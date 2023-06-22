Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290373A4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjFVPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjFVPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:21:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7730E7E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:20:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so10139977e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687447258; x=1690039258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9Nib1mjQ7HUVslIx9EtURK9z/yS/7mpl1B4Ox7/c/s=;
        b=g15tA4+CNcniYf/OcLJKZt2ymRKzXESCDfPItGGf4pXM5u5X0DdAweQxDe+YuHymKN
         HCYHcv4nhoMVPTvohDVk/2XxmWYeXhzfneaiKr082wMmGHZ2GKygtvUPPAEA524UAtxy
         bmcqY6FuJBxlZe8TchhILJkH1GYMoqDZZEBGqK2JPaVajS3v2KvZYyenL/6VbHYFgEeg
         VFfCihnzU9iwpvPRInH6mOxO8kkOUvkprS1mAxdvP3NFkz4XNjgeI9L8lqcM7R8ApVzi
         DdPjtgvLR6ALfJQsKO6aF4PCymSNHzbj+dW7iimcPMQfrmOhBVn6daWWPgAUTd+M+PGG
         6g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447258; x=1690039258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Nib1mjQ7HUVslIx9EtURK9z/yS/7mpl1B4Ox7/c/s=;
        b=JemZUUWP0TLll2rl8vrh4/vP1pjb9jPZzLJp9S4rsFUYnOMwHo1LAUZusk62c70uaF
         tCgZizG8AzI4kvKQqIjrsgFBb/jRKD3BOJ/OXWLiXvV/kyTh8N2lk/qOR0+xwojs0wvr
         qdqmnAV76TumHPYSyBxu3xYGazTO6qH0dyVIuhmQLbFn9Rnb7C5oPRpe/d+4NhJ9LaCp
         ijK0kf02sFJ8xGTU+ivFawm1DpbPlnEknvvWA+cCiQK6ejNvDTzmlipKTmh4q9xedKFl
         2PsvCYXcQVryYwcN4joq37F60dwatkaDa2M/16W6Rc8ag4xrw51SSx1Z/8orR40Y4VtW
         7/nw==
X-Gm-Message-State: AC+VfDwwBr4eeA2KflZegE8QNCZPdDWHFRnm6hEHM0Q5SiHFttEjqjRI
        SLAn3CRbLPw50JXL4ntpxSEG8A==
X-Google-Smtp-Source: ACHHUZ65em47HxJ5uP2ScMq4wC1WUQ8IS3y4pSQ5ePJuf0EI86kFZ1IXZW0p0liht+sUtKhW1HKrpA==
X-Received: by 2002:a19:6446:0:b0:4e9:bafc:88d0 with SMTP id b6-20020a196446000000b004e9bafc88d0mr11095123lfj.23.1687447257858;
        Thu, 22 Jun 2023 08:20:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402516700b00514bcbfd9e0sm4134273ede.46.2023.06.22.08.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:20:57 -0700 (PDT)
Message-ID: <218a76d9-d00b-3856-80b1-7d2f11b4ff1f@linaro.org>
Date:   Thu, 22 Jun 2023 17:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/7] arm64: dts: qcom: msm8916-samsung-fortuna: Add NFC
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, soc@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Joe Mason <buddyjojo06@outlook.com>
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
 <20230622000437.48367-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230622000437.48367-1-linmengbo0689@protonmail.com>
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

On 22/06/2023 02:05, Lin, Meng-Bo wrote:
> From: Joe Mason <buddyjojo06@outlook.com>
> 
> The Samsung Galaxy Ace 4, Core Prime and some Grand Prime have a
> Samsung S3FWRN5 NFC chip that works quite well with the s3fwrn5 driver
> in the Linux NFC subsystem.
> 
> The clock setup for the NFC chip is a bit special (although this
> seems to be a common approach used for Qualcomm devices with NFC):
> 
> The NFC chip has an output GPIO that is asserted whenever the clock
> is needed to function properly. On the A3/A5 this is wired up to
> PM8916 GPIO2, which is then configured with a special function
> (NFC_CLK_REQ or BB_CLK2_REQ).
> 
> Enabling the rpmcc RPM_SMD_BB_CLK2_PIN clock will then instruct
> PM8916 to automatically enable the clock whenever the NFC chip
> requests it. The advantage is that the clock is only enabled when
> needed and we don't need to manage it ourselves from the NFC driver.
> 
> Grand Prime SM-G530Y (fortunaltezt) has a NXP PN547, which is supported
> by the nxp-nci-i2c driver in mainline.
> 
> It seems to detect NFC tags using "nfctool" just fine, although more
> testing is difficult given there seem to be very few useful applications
> making use of the Linux NFC subsystem.
> 
> Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
> [Put i2c-nfc and NFC pinctrl into fortuna.dtsi to share it with other variants]
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

This and other SoB chains look like missing Co-developed-by.

> [Add pn547_nfc]
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---


> +		/* Available NFC chip varies depending on model variant */
> +		pn547_nfc: nfc@2b {
> +			compatible = "nxp,pn547", "nxp,nxp-nci-i2c";
> +			reg = <0x2b>;
> +
> +			interrupt-parent = <&tlmm>;
> +			interrupts = <21 IRQ_TYPE_EDGE_RISING>;
> +
> +			enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
> +			firmware-gpios = <&tlmm 49 GPIO_ACTIVE_HIGH>;
> +
> +			pinctrl-0 = <&nfc_default>;
> +			pinctrl-names = "default";
> +
> +			status = "disabled";
> +		};
> +
> +		s3fwrn5_nfc: nfc@27 {
> +			compatible = "samsung,s3fwrn5-i2c";
> +			reg = <0x27>;
> +
> +			interrupt-parent = <&tlmm>;
> +			interrupts = <21 IRQ_TYPE_EDGE_RISING>;
> +
> +			en-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
> +			wake-gpios = <&tlmm 49 GPIO_ACTIVE_HIGH>;
> +
> +			clocks = <&rpmcc RPM_SMD_BB_CLK2_PIN>;
> +
> +			pinctrl-0 = <&nfc_default>, <&nfc_clk_req>;
> +			pinctrl-names = "default";
> +
> +			status = "disabled";

Common part does not have two NFCs. It seems common part has zero
NFCs... or should be put into different file.

Best regards,
Krzysztof

