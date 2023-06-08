Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE687289CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjFHVAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjFHVAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:00:20 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCB7269A;
        Thu,  8 Jun 2023 14:00:19 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77a62a84855so50597539f.1;
        Thu, 08 Jun 2023 14:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686258018; x=1688850018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ6xGaMCtOtduGN8pKzDZZjENVHQCmzv4T9O+RDTdsk=;
        b=kGMeNOysmu9s7s2qaJdmss8zLMqnAY8SsSRcRoHVKkRrOentXcRK5iAS04Skm0gY50
         AwxaxoKZHBk1VxwhozyAN5cK75G7jnUmV+kO0ii0X2mBIiuwXbhmKlLEVlSj4MRzwL2x
         F3sACqNg25tNtmLyASyiBTLVbP8+fZtGLs1/ZhP4tH8RfRhZ4RUyx4brmz9nuYSipbvY
         prWZMCbKe3yClVR0WBsuPhown7aRjhSwpt4tME6SnfvvEGSs2YoxABUG2vmf5Sm5PLlk
         8VWTRq1kccfCF/hrTutWPN8NiAx27cZxMCYjJ91o6miXFjwmUB7h+jTUvL3fvMubLMuh
         DfXw==
X-Gm-Message-State: AC+VfDwwr0ack7bOhfSuAddztk7P8R1bhLy0IFs6c7NWVZvLR/oMWPKq
        BfmqkYvvW21+Ltq1SqarlQ==
X-Google-Smtp-Source: ACHHUZ7AyoffTQ3fi18lH+On2UmZysv1D8RdGu0Kp9eqI3ISi1ouvwHH/Odbc68BBCL+6r74PMk24w==
X-Received: by 2002:a05:6602:3311:b0:774:8d9f:e3e2 with SMTP id b17-20020a056602331100b007748d9fe3e2mr8171020ioz.17.1686258018474;
        Thu, 08 Jun 2023 14:00:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v3-20020a5ec103000000b00763699c3d02sm625027iol.0.2023.06.08.14.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 14:00:17 -0700 (PDT)
Received: (nullmailer pid 3436092 invoked by uid 1000);
        Thu, 08 Jun 2023 21:00:15 -0000
Date:   Thu, 8 Jun 2023 15:00:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 01/18] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
Message-ID: <168625801365.3436024.3812799547428239987.robh@kernel.org>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
 <20230223-topic-gmuwrapper-v8-1-69c68206609e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223-topic-gmuwrapper-v8-1-69c68206609e@linaro.org>
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


On Mon, 29 May 2023 15:52:20 +0200, Konrad Dybcio wrote:
> The "GMU Wrapper" is Qualcomm's name for "let's treat the GPU blocks
> we'd normally assign to the GMU as if they were a part of the GMU, even
> though they are not". It's a (good) software representation of the GMU_CX
> and GMU_GX register spaces within the GPUSS that helps us programatically
> treat these de-facto GMU-less parts in a way that's very similar to their
> GMU-equipped cousins, massively saving up on code duplication.
> 
> The "wrapper" register space was specifically designed to mimic the layout
> of a real GMU, though it rather obviously does not have the M3 core et al.
> 
> GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
> specified under the GPU node, just like their older cousins. Account
> for that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/gpu.yaml       | 61 ++++++++++++++++++----
>  1 file changed, 52 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

