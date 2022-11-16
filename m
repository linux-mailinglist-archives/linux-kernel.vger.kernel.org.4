Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2C62C1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiKPPAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiKPPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:00:06 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4BC4FF9B;
        Wed, 16 Nov 2022 06:59:12 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso10535673otq.11;
        Wed, 16 Nov 2022 06:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG2Tq6+Rxp6EDqdTHOj4cP+DRbjq8GgFfl9nEQ/66eA=;
        b=RMCvW2/2vAzxUisgM6R9wZ/Sg6AjeCxl+dlYDQq9atGKiF94z4vjoFY9cadue/yDkk
         PmTBBgbfPX+MlUfZZIezy7+ulPjJJS3xs+diz7kMyIYGmAozqock/kqlcyh4J/cB0sak
         jJ0nTun/Y713YTWbmI5XIrizLvAVhWzkZbrmfStFskwf4ssJX3koWPuNesrQXK+zmm8r
         /FmGkFJLdfB7Cor36rsT1gRk0hufT3u4eGmU5mBLOS85jX13jVFrkRg1Fk8GAkYLjpld
         lkOPD4YEMADGZYgg/ToT3/J9a7uBHi8B4SRf71PcbQcn7CSfMKNy+dflMhT0Nqu7GgWT
         miPQ==
X-Gm-Message-State: ANoB5pm1EPAPt3vCnyQYZv/BkFD5PrK8+szm2sJjS4dbv50avd+SPb6s
        ZOjCLBrSB07S608qQZVl/g==
X-Google-Smtp-Source: AA0mqf48FvjuD+IAwK/1wfbeBhUiVH98RSb0f3PIpqZwv0iDrLwWktAN4jSPD17kbnAnznZU+hLEoA==
X-Received: by 2002:a05:6830:1d90:b0:663:bd3a:2e4b with SMTP id y16-20020a0568301d9000b00663bd3a2e4bmr11237196oti.157.1668610751657;
        Wed, 16 Nov 2022 06:59:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j21-20020a544815000000b0035aa617156bsm6135435oij.17.2022.11.16.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:59:11 -0800 (PST)
Received: (nullmailer pid 3849197 invoked by uid 1000);
        Wed, 16 Nov 2022 14:59:12 -0000
Date:   Wed, 16 Nov 2022 08:59:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     loic.poulain@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        quic_jesszhan@quicinc.com, vinod.koul@linaro.org, sean@poorly.run,
        linux-kernel@vger.kernel.org, quic_kalyant@quicinc.com,
        dmitry.baryshkov@linaro.org, freedreno@lists.freedesktop.org,
        quic_abhinavk@quicinc.com, airlied@linux.ie, andersson@kernel.org,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, daniel@ffwll.ch,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        agross@kernel.org, dianders@chromium.org,
        bjorn.andersson@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v2 01/12] dt-bindings: display: msm: Add qcom,sm8350-dpu
 binding
Message-ID: <166861075192.3849132.17933292251888324677.robh@kernel.org>
References: <20221115133105.980877-1-robert.foss@linaro.org>
 <20221115133105.980877-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115133105.980877-2-robert.foss@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 14:30:54 +0100, Robert Foss wrote:
> Mobile Display Subsystem (MDSS) encapsulates sub-blocks
> like DPU display controller, DSI etc. Add YAML schema for DPU device
> tree bindings
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm8350-dpu.yaml | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
