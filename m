Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED49F74EFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjGKNOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjGKNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:13:58 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F00E60;
        Tue, 11 Jul 2023 06:13:54 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-78666f06691so190508239f.0;
        Tue, 11 Jul 2023 06:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689081233; x=1691673233;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NWpP4+fEKqWe2iQI82jLwDEACDw2gqnxMbAmFifLElw=;
        b=NZNU/OFmLgLeAWyJesl0g666kJ5GAIklW8smtcdjn5gO5HkDqx8ce0ynsAlsB5YoK4
         95Bo/PjZSrqWumrLni65k1PwEmS3OlckHUOmBs7WJzVFpDF/8I8HWw+cZiW7oIWrxOxE
         c5WCDbMM6Xb4LbnB9e05uG0D37DTaz/z32h4denerFyCsgpMF3DzENfl9+u5D+IgUxj4
         A1C0gAc/jP894GxIlOQESuJ42iJngEzjR8XoY+pZbrV8nkIhPbnwhZQYCUBDE651CSdK
         VnninPVvDGmyFlGtQH7HN2aq7YAzSTV+OF1moHlPv1+nNQewo8thVR9WxtewTN+s/hoh
         HAUw==
X-Gm-Message-State: ABy/qLYAQsLpTKfr7xA5iCELIJvQlLKs05RCbrAyW4ky9fRQN0fcsefD
        wCJyDoBSsttW5Nytjfe7dwBqPqof6Q==
X-Google-Smtp-Source: APBJJlH0f3M58j0GXXQis+UmNXxff+m6WDBMiwo9rAt1gCISYr4pmF6Cv55ooDei9fMghPrqjHeWFg==
X-Received: by 2002:a5e:c910:0:b0:77e:3d2f:d1f4 with SMTP id z16-20020a5ec910000000b0077e3d2fd1f4mr14965853iol.15.1689081233268;
        Tue, 11 Jul 2023 06:13:53 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c21-20020a056602335500b0078702f4894asm620420ioz.9.2023.07.11.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:13:52 -0700 (PDT)
Received: (nullmailer pid 802164 invoked by uid 1000);
        Tue, 11 Jul 2023 13:13:50 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-2-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <20230708-topic-rpmh_icc_rsc-v1-2-b223bd2ac8dd@linaro.org>
Message-Id: <168908123059.802078.8312643733472251777.robh@kernel.org>
Subject: Re: [PATCH 02/53] dt-bindings: interconnect: qcom,bcm-voter: Add
 qcom,bcm-voter-idx
Date:   Tue, 11 Jul 2023 07:13:50 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Jul 2023 14:18:01 +0200, Konrad Dybcio wrote:
> In order to (at least partially) untangle the global BCM voter lookup
> (as again, they are shared throughout the entire system and not bound to
> individual buses/providers), introduce a new required property to assign
> a unique identifier to each BCM voter.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,bcm-voter.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.example.dtb: rsc@18200000: bcm-voter: 'qcom,bcm-voter-idx' is a required property
	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.example.dtb: bcm-voter: 'qcom,bcm-voter-idx' is a required property
	from schema $id: http://devicetree.org/schemas/interconnect/qcom,bcm-voter.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230708-topic-rpmh_icc_rsc-v1-2-b223bd2ac8dd@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

