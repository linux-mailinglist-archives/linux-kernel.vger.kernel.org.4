Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F171629B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiKOOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKOOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:11:16 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167051DDD2;
        Tue, 15 Nov 2022 06:11:14 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id n186so14951129oih.7;
        Tue, 15 Nov 2022 06:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vz7uYUJeJamm9PygKBSIU9xy9hxrNgiwqn+UopNSfxg=;
        b=Pry+ejpCWfkzv9XVTtYEYzKD9AP9QHkyNafatfBySs6Y1xNr0UL3dn783pUT44jz3b
         C6rSOsMYqhmlNiwwK6MGjyLLwAD+5ULJzZNWR2mojuJI2O951CcuerEXwNgD5kLH9ngb
         PTEHpUelBwhCP8Ld/o1Y0Aodarn6I71g9i5nY6cff0Ve88vZ3btZ8ioaMrzbbsC8xi76
         gHC26m9Sqp0bGMxgvOQVO5/vCnvCROexrOPAElH4DGFDtlrQH5FyeHrJ4Ww2x+AS6vXn
         KHapDccyKg4eSR/027izP5RMtAo7lVE3FlCqLh+IKc8cRXOEkpxCq49jaSe+hQK5mlPV
         XiIA==
X-Gm-Message-State: ANoB5pnAfb34woXDcNfMkyhZZuS+jFdomCiMfpmQVC4K6U4zI+aohTUq
        lbOaXjrfbvP5IwZbyk2+zg==
X-Google-Smtp-Source: AA0mqf63x/dD+y9Qcgt5y0VP/sBf/XF/rZGM6hGioza2aUahrUk0uRvZcUGMWd8ljseCIlQn2gvXCA==
X-Received: by 2002:a05:6808:655:b0:354:2c52:51eb with SMTP id z21-20020a056808065500b003542c5251ebmr383158oih.89.1668521473150;
        Tue, 15 Nov 2022 06:11:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cg3-20020a056830630300b0066dae8cf9a0sm347740otb.50.2022.11.15.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:11:12 -0800 (PST)
Received: (nullmailer pid 908575 invoked by uid 1000);
        Tue, 15 Nov 2022 14:11:14 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bernhard =?utf-8?q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221115025421.59847-12-bero@baylibre.com>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-12-bero@baylibre.com>
Message-Id: <166851961560.867545.11435946011050466616.robh@kernel.org>
Subject: Re: [PATCH v2 11/15] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
Date:   Tue, 15 Nov 2022 08:11:14 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 03:54:17 +0100, Bernhard Rosenkränzer wrote:
> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---
>  .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Error: Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.example.dts:34.29-30 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

