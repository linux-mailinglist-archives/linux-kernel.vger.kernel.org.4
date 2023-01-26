Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536E367D068
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjAZPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjAZPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:39:32 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09F66EC8;
        Thu, 26 Jan 2023 07:39:28 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id c145-20020a4a4f97000000b004f505540a20so278613oob.1;
        Thu, 26 Jan 2023 07:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3eXVcz1aWMWvEL81Aq0ojYY8G729mnAF/bOUjUUr3zQ=;
        b=TzY8VkATKLs422bCWpZosQ/0Fo7ABWG7nkKjkAGcPqIed/GAIPW9xuJPc9paOA/Ah9
         Glq6E2gI8aHe85ba1Yx7tQsOzOA3RQSYJrKNFYkeFpRK+GzFSFeWncPuRLLLz5BET6Or
         K6k1FEnHMRj8QF4dyydTdJp+U4scUNVYQsaelsa9ZBaBYCMw5KThTDTQWxq+0sA5PcOy
         lNQOONe0l9ADKEaUZfDppIvKFJ7fGCtkxaT1EweSqJ7WZ7Qt//PnUeGgZQdltP6m9/Zq
         zAPIssoRXXdAN2LdI/o33cD3EXvofOkK2SHqbqNxud9hV14Mvj+VDGfpeFP/xXwOWnEY
         CA4g==
X-Gm-Message-State: AFqh2kr1f6TrYYx6sfWfYX/2b/00tBGpFPlE2t14gBWCtKFQ1QmB5qOT
        5rPehqc0DBOEBQaDdGY7lERvI8sE3g==
X-Google-Smtp-Source: AMrXdXv71xtxYai5bEupVaQg3h+vYl/Y8MKgVR1kwvXabc9mt3Kbcy1UsGCvyzFhu8FjwxC6WWjNmQ==
X-Received: by 2002:a4a:e744:0:b0:503:1693:4b0f with SMTP id n4-20020a4ae744000000b0050316934b0fmr10195896oov.8.1674747567116;
        Thu, 26 Jan 2023 07:39:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z7-20020a4ab607000000b004a8eb1d8f1bsm624825oon.39.2023.01.26.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:39:26 -0800 (PST)
Received: (nullmailer pid 1544996 invoked by uid 1000);
        Thu, 26 Jan 2023 15:39:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>
In-Reply-To: <20230126131415.1453741-2-abel.vesa@linaro.org>
References: <20230126131415.1453741-1-abel.vesa@linaro.org>
 <20230126131415.1453741-2-abel.vesa@linaro.org>
Message-Id: <167474700298.1532391.8847992552740606457.robh@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
Date:   Thu, 26 Jan 2023 09:39:25 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2023 15:14:08 +0200, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
> for the new driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v2 version of this patch was here:
> https://lore.kernel.org/all/20230126124651.1362533-2-abel.vesa@linaro.org/
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * dropped the "ref src" clock
>  * dropped the usb-repeater property
> 
>  .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
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
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230126131415.1453741-2-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

