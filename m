Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE074B33B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjGGOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:45:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F01FD7;
        Fri,  7 Jul 2023 07:45:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so21920605e9.0;
        Fri, 07 Jul 2023 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688741111; x=1691333111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swjcoqb53SUMB+DeeB9DvOSbSUZxcLJDlvlKSPHfeEA=;
        b=EcoaLuTvcXuXAayOAavdbHzX2pVNH/G03FXOIGUydIXmJQFbXUuROQO3utdu1UBlkJ
         i5T79FLwHEn+FbOtR6rojeXwzJHcN3/CK68Bvad105Kftqm7T8WDy8sNuGjTd6hfayxv
         uDJpcivLdOgHm8ZSTeXafh5kjH1vdz2QyHtzSHJLV/XWYvaOhiPNnuQ5tzKTLvDjncvS
         P5y3XVHqP3pY7yN0RNh/vAFc8a4l591jAPxYmEal9MXxlDk2fBMq4NgR91GWWwHGck3P
         eI4yxP0AJ/MzpKAkgF7Zh61e2cd2+bok+S1BGzDVt9sha/nd0oeYoFxqrjfurOOtpj/L
         wcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688741111; x=1691333111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swjcoqb53SUMB+DeeB9DvOSbSUZxcLJDlvlKSPHfeEA=;
        b=ZdK8Lhr3310rRREACJW0n9VFjuMNFySJ4GW8x3tNpvW/nDtXM4uGn2Gbc7R+XSCMPc
         fuiGSfbP461xgjhDZVgNV0zfdODmf9MV5t9F9T1soQUyGgc0b94as5twKb2aeizNuoch
         slLHvmSGFT08wZhQUAagk1JB/21s7fHZkRmezLO9AmlE/egbCulrYgoUfRpKVDiJYBdo
         6wmzccvr3q6QctGyYf4kAcHtJsuj/+wSZsOCRn/WMA1KuAYv7blXIlY3kDe3dS2QNxCv
         dyPv2lAOcxGrNF8e/nQfxT+ZwM8n8aeY7bmRAfIETFK3v2iH+VbU1WXiwZ7AhUmaQPXq
         hw9Q==
X-Gm-Message-State: ABy/qLZw8fqoMJoUL/bzCcqNxV0x14p5rPXRdU3v1RECogeeTy0J8Ogm
        2lOwG1HyRV2f6y8BnauERCk=
X-Google-Smtp-Source: APBJJlETLQxFyjxg4eixOg08xV5sR1+LQzSdY3LDqoWIxyh7KGoxRT87Xs2dLzQbJvZmgQ+CxxmFAg==
X-Received: by 2002:a1c:ed14:0:b0:3fb:4149:b816 with SMTP id l20-20020a1ced14000000b003fb4149b816mr4242668wmh.8.1688741111164;
        Fri, 07 Jul 2023 07:45:11 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id l15-20020a1c790f000000b003fc00789d5bsm1434084wme.1.2023.07.07.07.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 07:45:09 -0700 (PDT)
Message-ID: <0364cab8-25b0-5850-9791-4b0451d2adbe@gmail.com>
Date:   Fri, 7 Jul 2023 16:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/18] soc: mediatek: Move power-domain drivers to the
 genpd dir
Content-Language: en-US, ca-ES, es-ES
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-8-ulf.hansson@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230707140434.723349-8-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2023 16:04, Ulf Hansson wrote:
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: <linux-mediatek@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

We are missing a complete commit message here, is that intentional?
It would also need a patch against the maintainers file.

Apart from that patch looks good.

Regards,
Matthias

> ---
>   drivers/genpd/Makefile                              | 1 +
>   drivers/genpd/mediatek/Makefile                     | 3 +++
>   drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h | 0
>   drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h | 0
>   drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h | 0
>   drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h | 0
>   drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h | 0
>   drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h | 0
>   drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h | 0
>   drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h | 0
>   drivers/{soc => genpd}/mediatek/mtk-pm-domains.c    | 0
>   drivers/{soc => genpd}/mediatek/mtk-pm-domains.h    | 0
>   drivers/{soc => genpd}/mediatek/mtk-scpsys.c        | 0
>   drivers/soc/mediatek/Makefile                       | 2 --
>   14 files changed, 4 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/genpd/mediatek/Makefile
>   rename drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.c (100%)
>   rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.h (100%)
>   rename drivers/{soc => genpd}/mediatek/mtk-scpsys.c (100%)
> 
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> index 6b9e9fe907f3..1a0a56925756 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -3,3 +3,4 @@ obj-y					+= actions/
>   obj-y					+= amlogic/
>   obj-y					+= apple/
>   obj-y					+= bcm/
> +obj-y					+= mediatek/
> diff --git a/drivers/genpd/mediatek/Makefile b/drivers/genpd/mediatek/Makefile
> new file mode 100644
> index 000000000000..8cde09e654b3
> --- /dev/null
> +++ b/drivers/genpd/mediatek/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_MTK_SCPSYS)		+= mtk-scpsys.o
> +obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) 	+= mtk-pm-domains.o
> diff --git a/drivers/soc/mediatek/mt6795-pm-domains.h b/drivers/genpd/mediatek/mt6795-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mt6795-pm-domains.h
> rename to drivers/genpd/mediatek/mt6795-pm-domains.h
> diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/genpd/mediatek/mt8167-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mt8167-pm-domains.h
> rename to drivers/genpd/mediatek/mt8167-pm-domains.h
> diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/genpd/mediatek/mt8173-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mt8173-pm-domains.h
> rename to drivers/genpd/mediatek/mt8173-pm-domains.h
> diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/genpd/mediatek/mt8183-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mt8183-pm-domains.h
> rename to drivers/genpd/mediatek/mt8183-pm-domains.h
> diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/genpd/mediatek/mt8186-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mt8186-pm-domains.h
> rename to drivers/genpd/mediatek/mt8186-pm-domains.h
> diff --git a/drivers/soc/mediatek/mt8188-pm-domains.h b/drivers/genpd/mediatek/mt8188-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mt8188-pm-domains.h
> rename to drivers/genpd/mediatek/mt8188-pm-domains.h
> diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/genpd/mediatek/mt8192-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mt8192-pm-domains.h
> rename to drivers/genpd/mediatek/mt8192-pm-domains.h
> diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/genpd/mediatek/mt8195-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mt8195-pm-domains.h
> rename to drivers/genpd/mediatek/mt8195-pm-domains.h
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/genpd/mediatek/mtk-pm-domains.c
> similarity index 100%
> rename from drivers/soc/mediatek/mtk-pm-domains.c
> rename to drivers/genpd/mediatek/mtk-pm-domains.c
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/genpd/mediatek/mtk-pm-domains.h
> similarity index 100%
> rename from drivers/soc/mediatek/mtk-pm-domains.h
> rename to drivers/genpd/mediatek/mtk-pm-domains.h
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/genpd/mediatek/mtk-scpsys.c
> similarity index 100%
> rename from drivers/soc/mediatek/mtk-scpsys.c
> rename to drivers/genpd/mediatek/mtk-scpsys.c
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 8c0ddacbcde8..9d3ce7878c5c 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -4,8 +4,6 @@ obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>   obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
> -obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> -obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
>   obj-$(CONFIG_MTK_SVS) += mtk-svs.o
