Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70676E2A29
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNSiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjDNSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:38:01 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEADA240;
        Fri, 14 Apr 2023 11:38:00 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id z16so12309571oib.9;
        Fri, 14 Apr 2023 11:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497479; x=1684089479;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fKT6fiDg+2MVo2sXkICVAywOZ2rL0RJkCUkl74gbvUU=;
        b=fWZxe9n54oq4zSPhdeTnup2159WsChx1+fkkqyNoJl/As6eOC9qgp0VFoevJx9i+uq
         BTg79XHzJWt0Ewdcwx2IpXi1TJ9si/sJtos6dpr2I3qHCnH6NempLx5rSVJnxWQje8W9
         FzfuLw+wfq1348rAekcVoo9JuBhIzqAQcpwA6+BnYRCSBwGkNenCJQp6EJKE63NvJCLW
         EEdyU8yot6Np7qT3SxrEjYH+g4204j76EW/Qbeqm2gtcbP0yXY5v/Yby9Y2VtYb4L7zq
         /qcmudO1H7EBjCSUKx117aUsN2Al3ETadpS5UQXE1F3aRpZxbYR/lCy9s80Rc60cYdwV
         8qvg==
X-Gm-Message-State: AAQBX9eI3TlS7mkuT8lgZyH3QX6TOWA+BGstvoX4+zTnDG1VgZEWjMiU
        OdaFOVeNqp77CWMzpHGfbg==
X-Google-Smtp-Source: AKy350Zoe9qiArU40t8/OyBlNnywucXp5OyCvHFhVTS+SwpAkAjFup7HKFaIVtM7kS2mjA+10j1MhQ==
X-Received: by 2002:aca:d09:0:b0:37f:87fb:cdc3 with SMTP id 9-20020aca0d09000000b0037f87fbcdc3mr2137346oin.17.1681497479256;
        Fri, 14 Apr 2023 11:37:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r67-20020acac146000000b0038c36edc51dsm1077392oif.24.2023.04.14.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:37:58 -0700 (PDT)
Received: (nullmailer pid 105413 invoked by uid 1000);
        Fri, 14 Apr 2023 18:37:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nuno.sa@analog.com,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        upstream@semihalf.com, perex@perex.cz, tiwai@suse.com,
        lars@metafoo.de, lgirdwood@gmail.com
In-Reply-To: <20230414140203.707729-4-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-4-pan@semihalf.com>
Message-Id: <168149743035.103868.7729505155994277946.robh@kernel.org>
Subject: Re: [PATCH 3/9] dt-bindings: ASoC: Add chv3-audio
Date:   Fri, 14 Apr 2023 13:37:55 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2023 16:01:57 +0200, Paweł Anikiel wrote:
> Add binding for chv3-audio device.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/google,chv3-audio.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/google,chv3-audio.yaml:34:23: [error] empty value in block mapping (empty-values)
./Documentation/devicetree/bindings/sound/google,chv3-audio.yaml:35:25: [error] empty value in block mapping (empty-values)
./Documentation/devicetree/bindings/sound/google,chv3-audio.yaml:36:23: [error] empty value in block mapping (empty-values)
./Documentation/devicetree/bindings/sound/google,chv3-audio.yaml:37:25: [error] empty value in block mapping (empty-values)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml: required:1: {'google,audio-cpu0': None} is not of type 'string'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml: required:2: {'google,audio-codec0': None} is not of type 'string'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml: required:3: {'google,audio-cpu1': None} is not of type 'string'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml: required:4: {'google,audio-codec1': None} is not of type 'string'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml: ignoring, error in schema: required: 1
Documentation/devicetree/bindings/sound/google,chv3-audio.example.dtb: /example-0/sound: failed to match any schema with compatible: ['google,chv3-audio']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414140203.707729-4-pan@semihalf.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

