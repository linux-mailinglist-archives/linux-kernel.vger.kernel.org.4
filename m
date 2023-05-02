Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060FA6F4498
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjEBNDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjEBNCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:02:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978DB526E
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:02:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so1621341f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683032552; x=1685624552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yI7es7d2+0DIqALlHq+/W7rD8zTxU/feFIO70XrkNew=;
        b=WQL0w2zNAPoWWf1Ytr5s/LPoPDCGZRh1yXeq9jgG5ixrkDjypRR0XEgQd5p1tu6QRc
         ts34Q+Vs+g0dOesHjXjf5zSJ2gyPZu88qGFHaiDdq0dybcZO6jXeugQ+jeXpw7XHmb2K
         FsNyomyMfnY0q4qQwZq3SKxGU05wFEUaqdI9+vb09QGo49x/65sacDTVKdWgpv4yBxwX
         M6Dvk2fIkeXYoi7jwPVHCJ+VvJXZSyhhxueenxJCIcgUIL7QmRWQV96ASU7lzDEqkTA1
         K9EtrJD8eAmhtE9K91JqYHBkOhnkPasveZNjz2OYa2GZ8i92tuIeaCKvF5YFlqwlBdyC
         dP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683032552; x=1685624552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI7es7d2+0DIqALlHq+/W7rD8zTxU/feFIO70XrkNew=;
        b=HSbXJRBDVM0XfQF43I4B7A5jWW69TCtZ0gv+QQljPIiAYaNugp6UwAbE6F6cOYTxuF
         3nLvlEHq6Vi4FG6nAaqFihQToKO3cts/1b5bA1ZBzFU/+twz4zPSSRR8FyF7/zND/SiK
         2To9bfqActK8wjrNGMbctVod79KxIgDpUyZ6z8ZGjOfr/U/pbRKZNzCy/E4sP4kKCvVc
         5lRy2Gdhjy6XESLoDmUQRFxlrSEFSpxboKEUijhYQptSFE5NSmO2gKn+dW+e4eFpqado
         5X+6YDMAIS0lho/Omdukb3RYLYRQlK1sLm++lgUxQDoUDFRB7ndOrQCX8M04HOaY850Y
         UlDg==
X-Gm-Message-State: AC+VfDxA0PBZTlVqBqCEbx/l67Mfxzz4zK7Eg4L2FQ3K8pYBorAtbNhS
        UkYZbblRDRrftLkvDvtBu55zSA==
X-Google-Smtp-Source: ACHHUZ4N347G7AswAWEOp4Mu/8D6KX6stNUpFZBYx1KITgol32+f2NcGbP3VUDX9zsLA3ut4wuV0lg==
X-Received: by 2002:a05:6000:1:b0:306:26d7:3805 with SMTP id h1-20020a056000000100b0030626d73805mr6604084wrx.63.1683032552086;
        Tue, 02 May 2023 06:02:32 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d5043000000b002c70ce264bfsm30894846wrt.76.2023.05.02.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 06:02:30 -0700 (PDT)
Date:   Tue, 2 May 2023 16:02:11 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     oe-kbuild@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/gpu/drm/udl/udl_main.c:259 udl_get_urb_locked() warn:
 can 'unode' even be NULL?
Message-ID: <5ca02484-8a71-4b8c-b679-11ec11b7eef4@kili.mountain>
References: <e35cd818-d2f7-4d5e-abf8-b3448ca224aa@kili.mountain>
 <542af717-b889-3eea-a819-1d2a2cf4729d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542af717-b889-3eea-a819-1d2a2cf4729d@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 01:38:11PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.05.23 um 13:19 schrieb Dan Carpenter:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   2caeeb9d4a1bccd923b7918427f9e9ef7151ddd8
> > commit: c5c354a3a4728045e1342166394c615d75d45377 drm/udl: Fix inconsistent urbs.count value during udl_free_urb_list()
> > config: parisc-randconfig-m031-20230421 (https://download.01.org/0day-ci/archive/20230423/202304230801.ncoG1XDr-lkp@intel.com/config)
> > compiler: hppa-linux-gcc (GCC) 12.1.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Link: https://lore.kernel.org/r/202304230801.ncoG1XDr-lkp@intel.com/
> > 
> > smatch warnings:
> > drivers/gpu/drm/udl/udl_main.c:259 udl_get_urb_locked() warn: can 'unode' even be NULL?
> 
> It can't. Send a fix, if you like. OTOH it's not much of a problem either.
> 

Sure, I sent a patch.  This one is harmless, but we recently had a few
bugs that should have generated bogus NULL check warnings.

CVE-2023-1073: b12fece4c648 ("HID: check empty report_list in hid_validate_values()")
CVE-2023-1075: ffe2a2256244 ("net/tls: tls_is_tx_ready() checked list_entry")
CVE-2023-1077: 7c4a5b89a0b5 ("sched/rt: pick_next_rt_entity(): check list_entry")
CVE-2023-1078: f753a68980cf ("rds: rds_rm_zerocopy_callback() use list_first_entry()")

Although CVE-2023-1073 and CVE-2023-1077 are hard to warn about without
generating too many false positives.

regards,
dan carpenter

