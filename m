Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98965FB97
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjAFGsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjAFGsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:48:17 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A96EC84
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 22:48:14 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x37so647454ljq.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 22:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cXbXihXV6MI6wPU9ELSqbbiHv+KuaPURdjnGGvB+ZTA=;
        b=cYMryEsQvFWnHfqF/NYykYbP8HFRy78QI1QVZQ7DZBobgJAYRNoW+a/87B90AxoXRa
         AxnZ0haUClHj4xHrH0aaU6IANIqYgqj+U8F9db20zC/CbOdv12qcUZPhJ+18ZXIgt0Cn
         /YZeWUnFzPg1tUyD4pTRfBlqNnUiTl0ERwPlSsctLIxWRFvM6hZHNRpv5Xir91RzHhib
         d6m/T8Us8MQdfFlfoW2V/UvwOpgFMybsCNfrK+CgndNGC/5dQMIUo+3hE6qn3NrSI9Ot
         xPT8QJSp8XpbjTut857FJ11o91LMSINEOGpV1+D11qfEE7WugiZUtXW46iGVGz+QT9SI
         a1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXbXihXV6MI6wPU9ELSqbbiHv+KuaPURdjnGGvB+ZTA=;
        b=bnfsF19JW0M3qkNYNFuNJ2UL+TrGtEL9OA/s5QC8paFc9XxZswPfAFVFXwNRQyl0TL
         AwtzheD/Pko49u/HlTPgUePMz1X4K5lGRcSsj6QO3gdVexDgvy/H2eUN4of7EKjuFGwE
         qjKUWdFXmTNIxchJk1ga3tcXVV1/TDRp6z2dQ+dqr4Y/FcIs7t958DpZFoTB36q0QJRZ
         SzNs5JkeNr0I3zc3UFNvnpZVHfoTOJ2lB2jIf0NIieORT3fJBVFYprgb6BzYbrETqw1w
         4sAdu05AoMF/ALulTl7SKTIlhHGqI5E7dZl/zz0HrXkagekyXjlFM+2vXHAtx3nUHxHa
         C3lg==
X-Gm-Message-State: AFqh2kp6Y3alKMwjE/bTF9728wvVTy+E17k8o7HDAzdvThdcK++Ypbr7
        ihv0HG0X0P8/uQi0VXu9/h2jdCz7eTGbOCfn8Yf7gg==
X-Google-Smtp-Source: AMrXdXvJgMr94Wo6/9butWn9yyjNDYyz5+lTRG/UM8O7dXWuk7sQFdwSnEx2/JhirmdBg/0HkQY+dDOG3HI1hKt3M9o=
X-Received: by 2002:a05:651c:2001:b0:27f:ee4c:3c2d with SMTP id
 s1-20020a05651c200100b0027fee4c3c2dmr685128ljo.466.1672987692487; Thu, 05 Jan
 2023 22:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20230104091922.3959602-1-bhupesh.sharma@linaro.org>
 <20230104091922.3959602-3-bhupesh.sharma@linaro.org> <167288699633.3289770.7520350746366547570.robh@kernel.org>
In-Reply-To: <167288699633.3289770.7520350746366547570.robh@kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 6 Jan 2023 12:18:00 +0530
Message-ID: <CAH=2Nty0+610LzrR9HG+31p-CF6DzoTF6yNhQZA2S=StkRVaCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: soc: qcom: eud: Fix identation issues in
 the example
To:     Rob Herring <robh@kernel.org>
Cc:     linux-usb@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        quic_schowdhu@quicinc.com, linux-kernel@vger.kernel.org,
        andersson@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 at 08:24, Rob Herring <robh@kernel.org> wrote:
>
>
> On Wed, 04 Jan 2023 14:49:22 +0530, Bhupesh Sharma wrote:
> > As noted by Konrad while reviewing [1], the example
> > node in the EUD yaml documentation has identation
> > issues.
> >
> > So fix them.
> >
> > [1]. https://lore.kernel.org/linux-arm-msm/20221231131945.3286639-1-bhupesh.sharma@linaro.org
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,eud.example.dtb: eud@88e0000: reg: [[0, 143523840], [0, 8192], [0, 143532032], [0, 4096]] is too long
>         From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230104091922.3959602-3-bhupesh.sharma@linaro.org
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

Ok, let me try and fix this via v2.

Thanks.
