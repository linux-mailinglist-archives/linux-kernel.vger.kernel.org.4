Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D266F66BE52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjAPMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjAPMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:54:58 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D6C22031
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:52:42 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 20so11068093ybl.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2HwxURQ04QRPHjYFiwUTAY9c1+Tu3uq4SQk4i0sNqu4=;
        b=BX2XXb6Z/I8uqSGq+V3t+G3jgfTOzjVgOOQsSxDjQGnulfnkLrpeXJgo7xxz7Lk3gb
         69GvlI+IeJRRULFIykgNvw14q5nFemOJXWUjCtnrpQGB8/270ANcD4Ra9GDwo5kdKXOH
         njJzNwh14rD6t/8n6V/YIE6klTzC4otbBHzBYR1PM9o7BKsWcaawdYlxMoWwaRVt7do/
         wP6GtqJt4YNQ6fGZvoxaNJNaMST/Xxs4MhUxU++Z2pu0A4iZCoVs5ZW0GFvP9x47vfPP
         pNE045klwXHyEJuo2GG7O+uB1ftlF2ixt0ES468NgvgLLGObBloQEGYaqUTWLy3utNVy
         VdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HwxURQ04QRPHjYFiwUTAY9c1+Tu3uq4SQk4i0sNqu4=;
        b=X9SDzURgz3VV5jNBXx27m/p8l6+VXXQPKLaFqdmvVCCRML1S2wn1liD84pGyKGcVtW
         Ekj4JZ9WqkVwYxqemibVlX19yWGS0GqKinLZ3ATBZdqpJ+snluW9ZXehfVwg2AuCmAaE
         Gjs8O/nLqxYHBDE94/P5Auf4oKuZRi/QZNmXJMIG8qO3FtlKDhUZ/jyWagB6knx5a6Fn
         I/EYzlCjB5hjNx+mif2qu9ErsZW19vUGxCwvM8T0jara2Gb8sbSIioqRUs+BZycYG7ah
         L5euspTK4y2+GUH1yEkdNvrEXtqHb92kPluEPOBJcGtOGMi4R7joyvpkvJlFLXIU/B5s
         gl7Q==
X-Gm-Message-State: AFqh2koSquV3oXaCzUvVppID5jK6QZ+XGGeyLacCP9z2Xpj+XEkLiMEC
        HsW7gHRKWnDJApaes3/LyU0NZaQi2M0y6ZoGSGZKNw==
X-Google-Smtp-Source: AMrXdXvVqYBXE+hJ9b7YSEc2muX26rtwXJeHSCkz34eovdTPqEG7jDeQIgdO7eKutLnykzUqqBtiRDwJoRKQOLEeDNM=
X-Received: by 2002:a25:e648:0:b0:7c2:d9f1:3b04 with SMTP id
 d69-20020a25e648000000b007c2d9f13b04mr2486434ybh.516.1673873561962; Mon, 16
 Jan 2023 04:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20230116115132.348961-1-konrad.dybcio@linaro.org>
In-Reply-To: <20230116115132.348961-1-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 16 Jan 2023 14:52:30 +0200
Message-ID: <CAA8EJprNzLMnU7cguMit6Y4sgU0-SOkiiL+=s_BFBZiyvNvsAw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: msm/dsi: Don't require vdds-supply on 7nm PHY
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 at 13:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On some SoCs (hello SM6375) vdds-supply is not wired to any smd-rpm
> or rpmh regulator, but instead powered by the VDD_MX/mx.lvl line,
> which is voted for in the DSI ctrl node.

I think we should have an explicit `if compatible then required:
vdds-supply' clause. WDYT?

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> index 9c9184f94c44..8e9031bbde73 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
> @@ -48,7 +48,6 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - vdds-supply
>
>  unevaluatedProperties: false
>
> --
> 2.39.0
>


-- 
With best wishes
Dmitry
