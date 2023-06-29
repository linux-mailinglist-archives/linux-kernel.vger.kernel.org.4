Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C55742A93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjF2QXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjF2QXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:23:16 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3397187;
        Thu, 29 Jun 2023 09:23:15 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-341ff6251f2so3619755ab.0;
        Thu, 29 Jun 2023 09:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055795; x=1690647795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPh8e75fI5DgK1FIHoQuqCb5ZMtTAcx7+QMfAfjXghk=;
        b=c/BzyIwmiZkjzhgQs5L9BtCE9ZvYyxwkHuuGhB/kqBsM6MN0CZyUOKO6u6ymTc9Lq8
         Zbszd07e4EIR5N28l+O0mdWhtGO6Ab9pJNlGc4ZsZa3Y8Cs6spodYTU+PFVET3+3MAz7
         QGamn6Ae6lNfMCRS4oog5UteGHPRV2WFzEcmNHlyB85n9RTm0gd9weBrO4Fwji1FlTse
         aHtprcb6a+xpuaOdNyhFh1yXPXf9eg5p2rMBV1qO8FtBdWMqejeqwgGh+yHQvmTFegH5
         FyyKacvGH8BcswbAE32PwLKa3QBI+MYIjgKw0WmcUDD8SMj6Parw3saEQkuMyFy/sRmY
         zPhQ==
X-Gm-Message-State: AC+VfDwV/cA5d7pIz9E694T0X6xhyhJjgMJOo8WHaUO+3UXPcYQaCKyz
        LkQq2v+1iJChYIriJRLFVw==
X-Google-Smtp-Source: ACHHUZ4Kcv1UA5oX8BJmHwp8UVcuaRFAtds/5zfPnZvvG9i/NDjjwMOVlcnm/2bZb+YynlmohRZQUw==
X-Received: by 2002:a92:de50:0:b0:345:d277:18eb with SMTP id e16-20020a92de50000000b00345d27718ebmr3614130ilr.30.1688055795161;
        Thu, 29 Jun 2023 09:23:15 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t7-20020a92cc47000000b0034255d2d3c5sm4172219ilq.48.2023.06.29.09.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:23:14 -0700 (PDT)
Received: (nullmailer pid 3142728 invoked by uid 1000);
        Thu, 29 Jun 2023 16:23:12 -0000
Date:   Thu, 29 Jun 2023 10:23:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Konrad Dybcio <konradybcio@kernel.org>,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        Mark Brown <broonie@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Paul <sean@poorly.run>, Andy Gross <agross@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: display/msm: dsi-controller-main: Allow
 refgen-supply
Message-ID: <168805579134.3142664.11063512171591617294.robh@kernel.org>
References: <20230628-topic-refgen-v1-0-126e59573eeb@linaro.org>
 <20230628-topic-refgen-v1-3-126e59573eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628-topic-refgen-v1-3-126e59573eeb@linaro.org>
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


On Wed, 28 Jun 2023 18:29:47 +0200, Konrad Dybcio wrote:
> DSI host needs REFGEN to be enabled (if it's present on a given platform).
> Allow consuming it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

