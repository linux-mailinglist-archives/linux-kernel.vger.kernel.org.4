Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1342C72DF10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbjFMKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjFMKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:19:07 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750ED13A;
        Tue, 13 Jun 2023 03:19:06 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33e4e59da95so31928845ab.2;
        Tue, 13 Jun 2023 03:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651545; x=1689243545;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UbG9U/FLtRULHFXZAPeAJM9N/HEaNECQdhVlO5M7IT8=;
        b=KmCUHt4lbpGGDKuGdCuZL8mhVaTz0GnTRTxJ06BZ737i8uScRBoZ9Ufd9KuohbM/7s
         4rtm2Fm/mNNkkbKrj+HSpGIY+aRUNfNfybhDHYR5kCA23Qnsoskf5SbtAoL2bM0QPMPc
         MLD4A0erIhxelZI5Z9V7jtbYpX+Gfiiro/mlWpz8Pa1xoK+VM8GaPSiF+atxtV1QXkqC
         fjz8HM81Tjuj1iuy1EAg3PWY6PcRALGG+IW6E5Fiud6SI8q5sss0uIKrkgNV9UYNYe6K
         uasBVUfUGQ6VOSHu2FO3jMQPEx8jPVntnJJgpAJO8XuNDcvI9Nl+udgb3VwYRZtn5VkC
         pzHA==
X-Gm-Message-State: AC+VfDwIE8MrtRnk+ch//FPF84ICu+Qw9G4ThGsUxkMImZrU0PJzbshY
        RAucux/wZBJ8h9nTfLKL+w==
X-Google-Smtp-Source: ACHHUZ6b+3w2KTmQoleqNjbplF5QhcDGa+dzx6zlJ5JOkxzzvHjcoJsdGnoBowc14g3Y7OvjyRYLrA==
X-Received: by 2002:a92:d084:0:b0:340:7986:93b7 with SMTP id h4-20020a92d084000000b00340798693b7mr811372ilh.26.1686651545573;
        Tue, 13 Jun 2023 03:19:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h14-20020a0566380f0e00b0041cea93e589sm3298899jas.152.2023.06.13.03.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:19:04 -0700 (PDT)
Received: (nullmailer pid 1311612 invoked by uid 1000);
        Tue, 13 Jun 2023 10:19:01 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        Michael.Hennerich@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        jic23@kernel.org, linux-iio@vger.kernel.org
In-Reply-To: <20230613093346.60781-1-kimseer.paller@analog.com>
References: <20230613093346.60781-1-kimseer.paller@analog.com>
Message-Id: <168665154072.1311520.12958978545814613109.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add max14001
Date:   Tue, 13 Jun 2023 04:19:01 -0600
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


On Tue, 13 Jun 2023 17:33:45 +0800, Kim Seer Paller wrote:
> The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/all/168663709022.652608.11756645774505315189.robh@kernel.org/
> ---
> V3 -> V5: Added spaces between prefixes in subject. Fixed MAINTAINERS reference.
> 
>  .../bindings/iio/adc/adi,max14001.yaml        | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml: $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates that the pin should be operating in paired mode.'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230613093346.60781-1-kimseer.paller@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

