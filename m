Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F976F9FD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjEHG1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHG05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:26:57 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BB930E8;
        Sun,  7 May 2023 23:26:56 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6a5e905e15aso1513260a34.1;
        Sun, 07 May 2023 23:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527216; x=1686119216;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VIIsg81nx2YWfo/hbvJ1Tg3wCjn3Krug/S2LD6RUpvM=;
        b=WzPmJeV8FCQl+GhVT9+Y8oSguA9mZRWVPCjxkWmpmuy4HQm39ep7vAg+C6Zii0RDEB
         s2ozymDoraMeTbFCmG/SxM6Xn8jyjPSicliqbeO7WcNzBC5PXx0reM7uAn8HxOfRPRiC
         GANdGNjcfVocMChnQVtadUjYC74vTre0zwyQciPesyYGFScbzB1mkV1zr+Y4OPABk0JE
         Nj5wOBGWN3wRimaTY47ceNseDF499nscbdTNA8J2F4ldJQyH+MKPiNugCQVXLGq4V6ow
         3G9bn0goChIvAquASA11kmNOm3iiHnq+JPqLWlrYta0nmF5QbGZtRWMkbDsg5G3ujDCh
         cIfg==
X-Gm-Message-State: AC+VfDx5PHpEjATxUnIBcxlkhdDJeXQdE1ozdTThYMoHvHwEiS0AN8ME
        wslbedKdN1w/ZzSYfITrAA==
X-Google-Smtp-Source: ACHHUZ55oI53CjZWp9/PJbct2mXVHCl8NxRuxFEVisaxgWEGvdmnVDTw+6ugeAENdSEW5Gn0o4pQrg==
X-Received: by 2002:aca:d19:0:b0:38d:15c7:367e with SMTP id 25-20020aca0d19000000b0038d15c7367emr3853213oin.49.1683527215578;
        Sun, 07 May 2023 23:26:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e17-20020a05680809b100b0038cabfcb3ccsm5256956oig.15.2023.05.07.23.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 23:26:54 -0700 (PDT)
Received: (nullmailer pid 213412 invoked by uid 1000);
        Mon, 08 May 2023 06:26:53 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     rui.zhang@intel.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, amitk@kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org
In-Reply-To: <345a61f6cd56e504e1f82ac2328ffa6d89e2d510.1683523370.git.quic_varada@quicinc.com>
References: <cover.1683523370.git.quic_varada@quicinc.com>
 <345a61f6cd56e504e1f82ac2328ffa6d89e2d510.1683523370.git.quic_varada@quicinc.com>
Message-Id: <168352721179.213297.4966890333203565240.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Date:   Mon, 08 May 2023 01:26:53 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 08 May 2023 11:02:38 +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> [v2]:
> 	Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 	for the tip to make qcom,ipq8074-tsens as fallback.
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:67:9: [error] syntax error: expected <block end>, but found '-' (syntax)
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:69:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/thermal/qcom-tsens.example.dts'
Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:67:9: did not find expected key
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/thermal/qcom-tsens.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml
./Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:67:9: did not find expected key
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/345a61f6cd56e504e1f82ac2328ffa6d89e2d510.1683523370.git.quic_varada@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

