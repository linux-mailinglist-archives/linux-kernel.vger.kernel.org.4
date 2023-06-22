Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD63739513
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjFVCA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFVCAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:00:54 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7661BD8;
        Wed, 21 Jun 2023 19:00:51 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77e43dde8c9so151953839f.3;
        Wed, 21 Jun 2023 19:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399251; x=1689991251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBXEfv4Yrn77qP/MYPvp3SEav3PapGrc9nExUoKa+q4=;
        b=PFr5gGH7gNv36I0mknoHpsjPcdyG/6UCDtBCjUjqOCUtiqQ0+eh2k4gm4zw0TngJ4s
         PtS+okesHAM0q+iCaXaNOwNi+EKnExAAlAzs/SBmngq717DvfehWmMiOMPfmLMGEnCXz
         Z99IOdTemXFwHEcOV1VuIMJRvnSJ6k2NNoVxzt63/oE3ZFspeFlL6QYxc7bOZAreqe6R
         9YfIAMmPC2LOkm9o6qdGkrdJR/gk0dAKddvnWo49tLcB/E18irSsZFrcxrtHU7E47NXF
         JUl4zcKNtYytR9CN1BJhAQ93Dq69CZxyQCffuoatRIYbEsFlAIwBhyIChwtH/RiTXq4u
         7RWw==
X-Gm-Message-State: AC+VfDyhSm4UA+c2cB74BM8A9K+kE0j+47SXMnKzvu0fixtfDEx4eb/O
        8y5nhbfLT0sDg9D88itJMg==
X-Google-Smtp-Source: ACHHUZ4LjlN2f3BpdV6OS0nUzSrKIpexflZ3GCFR2u9mVTl6o2I45TcjN3WnmY9ZnCdbw80O88zXjg==
X-Received: by 2002:a05:6e02:4d2:b0:340:b569:aec1 with SMTP id f18-20020a056e0204d200b00340b569aec1mr15521666ils.28.1687399251132;
        Wed, 21 Jun 2023 19:00:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n13-20020a92d9cd000000b0033b2a123254sm1670712ilq.61.2023.06.21.19.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:00:50 -0700 (PDT)
Received: (nullmailer pid 55180 invoked by uid 1000);
        Thu, 22 Jun 2023 02:00:48 -0000
Date:   Wed, 21 Jun 2023 20:00:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 3/3] dt-bindings: display: msm: sm8550-mdss: document
 displayport controller subnode
Message-ID: <168739924746.55132.18209927857725642853.robh@kernel.org>
References: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-0-8bf386b373eb@linaro.org>
 <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-3-8bf386b373eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-3-8bf386b373eb@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2023 11:26:27 +0200, Neil Armstrong wrote:
> Document the optional document displayport controller subnode
> of the SM8550 MDSS.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

