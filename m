Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008DA750773
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGLMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjGLMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:04:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03561993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:04:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992b27e1c55so836236966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689163477; x=1691755477;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vd8MWhBmnS04Aiq7zVFQ14FEWv2Wo1c1C/C8yhC8Id0=;
        b=le6F9keT9ljyZRT5LbljxlaxWV9KiNZrUSeA+19dTnDjTdmXMhX81547hhEgNeEDDF
         VbcmPtnmrFSi79AfNcRSZbQoPngqE2SvJAHz6iKdJdoCm1FKq/9ktwvIfQg+n09vtIcP
         hV4vqfPMWYvffaGUXXZG+/CSxcJaqZxE1eyEXsL2KA7gJyGqjFYeqEgtXJopeu5ln9UM
         Nxu6R3QwA/89rDDHwoZa/FObzIDipuAVIaE1TCSKwaEmJ+aurE+Jq2r7W1ggN/HVqOJJ
         1NQV+twNkAQrdsb73PMisqrTKmyiMIVh8/LEkQKOmkndnbnL27kHHsyDdYeYgcFvF6HN
         uWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689163477; x=1691755477;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd8MWhBmnS04Aiq7zVFQ14FEWv2Wo1c1C/C8yhC8Id0=;
        b=e5CAVTn2VLBalMx78ycFYeuzuqiTHTRaTOf7/Gl+4VuEKIzx/un1RbKyZG0JTNdjxp
         D2arqBGg6EU/rMEGZW3CFPqezuIOviUNWDrIO7Loym260zCgkY8LqW2UQ43gOQFLTb+M
         PeXTwAFYxmm46PMJ0hjjb+Q42T56zXctY9LQMvRwkda34779312hDm/815UNh3UtEd8y
         IUlspdXw9D6w0hpe81/Ui48+w8eKUuRqGzn/kx+Job9ALbXBPZVXUmBndilNaiE05PUn
         Xzc858sREPPD7/3g1FocsU318xIuWuFH9nEe+h0Azjbze+zSsmEaS+Ixyu83SP/10FKq
         07Kw==
X-Gm-Message-State: ABy/qLbWhJzsbZA8IAbWshZ9cBxRg6IGkgkt53X9rqANfvQrDzq+bUvU
        7Y9wB6540YA+32iVZg4P7gIbmw==
X-Google-Smtp-Source: APBJJlHnPryYP9w3uG+1r8eDpkL93+kzmPWH5LYuGcs+JVPilF1y9IKiQbU4pJxkZeGKp6ZOswvrYA==
X-Received: by 2002:a17:906:2202:b0:993:fe68:569c with SMTP id s2-20020a170906220200b00993fe68569cmr10347515ejs.6.1689163477302;
        Wed, 12 Jul 2023 05:04:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906271900b009786c8249d6sm2502172ejc.175.2023.07.12.05.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:04:36 -0700 (PDT)
Message-ID: <13555184-1708-befd-1f2c-5e6f7e04a6ce@linaro.org>
Date:   Wed, 12 Jul 2023 14:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/6] arm64: dts: qcom: ipq5332: Add USB related nodes
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689160067.git.quic_varada@quicinc.com>
 <1f99805b6437aa8d6eaa4663e8d27b98ee595f00.1689160067.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1f99805b6437aa8d6eaa4663e8d27b98ee595f00.1689160067.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 13:38, Varadarajan Narayanan wrote:
> Add USB phy and controller nodes.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4:
> 	Change node name
> 	Remove blank line
> 	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom qcom/ipq5332-rdp441.dtb' passed
> v1:
> 	Rename phy node
> 	Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
> 	Remove 'qscratch' from phy node
> 	Fix alignment and upper-case hex no.s
> 	Add clock definition for the phy
> 	Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
> 	in dwc3/core.c takes the frequency from ref clock and calculates fladj
> 	as appropriate.
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 53 +++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 8bfc2db..8118356 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -405,6 +405,59 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		usbphy0: usb-phy@7b000 {
> +			compatible = "qcom,ipq5332-usb-hsphy";
> +			reg = <0x0007b000 0x12c>;
> +
> +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> +			clock-names = "cfg_ahb";
> +
> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb2: usb2@8a00000 {

So you responded to my comments, wait ten minutes and send v2? No need
to wait for my feedback, right?

No, it's not ok. This is "usb", not "usb2". Are you saying you have
second device with the same address?

Best regards,
Krzysztof

