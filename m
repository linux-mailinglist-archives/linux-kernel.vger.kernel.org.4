Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB55F1BFE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJALbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJALbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 07:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7E8109752
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 04:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A5860A1E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 11:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03A5C433D6;
        Sat,  1 Oct 2022 11:31:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TVPzHAvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664623895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ous3IPgazyAAsxjCERwjxWB+1oqHh8n8dAxLAs0texQ=;
        b=TVPzHAvSNcNFPWNcCf+LAIvrpVtlmNCoNhMM62zWVTcPBWKpjx/IOOugq+Z3vJ3tFsSjm3
        jdH9lq1rvg0nTGphunGHvSaDZl5EE8UJsyxZ91RgRhDiiVt7zc/fDQ2xmT2fQv1kZsKcOf
        sAVreHZN2bfAY9T5N+559BrcdfO6/Pc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a2fac5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 1 Oct 2022 11:31:34 +0000 (UTC)
Date:   Sat, 1 Oct 2022 13:31:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     William Zijl <postmaster@gusted.xyz>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Improve comment of get_random_bytes function
Message-ID: <YzglFDjXE2oN6QzH@zx2c4.com>
References: <20221001001831.46355-1-postmaster@gusted.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221001001831.46355-1-postmaster@gusted.xyz>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 02:18:31AM +0200, William Zijl wrote:
> The old comment of this function had a double whitespace and contained
> grammatical errors, such as: `the randomness by this function`, `at
> least once at any point prior`. This patch replaces those sentenced with
> `the randomness of this function`, `at any point prior to this`
> respectively.

"at any point prior" seems fine to me.

"the randomness by this function" is wrong, but the correction for it
should be "the randomness returned by this function".

Feel free to submit a v2.

Jason
