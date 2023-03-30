Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A327A6D0535
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC3Mrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjC3Mri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:47:38 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0AD91;
        Thu, 30 Mar 2023 05:47:36 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so5508090fac.8;
        Thu, 30 Mar 2023 05:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680180455;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L9da3RztuEaK2R1chEVmMMY8g07HXvBf7GOsgks3EJU=;
        b=yffchRJdKbFaj9+VYWwsp2nxL8ydMpghLxJEXsYmCpQLMNGWyYGVo5qsZEllRx/Xtn
         jekAdmrU+QXI2cIbslWOUTAXlq5FlztxN847mowYQw6cpxjRMJaFxFhUKPWyklm0vHcS
         RhzcxI70kI5w3g6sS0G8ZJGcXzdL3qPMEeKEEAG1FWclbIjats5q1Qu8LrPZJh4LUTyq
         FEe93OQRr0nsPFlInV3F5qvCF6pCzhfIykGSFcvOjlpaBHerw/NwwZ2/9+y1puXTFEOW
         VB5prqwLmCyMe7L7t2pluErbTxpnYlp8YFqPeNG8A+58s/DDKV5TcdjLpEioBf6TJwlq
         HklQ==
X-Gm-Message-State: AAQBX9egDi3xd8TVQHhG7e2L1qaodqU023GNYyDLgmuBwg/IkCmGZWIN
        0C7EItQkdhGMt0+JwNhiNA==
X-Google-Smtp-Source: AKy350YghLak0zz/2mTljRWGf4IHaCIVgJjlCbZOiK6HdF0cXWTyybVCcWMwszMvSZpi09ldbg47XA==
X-Received: by 2002:a05:6870:14d6:b0:17e:6eaa:9452 with SMTP id l22-20020a05687014d600b0017e6eaa9452mr3189662oab.13.1680180455484;
        Thu, 30 Mar 2023 05:47:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zd40-20020a05687127a800b0017eccc3fed9sm4915077oab.47.2023.03.30.05.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:47:35 -0700 (PDT)
Received: (nullmailer pid 1824010 invoked by uid 1000);
        Thu, 30 Mar 2023 12:47:33 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     konrad.dybcio@linaro.org, linux-phy@lists.infradead.org,
        andersson@kernel.org, gregkh@linuxfoundation.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, vkoul@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, linux-usb@vger.kernel.org,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_wcheng@quicinc.com, devicetree@vger.kernel.org
In-Reply-To: <cb8f2ba0ff39951aeada479ed3895d19c9f72617.1680162377.git.quic_varada@quicinc.com>
References: <cover.1680162377.git.quic_varada@quicinc.com>
 <cb8f2ba0ff39951aeada479ed3895d19c9f72617.1680162377.git.quic_varada@quicinc.com>
Message-Id: <168017973612.1809972.2258406921826317163.robh@kernel.org>
Subject: Re: [PATCH v5 3/8] dt-bindings: usb: dwc3: Add IPQ9574 compatible
Date:   Thu, 30 Mar 2023 07:47:33 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2023 14:10:45 +0530, Varadarajan Narayanan wrote:
> Document the IPQ9574 dwc3 compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v5:
> 	- Restore removed constraints
> 
>  Changes in v4:
> 	- Update other relevant sections
> 	- Remove constraints not applicable to IPQ9574
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/cb8f2ba0ff39951aeada479ed3895d19c9f72617.1680162377.git.quic_varada@quicinc.com


usb2@60f8800: clock-names:0: 'core' was expected
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb

usb2@60f8800: 'dwc3@6000000' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb

usb2@60f8800: 'interrupt-names' is a required property
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb

usb2@60f8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb

usb2@60f8800: 'power-domains' is a required property
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb

usb3@100f8800: 'dwc3@10000000', 'reset-names' do not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

usb3@110f8800: 'dwc3@11000000', 'reset-names' do not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

usb3@110f8800: 'interrupt-names' is a required property
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

usb3@110f8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

usb3@110f8800: 'power-domains' is a required property
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

usb3@8af8800: 'dwc3@8a00000' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb

usb3@8af8800: 'interrupt-names' is a required property
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb

usb3@8af8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb

usb3@8af8800: 'power-domains' is a required property
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb

usb@4ef8800: 'interrupt-names' is a required property
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb

usb@4ef8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb

usb@4ef8800: usb@4e00000: Unevaluated properties are not allowed ('extcon' was unexpected)
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb

usb@6af8800: 'extcon' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

usb@6af8800: usb@6a00000: Unevaluated properties are not allowed ('extcon' was unexpected)
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
	arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb

usb@70f8800: 'interrupt-names' is a required property
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb

usb@70f8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb

usb@70f8800: 'power-domains' is a required property
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb

usb@70f8800: usb@7000000: Unevaluated properties are not allowed ('phy_mode' was unexpected)
	arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
	arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
	arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb
	arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dtb
	arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dtb

usb@7678800: 'interrupt-names' is a required property
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

usb@7678800: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

usb@7678800: 'power-domains' is a required property
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

usb@76f8800: 'extcon' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb

usb@76f8800: 'interrupt-names' is a required property
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb

usb@76f8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb

usb@76f8800: usb@7600000: Unevaluated properties are not allowed ('extcon' was unexpected)
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb

usb@79b8800: 'interrupt-names' is a required property
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

usb@79b8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

usb@79b8800: 'power-domains' is a required property
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

usb@8af8800: assigned-clock-rates: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb

usb@8af8800: assigned-clocks: [[4, 124], [4, 125], [4, 126]] is too long
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb

usb@8af8800: assigned-clocks: [[9, 186], [9, 158], [9, 159]] is too long
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb

usb@8af8800: 'interrupt-names' is a required property
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb

usb@8af8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb

usb@8cf8800: assigned-clock-rates: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb

usb@8cf8800: assigned-clocks: [[4, 131], [4, 132], [4, 133]] is too long
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb

usb@8cf8800: 'interrupt-names' is a required property
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb

usb@8cf8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb

usb@a6f8800: 'dr_mode' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dtb

usb@a6f8800: 'dwc3@a600000' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-sdx55-mtp.dtb
	arch/arm/boot/dts/qcom-sdx55-t55.dtb
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb

usb@a6f8800: usb@a600000: Unevaluated properties are not allowed ('maximum-spped' was unexpected)
	arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dtb

usb@a8f8800: assigned-clock-rates: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

usb@a8f8800: assigned-clocks: [[34, 92], [34, 91], [35, 64]] is too long
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

usb@a8f8800: usb@a800000: Unevaluated properties are not allowed ('extcon' was unexpected)
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

usb@c2f8800: clock-names:2: 'iface' was expected
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

usb@c2f8800: clock-names: ['cfg_noc', 'core', 'mock_utmi', 'sleep'] is too short
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

usb@c2f8800: clocks: [[34, 48], [34, 88], [34, 89], [34, 90]] is too short
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
	arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
	arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
	arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb

usb@c2f8800: 'power-domains' is a required property
	arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb

usb@f92f8800: 'interrupt-names' is a required property
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb

usb@f92f8800: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
	arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
	arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb

