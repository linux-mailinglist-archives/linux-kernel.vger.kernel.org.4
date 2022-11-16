Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B7462C299
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiKPP3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiKPP32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:29:28 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291901E725;
        Wed, 16 Nov 2022 07:29:27 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso10601331otr.9;
        Wed, 16 Nov 2022 07:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cLCzckP4DZJLigh6uqQZLXPP0BctbxitUX+h3b1cBFs=;
        b=yMCa3MzsQBH7bxtrSRPGM8ipdzhi3oqM5RSJJPu4hWJMvoxx/cZK7eyELbmETSZQgG
         tfasTunkPjMrE27MaJ/EyouFtdfrtrMmqCeECymc52mxsV7Zw+0NCCBkzzUBZiPgz6jS
         VgAJPyoFh2dD/sQbKuCZ7vKkj9b749qeFPN6SaFYo6340+teKi1LfnH8bxYARjHkc6pu
         VVnGJ9PcdVubARBCGFwlWvxIXFHSLSP9uJys4jRwBVVs0Yy/P3k3LYKf20mQ4Ils5tJm
         6gbjNC1FE44aQGahXoPV9AviwtKKNwXR6oLQCPLOODIFfgISAtOk5kNookA+SvXAlzPK
         TyAA==
X-Gm-Message-State: ANoB5pkjwhue/DVhspfRV1l44IsTWRv3HCSQAKqSVzS2fRwJbLAykLR7
        XcU3S4mIq3DhEfuy2C6ws5y1siEuZg==
X-Google-Smtp-Source: AA0mqf4P0aJNSqcTZm5Qyjqu1YvFIAsxgQQqtjolMrC4rlaQIkKdRb6zA7FHl+CjFaNqbCoWEu/oFw==
X-Received: by 2002:a05:6830:d13:b0:661:b84c:6b0a with SMTP id bu19-20020a0568300d1300b00661b84c6b0amr10834817otb.186.1668612566371;
        Wed, 16 Nov 2022 07:29:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g8-20020a056870d20800b0012d6f3d370bsm8042595oac.55.2022.11.16.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:29:25 -0800 (PST)
Received: (nullmailer pid 4083492 invoked by uid 1000);
        Wed, 16 Nov 2022 15:29:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116120157.2706810-9-abel.vesa@linaro.org>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-9-abel.vesa@linaro.org>
Message-Id: <166861224970.4037717.4752810880647292636.robh@kernel.org>
Subject: Re: [PATCH 08/10] dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
Date:   Wed, 16 Nov 2022 09:29:23 -0600
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


On Wed, 16 Nov 2022 14:01:55 +0200, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
> for the new driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.example.dts:18:18: fatal error: dt-bindings/clock/qcom,gcc-sm8550.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,gcc-sm8550.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

