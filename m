Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95C648241
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLIMO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:14:53 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1BC1743C;
        Fri,  9 Dec 2022 04:14:52 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id e205so4303365oif.11;
        Fri, 09 Dec 2022 04:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kI7BbdyAUV/eNarvTgWcZoX1xauTnHS7x8JJjE7aAYY=;
        b=H22f2eUpGiDd7CwkA7y2/NdOiC8kNvSs78eGvAb5QoEBJpG/ckz6TnBBPcIm2ZF9TZ
         ghfn7Cs9kJu2zDZYNJXStZqos6Bilgb/Nl/HGcpLHAPJMd5FJS41RadYWpxYd3hW6itx
         da2Gt2aGy+Is/vJKUsH22uH2IVJJo93Ho/rawg8coQI+i+1xtk0glz+L6VbVL3PA+JZs
         B64ixJIuFJoGyuSLU9squll6+r7uqDBWDrjHdMeDtC7M+9XHVV6PyLMPg76cyVM2sKp4
         85jC0TBZWhkgqvbS0oDkUBe5sW1jY0XjYni2lCAEp+FWxevdRPtQTcyQsBx4n8Y8zJwQ
         sPew==
X-Gm-Message-State: ANoB5pnda16u1FgDR0e8NnjABxhbmoHwmUDovaa7v8RGCU+BTELxmjzg
        ZFT9Ebwf0XbrKD2fKWiOxA==
X-Google-Smtp-Source: AA0mqf4FRI86zMRlAtzC+h2pF/uE9HwQGgMNCY3G4dmWrGrHC4nf3HUzituKruhqW4XxFd90+aIcLQ==
X-Received: by 2002:aca:3dd5:0:b0:35a:3c3d:34d5 with SMTP id k204-20020aca3dd5000000b0035a3c3d34d5mr2111798oia.14.1670588091153;
        Fri, 09 Dec 2022 04:14:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b23-20020aca2217000000b0035b99bbe30bsm447422oic.54.2022.12.09.04.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 04:14:50 -0800 (PST)
Received: (nullmailer pid 2822350 invoked by uid 1000);
        Fri, 09 Dec 2022 12:14:49 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     vkoul@kernel.org, daniel@ffwll.ch, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, dmitry.baryshkov@linaro.org,
        freedreno@lists.freedesktop.org, agross@kernel.org,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, devicetree@vger.kernel.org,
        quic_sbillaka@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, airlied@linux.ie,
        quic_abhinavk@quicinc.com, andersson@kernel.org, airlied@gmail.com,
        sean@poorly.run
In-Reply-To: <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com>
References: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com>
 <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com>
Message-Id: <167058798233.2819544.12292613321491007286.robh@kernel.org>
Subject: Re: [PATCH v11 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Date:   Fri, 09 Dec 2022 06:14:49 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 08 Dec 2022 14:36:52 -0800, Kuogee Hsieh wrote:
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
> Changes in v11:
> -- add endpoint property at port@1
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>`
> ---
>  .../bindings/display/msm/dp-controller.yaml        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: properties:required: ['port@0', 'port@1'] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: properties: 'required' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml: ignoring, error in schema: properties: required
Documentation/devicetree/bindings/display/msm/dp-controller.example.dtb:0:0: /example-0/displayport-controller@ae90000: failed to match any schema with compatible: ['qcom,sc7180-dp']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

