Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BB45BB2BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIPTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIPTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:19:06 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98306B81C8;
        Fri, 16 Sep 2022 12:19:05 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id n83so7291426oif.11;
        Fri, 16 Sep 2022 12:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VSUsli+NytIctY1ygKKA0hjMdyhuIuRvkK4ZCkGJMxM=;
        b=zdDB1eAgQbzI8UdRUcot/jkTOOWNF901ouAYQwoVi9LUqSxRnfTPJOZkXBSheVw/w7
         NATaZM7UqUUPM0F0rwLbO1AWdwPe5mioeiQD2rYUQsrc+Hq7n/30lhZ0duGou2hNIkNg
         r/KAywbGh/uHUb+gF7WxaGYosm6gIA9WDxgiGnONPszW5TTOX7OibpEoI/FaSKjzRJ9y
         gmXnAQ9qq2JEBu1aVHm36q6fYj1Y5ZrSWgTkMq2yJQF0oZP0Dj4ds5EFoAiWFNypQNZm
         o0gw9wvmH3OJA6jovMfoo5UrLvrPHln5JYqf7NME8o+U7vCvsEt5oOLCqoVfhozChv/j
         c84w==
X-Gm-Message-State: ACrzQf3xAFU+UCQmLKdGsZ4fIUo9dPxyGl6O4QZYoZeLoXTFfRsV6WR8
        mIts3k1S7Jf2XFRKhs+1vA==
X-Google-Smtp-Source: AMsMyM7uTgiKhdX9RaMJ+7hc4ycY+sZFX/kej2v/t2DkPXchD8Hd/HLen6sX4ZYmf29qGxF2CLO+8A==
X-Received: by 2002:aca:3b89:0:b0:345:64e9:73c2 with SMTP id i131-20020aca3b89000000b0034564e973c2mr2967841oia.87.1663355944824;
        Fri, 16 Sep 2022 12:19:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z5-20020a05687041c500b0010e20d0b2e3sm3261064oac.44.2022.09.16.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:19:04 -0700 (PDT)
Received: (nullmailer pid 1112115 invoked by uid 1000);
        Fri, 16 Sep 2022 19:19:03 -0000
Date:   Fri, 16 Sep 2022 14:19:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 3/5] dt-bindings: arm: msm: Rework kpss-gcc driver
 Documentation to yaml
Message-ID: <20220916191903.GA1109317-robh@kernel.org>
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914142256.28775-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:22:54PM +0200, Christian Marangi wrote:
> Rework kpss-gcc driver Documentation to yaml Documentation.
> The current kpss-gcc Documentation have major problems and can't be
> converted directly. Introduce various changes to the original
> Documentation.
> 
> Add #clock-cells additional binding as this clock outputs a static clk
> named acpu_l2_aux with supported compatible.
> Only some compatible require and outputs a clock, for the others, set
> only the reg as a required binding to correctly export the kpss-gcc
> registers. As the reg is shared also add the required syscon compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 +++++++++++++++++++

Please move to bindings/clock/

Same comments as the other one.

>  2 files changed, 90 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml

> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> new file mode 100644
> index 000000000000..27f7df7e3ec4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
> +  to control L2 mux (in the current implementation) and provide access
> +  to the kpss-gcc registers.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,kpss-gcc-ipq8064
> +          - qcom,kpss-gcc-apq8064
> +          - qcom,kpss-gcc-msm8974
> +          - qcom,kpss-gcc-msm8960
> +          - qcom,kpss-gcc-msm8660
> +          - qcom,kpss-gcc-mdm9615
> +      - const: qcom,kpss-gcc
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: phandle to pll8_vote
> +      - description: phandle to pxo_board
> +
> +  clock-names:
> +    items:
> +      - const: pll8_vote
> +      - const: pxo
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - qcom,kpss-gcc-ipq8064
> +          - qcom,kpss-gcc-apq8064
> +          - qcom,kpss-gcc-msm8974
> +          - qcom,kpss-gcc-msm8960
> +then:
> +  required:
> +    - clocks
> +    - clock-names
> +    - '#clock-cells'
> +else:
> +  properties:
> +    clock: false
> +    clock-names: false
> +    '#clock-cells': false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> +
> +    clock-controller@2011000 {
> +      compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
> +      reg = <0x2011000 0x1000>;
> +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +      clock-names = "pll8_vote", "pxo";
> +      #clock-cells = <0>;
> +    };
> +
> +  - |
> +    clock-controller@2011000 {
> +      compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
> +      reg = <0x02011000 0x1000>;
> +    };
> +...
> +
> -- 
> 2.37.2
> 
> 
