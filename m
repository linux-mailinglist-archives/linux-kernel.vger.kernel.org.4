Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C93164643D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLGWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:47:22 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2612983E8D;
        Wed,  7 Dec 2022 14:47:21 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id l127so22423531oia.8;
        Wed, 07 Dec 2022 14:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cRmcqMTQRbqCVVPhtzGwVwk+S86YVEqZnamcUPsWuw=;
        b=YEfSwL7KdqriBiBRTfuFoEtbawfx3D1hfTtXDap+QSEY5QdTtFDqdhCLn0L8QNByWj
         2LqAMp8SN5yMv5itiL1P3crHU8Wde7UipZvZEMngi6JLLwUiqvfDzfs94bz+J6LV/Col
         7n16z+qB7MIxbndXsRoeULqnHniZQkrmVTVcVgEeG+HcbnWFQvv6mh1kX3DekHbwNrJd
         4VEJZCFqI6TqKQiBwSdYybhC4fCkkPKq1GySDNCF5XVz2YiwrsNdpf/tMyJLXtf5i3og
         nIiPS8/nKaKly/oKO/kK1YWNJidgfrSpi2Y2tFYiK/mDjYx1PiakUc1an6xJrQuYeQJo
         2gCw==
X-Gm-Message-State: ANoB5pnYimu/JD3kMMYMBWlUS4AUHdq7f5/xGcNse0y60/a5gny8OcrZ
        yLH9cEZHDTdLtARjVVjh0w==
X-Google-Smtp-Source: AA0mqf5UlSOz+vfnlBDLHjJdPNx/RAAKOFNV0hMbjpB8wdnbtdb+4ZbqIsJvE/QfEIFpIlrXEl8IaQ==
X-Received: by 2002:a54:4506:0:b0:35b:9cc2:bfa7 with SMTP id l6-20020a544506000000b0035b9cc2bfa7mr26513888oil.263.1670453240350;
        Wed, 07 Dec 2022 14:47:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d15-20020a056830138f00b0066e64c59bbcsm10705775otq.6.2022.12.07.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:47:19 -0800 (PST)
Received: (nullmailer pid 3099979 invoked by uid 1000);
        Wed, 07 Dec 2022 22:47:18 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     agross@kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, sean@poorly.run, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, airlied@gmail.com,
        konrad.dybcio@somainline.org, swboyd@chromium.org,
        quic_abhinavk@quicinc.com, andersson@kernel.org, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, airlied@linux.ie,
        krzysztof.kozlowski+dt@linaro.org, freedreno@lists.freedesktop.org,
        dianders@chromium.org, quic_sbillaka@quicinc.com,
        robh+dt@kernel.org
In-Reply-To: <1670432278-30643-3-git-send-email-quic_khsieh@quicinc.com>
References: <1670432278-30643-1-git-send-email-quic_khsieh@quicinc.com>
 <1670432278-30643-3-git-send-email-quic_khsieh@quicinc.com>
Message-Id: <167045316457.3098064.10722096707360943971.robh@kernel.org>
Subject: Re: [PATCH v10 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Date:   Wed, 07 Dec 2022 16:47:18 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 08:57:55 -0800, Kuogee Hsieh wrote:
> Add both data-lanes and link-frequencies property into endpoint
> 
> Changes in v7:
> -- split yaml out of dtsi patch
> -- link-frequencies from link rate to symbol rate
> -- deprecation of old data-lanes property
> 
> Changes in v8:
> -- correct Bjorn mail address to kernel.org
> 
> Changes in v10:
> -- add menu item to data-lanes and link-frequecnis
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>`
> ---
>  .../devicetree/bindings/display/msm/dp-controller.yaml      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/msm/dp-controller.yaml:108:21: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/display/msm/dp-controller.example.dts'
Documentation/devicetree/bindings/display/msm/dp-controller.yaml:108:21: mapping values are not allowed in this context
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/msm/dp-controller.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/display/msm/dp-controller.yaml:108:21: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1670432278-30643-3-git-send-email-quic_khsieh@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

