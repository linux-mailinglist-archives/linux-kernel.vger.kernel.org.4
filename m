Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A066617E4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjAHSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbjAHSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:11:32 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65CD45;
        Sun,  8 Jan 2023 10:10:55 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id n63so3485557iod.7;
        Sun, 08 Jan 2023 10:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaYtJSbg0m1h9v/y0oGBIF5OJEkln4UIHXOm49qosbk=;
        b=UvjJpTunF72XlJdr6SRMKMnx1wDWciKPBFkmB+fqeu4LKRGo4ZLB3DTqzk5ykGMMC7
         znRpKTAH9xPasG6+VBAJFK0ceQ2Czdxmb3P351RxZbjzL9fbgT3uBlGy7oVAaZ3fbJEW
         lZSAg0tk+ZSvsiIH+OHcQPKcZ6xgMMmyMxJyN18gmnbyofUeo/YjcRT87plWMQdtBNfC
         ZjsZEwY0peH7zk9ulQ7T+iVv0rU3k+3EDOaXshAlCt2zMnSLEOVTZ464kgzCveEtstSd
         ccL11bTzpsIqJuSXFt2eBrDkYGTGP2VPpnhxc/W9MEwXMrUa0rJGYylM1Kz6A33fIr5p
         2BBg==
X-Gm-Message-State: AFqh2koGGvsnDxEvGDK1xXYGZTAn74YOp2IzBzjHjENMksSFlTlexRQL
        01Xia/VpkyyR6IVHE30CmA==
X-Google-Smtp-Source: AMrXdXvgwhlFhigBTBW17M60+YlCLJ0HiW7wQwdHfJos1G0hDrrz6tu/pH11pfTsb5vfGyTuyIE+Zw==
X-Received: by 2002:a05:6602:2183:b0:6bd:196e:da3 with SMTP id b3-20020a056602218300b006bd196e0da3mr40568542iob.8.1673201454659;
        Sun, 08 Jan 2023 10:10:54 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id d16-20020a6b6810000000b006de73a731dbsm2347201ioc.51.2023.01.08.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:10:54 -0800 (PST)
Received: (nullmailer pid 154605 invoked by uid 1000);
        Sun, 08 Jan 2023 18:10:51 -0000
Date:   Sun, 8 Jan 2023 12:10:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: msm: drop redundant part of
 title
Message-ID: <167320145082.154531.12469565468633338851.robh@kernel.org>
References: <20221225115925.55337-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115925.55337-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Dec 2022 12:59:24 +0100, Krzysztof Kozlowski wrote:
> The Devicetree bindings document does not have to say in the title that
> contains "DT properties", but instead just describe the hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-phy-common.yaml    | 7 +++----
>  .../devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml  | 2 +-
>  .../devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml  | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml   | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml   | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml   | 2 +-
>  .../devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml   | 2 +-
>  7 files changed, 9 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
