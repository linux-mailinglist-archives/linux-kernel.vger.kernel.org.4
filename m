Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC74658533
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiL1RQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiL1RQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:16:47 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E713D4F;
        Wed, 28 Dec 2022 09:16:46 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id z18so8471211ils.3;
        Wed, 28 Dec 2022 09:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GtsNziqtosk5fGA4iQynew9CXVas2xeRqJXm3p7E/xg=;
        b=un/CJNX8XRZHlc0PPJnIvFhS5IpgRD8I6/R/zoBGRhbmLkaNpqf64wYynampwtftgC
         5tupdgtNjTp2tKIbjujzszPg4IBsX0CiFcE1QIPLgTIcqT348hIKvToiDFboIRAGAw8Y
         J7Su0eKkpGOpNbYo+H9p7SFxoZugmm/yanqjZ+CrL9vF+sizCTiLuffdUg+Yo/KFWfR8
         ksmR+6cDhqN2RxTP9WUESd7If1/P9sBhw53a3alfH5KKxE574hqphl/0ykhN7glQM+Un
         ihVkViQBQsEccM1hY5JpafwloJ8TwAIYT/5t4hSoo2TdiEe2x+djtxA/+p4m5l9s1HSm
         /xvA==
X-Gm-Message-State: AFqh2kp6e2+gYMRLPbeGsLALpYFPi0TV5AvFPCCWITpjO6TIHxfwrBWu
        Ii2aXliqRT62NFy0VAXYLVQHfGzR3A==
X-Google-Smtp-Source: AMrXdXvqv/LDMIFwAHIsqBV/YKVKwU0ASsP/hpfrlmxnnqj/Tb1UjRUMXdmHtr2gPuHf0d0UPxuEhQ==
X-Received: by 2002:a05:6e02:218d:b0:30c:2266:cfca with SMTP id j13-20020a056e02218d00b0030c2266cfcamr1939780ila.9.1672247805656;
        Wed, 28 Dec 2022 09:16:45 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f27-20020a056638329b00b003758bcba4b5sm5184514jav.153.2022.12.28.09.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:16:45 -0800 (PST)
Received: (nullmailer pid 1928458 invoked by uid 1000);
        Wed, 28 Dec 2022 17:16:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20221228100321.15949-9-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
 <20221228100321.15949-9-linux.amoon@gmail.com>
Message-Id: <167224753802.1921489.221143833426610237.robh@kernel.org>
Subject: Re: [PATCH v1 08/11] dt-bindings: usb: Add binding for Via lab
 VL817Q7 hub controller
Date:   Wed, 28 Dec 2022 11:16:44 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Dec 2022 10:03:17 +0000, Anand Moon wrote:
> The VIA Lab VL817-Q7 is a USB 3.1 Gen 1 4-Port hub controller that
> features 4 downstream ports, an internal 5V regulator and has
> external reset pin.
> 
> Add a device tree binding for its USB protocol part.
> The internal LDO is not covered by this and can just be modelled
> as a fixed regulator.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../bindings/usb/vialab,vl817q7.yaml          | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml: '$id' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Error: Documentation/devicetree/bindings/usb/vialab,vl817q7.example.dts:26.17-18 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/usb/vialab,vl817q7.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221228100321.15949-9-linux.amoon@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

