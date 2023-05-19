Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1E709CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjESQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjESQw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:52:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B82FD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:52:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f26f437b30so3983441e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684515175; x=1687107175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKNMa0s4Vk4CkoiOAyA9DUfRZyyAScSWwyf79QsupZg=;
        b=T3kEGXtQkNq9tMLqkKPuXcX5Hwe7JZrZnODT8hWYVSVNv51ycYlxBGrhCxXdgtSnOB
         DgN000U/z4upaQRc9BBUs9+0+VfgjiWk6bMMXhTCUgTE0EbmwIuCtKUlmcEUcAGxpZCD
         Dp1eK8JZpvv8PdPCz36WLmYsVWAthILLNgL8pQU+jAH0TZOiFpUA/QOGjBV+zHWC0jtO
         JpO5HvNRFyRFfltfo+TcBVO4XGprcpCMcmPvNcusTie1Fw+iQAo7/MWzdgrXUhShRGPh
         LJn3iQQ5GpIsv/tPzTWzP+OEaP13gHsbb+sAzIg6bn+o+/C7T8OffztR9KcLQxX763IJ
         vdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515175; x=1687107175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKNMa0s4Vk4CkoiOAyA9DUfRZyyAScSWwyf79QsupZg=;
        b=L8gVljT8LxOmzzlbo9WFshTqaTRQR3RuYLnPx2aiZq+H7Nvc8itQ1XO+s5oNAa+wti
         pVkZqoz8iJL9b+it3BlRu2NkSTDhBYrqxwkxMayMqm/yqk2j9t+lWWb1Bb+NoypyA525
         WkqwRSL8FAMakHO3MvRqyrXRJn7+lAxftV1aR3ql6nIp17BH5vnce7X8wz5TdXbdSzvG
         zhW147ImqB4Ly3M6LlhnobEMpxr5wmXS/1+yWslk5G2Chi6ynNPCxpTiUyl4gAzpkn5i
         A0YkPhID6ZS/X6H3eLldegdGWaZSHILarsCe2sbR49AITHrxdaN9c9ZRw97liaDWKz+7
         EniA==
X-Gm-Message-State: AC+VfDzm6OaBLy3cvCINuaOWwHoRZJe0if2YsYS3ZeTE9Rj0phN8FPFB
        wYeunX/e2qWDQawzxnu2t/EeMg==
X-Google-Smtp-Source: ACHHUZ5GRnZEXcAAo1HGUkRBvXlAE5ebGSOeGchueyWmdk7Arl/6Rvf1X0Uq6sPltP51ozwaEDXP8A==
X-Received: by 2002:ac2:5503:0:b0:4ec:8816:f4fc with SMTP id j3-20020ac25503000000b004ec8816f4fcmr966012lfk.6.1684515174867;
        Fri, 19 May 2023 09:52:54 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id r4-20020a056512102400b004f24db9248dsm656008lfr.141.2023.05.19.09.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:52:54 -0700 (PDT)
Message-ID: <634c80b4-5007-4f66-9114-1dedf3c95f1f@linaro.org>
Date:   Fri, 19 May 2023 18:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8550: Add camera clock controller
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
 <20230519155602.6642-5-quic_jkona@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519155602.6642-5-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 17:56, Jagadeesh Kona wrote:
> Add device node for camera clock controller on Qualcomm
> SM8550 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index e67e7c69dae6..ac82d3774ed8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sm8550-camcc.h>
>  #include <dt-bindings/clock/qcom,sm8550-gcc.h>
>  #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
>  #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
> @@ -2397,6 +2398,20 @@ opp-202000000 {
>  			};
>  		};
>  
> +		camcc: clock-controller@ade0000 {
> +			compatible = "qcom,sm8550-camcc";
> +			reg = <0 0xade0000 0 0x20000>;
Please pad the non-zero address part to 8 hex digits

Konrad
> +			clocks = <&bi_tcxo_div2>,
> +				 <&bi_tcxo_ao_div2>,
> +				 <&sleep_clk>,
> +				 <&gcc GCC_CAMERA_AHB_CLK>;
> +			power-domains = <&rpmhpd SM8550_MMCX>;
> +			required-opps = <&rpmhpd_opp_low_svs>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		mdss: display-subsystem@ae00000 {
>  			compatible = "qcom,sm8550-mdss";
>  			reg = <0 0x0ae00000 0 0x1000>;
