Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04DD60E0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiJZMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiJZMgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:36:07 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972984E5B;
        Wed, 26 Oct 2022 05:36:03 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-13b23e29e36so19030671fac.8;
        Wed, 26 Oct 2022 05:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kV4Oxfken2/ulM3nGzbwK4CyKckevFO7gguVOI5Hhm4=;
        b=Ksf/Lu4CUcEYmyb2vNavBe6fXuU4ioTcRyFEqQ5lg93haCQ7g9xw2rVNqY7dtLrSwC
         EJ5P2HnY+/gKOjOp53y7fZCCk/jfoQUg0NU429CS1meu/knm4cMWlwVWvnZMqaFcz/5y
         4hi329SpvBCx5FwoSEa3sXWIEa3A195qfKjW3LBiIJAAfefvDWKm04Za0w7L9/+gWNZP
         e2HPltsoU0kd+tJrg4X8XT6LREnAKyk/ubTYnOFCTyzxJNwZ/SREh3/1VgVN/HO3mWVm
         N43Suu9lxWY2rjJNkGF0UVT2CX7dmZmvdNY2rOwGUCLUzapAzRpz/rqrRcEmpXBo+/iZ
         4IqQ==
X-Gm-Message-State: ACrzQf3oHSSxqOBE+B1EnTK87xRiISM6MdGS3tYZnm2Uly+QArYdwinW
        mZXdoT4IRixDumLAFyQ/3Q==
X-Google-Smtp-Source: AMsMyM7avrAhnzOr2x6d70zZ/hy8bXiFehrVQMoacKHi/oBio7h7PU7naRlNqMgIa18WyCNJRmnZHg==
X-Received: by 2002:a05:6870:8910:b0:131:2f31:dc1c with SMTP id i16-20020a056870891000b001312f31dc1cmr2029210oao.290.1666787762448;
        Wed, 26 Oct 2022 05:36:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d22-20020a4ad356000000b004805e9e9f3dsm2123538oos.1.2022.10.26.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:36:01 -0700 (PDT)
Received: (nullmailer pid 277720 invoked by uid 1000);
        Wed, 26 Oct 2022 12:36:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
In-Reply-To: <20221026032624.30871-2-quic_bjorande@quicinc.com>
References: <20221026032624.30871-1-quic_bjorande@quicinc.com> <20221026032624.30871-2-quic_bjorande@quicinc.com>
Message-Id: <166678762718.274656.14416161449532771853.robh@kernel.org>
Subject: Re: [PATCH v3 01/12] dt-bindings: display/msm: Add binding for SC8280XP MDSS
Date:   Wed, 26 Oct 2022 07:36:02 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 20:26:13 -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add binding for the display subsystem and display processing unit in the
> Qualcomm SC8280XP platform.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v2:
> - Cleaned up description and interconnect definitions
> - Added opp-table
> 
>  .../bindings/display/msm/dpu-sc8280xp.yaml    | 287 ++++++++++++++++++
>  1 file changed, 287 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.example.dts:21:18: fatal error: dt-bindings/clock/qcom,dispcc-sc8280xp.h: No such file or directory
   21 |         #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

