Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CFE6514BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiLSVWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSVWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:22:11 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD6A64D1;
        Mon, 19 Dec 2022 13:22:10 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so13202545fac.2;
        Mon, 19 Dec 2022 13:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f/Rdvbu+qSgHoC8VgQQG2atswz7W9zrDtpuYONrJn/Q=;
        b=yJWD2nBRnVDgdbsQpV1zFrkqgSb4wzf/qkiswwrWgYlb64841ikksj6b/pz2BdG0RD
         HemSt6CjNTOTfLDgwSfPv4M0AAuBoXEfLm1zHMF3DnocrDcy33OJ5raBubQBbs2T0/ap
         4l9rMs+BqykMIRMYPPCyeKkE+v8lDbLkrIOE6p4Pjg9CqAsymX7Q757NlKSrfGVLDmxp
         aVMMyq+EQntbMgg/m9WvH9aDTlrINMCVX/LQtV6QWL+w0B3Mn+t9CPsvoRqp9H1J0QyM
         Oo4+bKp9ZITKBu7yE6JbAZqcclDuqoNQ0kiHtzemadPAj9USU5EH5QS9UYim5iy67BKr
         ByEg==
X-Gm-Message-State: ANoB5pm0rq+DWHB4dbrie/vkc1/mqUMD9Y33WV+AvzdqvDih5kjYLFUw
        59l9i9NpVeq1TgvvQnjsxA==
X-Google-Smtp-Source: AA0mqf7Swu8ufPQphtB2Ovx5HkJFBwFP2DUcnrN3rLC0xKRvsEiI5m29SLKPHE/BL0mwmq/kG0H5pw==
X-Received: by 2002:a05:6870:7d02:b0:144:b4d6:4e02 with SMTP id os2-20020a0568707d0200b00144b4d64e02mr20991772oab.40.1671484929997;
        Mon, 19 Dec 2022 13:22:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h18-20020a4ad012000000b004908a9542f8sm4345687oor.31.2022.12.19.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:22:09 -0800 (PST)
Received: (nullmailer pid 2350832 invoked by uid 1000);
        Mon, 19 Dec 2022 21:22:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Witold Sadowski <wsadowski@marvell.com>
Cc:     wbartczak@marvell.com, jpawar@cadence.com,
        linux-spi@vger.kernel.org, pthombar@cadence.com,
        devicetree@vger.kernel.org, konrad@cadence.com,
        linux-kernel@vger.kernel.org, wzmuda@marvell.com,
        broonie@kernel.org
In-Reply-To: <20221219144254.20883-5-wsadowski@marvell.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-5-wsadowski@marvell.com>
Message-Id: <167148425112.2334433.10418308951514723890.robh@kernel.org>
Subject: Re: [PATCH 4/7] spi: cadence: Change dt-bindings documentation for
 Cadence XSPI controller
Date:   Mon, 19 Dec 2022 15:22:08 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Dec 2022 06:42:51 -0800, Witold Sadowski wrote:
> Add parameter cdns,read-size.
> Parameter is controlling SDMA read size length.
> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/cdns,xspi.yaml: properties:cdns,read-size: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	'description' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('items' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/cdns,xspi.yaml: properties:cdns,read-size: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/cdns,xspi.yaml: properties:cdns,read-size: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221219144254.20883-5-wsadowski@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

