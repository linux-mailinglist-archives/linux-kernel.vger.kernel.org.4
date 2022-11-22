Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C67363485C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiKVUiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiKVUiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:38:12 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994D114D14;
        Tue, 22 Nov 2022 12:38:10 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id e189so11845706iof.1;
        Tue, 22 Nov 2022 12:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c7DzvJvmU/QCKu7YfqpQASfMrO0u+3nVdwbz7+KvvCQ=;
        b=1zlVSbD60x3EJ5nNHnj0ED/t1gR6Eypr01LsJtHf6DvrxR+00IbBOwAEeAPi0Xng4X
         X3+fU0WIfAExGu9VhYVWPpsuiYapc1AcHJsd7TzddJAtCe130hbs2PkkBUSKyRR/UbpU
         VQV5c5V32Se+rOoiJUUOrd0pxV35L29uBxrxyv/OCrX9OANq059I7lxk0zoSUPDDdnPV
         EfllrjSJDSzks1K1wWQbSfiuFEPf258C+w2tR6dtCixSr0GB3jKGHAPktPmN/D94hOPi
         LS6QS7UAgtVxrTe1g3Wo8fawkRcHLUDjVKqnv0AKqgRfqwxEM4lVUsEOgZOyxb5m6Gf0
         ElpA==
X-Gm-Message-State: ANoB5pk9H7oLsl3sIj2KYaxzkTlr6tPjAZVNIUjSesGdGsoFkdtaQ+Pb
        6VSuTFcfuEfYzhNZOLZZZ/hQVpEuxQ==
X-Google-Smtp-Source: AA0mqf5ebl7BWmPxoFSBtUFhwg0yaIMNTy52rzFTD4AkAmwMM3MfTf7ZuXdiot8asA9+Fz9rtGQN/Q==
X-Received: by 2002:a5d:8b96:0:b0:6ce:ec71:4b96 with SMTP id p22-20020a5d8b96000000b006ceec714b96mr5104433iol.69.1669149489827;
        Tue, 22 Nov 2022 12:38:09 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b2-20020a029582000000b0037612be6830sm5606980jai.140.2022.11.22.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:38:09 -0800 (PST)
Received: (nullmailer pid 514978 invoked by uid 1000);
        Tue, 22 Nov 2022 20:28:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221121042545.421532-1-uwu@icenowy.me>
References: <20221121042545.421532-1-uwu@icenowy.me>
Message-Id: <166914591445.441329.7295488249527813864.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: timer: add a binding for LiteX Timer
Date:   Tue, 22 Nov 2022 14:28:34 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Nov 2022 12:25:44 +0800, Icenowy Zheng wrote:
> The LiteX SoC generator has a timer core, which by default only
> generates a simple down counter.
> 
> Add a DT binding for it.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  .../bindings/timer/litex,timer.yaml           | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/litex,timer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/timer/litex,timer.yaml: properties:litex,width: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/timer/litex,timer.yaml: properties:litex,width: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/timer/litex,timer.yaml: properties:litex,width: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221121042545.421532-1-uwu@icenowy.me

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

