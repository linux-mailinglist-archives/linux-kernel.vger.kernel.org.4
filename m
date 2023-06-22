Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462CA739507
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFVCAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFVCAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:00:33 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4762E1738;
        Wed, 21 Jun 2023 19:00:32 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-340b7da7e3aso26832955ab.3;
        Wed, 21 Jun 2023 19:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399231; x=1689991231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1hTON9k3kUIOBB37/7PUxl0PK0fb2GZFYePKsdMJFo=;
        b=EZLU65LjT5L2+6suAdYZwsafYHWHK2Ivs52ctdI4Mk6AZDVhlqV1V3NUKFPGqK7M6q
         5nLhQG2kSwSUi107tlvIMBlwB4DVHDjMbphiGtdt13l/UZt2NFcdWjFOGn4fn0g5LboR
         kCy+Eq2t7MlBko1gbwnpPhgL+m+n11RNWLbKdwNMH95upG8AcAe+AR1RfoeVNE0leR8x
         t9THjT1S7UV8r/O8NbMQ5t/XIsEgsWRk24bEZCA1nAitJIo7BfywZhKgJimPQAKvAxbu
         MAqQXTi/I9CTsIeLvpF/w7IcXhSq10fh9RP8eR+ExjhJAd0Xz4HLNxUSlkx2Os4MZCcv
         8jjw==
X-Gm-Message-State: AC+VfDx9Y1ztgp/sS1HRMKEsj6vgJWAZIgcl6UJmUNtdDwixDY5pt6At
        68jBBU48B1GXllM4FJZlUgpDBCb9vQ==
X-Google-Smtp-Source: ACHHUZ7PHAaESnvWc25GWM80Ls0vDP095cd+Mfu5NOZJhBwUtBO+yfU/nx4s4ZFJNpLM37IU/+AHew==
X-Received: by 2002:a05:6e02:102:b0:341:d9e7:9d88 with SMTP id t2-20020a056e02010200b00341d9e79d88mr16172126ilm.11.1687399231490;
        Wed, 21 Jun 2023 19:00:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p24-20020a02c818000000b0042672a015f0sm1733554jao.25.2023.06.21.19.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:00:30 -0700 (PDT)
Received: (nullmailer pid 54477 invoked by uid 1000);
        Thu, 22 Jun 2023 02:00:28 -0000
Date:   Wed, 21 Jun 2023 20:00:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        freedreno@lists.freedesktop.org, Robert Foss <rfoss@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: sm8350-mdss: document
 displayport controller subnode
Message-ID: <168739922812.54419.5619568858048769577.robh@kernel.org>
References: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-0-8bf386b373eb@linaro.org>
 <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-1-8bf386b373eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-1-8bf386b373eb@linaro.org>
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


On Wed, 21 Jun 2023 11:26:25 +0200, Neil Armstrong wrote:
> Document the optional document displayport controller subnode
> of the SM8350 MDSS.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

