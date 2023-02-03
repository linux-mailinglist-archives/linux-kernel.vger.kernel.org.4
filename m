Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F1D689976
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBCNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBCNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:08:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F86C660;
        Fri,  3 Feb 2023 05:08:02 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k4so15231462eje.1;
        Fri, 03 Feb 2023 05:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+oNqKUjSYteeXc32+a1j1XXitAiSrhnlK69sLD2wiE=;
        b=XBlTfXiA6xY/KBhsBCXPdktvCyiHE4+WzsMBh1ofzFNiG0gYTetLQxFwVv0RkdcVE7
         TUNApe5IKU7kXXdXrnwaPS4GESt2VxA24ApJ5R5L2yHcxK917UvP22milafts/2bsC6W
         PnMakg3oUPR94YPtWvntQzkC2IM/f9DNrdSmH19qw/f/tF68qvYjUYPwbgUPUyQIFPqL
         YuFTnrPCDXG+KNJVg6fpgdi9eIiw6JX75Wxzi2Bq9bsL3ONf31kO+ngSFAGbyQKNdRWn
         kap5Ma7+kYTyhjKbZmMsWWnJ70yPJOucx6Ct8g6QUB0ccFHbTQojo3jk5GDuZXbVE1PN
         Fjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+oNqKUjSYteeXc32+a1j1XXitAiSrhnlK69sLD2wiE=;
        b=yw8ECfn6R6wZM1BuLt5jEUuDPwxLrYRDe1t22s/NT8FBoZpPeJWrRWQU9Jl+dovVc8
         wUgJ58UPIJJmPCmnHFHRr8khOCEErruImzSlIRr4l3kVx3TGJ6U98FjIc8k8EZRcA4+H
         Dz5ij8u3cReFMhRxY1cKEhlmI3px7VvpPssDaIzemimwo48YKdlJ2eNaJIjQ1QSUXsZe
         hyx+TtLMp7uIhMQxDZn9qq6hbm8RWtiTGzUVI2e2+bI2b9NtKlMurcRVX08EZiPRPQUS
         m5T06ilCUwkF9pqhjJx44nQRmZMQFNtBTWfR80trdsRfx0kqRdNhj4NHaedAKWAiN4ZU
         652Q==
X-Gm-Message-State: AO0yUKW0YRPpiI+tSXpdNSqgECpgIJpzw8jpL3is0erF2Zu/bthYtn8F
        2FFWBPcG4J3gfrcvqA9mx2W0RIjRQh8=
X-Google-Smtp-Source: AK7set9vzcCz59807cbRnRYiNnlh560czXx/j4rsr1r0CfN6ry7Bg9+duIk7hWbLlWoSjKG9B93atg==
X-Received: by 2002:a17:906:2012:b0:878:59b6:c194 with SMTP id 18-20020a170906201200b0087859b6c194mr11088644ejo.32.1675429680992;
        Fri, 03 Feb 2023 05:08:00 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id gw16-20020a170906f15000b0088e5f3e1faesm1358722ejb.36.2023.02.03.05.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 05:08:00 -0800 (PST)
Message-ID: <897b3476-d62c-dbdb-63b0-8dbf4f24ccdf@gmail.com>
Date:   Fri, 3 Feb 2023 14:07:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/6] soc: mediatek: pm-domains: Add ADSP power domain
 data for MT8192
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
References: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
 <20221221034407.19605-5-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221221034407.19605-5-allen-kh.cheng@mediatek.com>
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



On 21/12/2022 04:44, Allen-KH Cheng wrote:
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

Can we get a define for this magic number please?

Regards,
Matthias

> +		.ext_buck_iso_mask = BIT(2),
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
