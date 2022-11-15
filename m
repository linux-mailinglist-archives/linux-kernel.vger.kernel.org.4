Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296F4629F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiKOQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKOQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:45:51 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF31F3;
        Tue, 15 Nov 2022 08:45:48 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id b124so15460231oia.4;
        Tue, 15 Nov 2022 08:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpB0DnIAvfrGbGP924nojTI5rkoGhC08JADkFVFEIXw=;
        b=aZAMal82Thq0gebilD+8oqy1CeiGIuSTeQMX6T3iPTCPg0dvMZHWcDyjHap3SNlLJ6
         4rISyixM+XjtQUTvQYbb+Ei2wareLY/7DT/+5r6Nx/I5oPBoaz+h3tnAkldkNsvKhqXb
         aM6RGiqMzov5EtyotaK1yQgrTDWUodrv7DfulosbwSnN/RTWy7o9riuCwYc/zALlvKGz
         nKafj9lZdc/yO3hKUm1X2nBPtKiohjs9GE0Z3jyb2w42Dz6RZKsyaN3aKHWjeIh1Nnap
         mxWJJu2kgdKmatXGTrwL2gIzN5F41vJ3W8Rof3hfSPGZIjsC8UCfny9vpWFAoJ5Esdba
         bBLA==
X-Gm-Message-State: ANoB5pmnZUAHx8a7HVfvH1sOOXpd0bEfBGHt8UF4BP3usC0ovEYTNBgM
        DwdSft5TeXqyYAx2LiiC8g==
X-Google-Smtp-Source: AA0mqf5VUkKcLRvmerOG2+29l48fzbwkTMibacpwCXqHvIyVT9sdB9182Jgw1CU4ZxTjs6VTEzUywg==
X-Received: by 2002:a54:4685:0:b0:35a:1078:5f90 with SMTP id k5-20020a544685000000b0035a10785f90mr794917oic.117.1668530747395;
        Tue, 15 Nov 2022 08:45:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u29-20020a0568301f5d00b00660fe564e12sm5522176oth.58.2022.11.15.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:45:46 -0800 (PST)
Received: (nullmailer pid 1091300 invoked by uid 1000);
        Tue, 15 Nov 2022 16:45:47 -0000
Date:   Tue, 15 Nov 2022 10:45:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, quic_kalyant@quicinc.com,
        swboyd@chromium.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, vkoul@kernel.org,
        quic_vpolimer@quicinc.com, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
Subject: Re: [PATCH v2 01/12] dt-bindings: display: msm: Add qcom,sm8350-dpu
 binding
Message-ID: <20221115164547.GA1088214-robh@kernel.org>
References: <20221115111721.891404-1-robert.foss@linaro.org>
 <20221115111721.891404-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115111721.891404-2-robert.foss@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:17:10PM +0100, Robert Foss wrote:
> Mobile Display Subsystem (MDSS) encapsulates sub-blocks
> like DPU display controller, DSI etc. Add YAML schema for DPU device
> tree bindings
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm8350-dpu.yaml | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

But since there is a dependency, no idea if this passes validation.
