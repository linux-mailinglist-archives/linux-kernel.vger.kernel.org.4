Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC456D8412
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjDEQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjDEQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:49:01 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C4230F9;
        Wed,  5 Apr 2023 09:49:00 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-177b78067ffso39182381fac.7;
        Wed, 05 Apr 2023 09:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680713339;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YOm7tILvDPZI6czqCDOR13IkcnfefKihrcBUjqz0L8Y=;
        b=FBHtD7JQejEhsI9wObe4Eogffs+RpO1AYMOSZanKRSZbz6nSvco9Z0VsrVy16Oqgxj
         IJ6xsUy6EEGKBd7TJ8TVWU5cM76FlZUQgKQ2VAek5W3A7xu/CXJXwrenTYJQ6eyk/NYp
         b0t+7alzlWeT1OFbFK6TAoVbrg3NpDPr4UGOihwGNT9x2ZEYhBQeIn7cXEqXubvetQcA
         1SzRpLLJvK6UFqYyV5iLKgi2DN/E5X1kn0tGrqanausEBrLqEKLbHLvEL/CdOTc+40P7
         yAhrPhJjq/pTLPuwESRAbB0LDId+uOVEIR4yTk099t4gulmBh3tB5MiAGNhXhBUCbmIE
         ++XA==
X-Gm-Message-State: AAQBX9fGx+Bom8dVHn/GarV15ZSXMRT6A+HrCP3CUVaFbGx0dTL84ULg
        zx/JXYcLLGEGmI/GA4bK/g==
X-Google-Smtp-Source: AKy350bOWFf1ufKwVRHaSJOkmcOubEUaoDXmzwdrxIlRe4vQv0WbM2rbpalQ0GPhRcx5gis4QHzRZA==
X-Received: by 2002:a05:6871:90:b0:17e:de1c:c557 with SMTP id u16-20020a056871009000b0017ede1cc557mr4517825oaa.12.1680713339438;
        Wed, 05 Apr 2023 09:48:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m16-20020a9d7ad0000000b006a119c75ad8sm6996757otn.55.2023.04.05.09.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:48:59 -0700 (PDT)
Received: (nullmailer pid 2821005 invoked by uid 1000);
        Wed, 05 Apr 2023 16:48:57 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20230405-topic-master_stats-v1-1-1b1fa2739953@linaro.org>
References: <20230405-topic-master_stats-v1-0-1b1fa2739953@linaro.org>
 <20230405-topic-master_stats-v1-1-1b1fa2739953@linaro.org>
Message-Id: <168071287381.2812239.11751360706280715268.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: Add RPM Master stats
Date:   Wed, 05 Apr 2023 11:48:57 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Apr 2023 17:01:35 +0200, Konrad Dybcio wrote:
> The RPM MSG RAM contains per-RPM-master (e.g. APPS, ADSP etc.) sleep
> statistics. They let one assess which core is actively preventing the
> system from entering a true low-power mode.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/soc/qcom/rpm-master-stats.yaml        | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.yaml: properties:compatible: [{'const': 'qcom,rpm-master-stats'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.example.dtb: /example-0/stats: failed to match any schema with compatible: ['qcom,rpm-master-stats']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230405-topic-master_stats-v1-1-1b1fa2739953@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

