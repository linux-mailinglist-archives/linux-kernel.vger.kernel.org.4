Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52BE5BFAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiIUJ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIUJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:26:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F58E453
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:26:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a2so8185131lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ezjLW8T0NnEvujrr+yzCxs0Deq1uyAkeS9ezzI+wOlY=;
        b=sK8YpVlFRQHVPWV/D2oTHdullgr0ojORZlODvaC0y5qrYolxrJNQN/VcgFepuYOOVF
         9XzaSs1eBp+6XfFjMH6CwjqjriUOtPTSLtxtMMa10Dm5gawSXBO9YrS87Z7N6dqz83QU
         +mvP6MZm4VjD11quHXnPwd8Nl+sO/IDL7PGb+fFM2Q9kPA2QOZzSP0v4ju1W63rvSsK9
         1jHqXNDT1fSn//4eN12bTKbuxMH96XAzatxgylqGStavXz3AC/RRamnSr/f/x3XsmasM
         +A7Mj5TpRHkH67k+fMl3obmniN/ViMfReMVR0tjwXBcq5Ss63imtx9fsfkyKPZaQ+O80
         UjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ezjLW8T0NnEvujrr+yzCxs0Deq1uyAkeS9ezzI+wOlY=;
        b=BxngxHhoFdkIpMK6w1ZnZYkPqTPtjlMTbwN+PPWCXE6ejJocuaY9NTsNFX2BX8QK7R
         zMiU67rXzxWKw3trwSKfyZ30kgWepdBqXsEb/fIpbun21ScWXbVpk+nUvAedR9EoAg6Y
         blxbxP7qobKhUPnK+wnoS91eJn2u3afzGnfSSxfh+LRhOHPQ/3Q5ypqTbJgCaPReguz5
         ZiJXYlEEi3Ho2i943J9+FdlOEXpifQJ33W9Bu9wNVUXqeyLKUQ/VX8+c/N8lZqlnDB9Q
         wxm/7ztsJBdHhgj4Ws6AIgxqyQbChNm/MttDL1gPt4mCn2sCZY9XFtBzhZiDugXYOUOi
         YApg==
X-Gm-Message-State: ACrzQf1w7M5P1E0Sjz7wHOUPTbaVaZKQa0udDukhKr9CvHyqhL3Nlpfk
        J7MxOwEjSf1TXjIO1DXjUsp1hg==
X-Google-Smtp-Source: AMsMyM4q9W7PZ0FNmBge0OKP6Vy5oQjiloIoQojkEylWDKl/E9ETnWbWzbw58onHa6PBPZqj2juazA==
X-Received: by 2002:a05:6512:15a0:b0:49b:1eba:89d4 with SMTP id bp32-20020a05651215a000b0049b1eba89d4mr9070467lfb.188.1663752364597;
        Wed, 21 Sep 2022 02:26:04 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o16-20020a05651205d000b00492aefd73a5sm353258lfo.132.2022.09.21.02.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:26:03 -0700 (PDT)
Message-ID: <df9ff0bd-ad0e-4b5b-859d-dd913628edc8@linaro.org>
Date:   Wed, 21 Sep 2022 11:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org>
 <CA+V-a8t3ukpa1PNz=5fP+BTjWkFJmwDo_EJJYjO9YctF2=K1Vg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8t3ukpa1PNz=5fP+BTjWkFJmwDo_EJJYjO9YctF2=K1Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 11:20, Lad, Prabhakar wrote:
>>
>> What do you mean? Macros support string concatenation and simple
>> arithmetic like adding numbers. I just tested it.
>>
> I did try the below:
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> index 689aa4ba416b..0f923c276cd3 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> @@ -8,6 +8,8 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/r9a07g043-cpg.h>
> 
> +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr na
> +
>  / {
>      compatible = "renesas,r9a07g043";
>      #address-cells = <2>;
> @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
>              compatible = "renesas,r9a07g043-ssi",
>                       "renesas,rz-ssi";
>              reg = <0 0x1004a000 0 0x400>;
> -            interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +            interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
>                       <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
>                       <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
>                       <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
> 
> This worked as expected, but couldn't get the arithmetic operation
> working. Could you please provide an example?

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index ff6aab388eb7..0ecca775fa3f 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/r9a07g043-cpg.h>
 
+#define SOC_PERIPHERAL_IRQ_NUMBER(na)  (na + 32)
+#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr SOC_PERIPHERAL_IRQ_NUMBER(na)
 / {
        compatible = "renesas,r9a07g043";
        #address-cells = <2>;
@@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
                        compatible = "renesas,r9a07g043-ssi",
                                     "renesas,rz-ssi";
                        reg = <0 0x1004a000 0 0x400>;
-                       interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+                       interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,



Or any other method like that....

Best regards,
Krzysztof

