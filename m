Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750F662882
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjAIOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjAIOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:30:40 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975E5A1A7;
        Mon,  9 Jan 2023 06:30:39 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1322d768ba7so8758398fac.5;
        Mon, 09 Jan 2023 06:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dw1mx8WSg2YN8QfEa/EeEF+6wNa6Dwq8nHk5GLyrbCA=;
        b=qFj3PFfC4C9Q6c2VQ2G+0JbmW3bSJLrjAzTKO9KB/hQHXSrQWXWDtCNmWq49kOdtcl
         7qzvCQKswpzqP9eY9n27WKPV8WX4Xx4wlf00oCQwZDhjqhBj3gDxoYr8uQusKOghbSYP
         /9IHaV/SNxKVu2g6+H6F4963TLxOBb+1QGs9c3N03EVO6H8YARI30N0wVoveDSGYCNKG
         9tzrtiG7carBXUxwsUeTkuVr+htNJZbQZ/OQLSxxrdJNhcphxA+M6GxImV4rCWEbCK+j
         j4kPMqRdCBH/sfQ4WqxJ5vHnePpzovw3XYoxeqbKI6ROcrIEkKIApkArmZFgizwfT7fs
         aSEg==
X-Gm-Message-State: AFqh2kqbXZ19PIkxHSwboVzKlwPFmehIhVJ0NGWAFz2bVxHnTIB8Lyrg
        VU2UuANRdiYsz42ynfogHf2CGk9XLw==
X-Google-Smtp-Source: AMrXdXuhXryTUekpsWEZueO52n4IgWGu3chWGQzHGt/JQgLTSQ+mhMBV+oqTEtDmzBPk3PRplCEiHw==
X-Received: by 2002:a05:6871:4497:b0:151:89b:a657 with SMTP id ne23-20020a056871449700b00151089ba657mr9629377oab.19.1673274638814;
        Mon, 09 Jan 2023 06:30:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eq2-20020a056870a90200b0014fb4bdc746sm4235849oab.8.2023.01.09.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:30:38 -0800 (PST)
Received: (nullmailer pid 237515 invoked by uid 1000);
        Mon, 09 Jan 2023 14:30:36 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Rob Clark <robdclark@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v3-2-660c3bcb127f@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v3-2-660c3bcb127f@linaro.org>
Message-Id: <167327376724.61122.3156617498910384494.robh@kernel.org>
Subject: Re: [PATCH v3 2/7] dt-bindings: display/msm: document DPU on SM8550
Date:   Mon, 09 Jan 2023 08:30:36 -0600
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


On Mon, 09 Jan 2023 11:15:18 +0100, Neil Armstrong wrote:
> Document the DPU hardware found on the Qualcomm SM8550 platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm8550-dpu.yaml      | 134 +++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.example.dts:21:18: fatal error: dt-bindings/clock/qcom,sm8550-dispcc.h: No such file or directory
   21 |         #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230103-topic-sm8550-upstream-mdss-dsi-v3-2-660c3bcb127f@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

