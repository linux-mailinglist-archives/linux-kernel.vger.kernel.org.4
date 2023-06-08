Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87AC7289BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjFHU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjFHU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:58:53 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BADB269A;
        Thu,  8 Jun 2023 13:58:52 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33b1da9a8acso4884465ab.3;
        Thu, 08 Jun 2023 13:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686257931; x=1688849931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FMvGYAzuZRfNH9ntpuhSoq2QKXt57EC2toGT1Yc+LQ=;
        b=B163tFeOKLbvVhXiLjMGP1hgJkXxkDKFBQ/X9ZpS6zwB2qzr1ztKXy6ncSoFCBiTTs
         qu1RYcLZCXthMZykAcp4xYvrNl7tnuT87AmtCGd6jMkVNSraTfxUXJJZOamLs+rQBiuX
         SBQGNKLNDRsHsrKFISTfXexEU+TnyQd/YLa+aEQxDgvVDX1a5MKokuLrqLNAWGXiBKxA
         dpC+VuuAz6h2jYpNgbxvvuyYKgani+hy4pvMUipp8sYwLMS3xM5yUUnJcNWBnkBiBNmR
         efa2PkPAlF11EfVh8FncgJjMdDkClmC/VSU47SCzUkYsANtIQfDp5rXnWE8ufnK58K+u
         o9wA==
X-Gm-Message-State: AC+VfDyvYB2ko9iMVcWZV3fYnBOdhPZ4Mu25hlS6p4AXiegWCZCFK/6F
        4BMVa0f8y2919c7sqzXtIQ==
X-Google-Smtp-Source: ACHHUZ5ulKJE2NEgESnPWkXHIhgORYjMch54tcncszW51gmLv2NwnUQflJQQonqUZB/1nKyGzK2X8A==
X-Received: by 2002:a92:cc01:0:b0:33c:b80e:4599 with SMTP id s1-20020a92cc01000000b0033cb80e4599mr11532791ilp.9.1686257931638;
        Thu, 08 Jun 2023 13:58:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z12-20020a92d6cc000000b0033bea7559ffsm630717ilp.53.2023.06.08.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:58:50 -0700 (PDT)
Received: (nullmailer pid 3434522 invoked by uid 1000);
        Thu, 08 Jun 2023 20:58:48 -0000
Date:   Thu, 8 Jun 2023 14:58:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v8 01/18] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
Message-ID: <20230608205848.GA3424883-robh@kernel.org>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
 <20230223-topic-gmuwrapper-v8-1-69c68206609e@linaro.org>
 <20230530122652.lct6tk6zseny6gxl@krzk-bin>
 <1ceeb56e-3efd-6858-358a-bd1976c625b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ceeb56e-3efd-6858-358a-bd1976c625b1@linaro.org>
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

On Tue, May 30, 2023 at 03:35:09PM +0200, Konrad Dybcio wrote:
> 
> 
> On 30.05.2023 14:26, Krzysztof Kozlowski wrote:
> > On Mon, 29 May 2023 15:52:20 +0200, Konrad Dybcio wrote:
> >> The "GMU Wrapper" is Qualcomm's name for "let's treat the GPU blocks
> >> we'd normally assign to the GMU as if they were a part of the GMU, even
> >> though they are not". It's a (good) software representation of the GMU_CX
> >> and GMU_GX register spaces within the GPUSS that helps us programatically
> >> treat these de-facto GMU-less parts in a way that's very similar to their
> >> GMU-equipped cousins, massively saving up on code duplication.
> >>
> >> The "wrapper" register space was specifically designed to mimic the layout
> >> of a real GMU, though it rather obviously does not have the M3 core et al.
> >>
> >> GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
> >> specified under the GPU node, just like their older cousins. Account
> >> for that.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  .../devicetree/bindings/display/msm/gpu.yaml       | 61 ++++++++++++++++++----
> >>  1 file changed, 52 insertions(+), 9 deletions(-)
> >>
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> I think it'd be beneficial if the bot diffed the output of checks pre-
> and post- patch.

Fix all the warnings and it will. ;) Care to donate h/w to run the build 
twice every time?

Really what I care about on these is when I keep getting changes to a 
schema and the list of warnings remains long and not getting fixed.

This case was less than useful with just the oneOf warning.

Rob
