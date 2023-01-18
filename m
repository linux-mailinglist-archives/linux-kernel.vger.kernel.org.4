Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30621672404
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjARQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjARQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:49:07 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA236FE7;
        Wed, 18 Jan 2023 08:49:06 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-15eec491b40so15145849fac.12;
        Wed, 18 Jan 2023 08:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W9y7b/ziaOFjGUNm7d4cmFDdM4EDargAbRPiR5bNLQ=;
        b=4hJywG/AKM9TeRQsQ1JvW4TgL+sbpr+Sl707UiCXzYMrBVwgnbADr+RPSX/FG3YQ0A
         pkF1QZnOKYXM0DiggI10ZgyFmb0l9fOmxsVqQcamcWakQLBou5kVCVhwXAkXyEC5VBY6
         cebO2azcAprqFZ5vJFM2gy0zgBrU5JsFi1pbdVc2JcduaqFhL9Pn3+w4cWzLA6pBGnX9
         OyN0p8fh2HSi9qJ013Kh7QImxGms585wwCwMG4KmPQoZNcKGHZ8a/WapyaWlhbaB1ku8
         klhCU/t1F12f6GLQZTYg7TDqp4LaxJDJvyrQFlh+sXlu1FyxHM6MEbhDdZvZVBFpwD36
         rPmg==
X-Gm-Message-State: AFqh2kpD5KiQuHSrJunYlzmGTj+Cfm/ahLv50+865QxVzlxybHy5fgwg
        fhM8jW/NCulkwvhZ42EKnA==
X-Google-Smtp-Source: AMrXdXtIWuC3J1y+UwrLmINbTm9kPgk76QzDW6udmvO3aPTiNNlYIcEhJTMYOiY45UdU64RY+g328A==
X-Received: by 2002:a05:6870:c906:b0:15e:f1d6:3d8 with SMTP id hj6-20020a056870c90600b0015ef1d603d8mr4189671oab.14.1674060545753;
        Wed, 18 Jan 2023 08:49:05 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id s18-20020a056870611200b0014c7958c55bsm18632011oae.42.2023.01.18.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:49:05 -0800 (PST)
Received: (nullmailer pid 148495 invoked by uid 1000);
        Wed, 18 Jan 2023 16:49:04 -0000
Date:   Wed, 18 Jan 2023 10:49:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,sm8250: use fallback for
 SDM845 sound cards
Message-ID: <167406054417.148440.18145295940494067473.robh@kernel.org>
References: <20230118101542.96705-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118101542.96705-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 11:15:41 +0100, Krzysztof Kozlowski wrote:
> All SDM845 sound cards are compatible with each other, so use one
> generic fallback compatible for them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,sm8250.yaml           | 24 +++++++++++--------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
