Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C237E63AAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiK1OPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiK1OPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:15:06 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6C220F8;
        Mon, 28 Nov 2022 06:15:02 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id m204so11670416oib.6;
        Mon, 28 Nov 2022 06:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rMDrKJM1JYq9frHiDAV6QjHrjgaT+Wd+P/w7Ou0pGrc=;
        b=FJMqrqaggu+xu84dmIACxHlCmKBZBO92yLaeIT6fVNe2woR7EQQurkeEYbMUhV2S6X
         aFJD79J9DgeOOiRrp5eEwEeYEsF8cMwquzOsgvyOdOIHvjiWGHijVqUv6jSDBQyZhGxy
         +pEDKxkmasI9nuwJf4K/9bVmB5/9aZr/XaceWnPr/A34kiaZz7S36P/oyI73tflIvf+I
         ZMD0HJvwfjbMTrM9zjmDbIbWK6zzZSZvGm5CT4TZa4zYlLMlAAo3fZP6RLn8OOaNgESi
         wz2UsetPI0ijOiBwKu0xyl3BRSUDy/y7km1z9f87h3evIIbiFeqlud7niACuk6FOMRpZ
         m2rg==
X-Gm-Message-State: ANoB5plBF2UjrxR8FIUdyCHi4Xh+L1u9wssNJQ5wj6GBvBoR/8T3EXI9
        98sxd1w+Z4HX2AegQ595Kw==
X-Google-Smtp-Source: AA0mqf7GaLmT+j6KXYSEaDabzZGvwPVlEA86w3Pu8lzi8pqWtO//a4CTd3PVxjYaNKvONEotUcwvLA==
X-Received: by 2002:a05:6808:22a1:b0:35b:8a39:ab76 with SMTP id bo33-20020a05680822a100b0035b8a39ab76mr8955735oib.196.1669644902054;
        Mon, 28 Nov 2022 06:15:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a056870e74c00b001375188dae9sm5946085oak.16.2022.11.28.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:15:01 -0800 (PST)
Received: (nullmailer pid 722965 invoked by uid 1000);
        Mon, 28 Nov 2022 14:15:00 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        asahi@lists.linux.dev
In-Reply-To: <20221128124216.13477-3-marcan@marcan.st>
References: <20221128124216.13477-1-marcan@marcan.st>
 <20221128124216.13477-3-marcan@marcan.st>
Message-Id: <166964486801.717655.2608444925832576232.robh@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Date:   Mon, 28 Nov 2022 08:15:00 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Nov 2022 21:42:14 +0900, Hector Martin wrote:
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml: properties:compatible:oneOf:0:items: 'anyOf' conditional failed, one must be fixed:
	[{'oneOf': ['apple,t8103-cluster-cpufreq', 'apple,t8112-cluster-cpufreq']}, {'const': 'apple,cluster-cpufreq'}] is not of type 'object', 'boolean'
	'apple,t8103-cluster-cpufreq' is not of type 'object', 'boolean'
	'apple,t8112-cluster-cpufreq' is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml: properties:compatible:oneOf:0:items: 'oneOf' conditional failed, one must be fixed:
	[{'oneOf': ['apple,t8103-cluster-cpufreq', 'apple,t8112-cluster-cpufreq']}, {'const': 'apple,cluster-cpufreq'}] is not of type 'object'
	['apple,t8103-cluster-cpufreq', 'apple,t8112-cluster-cpufreq'] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
		hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml: properties:compatible:oneOf:0:items: 'oneOf' conditional failed, one must be fixed:
	[{'oneOf': ['apple,t8103-cluster-cpufreq', 'apple,t8112-cluster-cpufreq']}, {'const': 'apple,cluster-cpufreq'}] is not of type 'object'
	Additional properties are not allowed ('oneOf' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml: ignoring, error in schema: properties: compatible: oneOf: 0: items
Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb:0:0: /example-0/soc/performance-controller@210e20000: failed to match any schema with compatible: ['apple,t8103-cluster-cpufreq', 'apple,cluster-cpufreq']
Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb:0:0: /example-0/soc/performance-controller@210e20000: failed to match any schema with compatible: ['apple,t8103-cluster-cpufreq', 'apple,cluster-cpufreq']
Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb:0:0: /example-0/soc/performance-controller@211e20000: failed to match any schema with compatible: ['apple,t8103-cluster-cpufreq', 'apple,cluster-cpufreq']
Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb:0:0: /example-0/soc/performance-controller@211e20000: failed to match any schema with compatible: ['apple,t8103-cluster-cpufreq', 'apple,cluster-cpufreq']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221128124216.13477-3-marcan@marcan.st

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

