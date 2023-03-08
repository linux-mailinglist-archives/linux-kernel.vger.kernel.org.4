Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A636B1166
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCHSvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCHSvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:51:19 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB1CB646;
        Wed,  8 Mar 2023 10:51:06 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-17683b570b8so16980246fac.13;
        Wed, 08 Mar 2023 10:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxHmoWTI8MLGT4ZibFgSPu97U/Mok0BTnkOY7p1ZoA8=;
        b=Y7bOUeJsW30SfQlyAwUbcZxDGUn+1w6xgPT0FFwamxiuMW+JVX/0RMfx4CL2z3OK2D
         QX3f+6v3bSTSDMvn9vWU5GWi4OD6Q/TK1OdMMm+vILumMIjet1wGSpkgrxKIDl9Wdry0
         fRsMR8Vv7clUoNjLo2Cm6Ji3zbwxMERghVEIHd2LZOpvUE7gdOrDXHlhxuz/WCKooxeY
         m7ZEoB9kBQSolvt90sYpnuxV0rPoz8Z2L6d7Nc6qTN/9b3wqXUIQGbfWE8jBYhdPZ/42
         1fptw90aKnHKUgAk/hn1XlHG9pHO1RhBXMG49CbpTVcg/BP1u3eR3ma7iN2m8Zka3EvT
         Ltxg==
X-Gm-Message-State: AO0yUKXLAOfPfSlBzLnsMI503+dKEv2OAuoE7AnfyY06N81AaafMcAqJ
        3/SFrtP/W6U/XbVa4FlRgsIrqyoWQQ==
X-Google-Smtp-Source: AK7set9i5XHntQJl5sc/hGUJ494y7HgMwr3hwqLZ0laP2jB5VlHjCdPUWv4BQRChS7BqTraYIEMKDA==
X-Received: by 2002:a05:6870:7394:b0:16d:eac4:7b5f with SMTP id z20-20020a056870739400b0016deac47b5fmr11900569oam.48.1678301465508;
        Wed, 08 Mar 2023 10:51:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id du41-20020a0568703a2900b001764b4a05f6sm6504401oab.39.2023.03.08.10.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:51:04 -0800 (PST)
Received: (nullmailer pid 3587173 invoked by uid 1000);
        Wed, 08 Mar 2023 18:51:03 -0000
Date:   Wed, 8 Mar 2023 12:51:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Andy Gross <agross@kernel.org>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 09/10] dt-bindings: display/msm: dsi-controller-main:
 Add SM6115
Message-ID: <167830146346.3587111.3542934829511061872.robh@kernel.org>
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-9-8bd7e1add38a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-topic-dsi_qcm-v3-9-8bd7e1add38a@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Mar 2023 14:01:47 +0100, Konrad Dybcio wrote:
> Add a compatible for the DSI on SM6115.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml         | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

