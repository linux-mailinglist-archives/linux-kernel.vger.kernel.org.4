Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE262E856
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbiKQWXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbiKQWXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:23:33 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6198D490
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:21:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g62so3115872pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSwJV2KYxBElCKXN+JgGSpLARwCfSn0ae92xplQAFic=;
        b=TwEHZg8sV4C4VuUBGudICbSbcvrp8OQsn0eQKHKdMKujOovO5I+rxSVCirl/IR5r7S
         7uWpBOwAOUgJRYgGlPkl+JBNzE7LvNJgU9wNg7Lal5ktuI8OAKWTl7I3yfRXNdIl4NvF
         EZVjOTol9GfLD5u3GgNM46VUoBtQfFWCWkJDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSwJV2KYxBElCKXN+JgGSpLARwCfSn0ae92xplQAFic=;
        b=OFpxB9+jT4LHDOcZqkeIcw4P1ids5cgXFDJGGx58SzloN1b/k+JC0t9AkSDobo60pJ
         asARta9SVdOYsBXK8C9+g8aBUiB0yVXCw0cq02UyzMKVh/v01dNz8Q7FLT/ZlHCzmTfm
         R0GjMW4xiK585tEZmda6EVvJyHFDcERbcNGzhGabOBR5Ag2qP78pMn+xoI9U/vRVI/d5
         J2DpccaYw3akIa8Ne8HoK85I6ycRRElNdlEx4Qeb7nJ8Tk3tQzEkRwIOOavLhqU0wHjM
         ZIIu2k6jzrpKNUVOaZNpUV6lHePuHgtQMMk7n2M7GYX4HIMA+ntFIJuryvusiaWcDvfP
         n/hg==
X-Gm-Message-State: ANoB5plic1ZpwDoOsrY61i+wnjZfjZolKwOWFw6bnQD5k+9q1XNK9xnW
        /eI5f0skw8VDPrTmN3BeaWe37g==
X-Google-Smtp-Source: AA0mqf6nbW+rxyP+i6B7Axg0KIP23raSHJTeKi8rSP5n/ZD0poWcqUnhn4XDJpFixIo7gBZXc1VuZg==
X-Received: by 2002:a63:887:0:b0:460:633b:5702 with SMTP id 129-20020a630887000000b00460633b5702mr4093864pgi.9.1668723706884;
        Thu, 17 Nov 2022 14:21:46 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s12-20020a63f04c000000b0047681fa88d1sm1554188pgj.53.2022.11.17.14.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:21:46 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 17 Nov 2022 14:21:46 -0800
To:     Ananda <a.badmaev@clicknet.pro>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Ananda Badmaev <a.badmaev@clicknet.pro>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: zblock_reclaim_block(): Control flow issues
Message-ID: <202211171421.914F0F3719@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221117 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 16 16:19:12 2022 -0800
    9097e28c25c8 ("mm: add zblock - new allocator for use via zpool API")

Coverity reported the following:

*** CID 1527349:  Control flow issues  (NO_EFFECT)
mm/zblock.c:412 in zblock_reclaim_block()
406     	unsigned long handle, block_type, slot;
407     	int ret, i, reclaimed;
408
409     	/* start with list storing blocks with the worst compression and try
410     	 * to evict the first added (oldest) block in this list
411     	 */
vvv     CID 1527349:  Control flow issues  (NO_EFFECT)
vvv     This greater-than-or-equal-to-zero comparison of an unsigned value is always true. "block_type >= 0UL".
412     	for (block_type = ARRAY_SIZE(block_desc) - 1; block_type >= 0; --block_type) {
413     		list = &(pool->block_lists[block_type]);
414     		spin_lock(&list->lock);
415
416     		/* find the oldest block in list */
417     		block = list_last_entry(&list->head, struct zblock_block, block_node);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527349 ("Control flow issues")
Fixes: 9097e28c25c8 ("mm: add zblock - new allocator for use via zpool API")

Thanks for your attention!

-- 
Coverity-bot
