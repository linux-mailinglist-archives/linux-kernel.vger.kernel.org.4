Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6290C6E2A26
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDNSh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDNSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:37:58 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8755B4;
        Fri, 14 Apr 2023 11:37:57 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id w19-20020a9d6393000000b006a43ff0f57cso1600284otk.5;
        Fri, 14 Apr 2023 11:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497476; x=1684089476;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=esLUoAYEUiCqLSENFicfSVfYmj0WlNAWG2ZggPbHEGc=;
        b=XGG4gvTRfNyKuUoCwUMAAuC4kBEqjqCLg8S5JGfputNxEt30neGlPOzExOzmUf1L9f
         SMkpeb0C/7wT9biydCqIIsOcJZWdIZ1+7gOeR1ctfm5AGZLRCGqeeQ2YsYNbMP1BEiXK
         Aaz+DYEIOkWk9CedWy2B8Nip2Sgqqh229V0N8znLY1aRiqk61BIf8JTFTTrsuwfMb5px
         soUkx+Hu9DMCjL65djRTbxAYSyyWg2kCZsntxPjoyyhvby+p9CxiSOATJopmc2V9AB20
         9CVb/ChwznE2x+MXzd9YWQpbqctk7RlmEFKO68J2p6R4fHhQgB2tbJGVbASiLSxr+7uF
         f7OQ==
X-Gm-Message-State: AAQBX9cSYJ8zMiHv7o7kLM/Zu3SNX63c7IQN36IpCyt/ZR0a47xyzDXt
        +sOT+FpaeSSD4lwxD7yShw==
X-Google-Smtp-Source: AKy350Yb7Wxpz60VAMD1VMkHDAMWwCgvcXgm479C4o7Hkyqu53KhC9PtSXkFDuHi7qQxnYtXpwT9Fw==
X-Received: by 2002:a05:6830:2049:b0:68d:416e:3d9d with SMTP id f9-20020a056830204900b0068d416e3d9dmr3353438otp.7.1681497476228;
        Fri, 14 Apr 2023 11:37:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k7-20020a056830150700b0069fa6ca584bsm1998493otp.40.2023.04.14.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:37:55 -0700 (PDT)
Received: (nullmailer pid 105410 invoked by uid 1000);
        Fri, 14 Apr 2023 18:37:55 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZDlLmCIiKSMa7Hah@arbad>
References: <ZDlLmCIiKSMa7Hah@arbad>
Message-Id: <168149742968.103828.12005372013452240608.robh@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: iio: pressure: Support Honeywell
 mprls0025pa sensor
Date:   Fri, 14 Apr 2023 13:37:55 -0500
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


On Fri, 14 Apr 2023 14:48:24 +0200, Andreas Klinger wrote:
> Honeywell mpr is a pressure sensor series. There are many different models with different pressure
> ranges, units and transfer functions.
> 
> The range and transfer function need to be set up in the dt. Therefore new properties
> honeywell,pmin-pascal, honeywell,pmax-pascal, honeywell,transfer-function are introduced.
> 
> Add dt-bindings.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/pressure/honeywell,mprls0025pa.yaml   | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,transfer-function: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,transfer-function: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,transfer-function: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.example.dtb: pressure@18: 'honeywell,pmax', 'honeywell,pmin' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ZDlLmCIiKSMa7Hah@arbad

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

