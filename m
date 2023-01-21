Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94EB67640E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjAUFq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjAUFq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:46:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B16ACAF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:46:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD0A7B82A52
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 05:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E24C433EF;
        Sat, 21 Jan 2023 05:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674280012;
        bh=8SxDwvezamNgdCvUXl9WhV9580K6miB6Zm1RyeGT6PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAK0J7coIoDluJ2A5Jm66dZUoSbq6jKiU0ykC2xY7ovP7DEfTJbKnn4D9duF50W4n
         p2zYljlus3Uh0Kjaf9ueWDOgKRrvvjnV4KvCYfpUwrgbP/DnaO/4JGBhB23jD5kQp3
         48lmMJ+JtuoRNhhzoTco/WIgs2qT7pnU0Gr661maMMrTRCTRQDQMzkxWxv+bq9GBqh
         4gz14G6fT6bUe/40rnNzsu/GfTeei0Qh3aKzYx8TGPKxzBxW6agmm1i8ErCHvr0vHN
         kpw9PMQ8D4v/ls80RY2dGIGyTGRTz1sXsrrMCHyJXm2AnuOhZHYoUlshLTH9VCq5Fm
         LejQtZIDNL5PQ==
Date:   Fri, 20 Jan 2023 21:46:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2 1/5] f2fs: fix unnecessary newlines in
 super.c
Message-ID: <Y8t8SZ9VGm5fjYAn@sol.localdomain>
References: <20230121051204.81251-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121051204.81251-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 01:12:00PM +0800, Yangtao Li via Linux-f2fs-devel wrote:
> commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
> warning") increased the limit to 100 columns. Let's remove some
> unnecessary newlines.

80 is still the *preferred* limit.  See Documentation/process/coding-style.rst:

	The preferred limit on the length of a single line is 80 columns.                
											 
	Statements longer than 80 columns should be broken into sensible chunks,
	unless exceeding 80 columns significantly increases readability and does
	not hide information.                                                            

Also, to avoid churn, patches that just change whitespace generally aren't
accepted, unless they are changing the relevant code anyway.

- Eric
