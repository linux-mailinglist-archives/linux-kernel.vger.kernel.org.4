Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C014644369
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiLFMrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiLFMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:47:31 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75E424F;
        Tue,  6 Dec 2022 04:47:28 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1445ca00781so10659624fac.1;
        Tue, 06 Dec 2022 04:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRbJnoAPdyVeKSpAdDaecdS/ZR6oAJxEcKGzEYJMYw0=;
        b=eeHNYvEqru0tU9fsBL1/bkm91uWkm/y0V+oysIoo2Vk/HRtadL0J8x7Ca0VbvMieUq
         PIf8vzrpoHWDg7bXsG4kItHvtls3JKl/4nX0/aHK+sF1yQKVO64H9DFepaya4AF2qr6u
         Bzp7gOSx6pnfbsODe0GM763SxIWktkahQXr2gASibA6xaw6ulrvsKIMXbgoDubvAaGUp
         a0rd++TjUNFn4B82T37qJzRTaFQL6wbNhVEXbPDQwn5KjpGbHTb4Xpzu/udLqKBRV1v/
         M+Xi5eS+J/EPmXI1en1/TkZKfdEaPYNTaa8/aWqPy1cJGaA8DQNGU2Ql6zv8TRIMBerR
         gtGw==
X-Gm-Message-State: ANoB5plRHmNIZx+NMlYumtDwC34R5hC4mzHIyib8PhwBHzODONBSJXeT
        Os2UX4x9Jzov9CiYdkmAlw==
X-Google-Smtp-Source: AA0mqf5Rm0o3BU5PrNXKP/4vKT9EPUdrmyLN5uG/7ZjQ/O4xf0ra3tTsNcE89VV/V15aEllCorbAZw==
X-Received: by 2002:a05:6870:5781:b0:13b:c610:e30b with SMTP id i1-20020a056870578100b0013bc610e30bmr39970200oap.134.1670330848000;
        Tue, 06 Dec 2022 04:47:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r16-20020a4a3710000000b004a0b424f99dsm3656548oor.43.2022.12.06.04.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 04:47:27 -0800 (PST)
Received: (nullmailer pid 176446 invoked by uid 1000);
        Tue, 06 Dec 2022 12:47:26 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dmitry.baryshkov@linaro.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        airlied@linux.ie, quic_sbillaka@quicinc.com, andersson@kernel.org,
        agross@kernel.org, sean@poorly.run, robh+dt@kernel.org,
        vkoul@kernel.org, konrad.dybcio@somainline.org, airlied@gmail.com,
        quic_abhinavk@quicinc.com, dri-devel@lists.freedesktop.org,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1670281694-13281-3-git-send-email-quic_khsieh@quicinc.com>
References: <1670281694-13281-1-git-send-email-quic_khsieh@quicinc.com>
 <1670281694-13281-3-git-send-email-quic_khsieh@quicinc.com>
Message-Id: <167033052405.165993.699264089064134340.robh@kernel.org>
Subject: Re: [PATCH v9 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Date:   Tue, 06 Dec 2022 06:47:26 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 15:08:11 -0800, Kuogee Hsieh wrote:
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
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>`
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/msm/dp-controller.yaml:108:21: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/display/msm/dp-controller.example.dts'
Documentation/devicetree/bindings/display/msm/dp-controller.yaml:108:21: mapping values are not allowed here
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/msm/dp-controller.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/display/msm/dp-controller.yaml:108:21: mapping values are not allowed here
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1670281694-13281-3-git-send-email-quic_khsieh@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

