Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA02A69B93D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBRKKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBRKKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:10:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8371D37542
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:10:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i28so1126001eda.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HF0DcS0ZS+01AvWrN70KNxaOHsB2n9jllNRuloPze0Y=;
        b=kl5doSpWXi3Kei5ZgZG95krT8GMZx2JqflbaScqDaqQydetrFulbPqz0JWomcjDEjX
         JcxfQ5ztullNQFpgR/zCaOwWMOXQO+O3m+oXhfsay0TaNbCDDkSXU+8y0W31n2WDMXu4
         9aD0Hj4ihvgwTzGkACrNT1lvy7EagPt4ReyW6QOF4ArzUJsP1BAS/qv0y8qc2J+8ZSSI
         B0iG+37MK6cUqvk1JAA076ynwqYpGsMcSenViIZquQct0DUW7r2yInSgu4X0Ez2Lefa4
         mpEw91OB44Gv8jn/E0mjeGbuZBjAqKLVvyIpd5e/QRCRWW0UGrQjarYAvzOUxMLZpDs3
         kN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HF0DcS0ZS+01AvWrN70KNxaOHsB2n9jllNRuloPze0Y=;
        b=U9e65wxoEx8H/IuaSvSahsyO/27+/8tC0J6dE7pQT/Po7EISW1H4pV3ishtrqCpq9/
         SSVWg0RsH3Al6aPSYZc1UbQMPNO9mrpRbdubf3CSkSKo08E9CQUs1wQtwie8BQrz4y7f
         5u5QuQnUYvP7GqeMATj5oYANT/1ysMvjMb4JszukwXJn17fkJxmR6oYITMusM0QffOfq
         tlisyzsdpF365nfj1r4MArep8Adn2xT4EnSnujauRSukNQKejGUH2AHbb4UN0f24cVy8
         EPw3i3J7xlfRL0utSB0Q5/GpAcbebn8xWnbdbO2TBSy7VDGWLCzuDNEJCZsKpWamHtvX
         R24Q==
X-Gm-Message-State: AO0yUKU3v2Y0uFoLCdAWw7+yhNgLF2pfg+/YONbMO4+wrYje8kAuYIvL
        rPi6yFP3pMP/+G9zuTYt8tUi4A==
X-Google-Smtp-Source: AK7set8Oz5135GMjU3IWKlGah+gmHtwLX1ikikSRnXZqIU/R0XwcVJQ4kDyRpW7TI+dkkdbXVFovNQ==
X-Received: by 2002:aa7:c051:0:b0:4ac:d30d:c3a3 with SMTP id k17-20020aa7c051000000b004acd30dc3a3mr2891721edo.32.1676715028023;
        Sat, 18 Feb 2023 02:10:28 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e9-20020a50a689000000b004accf3a63cbsm3318177edc.68.2023.02.18.02.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 02:10:27 -0800 (PST)
Message-ID: <dc708865-6005-760f-cbb0-cb2d1d989b9d@linaro.org>
Date:   Sat, 18 Feb 2023 11:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 3/5] ARM: dts: hpe: Add I2C Topology
To:     nick.hawkins@hpe.com, verdun@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsa@kernel.org
References: <20230217155054.99757-1-nick.hawkins@hpe.com>
 <20230217155054.99757-4-nick.hawkins@hpe.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217155054.99757-4-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 16:50, nick.hawkins@hpe.com wrote:
> diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
> index cf735b3c4f35..3bc071149bae 100644
> --- a/arch/arm/boot/dts/hpe-gxp.dtsi
> +++ b/arch/arm/boot/dts/hpe-gxp.dtsi
> @@ -122,6 +122,131 @@
>  				interrupts = <6>;
>  				interrupt-parent = <&vic0>;
>  			};
> +
> +			sysreg_system_controller: syscon@f8 {
> +				compatible = "hpe,gxp-sysreg", "syscon";
> +				reg = <0xf8 0x8>;
> +			};
> +
> +			i2c0: i2c@2000 {
> +				compatible = "hpe,gxp-i2c";
> +				reg = <0x2000 0x70>;
> +				interrupts = <9>;
> +				interrupt-parent = <&vic0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +				hpe,sysreg = <&sysreg_system_controller>;
> +				clock-frequency = <100000>;

clock-frequency is a property of the board. If it is fixed in the SoC,
then make it fixed in the driver and there is no point for this property
in DT.

Best regards,
Krzysztof

