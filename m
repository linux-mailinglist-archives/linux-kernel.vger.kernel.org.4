Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8257A66288C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjAIOax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjAIOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:30:47 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC5B1659C;
        Mon,  9 Jan 2023 06:30:45 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso5251357otn.2;
        Mon, 09 Jan 2023 06:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lnvWjGkJXKCbxJNpIXGvIrUGwer2KE72GLT13UzJPJM=;
        b=WvqozAVSGlJzNrkagP47k+xDE+z4V62+pVg6NTzz/QLTdXKdaFdJoFBZPBmIEHrh3Q
         I8hmmQc727vXeEIKTm/PgC/i0VzooGUYy+bt7G88Z+LL7vHzal80PseCEJRM055gaPqw
         DRonqvu1ak+fKrsL0pbDCgzfK4c78GQttYBpSVLUgsT8KIOpQEW5ylVvSqNuECQz/ovW
         SO12y8beqdtMPQqsUMcDpJWoIDjwlEQ/4Ux+berB0m3TXPuglnKiukiKQMHIZ9z9cmNP
         5P8kLy7e3H2Azb4K1s4lO99cQehVPTHhWSzKqlEkguvizkf6euZM3Kx3Zm/oazYShNYQ
         x7mA==
X-Gm-Message-State: AFqh2kq39tVRH/gZmG5gBNiSNe889I+dIC0lIbD0fXm3y5ev2ubK6am6
        2qlPKZk7npsmA0FKhUA4Lg==
X-Google-Smtp-Source: AMrXdXsbnWLocs9cJBrnQ0sJkMZX7KSKHILdb1IwjdJTuilsjNdiW3psm5xNI4+SRYShJnGsLC5OAg==
X-Received: by 2002:a9d:69c4:0:b0:66e:a5db:c553 with SMTP id v4-20020a9d69c4000000b0066ea5dbc553mr35961709oto.19.1673274644592;
        Mon, 09 Jan 2023 06:30:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b19-20020a9d6b93000000b0066ca61230casm4615429otq.8.2023.01.09.06.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:30:43 -0800 (PST)
Received: (nullmailer pid 237517 invoked by uid 1000);
        Mon, 09 Jan 2023 14:30:36 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v3-3-660c3bcb127f@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v3-3-660c3bcb127f@linaro.org>
Message-Id: <167327376817.61320.5444570222214850129.robh@kernel.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: display/msm: document MDSS on SM8550
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


On Mon, 09 Jan 2023 11:15:19 +0100, Neil Armstrong wrote:
> Document the MDSS hardware found on the Qualcomm SM8550 platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm8550-mdss.yaml     | 331 +++++++++++++++++++++
>  1 file changed, 331 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dts:21:18: fatal error: dt-bindings/clock/qcom,sm8550-dispcc.h: No such file or directory
   21 |         #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230103-topic-sm8550-upstream-mdss-dsi-v3-3-660c3bcb127f@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

