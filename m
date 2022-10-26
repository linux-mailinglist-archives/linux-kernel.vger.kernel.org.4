Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9C60E6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiJZRyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiJZRyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:54:44 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E16399;
        Wed, 26 Oct 2022 10:54:40 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 16-20020a9d0490000000b0066938311495so2087314otm.4;
        Wed, 26 Oct 2022 10:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmbqUT3CmVbU0HzMpVAJyOgaDhVx3i4wGwXhoedlXNs=;
        b=xRBLKsdXdOUu5CKFUhSceEQcNAZIrgHWHRzFWOqLTtyGZglh1RiKq7dv8tS80LmO8s
         cf50hFlvo0L/y8qKPJBAUMH8mW9rFuMdwSji4SH1TcZyRQPPeR9+ViV0Em4EABW7ISbZ
         6SOT4GGTHTMPiTkP1AwIEnH76fTCeYsGYRGQd+06/prlAAD2BIrvZhPn/4w9nnFCG0gb
         ndS5B5pAMKEL/C3y/Cyczf6h+xBa5TNd517f19+9CufH8YlVig2JArfRzinwNAwp7Aoa
         WoYUblYLSkCN5Du3h33x5PFsKUuMZnAop9A5+buzTKD0YhX9413QR8RSzeKrBXZQnbI6
         Crcg==
X-Gm-Message-State: ACrzQf34tJDUQ1Xw/Y+iqtCck4OMYEXlE7qNlT4ysO25aRXoKt3XiL4u
        jckV6RygiPOa+mU0001HZQ==
X-Google-Smtp-Source: AMsMyM7u/5xsmyjQ88MnSABwibsj9ORVBkFwkQ3aUNkf/hBMroiSAacuWdQE9wICk8HxIgRsWTUPqg==
X-Received: by 2002:a05:6830:d02:b0:661:9466:dfc3 with SMTP id bu2-20020a0568300d0200b006619466dfc3mr22434647otb.333.1666806880150;
        Wed, 26 Oct 2022 10:54:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n44-20020a056870972c00b0011f22e74d5fsm3405812oaq.20.2022.10.26.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 10:54:39 -0700 (PDT)
Received: (nullmailer pid 820018 invoked by uid 1000);
        Wed, 26 Oct 2022 17:54:41 -0000
Date:   Wed, 26 Oct 2022 12:54:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/12] dt-bindings: display/msm: Add binding for
 SC8280XP MDSS
Message-ID: <20221026175441.GA812056-robh@kernel.org>
References: <20221026032624.30871-1-quic_bjorande@quicinc.com>
 <20221026032624.30871-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026032624.30871-2-quic_bjorande@quicinc.com>
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

On Tue, Oct 25, 2022 at 08:26:13PM -0700, Bjorn Andersson wrote:
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

Doesn't this need to be reworked to match Dmitry's restructuring?

> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
> new file mode 100644
> index 000000000000..24e7a1562fe7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
> @@ -0,0 +1,287 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/dpu-sc8280xp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Processing Unit for SC8280XP
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  Device tree bindings for MSM Mobile Display Subsystem (MDSS) that encapsulates
> +  sub-blocks like DPU display controller, DSI and DP interfaces etc.
> +
> +properties:
> +  compatible:
> +    const: qcom,sc8280xp-mdss
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    const: mdss
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Display AHB clock from gcc
> +      - description: Display AHB clock from dispcc
> +      - description: Display core clock
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: ahb
> +      - const: core
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +

> +  "#address-cells": true
> +
> +  "#size-cells": true

enum: [ 1, 2 ]

(Nothing else sets that)

Rob
