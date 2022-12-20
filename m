Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF16524ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiLTQtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:49:42 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76BD165A2;
        Tue, 20 Dec 2022 08:49:40 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s187so11033858oie.10;
        Tue, 20 Dec 2022 08:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xfo0DKmMuO25A+nCHOD0jlMrFZ6CXCqZIybciF03fMk=;
        b=HYQayYd90MT6Vg6nImVPPml7ciY+lCznR1dk1q/DT6m3OAYezOirIMV4mEhNJ6uohy
         QDDsQtKPNyWirKnWyZfkK5Wd5n9/XpO0fEiS5T4mbGJL0pBfvlHilty4utNhj69mRuuV
         TqIF7lDGj5wZgNzLy4iAjl0ZgDtBLp7JPN8t35AnEvxdXRj+HYEdHuj6VcDJNqDlnZbh
         kXEh7KrZwbGzZyAt5MHhWnDm6EgAE1loxHfXDZAQvFH/rVcQ+ON7oT3cA2mP1toBRykq
         2aTesAJXinEtXvqgq2UH7DxqlCHPCqlO6KLwINyvw8SmqO6TKed0Ok7i/DG7dRCFWuSb
         swYg==
X-Gm-Message-State: AFqh2krd+kXV4T/C7NPT8H4S5ZuqFK+qRl7/a5ZWLlT6z0ez9sXV2yTm
        usB8vsD/YlvRH+zPLb4hQw==
X-Google-Smtp-Source: AMrXdXtb9dnjg9S/upe3GH/oPYQi1IvGTkfvaKUQWnOl0cMjKRXg+yxj5Ga1ozak5D9lrEdX8QEf5Q==
X-Received: by 2002:a05:6808:200e:b0:35c:2451:59bb with SMTP id q14-20020a056808200e00b0035c245159bbmr6658804oiw.20.1671554979988;
        Tue, 20 Dec 2022 08:49:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ec10-20020a056808638a00b0035acd0a6eb2sm5668080oib.41.2022.12.20.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:49:39 -0800 (PST)
Received: (nullmailer pid 726453 invoked by uid 1000);
        Tue, 20 Dec 2022 16:49:38 -0000
Date:   Tue, 20 Dec 2022 10:49:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     daniel@ffwll.ch, agross@kernel.org, david@ixit.cz,
        robh+dt@kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        quic_abhinavk@quicinc.com, andersson@kernel.org, airlied@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        dmitry.baryshkov@linaro.org, dianders@chromium.org, sean@poorly.run
Subject: Re: [PATCH v5 07/21] dt-bindings: msm: dsi-controller-main: Fix
 clock declarations
Message-ID: <167155496351.726025.910828492116114621.robh@kernel.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
 <20221220123634.382970-8-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220123634.382970-8-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 12:36:20 +0000, Bryan O'Donoghue wrote:
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


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring <robh@kernel.org>


