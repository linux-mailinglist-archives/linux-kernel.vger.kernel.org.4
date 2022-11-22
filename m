Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD163485B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiKVUiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiKVUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:38:10 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E11403E;
        Tue, 22 Nov 2022 12:38:08 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id o17so1597113ilg.12;
        Tue, 22 Nov 2022 12:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IxhuJmnEARIWlXQpcwKPNDNfyA1cKV7mmycNRMiAUnw=;
        b=74vPUyU7EiL3Ov/TjfMV35quBWVMCq81bQethB48+H5+lrZgRgdvGXB5BCUdJZdtVG
         xFgnOnXiahVt/X7i+69SVUcEqYK4ivx7HrhnJAq2K+w2yjUjp/Jj75AHMtqjJrVAeQy/
         Zme81J9MFH9ic4urDGptRscoIdSMEPf9xtI0pyw3I4lsXtVHshiTjeING4NlfCreGdQb
         E3njP2b41RX+rWQiAin4lceYaTabL2JIHuEHH/GM7f1zS3JgZvnyf/v8Ccp/TVFYNX81
         foWeB2aY4Vkp44ncoHWvUDt45Jc4rxT/TFRTpS4IG3zHBxqQVzdzgeilx6BJicaRSCBR
         V5og==
X-Gm-Message-State: ANoB5pkgQv61iqHS1Pxv7sDYGbAhCbWeRWpjB0ViGRp0KAmF+QrI5YPI
        Ve4e9QJaM5Usg+YBwvChVE04HyiUJw==
X-Google-Smtp-Source: AA0mqf7szvteT0DhoEE8ltblx51SieTice/p6rYK2egqQEWY2mUi7XDAmn+bUokAsQxJd8B3HHq92g==
X-Received: by 2002:a92:cc4c:0:b0:2fc:81e8:db26 with SMTP id t12-20020a92cc4c000000b002fc81e8db26mr3822882ilq.73.1669149488075;
        Tue, 22 Nov 2022 12:38:08 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u14-20020a056e02110e00b00302c31956b2sm2302289ilk.10.2022.11.22.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:38:07 -0800 (PST)
Received: (nullmailer pid 514983 invoked by uid 1000);
        Tue, 22 Nov 2022 20:28:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Marvin Lin <milkfafa@gmail.com>
Cc:     kflin@nuvoton.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, avifishman70@gmail.com,
        kwliu@nuvoton.com, openbmc@lists.ozlabs.org, tmaimon77@gmail.com,
        linux-kernel@vger.kernel.org, tali.perry1@gmail.com,
        mchehab@kernel.org
In-Reply-To: <20221122085724.3245078-3-milkfafa@gmail.com>
References: <20221122085724.3245078-1-milkfafa@gmail.com>
 <20221122085724.3245078-3-milkfafa@gmail.com>
Message-Id: <166914597689.442814.4178753345805789388.robh@kernel.org>
Subject: Re: [PATCH v7 2/7] media: dt-binding: nuvoton: Add bindings for NPCM
 VCD and ECE engine
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


On Tue, 22 Nov 2022 16:57:19 +0800, Marvin Lin wrote:
> Add dt-binding document for Video Capture/Differentiation Engine (VCD)
> and Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  .../bindings/media/nuvoton,npcm-video.yaml    | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml: properties:nuvoton,syscon-gcr: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('$ref' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml: properties:nuvoton,syscon-gcr: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'/schemas/types.yaml#definitions/phandle' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	'/schemas/types.yaml#definitions/phandle' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml: properties:nuvoton,syscon-gfxi: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('$ref' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml: properties:nuvoton,syscon-gfxi: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'/schemas/types.yaml#definitions/phandle' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	'/schemas/types.yaml#definitions/phandle' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221122085724.3245078-3-milkfafa@gmail.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

