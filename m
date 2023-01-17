Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9274F66E82B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjAQVKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAQVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:08:34 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A475B917DF;
        Tue, 17 Jan 2023 11:33:17 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id d188so15668953oia.3;
        Tue, 17 Jan 2023 11:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/5VHDfuP60dlqe33FBmFK6FgItob/cxxKnvyTavuYE=;
        b=ObXWG9NdoPWn2/damOzMZ9EkghAVyrOFDyQRQPAp3eJOmPGhv5tlhw6nd/VHyECFTP
         4XM6MA0ieECUP12w5XxyUKyue49IMJf1IXUdgzbjrX/ekU7CqGR/Y2t6Q+A/q4ZBoDeL
         BSZX8Sp7hctC5dM3P8P1NNFBOmgZmfuLZ+/q3ryd0z0y7N2eZmflb4/ASSOfOQJa5IsK
         7F70FvlJBvL+FBApOepTqj6CU57JcnA4HsUvTTb1HFjf863V3bnxAoclr2nAZJpbokvp
         1uLJqK4Jv/cD8LmHkfzDwHdChxLbGp+XWgZ3F3Mv6SvTq+821H82+ZG0zV6GoPqc/QUx
         XIIg==
X-Gm-Message-State: AFqh2kriuDytGgcO8d3ht32BgbuPhKrMtucaxffTUOqQ5gYvKEYCqXjO
        dmovMTg14CvbkjziIGxMCwoM7lPruQ==
X-Google-Smtp-Source: AMrXdXvSKOggm/yjSQrSk84DQlXTfHz0baeJwd3/p31H4zN6IQISF1PzfbOm3NU2JN6ca56PgFDj1g==
X-Received: by 2002:aca:6706:0:b0:367:30b:ef76 with SMTP id z6-20020aca6706000000b00367030bef76mr1947484oix.46.1673983996953;
        Tue, 17 Jan 2023 11:33:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v25-20020a05683011d900b00683e4084740sm16785861otq.10.2023.01.17.11.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:33:16 -0800 (PST)
Received: (nullmailer pid 3504196 invoked by uid 1000);
        Tue, 17 Jan 2023 19:33:15 -0000
Date:   Tue, 17 Jan 2023 13:33:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: qcom,wcd934x: Allow usage as IFD
 device
Message-ID: <167398399522.3504122.3368632808087174176.robh@kernel.org>
References: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
 <20230113162214.117261-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113162214.117261-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2023 17:22:14 +0100, Krzysztof Kozlowski wrote:
> The WCD9340 audio codec appears on Slimbus twice: as IFD device without
> properties and the actual audio-codec referencing the former via
> wcd9340_ifd.  Allow in the binding both versions to fix several warnings
> like:
> 
>   sdm850-samsung-w737.dtb: ifd@0,0: 'reset-gpios' is a required property
>   sdm850-samsung-w737.dtb: ifd@0,0: 'slim-ifc-dev' is a required property
>   sdm850-samsung-w737.dtb: ifd@0,0: 'interrupt-controller' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> oneOf: interrupts-extended|interrupts is needed to avoid dtschema
> limitation.
> ---
>  .../bindings/sound/qcom,wcd934x.yaml          | 58 ++++++++++++++-----
>  1 file changed, 43 insertions(+), 15 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
