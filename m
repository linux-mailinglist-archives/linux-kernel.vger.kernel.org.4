Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1D97498D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGFJ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjGFJ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:59:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF33199E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:59:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso623566e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688637552; x=1691229552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4KRAl1SXh9F50E8KrcQpWDKtvEdJdPWaJltBzl5oqM=;
        b=zar+rSBoiY8ta2dNbHlyMHWPjKN/Tudmy/AM6Y9B4V1OZB6uRG+rA/NQRLKkUWiW7d
         fdwVBVpVpqxbSewBuT9wNXOk+f+MvdOo7h7qmho78OE7EFaKOZakFr8dWMoxkQdph/Mn
         Zf8xiTbIkrMog3B1NtyFV7A8GM7P3gclpRG3QnSsNP8yOlkW/RSPTeHMrBxHPW9DgZVx
         sJTfp+MOIpwp4R3xH+fpPSDXWTEPrHC8f29W5Fn2Zu1DbXsg949wbunG9H5qSzfysfQS
         QdO2d0DXQl2n8FVC7r/dMPsTWb9AjmHjiSdT+fDeB149UCF7MBNBceknyaxvT56YwEu7
         rcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688637552; x=1691229552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4KRAl1SXh9F50E8KrcQpWDKtvEdJdPWaJltBzl5oqM=;
        b=dr3b/nWMACTyaunKChdTQWqjhTXWpFfou3rM5fKgKHN/RjoY8zdEc/YFcl3eeahRI9
         TfSgeaUqZhcGA0acusZYfv0k9SA4S+Tqmj06nU8gMsHBJ3YF7F2mzB+jA/ecOkPwZGxa
         X9MASCR8S2X2TpG033Ig3rsR8yKXhH6uNA62X0/rW0S3Q657KKFV/TlZHSnDHpn7Wthn
         W/A6Em2qPwTDRHvtnXj2oztuCAnRkWhuD/Sg2FaeeQJwTXBCfRyb9UjjNKWokGMfJ7vQ
         glGMyMuOaID/RLjiPMBml29bvEuoeZcKwvG/Uk2wxQ0fjzTqdZzUROsEc1kgP1DOCZ0K
         wYzA==
X-Gm-Message-State: ABy/qLbhnS4Ecg8JHI4pZw/zAUnEtvCUiL118QutoWwW3q0lkCgonKsq
        YbVvSZJVwZju9kJk/3szCaBa3w==
X-Google-Smtp-Source: APBJJlHx2jb/C1xvYcviytoGsRRP3/hnSZYvdyDHFNz3f0GfzvUjVskqOWLR4lZxf9/47D/NhCivkw==
X-Received: by 2002:a05:6512:6c7:b0:4f8:46e9:9f19 with SMTP id u7-20020a05651206c700b004f846e99f19mr1341725lff.1.1688637552469;
        Thu, 06 Jul 2023 02:59:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id m26-20020ac24ada000000b004f866200361sm184921lfp.164.2023.07.06.02.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 02:59:12 -0700 (PDT)
Message-ID: <630406a9-7410-8608-ffb5-67ec37caeea1@linaro.org>
Date:   Thu, 6 Jul 2023 11:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Remove the SoC specific
 entries
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688635218-23779-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1688635218-23779-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.07.2023 11:20, Rohit Agarwal wrote:
> Remove the SoC specific entries and add a generic set of defines
> that can be used by all the SoCs. This will remove the duplicate
> entries among SoCs.
> The arrangement of the defines is done according to the frequency
> used in SoC specific entries in the driver to avoid wastage of
> memory.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
It was easy to misunderstand, but that's not what I meant :/

Basically we can't do what's done in this commit, as everything in
include/dt-bindings is ABI and unless there's a good reason (e.g. "this
could have never worked anyway"), it shouldn't be broken.

What we *should* do though, is apply this to all new platforms.
We unfortunately have to carry this legacy baggage so long as we
keep the RPM(h)PD drivers around.

So, with your SDX75 addition, please use the new, SoC-independent
indices and keep the old junk as stinky as it was

Konrad
> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 389 ++++-----------------------------
>  1 file changed, 46 insertions(+), 343 deletions(-)
> 
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 83be996..fa2ed08 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -4,216 +4,52 @@
>  #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
>  #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
>  
> -/* SA8775P Power Domain Indexes */
> -#define SA8775P_CX	0
> -#define SA8775P_CX_AO	1
> -#define SA8775P_DDR	2
> -#define SA8775P_EBI	3
> -#define SA8775P_GFX	4
> -#define SA8775P_LCX	5
> -#define SA8775P_LMX	6
> -#define SA8775P_MMCX	7
> -#define SA8775P_MMCX_AO	8
> -#define SA8775P_MSS	9
> -#define SA8775P_MX	10
> -#define SA8775P_MX_AO	11
> -#define SA8775P_MXC	12
> -#define SA8775P_MXC_AO	13
> -#define SA8775P_NSP0	14
> -#define SA8775P_NSP1	15
> -#define SA8775P_XO	16
> -
> -/* SDM670 Power Domain Indexes */
> -#define SDM670_MX	0
> -#define SDM670_MX_AO	1
> -#define SDM670_CX	2
> -#define SDM670_CX_AO	3
> -#define SDM670_LMX	4
> -#define SDM670_LCX	5
> -#define SDM670_GFX	6
> -#define SDM670_MSS	7
> -
> -/* SDM845 Power Domain Indexes */
> -#define SDM845_EBI	0
> -#define SDM845_MX	1
> -#define SDM845_MX_AO	2
> -#define SDM845_CX	3
> -#define SDM845_CX_AO	4
> -#define SDM845_LMX	5
> -#define SDM845_LCX	6
> -#define SDM845_GFX	7
> -#define SDM845_MSS	8
> -
> -/* SDX55 Power Domain Indexes */
> -#define SDX55_MSS	0
> -#define SDX55_MX	1
> -#define SDX55_CX	2
> -
> -/* SDX65 Power Domain Indexes */
> -#define SDX65_MSS	0
> -#define SDX65_MX	1
> -#define SDX65_MX_AO	2
> -#define SDX65_CX	3
> -#define SDX65_CX_AO	4
> -#define SDX65_MXC	5
> -
> -/* SM6350 Power Domain Indexes */
> -#define SM6350_CX	0
> -#define SM6350_GFX	1
> -#define SM6350_LCX	2
> -#define SM6350_LMX	3
> -#define SM6350_MSS	4
> -#define SM6350_MX	5
> -
> -/* SM6350 Power Domain Indexes */
> -#define SM6375_VDDCX		0
> -#define SM6375_VDDCX_AO	1
> -#define SM6375_VDDCX_VFL	2
> -#define SM6375_VDDMX		3
> -#define SM6375_VDDMX_AO	4
> -#define SM6375_VDDMX_VFL	5
> -#define SM6375_VDDGX		6
> -#define SM6375_VDDGX_AO	7
> -#define SM6375_VDD_LPI_CX	8
> -#define SM6375_VDD_LPI_MX	9
> -
> -/* SM8150 Power Domain Indexes */
> -#define SM8150_MSS	0
> -#define SM8150_EBI	1
> -#define SM8150_LMX	2
> -#define SM8150_LCX	3
> -#define SM8150_GFX	4
> -#define SM8150_MX	5
> -#define SM8150_MX_AO	6
> -#define SM8150_CX	7
> -#define SM8150_CX_AO	8
> -#define SM8150_MMCX	9
> -#define SM8150_MMCX_AO	10
> -
> -/* SA8155P is a special case, kept for backwards compatibility */
> -#define SA8155P_CX	SM8150_CX
> -#define SA8155P_CX_AO	SM8150_CX_AO
> -#define SA8155P_EBI	SM8150_EBI
> -#define SA8155P_GFX	SM8150_GFX
> -#define SA8155P_MSS	SM8150_MSS
> -#define SA8155P_MX	SM8150_MX
> -#define SA8155P_MX_AO	SM8150_MX_AO
> -
> -/* SM8250 Power Domain Indexes */
> -#define SM8250_CX	0
> -#define SM8250_CX_AO	1
> -#define SM8250_EBI	2
> -#define SM8250_GFX	3
> -#define SM8250_LCX	4
> -#define SM8250_LMX	5
> -#define SM8250_MMCX	6
> -#define SM8250_MMCX_AO	7
> -#define SM8250_MX	8
> -#define SM8250_MX_AO	9
> -
> -/* SM8350 Power Domain Indexes */
> -#define SM8350_CX	0
> -#define SM8350_CX_AO	1
> -#define SM8350_EBI	2
> -#define SM8350_GFX	3
> -#define SM8350_LCX	4
> -#define SM8350_LMX	5
> -#define SM8350_MMCX	6
> -#define SM8350_MMCX_AO	7
> -#define SM8350_MX	8
> -#define SM8350_MX_AO	9
> -#define SM8350_MXC	10
> -#define SM8350_MXC_AO	11
> -#define SM8350_MSS	12
> -
> -/* SM8450 Power Domain Indexes */
> -#define SM8450_CX	0
> -#define SM8450_CX_AO	1
> -#define SM8450_EBI	2
> -#define SM8450_GFX	3
> -#define SM8450_LCX	4
> -#define SM8450_LMX	5
> -#define SM8450_MMCX	6
> -#define SM8450_MMCX_AO	7
> -#define SM8450_MX	8
> -#define SM8450_MX_AO	9
> -#define SM8450_MXC	10
> -#define SM8450_MXC_AO	11
> -#define SM8450_MSS	12
> -
> -/* SM8550 Power Domain Indexes */
> -#define SM8550_CX	0
> -#define SM8550_CX_AO	1
> -#define SM8550_EBI	2
> -#define SM8550_GFX	3
> -#define SM8550_LCX	4
> -#define SM8550_LMX	5
> -#define SM8550_MMCX	6
> -#define SM8550_MMCX_AO	7
> -#define SM8550_MX	8
> -#define SM8550_MX_AO	9
> -#define SM8550_MXC	10
> -#define SM8550_MXC_AO	11
> -#define SM8550_MSS	12
> -#define SM8550_NSP	13
> -
> -/* QDU1000/QRU1000 Power Domain Indexes */
> -#define QDU1000_EBI	0
> -#define QDU1000_MSS	1
> -#define QDU1000_CX	2
> -#define QDU1000_MX	3
> -
> -/* SC7180 Power Domain Indexes */
> -#define SC7180_CX	0
> -#define SC7180_CX_AO	1
> -#define SC7180_GFX	2
> -#define SC7180_MX	3
> -#define SC7180_MX_AO	4
> -#define SC7180_LMX	5
> -#define SC7180_LCX	6
> -#define SC7180_MSS	7
> -
> -/* SC7280 Power Domain Indexes */
> -#define SC7280_CX	0
> -#define SC7280_CX_AO	1
> -#define SC7280_EBI	2
> -#define SC7280_GFX	3
> -#define SC7280_MX	4
> -#define SC7280_MX_AO	5
> -#define SC7280_LMX	6
> -#define SC7280_LCX	7
> -#define SC7280_MSS	8
> -
> -/* SC8180X Power Domain Indexes */
> -#define SC8180X_CX	0
> -#define SC8180X_CX_AO	1
> -#define SC8180X_EBI	2
> -#define SC8180X_GFX	3
> -#define SC8180X_LCX	4
> -#define SC8180X_LMX	5
> -#define SC8180X_MMCX	6
> -#define SC8180X_MMCX_AO	7
> -#define SC8180X_MSS	8
> -#define SC8180X_MX	9
> -#define SC8180X_MX_AO	10
> -
> -/* SC8280XP Power Domain Indexes */
> -#define SC8280XP_CX		0
> -#define SC8280XP_CX_AO		1
> -#define SC8280XP_DDR		2
> -#define SC8280XP_EBI		3
> -#define SC8280XP_GFX		4
> -#define SC8280XP_LCX		5
> -#define SC8280XP_LMX		6
> -#define SC8280XP_MMCX		7
> -#define SC8280XP_MMCX_AO	8
> -#define SC8280XP_MSS		9
> -#define SC8280XP_MX		10
> -#define SC8280XP_MXC		12
> -#define SC8280XP_MX_AO		11
> -#define SC8280XP_NSP		13
> -#define SC8280XP_QPHY		14
> -#define SC8280XP_XO		15
> +#define RPMHPD_CX		0
> +#define RPMHPD_MX		1
> +#define RPMHPD_CX_AO		2
> +#define RPMHPD_MX_AO		3
> +#define RPMHPD_GFX		4
> +#define RPMHPD_MSS		5
> +#define RPMHPD_EBI		6
> +#define RPMHPD_LCX		7
> +#define RPMHPD_LMX		8
> +#define RPMHPD_MMCX		9
> +#define RPMHPD_MMCX_AO		10
> +#define RPMHPD_MXC		11
> +#define RPMHPD_MXC_AO		12
> +#define RPMHPD_NSP		13
> +#define RPMHPD_NSP0		14
> +#define RPMHPD_NSP1		15
> +#define RPMHPD_QPHY		16
> +#define RPMHPD_DDR		17
> +#define RPMHPD_XO		18
> +
> +#define RPMPD_VDDCX		0
> +#define RPMPD_VDDCX_AO		1
> +#define RPMPD_VDDMX		2
> +#define RPMPD_VDDMX_AO		3
> +#define RPMPD_VDDCX_VFL		4
> +#define RPMPD_VDDMX_VFL		5
> +#define RPMPD_VDDCX_VFC		6
> +#define RPMPD_LPI_CX		7
> +#define RPMPD_LPI_MX		8
> +#define RPMPD_SSCCX		9
> +#define RPMPD_SSCCX_VFL		10
> +#define RPMPD_SSCMX		11
> +#define RPMPD_SSCMX_VFL		12
> +#define RPMPD_VDDSSCX		13
> +#define RPMPD_VDDSSCX_VFC	14
> +#define RPMPD_VDDGFX		15
> +#define RPMPD_VDDGFX_VFC	16
> +#define RPMPD_VDDGX		17
> +#define RPMPD_VDDGX_AO		18
> +#define RPMPD_VDDMDCX		19
> +#define RPMPD_VDDMDCX_AO	20
> +#define RPMPD_VDDMDCX_VFC	21
> +#define RPMPD_VDDMD		22
> +#define RPMPD_VDDMD_AO		23
> +#define RPMPD_LPICX_VFL		24
> +#define RPMPD_LPIMX_VFL		25
>  
>  /* SDM845 Power Domain performance levels */
>  #define RPMH_REGULATOR_LEVEL_RETENTION		16
> @@ -241,139 +77,6 @@
>  #define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
>  #define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
>  
> -/* MDM9607 Power Domains */
> -#define MDM9607_VDDCX		0
> -#define MDM9607_VDDCX_AO	1
> -#define MDM9607_VDDCX_VFL	2
> -#define MDM9607_VDDMX		3
> -#define MDM9607_VDDMX_AO	4
> -#define MDM9607_VDDMX_VFL	5
> -
> -/* MSM8226 Power Domain Indexes */
> -#define MSM8226_VDDCX		0
> -#define MSM8226_VDDCX_AO	1
> -#define MSM8226_VDDCX_VFC	2
> -
> -/* MSM8939 Power Domains */
> -#define MSM8939_VDDMDCX		0
> -#define MSM8939_VDDMDCX_AO	1
> -#define MSM8939_VDDMDCX_VFC	2
> -#define MSM8939_VDDCX		3
> -#define MSM8939_VDDCX_AO	4
> -#define MSM8939_VDDCX_VFC	5
> -#define MSM8939_VDDMX		6
> -#define MSM8939_VDDMX_AO	7
> -
> -/* MSM8916 Power Domain Indexes */
> -#define MSM8916_VDDCX		0
> -#define MSM8916_VDDCX_AO	1
> -#define MSM8916_VDDCX_VFC	2
> -#define MSM8916_VDDMX		3
> -#define MSM8916_VDDMX_AO	4
> -
> -/* MSM8909 Power Domain Indexes */
> -#define MSM8909_VDDCX		MSM8916_VDDCX
> -#define MSM8909_VDDCX_AO	MSM8916_VDDCX_AO
> -#define MSM8909_VDDCX_VFC	MSM8916_VDDCX_VFC
> -#define MSM8909_VDDMX		MSM8916_VDDMX
> -#define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
> -
> -/* MSM8953 Power Domain Indexes */
> -#define MSM8953_VDDMD		0
> -#define MSM8953_VDDMD_AO	1
> -#define MSM8953_VDDCX		2
> -#define MSM8953_VDDCX_AO	3
> -#define MSM8953_VDDCX_VFL	4
> -#define MSM8953_VDDMX		5
> -#define MSM8953_VDDMX_AO	6
> -
> -/* MSM8976 Power Domain Indexes */
> -#define MSM8976_VDDCX		0
> -#define MSM8976_VDDCX_AO	1
> -#define MSM8976_VDDCX_VFL	2
> -#define MSM8976_VDDMX		3
> -#define MSM8976_VDDMX_AO	4
> -#define MSM8976_VDDMX_VFL	5
> -
> -/* MSM8994 Power Domain Indexes */
> -#define MSM8994_VDDCX		0
> -#define MSM8994_VDDCX_AO	1
> -#define MSM8994_VDDCX_VFC	2
> -#define MSM8994_VDDMX		3
> -#define MSM8994_VDDMX_AO	4
> -#define MSM8994_VDDGFX		5
> -#define MSM8994_VDDGFX_VFC	6
> -
> -/* MSM8996 Power Domain Indexes */
> -#define MSM8996_VDDCX		0
> -#define MSM8996_VDDCX_AO	1
> -#define MSM8996_VDDCX_VFC	2
> -#define MSM8996_VDDMX		3
> -#define MSM8996_VDDMX_AO	4
> -#define MSM8996_VDDSSCX		5
> -#define MSM8996_VDDSSCX_VFC	6
> -
> -/* MSM8998 Power Domain Indexes */
> -#define MSM8998_VDDCX		0
> -#define MSM8998_VDDCX_AO	1
> -#define MSM8998_VDDCX_VFL	2
> -#define MSM8998_VDDMX		3
> -#define MSM8998_VDDMX_AO	4
> -#define MSM8998_VDDMX_VFL	5
> -#define MSM8998_SSCCX		6
> -#define MSM8998_SSCCX_VFL	7
> -#define MSM8998_SSCMX		8
> -#define MSM8998_SSCMX_VFL	9
> -
> -/* QCS404 Power Domains */
> -#define QCS404_VDDMX		0
> -#define QCS404_VDDMX_AO		1
> -#define QCS404_VDDMX_VFL	2
> -#define QCS404_LPICX		3
> -#define QCS404_LPICX_VFL	4
> -#define QCS404_LPIMX		5
> -#define QCS404_LPIMX_VFL	6
> -
> -/* SDM660 Power Domains */
> -#define SDM660_VDDCX		0
> -#define SDM660_VDDCX_AO		1
> -#define SDM660_VDDCX_VFL	2
> -#define SDM660_VDDMX		3
> -#define SDM660_VDDMX_AO		4
> -#define SDM660_VDDMX_VFL	5
> -#define SDM660_SSCCX		6
> -#define SDM660_SSCCX_VFL	7
> -#define SDM660_SSCMX		8
> -#define SDM660_SSCMX_VFL	9
> -
> -/* SM6115 Power Domains */
> -#define SM6115_VDDCX		0
> -#define SM6115_VDDCX_AO		1
> -#define SM6115_VDDCX_VFL	2
> -#define SM6115_VDDMX		3
> -#define SM6115_VDDMX_AO		4
> -#define SM6115_VDDMX_VFL	5
> -#define SM6115_VDD_LPI_CX	6
> -#define SM6115_VDD_LPI_MX	7
> -
> -/* SM6125 Power Domains */
> -#define SM6125_VDDCX		0
> -#define SM6125_VDDCX_AO		1
> -#define SM6125_VDDCX_VFL	2
> -#define SM6125_VDDMX		3
> -#define SM6125_VDDMX_AO		4
> -#define SM6125_VDDMX_VFL	5
> -
> -/* QCM2290 Power Domains */
> -#define QCM2290_VDDCX		0
> -#define QCM2290_VDDCX_AO	1
> -#define QCM2290_VDDCX_VFL	2
> -#define QCM2290_VDDMX		3
> -#define QCM2290_VDDMX_AO	4
> -#define QCM2290_VDDMX_VFL	5
> -#define QCM2290_VDD_LPI_CX	6
> -#define QCM2290_VDD_LPI_MX	7
> -
>  /* RPM SMD Power Domain performance levels */
>  #define RPM_SMD_LEVEL_RETENTION       16
>  #define RPM_SMD_LEVEL_RETENTION_PLUS  32
