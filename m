Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E962E73950F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFVCAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFVCAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:00:50 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ECE1BEA;
        Wed, 21 Jun 2023 19:00:46 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-777a6ebb542so270057839f.0;
        Wed, 21 Jun 2023 19:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399246; x=1689991246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPfkOWL+5FHVazix2bTeczr6wVtV3YUUaWTawgk744k=;
        b=SHaNBxS/okxG9McV9Qqc66fd65sjxklXMyIhAPPv706x3x48gXLAy5Kziw+Wz9HiyA
         pI2fCskguoFO2F1saJz0MQKcna0eYkkeP/cUcgMkFn2JwCtvvTDBsPyvmKzftnB2m6ot
         OAALa1FrS/4HdUG15GpeWB8ZiWBRyJktr0dKOmBzH2OpxPftF8ST7McgF/CRufXaYV/o
         kRFG+r7InpSZEUJpF3rNmkpGGMX8azPgNsOAxOrW4tq+Ub2tKg1K2WKcOLG6sVQutEkG
         MAYGNSZ+h3lhoRzYvissgo+dlCJkEOkfA+VEE//Z5MYHJkjUEZ72X1dapYTJHcV2Swij
         ui0w==
X-Gm-Message-State: AC+VfDxX9VtHuO2jKNTQQsvsfXCZRpms7NKH/q35xnx2PYUITehyTujq
        R+cUyAm6TXp/6L8c1PiLjQ==
X-Google-Smtp-Source: ACHHUZ6SEbMTFHsbfIGdCv9COJO/+cOsDwJBi0mYIbdT7YAq1hrmmPL4I//mLfm4Si/c96SBEJVgWw==
X-Received: by 2002:a92:c108:0:b0:331:1c97:f679 with SMTP id p8-20020a92c108000000b003311c97f679mr13310177ile.10.1687399245834;
        Wed, 21 Jun 2023 19:00:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l14-20020a92290e000000b003427601b77esm1685209ilg.21.2023.06.21.19.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:00:45 -0700 (PDT)
Received: (nullmailer pid 54879 invoked by uid 1000);
        Thu, 22 Jun 2023 02:00:39 -0000
Date:   Wed, 21 Jun 2023 20:00:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Robert Foss <rfoss@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: display: msm: sm8450-mdss: document
 displayport controller subnode
Message-ID: <168739923947.54817.13314418974279219591.robh@kernel.org>
References: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-0-8bf386b373eb@linaro.org>
 <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-2-8bf386b373eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-2-8bf386b373eb@linaro.org>
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


On Wed, 21 Jun 2023 11:26:26 +0200, Neil Armstrong wrote:
> Document the optional document displayport controller subnode
> of the SM8450 MDSS.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

