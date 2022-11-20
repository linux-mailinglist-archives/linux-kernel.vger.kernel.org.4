Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E354E6314C7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKTPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:09:25 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9199A2D1D4;
        Sun, 20 Nov 2022 07:09:23 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso5979573otl.13;
        Sun, 20 Nov 2022 07:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6L3JfWVGgGaiFrPDApH8/SmW5rukZX6e4N1Fd2hikUs=;
        b=AYfMy9yQZjLZc3HfboTp9GL0wykFBG3QQtBCBDXbcG7BWgSmqEmmTflXNojjtytmiv
         ca98xctZODp1ZJYBfzUtkntTuFRIkfsd9K/5duYJxPYMUsACtY7W4ihL/bTU834ikoyB
         oaRoLadPS4+iNVnrMBcbrTnHzMg6cohlvkx4V+O7bn4bXA4RKqZfcZp88gypX3zaJ0eH
         X2+1UkqqhYVSdEKMI+G/bh21NW4tLJhyTMQ8MSUC0Iy1ljLA4nz8MNXtgzHEevr/ijl0
         49l+Pv/nnoko/Duil2SgiwD+nz/BgZpozZTca9KZrnO88XAQfoOkvn2dxUxYLba757Ep
         M54A==
X-Gm-Message-State: ANoB5pno+H1I+psgbe5eUE/DeGXhJGI8lsyOxTLsqr8MWLYNlvcO18ik
        0b0tv0RMYRbtakk9zDoyag==
X-Google-Smtp-Source: AA0mqf5mmRH/CwUjCggrAp+GQ2tKV+qZBmu/NFMhsmTFeoD/V6J0OYp7q+B/PmKwEDSpvmtg6UrCTw==
X-Received: by 2002:a9d:75d5:0:b0:667:7361:7db5 with SMTP id c21-20020a9d75d5000000b0066773617db5mr813831otl.22.1668956962725;
        Sun, 20 Nov 2022 07:09:22 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f6:1a48:29f6:113d:266f:a78e])
        by smtp.gmail.com with ESMTPSA id v13-20020a056870310d00b0012d939eb0bfsm4795788oaa.34.2022.11.20.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:09:22 -0800 (PST)
Received: (nullmailer pid 3068615 invoked by uid 1000);
        Sun, 20 Nov 2022 15:09:22 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20221120124543.18973-1-edmund.berenson@emlix.com>
References: <20221116191208.269e67eb@jic23-huawei>
 <20221120124543.18973-1-edmund.berenson@emlix.com>
Message-Id: <166895687829.3066801.11111948596761204211.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: ad7923: adjust documentation
Date:   Sun, 20 Nov 2022 09:09:22 -0600
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


On Sun, 20 Nov 2022 13:45:43 +0100, Edmund Berenson wrote:
> - Add the ad7927 compatibility string, with fallback compatibility
> to ad7928.
> - ad7923 and ad7924 are treated the same in the driver, show
> the relationship in the documentation.
> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
> ---
>  .../bindings/iio/adc/adi,ad7923.yaml          | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml:27:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml:32:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7923.example.dtb: adc@0: compatible: 'oneOf' conditional failed, one must be fixed:
	['adi,ad7928'] is too short
	'adi,ad7904' was expected
	'adi,ad7914' was expected
	'adi,ad7923' was expected
	'adi,ad7908' was expected
	'adi,ad7918' was expected
	'adi,ad7927' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7923.example.dtb: adc@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221120124543.18973-1-edmund.berenson@emlix.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

