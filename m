Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39407722113
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjFEIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFEIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:34:06 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440AC7;
        Mon,  5 Jun 2023 01:34:04 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-777ac4344f9so19423739f.0;
        Mon, 05 Jun 2023 01:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685954043; x=1688546043;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FvMVzBFh2qIaLJzUc3itd2Y7Ptws11UXcErgWlt9W/U=;
        b=Uyl7ibfIhbM2lCd1QOH06Dp+0qgyPZf1OUPVt0Gr9k9t3DfVICMBWixr88/jjhX22o
         p019KECAV7ahIYthSSmdrbV5EvAikcN0K0zt8xi95qCv0bfGhgN08rZBB28tLdlAho/P
         BsfTssRHCLw9epmyfbaJTJyIqBDQvDtmkFZFeTihIl/ujPK0qbEsyHySzUrSv7J+Rfqi
         NOTq61FKNcIWfvIciY3rr78sq7oLdlQLIh+tOj62o8imjhYf+F+4oE21BNfWnKTAOYMD
         98iO1xpVSTedAfJX1sDpaHNEYJXYX3LNNJoZpaHtniKXsxbsg56kUDeElQwCk6SM1g43
         jrQw==
X-Gm-Message-State: AC+VfDxFqs8YaUiXhBviXLLWi8x/g4KMhMpRESMiffF7/I3muL9Zfq5L
        uL3QfuEhGoWvnEY32UuQcg==
X-Google-Smtp-Source: ACHHUZ5QAi3gJpHdm7Tj1gUW44mXOGsCdk/LqF2d6rfZDUpRsopLA0zibIELN/MSr7L9Mf9hF5UYZg==
X-Received: by 2002:a6b:740f:0:b0:777:91d5:c198 with SMTP id s15-20020a6b740f000000b0077791d5c198mr5849697iog.15.1685954043534;
        Mon, 05 Jun 2023 01:34:03 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z25-20020a6b0a19000000b00760f256037dsm545198ioi.44.2023.06.05.01.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:34:02 -0700 (PDT)
Received: (nullmailer pid 208976 invoked by uid 1000);
        Mon, 05 Jun 2023 08:33:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20230531-rpm-rproc-v1-6-e0a3b6de1f14@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-6-e0a3b6de1f14@gerhold.net>
Message-Id: <168595403816.208946.12766625011186229177.robh@kernel.org>
Subject: Re: [PATCH 06/14] dt-bindings: soc: qcom: smd-rpm: Use
 qcom,rpm-proc in example
Date:   Mon, 05 Jun 2023 02:33:58 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Jun 2023 09:08:22 +0200, Stephan Gerhold wrote:
> Use the new top-level rpm-proc node instead of having a dummy top-level
> /smd node that only contains the RPM but not other remote processors.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.example.dtb: /example-0/remoteproc-rpm: failed to match any schema with compatible: ['qcom,msm8916-rpm-proc', 'qcom,rpm-proc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230531-rpm-rproc-v1-6-e0a3b6de1f14@gerhold.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

