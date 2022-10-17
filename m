Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04946601C85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJQWk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJQWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:40:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BC7B29F;
        Mon, 17 Oct 2022 15:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78697B81B43;
        Mon, 17 Oct 2022 22:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ECBC433C1;
        Mon, 17 Oct 2022 22:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666046449;
        bh=/3nMyjfwYNbh6D7yFQ8tG56v/iKyuORuuufbK2reUGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+s92lE/wj1Cc66gkJmt2hnZFn8KBqhq2faVp7hHgiec5lNHLCkPI5mRPLLP9MMeZ
         +d+CY9X+Jhob1g7etZ9J7vyQmru/A9jVx2MOiEh1TBWUONR63I0eb9zQyOLjonF1qK
         y5ehqg41I99RARHtttQxWnLt9m/DjZN9L2Mai6Z4J7MZLiBnzjC7T9dzvGhtgBDGFm
         TnfNM/eI/sQfuJwhVgd+e/zV8xjdRp+f6b+Wva/8/kodw8n7knfjhLBQvKaNiyJ7uK
         9401JCy8POV/B2cPDEQy0u3xBuRuaD+mHIM5gbfHEJTP0XiccMSou3JpI9xh7+fSib
         xUBQOsGeM3Iqg==
Date:   Mon, 17 Oct 2022 17:40:46 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH v6] dt-bindings: qcom: document preferred compatible
 naming
Message-ID: <20221017224046.yxgpkhlqv4cykwc3@builder.lan>
References: <20220928152501.490840-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928152501.490840-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 05:25:01PM +0200, Krzysztof Kozlowski wrote:
> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> DT schema file documenting preferred policy and enforcing it for all new
> compatibles, except few existing patterns.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> 
> ---
> 
> Changes since v5:
> 1. Correct Bjorn's email.
> 2. Add tags.
> 
> Changes since v4:
> 1. Add qcm.
> 2. Add more qcom,ipq806x exceptions.
> 3. Add Rob's tag.
> 
> Changes since v3:
> 1. Add qcom,kpss-wdt-xxx to pattern for exceptions.
> 2. Add ipq806x entries to list of exceptions.
> 
> Changes since v2:
> 1. Narrow the expected pattern to be followed by dash '-' after model
>    number (msm8996-) or by two letters and a dash (sc8280xp-).
> 2. Add qcom,apss-wdt-xxx to list of exceptions.
> 3. Use comment instead of description in the oneOf list.
> 
> Changes since v1:
> 1. Add schema instead of readme (Rob).
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alex Elder <elder@linaro.org>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/arm/qcom-soc.yaml     | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> new file mode 100644
> index 000000000000..889fbfacf226
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom-soc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SoC compatibles naming convention
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description: |
> +  Guidelines for new compatibles for SoC blocks/components.
> +  When adding new compatibles in new bindings, use the format::
> +    qcom,SoC-IP
> +
> +  For example::
> +   qcom,sdm845-llcc-bwmon
> +
> +  When adding new compatibles to existing bindings, use the format in the
> +  existing binding, even if it contradicts the above.
> +
> +select:
> +  properties:
> +    compatible:
> +      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # Preferred naming style for compatibles of SoC components:
> +      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$"
> +      - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
> +
> +      # Legacy namings - variations of existing patterns/compatibles are OK,
> +      # but do not add completely new entries to these:
> +      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +      - enum:
> +          - qcom,gpucc-sdm630
> +          - qcom,gpucc-sdm660
> +          - qcom,lcc-apq8064
> +          - qcom,lcc-ipq8064
> +          - qcom,lcc-mdm9615
> +          - qcom,lcc-msm8960
> +          - qcom,lpass-cpu-apq8016
> +          - qcom,usb-ss-ipq4019-phy
> +          - qcom,usb-hs-ipq4019-phy
> +          - qcom,vqmmc-ipq4019-regulator
> +
> +      # Legacy compatibles with wild-cards - list cannot grow with new bindings:
> +      - enum:
> +          - qcom,ipq806x-gmac
> +          - qcom,ipq806x-nand
> +          - qcom,ipq806x-sata-phy
> +          - qcom,ipq806x-usb-phy-ss
> +          - qcom,ipq806x-usb-phy-hs
> +
> +additionalProperties: true
> -- 
> 2.34.1
> 
