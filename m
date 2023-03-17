Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FFB6BEBE0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCQOzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCQOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:55:51 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB996150A;
        Fri, 17 Mar 2023 07:55:22 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id q6so2398219iot.2;
        Fri, 17 Mar 2023 07:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064921;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rZSOUyuCSrUz5N/H+o+NJ3xKMTNoMLx1KYXhbS5FPY8=;
        b=L2VIF4k6QktpGYUPEV0jouRq8b9pRbOgVn4Qd9IaRIDqiwTbdN4cc3bOluooiLmuwe
         36XZ7sHBQTYIxIrs2IPm2AFTJeIcEgB9rONth/TnRnEWL/7BU/3ZmRzrE1q5gHYAx0ev
         iajVeH3d+/efJx8Y6H8WdbLjf+LtPep955A054hmx4tPjuAuyfnuLM0Yd2MjqPMyCkdx
         ETrjdyalqnagjhUx+1InYJXPDQUzm2RFPZ1vuPM26KApiw+Rbxhv4qiRFywy2c/Vmyq2
         qJQAI41JVEUsxWwyL+wKRGL802XsXOKWvhLTK/6+u+2qdiwLom5vInv1drzEskjlyWi8
         A8Zg==
X-Gm-Message-State: AO0yUKWkj1I28nglR3Hn1q27IqIYqPj0usRFk9+Ch3+ChkRpltu7eaY9
        1i/7TT+l86yXezR7weph6rtQK18u1g==
X-Google-Smtp-Source: AK7set/sCF3qnbQifdlhrYVwSflG6YACrfvZ09Zk1ANk0OtJBbGnh0nPxN5jOUo8s9/w/mhsEXsHbg==
X-Received: by 2002:a5e:db4b:0:b0:751:df6e:79ba with SMTP id r11-20020a5edb4b000000b00751df6e79bamr1615893iop.5.1679064921584;
        Fri, 17 Mar 2023 07:55:21 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id g8-20020a6b7608000000b0074c7db1470dsm604027iom.20.2023.03.17.07.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:55:21 -0700 (PDT)
Received: (nullmailer pid 2039508 invoked by uid 1000);
        Fri, 17 Mar 2023 14:55:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <20230317082950.12738-2-zhuyinbo@loongson.cn>
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-2-zhuyinbo@loongson.cn>
Message-Id: <167906278354.1989456.6038971429020823802.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add loongson spi
Date:   Fri, 17 Mar 2023 09:55:19 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Mar 2023 16:29:49 +0800, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/spi/loongson,ls-spi.yaml         | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dts:22.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230317082950.12738-2-zhuyinbo@loongson.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

