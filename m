Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F094572DD86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbjFMJTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbjFMJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:18:57 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8980E7A;
        Tue, 13 Jun 2023 02:18:52 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-34070ecad56so1286555ab.3;
        Tue, 13 Jun 2023 02:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686647932; x=1689239932;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3l7i3ti7Ci+JAIfrqJMPuqYwSi/QpzUEyhd2W9zcJMQ=;
        b=JyWKeYjNesxCe+GqlqmLhu0yPTy/nVq0C/yWInnI6Jv5V47A4poldt/7JNaY1tVuSa
         4U6ZzQLDtaDxfO6DcSeBraMHzlM12TFQiuAQFObpbZ8/GBu3IHbr6SkahsD+FPOeCqrh
         iYChh8JY0MG1zTJTd8zoP+5e6kI1X/y6mvkaQx2Ppgu8IQ1ByTJHET3J10/fV0zZ0S9k
         w2X6f2jsIY3uDt/WEOIvOxX7CRb6g7ckK9B0JISiAa6AWhw+3F0nXLiENxc++WRKCgGk
         BnX4BxcnJTNeaqi0fP72odO/EkUOycR/3C/sDTGugstdmA/un+TxIKDCHs4h3SnSqvH9
         dixQ==
X-Gm-Message-State: AC+VfDw5FUVBsArkGKhZvSwfte77YRfIWiWgXv3YNbIbc21nVmr27RZU
        EI2R006P+aaONzjvp+5M8w==
X-Google-Smtp-Source: ACHHUZ4UEbo3jcsK6QJZwFJIadLOuNXhsYrmCm2eEJADv3BGbeK/HQpFbgZyJG8xnpy45roW1OQ7aQ==
X-Received: by 2002:a92:cb42:0:b0:331:3b07:56e2 with SMTP id f2-20020a92cb42000000b003313b0756e2mr9377465ilq.31.1686647931922;
        Tue, 13 Jun 2023 02:18:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v5-20020a92d245000000b0032957b21c26sm3711047ilg.77.2023.06.13.02.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:18:51 -0700 (PDT)
Received: (nullmailer pid 1147154 invoked by uid 1000);
        Tue, 13 Jun 2023 09:18:49 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230613080552.4492-2-okan.sahin@analog.com>
References: <20230613080552.4492-1-okan.sahin@analog.com>
 <20230613080552.4492-2-okan.sahin@analog.com>
Message-Id: <168664792963.1147059.8156399408819922296.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: regulator: max77857: Add ADI
 MAX77831/MAX77831 Regulator
Date:   Tue, 13 Jun 2023 03:18:49 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Jun 2023 11:05:49 +0300, Okan Sahin wrote:
> Add ADI MAX77857 and MAX77831 Regulator device tree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../bindings/regulator/adi,max77857.yaml      | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77857.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml: $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates that the pin should be operating in paired mode.'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230613080552.4492-2-okan.sahin@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

