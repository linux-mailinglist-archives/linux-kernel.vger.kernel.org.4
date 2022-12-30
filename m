Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82E5659A95
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiL3Qeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiL3Qef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:34:35 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31DBFDF;
        Fri, 30 Dec 2022 08:34:33 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id o8so11531934ilq.6;
        Fri, 30 Dec 2022 08:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aIAHarDIoUwGLglqR9Cq1cAuIikz32MrjOcIZVaihrc=;
        b=V6AZ5ocKh0eNnT3Qd9nfa0lh3a3HmgoLG4WUSEd2LF4Y+9Msz6ylO9qnAx+XiHSVH1
         Wmy/rLGuqGn8IV0abi7m+3DgrD/XXtJ/WEy1gtlgrG87MxnihZf2i5Pkw14O/46iz3cT
         xFiKQroZlN2joqGC2tJxhzsZjewGeYH05LbJoGOb5HeZ94YxRqQ0KzAeCdKDDB0AnAv0
         SOo+lN1gpljIfsKJXnQdb7Bvz5wq3+XN4SBL67yf6Bz/JXih2X8TQ29tPba52omHySbI
         EWBeMd0EFMFOtR77WriprNdSg8yuaJrYE3lVF24nplYcMFKk9JNXw/FS/adf2Tlo3CXy
         Y4WA==
X-Gm-Message-State: AFqh2kp6PfLJ25X7Y+jKcB19kyR8eLRBNQ2Y2+4mnrSsr7o6XU7bvdhn
        mQOOA/QCuQc5ciwJ0XRo/Q==
X-Google-Smtp-Source: AMrXdXv29Iz5nqn62So3TGHNqf5f780laIw1LKCUEjLN91zFX93RB1b6KXQjmbZTq1l6jHQbsWKKpQ==
X-Received: by 2002:a92:bf0c:0:b0:30c:3c0:7a56 with SMTP id z12-20020a92bf0c000000b0030c03c07a56mr10099325ilh.5.1672418073087;
        Fri, 30 Dec 2022 08:34:33 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u4-20020a02cb84000000b003762308fe54sm6928229jap.93.2022.12.30.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:34:32 -0800 (PST)
Received: (nullmailer pid 1935055 invoked by uid 1000);
        Fri, 30 Dec 2022 16:34:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Iskren Chernev <me@iskren.info>
In-Reply-To: <20221209-dt-binding-ufs-v2-3-dc7a04699579@fairphone.com>
References: <20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com>
 <20221209-dt-binding-ufs-v2-3-dc7a04699579@fairphone.com>
Message-Id: <167241769341.1925758.17856681634949446114.robh@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: ufs: qcom: Fix sm8450 bindings
Date:   Fri, 30 Dec 2022 10:34:28 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Dec 2022 08:42:07 +0100, Luca Weiss wrote:
> SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
> bindings and the example to match.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: Unevaluated properties are not allowed ('reg-names' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221209-dt-binding-ufs-v2-3-dc7a04699579@fairphone.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

