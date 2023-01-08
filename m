Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C96617E5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjAHSMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjAHSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:11:41 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E386578;
        Sun,  8 Jan 2023 10:11:22 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id i16so3316261ilq.9;
        Sun, 08 Jan 2023 10:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiypBw1FFoQC+gIVSsz3bdQtqAHOH/d5JbPQdSsewDY=;
        b=csORe15M/y2mobM49fvM0rjsCLh3M+XlRshg+3WCW0NSzgjcUs9ycBYXyYNBTshSqQ
         /7z+0ksdVB6tb5sUzn8KljDKRCNlHCamCooH42ePfyYqWQyhp1JKtYcKlkkBhAuhpTJ9
         7v99FPQOwcm4KLanQNbQNg4a8ExAisvmG52Mut2GWVnDn/p1+gciWn5Ofe+SQDza+PPK
         qK/vB5Bfnx9ZhjgJ+fnfJL6beDgpD99Pj+zR1DMLSdYfqQ6H8oXnzmSlRaDCu9j2hciI
         h5+QnGts6qdexBofSvOzkLZ0S3A9C1pTDMkMd6bptogZ24y+6PN7S6ALghGFoG3TOLd4
         qF8A==
X-Gm-Message-State: AFqh2kpe0jd3I0jtWWZvtnc2vFC3pUqS2W1SLE5TYudlxZS3y7CpzXFk
        OIfCj8doTloi/dsRIpt8oQ==
X-Google-Smtp-Source: AMrXdXuYDz5mzS+d03/EiJebiBeLhsVbqPJcw3Ay/ahTEpGsd0G1G7HVqSpVRNyYJa06WCL4gtW/Lw==
X-Received: by 2002:a92:dc06:0:b0:30d:7b2f:c0b1 with SMTP id t6-20020a92dc06000000b0030d7b2fc0b1mr10948191iln.16.1673201481239;
        Sun, 08 Jan 2023 10:11:21 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id o12-20020a02220c000000b0039e5fa071a2sm1981012jao.173.2023.01.08.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:11:20 -0800 (PST)
Received: (nullmailer pid 155243 invoked by uid 1000);
        Sun, 08 Jan 2023 18:11:18 -0000
Date:   Sun, 8 Jan 2023 12:11:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-kernel@vger.kernel.org,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/2] dt-bindings: display: msm: drop unneeded list for
 single compatible
Message-ID: <167320147769.155186.14878775779910261810.robh@kernel.org>
References: <20221225115925.55337-1-krzysztof.kozlowski@linaro.org>
 <20221225115925.55337-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115925.55337-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Dec 2022 12:59:25 +0100, Krzysztof Kozlowski wrote:
> With only one compatible, there is no need to define it as list (items).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml      | 3 +--
>  .../devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml     | 3 +--
>  .../devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml      | 3 +--
>  .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml     | 3 +--
>  .../devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml       | 3 +--
>  .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml      | 3 +--
>  .../devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml       | 3 +--
>  .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml      | 3 +--
>  .../devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml       | 3 +--
>  .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml      | 3 +--
>  .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml      | 3 +--
>  11 files changed, 11 insertions(+), 22 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
