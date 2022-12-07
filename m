Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67230645C59
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiLGOU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiLGOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:20:14 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA35D697;
        Wed,  7 Dec 2022 06:20:02 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so21462542fac.2;
        Wed, 07 Dec 2022 06:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RhBLk8VcFaz/v/fMZe1KFzL357JI5UetuESxzLIfjRI=;
        b=f41V3Mr1ZbHV9eZngza0v8XRjgfMyhl1EayJcMThAExA0jzsCSXhrSWUEEfF8HkeXM
         gxo4RRBAR48pBURgRD9bXg36sfvOFEI/AbjnmhAgK+ox4vAclRcaA9S/bqT3IajwDftG
         z6BOREkg6mqL2rbtivCzpOr6zu4YtXHDsDrP+zcaJo5Q0YHwAweUaPAnjXvv/Ap70z33
         +KjIJrJMBJXk4F4j/AvpEEKue0ei6eIRhRJtwu9yS9Ou3oCjYH3/7vVFOkHulY/9SdSe
         I+rWB/l6d+EZFco09t0S1s9Chb3mzR8l4lHU7FPrlN0UkS6kdMiXu4xuKusOxeGiUGgb
         55vA==
X-Gm-Message-State: ANoB5pluVXM0GyVakcFKC1AVFXso6cXrklbYKwOPff3endGfgMRlb40G
        Db1wMzF7zAYOftUoPfghCg==
X-Google-Smtp-Source: AA0mqf5Ces9tvVXcwYUIowwHdMMYUnDLEQYpabQuJIpvVLOqIoD7NUUxHhH9Fbamf0mmXpL6Z9I0lQ==
X-Received: by 2002:a05:6870:be9b:b0:144:a46f:e355 with SMTP id nx27-20020a056870be9b00b00144a46fe355mr7016254oab.95.1670422801747;
        Wed, 07 Dec 2022 06:20:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w64-20020aca6243000000b0035ba52d0efasm9484993oib.52.2022.12.07.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:20:01 -0800 (PST)
Received: (nullmailer pid 2124809 invoked by uid 1000);
        Wed, 07 Dec 2022 14:19:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        outreachy@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20221207090906.5896-5-okan.sahin@analog.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
 <20221207090906.5896-5-okan.sahin@analog.com>
Message-Id: <167042222369.2111889.8418799302512280680.robh@kernel.org>
Subject: Re: [PATCH 4/5] staging: dt-bindings: regulator: adi,max77541.yaml
 Add MAX77541 Regulator bindings
Date:   Wed, 07 Dec 2022 08:19:49 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 12:08:43 +0300, Okan Sahin wrote:
> This patch adds document the bindings for MAX77541 and MAX77540
> regulator drivers.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../bindings/regulator/adi,max77541.yaml      | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77541.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/regulator/adi,max77541.yaml:44:28: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/regulator/adi,max77541.yaml: Documentation/devicetree/bindings/mfd/adi,max77541.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207090906.5896-5-okan.sahin@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

