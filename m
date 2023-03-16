Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633396BD180
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCPNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCPNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:53:44 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F11DB5B6A;
        Thu, 16 Mar 2023 06:53:41 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id h83so802350iof.8;
        Thu, 16 Mar 2023 06:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974821;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j2tFiBfDR3sqBGyTts2F0hCCIX1073H/hBiuonmjick=;
        b=YcPH1aGkCT0QSvihklByQUHq6nfX9YV6Ed+i2ZL41dXsnctzoEZkDoCBpj3h7awfYC
         iytkn+LE2LDA3qIcRMV+CoQN2pnXheQBaLMfbLZ7NczIN55FSxmMcC4+DUPXW8dAzen4
         YY+gGvxYjR/9fss4HJVut6eFJE5VVjpBnzcLSeGDkjNA8d2nnJkngdhX+ITAI0VgsMQi
         Av+nIB1H/JnOKJpczKIKXWJXW56lH27mFAJrvg0gZUpNy9iCGKF/8iQ5KkUO+lRtR/7D
         EKm5Kty5B7ixLNxRjRomx2WpeZD2dheQUzpTEXrETQwdVlDJNKivVIdEnt/iy2lDX0/e
         DDTw==
X-Gm-Message-State: AO0yUKUAM3/kg8yqH5RgB9LU+ySLCwLDkykGHTrPnxR3E+liOsoU+MV+
        RyQHMRo7HDK6Veil0h7I8A==
X-Google-Smtp-Source: AK7set8juC5NrSRSkGIE3mqMOYX3XEILn2QkGMLTFLQt3sdO7GSVXBIFLYoCNLWf9Cu5K7tqy7WHdw==
X-Received: by 2002:a5e:9508:0:b0:752:e9a2:1c5b with SMTP id r8-20020a5e9508000000b00752e9a21c5bmr4351255ioj.14.1678974820771;
        Thu, 16 Mar 2023 06:53:40 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id z13-20020a02cead000000b003a53692d6dbsm2524462jaq.124.2023.03.16.06.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:53:40 -0700 (PDT)
Received: (nullmailer pid 2744944 invoked by uid 1000);
        Thu, 16 Mar 2023 13:53:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Vijaya Anand <sunrockers8@gmail.com>
Cc:     broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org
In-Reply-To: <20230315231055.3067-1-sunrockers8@gmail.com>
References: <20230315231055.3067-1-sunrockers8@gmail.com>
Message-Id: <167897435177.2729678.7747291818682080828.robh@kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: adi,adau17x1: Convert to DT
 schema
Date:   Thu, 16 Mar 2023 08:53:34 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Mar 2023 04:40:55 +0530, Vijaya Anand wrote:
> Convert the binding document for adi,adau17x1 from txt to yaml
> so one could validate dt-entries correctly and any future additions
> can go into yaml format. Add address and size cells to example to
> prevent errors regarding reg format.
> 
> Signed-off-by: Vijaya Anand <sunrockers8@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v1:
> - added 'Codec' in title to clarify type of devices
> - put compatible devices in lexographic order
> - changed description of clocks
> - changed 'unevaluatedProperties' to 'additionalProperties'
> - changed node names to be generic
> 
> ---
>  .../bindings/sound/adi,adau17x1.txt           | 32 ------------
>  .../bindings/sound/adi,adau17x1.yaml          | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,adau17x1.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,adau17x1.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/adi,adau17x1.yaml:8:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/adi,adau17x1.example.dts:29.3-30.1 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/sound/adi,adau17x1.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230315231055.3067-1-sunrockers8@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

