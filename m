Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD5F6880FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjBBPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjBBPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:03:54 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA8222D4;
        Thu,  2 Feb 2023 07:03:33 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id 20so873026oix.5;
        Thu, 02 Feb 2023 07:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UvTEwmvDcai5Hh/VZKSiaeACzpspNyaYbdFC4BxG9Vw=;
        b=NuBaPNc+cBiB8pcsJMoB9Gd7opPc6aAu3+RiHf5TDwGFzRO9IJWTd1ySrMMmv81OvZ
         WpqBTIZY/amaOBIhG6tbtlP5YBnf5ibKRhbiX6Ig83AyZxvUHAhN7mMXxMVZVb9zgbpw
         89SntZ5xfaWuKQy819eCwlceQ1Ql9feKe5QzVaox3BP0CpZQyTxQWYTDHZI+jIyeJOyf
         vBHP2hQPwW0iFDsTMmvBf2p6PzfOmDfmX6zi1t9SY+4aEoT9hu5q9+zTyVLtmHH7TMWG
         4Ep+4cd17AX4cGa7W33VOdls0JEvuRittpg/YQypMlQq1EHxWwWavQpeuFLW162yWVy4
         JV6A==
X-Gm-Message-State: AO0yUKWvUNObkuvnFzZgna/mZxUpfjvCcvKXejAHY6biIQxuCGUFakJC
        n8q9tDCJBQ2ZfbUBIDl4yQ==
X-Google-Smtp-Source: AK7set+bA5yyR6vdQFFHDqhA79+FbXA1M9yolgiLz2mvM49bfLSzO8phSA+39jcZTwIbokmloj9QuA==
X-Received: by 2002:a05:6808:d47:b0:378:7d9c:8d3c with SMTP id w7-20020a0568080d4700b003787d9c8d3cmr3783713oik.31.1675350212469;
        Thu, 02 Feb 2023 07:03:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p184-20020acad8c1000000b003547a3401e6sm8087537oig.43.2023.02.02.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:03:31 -0800 (PST)
Received: (nullmailer pid 1858077 invoked by uid 1000);
        Thu, 02 Feb 2023 15:03:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>, vkoul@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230202132511.3983095-2-abel.vesa@linaro.org>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
 <20230202132511.3983095-2-abel.vesa@linaro.org>
Message-Id: <167535003746.1854137.3170990536949157461.robh@kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: phy: Add qcom,snps-eusb2-phy
 schema file
Date:   Thu, 02 Feb 2023 09:03:31 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 15:25:04 +0200, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
> for the new driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v3 version of this patch was here:
> https://lore.kernel.org/all/20230126131415.1453741-2-abel.vesa@linaro.org/
> 
> Changes since v3:
>  * removed blank line, like Rob suggested
>  * dropped quotes and reset description, like Rob suggested
>  * dropped the RPMH_CXO_PAD_CLK clock and the ref_src clock name
>    to match the schema
>  * fixed filenames of the includes in the example (sm8550-gcc and
>    sm8550-tcsr)
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * dropped the "ref src" clock
>  * dropped the usb-repeater property
> 
>  .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.example.dts:20:18: fatal error: dt-bindings/clock/qcom,sm8550-tcsr.h: No such file or directory
   20 |         #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230202132511.3983095-2-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

