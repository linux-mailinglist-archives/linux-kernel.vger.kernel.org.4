Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30275B7A98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiIMTLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIMTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2E061117;
        Tue, 13 Sep 2022 12:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371A961557;
        Tue, 13 Sep 2022 19:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A0FC433D6;
        Tue, 13 Sep 2022 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663096254;
        bh=ZLkA04AtkkAj7ap7zMdoFumFhJP+cqx7AqrTUyGLtUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAAYwTQw/R3F+U5kbFcMkrdU2Ok+RGyXFOLk6iv3JAn3tgAyUkjPejnQZpYI6AxTd
         nyEyf7yoId9ph2FMOs4mF6Ze+F8RG9EXrCXc9xiSWLhhUi2CqjGmJm9Umk0916CZ4W
         LiXoD8JBh0XY1aXOZAtS5bQDSSgC0/dB1jBHkq4sE6ssFHphpLYcyAmLNTBlInqP0x
         N9Z2miPgfyMq0Ym9wF+PcHa6hrINdHzNLn5dJNDeLLCvsA28nI3dWQU2BgTN3u6v+b
         aqE9rjIPdyIFBJQF/ngja81zJitblEp6oAV0OOwsQxVtFnr85mqjnPXoPXAk0NzdYM
         pfhDHg58u8ewQ==
Date:   Tue, 13 Sep 2022 14:10:51 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh@kernel.org, rafael@kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH 3/4] dt-bindings: thermal: Add qcom,qmi-tmd-device and
 qcom,tmd-device yaml bindings
Message-ID: <20220913191051.vx7leo6c4qbcuyns@builder.lan>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
 <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912085049.3517140-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:20:48PM +0530, Bhupesh Sharma wrote:
> Add qcom,qmi-tmd-device and qcom,tmd-device yaml bindings.

Looks like a duplicate of $subject.

> 
> Qualcomm QMI based TMD cooling device(s) are used for various

What is "TMD" an abbreviation of?

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

Looking at the implementation I see no relationship between the
individual instances (i.e. between the children of this node).

My suggestion is that you drop this top-level node and just list out
modem, adsp etc individually - which would mean that you can remove one
layer of indirection in the driver, as each instance would just need a
list of cooling-devices.

> +      compatible = "qcom,qmi-tmd-devices";
> +
> +      modem0 {

So you would move the compatible here.

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

I see no reason for splitting this into a separate binding.

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
> +
> +  qcom,instance-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Remote subsystem QMI server instance id to be used for communicating with QMI.
> +
> +patternProperties:
> +  "^tmd-device[0-9]?$":

So max 10 cooling devices per remote?

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

Afaict there are about 50 valid cooling devices listed in the driver.
Why limit this to these 7 here?

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

As written here this example is incomplete, as these nodes can't live on
their own.

But this is actually what I propose above.

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

This is a quite generic name, how about qcom,qmi-cooling.h?

> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
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

QMI cooling isn't the only thing dealing with "instance id" and all of
them would deal with instances ids of type modem, adsp, cdsp, slpi etc.

As such I think these are too generic, how about

QMI_COOLING_ADSP etc?

Regards,
Bjorn

> +
> +#endif
> -- 
> 2.37.1
> 
