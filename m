Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB06B975E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjCNOKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjCNOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:10:38 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B3C85B36;
        Tue, 14 Mar 2023 07:10:36 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id g6so6434995iov.13;
        Tue, 14 Mar 2023 07:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803036;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AO9OtxWO9OtOvd5xefZPHLbbBm6bTV85U6hkSkYPrV8=;
        b=qfvWYoPONo7+N0dih6SL+t5yGhhiHor2VIxLDrfen9Y2vRWigc7dNEdRR5gxnqKZcS
         FKHZk5hS4EN5I/RNsxMASwN5X4Aq3oVelvTkkqP/uA71yEnIPM/ADVj6IYy6bq/8C+Ca
         00qonOUza++I6fZDvQhXfeBsc0o14zcb8HvlEM40ihZ01UNMarweWG4PadYBwImplEx+
         f0lKLq0HpDMZvtHNgKRPYqNZBUxIM8IYUyNDaAhsZFSPrZ56awgA4nrdRrAMohV26kX9
         O+qrwGI5/7HzlYHIXMiUPL++Gh7S+6G+ZNtEeg6+tskTWeLcAVs2gwk4ZzXIIl7drA4j
         yzXg==
X-Gm-Message-State: AO0yUKW+6Ie1l3A+5rOzJrMzzuWjXjKZgreiPDT8/IEkvXj/DOA1vY47
        LNMe+4U78TMcu0ikXRt3rg==
X-Google-Smtp-Source: AK7set9d2oLzX+5QU6qtEvSgErDHV3fNQtwQocr4/uY3w5g3N8Pa9Fta1wUTyAO/xYzhNT6Da8a4Uw==
X-Received: by 2002:a5d:8594:0:b0:74c:b436:4a9e with SMTP id f20-20020a5d8594000000b0074cb4364a9emr24021636ioj.16.1678803035864;
        Tue, 14 Mar 2023 07:10:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id g21-20020a02bb95000000b004051a7ef7f3sm800531jan.71.2023.03.14.07.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:10:35 -0700 (PDT)
Received: (nullmailer pid 83783 invoked by uid 1000);
        Tue, 14 Mar 2023 14:10:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
In-Reply-To: <20230313124040.9463-3-quic_kbajaj@quicinc.com>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
 <20230313124040.9463-3-quic_kbajaj@quicinc.com>
Message-Id: <167880254436.25736.2826081458133350078.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: msm: Add bindings for multi
 channel DDR in LLCC
Date:   Tue, 14 Mar 2023 09:10:19 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 18:10:37 +0530, Komal Bajaj wrote:
> Add description for additional nodes needed to support
> mulitple channel DDR configurations in LLCC.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/msm/qcom,llcc.example.dtb: system-cache-controller@1100000: reg: [[17825792, 2097152], [19922944, 327680]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/msm/qcom,llcc.example.dtb: system-cache-controller@1100000: reg-names: ['llcc_base', 'llcc_broadcast_base'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230313124040.9463-3-quic_kbajaj@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

