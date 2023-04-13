Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30A96E0DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDMNAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDMNAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:00:43 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBDC93D9;
        Thu, 13 Apr 2023 06:00:41 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id bp9-20020a056820198900b005414beaa075so4505532oob.8;
        Thu, 13 Apr 2023 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681390841; x=1683982841;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8wfgGByHfdJ08Wr+lWIbZNkFievhpJuq8NSnds9ngVg=;
        b=koPrR3WSvIR9bX+SawhHtGG1aeApwQ1KP3KPtGc7z4xzTVsWLJF+Fg/faJ8IdjExUM
         +5d22uOif7IK0L+RHvJ0expYQAxrj5QSP9lSUaW1GuSXVzXsJYlYzpGQs7SW0PTHRv6w
         bXNKgUmkZHhwzWA16DDHNuVkvp0zdCHmd6VX8tnmXShk+G6HaRcPFe7tFlnBFa/obi1K
         CoNEi3mXfQ1geD3sq/jmoXKdFUuuYBFo2XFdRckkTydurxROF+/431nXZoTQVhJgviGT
         d7uuxWjihtkPrAFG4pspEB5zWX/6eSFHmwAn8F402O2gmJP9UEfoxMdldhw7BgPwZ4nQ
         H4uQ==
X-Gm-Message-State: AAQBX9dmUCr8nNuC9f/Bzfi4cD+oRmOETyid4rrDKezZ/ibT6qJp1W+2
        CNpFPWHTGd8Pw9dMqYxTwQ==
X-Google-Smtp-Source: AKy350YowH7B9fmcOXSowhNDvvT1rZtphj7sGFoP3nHOx9sYmmIDSimY2y2wdMEqgAujrFACUFt14w==
X-Received: by 2002:a4a:4589:0:b0:53e:133e:28cf with SMTP id y131-20020a4a4589000000b0053e133e28cfmr890571ooa.1.1681390840836;
        Thu, 13 Apr 2023 06:00:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h42-20020a056870172a00b001762ce27f9asm674447oae.23.2023.04.13.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:00:40 -0700 (PDT)
Received: (nullmailer pid 681755 invoked by uid 1000);
        Thu, 13 Apr 2023 13:00:39 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230413042503.4047-1-stanley_chang@realtek.com>
References: <20230412033006.10859-2-stanley_chang@realtek.com>
 <20230413042503.4047-1-stanley_chang@realtek.com>
Message-Id: <168139061467.672124.12193026400229130255.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,global-regs-starting-offset' quirk
Date:   Thu, 13 Apr 2023 08:00:39 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Apr 2023 12:25:03 +0800, Stanley Chang wrote:
> Add a new 'snps,global-regs-starting-offset' DT to dwc3 core to remap
> the global register start address
> 
> The RTK DHC SoCs were designed the global register address offset at
> 0x8100. The default address is at DWC3_GLOBALS_REGS_START (0xc100).
> Therefore, add the property of device-tree to adjust this start address.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  v1 to v2 change:
> 1. Change the name of the property "snps,global-regs-starting-offset".
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,global-regs-starting-offset: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,global-regs-starting-offset: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml: properties:snps,global-regs-starting-offset: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230413042503.4047-1-stanley_chang@realtek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

