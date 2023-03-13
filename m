Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CD86B7F98
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCMRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCMRh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:37:28 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24430D0;
        Mon, 13 Mar 2023 10:37:27 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id cu4so4959751qvb.3;
        Mon, 13 Mar 2023 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678729046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VBxk32WXQYbcs9sGRGUzUJUIa6Pw7Q1PNFTVgQx2lw=;
        b=YSt8hBr5Y80mZ97RShggVMcx3Oty80UQ+8EwxZ1LG05uDtr17VD4rsFf+LD79QciO9
         bQVl1h4Rk0ch5bbGPn3tjYCbhJYquiVlgA0L36trWyYfQ8VFl1XkaMxPXiZJihKF8pfq
         rcVtG0S+K+PE+/MFJkUX4uUDQlbMiz25uU2TRvwQbI+OGw3mVjWLCtzQ2tX/S9qIm6VO
         MVzIBLRIjQv8n9vXj0E0D1NSoKvBewCE/quuJEvCdQsXhXLxilmrQI7KauzfLo2/9pb5
         8U4Gctb9bF6jpMvo5BJ5+WQtuo5WbtFWoUlmNOABkQYzQ73ooYDtjwVymCcm1+NmUf9R
         /uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678729046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VBxk32WXQYbcs9sGRGUzUJUIa6Pw7Q1PNFTVgQx2lw=;
        b=4GVZmnIrRQUcYD2CKmCKBhGLhrN4oeUbsOVO3YZpuPjzWJg6Fz1LPd5yTG1bUvj2B1
         iX36T8dSaruVykp4it35n9gaoiMsYoVHRsRpCuKP9X6uW+A+MqKDklnkaA5WdcB1SKDP
         OIGXUxyS9xKUZdxJFqOJ0YRYAl/eAtyH83vFOFnC+g+Yo/0W4qW/saXuIFO8lu7TpuHr
         PW8ygzxRqyK1UbOGayhiflXglOchqo033sY98vj5R0GZJ8PBvip3ubdIFJH8QpkyyILB
         Ia3cCCtu5d5n20vETWc8ylZ+MzWnnb5M6DbSrguDs0drxGoQ67DNDRKllfOZh7WDGMx/
         Fj0g==
X-Gm-Message-State: AO0yUKVenWt+p0oklj1yaBrC++lwFF+w48//T2cE3G0nfPGhlPMIWLe/
        cILSqJeVHtLUpPk4lyuJrmQ=
X-Google-Smtp-Source: AK7set8PjuyWfhXfdCmvXDXX6P+PAPf4fHuMYR+90AMOGKswRTmL5cvDnRyCaSXjycGFin7DeH5qlQ==
X-Received: by 2002:a05:6214:4014:b0:5aa:fd43:1fcd with SMTP id kd20-20020a056214401400b005aafd431fcdmr1824542qvb.42.1678729046712;
        Mon, 13 Mar 2023 10:37:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c137-20020a379a8f000000b0073baa5ec0besm82499qke.115.2023.03.13.10.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 10:37:25 -0700 (PDT)
Message-ID: <e3cff853-8d5d-acdf-8e6a-3322c4de2023@gmail.com>
Date:   Mon, 13 Mar 2023 10:37:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mips: bmips: BCM6358: disable arch_sync_dma_for_cpu_all()
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310121306.4632-1-noltari@gmail.com>
 <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
 <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
 <5b4d3eef-ff80-29e8-9be0-d487aee5e4e2@broadcom.com>
 <a88fc41b-69d3-b042-fa91-e403d1263742@gmail.com>
 <CAKR-sGfL5_VU9uxJHGyZ-bj2P_7R6+OOfWs6Yf-ihcCF8bD2MA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAKR-sGfL5_VU9uxJHGyZ-bj2P_7R6+OOfWs6Yf-ihcCF8bD2MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 11:50, Álvaro Fernández Rojas wrote:
> Hi Florian,
> 
> I tried what you suggested but it stil panics on EHCI:
> 
> [    0.000000] Linux version 5.15.98 (noltari@atlantis)
> (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
> 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
> [    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() = 0xe30e1006
> [    0.000000] bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG = 0x3c1b8041
> [    0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
> 
> It looks like bit 29 is set so RAC should be present.
> And RAC_I seems to be set, but not RAC_D...
> 
> BTW, this is what I added to bmips_cpu_setup:
> 
> case CPU_BMIPS4350:
> cfg = read_c0_brcm_config_0();
> pr_info("bmips_cpu_setup: read_c0_brcm_config_0() = 0x%x\n", cfg);
> 
> cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
> pr_info("bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG = 0x%x\n", cfg);
> __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
> __raw_readl(cbr + BMIPS_RAC_CONFIG);
> break;

Thanks for running those experiments, I cannot explain what you are 
seeing, so there must be some sort of erratum applicable to the 
BMIPS4380 revision used on the 6358 somehow...

If you can make the suggested change to use negative logic in order to 
disable the RAC flushing, that would work for me, also maybe add a 
Fixes: tag so it gets backported to stable trees?

Thanks!
-- 
Florian

