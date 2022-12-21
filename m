Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C327652FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiLUKjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiLUKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:39:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A443BA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:39:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z26so22837150lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxdKqsLuz6bID8DbZMd3V6s/TTGbaralPkilWXa38+4=;
        b=ALNmyFz7l7qGItYkVDE3PFVZ74mgc19cf1odUdPq1rSMCDAKMivpIzKmnLlWMlB9oY
         J0H1uFEKkS6xv9o3rZASJX3UYPVZgBRdR00KdaLYl5iAhJR8CqC3SOb3y7F7MUW46IBC
         sGH9Fv6sr0q8daBkxNL+49d9z/5ojPwa8+F7fc3879Pszo3nUnAOQSnqWxAGv3Sf1y58
         mr+fLSMyQAkXLvpiTNe/o6xPUJL29xbE0orQ8I4Kp/sih424b3NBa+b03UfeUJxtgmOq
         L97dsFj8ffVfyHSb/3i8FtkLG4REn51R1s5s9GXbpS+lIpq7u7ZkXagHl9GER+AWCRZV
         1yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxdKqsLuz6bID8DbZMd3V6s/TTGbaralPkilWXa38+4=;
        b=JNYrX/mzaBplgK3jIjWVHC2Oo7oBAIjrqSh+K3Qa/OKYOSYCqXGxZ4bWwCAcMEUFUx
         cdHxWxNFdIKOTP64P51NVe/UP0eVqD6fRjbk+OvB/6QZJA6W6acPPNtbokEaSmfkToTY
         Ebgyuitr7k7Jf0r4ujCMK5mg8L8P3ARoExB1uT2ruvrsHEV+gwB7NkSH1z3jd6VSNxtT
         AHnl5/XS4wE206iPm8LO6/H8P1xJJZiPOM+/J0NhN9ggbCEriyJOnr6ULF7kfFWDswwV
         24lmGWTn6AciF4VA7f90lHulxRgRqoLLSsEua08TxLmixnhxqymuR6fbdFLNFx/Z67K0
         6Xbg==
X-Gm-Message-State: AFqh2kqB6uUTECtOgtmntG8kWh41PkLtwSQpZXUSnqkt4r8P2WsYueJe
        sCt8dUdolZi214zlMF7mpTcBOME4j6F++XZU
X-Google-Smtp-Source: AMrXdXsgXX7RGGH9ttNmwxmxi/N03op+upda3uNLgRQ09XbOORSGyIoKUbTwZl+zHm5B6MnswJss3w==
X-Received: by 2002:ac2:5b41:0:b0:4a4:68b9:66dd with SMTP id i1-20020ac25b41000000b004a468b966ddmr419834lfp.40.1671619183533;
        Wed, 21 Dec 2022 02:39:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k7-20020ac257c7000000b004c2e1d7d9a3sm1551023lfo.146.2022.12.21.02.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 02:39:43 -0800 (PST)
Message-ID: <efde6373-f788-5c0c-4712-7b9caf7ad3d4@linaro.org>
Date:   Wed, 21 Dec 2022 11:39:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] clk: qcom: lpasscc: Add resets for SC7280 audioreach
 clock controller
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1671618061-6329-1-git-send-email-quic_srivasam@quicinc.com>
 <1671618061-6329-3-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671618061-6329-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 11:21, Srinivasa Rao Mandadapu wrote:
> The clock gating control for TX/RX/WSA core bus clocks would be required
> to be reset(moved from hardware control) from audio core driver. Thus
> add the support for the reset clocks in audioreach based clock driver.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  drivers/clk/qcom/lpasscc-sc7280.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
> index 5c1e17b..d81d81b 100644
> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> @@ -12,10 +12,12 @@
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,lpass-sc7280.h>
> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>

These are bindings for different device.

>  
>  #include "clk-regmap.h"
>  #include "clk-branch.h"
>  #include "common.h"
> +#include "reset.h"
>  
>  static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
>  	.halt_reg = 0x0,
> @@ -102,6 +104,18 @@ static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
>  	.num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
>  };
>  
> +static const struct qcom_reset_map lpass_cc_sc7280_resets[] = {
> +	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
> +	[LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
> +	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },

These are example the same - IDs and values - as
qcom,sc7280-lpassaudiocc. Aren't you duplicating same control?

Best regards,
Krzysztof

