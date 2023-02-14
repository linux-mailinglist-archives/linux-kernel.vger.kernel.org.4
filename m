Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D19697246
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjBNX6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjBNX57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:57:59 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1ABB82;
        Tue, 14 Feb 2023 15:57:57 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id 18so897388ilg.3;
        Tue, 14 Feb 2023 15:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeYxkETlP+j2/3REjtjMCDSYf/OdbSqdZdWMS3XrVDE=;
        b=NIdSn2FPs0afajLBRtaGQrEusOfhDAoR3J6eiZQsaaTYghbo9R6KdOCu+LueroT7or
         lUDH3Kkkz5MJU/KHOrZVKykMnE5rURECOVGRsq3T/GqXMIPE6UPR/LlRiYyAclfbWFkW
         KE67QTj35niQXJyPq0dcGlV/AlTT5gDLrYJ+WvECxTuCCE7d6iTUImljHaCJ19BBKwNC
         cxy+e2FUYZQzcqSvXZQfHQKYAsl3z+71lC1nAuLH3CnxYY7PBlKt5xuUsS6d0Yo8ULZ8
         GqEISFebScNRjErFKyDS/twgkYvWF23/lv7iI5RqTwQNE3NRa/POznwhaRGsInIwn46h
         LSHA==
X-Gm-Message-State: AO0yUKVuFFqk4dhckEIEuxCvHicBUMy7ZTtKcGJ33NPg5TV1s8g10+PY
        TA+WP6yxGcQK6V+LO2TEDw==
X-Google-Smtp-Source: AK7set+VE+S5NKrV/pyFHml4rxisTMgU4caFP+H7RsaZYsZaoraA1KXIngG7aiNE0DTeJ3y5OVe1BA==
X-Received: by 2002:a92:cd8e:0:b0:315:415a:4e61 with SMTP id r14-20020a92cd8e000000b00315415a4e61mr526178ilb.11.1676419077169;
        Tue, 14 Feb 2023 15:57:57 -0800 (PST)
Received: from robh_at_kernel.org ([65.158.198.6])
        by smtp.gmail.com with ESMTPSA id p3-20020a92c603000000b003129e9480ebsm5107354ilm.47.2023.02.14.15.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:57:56 -0800 (PST)
Received: (nullmailer pid 56787 invoked by uid 1000);
        Tue, 14 Feb 2023 23:57:54 -0000
Date:   Tue, 14 Feb 2023 17:57:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        agross@kernel.org, Sean Paul <sean@poorly.run>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        marijn.suijten@somainline.org, andersson@kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 02/10] dt-bindings: display/msm: dsi-controller-main: Add
 SM6375
Message-ID: <167641907419.56714.15225525581461170662.robh@kernel.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-3-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211122656.1479141-3-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Feb 2023 13:26:48 +0100, Konrad Dybcio wrote:
> Add the DSI host found on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

