Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68DD67403C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjASRpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjASRpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:45:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39535B59D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:45:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w14so3826639edi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCueC+kG6+G8iq3m73OLmpsWjfxU0yEo1uLN/H9w3xc=;
        b=Po8NK4Esq7bg3ZGf7dFDhO1x/2AzxLym3eT3SdebR/lqBPt/6rm1dyOGbOtbtCZQ9C
         nH78jIH/1/EQhKEGA7YJ4lqU5xgPvbu36kxO+51OHKbd0y9UR2dgIACedEWIUpfAOGjm
         uGNJLyvocpn8ut5V/TygukFbgXCzPWvxjNkvrgZ+/7UZWaPeL6ycyqUQCqyh1Mx0anwh
         2fG6M84W0RKLMMba51agXis+J8Ul7+BIkqZnv2RWd/p6dzA+bj3h3z2MV/WJTqPo6NXo
         6uK7nc9/AL25wIdAWFisQJXGwi6+EOWd7z5mEW12XCHMR7kk6Zkp/wUzJ7SYQTEnHxxp
         JdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCueC+kG6+G8iq3m73OLmpsWjfxU0yEo1uLN/H9w3xc=;
        b=fYi2v8euDZwRydSBRwtrUV6mWlAIH7rFjgftxokI4DJCEaVMxbjtzsXhDrrSHHriHJ
         8Tw831WPR4qfAnUWRMN68F7/5lY/PvKhyww+FBmKjFnhhV0GzsNuO1W7xH6K/zpo11ff
         jDhQgttyOM936/RCc/ybtr/+Po9Qs/gUXeRgFkAwON/Y4VnZ3KdUTH2oFHJYXxSrEAh0
         aVa+yjinVyhi5kiwLi8iJ7DCsG4wJOfcLonS3kkiopal7WTx7W/dC1AQVFVsYNnAHDya
         G/+uXV+HzguqSM78hLD3qpdELEF2Mu2qnprgt622+l1OR3nH6ttlPhYN226oQZ4RpZOB
         IgXA==
X-Gm-Message-State: AFqh2kpuQzkQdi5IbKCmUyAtXWqFdFsjYjJ97ZCgAV6g4HWEjlbFXc83
        ZFe4S9n68xF65eG0+YA2UCE=
X-Google-Smtp-Source: AMrXdXvIE5RyU6AO9ZuhqpGaXSnAy81/ruty02LgQqV5TocZY4F1CDUxuJiu1LLCH/rK4JK/d2wUtA==
X-Received: by 2002:a05:6402:10d4:b0:48f:fcc9:665e with SMTP id p20-20020a05640210d400b0048ffcc9665emr21369738edu.0.1674150326317;
        Thu, 19 Jan 2023 09:45:26 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k26-20020a508ada000000b00487fc51c532sm16354456edk.33.2023.01.19.09.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:45:25 -0800 (PST)
Message-ID: <e20e80fd-cb10-2f41-b5d8-8d6673e2b506@gmail.com>
Date:   Thu, 19 Jan 2023 18:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] soc: mediatek: pm-domains: Add buck isolation offset
 and mask to power domain data
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230117032640.13504-1-allen-kh.cheng@mediatek.com>
 <20230117032640.13504-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230117032640.13504-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2023 04:26, Allen-KH Cheng wrote:
> Add buck isolation offset and mask to power domain data.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-pm-domains.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 7d3c0c36316c..a5f24c58e35a 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -81,6 +81,8 @@ struct scpsys_bus_prot_data {
>    * @ctl_offs: The offset for main power control register.
>    * @sram_pdn_bits: The mask for sram power control bits.
>    * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> + * @ext_buck_iso_offs: The offset for external buck isolation
> + * @ext_buck_iso_mask: The mask for external buck isolation
>    * @caps: The flag for active wake-up action.
>    * @bp_infracfg: bus protection for infracfg subsystem
>    * @bp_smi: bus protection for smi subsystem
> @@ -91,6 +93,8 @@ struct scpsys_domain_data {
>   	int ctl_offs;
>   	u32 sram_pdn_bits;
>   	u32 sram_pdn_ack_bits;
> +	int ext_buck_iso_offs;
> +	u32 ext_buck_iso_mask;
>   	u8 caps;
>   	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
>   	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
