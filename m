Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70765E313
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAECyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjAECyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:54:09 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF40A479E4;
        Wed,  4 Jan 2023 18:54:05 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id y2so20496318ily.5;
        Wed, 04 Jan 2023 18:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2U2LP/PrGLivefuel6MGYPY+slv2LEFjdHU/ynY8sag=;
        b=x/r80iEbPk81oyAAuwQDPqJjd1JmcpduXzo0i36+a34w1t7GkHyoGb3Fgd3nVBc8rH
         ddZjWkQrIBkR6V/mC0khxUzQH4u4v4XGFuh0zNqCvtNNG7anWGyHv2L7hPCNU3TEMoao
         ZOy+SNTzWrKOfGTWDg80iJQXOCSEhQ4s2nM9ci1qAFA74wYgQmQE0myYj+jjmlR/C4Va
         FYztPpJcOk5wXS/7y+6h1jVj2Ms53HMvxR4lpV4o/Gqc1/k85j/RThZ1B8fD0RUzGXgF
         5sW4tXXUZUODa8g0vYDxRLAiIvKkWhmMvvaMTHkVLQ4vMdpOssTYeWXxPVCCg91KfJGg
         5rMQ==
X-Gm-Message-State: AFqh2kokffQOkeCWZhsPCIGudJFbAcvHe95OadtUenLObS68sgxpOe4j
        2BW5znvF8kL1AfUwMJRufg==
X-Google-Smtp-Source: AMrXdXsgigb1TTZN/WfMLsd6h8c/dYfxRpHtFtcZdqWmx/2sFVLeEl9+EFVwNeDmfntVBmYEpMrZrw==
X-Received: by 2002:a05:6e02:e41:b0:30c:1b36:73af with SMTP id l1-20020a056e020e4100b0030c1b3673afmr17356804ilk.25.1672887245110;
        Wed, 04 Jan 2023 18:54:05 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g11-20020a02a08b000000b0039c492ae300sm10902118jah.114.2023.01.04.18.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 18:54:04 -0800 (PST)
Received: (nullmailer pid 3295149 invoked by uid 1000);
        Thu, 05 Jan 2023 02:53:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-usb@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        quic_schowdhu@quicinc.com, linux-kernel@vger.kernel.org,
        andersson@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230104091922.3959602-3-bhupesh.sharma@linaro.org>
References: <20230104091922.3959602-1-bhupesh.sharma@linaro.org>
 <20230104091922.3959602-3-bhupesh.sharma@linaro.org>
Message-Id: <167288699633.3289770.7520350746366547570.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: soc: qcom: eud: Fix identation issues in
 the example
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


On Wed, 04 Jan 2023 14:49:22 +0530, Bhupesh Sharma wrote:
> As noted by Konrad while reviewing [1], the example
> node in the EUD yaml documentation has identation
> issues.
> 
> So fix them.
> 
> [1]. https://lore.kernel.org/linux-arm-msm/20221231131945.3286639-1-bhupesh.sharma@linaro.org
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,eud.example.dtb: eud@88e0000: reg: [[0, 143523840], [0, 8192], [0, 143532032], [0, 4096]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230104091922.3959602-3-bhupesh.sharma@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

