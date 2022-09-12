Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE65B5DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiILP6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiILP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:58:24 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C557923BEF;
        Mon, 12 Sep 2022 08:58:22 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-12803ac8113so24530816fac.8;
        Mon, 12 Sep 2022 08:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zS3yyO6nCl1vnt2+U5h2vaJpvgKIH5YZrOhEZbFuxHU=;
        b=nakGdPijdCEQMU1qYn516B5hmEMlfAuhuo4O0m46XqT6MCxr6fWsgCHtoMegs1630o
         o7FXK3g5IXx7RIYg+Q/2VI3ughcPt3ed9rtAtKzrtvDmdH5Wk6H4SK6qTM7nFDVK5wu3
         tR9MZr6xx2WcdIBOGVom/vuVncU0QmAqqGlLghwK3uzq7brCduRUaOGEbPDJWltNgb2v
         Jv4uimlcnhWO3m37jYGR4Nz50d7mmjuViJ5eP2YuyMGQ1TVjQLFwNLFKTjNreawdeR04
         4srWUsgk8hRxYO8Yfyi5XNHtQnmIxiuDVO7U5EF9RHK9BiUwN2Kiwhd9DOQtNBhxV5u+
         1wwA==
X-Gm-Message-State: ACgBeo2EAlAsd8JAL1QE2n4DdpWjpa/F0Ru86W+oAk5eRNO91/v5GiDc
        84OpWF4WE0vEnDVq4rfmcGZfxEnXlw==
X-Google-Smtp-Source: AA6agR5Bbgn+aZKzFHPgJzhnCMuycnAj8Aw4zJ2DKHRCLHlWHnTyXwfjOfTLuF3fPvcNkWwYQL67Xw==
X-Received: by 2002:a05:6870:3285:b0:11f:5465:4943 with SMTP id q5-20020a056870328500b0011f54654943mr12039498oac.188.1662998301981;
        Mon, 12 Sep 2022 08:58:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s4-20020a4aa544000000b0044b22632d51sm4266748oom.2.2022.09.12.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:58:21 -0700 (PDT)
Received: (nullmailer pid 1373603 invoked by uid 1000);
        Mon, 12 Sep 2022 15:58:20 -0000
Date:   Mon, 12 Sep 2022 10:58:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        andersson@kernel.org, rafael@kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH 3/4] dt-bindings: thermal: Add qcom,qmi-tmd-device and
 qcom,tmd-device yaml bindings
Message-ID: <20220912155820.GA1362480-robh@kernel.org>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
 <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:20:48PM +0530, Bhupesh Sharma wrote:
> Add qcom,qmi-tmd-device and qcom,tmd-device yaml bindings.
> 
> Qualcomm QMI based TMD cooling device(s) are used for various
> mitigations for remote subsystem(s) including remote processor
> mitigation, rail voltage restriction etc.
> 
> Each child node represents one remote subsystem and each child
> of this subsystem in-turn represents separate TMD cooling device.
> 
> Cc: daniel.lezcano@linaro.org
> Cc: rafael@kernel.org
> Cc: andersson@kernel.org
> Cc: robh@kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../bindings/thermal/qcom,qmi-tmd-device.yaml |  78 +++++++++++
>  .../bindings/thermal/qcom,tmd-device.yaml     | 122 ++++++++++++++++++
>  include/dt-bindings/thermal/qcom,tmd.h        |  14 ++
>  3 files changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
>  create mode 100644 include/dt-bindings/thermal/qcom,tmd.h
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
> new file mode 100644
> index 000000000000..dfda5b611a93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-tmd-device.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/thermal/qcom,qmi-tmd-device.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description:
> +  Qualcomm QMI based TMD cooling device(s) are used for various
> +  mitigations for remote subsystem(s) including remote processor
> +  mitigation, rail voltage restriction etc.
> +
> +properties:
> +  $nodename:
> +    const: qmi-tmd-devices
> +
> +  compatible:
> +    items:
> +      - const: qcom,qmi-tmd-devices
> +
> +  modem0:
> +    $ref: /schemas/thermal/qcom,tmd-device.yaml#
> +
> +  adsp:
> +    $ref: /schemas/thermal/qcom,tmd-device.yaml#
> +
> +  cdsp:
> +    $ref: /schemas/thermal/qcom,tmd-device.yaml#
> +
> +  slpi:
> +    $ref: /schemas/thermal/qcom,tmd-device.yaml#
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/qcom,tmd.h>
> +    qmi-tmd-devices {
> +      compatible = "qcom,qmi-tmd-devices";
> +
> +      modem0 {
> +        qcom,instance-id = <MODEM0_INSTANCE_ID>;
> +
> +        modem0_pa: tmd-device0 {
> +          label = "pa";
> +          #cooling-cells = <2>;
> +        };
> +
> +        modem0_proc: tmd-device1 {
> +          label = "modem";
> +          #cooling-cells = <2>;
> +        };
> +
> +        modem0_current: tmd-device2 {
> +          label = "modem_current";
> +          #cooling-cells = <2>;
> +        };
> +
> +        modem0_skin: tmd-device3 {
> +          label = "modem_skin";
> +          #cooling-cells = <2>;
> +        };
> +
> +        modem0_vdd: tmd-device4 {
> +          label = "cpuv_restriction_cold";
> +          #cooling-cells = <2>;
> +        };
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml b/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
> new file mode 100644
> index 000000000000..38ac62f03376
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom,tmd-device.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/thermal/qcom,tmd-device.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm thermal mitigation (TMD) cooling devices
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description:
> +  Qualcomm thermal mitigation (TMD) cooling devices. Each child node
> +  represents one remote subsystem and each child of this subsystem in-turn
> +  represents separate cooling devices.
> +
> +properties:
> +  $nodename:
> +    pattern: "^(modem|adsp|cdsp|slpi[0-9])?$"

Node names are supposed to reflect the class of device, not instance.

> +
> +  qcom,instance-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Remote subsystem QMI server instance id to be used for communicating with QMI.

In general, we don't do instance indexes in DT. You'll need to explain 
where the value comes from.

> +
> +patternProperties:
> +  "^tmd-device[0-9]?$":

A cooling provider should have a standard node name. Not sure offhand if 
we defined one in the spec or not yet.

> +    type: object
> +    description:
> +      Subnodes indicating tmd cooling device of a specific category.
> +    properties:
> +      label:
> +        maxItems: 1
> +        description: |
> +          Remote subsystem device identifier. Acceptable device names -
> +          "pa" -> for pa cooling device,
> +          "cpuv_restriction_cold" -> for vdd restriction,
> +          "cx_vdd_limit" -> for vdd limit,
> +          "modem" -> for processor passive cooling device,
> +          "modem_current" -> for current limiting device,
> +          "modem_bw" ->  for bus bandwidth limiting device,
> +          "cpr_cold" -> for cpr restriction.
> +
> +      "#cooling-cells":
> +        const: 2
> +
> +    required:
> +      - label
> +      - "#cooling-cells"
> +
> +    additionalProperties: false
> +
> +required:
> +  - qcom,instance-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/qcom,tmd.h>
> +    modem0 {
> +      qcom,instance-id = <MODEM0_INSTANCE_ID>;
> +
> +      modem0_pa: tmd-device0 {
> +        label = "pa";
> +        #cooling-cells = <2>;
> +      };
> +
> +      modem0_proc: tmd-device1 {
> +        label = "modem";
> +        #cooling-cells = <2>;
> +      };
> +
> +      modem0_current: tmd-device2 {
> +        label = "modem_current";
> +        #cooling-cells = <2>;
> +      };
> +
> +      modem0_skin: tmd-device3 {
> +        label = "modem_skin";
> +        #cooling-cells = <2>;
> +      };
> +
> +      modem0_vdd: tmd-device4 {
> +        label = "cpuv_restriction_cold";
> +        #cooling-cells = <2>;
> +      };
> +    };
> +
> +  - |
> +    #include <dt-bindings/thermal/qcom,tmd.h>
> +    adsp {
> +      qcom,instance-id = <ADSP_INSTANCE_ID>;
> +
> +      adsp_vdd: tmd-device1 {
> +        label = "cpuv_restriction_cold";
> +        #cooling-cells = <2>;
> +      };
> +    };
> +
> +  - |
> +    #include <dt-bindings/thermal/qcom,tmd.h>
> +    cdsp {
> +      qcom,instance-id = <CDSP_INSTANCE_ID>;
> +
> +      cdsp_vdd: tmd-device1 {
> +        label = "cpuv_restriction_cold";
> +        #cooling-cells = <2>;
> +      };
> +    };
> +
> +  - |
> +    #include <dt-bindings/thermal/qcom,tmd.h>
> +    slpi {
> +      qcom,instance-id = <SLPI_INSTANCE_ID>;
> +
> +      slpi_vdd: tmd-device1 {
> +        label = "cpuv_restriction_cold";
> +        #cooling-cells = <2>;
> +      };
> +    };
> diff --git a/include/dt-bindings/thermal/qcom,tmd.h b/include/dt-bindings/thermal/qcom,tmd.h
> new file mode 100644
> index 000000000000..5ede4422e04e
> --- /dev/null
> +++ b/include/dt-bindings/thermal/qcom,tmd.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license.

> +/*
> + * This header provides constants for the Qualcomm TMD instances.
> + */
> +
> +#ifndef _DT_BINDINGS_THERMAL_QCOM_TMD_H_
> +#define _DT_BINDINGS_THERMAL_QCOM_TMD_H_
> +
> +#define MODEM0_INSTANCE_ID	0x0
> +#define ADSP_INSTANCE_ID	0x1
> +#define CDSP_INSTANCE_ID	0x43
> +#define SLPI_INSTANCE_ID	0x53
> +
> +#endif
> -- 
> 2.37.1
> 
> 
