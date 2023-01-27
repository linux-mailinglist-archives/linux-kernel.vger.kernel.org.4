Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4303467F051
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjA0VTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjA0VTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:19:47 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E6B1630A;
        Fri, 27 Jan 2023 13:19:46 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id m18-20020a05683026d200b0068661404380so2620804otu.2;
        Fri, 27 Jan 2023 13:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMBH4OaEcfhMng/uMsZ7qj6zrdL3KO0FA5Oo+Mfrzqk=;
        b=TCKBWOfdroj8IeVAF09OYV7f+pthOfPJ8CpNrW4qnYTIAFZc9aAOyRGjUnzH4x1gg4
         kt4kmG9DnykjgHYtuRuq32HHXx7uCOfLBOKCAT6wnw0y4LJASEtTb/R9skdmKrQuTgeA
         tp34Flqi5HHZiGROfVDkZMMv5c804rghlpA4Nv7PH9m071doKhoZEF6MJpIPbCQNV4k3
         YOMceCtWVutjgGgPUYJ62zphGH53yyT2Wh3w+TqByHhePXLIEGX9YF2qSKMOTUP8D7f2
         8BWPjqkxANQx5166LbXzjWJzmO1w4T8o1jlB/vJM16Kr0gZzbKar8/JjpLRwxyeRsjyL
         HURA==
X-Gm-Message-State: AFqh2koUyXQ8LBfaiwJHZMjbblmyz6ZqGdbL05utNYi0fKLqUVH+v25U
        kkkmckL/U2B84Pqx68qBoA==
X-Google-Smtp-Source: AMrXdXthH4OPTLyVNiYD9/v8bT3CTUREw48g/jXBA27Bcqp8oBqcG1VsOfg0TD/wsmn6S/zokuyvkw==
X-Received: by 2002:a9d:4c8a:0:b0:670:6419:c3ee with SMTP id m10-20020a9d4c8a000000b006706419c3eemr20672876otf.16.1674854385834;
        Fri, 27 Jan 2023 13:19:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z5-20020a9d62c5000000b0068bba70ab10sm143815otk.62.2023.01.27.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:19:45 -0800 (PST)
Received: (nullmailer pid 699757 invoked by uid 1000);
        Fri, 27 Jan 2023 21:19:44 -0000
Date:   Fri, 27 Jan 2023 15:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 1/8] dt-bindings: phy: Add qcom,snps-eusb2-phy schema
 file
Message-ID: <20230127211944.GA696408-robh@kernel.org>
References: <20230126131415.1453741-1-abel.vesa@linaro.org>
 <20230126131415.1453741-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126131415.1453741-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:14:08PM +0200, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
> for the new driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v2 version of this patch was here:
> https://lore.kernel.org/all/20230126124651.1362533-2-abel.vesa@linaro.org/
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * dropped the "ref src" clock
>  * dropped the usb-repeater property
> 
>  .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> new file mode 100644
> index 000000000000..49a5dad486c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +

Remove blank line

> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,snps-eusb2-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes

> +
> +title: Qualcomm SNPS eUSB2 phy controller
> +
> +maintainers:
> +  - Abel Vesa <abel.vesa@linaro.org>
> +
> +description:
> +  eUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8550-snps-eusb2-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: ref
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +
> +  resets:
> +    maxItems: 1
> +    description:
> +      Phandle to reset to phy block.

Drop description.

> +
> +  vdd-supply:
> +    description:
> +      Phandle to 0.88V regulator supply to PHY digital circuit.
> +
> +  vdda12-supply:
> +    description:
> +      Phandle to 1.2V regulator supply to PHY refclk pll block.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - vdd-supply
> +  - vdda12-supply
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sm8550.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/clock/qcom,tcsrcc-sm8550.h>
> +
> +    usb_1_hsphy: phy@88e3000 {
> +        compatible = "qcom,sm8550-snps-eusb2-phy";
> +        reg = <0x88e3000 0x154>;
> +        #phy-cells = <0>;
> +
> +        clocks = <&rpmhcc RPMH_CXO_PAD_CLK>,
> +                 <&tcsrcc TCSR_USB2_CLKREF_EN>;
> +        clock-names = "ref_src", "ref";

Doesn't match the schema.

> +
> +        vdd-supply = <&vreg_l1e_0p88>;
> +        vdda12-supply = <&vreg_l3e_1p2>;
> +
> +        resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +    };
> -- 
> 2.34.1
> 
