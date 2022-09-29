Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA215EF3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiI2KoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2KoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:44:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277E4147A12;
        Thu, 29 Sep 2022 03:44:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 135so1031478ybl.9;
        Thu, 29 Sep 2022 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eVyC2om8iRoc+83iT4ksvNh32e+purWPgzjisBjHf1E=;
        b=XUrDyfJfsz4U7znQLZEvfXt8cEYHbg3TbLkWorTXz3GRClA4xqJZExeqhFyfcLZMD0
         qlXGoGmqxoS37LqldIfgGzotYC8plIDksSsKU6wap32qxE6lw9uCe896QbkWy39myt9e
         RT9mCaJQMcrLxJVNGYldQXrkxQ5RF9Pzoeme3/LFRzTAlu5wiifHa6y3WyuILT7IjNEt
         ALcoMQKpbCNC4NTpzJ9IF4+1LXpQb6e/HzUHQKf3cYbOfViphd81T6LsI3i/kfgRlmeZ
         lRWiTLPyYQcqgqXSY2WGpYMDgpQDC+hM0flQn7diMbrACijdU9o2cL65EahRRoiQeaL/
         qo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eVyC2om8iRoc+83iT4ksvNh32e+purWPgzjisBjHf1E=;
        b=rhREJXnE7e8d+Bdp6yrV5UnXXuLNljR7aZdBKULw00xLARJwKoAmeisYNYuaCCGiWH
         7bswx+2QOBf9cTQ3Y+MHuqCkrKo7EfSTBN6s2JUb5jBZvT2W7IVq8z5AnIyF93gesgsU
         s/tZ1XPNE4ZdK3CvmzD7aYEIXyYaPlb3/D3jegLH1Qsf6MinHIQA6jm12BlAS0Xx7f8x
         NFMaLF32XzNQeP77lil+9g0e88hfp50QByjn7oA4dRTm9szaABCmW2E0Q5LWao8SnZ4N
         rMFTRgiA7Ul3Ek/TaqSJm/UvNcNKVJIYn14q0F605iLqZBWlHI5kZxgcxFrDNhc6ai9e
         GfBw==
X-Gm-Message-State: ACrzQf3mIEmyr+rWMTbx+c6fnjl1I+mt9bVnQF9bKBpnbDtr01b2nxzu
        paGBzLUNOV/0fVHcBSdN+je9Q5rP7Ih1hdWoaXtEQRzSYQ4=
X-Google-Smtp-Source: AMsMyM6PYClyn52CoVXC0dXvBu4NXduY1WxQbcZaJsVZl+aqoBY12GbZ7shAI5oyE6urDGJcnZNGSgY17CFRG7+Z01E=
X-Received: by 2002:a25:37d8:0:b0:6bc:99af:2991 with SMTP id
 e207-20020a2537d8000000b006bc99af2991mr2316477yba.389.1664448259243; Thu, 29
 Sep 2022 03:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220929101445.32124-1-lukas.bulwahn@gmail.com> <CAAhV-H6xe4o0upxcQTN=8BeDdcDipmoRp+QQNiakJJZ_eneTxg@mail.gmail.com>
In-Reply-To: <CAAhV-H6xe4o0upxcQTN=8BeDdcDipmoRp+QQNiakJJZ_eneTxg@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 29 Sep 2022 12:44:08 +0200
Message-ID: <CAKXUXMwhF4V1=oNq1XaTmQpk_Tt7ZXfZEmK_r_GT6wz7=vVx2g@mail.gmail.com>
Subject: Re: [PATCH] loongarch: update config files
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:42 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Lukas,
>
> Thank you for your patch, it is queued for loongarch-next, and may be
> squashed to another patch with your S-o-B if you have no objections.
>
> Huacai
>

Feel free to squash as you see fit. I cannot recall sending something
specific for loongarch-next, though.

Lukas

> On Thu, Sep 29, 2022 at 6:14 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Clean up config files by:
> >   - removing configs that were deleted in the past
> >   - removing configs not in tree and without recently pending patches
> >   - adding new configs that are replacements for old configs in the file
> >
> > For some detailed information, see Link.
> >
> > Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  arch/loongarch/configs/loongson3_defconfig | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> > index 3712552e18d3..2b4220778b66 100644
> > --- a/arch/loongarch/configs/loongson3_defconfig
> > +++ b/arch/loongarch/configs/loongson3_defconfig
> > @@ -108,14 +108,12 @@ CONFIG_NETFILTER=y
> >  CONFIG_BRIDGE_NETFILTER=m
> >  CONFIG_NETFILTER_NETLINK_LOG=m
> >  CONFIG_NF_CONNTRACK=m
> > -CONFIG_NF_LOG_NETDEV=m
> >  CONFIG_NF_CONNTRACK_AMANDA=m
> >  CONFIG_NF_CONNTRACK_FTP=m
> >  CONFIG_NF_CONNTRACK_NETBIOS_NS=m
> >  CONFIG_NF_CONNTRACK_TFTP=m
> >  CONFIG_NF_CT_NETLINK=m
> >  CONFIG_NF_TABLES=m
> > -CONFIG_NFT_COUNTER=m
> >  CONFIG_NFT_CONNLIMIT=m
> >  CONFIG_NFT_LOG=m
> >  CONFIG_NFT_LIMIT=m
> > @@ -329,7 +327,6 @@ CONFIG_PARPORT_PC_FIFO=y
> >  CONFIG_ZRAM=m
> >  CONFIG_ZRAM_DEF_COMP_ZSTD=y
> >  CONFIG_BLK_DEV_LOOP=y
> > -CONFIG_BLK_DEV_CRYPTOLOOP=y
> >  CONFIG_BLK_DEV_NBD=m
> >  CONFIG_BLK_DEV_RAM=y
> >  CONFIG_BLK_DEV_RAM_SIZE=8192
> > @@ -505,7 +502,6 @@ CONFIG_ATH9K_HTC=m
> >  CONFIG_IWLWIFI=m
> >  CONFIG_IWLDVM=m
> >  CONFIG_IWLMVM=m
> > -CONFIG_IWLWIFI_BCAST_FILTERING=y
> >  CONFIG_HOSTAP=m
> >  CONFIG_MT7601U=m
> >  CONFIG_RT2X00=m
> > @@ -688,7 +684,6 @@ CONFIG_COMEDI_NI_PCIDIO=m
> >  CONFIG_COMEDI_NI_PCIMIO=m
> >  CONFIG_STAGING=y
> >  CONFIG_R8188EU=m
> > -# CONFIG_88EU_AP_MODE is not set
> >  CONFIG_PM_DEVFREQ=y
> >  CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> >  CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> > @@ -772,14 +767,12 @@ CONFIG_CRYPTO_CRYPTD=m
> >  CONFIG_CRYPTO_CHACHA20POLY1305=m
> >  CONFIG_CRYPTO_HMAC=y
> >  CONFIG_CRYPTO_VMAC=m
> > -CONFIG_CRYPTO_TGR192=m
> >  CONFIG_CRYPTO_WP512=m
> >  CONFIG_CRYPTO_ANUBIS=m
> >  CONFIG_CRYPTO_BLOWFISH=m
> >  CONFIG_CRYPTO_CAST5=m
> >  CONFIG_CRYPTO_CAST6=m
> >  CONFIG_CRYPTO_KHAZAD=m
> > -CONFIG_CRYPTO_SALSA20=m
> >  CONFIG_CRYPTO_SEED=m
> >  CONFIG_CRYPTO_SERPENT=m
> >  CONFIG_CRYPTO_TEA=m
> > --
> > 2.17.1
> >
> >
