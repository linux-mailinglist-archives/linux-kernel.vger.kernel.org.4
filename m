Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DE6617D6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjAHSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:10:05 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377112D;
        Sun,  8 Jan 2023 10:10:05 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id m15so3847271ilq.2;
        Sun, 08 Jan 2023 10:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiDtm4dg6sBcZvEsrtZDf8KneTPB6egmjNiY/UbVENE=;
        b=Rm3wLrn3cBPu9YbgHj6jacduGkRXLd2TXlMMcwAMhGKotsOSvQvPHSpFc+M2gSiBSq
         cRYJOnMatJt6l+OJSY34hFbF/nCTyp3OR0lGJjw6K/ZTIMh5mxwcA6KrpHwZMd2SQQ5K
         q1wEL+add2Xs2Ev4xCWAsjlzBq0sdkSNXznj44LWTDDw/Sg0iQIU8UNkr1XZ1wq6ainw
         8zUvr5CMEMJ7N9KE3odKF8TUQZf74w1AFh/fW88ZNIY5gvfSr9O+MNFCBWY7ea89eHDN
         80Pc3mGekazEE0/a45mlX91NTmTn4TeS2xM3SOr5ApmnLqn9F0ohE6rtj+UoozxI4Ec0
         jcww==
X-Gm-Message-State: AFqh2krfKKNxlMKD+VnL3Grnsjiidq6y7TacsN8Rao68/C8tbyoEyKMG
        M697RgLjdeamnJilaTqUXQ==
X-Google-Smtp-Source: AMrXdXsTb3xz2g05XmKI/Rwa/5xKheM+PvRs63uDP3nLe5Saz66r8IjIA0dJsxAiyvyJTh36ORb2Pg==
X-Received: by 2002:a92:d448:0:b0:30b:f758:22db with SMTP id r8-20020a92d448000000b0030bf75822dbmr46852324ilm.2.1673201404490;
        Sun, 08 Jan 2023 10:10:04 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id w8-20020a056e0213e800b0030c2667fe17sm2112283ilj.80.2023.01.08.10.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:10:04 -0800 (PST)
Received: (nullmailer pid 153586 invoked by uid 1000);
        Sun, 08 Jan 2023 18:10:01 -0000
Date:   Sun, 8 Jan 2023 12:10:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Banajit Goswami <bgoswami@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: qcom,lpass-tx-macro: correct
 clocks on SC7280
Message-ID: <167320139670.153361.17614063062571302381.robh@kernel.org>
References: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
 <20221225115907.55250-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115907.55250-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Dec 2022 12:59:07 +0100, Krzysztof Kozlowski wrote:
> On SC7280 ADSP bypassed platform, there are only three clocks for TX
> macro.  This is already reflected in "clock-names" but not in "clocks"
> property:
> 
>   sc7280-herobrine-zombie-lte.dtb: codec@3220000: clocks: [[219, 8], [219, 7], [220]] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
