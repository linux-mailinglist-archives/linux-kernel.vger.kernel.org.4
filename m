Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD76921E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjBJPUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjBJPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:19:57 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C375346
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:19:49 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw12so16797202ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfwo/m+BVb3HeTZgm0uhdzbWmdU04ZuaJp+e96peY7U=;
        b=KnqvTl/hOvxHhroZ27ow5WJGGDVdp+9ymSSvuCy57Vhmfysh51eLO7ubEPYguWLPFS
         Gh6Kg0LwpySo5HbnjSlGvItc8Pxd8US0lrMfLRHDB12iQd2xrxj+rnhOreCLqBbJ9eT1
         5uekOoqeTzl/FF4R+LVYWtYu1dadHTnOuw7w4sN6Cn/lrc0uxCQNoFnbz4jC/sHKTwPJ
         CWaTVoLW9qVtIylKxmamDKZ1FsWtIomRLQaulUn8WdR4bs5w0gmNgvKfg+5HnDcP6V4H
         FW3yzpFzbP59vwi2+LMN7ORZSjHi2oQgCuNCaJkdo3b6Vb714y2s+pxFnOG6p/6v2MsM
         5U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfwo/m+BVb3HeTZgm0uhdzbWmdU04ZuaJp+e96peY7U=;
        b=3H+6S+bp4qrMWeGWDIleU4p7GiyKfw+l1RaQXCLBvcA7ATEPRC3pAu6641VB+21CtP
         BYy9mbkL1NIlpilPabRMfADx7bxi+/3fCTiXBCPpjcf/zDu1/37tGVmLMpTlISUSXC+N
         QnqXfsvgdboyAEb+OzTiqdVHE12xbLnKV5afFrJNMZrVgNIFfos+vGEVAyJH/LwwGhZU
         YmAXang2BIXp28OceueEuPpOcIa7sAXf8FohOVSh6nzuNZX6NJrERJethv3wsbvb+ofj
         9/SrHOqHqL/U+4emm3hxdBjSajjzhwOaCzKdwbzBgvXlDA8yWxitWw22mVkYLJNENspa
         tqCg==
X-Gm-Message-State: AO0yUKWnH82W+smC8sMggMO0JCkO/ZaozCnEmlNuhxxsyRJpGdCQGlQ+
        lPKoSphvEtc8+K/roOHKL2E4TQ==
X-Google-Smtp-Source: AK7set/86GqNfiBkJYukL6BdcIi2iwtCSO2rGM3YkRAIX5XyhX/HHuKOUWJat0wWtXZJTqufE/Ejdg==
X-Received: by 2002:a17:906:3915:b0:87b:cdab:988e with SMTP id f21-20020a170906391500b0087bcdab988emr15398145eje.21.1676042388550;
        Fri, 10 Feb 2023 07:19:48 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090625c100b0088c224bf5adsm2517275ejb.147.2023.02.10.07.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:19:48 -0800 (PST)
Message-ID: <0de52122-30a4-a09d-bfef-5b4c173b81d9@linaro.org>
Date:   Fri, 10 Feb 2023 16:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 07/11] arm64: dts: qcom: sm8550: add port subnodes in
 dwc3 node
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-7-71fea256474f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-7-71fea256474f@linaro.org>
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



On 10.02.2023 16:02, Neil Armstrong wrote:
> Add ports subnodes in dwc3 node to avoid repeating the
> same description in each board DT.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 9910006c32aa..2914a12a1c89 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2469,6 +2469,25 @@ usb_1_dwc3: usb@a600000 {
>  				phys = <&usb_1_hsphy>,
>  				       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						usb_1_dwc3_hs: endpoint {
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						usb_1_dwc3_ss: endpoint {
> +						};
> +					};
> +				};
>  			};
>  		};
>  
> 
