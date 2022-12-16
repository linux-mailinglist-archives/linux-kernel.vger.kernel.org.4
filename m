Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0857C64EA13
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiLPLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLPLQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:16:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B12BD3;
        Fri, 16 Dec 2022 03:15:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso3850053wme.5;
        Fri, 16 Dec 2022 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TduGez5okMoaMoWtG+a/gDZ6K+tMIFN63iCFQSQsXnc=;
        b=poGvMOI+DZhFnvewifa7xuMgoYfEN6GfdHixircewhmNWI1wf7jJRpF6FLe2k+gBh+
         BfaBVFfBiZmo8WvNNTkM1KA2ip8M8Inf32AtLoX875ooAjtN+w5lJ+waGJsab2ThhKAj
         m1+vBp3R5kwpep77ei/Pid7DFabFUTtpheALbrtR8L9+2DQHbgiS7k+HVUshCj0mZy4A
         z2B7TSCqZHlCM0+sgeWTfBf34NWB+670zIUaIMF4rVYWbIq0lFLpY0P06BQmT6rfRItw
         lDrc2JcsKGgGiVgw516DWiUEqgVltFg1DfjtTCYkzoThvNDSJv8VIghV9G0SoUfnSVE6
         Qkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TduGez5okMoaMoWtG+a/gDZ6K+tMIFN63iCFQSQsXnc=;
        b=NmXB377L1I+hEzbK8OqIH2u4D6WH5YyAh5V3Wq8BISMAbS/ugYzyqU2/bt2WZbOzaP
         CNJA+SSj06wCXuYVQI6gnmDyL31RQnDohZHWjPiQ6mWSJksru4n+nwdiX9aCPvh/2EKM
         yc/YTlTugxaINu4G+1uZOSXCinZVtj5uyPNCpK9+GXEz4hWjt2gmJRDDnvCvKcXzJHg0
         lDqwav2hn4xbblG0WTrulNyIX/LMRyRZiRYEpF2hOjXtKfyKtoLuQ0zv/cyLQHFOR7qK
         uc9KxDdzFcSFWbw78eYIJzblUce1/X+SZX3+VOQT6UXmKvwwbIubkV7odP8wQiGh39Xb
         Hz5w==
X-Gm-Message-State: ANoB5pmY0YDKX/CCv/sjFhCvUJam0lbNo25rbuxodOdBl1wAtV4by2zj
        RsB4cqgZK154/6f8UQcnHcDm7O0iXgQ=
X-Google-Smtp-Source: AA0mqf7JMvc5A1nsCgHMY4tDpIPErZEnQUIERlUiYi0wkELvSsM/N+Zzruki8wtc4cD0x7K7L0Oilg==
X-Received: by 2002:a05:600c:3555:b0:3d0:8643:caf1 with SMTP id i21-20020a05600c355500b003d08643caf1mr17299280wmq.16.1671189347575;
        Fri, 16 Dec 2022 03:15:47 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i26-20020a1c541a000000b003c6c182bef9sm11257713wmb.36.2022.12.16.03.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:15:46 -0800 (PST)
Message-ID: <9511c5b1-203b-a7e3-b96b-614e1c52639a@gmail.com>
Date:   Fri, 16 Dec 2022 12:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] soc: mediatek: pm-domains: Add ADSP power domain data
 for MT8192
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221215120016.26611-1-allen-kh.cheng@mediatek.com>
 <20221215120016.26611-3-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221215120016.26611-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/12/2022 13:00, Allen-KH Cheng wrote:
> Add ADSP pm-domains (mtcmos) data for MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   drivers/soc/mediatek/mt8192-pm-domains.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
> index b97b2051920f..19e58f0ca1df 100644
> --- a/drivers/soc/mediatek/mt8192-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8192-pm-domains.h
> @@ -287,6 +287,22 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
>   		.sram_pdn_bits = GENMASK(8, 8),
>   		.sram_pdn_ack_bits = GENMASK(12, 12),
>   	},
> +	[MT8192_POWER_DOMAIN_ADSP] = {
> +		.name = "adsp",
> +		.sta_mask = BIT(22),
> +		.ctl_offs = 0x0358,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.ext_buck_iso_offs = 0x039C,
> +		.ext_buck_iso_mask = BIT(2),

Not defined in upstream. It seems we are missing something here.

Regards,
Matthias

> +		.bp_infracfg = {
> +			BUS_PROT_WR(MT8192_TOP_AXI_PROT_EN_2_ADSP,
> +				    MT8192_TOP_AXI_PROT_EN_2_SET,
> +				    MT8192_TOP_AXI_PROT_EN_2_CLR,
> +				    MT8192_TOP_AXI_PROT_EN_2_STA1),
> +		},
> +		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_EXT_BUCK_ISO,
> +	},
>   	[MT8192_POWER_DOMAIN_CAM] = {
>   		.name = "cam",
>   		.sta_mask = BIT(23),
