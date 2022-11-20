Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F1C631547
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKTQxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTQxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:53:22 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C72E9EB;
        Sun, 20 Nov 2022 08:53:22 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so6065267otl.7;
        Sun, 20 Nov 2022 08:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoQ4zuyTd7evirB3DHF86QcOknBwVYfLo01LRkadhOQ=;
        b=u0CZTlhYPZ5ckXtB/w2AhrovL27QJCgeBEjvlW4zaByxMdJbTB/vcVEKc7b3va21st
         pyOIo01WLrqMq816N8Q1LgQwqzkH8VFL7MQUpjD23FBNPyr0HCMc+COLi57tpQa9jfIq
         7Cnk0zz/LFHDUu4TU9s7guZM9YUDLHPfmjTMPmYrOrQ2VqjzKQzBdufHMiAhDG04yWh7
         b7Y6/EhjRtNWhiuKVIk979WD3IExGEFGld1xFbvZjzRP5HfRe8Qy1oUALqbWFytixbqs
         V7swzXYQKQyBnJs9oy9k4n/BLRLBJ4031AVk5efkASn1qJbEVbayweDP079yQsvxudV8
         bmvg==
X-Gm-Message-State: ANoB5pl9zog/Il5BR5Eypzj4A9GsAX5iYxgK8SF9kbsHb3ONQQu2nqMe
        JGDY3xgrNm9xY3tsJnyfufdD17TIPQ==
X-Google-Smtp-Source: AA0mqf7VoumVeOat8gcKUatjmfqniX6zO3MOiPw3zmmtuxnZ2rqYap6OXiFNILEtWXSN+2z5E8jX9A==
X-Received: by 2002:a9d:7e9a:0:b0:66c:6096:1878 with SMTP id m26-20020a9d7e9a000000b0066c60961878mr634215otp.203.1668963201355;
        Sun, 20 Nov 2022 08:53:21 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:5cb3:df5a:23c3:86fb:15a6])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870d0c500b0014185b2b3d5sm2833328oaa.18.2022.11.20.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 08:53:20 -0800 (PST)
Received: (nullmailer pid 3191260 invoked by uid 1000);
        Sun, 20 Nov 2022 16:53:22 -0000
Date:   Sun, 20 Nov 2022 10:53:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, agross@kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        andersson@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        patches@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dt-bindings: msm/dsi: Don't require vdds-supply on 10nm
 PHY
Message-ID: <166896320103.3191204.6491707287483372164.robh@kernel.org>
References: <20221116163218.42449-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116163218.42449-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2022 17:32:18 +0100, Konrad Dybcio wrote:
> On some SoCs (hello SM6350) vdds-supply is not wired to any smd-rpm
> or rpmh regulator, but instead powered by the VDD_MX/mx.lvl line,
> which is voted for in the DSI ctrl node.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
