Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0D61FF2B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiKGUIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiKGUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:08:03 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5157C2AC6E;
        Mon,  7 Nov 2022 12:08:01 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso7208329otb.2;
        Mon, 07 Nov 2022 12:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e+1CQkY31rHRU0NgYRi9WpKBJmDl6YDaaKalJuxGYI=;
        b=DSuWORcZm2esk4UkhYLC7luaIFUQmegaEHE92/O76wlaZ4B6JB0nxwXsuvCgLZh9Na
         QZ90hbXj/+zWN05OkPOe9a5HDulWJnaS+FbTsmkD6Mb4qrsPm14PoXXc1NzhcwzxxxPf
         dVfBExGjkHkDRGP2A5CIETRxeWuyPp7mFS4hcboVsFhXeJZOf+Wns9UWt0wgGzymdDAg
         86xd4gdf0+WSC1S4aZO/Tw6FL2mySOmm8c4WQ7qha2BKdKuhildrtELFs4vOO3dGVmpJ
         cu9fhCcYTQbk3mfLsh7bxnn6i31X6Bf2Lx0B+Vql5nmy1mdQdh3hH5V7CZsBsqYZM9JH
         T2OA==
X-Gm-Message-State: ACrzQf29ptMys5AqApX6sYj88UN2uF1bltF2spXYJXYsx0SmfRZPAIXo
        fQD51LUcKKg4f0DWz3bmsQ==
X-Google-Smtp-Source: AMsMyM42ecXI4jCMeu1Vcv60kCpnrjWz5XTXNFhmZZ/yXrVn/q9+wmUt8QoVVIhjw/+1BIFiuvTv+w==
X-Received: by 2002:a05:6830:2aa3:b0:66c:9a3a:539 with SMTP id s35-20020a0568302aa300b0066c9a3a0539mr8688491otu.317.1667851680547;
        Mon, 07 Nov 2022 12:08:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u8-20020a9d4d88000000b0066871c3adb3sm3330746otk.28.2022.11.07.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:07:59 -0800 (PST)
Received: (nullmailer pid 1525000 invoked by uid 1000);
        Mon, 07 Nov 2022 20:08:01 -0000
Date:   Mon, 7 Nov 2022 14:08:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Banajit Goswami <bgoswami@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,lpass: do not hard-code
 clock-output-names
Message-ID: <166785167860.1524281.4239012568327496150.robh@kernel.org>
References: <20221103195341.174972-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103195341.174972-1-krzysztof.kozlowski@linaro.org>
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


On Thu, 03 Nov 2022 15:53:39 -0400, Krzysztof Kozlowski wrote:
> The purpose of clock-output-names is to customize desired clock name,
> not use one, same name.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-rx-macro.yaml         | 3 +--
>  .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml         | 3 +--
>  .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml         | 3 +--
>  .../devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml        | 3 +--
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
