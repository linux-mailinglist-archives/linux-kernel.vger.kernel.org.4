Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76C35BE961
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiITOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiITOvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:51:33 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE930551;
        Tue, 20 Sep 2022 07:51:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n83so3958487oif.11;
        Tue, 20 Sep 2022 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sK3l/7ireIyebTpzElTksVtVf2abmUnWhRtQl7kzKXU=;
        b=KlIkFV7VgcSZ7Kc5r43d0egsRp3NWHdEQHTVBY4ubNULGEQyRET8LzjsXeB3neFzO9
         t64aC1df6jnsJpAm2luaG4aPrM1+rzKjQX4EkaJUuCOPLA3ma9Q4hI8XpiTbw50RubuW
         P+3eGfZbIBzOn2jKU/GYvGZe14b7BzSofzabPsPJ/INGJs2PGeciL9F/FY6RALNJSoJR
         9naZ5JdveIoTrLaZOg3Oh3AtIhJr650G0ErDCqzhP37LjSAJ/CTva/+/cTGnkcRjgXfa
         h7mhwFUNl0yNB7HzroY67599Z69hKLg/UtcF5kHTxEXQR6qQut4hEKXR2nuyfVliJ1vq
         ztUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sK3l/7ireIyebTpzElTksVtVf2abmUnWhRtQl7kzKXU=;
        b=4xcY70fKmHcEyDPmihuYhAzjA8atYmziUHsiGkw6wvMEwo8JYGsZN5Bax3MSsHlmgV
         5FwPojB+BbLG8V0maoMKnL/NV450/DKnCrHPzb3UU82pY3XbbTozXWo4QNYUppwsDsdo
         Vs1CIpECGK4NhJMuRdVrJ+cwMmXjAQElO3/9K2MC11HC7RlN1bOf+NBO3C0eY+g7St0r
         //bDd2rDqsHFYC4iEccAnAXQIVC4sUJCl4dDVgYQmCaW1FnwHowK7ckqgm19o9gobRQX
         pEKvU3sOaQ1vATtZp6nwNAnUGtQz1GTHrMO5uow6gdk7kYDdyxlyY7q3IbSZfG2mjUWH
         OnrA==
X-Gm-Message-State: ACrzQf1DYnPkyQI2L7+NyfY61WawbDFK+Yp5uMHCO6jn9vb8kPsc/aDi
        X9vUdbkqWp7wbiolZ3GkDruVo4hM968=
X-Google-Smtp-Source: AMsMyM7UPUN/aISEbd2G4BbSn+IheDmIuz1gETVP9Ya6cE0aro+hmb7c0HaoJuDMM8QuTxB4WUeAbg==
X-Received: by 2002:a05:6808:a05:b0:350:d047:8878 with SMTP id n5-20020a0568080a0500b00350d0478878mr1759392oij.138.1663685491930;
        Tue, 20 Sep 2022 07:51:31 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id r7-20020a056870e98700b0012c8f0d1f85sm538oao.17.2022.09.20.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:51:31 -0700 (PDT)
Date:   Tue, 20 Sep 2022 07:49:21 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bitmap tree
Message-ID: <YynS8Z7BLy0/Vu1j@yury-laptop>
References: <20220920180839.79870ef4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920180839.79870ef4@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:08:39PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bitmap tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> ld: arch/powerpc/kernel/head_64.o: in function `generic_secondary_common_init':
> (.text+0x545e): undefined reference to `nr_cpu_ids'
> 
> Caused by commit
> 
>   c90c5bd9f2d6 ("lib/cpumask: add FORCE_NR_CPUS config option")
> 
> This build has CONFIG_FORCE_NR_CPUS set but the (assembler) code expects
> nr_cpu_ids to be a variable ...
> 
> I have reverted that commit for today.

Thanks for report, Stephen.

I did PPC build for bitmap-for-next, and it was OK on top of
v6-rc4. On today's -next I can reproduce the failure. It's weird
because the code in trouble was added at 2011 in 768d18ad6d5e6
("powerpc: Don't search for paca in freed memory").

Anyways, the fix is straightforward. I updated the bitmap-for-next
with it, and will send it for review shortly.
--

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index cf2c08902c05..7cb97881635e 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -400,7 +400,11 @@ generic_secondary_common_init:
 #else
        LOAD_REG_ADDR(r8, paca_ptrs)    /* Load paca_ptrs pointe         */
        ld      r8,0(r8)                /* Get base vaddr of array       */
+#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
+       LOAD_REG_IMMEDIATE(r7, NR_CPUS)
+#else
        LOAD_REG_ADDR(r7, nr_cpu_ids)   /* Load nr_cpu_ids address       */
+#endif
        lwz     r7,0(r7)                /* also the max paca allocated   */
        li      r5,0                    /* logical cpu id                */
 1:

