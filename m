Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17895EF3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiI2KmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiI2KmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:42:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599BF8FB1;
        Thu, 29 Sep 2022 03:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44025B823EE;
        Thu, 29 Sep 2022 10:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36E8C43470;
        Thu, 29 Sep 2022 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664448125;
        bh=UX6F5JaSgdh8DRHxfcjhKJy1RLXU9YsBvv2vTzpPVM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kzU1ZrtGrAK8NJ6HnoBJhey4y/GdilTJ1bsV9MuRpbl36FsmshescEe0hoSyI0F+R
         oq+EY612FKGXtBqjNoVVRUYQeI/0ENap7eumxNTueiPT5/Likzad62v0AKjUR0SF27
         QSNVRTxVA3p4P1WCS+YuSdITR2y9kZ4tdw1H7XMy7VwyQOBxAIlgEjkZ8zDTnNTRjv
         humjPH05Nhr+dGT6Cu1MGpptZj/STSOH9UcEDTlnlrgsqJQvE/j3pPgNLe4/2VituP
         M7DBCPRte7vBLq77c8Pte9cAwRJLYOiGfxdc8nRUN2vadVbGutN8QT4H5UV0pjUO7N
         NcwTrAj533U4w==
Received: by mail-ua1-f45.google.com with SMTP id p89so336254uap.12;
        Thu, 29 Sep 2022 03:42:05 -0700 (PDT)
X-Gm-Message-State: ACrzQf24tJ8u7XaIjGyqnum9JXiWExBS/GFEP8iyBL1Bw8kzo7KD0ic/
        dibzMITdmD5RBk28XKusDHbwRQmmswJ/ga28Yi8=
X-Google-Smtp-Source: AMsMyM7NSDSfn86kitr0d70mZwbZa7orK8H30PiB54tA6KPsmV8su+U4TUaBbU63hJXeVxIA8j8mNk8Wv/zFyE7iAX0=
X-Received: by 2002:a05:6130:c13:b0:39f:58bb:d51c with SMTP id
 cg19-20020a0561300c1300b0039f58bbd51cmr1248782uab.104.1664448124801; Thu, 29
 Sep 2022 03:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220929101445.32124-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220929101445.32124-1-lukas.bulwahn@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 29 Sep 2022 18:41:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6xe4o0upxcQTN=8BeDdcDipmoRp+QQNiakJJZ_eneTxg@mail.gmail.com>
Message-ID: <CAAhV-H6xe4o0upxcQTN=8BeDdcDipmoRp+QQNiakJJZ_eneTxg@mail.gmail.com>
Subject: Re: [PATCH] loongarch: update config files
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lukas,

Thank you for your patch, it is queued for loongarch-next, and may be
squashed to another patch with your S-o-B if you have no objections.

Huacai

On Thu, Sep 29, 2022 at 6:14 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Clean up config files by:
>   - removing configs that were deleted in the past
>   - removing configs not in tree and without recently pending patches
>   - adding new configs that are replacements for old configs in the file
>
> For some detailed information, see Link.
>
> Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/loongarch/configs/loongson3_defconfig | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index 3712552e18d3..2b4220778b66 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -108,14 +108,12 @@ CONFIG_NETFILTER=y
>  CONFIG_BRIDGE_NETFILTER=m
>  CONFIG_NETFILTER_NETLINK_LOG=m
>  CONFIG_NF_CONNTRACK=m
> -CONFIG_NF_LOG_NETDEV=m
>  CONFIG_NF_CONNTRACK_AMANDA=m
>  CONFIG_NF_CONNTRACK_FTP=m
>  CONFIG_NF_CONNTRACK_NETBIOS_NS=m
>  CONFIG_NF_CONNTRACK_TFTP=m
>  CONFIG_NF_CT_NETLINK=m
>  CONFIG_NF_TABLES=m
> -CONFIG_NFT_COUNTER=m
>  CONFIG_NFT_CONNLIMIT=m
>  CONFIG_NFT_LOG=m
>  CONFIG_NFT_LIMIT=m
> @@ -329,7 +327,6 @@ CONFIG_PARPORT_PC_FIFO=y
>  CONFIG_ZRAM=m
>  CONFIG_ZRAM_DEF_COMP_ZSTD=y
>  CONFIG_BLK_DEV_LOOP=y
> -CONFIG_BLK_DEV_CRYPTOLOOP=y
>  CONFIG_BLK_DEV_NBD=m
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_SIZE=8192
> @@ -505,7 +502,6 @@ CONFIG_ATH9K_HTC=m
>  CONFIG_IWLWIFI=m
>  CONFIG_IWLDVM=m
>  CONFIG_IWLMVM=m
> -CONFIG_IWLWIFI_BCAST_FILTERING=y
>  CONFIG_HOSTAP=m
>  CONFIG_MT7601U=m
>  CONFIG_RT2X00=m
> @@ -688,7 +684,6 @@ CONFIG_COMEDI_NI_PCIDIO=m
>  CONFIG_COMEDI_NI_PCIMIO=m
>  CONFIG_STAGING=y
>  CONFIG_R8188EU=m
> -# CONFIG_88EU_AP_MODE is not set
>  CONFIG_PM_DEVFREQ=y
>  CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
>  CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> @@ -772,14 +767,12 @@ CONFIG_CRYPTO_CRYPTD=m
>  CONFIG_CRYPTO_CHACHA20POLY1305=m
>  CONFIG_CRYPTO_HMAC=y
>  CONFIG_CRYPTO_VMAC=m
> -CONFIG_CRYPTO_TGR192=m
>  CONFIG_CRYPTO_WP512=m
>  CONFIG_CRYPTO_ANUBIS=m
>  CONFIG_CRYPTO_BLOWFISH=m
>  CONFIG_CRYPTO_CAST5=m
>  CONFIG_CRYPTO_CAST6=m
>  CONFIG_CRYPTO_KHAZAD=m
> -CONFIG_CRYPTO_SALSA20=m
>  CONFIG_CRYPTO_SEED=m
>  CONFIG_CRYPTO_SERPENT=m
>  CONFIG_CRYPTO_TEA=m
> --
> 2.17.1
>
>
