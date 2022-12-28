Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74AC657167
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiL1A1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiL1A1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:27:45 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF4210E4;
        Tue, 27 Dec 2022 16:27:44 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id i25so7569865ila.8;
        Tue, 27 Dec 2022 16:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lzEg4VO5GMi09m7RLPNF4beRTGaDDincjcOLdN8zZdk=;
        b=MYVPFXSiAJF3rKVPNgcOuKV7X2v1OdQE9f6coPHd3r2GRSL4+dFVjeHoFv0aokx2UZ
         QOuF0YEYT8T8c87kE5fsRJTfgTZQZfbOhL36g6l4ImaR9Z8utEN+0vZvs5eoA9lJ4KFq
         /PW9PtBB91QLycXbmnQvsK1FfLIownZ28Wo0uJGvXsZLXaIL1p0CzHfoxwYjvVkJYUx4
         f9pa1+7LRngJBOt5B10nEYzD/z/oec1q4G4I0jK6ej0or5BeowWjdowMKrACHC3CnG7i
         EgAilLapp7KDJjKgMQj9jzE68DnuFaCys5UxjomSP/HeOGc4eX6aI5JZBV/9aFynGCQ9
         Fz0g==
X-Gm-Message-State: AFqh2kpnXXbjxPJ7ILKOlT8Kuz2oVDpAMIPXaTDkLXaIA3d0XkHwCQ09
        lZDQSHN/gbMGiVLVhjHM9A==
X-Google-Smtp-Source: AMrXdXtSbeY5HcnJUrgcgnQWGZZB8V4nCKmekBJ+lCyjQy174hnKaPbClWYr0MaWlXwbR6bSTkuH0Q==
X-Received: by 2002:a92:d2cf:0:b0:30b:e45c:3d1a with SMTP id w15-20020a92d2cf000000b0030be45c3d1amr12815714ilg.23.1672187263562;
        Tue, 27 Dec 2022 16:27:43 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w9-20020a92c889000000b0030c00897497sm2423967ilo.19.2022.12.27.16.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 16:27:42 -0800 (PST)
Received: (nullmailer pid 42254 invoked by uid 1000);
        Wed, 28 Dec 2022 00:27:41 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:MAXIM MAX77541 PMIC MFD DRIVER" 
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221226223839.103460-3-okan.sahin@analog.com>
References: <20221226223839.103460-1-okan.sahin@analog.com>
 <20221226223839.103460-3-okan.sahin@analog.com>
Message-Id: <167218706106.33727.591355104841763067.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: mfd: adi,max77541.yaml Add MAX77541 bindings
Date:   Tue, 27 Dec 2022 18:27:41 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 01:38:36 +0300, Okan Sahin wrote:
> The bindings for MAX77541 MFD driver. It also
> includes MAX77540 driver whose regmap is covered by MAX77541.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77541.yaml | 102 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/adi,max77541.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/regulator/adi,max77541-regulator.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77541.example.dtb: pmic@69: regulators: False schema does not allow {'BUCK1': {'regulator-min-microvolt': [[500000]], 'regulator-max-microvolt': [[5200000]], 'regulator-boot-on': True, 'regulator-always-on': True}, 'BUCK2': {'regulator-min-microvolt': [[500000]], 'regulator-max-microvolt': [[5200000]], 'regulator-boot-on': True, 'regulator-always-on': True}}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,max77541.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221226223839.103460-3-okan.sahin@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

