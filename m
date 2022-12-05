Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E78643686
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiLEVJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiLEVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:09:01 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E595A5F73;
        Mon,  5 Dec 2022 13:08:59 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id a7-20020a056830008700b0066c82848060so8066704oto.4;
        Mon, 05 Dec 2022 13:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXjFpm/+C4nfs0zFQWp+HDIv2IGjyOfEFa6fb6gGpMw=;
        b=J3/txBpPFbg8xUCmtyjILhTpM6KcYgoCFgF3aJakfxYaz0G3rjlLZn0To4WZT8Wd9y
         tx3A0OGqCmhooOq3Vd/mlY+37d6Of5KgWr3ecHRd+TQ/8RdCpHahpk9sU3nscym3GPj1
         B4pG61tMFPikJtKw3MxEi7vBIc7jM+97Q1edM1zDc8tW97+H+P2b+YBatUC8MKLHWnUO
         0WuHbfgVyo4Srx8Y6EZ7E87yu/zTMPsThMmu2waxO5JN4epCFp3QgvHeG4d2LVX+Prwv
         NrkQ1abi7bQriL3M8nc3TnYe4f0A8ewT0/hpkdJV4aogJ7hMHL+c1gcwIv4mSgA/WOMq
         HDug==
X-Gm-Message-State: ANoB5plv+wJTKePjXFqKIe3OqqyQw8nG95IuS06XRM2b3h5DW6EspSnD
        CK0ZlBkhxI8hqiPeEDWtLg==
X-Google-Smtp-Source: AA0mqf4pi2xM26IK4lkpivLEq04ATV1U/s3nJb8ELurAsyYe6CVsyow1euCYO7OR3rTAz0hPf4OzCw==
X-Received: by 2002:a9d:69:0:b0:66e:976:193f with SMTP id 96-20020a9d0069000000b0066e0976193fmr31490146ota.214.1670274539009;
        Mon, 05 Dec 2022 13:08:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n25-20020a9d6f19000000b00660e833baddsm8206891otq.29.2022.12.05.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:08:58 -0800 (PST)
Received: (nullmailer pid 2625205 invoked by uid 1000);
        Mon, 05 Dec 2022 21:08:57 -0000
Date:   Mon, 5 Dec 2022 15:08:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 01/13] dt-bindings: display/msm: Add binding for
 SC8280XP MDSS
Message-ID: <167027453696.2625145.2281674467563645839.robh@kernel.org>
References: <20221205174433.16847-1-quic_bjorande@quicinc.com>
 <20221205174433.16847-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205174433.16847-2-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Dec 2022 09:44:21 -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add binding for the display subsystem and display processing unit in the
> Qualcomm SC8280XP platform.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v3:
> - Reworked on top of redesigned common yaml.
> 
>  .../display/msm/qcom,sc8280xp-dpu.yaml        | 122 +++++++++++++++
>  .../display/msm/qcom,sc8280xp-mdss.yaml       | 143 ++++++++++++++++++
>  2 files changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sc8280xp-mdss.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
