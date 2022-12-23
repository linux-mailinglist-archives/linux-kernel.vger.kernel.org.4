Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F70654E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiLWJFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:05:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1536C49
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:05:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so6275640lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgkyZLlR8dmps7bIqgtuU0p5kKZJ22gyr0j4DXf+Tuc=;
        b=Go1z1WOZVAeyBHYx43G2o1a8Yqwp73M6XDVnsyel0fTSrZE7lFmvXu6jECQRR07gBz
         99nbMAP/RhkSJr3F/TaU4QfxJ2YnyRThXR9yAzmSeI2YISl5G+/wja0nBz5lfp26ARpA
         NXwz3/M0U6g2ijul298JVbhc/ZkbMUfBhHPhgKTaOgPSjCOdoAt+UTm8+jfqJGY5kVPa
         lT8546ZP2UjeEalietwdiWWN23EUjBOLEKV2s6xaxlg64Xb+h9CeOCSmY5jtJu3Bmg2A
         KFDHcbBOt2ZnGYe93EUJ9L157dTvP6V6tl1Sg1g+k4QSh3WfY4ScVsdrlH0IY71yXBwU
         BhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgkyZLlR8dmps7bIqgtuU0p5kKZJ22gyr0j4DXf+Tuc=;
        b=OXS/tfps/fAWC4+fu0WL3QTqd8spS2mNI3KeDumUwsb/DDZfFnAJNG8p5KKPJP1bz1
         Xx/30lXN0HpBco6R8m7GHE3/EyWnbMetZHRvLAd+rXGKKvz72ucsM64iExuEm732guPx
         yovWIVo8R8fdFJ6d34smIjDD7kEmlLyfNTgC93H8klT+hjDX/iVvCknMvbd1vSPmyrWg
         7gf0mf/4mhQ+ljj1GWD6cedT8mW5sLheNUC6ISZ9aDXQxFbKwk9UgPXiYkC0RTRnIB0f
         smlLzNu7GMQctQK2FkyKcYs8wmaGWnVfUaIdpDZaDvfL8AzXxQHFuYCTFuaXXPKCxmW+
         c5+g==
X-Gm-Message-State: AFqh2krCJYrLxBRXRR3en+aQc5wapiuZ39I4Hm62hJCCL6bJZ1bao7+A
        oxBrY8yCqkGFlaFerCRhNsZxWg==
X-Google-Smtp-Source: AMrXdXu07H/DBU/l0axgXYiPZK261IL8apRQ5mpgRPTJSTtf+JWCe6x+AyhRvRw1adFfKChiMlIlNQ==
X-Received: by 2002:a05:6512:20d0:b0:4b5:88e4:2ba4 with SMTP id u16-20020a05651220d000b004b588e42ba4mr2175863lfr.15.1671786309930;
        Fri, 23 Dec 2022 01:05:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z12-20020ac2418c000000b004b58ebf0399sm443827lfh.132.2022.12.23.01.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:05:09 -0800 (PST)
Message-ID: <e079efba-2cd7-6e1d-3ce2-7f0371962252@linaro.org>
Date:   Fri, 23 Dec 2022 10:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sc7280: Extract audio nodes from
 common idp dtsi file
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org
References: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
 <1671702170-24781-2-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671702170-24781-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 10:42, Srinivasa Rao Mandadapu wrote:
> Split common idp dtsi file into audio specific dtsi and common
> idp dtsi file.
> 
> It is required to isolate idp and crd-rev3 platform device tree nodes
> and convert crd-rev3 platform device tree nodes into audioreach specific
> device tree nodes.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi | 242 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts     |   1 +
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 230 -----------------------
>  arch/arm64/boot/dts/qcom/sc7280-idp2.dts       |   1 +
>  4 files changed, 244 insertions(+), 230 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
> new file mode 100644
> index 0000000..8c9e667
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * sc7280 Audio IDP board device tree source (common between SKU1 and SKU2)
> + *
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +

Mising includes. Each file is responsible for its own includes and must
not rely on others to include something.

> +/{
> +   /* BOARD-SPECIFIC TOP LEVEL NODES */

Wrong indentation.

> +	sound: sound {
> +		compatible = "google,sc7280-herobrine";
> +		model = "sc7280-wcd938x-max98360a-1mic";
> +
> +		audio-routing =
> +			   "IN1_HPHL", "HPHL_OUT",
> +			   "IN2_HPHR", "HPHR_OUT",
> +			   "AMIC1", "MIC BIAS1",
> +			   "AMIC2", "MIC BIAS2",
> +			   "VA DMIC0", "MIC BIAS3",
> +			   "VA DMIC1", "MIC BIAS3",
> +			   "VA DMIC2", "MIC BIAS1",
> +			   "VA DMIC3", "MIC BIAS1",
> +			   "TX SWR_ADC0", "ADC1_OUTPUT",
> +			   "TX SWR_ADC1", "ADC2_OUTPUT",
> +			   "TX SWR_ADC2", "ADC3_OUTPUT",
> +			   "TX SWR_DMIC0", "DMIC1_OUTPUT",
> +			   "TX SWR_DMIC1", "DMIC2_OUTPUT",
> +			   "TX SWR_DMIC2", "DMIC3_OUTPUT",
> +			   "TX SWR_DMIC3", "DMIC4_OUTPUT",
> +			   "TX SWR_DMIC4", "DMIC5_OUTPUT",
> +			   "TX SWR_DMIC5", "DMIC6_OUTPUT",
> +			   "TX SWR_DMIC6", "DMIC7_OUTPUT",
> +			   "TX SWR_DMIC7", "DMIC8_OUTPUT";
> +
> +		qcom,msm-mbhc-hphl-swh = <1>;
> +		qcom,msm-mbhc-gnd-swh = <1>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#sound-dai-cells = <0>;
> +
> +		dai-link@0 {
> +			link-name = "MAX98360A";
> +			reg = <0>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
> +			};
> +
> +			codec {
> +			   sound-dai = <&max98360a>;

I have no clue what happened here. This was correct code before, now it
is not. It turns out it was not just a move of code. If you just
cut+paste, would be fine, but you changed it during moving and now we
have to review it. Reviewing such diffs is difficult if not impossible,
so we have no way to validate, maybe except comparing de-compiled dtbs
(dtx_diff, fdtdump). Did you do it?

Otherwise I do not see a way how can we be sure this code is correct if
you do not cut+paste but change the code in the meantime.

Best regards,
Krzysztof

