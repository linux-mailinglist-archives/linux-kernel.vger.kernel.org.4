Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2B60D137
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJYQBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJYQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:01:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430318F92C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:01:46 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h10so8920949qvq.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5k4oXNi7wIr/yTUcNWF+k2ZgcBaXW2+/B9fhcI3NaxY=;
        b=fZoLICmcpxc7ya8YhyB8zyJ0hhZBpusQO1Te7bNyn7VgyIrTHa/zgg93BVM9FX79Qx
         yuiAJMyDN/1iRmtJ4dk3XD9iPp+OwWxHJYE8nJAe7t18FT6V8H/uifX0CqyDBrEy9Ird
         YHrUM04nT93ARAzXeNQYU+P6Iq87XYJiqVRKHkyk1edg0+gRCkQgSR5DgWKgjTG1fkpr
         Lmy6eqied/95AT5xejacqjO2ZIbFkJqgnrOArj5LCAPnHXezoXRkwDDo9UGqPsJradYI
         siHQfJ14o7g/0y2GnEk+1zSEC0pKPBZgxy7AB/Kagq0DGLpL24OaS3ehvdQnFtVw6tJj
         zKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5k4oXNi7wIr/yTUcNWF+k2ZgcBaXW2+/B9fhcI3NaxY=;
        b=HnKLhol96p66M1w5SuJ4WFVm88SMajRbEpsDT4pfe4BAwYr0glj8X1bh0Kw7fxZLjn
         4P6xEzY9OYow5VzW4L2Wd6oVGjexdWpC5NFiKlpCA+1voKPrMPTZZ0200B7mFYGclMmx
         ZSyMOsGH284CFxsj8VPO0ZICU6v+X8QDyZiON1QKLJSwM3nAkHAr2IV2Rl1qZs5DIXGY
         JB3Thf1FVAGlCv0sP/iWKlw6Vqw7u2hdXhdzX0n7fYdJtG0V8qG91Mb+GM20Wg0mmXMd
         M1UHvWniVm4QF33q8L3mDImn7QH5vW9oRLUpY6SPkuxrmXOFXIc4/XPnRc9yIre39hPK
         BJ0Q==
X-Gm-Message-State: ACrzQf1UtopB7SYl0wKeE00pN4q0iXxhivoWDEm3mON11W7sxNqDaOjG
        O7UR6KVtDTw/EtP2v+V0TywQ9g==
X-Google-Smtp-Source: AMsMyM6o6xBD+WYR2CO0j6dAkweiKItDjdgpLFpHCMkk6IrNKCkm8KiYfd7Yt33MY63MGZbyfL20aA==
X-Received: by 2002:ad4:594b:0:b0:4bb:6e7d:6c63 with SMTP id eo11-20020ad4594b000000b004bb6e7d6c63mr9749603qvb.86.1666713704935;
        Tue, 25 Oct 2022 09:01:44 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id k11-20020ac85fcb000000b0039953dcc480sm1794373qta.88.2022.10.25.09.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 09:01:44 -0700 (PDT)
Message-ID: <5c3126fb-8fdb-5163-95a8-136a4a7ee2ce@linaro.org>
Date:   Tue, 25 Oct 2022 12:01:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/5] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-3-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024043925.25379-3-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 00:39, Hector Martin wrote:
> This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
> The hardware has an independent controller per CPU cluster, and we
> represent them as unique nodes in order to accurately describe the
> hardware. The driver is responsible for binding them as a single cpufreq
> device (in the Linux cpufreq model).
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../cpufreq/apple,cluster-cpufreq.yaml        | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> new file mode 100644
> index 000000000000..b11452f91468
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/apple,cluster-cpufreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC cluster cpufreq device

Few nits, in general looks fine to me.

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
> +          - const: apple,t8103-cluster-cpufreq
> +          - const: apple,cluster-cpufreq
> +      - items:
> +          - const: apple,t6000-cluster-cpufreq
> +          - const: apple,t8103-cluster-cpufreq
> +          - const: apple,cluster-cpufreq
> +      - items:
> +          - const: apple,t8112-cluster-cpufreq

With the first one (t8103) - it's an enum.

> +          - const: apple,cluster-cpufreq
> +
> +  reg:
> +    maxItems: 1
> +    description: The register region for this CPU cluster DVFS controller

Drop description, quite obvious.

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
> +      cpufreq_e: cpufreq@210e20000 {

Node name: performance-controller

(cpufreq is rather Linux naming)

> +        compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
> +        reg = <0x2 0x10e20000 0 0x1000>;
> +        #performance-domain-cells = <0>;
> +      };
> +
> +      cpufreq_p: cpufreq@211e20000 {

The same.

> +        compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
> +        reg = <0x2 0x11e20000 0 0x1000>;
> +        #performance-domain-cells = <0>;
> +      };
> +    };

Best regards,
Krzysztof

