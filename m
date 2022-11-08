Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255F7620F15
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiKHL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiKHL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:28:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54D14B9BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:28:27 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g7so20821511lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4bF5b4uSR+PiYI+2EWUk5/vuKUO/CvUGHdFYYb5oFo=;
        b=eQF7DappUd2N5b981o9yxaOb99guRAo/uqgsDGSn0OHT6KEsr9JBcQZsnjJryaoGQu
         Lzd7refSfqCHKxgt/iggiTidS17wYvvC5/njGYkdC7HWK5XCGhl+Eogk13MTtcjuyj7w
         dDDkX4Lov7LGbMfUDGJqQdlf/PwCVg5LcwJ9numup5jCw/DOl9OZUsByaXBbjqTwsT+N
         YjxwKE0BouFoXlnRZnOaxl0uOnh8gTFc0/DyiJACGRQzvjg0M9eiPLWCNRjcV6KeTg64
         ORO/CyTHsaZuXplWrTB4h9ClRxhgLqDCGVJvYxeY4MqGlvWkP1SUxntZZmZmFEsL+YO9
         0Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4bF5b4uSR+PiYI+2EWUk5/vuKUO/CvUGHdFYYb5oFo=;
        b=duO/Mb7hCzZ1ZyKEzvZTD5gX+ywR8T+gMWikUW9/rigm5Q93jtbtna0YuRwdhrZEDA
         A+eVE9U51ZhDv+NpTQrBaLyrd2n/En55ZO9luaLNqouzMqJetlzB/0w9X3E/zSYKzWwz
         cyMPgm0eGlRgaddNPaOY/TtpdIZuUVfStyIKmVAFYV6X4vKCFjMr+5aCeQrsY+147Sd8
         XGO71Mj1ZW+2IG/ynRFc0Q+OTMFhsevoAmo9UqpIgLx6qcM+q7tgLj8BRs9nuACTNd88
         t08T25PtNi9S1PdOP8GBI8V5A6TsnHKdel1DLff+PMwdvirrn9v2citj4aOGVzpwfq9M
         Xp+w==
X-Gm-Message-State: ACrzQf2+7jFHsDC69Ik0AobN7PpVxCsPtijpQlUHp+Wlksek8HdWW7hm
        Aaz8MSHSEF1iKyfxzgJm39PUfQ==
X-Google-Smtp-Source: AMsMyM4yHGNR2Ct1uNwRmvEy3UsNs7Pg4gtxGic+wGvnBCnfwKCtFXI0kII1QiSaoswtC8dY0bIHIg==
X-Received: by 2002:a05:6512:150c:b0:4aa:f81e:6c17 with SMTP id bq12-20020a056512150c00b004aaf81e6c17mr20752532lfb.275.1667906906320;
        Tue, 08 Nov 2022 03:28:26 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e9255000000b002776ce08326sm1699183ljg.29.2022.11.08.03.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:28:25 -0800 (PST)
Message-ID: <fd9ee5df-0b9d-59c1-92c6-4874312aae1c@linaro.org>
Date:   Tue, 8 Nov 2022 12:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 5/7] ARM: dts: hpe: Add UDC nodes
Content-Language: en-US
To:     richard.yu@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-6-richard.yu@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103160625.15574-6-richard.yu@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 17:06, richard.yu@hpe.com wrote:
> From: Richard Yu <richard.yu@hpe.com>
> 
> Add support for the USB drivers on HPE GXP SoC.
> 
> Signed-off-by: Richard Yu <richard.yu@hpe.com>
> ---
>  arch/arm/boot/dts/hpe-gxp.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
> index cf735b3c4f35..60f2d3b15d90 100644
> --- a/arch/arm/boot/dts/hpe-gxp.dtsi
> +++ b/arch/arm/boot/dts/hpe-gxp.dtsi
> @@ -59,6 +59,36 @@
>  			ranges = <0x0 0xc0000000 0x30000000>;
>  			dma-ranges;
>  
> +			vuhc0: vuhc@80400000 {
> +				compatible = "hpe,gxp-vuhc", "syscon";
> +				reg = <0x80400000 0x80>;
> +			};
> +
> +			udc_system_controller: system-controller@80400800 {
> +				compatible = "hpe,gxp-udcg", "syscon";
> +				reg = <0x80400800 0x200>;
> +			};
> +
> +			gadget0: udc@80401000 {
> +				compatible = "hpe,gxp-udc";
> +				reg = <0x80401000 0x1000>;
> +				interrupts = <13>;
> +				interrupt-parent = <&vic1>;
> +				vdevnum = <0>;
> +				fepnum = <7>;
> +				hpe,syscon-phandle = <&udc_system_controller>;
> +			};
> +
> +			gadget1: udc@80402000 {
> +				compatible = "hpe,gxp-udc";
> +				reg = <0x80402000 0x1000>;
> +				interrupts = <13>;
> +				interrupt-parent = <&vic1>;
> +				vdevnum = <1>;
> +				fepnum = <7>;
> +				hpe,syscon-phandle = <&udc_system_controller>;

Based on your bindings explanation, UDC should be rather the device
with multiple children representing actual devices.

Best regards,
Krzysztof

