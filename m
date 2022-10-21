Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33603606CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJUBFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJUBFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:05:17 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAE7C06BD;
        Thu, 20 Oct 2022 18:05:12 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so910268otp.10;
        Thu, 20 Oct 2022 18:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecocDdlY9HD0dckWSi58lakyiwrmabIaEHlrxIT6WH0=;
        b=OPVrwIQWo1WfGYF/ZiSMdmCHZ6Pf0kEEVvbRGSx5p0G+IispvY/Ec3KYJt1rj0NLq1
         1HFWtIGgUm0wHlmDlm0bbkh5PbEdgAZVj3MX+TvNXlJKzHg6kFzJgYrN2AIx8G0kfGTz
         fezVS/vfsQiMdjzhr7wu0GF3zXcwqdGNBjFulXWX8wWOcMoNr1PxdLy1ed5h5hS1n4Zb
         Esu297TMxX8ysCuJDL7I+9I2luAUvoj9ndcXlZFUmYBIEGJ9X6BbH/DflEzP6s0wSEba
         9xV0Gzxd4iJHRY9dHvAr87sf3Jy8Y9HJICI34OQ8reh8esLhyhot2TGNf8akZWb99Nsw
         wsDQ==
X-Gm-Message-State: ACrzQf1iB7WdokcGhxCcFS70kDZSuYXZu1zZ0y1bw0WGaPwRIvvCbCNo
        QFHPZmTb/EkspAYyS134BMEdrKXAXg==
X-Google-Smtp-Source: AMsMyM6tI/gHEPMEf2U2laKjn7zNaO032RwU8qbztdEvs2i2nyjTJbwEI06MkMtaR9Ee3w9ADVSNZg==
X-Received: by 2002:a05:6830:1644:b0:661:8b9f:16c3 with SMTP id h4-20020a056830164400b006618b9f16c3mr8477769otr.235.1666314311664;
        Thu, 20 Oct 2022 18:05:11 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s64-20020acaa943000000b00353fe4fb4casm550566oie.48.2022.10.20.18.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:05:11 -0700 (PDT)
Received: (nullmailer pid 2100343 invoked by uid 1000);
        Fri, 21 Oct 2022 01:05:12 -0000
Date:   Thu, 20 Oct 2022 20:05:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: regulator: Add binding schema for
 mt6357 regulators
Message-ID: <20221021010512.GA1974104-robh@kernel.org>
References: <20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com>
 <20221005-mt6357-support-v3-3-7e0bd7c315b2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v3-3-7e0bd7c315b2@baylibre.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:20:47PM +0200, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add YAML schema for the MediaTek MT6357 regulators.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../regulator/mediatek,mt6357-regulator.yaml       | 292 +++++++++++++++++++++
>  1 file changed, 292 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
> new file mode 100644
> index 000000000000..8dc1245304be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
> @@ -0,0 +1,292 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6357-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6357 Regulators
> +
> +maintainers:
> +  - Fabien Parent <fabien.parent@linaro.org>
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +
> +description: |
> +  The MT6357 PMIC provides 5 BUCK and 29 LDO.
> +  Regulators and nodes are named according to the regulator type:
> +  buck-<name> and ldo-<name>.
> +  MT6357 regulators node should be sub node of the MT6397 MFD node.
> +
> +patternProperties:
> +  "^buck-v(core|modem|pa|proc|s1)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Properties for single BUCK regulator.
> +
> +    required:
> +      - regulator-name
> +      - regulator-min-microvolt
> +      - regulator-max-microvolt
> +
> +  "^ldo-v(aud28|aux18|cama|camd|cn18|cn28|cn33-bt|cn33-wifi|dram)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Properties for single LDO regulator.
> +
> +    required:
> +      - regulator-name
> +      - regulator-min-microvolt
> +      - regulator-max-microvolt
> +
> +  "^ldo-v(efuse|emc|ibr|io18|io28|ldo28|mch|rf12|rf18)$":

vf12 and rf18 are covered by regulator-fixed binding.



> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Properties for single LDO regulator.
> +
> +    required:
> +      - regulator-name
> +      - regulator-min-microvolt
> +      - regulator-max-microvolt
> +
> +  "^ldo-v(xo22|sim1,sim2|sram-others|sram-proc|usb33|xo22)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Properties for single LDO regulator.
> +
> +    required:
> +      - regulator-name
> +      - regulator-min-microvolt
> +      - regulator-max-microvolt
> +
> +additionalProperties: false

vfe28 is not listed, and this would cause an error if the schema was 
applied, but it is not as Krzysztof pointed out.


The MFD binding really needs to be converted so it can reference this 
schema. Otherwise, when it is, then all the issues have to be fixed.

Rob
