Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEF619F4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiKDRyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKDRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:54:20 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A02E9CE;
        Fri,  4 Nov 2022 10:54:18 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id r76so5890970oie.13;
        Fri, 04 Nov 2022 10:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8O78pONB73hi1zKNkgXxDhfNpzDliN4yTiKMnP0CVJo=;
        b=I/qtxdP2K6GWbtfkf1B9S+NYJwuyLzh+PkLBJ/UykEhNfblKSuzR4O2SxBHjBBaM0s
         VnpClXx+jqKzd3Wj10fEMUh0++h0xUaDnhyRFD/pBxtOXOh6IDij7f+debx9e+NTjZwl
         SDevXN4ukT+bKinWSVy9jxme2Hbpl0rXa7SALh+OJhABpuDUlv0Jg4P1VQlgKHp35njT
         FOgZf7BS9IgPO/g0zGzSQXhXpf6LYoL97teMJsYwQxEzeAEZjQR2XYWcEwrmwgrIM1ZD
         QUSPQVDEjFSbCgcmM+TKHz2hW78Rpm+H1U0GEJCQYR/9JOSojxuW0XyU6FuHB414HsaC
         wJVA==
X-Gm-Message-State: ACrzQf0qorVm6oPBUSuQHXfteKeuTjeC/Df1/gGdKZciLIv/r8oMLCaf
        9CY2xpGvIuLpY+sWTjve0A==
X-Google-Smtp-Source: AMsMyM7xXk4euDIh9SYT0vN2hxCzE5fvK6Pc+ND36HcC2QllT1s+sTl/+OWip6cXM7LcLKAyo/Zahw==
X-Received: by 2002:a05:6808:211b:b0:35a:4fb4:c3c6 with SMTP id r27-20020a056808211b00b0035a4fb4c3c6mr4979803oiw.141.1667584457901;
        Fri, 04 Nov 2022 10:54:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a4ade03000000b004982f2d3c03sm1344414oot.25.2022.11.04.10.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:54:17 -0700 (PDT)
Received: (nullmailer pid 2078503 invoked by uid 1000);
        Fri, 04 Nov 2022 17:54:15 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     marijn.suijten@somainline.org, konrad.dybcio@somainline.org,
        kernel@collabora.com, andersson@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
In-Reply-To: <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
References: <20221104142204.156333-1-angelogioacchino.delregno@collabora.com>
 <20221104142204.156333-2-angelogioacchino.delregno@collabora.com>
Message-Id: <166758411781.2066027.6365889663189109123.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
Date:   Fri, 04 Nov 2022 12:54:15 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 04 Nov 2022 15:22:03 +0100, AngeloGioacchino Del Regno wrote:
> Document bindings for the Qualcomm Ramp Controller, found on various
> legacy Qualcomm SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../qcom/qcom,msm8976-ramp-controller.yaml    | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,msm8976-ramp-controller.example.dtb: power-controller@b014000: '#power-domain-cells' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/power-domain.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

