Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576755BB2B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiIPTRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPTRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:17:19 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FEB6D1F;
        Fri, 16 Sep 2022 12:17:18 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id o204so7286770oia.12;
        Fri, 16 Sep 2022 12:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zCLPn/HwN1TiefL3Aqe+h98I2D++Or1my8mtlgETcOo=;
        b=7fLH8Eyh3AtcSPgce5RYt638GFsluBzTOMtwCxN4rkBifPed6l6pdNJ5xlh9hSDTlS
         lVW3mQ9Ozh2EjBKhpzj5MG2R4C4XnvJoBH1pc8MbHD5qapC84w3mbJB97M3lo7mCYoe7
         FD9vX0H/flNKLTWyTlRlJdPmswgFCwtbUC3eNiPeniHR0x3Z54E6cR9hh39Ttp1/Z+Ts
         UhLD1tOcjXIUVQYNNB8v2j0STN+5zKxU1kiGEMwQIrhgX83nYzuju/q7B/yYMHLKBYu5
         htPvCToIudbhX5nwA9at1bgvZtFTASGsIoahCAR1hGQ10s6kj/QaNOTVkNcJ8QwL3iNO
         xodA==
X-Gm-Message-State: ACgBeo0SkBLcUvNCcuwq11jrl9g5EyCCm5T/hxO54R62ETwvSSinOqCA
        AV4FGMk/N8/ruiImAIWxsg==
X-Google-Smtp-Source: AA6agR6eqlyPtQkJJrob+G2quqPI7sfi/F3WkYcp9vGnrwH1R0gDagteP5k5KoZaheCaltHQNzyJbg==
X-Received: by 2002:a05:6808:1987:b0:34f:c567:8592 with SMTP id bj7-20020a056808198700b0034fc5678592mr7079773oib.229.1663355836930;
        Fri, 16 Sep 2022 12:17:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm3696268oab.3.2022.09.16.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:17:16 -0700 (PDT)
Received: (nullmailer pid 1109013 invoked by uid 1000);
        Fri, 16 Sep 2022 19:17:15 -0000
Date:   Fri, 16 Sep 2022 14:17:15 -0500
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
Subject: Re: [PATCH v5 2/5] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
Message-ID: <20220916191715.GA1079300-robh@kernel.org>
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914142256.28775-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> Convert kpss-acc driver Documentation to yaml.
> The original Documentation was wrong all along. Fix it while we are
> converting it.
> The example was wrong as kpss-acc-v2 should only expose the regs but we
> don't have any driver that expose additional clocks. The kpss-acc driver
> is only specific to v1. For this exact reason, limit all the additional
> bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> v1 and also flag that these bindings should NOT be used for v2.

Odd that a clock controller has no clocks, but okay.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++

As this is a clock controller, please move to bindings/clock/

>  2 files changed, 93 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml

> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> new file mode 100644
> index 000000000000..5e16121d9f0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> +  There is one ACC register region per CPU within the KPSS remapped region as
> +  well as an alias register region that remaps accesses to the ACC associated
> +  with the CPU accessing the region.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kpss-acc-v1
> +      - qcom,kpss-acc-v2
> +
> +  reg:
> +    items:
> +      - description: Base address and size of the register region
> +      - description: Optional base address and size of the alias register region
> +
> +  clocks:
> +    items:
> +      - description: phandle to pll8_vote

Always a phandle (and arg), so that's redundant. Really, if there's not 
more to add that what clock-names says, then just 'maxItems: 2' is fine.

> +      - description: phandle to pxo_board
> +
> +  clock-names:
> +    items:
> +      - const: pll8_vote
> +      - const: pxo
> +
> +  clock-output-names:
> +    description: Name of the aux clock. Krait can have at most 4 cpu.
> +    enum:
> +      - acpu0_aux
> +      - acpu1_aux
> +      - acpu2_aux
> +      - acpu3_aux
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
> +        const: qcom,kpss-acc-v1
> +then:
> +  required:
> +    - clocks
> +    - clock-names
> +    - clock-output-names
> +    - '#clock-cells'
> +else:
> +  properties:
> +    clocks: false
> +    clock-names: false
> +    clock-output-names: false
> +    '#clock-cells': false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> +
> +    clock-controller@2088000 {
> +      compatible = "qcom,kpss-acc-v1";
> +      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +      clock-names = "pll8_vote", "pxo";
> +      clock-output-names = "acpu0_aux";
> +      #clock-cells = <0>;
> +    };
> +
> +  - |
> +    clock-controller@f9088000 {
> +      compatible = "qcom,kpss-acc-v2";
> +      reg = <0xf9088000 0x1000>,
> +            <0xf9008000 0x1000>;
> +    };
> +...
> -- 
> 2.37.2
> 
> 
