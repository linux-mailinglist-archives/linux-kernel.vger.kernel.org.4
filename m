Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599974E9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGKJBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGKJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:01:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C317E56
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:01:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e5672d580so3165224a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689066067; x=1691658067;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0CkFjEb0OuX6JyslnIk0RBjlIpWepCB/X11vsuG/i8=;
        b=BfggbPHEM8qyNGf9X8z+x15SZn2y2QTAb7xh7ZQd48XBwYDhpfVXi02HZ+jYOcClBh
         KIjPUvvYorXEIL4Rf0eJN5pJoyE+HYozl4EjafDtxwx+v0AyUpcr7trCg0741fGzRmke
         QLaTaPToZo2L3jrucKqMddWIUmALa7Zgo3q4esHanSJxsM4REML7NDOSfJ0RSPPZm9uP
         AxpJBcfyp1JmbrYDFfVpq2VLyEJ6hRzkuiazVQS9o3n7dn9sw9fpozHxee9E3OMoGtTF
         EWBcsCp3bvoziCWmO1mLwUlqi305g24fMmWB8mmjZ3/QX/tmW5A2/0Nnno4ZFhsXgyQo
         jPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066067; x=1691658067;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0CkFjEb0OuX6JyslnIk0RBjlIpWepCB/X11vsuG/i8=;
        b=Ym27Tr+TBlHEUTrRWyropCkW50QcY68M1w/1l/+I5Z0LVN+guamyWZhSkXqY4KRzBt
         Orj9Yr4pE4ixl8TOafh8w0LNDuNOSSP6kYIRwsrz0Dzbrk0llt1clUPEgmpePL4ULsQf
         QoV631oOOX8OuMt+qwIhIsAay6o+d9GF91w+wzN0KAQO7nJacD8XAbhhIzleANcWuwS2
         4FeYKy5aZVaQFNL5xSfikOjh3dQE+W365IqSW/ta/yKLX6z4oNB6HtxnOnLF0KkBrvyL
         mEdwqFNWz9049BmqejJeeno/pkQAdenLOzM8AIT4zNYKaMLmvSM/z8OUTvptff92Oy7X
         bgDA==
X-Gm-Message-State: ABy/qLYA+DxSqCIIpzgoU8ikdLdsW09URyjSdhq86PozRsIvwG/Z8miE
        rkMiiU6Hg0sRLWU31dYl/s4Baw==
X-Google-Smtp-Source: APBJJlEyytDgOjuuRyspI4qoYl7w3PtoRhH9wmrQr4+Yr8WOELXXVdjiF3Ro5xKRaNdqoK5aVuWpug==
X-Received: by 2002:a17:906:77c7:b0:993:d782:a3db with SMTP id m7-20020a17090677c700b00993d782a3dbmr14084304ejn.16.1689066067522;
        Tue, 11 Jul 2023 02:01:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y24-20020a17090629d800b0098822e05539sm869474eje.191.2023.07.11.02.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:01:07 -0700 (PDT)
Message-ID: <ddd97ecd-bf4b-85c8-1f0b-8ca175799076@linaro.org>
Date:   Tue, 11 Jul 2023 11:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/6] arm64: dts: qcom: ipq5332: Add USB related nodes
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689065318.git.quic_varada@quicinc.com>
 <23b259b72c8f6faad99f09c37ac8b7b6b027cea1.1689065318.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <23b259b72c8f6faad99f09c37ac8b7b6b027cea1.1689065318.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 10:51, Varadarajan Narayanan wrote:
> Add USB phy and controller nodes.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v1:
> 	Rename phy node

I don't see any improvements.

> 	Change compatible from m31,ipq5332-usb-hsphy -> qcom,ipq5332-usb-hsphy
> 	Remove 'qscratch' from phy node
> 	Fix alignment and upper-case hex no.s
> 	Add clock definition for the phy
> 	Remove snps,ref-clock-period-ns as it is not used. dwc3_ref_clk_period()
> 	in dwc3/core.c takes the frequency from ref clock and calculates fladj
> 	as appropriate.
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 54 +++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 8bfc2db..c945ff6 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -405,6 +405,60 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		usbphy0: ipq5332-hsphy@7b000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

"phy"



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

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
> +

No need for blank line.

> +			reg = <0x08af8800 0x400>;
> +
> +			interrupts = <GIC_SPI 62 IRQ_


Best regards,
Krzysztof

