Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8D64B73E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiLMOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiLMOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:22:43 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF60C268;
        Tue, 13 Dec 2022 06:22:42 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id q6-20020a4aa886000000b004a083f945a6so2381103oom.6;
        Tue, 13 Dec 2022 06:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nPYc70xBGK0Wj8psANEn98FZZPcSq92yTHRO99EQSs=;
        b=cKt+DuyO1JN7ao96QG/otVH/li8GHIfCZMN5j1cD0QHnKf+0BFhT2FqL38/rQyi4PA
         La/ipL/QDl33BZzOvV3/CfkVXIqqgktDwCTDAj+cNB437sHP9EixTs0F30YPY4uzEp79
         xdRzUHEHvhvjQW5Mgo38t4gFa22HxrTiJiS5yTTGljBnAKRbQ6Rw+rLdq73T7XeabMHd
         7ilsZAM1YsZW18y6KYHDHBdIC0Jsx0IpuNRTxDwi4jjPdCVrYa/0MxABH2jyD/IpbNgY
         6PV/ZbjnsfBg66fPdOBmA6kmVWFZI+zur+WpX8jIFzaSIF8j4Nlf3xrpHxoMBW+4EbR8
         cTnw==
X-Gm-Message-State: ANoB5pkfx8spw34RHFXSwapAGmX6soelDPYqS8RXilczyEuriQlnUtt8
        sOswGgFi5Xutc9QX02qi9g==
X-Google-Smtp-Source: AA0mqf4KHNeZUBFBK8Dd0lGGuku2C3O9bcj5/PiV07nJKuDygyrL2XX0a1nldxe/GxB6Cg/4thpJPQ==
X-Received: by 2002:a4a:d84c:0:b0:4a3:986e:3e07 with SMTP id g12-20020a4ad84c000000b004a3986e3e07mr8839675oov.5.1670941361968;
        Tue, 13 Dec 2022 06:22:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z15-20020a4a304f000000b004a065c72a05sm1206791ooz.2.2022.12.13.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:22:41 -0800 (PST)
Received: (nullmailer pid 958687 invoked by uid 1000);
        Tue, 13 Dec 2022 14:22:40 -0000
Date:   Tue, 13 Dec 2022 08:22:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, andersson@kernel.org,
        marijn.suijten@somainline.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        freedreno@lists.freedesktop.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        agross@kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display/msm: Add SM8150 MDSS & DPU
Message-ID: <167094136007.958629.14485580510491889552.robh@kernel.org>
References: <20221212093315.11390-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212093315.11390-1-konrad.dybcio@linaro.org>
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


On Mon, 12 Dec 2022 10:33:12 +0100, Konrad Dybcio wrote:
> Add bindings for the display hardware on SM8150.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm8150-dpu.yaml |  92 +++++
>  .../display/msm/qcom,sm8150-mdss.yaml         | 330 ++++++++++++++++++
>  2 files changed, 422 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
