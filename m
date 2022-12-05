Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA0643523
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLEUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiLEUAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:00:14 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C68E63E6;
        Mon,  5 Dec 2022 12:00:13 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1441d7d40c6so14731213fac.8;
        Mon, 05 Dec 2022 12:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3fVj6v3LruTTu+ByPEHUKRATHKnRWFUX12drFvN6zk=;
        b=kbdqYWG0ADRrV+bZ3JRTO1t/wm2J/OXM5i1Z6Y1sMv73u14Wti/B5B/sXZnxToV4rh
         InrseuBMm897O1bYo9XXGpPCxi56q32EuO+JBCDJmpadMvYuYq8S+wUBM/SPIIbYclMH
         Jye6/R4oOUl7omO5o0dJRwY8/fQUoe+U1k1PzcNX9YDvs/K9V9rJwft9GtwkMtp+Dxp9
         +ev8nugDqXp0uqDT3TWxI0cc0lGWERQ+hwM1o+hmQhxKgIezTUfe16D6Cs+XT3HPqyNg
         Zgu8xPWqg5uY2Hdw2LZknWEiwqOd1tTXHMTf6DAksMU5ihlFQPiER8CGq5cldZzubxpb
         hRVQ==
X-Gm-Message-State: ANoB5plqqbVAXeBh3rMrrlhOncjbHaJJt18gjrIrMdld88mq9NTKRZNq
        J/zxgvbVq+Du0ztwYrKrcw==
X-Google-Smtp-Source: AA0mqf5Kq7aCH/7UElbfkgcbQsvNIhjJjr62XqJdJEwBt5NiKuud40G6Vkoqh+eVupl5JyLyWf+atw==
X-Received: by 2002:a05:6870:807:b0:144:4e1a:80c2 with SMTP id fw7-20020a056870080700b001444e1a80c2mr7133704oab.138.1670270412333;
        Mon, 05 Dec 2022 12:00:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z20-20020a4a9c94000000b004a3527e8279sm521141ooj.0.2022.12.05.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:00:12 -0800 (PST)
Received: (nullmailer pid 2496556 invoked by uid 1000);
        Mon, 05 Dec 2022 20:00:11 -0000
Date:   Mon, 5 Dec 2022 14:00:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        dianders@chromium.org, airlied@gmail.com, daniel@ffwll.ch,
        freedreno@lists.freedesktop.org, dmitry.baryshkov@linaro.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, sean@poorly.run,
        devicetree@vger.kernel.org, quic_abhinavk@quicinc.com,
        robh+dt@kernel.org, david@ixit.cz, andersson@kernel.org,
        swboyd@chromium.org
Subject: Re: [PATCH v4 07/18] dt-bindings: msm: dsi-controller-main: Fix
 clock declarations
Message-ID: <167027041070.2496499.14501080606552606185.robh@kernel.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-8-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125123638.823261-8-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Nov 2022 12:36:27 +0000, Bryan O'Donoghue wrote:
> When converting from .txt to .yaml dt-binding descriptions we appear to
> have missed some of the previous detail on the number and names of
> permissible clocks.
> 
> Fix this by listing the clock descriptions against the clock names at a
> high level.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml      | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
