Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937BC64B9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiLMQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiLMQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:31:45 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5921256
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:31:43 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f16so3826219ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fVKUh2+QI64ZIEkEINbeaDS3cwQja0P9IxofnvB2jE=;
        b=SBSUlzNPKTh2vN7xGwX0+CnvJFw7te6GgBNLYtQHVWvRIN2cqn5Z1mPB0CQN1o83G7
         pf7BYbWs6q+vH65Bnf4pg6Hv6C1OjypmG3ATtdun+r1qEbSvumkxW3ng3L7FP6NZo48+
         5r5KR9/T5ZNgPc7smlQS4/Yf/JyA+wWhJACvv2VnP7vT7ep0ghnjJE0OPG24zDI79Gw0
         xTZ/qBRmlTve1I4UCNyGJVK58Kx4Qc00vzCokfMH18VekkaCxW7JPlNjrmbejvLja058
         eYKgiJ9BJ4YidWb9vcn1ZrY1dldrMxD9H6NCRLN0nO9I2Lkv9a/vMtPycSQzONh3E2/K
         r+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fVKUh2+QI64ZIEkEINbeaDS3cwQja0P9IxofnvB2jE=;
        b=KaZv0VDCMuVTQ1bGI5iOAz6zlQBxAmfzJHCZApKsxM0cg+0G3Pz40HVz9H25sDwsoG
         9T3PnRMWm9mGhMpI2iBWH852+6zfXxnYxqBZiWFybAmZkOBBlVPNFGeXpnZTwUALD/dg
         8whiB190CsrPuvPhyjG3W0gcwdMlRxDX+8X/+g8v/8StCLcJGbxyI/xw6o5hc65nJIkw
         LkM8Q6gn8vfStTY/PlH0Mg4q4s7ed05YmsZKE0QEdMsDItB1l5gcfVyAY0MqUIkggRuA
         MHgahm7FfDEjJbIRu+vGDhxE553c7TX+kfOmP0dcruBA9Z9p62W7dkbvjB02kFEDjj7M
         waLw==
X-Gm-Message-State: ANoB5plMfNOaowshwqD/mv/oM6LzRdpC1c0uVNx3a9LJg7qSbNTqk32e
        oygEQLVYNVRUaNpGPXDS4G0Zqg==
X-Google-Smtp-Source: AA0mqf4linTEHhvzoqZ+xGkZEoDE89tR6y+NXb12dTNueCxtlalVHHrIqWLAdu8O7nxwCspZccrOyw==
X-Received: by 2002:a2e:a98f:0:b0:278:ec8c:791d with SMTP id x15-20020a2ea98f000000b00278ec8c791dmr6429418ljq.17.1670949102324;
        Tue, 13 Dec 2022 08:31:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p18-20020a2e9ad2000000b00279f3c58278sm320970ljj.51.2022.12.13.08.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 08:31:41 -0800 (PST)
Message-ID: <e87ac9f3-e0ce-bd4c-6e2c-d57adb0c9169@linaro.org>
Date:   Tue, 13 Dec 2022 17:31:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 11/13] arm64: dts: qcom: sm6350: Remove reg-names
 property from LLCC node
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, stable@vger.kernel.org
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212123311.146261-12-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221212123311.146261-12-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2022 13:33, Manivannan Sadhasivam wrote:
> The LLCC block has several banks each with a different base address
> and holes in between. So it is not a correct approach to cover these
> banks with a single offset/size. Instead, the individual bank's base
> address needs to be specified in devicetree with the exact size.
> 
> On SM6350, there is only one LLCC bank available. So only change needed is
> to remove the reg-names property from LLCC node to conform to the binding.
> 
> The driver is expected to parse the reg field based on index to get the
> addresses of each LLCC banks.
> 
> Cc: <stable@vger.kernel.org> # 5.16
> Fixes: ced2f0d75e13 ("arm64: dts: qcom: sm6350: Add LLCC node")

This is a definitive no go. There is no bug here and such change cannot
be backported.

> Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>

What is the bug here which deserves a credit? reg-names in v5.16 were
perfectly correct.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 43324bf291c3..1f39627cd7c6 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1174,7 +1174,6 @@ dc_noc: interconnect@9160000 {
>  		system-cache-controller@9200000 {
>  			compatible = "qcom,sm6350-llcc";
>  			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
> -			reg-names = "llcc_base", "llcc_broadcast_base";
>  		};
>  
>  		gem_noc: interconnect@9680000 {

Best regards,
Krzysztof

