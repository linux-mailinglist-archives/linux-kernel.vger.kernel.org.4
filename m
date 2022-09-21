Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AEB5BF401
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiIUCx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIUCwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:52:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671B7DF52;
        Tue, 20 Sep 2022 19:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69154B82E0B;
        Wed, 21 Sep 2022 02:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B9EC43470;
        Wed, 21 Sep 2022 02:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663728768;
        bh=RhR8GLW+bPD7kNiLxNd2NSfrl+/O4Gc3C+CqOGphGe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/VEg7DyTP1VVx7Z8n0SiPDexYG0hCuDf3LV3vbKAeu9Z/IuKDX2xxP2BsW7yxzit
         NBtFWPRfxO5oI6ETLwJP8VlkZmqzuOmLLwUjI/aLykhcTzbkDXClIutCpHT3Ru6FIH
         swlx0ohfXTbyj4AqvsTMA1JfhP3+mW6P3ndcZpFieWk8CTnbstjMx2q2yHkHCFbpOU
         RUpCA1rWMFZmqYrrMa1ht/kCItWuSNSJqr2lKdltshybvP9LRjP4P7mqmL8bwNDec8
         bfWEHQvunElibTf3PBnWshdDAg3TyLSbOzwpOcF41duGvPwDEdCC6jNzUTv5zO3PzY
         pt6Hw66QW5yrg==
Date:   Tue, 20 Sep 2022 19:52:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Rob Landley <rob@landley.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: fs/xfs/Kconfig points at oss.sgi.com which is toast.
Message-ID: <Yyp8f9hUbGpS1R9Q@magnolia>
References: <4d69c27b-d0a0-997e-6609-eccd0939d156@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d69c27b-d0a0-997e-6609-eccd0939d156@landley.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 04:09:55PM -0500, Rob Landley wrote:
> Is there a replacement URL for the xfs documentation?

None that I know of.  Some of it went to xfs.org but then we lost
control of it.  I tried to push other pieces went to xfs.wiki.kernel.org
but then we lost control of that too.  Some of it is slowly migrating to
the kernel source code, but most of the old stuff is probably not
movable because people are afraid of mixing GPL and CC licensed data in
the same git repo/git server.

(And please always cc linux-xfs)

--D

> Rob
