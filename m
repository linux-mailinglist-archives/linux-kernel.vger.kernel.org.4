Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7163DA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiK3QYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiK3QYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:24:16 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7932061B98
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:24:14 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n1so16793845ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbCew0BFNIRSFlp+k5uoeLKizvWgiWnblmCvWuyFg8Y=;
        b=ZxxkADj2eOo60vb97SjWhIokVfM6y1vjfalXar5jCWgqqLAOvG67JKzvYA+B0SIaLk
         CcmFI+Azi/SIwuQrHWYyHp2B7SIXToWyurBYoeSlzRMUO9LUZnl/XD8+B55hNYwO4scI
         H1CcRZ/a7U2u9QLi7NHc2IessDPYoc/O6I+Cg8ZN40qlo7jgsNfubf9badzn2e0YBq/L
         0XwTF4vAGFd52R+HgxS+SCx8+3PFDfFmC2SgKJ+VI/ZT4FscHF0eRUYeIMPukHiACCnR
         SXAOys/bSJFRdIbII2ZSQNXWZw0IaNyeV6HZtdyM1OA35HY0lImuJIUg0MtohfkLUlKC
         knRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbCew0BFNIRSFlp+k5uoeLKizvWgiWnblmCvWuyFg8Y=;
        b=qPTkrSwb2um2axoPmN6RLNZPeJNarFU/1G7VevTXrxkrpgfMjC31MaG/Xc8R9RrNsQ
         FQ/4YkN6Vf1cmwtfVxnIvTp1szU9VJuCKy9e+5opsptL/z50dVX/ZmLUxF5m7R3Rm+Y/
         UG2vB03oEkHOzQTgoPILyXnuyhPwSB2it9BMm+SovM+yeGaPWEBEtgtfYhg4+YEyt6xM
         DK3ZiAF9Tdn1dtuQ3Jqy5PFW/okkyZW45NAvRJQB30DSgBrdZLNHe3fh48tASO8cOv1v
         s2mLKZOhA5G07F4gUWh7ShUpAav45sCbVdYx4YweWIANvTphh6sXoLwwOBlwh7L6pmp7
         y29g==
X-Gm-Message-State: ANoB5pldpQhPcuuW7nck41sPTSX0wDiqrtvg7fS9HbUQR2lmVL7qYgJJ
        rroH50LST7Viyf6BXKYhdRYOjg==
X-Google-Smtp-Source: AA0mqf6C9iAEBZCoC56tNEM8JYTBJNnzYIkVMPp0xkGO/BTkobxq0of+g47UTD6XPcOGAOwbMW9PWg==
X-Received: by 2002:a05:651c:1a10:b0:277:5059:82c9 with SMTP id by16-20020a05651c1a1000b00277505982c9mr15621509ljb.218.1669825452692;
        Wed, 30 Nov 2022 08:24:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s8-20020a056512214800b004b4823f02b0sm306594lfr.152.2022.11.30.08.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:24:12 -0800 (PST)
Message-ID: <9412f6ff-1fd7-31b5-56a7-12bda174f7f6@linaro.org>
Date:   Wed, 30 Nov 2022 17:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for
 Qualcomm SMBCHG
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
 <20220808073459.396278-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808073459.396278-2-y.oudjana@protonmail.com>
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

On 08/08/2022 09:34, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 


> +      See Documentation/devicetree/bindings/power/supply/battery.yaml
> +
> +  interrupts:
> +    items:
> +      - description: Charger error
> +      - description: Charger inhibited
> +      - description: Charger precharge safety timer timeout
> +      - description: Charger charge safety timer timeout
> +      - description: Charger pre to fast charging switch threshold reached
> +      - description: Charger recharge threshold reached
> +      - description: Charger taper threshold reached

After discussing with Dmitry, it's current design of the PMIC (parent
device) so it's fine. We would need to make bigger refactoring of
drivers and bindings to change it to match other typical MFD PMICs. In
current state it's the only way to express device interrupts.

Two more comments below.

> +      - description: Charger charge termination threshold reached
> +      - description: Battery hot
> +      - description: Battery warm
> +      - description: Battery cold
> +      - description: Battery cool
> +      - description: Battery overvoltage
> +      - description: Battery low
> +      - description: Battery missing
> +      - description: Battery thermistor missing # unconfirmed
> +      - description: USB input undervolt
> +      - description: USB input overvolt
> +      - description: USB input source detected
> +      - description: OTG regulator failure
> +      - description: OTG regulator overcurrent
> +      - description: Automatic input current limiting done
> +      - description: USB ID pin changed
> +      - description: DC input undervolt
> +      - description: DC input overvolt
> +      - description: Power OK
> +      - description: Temperature shutdown
> +      - description: Watchdog timeout
> +      - description: Flash failure
> +      - description: OTST2 # unknown
> +      - description: OTST3 # unknown
> +
> +  interrupt-names:
> +    items:
> +      - const: chg-error
> +      - const: chg-inhibit
> +      - const: chg-prechg-sft
> +      - const: chg-complete-chg-sft
> +      - const: chg-p2f-thr
> +      - const: chg-rechg-thr
> +      - const: chg-taper-thr
> +      - const: chg-tcc-thr
> +      - const: batt-hot
> +      - const: batt-warm
> +      - const: batt-cold
> +      - const: batt-cool
> +      - const: batt-ov
> +      - const: batt-low
> +      - const: batt-missing
> +      - const: batt-term-missing
> +      - const: usbin-uv
> +      - const: usbin-ov
> +      - const: usbin-src-det
> +      - const: otg-fail
> +      - const: otg-oc
> +      - const: aicl-done
> +      - const: usbid-change
> +      - const: dcin-uv
> +      - const: dcin-ov
> +      - const: power-ok
> +      - const: temp-shutdown
> +      - const: wdog-timeout
> +      - const: flash-fail
> +      - const: otst2
> +      - const: otst3
> +
> +  otg-vbus:
> +    type: object

I think I did not comment about this one - this looks like regulator.yaml.

> +
> +    description:
> +      OTG regulator subnode.
> +
> +required:
> +  - compatible
> +  - reg
> +  - monitored-battery
> +  - interrupts
> +  - interrupt-names
> +  - otg-vbus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    battery: battery {
> +        compatible = "simple-battery";
> +
> +        charge-full-design-microamp-hours = <4070000>;
> +        charge-term-current-microamp = <100000>;
> +        voltage-min-design-microvolt = <3400000>;
> +        voltage-max-design-microvolt = <4400000>;
> +    };
> +
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        charger@1000 {
> +            compatible = "qcom,pmi8996-smbchg";
> +            reg = <0x1000>;
> +
> +            interrupts = <0x2 0x10 0x0 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x10 0x1 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x10 0x2 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x10 0x3 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x10 0x4 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x10 0x5 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x10 0x6 IRQ_TYPE_EDGE_RISING>,
> +                         <0x2 0x10 0x7 IRQ_TYPE_EDGE_RISING>,
> +                         <0x2 0x12 0x0 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x12 0x1 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x12 0x3 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x12 0x4 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x12 0x5 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x12 0x6 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x12 0x7 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x13 0x0 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x13 0x1 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x13 0x2 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x13 0x3 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x13 0x4 IRQ_TYPE_EDGE_RISING>,
> +                         <0x2 0x13 0x5 IRQ_TYPE_EDGE_RISING>,
> +                         <0x2 0x13 0x6 IRQ_TYPE_EDGE_FALLING>,
> +                         <0x2 0x14 0x0 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x14 0x1 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x16 0x0 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x16 0x1 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x16 0x2 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x16 0x3 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x16 0x4 IRQ_TYPE_EDGE_BOTH>,
> +                         <0x2 0x16 0x5 IRQ_TYPE_EDGE_BOTH>;
> +            interrupt-names = "chg-error",
> +                              "chg-inhibit",
> +                              "chg-prechg-sft",
> +                              "chg-complete-chg-sft",
> +                              "chg-p2f-thr",
> +                              "chg-rechg-thr",
> +                              "chg-taper-thr",
> +                              "chg-tcc-thr",
> +                              "batt-hot",
> +                              "batt-warm",
> +                              "batt-cold",
> +                              "batt-cool",
> +                              "batt-ov",
> +                              "batt-low",
> +                              "batt-missing",
> +                              "batt-term-missing",
> +                              "usbin-uv",
> +                              "usbin-ov",
> +                              "usbin-src-det",
> +                              "otg-fail",
> +                              "otg-oc",
> +                              "aicl-done",
> +                              "usbid-change",
> +                              "dcin-uv",
> +                              "dcin-ov",
> +                              "power-ok",
> +                              "temp-shutdown",
> +                              "wdog-timeout",
> +                              "flash-fail",
> +                              "otst2",
> +                              "otst3";
> +
> +            monitored-battery = <&battery>;
> +
> +            otg-vbus { };

Why empty?

Best regards,
Krzysztof

