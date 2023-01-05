Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B665E30C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjAECyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAECyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:54:05 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38353479D8;
        Wed,  4 Jan 2023 18:54:02 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id c20so16654734ilj.10;
        Wed, 04 Jan 2023 18:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CNKaGonGu+I02QEZvEk7d0YSoCmtvT6lkDN3iBcVJcQ=;
        b=kl6HDdSee4+ETiTnNENqUlOBvpNy0wIRAI86BETTMZxU+XJ40bYZMm3jFyKdzhmgBv
         tN4SmCsCK5PjBJlkbMFRq2ShKk4ZmA1GKh316itoyeVjzHEfb4XJ1jIj3RNZqGnqLdmg
         H9vcuDf3HGhBvCaWTJkbieoTnRNdSy7xb4hJh3uLOgjBBx6vHmTfw1LY+B3pQZDqpjfN
         BiJF4ToOoZG4Co5nxz0TrcfI3ISgzpZRuBeb4XoN9dmXx0Pt87qeShbn2WZ5rUYcjSfn
         nVuuYzKOeK9nU5UFek+clXfyOf3BgnIZf1k5nwna61DCPBWum/JcrDVRCkacpZUfoxJL
         Bugw==
X-Gm-Message-State: AFqh2kp5sxaTlACKAYdOKgWfrye+FmD8py1QF+d7j4CWtdBKzFUfzQBM
        lYzJTj07gjHSiIDxqDuFMQ==
X-Google-Smtp-Source: AMrXdXtYqUXNZ+i5YDmpzwIUU8B3ypJ+r8qwgK08X3a6FvGGIE7XfINtYr4VF10NsxsCe6SH+DudoA==
X-Received: by 2002:a05:6e02:60e:b0:302:aa41:43ad with SMTP id t14-20020a056e02060e00b00302aa4143admr43317218ils.20.1672887241190;
        Wed, 04 Jan 2023 18:54:01 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y72-20020a02954e000000b0036332a07adcsm11236500jah.173.2023.01.04.18.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 18:54:00 -0800 (PST)
Received: (nullmailer pid 3295146 invoked by uid 1000);
        Thu, 05 Jan 2023 02:53:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v1-2-9ccd7e652fcd@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v1-2-9ccd7e652fcd@linaro.org>
Message-Id: <167288699522.3289711.11095242316401354794.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: display/msm: document the display
 hardware for SM8550
Date:   Wed, 04 Jan 2023 20:53:58 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Jan 2023 10:08:44 +0100, Neil Armstrong wrote:
> Document the MDSS and DPU blocks found on the Qualcomm SM8550
> platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm8550-dpu.yaml      | 134 +++++++++
>  .../bindings/display/msm/qcom,sm8550-mdss.yaml     | 331 +++++++++++++++++++++
>  2 files changed, 465 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230103-topic-sm8550-upstream-mdss-dsi-v1-2-9ccd7e652fcd@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

