Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E5606843
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJTSgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJTSgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:36:00 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA4D1F5267;
        Thu, 20 Oct 2022 11:35:58 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id w74so672274oie.0;
        Thu, 20 Oct 2022 11:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu3QJgsLCoS+vfp9HN0FHUunihCVkS1IyOV5MfUmUG0=;
        b=3uy3xnmR6/2/2qP99keO84o5fGGNT/1h6/26CAxaGTmGdfe8pLIQXrxE4erDEIKEOl
         HbOE49l9nmQEmlrfP31+XJA1RctAvl84ryMfK28sXtZUOPRXkE2J6pjQsc673bM0AAOc
         OcVzQ3yVtjYhuO8awdCqiNkMdrWZoF7aicZc3mZO1lBK271lxVJpm9v9b4ImVRhj+oSE
         UGqQRb9XJLeWvbgFJqH3lUXApQdj7scmvtWLTqg0OwoX5S2e3hj/HRd5CUngplmzdE7E
         VjLByryTvSKNB07wjYcykjRtjn5Un+uy0xUuDtD62Iz+2w9N2mCF46ML8znWFXH8SwUO
         c/FA==
X-Gm-Message-State: ACrzQf2u+f0a7J/6oR7jrKyXhZFqlyZrUwzDzSrOy50OdmVEO69mF8o2
        epr9jWZzzNH2KDWfWVKncw==
X-Google-Smtp-Source: AMsMyM5qNUJ94xIXCMBvdhoSyM1ZAccL+fHVKAJh43zOfpXKNYwlRAh7/ryPkPhO5BnqcpXUyGHpGQ==
X-Received: by 2002:a05:6808:2215:b0:354:856f:f524 with SMTP id bd21-20020a056808221500b00354856ff524mr21731807oib.185.1666290957465;
        Thu, 20 Oct 2022 11:35:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a23-20020a05683012d700b006618fc435absm209622otq.43.2022.10.20.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:35:56 -0700 (PDT)
Received: (nullmailer pid 1675933 invoked by uid 1000);
        Thu, 20 Oct 2022 18:35:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        quic_rohkumar@quicinc.com, linux-kernel@vger.kernel.org,
        judyhsiao@chromium.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org, tiwai@suse.com, andersson@kernel.org,
        lgirdwood@gmail.com, agross@kernel.org, devicetree@vger.kernel.org,
        bgoswami@quicinc.com, perex@perex.cz,
        linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org,
        Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>,
        swboyd@chromium.org, quic_plai@quicinc.com
In-Reply-To: <1666271160-22424-1-git-send-email-quic_srivasam@quicinc.com>
References: <1666271160-22424-1-git-send-email-quic_srivasam@quicinc.com>
Message-Id: <166629081432.1672392.1870693936470507385.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: soundwire: Convert text bindings to DT Schema
Date:   Thu, 20 Oct 2022 13:35:57 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 18:36:00 +0530, Srinivasa Rao Mandadapu wrote:
> Convert soundwire text bindings to DT Schema format.
> 
> Update interrupt property items as per device tree,
> as it is not appropriately described in text file.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> ---
> This patch depends on:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42801e6185290d63691bd39cf8a3bba6cd5fe520
> Changes since V2:
>   -- Update commit message.
>   -- Add child node property.
>   -- Change file name.
>   -- Remove minIteams for few properties.
>   -- Remove redundant required properties.
>   -- Remove redundant description for wakeup-source property.
>   -- Update interrupt property items.
> Changes since V1:
>   -- Remove the status field in example.
>   -- Remove interrupt-names property in the required list.
>   -- Add the wakeup-source property.
> 
>  .../devicetree/bindings/soundwire/qcom,sdw.txt     | 214 ---------------------
>  .../bindings/soundwire/qcom,soundwire.yaml         | 184 ++++++++++++++++++
>  2 files changed, 184 insertions(+), 214 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


soundwire@3210000: 'codec@0,4' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3210000: interrupts: [[0, 155, 4]] is too short
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: 'codec@0,3', 'qcom,port-offset' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-block-group-count: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-block-pack-mode: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-hstart: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-hstop: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-lane-control: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-offset1: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-offset2: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-sinterval-low: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire@3230000: qcom,ports-word-length: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

soundwire-controller@3210000: interrupts: [[0, 298, 4]] is too short
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3210000: 'label' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3210000: 'label', 'wcd9380-rx@0,4' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb

soundwire-controller@3230000: interrupt-names:0: 'wakeup' was expected
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3230000: interrupt-names: ['core'] is too short
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3230000: interrupts-extended: [[1, 0, 297, 4]] is too short
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3230000: 'label', 'qcom,port-offset' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3230000: 'label', 'qcom,port-offset', 'wcd9380-tx@0,3' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb

soundwire-controller@3250000: interrupts: [[0, 202, 4]] is too short
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3250000: qcom,ports-block-pack-mode: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3250000: qcom,ports-offset1: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3250000: qcom,ports-offset2: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3250000: qcom,ports-sinterval-low: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

soundwire-controller@3250000: 'wsa8810-left@0,4', 'wsa8810-right@0,3' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb

soundwire-controller@3250000: 'wsa8810-left', 'wsa8810-right' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb

swm@c85: interrupts-extended: [[169, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb

swm@c85: interrupts-extended: [[175, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-lg-judyp.dtb

swm@c85: interrupts-extended: [[176, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-mtp.dtb

swm@c85: interrupts-extended: [[177, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dtb

swm@c85: interrupts-extended: [[178, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb

swm@c85: interrupts-extended: [[179, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dtb
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb

swm@c85: interrupts-extended: [[180, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb

swm@c85: interrupts-extended: [[181, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dtb

swm@c85: interrupts-extended: [[186, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb

swm@c85: interrupts-extended: [[189, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb

swm@c85: interrupts-extended: [[190, 20]] is too short
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb

swm@c85: qcom,ports-offset1: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
	arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dtb
	arch/arm64/boot/dts/qcom/sdm845-lg-judyp.dtb
	arch/arm64/boot/dts/qcom/sdm845-mtp.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
	arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dtb
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb

swm@c85: qcom,ports-offset2: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
	arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dtb
	arch/arm64/boot/dts/qcom/sdm845-lg-judyp.dtb
	arch/arm64/boot/dts/qcom/sdm845-mtp.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
	arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dtb
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb

swm@c85: qcom,ports-sinterval-low: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
	arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dtb
	arch/arm64/boot/dts/qcom/sdm845-lg-judyp.dtb
	arch/arm64/boot/dts/qcom/sdm845-mtp.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
	arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dtb
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb

swm@c85: 'wsa8810-left', 'wsa8810-right' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb

