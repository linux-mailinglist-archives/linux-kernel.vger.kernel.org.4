Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A56617D3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjAHSJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjAHSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:09:22 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935A76579;
        Sun,  8 Jan 2023 10:09:16 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id g2so3843516ila.4;
        Sun, 08 Jan 2023 10:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXsurnTQkqDtvp9r1jTD8u+Cgja6sWV8sbpQiCK0ozc=;
        b=FdcbWIRTelRgvoCeuN0+MiRkov+W2DdZACYWwhq3AqIgOumnzKq94i+GUwx2aoXHkM
         YYLXLEzm/dsidCdqjS+xbZb5PrlJJoAttHyqW/77dUH1zZlqPbrQrIq7LG09Jot3Jz5I
         dvA6+LdhS3rKEPeHHYjGeTrygbFkZtuzjPU89ZXY3PWvvjLJtZ5I+ObmpAbJ4bjtmrw4
         cGklM/uzsX8r54UATiilhgFgUvZcxiwGMIKhFhNgyj7Y5AbJma7/OTZQpLAVhZinrbZl
         OvSI1ERKbYEwWcTWE7W+iw1UrDiw/FNjiDAJEBmxZRF2YcKJhHkMLbQw+2gDxah+3AvK
         yxfw==
X-Gm-Message-State: AFqh2krpF6JbkmBxOFLzbDH8nek3RSJvhmBowqa6d6o/ek1JC84HHE8C
        9V89g4xytlIdGhawQiAFVA==
X-Google-Smtp-Source: AMrXdXv3wAOICdNq1RPiqJO8HCMJFqLidp5nT4nWPpEzahC2yfHFyjFRoBkR6WUu63GwD35MlGS+Cg==
X-Received: by 2002:a05:6e02:2217:b0:30d:84be:725d with SMTP id j23-20020a056e02221700b0030d84be725dmr9994617ilf.22.1673201355793;
        Sun, 08 Jan 2023 10:09:15 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id c72-20020a02964e000000b00363d6918540sm2067426jai.171.2023.01.08.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:09:15 -0800 (PST)
Received: (nullmailer pid 152523 invoked by uid 1000);
        Sun, 08 Jan 2023 18:09:11 -0000
Date:   Sun, 8 Jan 2023 12:09:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,lpass-wsa-macro: correct
 clocks on SM8250
Message-ID: <167320134913.152434.15549162581347874733.robh@kernel.org>
References: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Dec 2022 12:59:06 +0100, Krzysztof Kozlowski wrote:
> SM8250 DTS uses additional "va" clock in WSA macro device node:
> 
>   sm8250-sony-xperia-edo-pdx203.dtb: codec@3240000: clock-names: ['mclk', 'npl', 'macro', 'dcodec', 'va', 'fsgen'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 58 +++++++++++++++----
>  1 file changed, 47 insertions(+), 11 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
