Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB163BF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiK2Lhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiK2Lhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:37:31 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F819C16
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:37:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id k7so13105233pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jxt7XJEYGG/DEIW5w0DACPgROVLQHrBVTMD19NFNGTc=;
        b=g6xuAB7M1cwuReyoLI1Pz9XWawK/Zcxp6jAQagnKiAYgrPJw2PTWF/qIR5RdrQyTGd
         bldSnpkydHwp+/FKZdouI3BJpDHolO0ZJaGN/1Ec+Bw2WwKVeoM/5yRZRgjZiqekNrwU
         rrq06E/HLYzhu36U0VJM7R0VTIC/uXuoGLI1sqDqA/OEnCpgcVZHnQoFRYJMAh6otBLO
         G04xxQ9fqfjMvaYWJIwpo91wqar/qgGQ3K0NcZWczLFfmW3vbKsT2oXmxO2ar15J4kyL
         cVKhr4mNmD5gK57PgeXY8H0gJSLAEh/hUIpHl6a1g6skJhey2ojmFmbgGC7+LdIh7tMn
         QFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxt7XJEYGG/DEIW5w0DACPgROVLQHrBVTMD19NFNGTc=;
        b=1eTMphgm2kq0+HTUtVC9N8o+Zvj+iowkgZi7Af7sdvA4oZrLIp9hTCkhQ8UmxZTf0a
         DZV+nmS+EbA4cRw/etKIsvV6S6kqQTDuMq8cPGuXeh5CI9yvgLXXIEyem9r4o4+5xdtX
         zwOsO+xZf0Kb7HVJJEqruhum45rJKdejYGajIENvTO71OwAb6C3jD0N38EnjXb/yetEx
         8VK3lUvJLZJKWJMItbh2oCS+7cdnlslcIvpNzcT5DtA/cS0ZCHB0g+Vnu8uzx546k/fQ
         Wpn6Nwivp9D1gVQzB3qa52dMWrq6XR0hCb3JWbAOtrZ7bMmAyEfcceU9xbhiVBstpADk
         gewQ==
X-Gm-Message-State: ANoB5pnObo0IEGA+ex2CgxQc9uGt7KnDgMx7BJB7I7pDntAk97gPYYFO
        jq/HRg77f+4CANtdZJKhS1z4t9gGrZF+KoDTPZ/2Bg==
X-Google-Smtp-Source: AA0mqf49JkGCFX8uW+xdTRt6k8iounPurzJuv8HbDZZ8T0XZrXWRbIj9Uqnho0Ewn/u7YwNkOC3dNefGn8Nzl/EqDeY=
X-Received: by 2002:a17:90b:1d45:b0:218:6db5:fd98 with SMTP id
 ok5-20020a17090b1d4500b002186db5fd98mr60801030pjb.164.1669721850067; Tue, 29
 Nov 2022 03:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20221128142912.16022-1-marcan@marcan.st> <20221128142912.16022-3-marcan@marcan.st>
In-Reply-To: <20221128142912.16022-3-marcan@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 12:36:53 +0100
Message-ID: <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 at 15:29, Hector Martin <marcan@marcan.st> wrote:
>
> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
> The hardware has an independent controller per CPU cluster, and we
> represent them as unique nodes in order to accurately describe the
> hardware. The driver is responsible for binding them as a single cpufreq
> device (in the Linux cpufreq model).
>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../cpufreq/apple,cluster-cpufreq.yaml        | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> new file mode 100644
> index 000000000000..76cb9726660e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/apple,cluster-cpufreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC cluster cpufreq device
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
> +  the cluster management register block. This binding uses the standard
> +  operating-points-v2 table to define the CPU performance states, with the
> +  opp-level property specifying the hardware p-state index for that level.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - apple,t8103-cluster-cpufreq
> +              - apple,t8112-cluster-cpufreq
> +          - const: apple,cluster-cpufreq
> +      - items:
> +          - const: apple,t6000-cluster-cpufreq
> +          - const: apple,t8103-cluster-cpufreq
> +          - const: apple,cluster-cpufreq
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#performance-domain-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#performance-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // This example shows a single CPU per domain and 2 domains,
> +    // with two p-states per domain.
> +    // Shipping hardware has 2-4 CPUs per domain and 2-6 domains.
> +    cpus {
> +      #address-cells = <2>;
> +      #size-cells = <0>;
> +
> +      cpu@0 {
> +        compatible = "apple,icestorm";
> +        device_type = "cpu";
> +        reg = <0x0 0x0>;
> +        operating-points-v2 = <&ecluster_opp>;

To me, it looks like the operating-points-v2 phandle better belongs in
the performance-domains provider node. I mean, isn't the OPPs really a
description of the performance-domain provider?

That said, I suggest we try to extend the generic performance-domain
binding [1] with an "operating-points-v2". In that way, we should
instead be able to reference it from this binding.

In fact, that would be very similar to what already exists for the
generic power-domain binding [2]. I think it would be rather nice to
follow a similar pattern for the performance-domain binding.

> +        performance-domains = <&cpufreq_e>;
> +      };
> +
> +      cpu@10100 {
> +        compatible = "apple,firestorm";
> +        device_type = "cpu";
> +        reg = <0x0 0x10100>;
> +        operating-points-v2 = <&pcluster_opp>;
> +        performance-domains = <&cpufreq_p>;
> +      };
> +    };
> +
> +    ecluster_opp: opp-table-0 {
> +      compatible = "operating-points-v2";
> +      opp-shared;
> +
> +      opp01 {
> +        opp-hz = /bits/ 64 <600000000>;
> +        opp-level = <1>;
> +        clock-latency-ns = <7500>;
> +      };
> +      opp02 {
> +        opp-hz = /bits/ 64 <972000000>;
> +        opp-level = <2>;
> +        clock-latency-ns = <22000>;
> +      };
> +    };
> +
> +    pcluster_opp: opp-table-1 {
> +      compatible = "operating-points-v2";
> +      opp-shared;
> +
> +      opp01 {
> +        opp-hz = /bits/ 64 <600000000>;
> +        opp-level = <1>;
> +        clock-latency-ns = <8000>;
> +      };
> +      opp02 {
> +        opp-hz = /bits/ 64 <828000000>;
> +        opp-level = <2>;
> +        clock-latency-ns = <19000>;
> +      };
> +    };
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      cpufreq_e: performance-controller@210e20000 {
> +        compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
> +        reg = <0x2 0x10e20000 0 0x1000>;
> +        #performance-domain-cells = <0>;
> +      };
> +
> +      cpufreq_p: performance-controller@211e20000 {
> +        compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
> +        reg = <0x2 0x11e20000 0 0x1000>;
> +        #performance-domain-cells = <0>;
> +      };
> +    };

Kind regards
Uffe

[1]
Documentation/devicetree/bindings/dvfs/performance-domain.yaml
[2]
Documentation/devicetree/bindings/power/power-domain.yaml
