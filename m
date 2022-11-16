Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A6262C0C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiKPO2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:28:35 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D10FCB;
        Wed, 16 Nov 2022 06:28:34 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id l127so18673116oia.8;
        Wed, 16 Nov 2022 06:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJm4Khl2AqxNBL7jLr8tofG6XONtUSnDoYtCODWM95I=;
        b=3jatdqJuwd8F0+iYb60QEL4RHKZTy1OQQm11ENV8QfDzhPsvFXjIEiTgVx8vd64Iz3
         iePzzZUj6qzDbGtuHTTwP61bySTvpa/gJgASiaL0ott+G+SS+INu11TuSjPzl4EUGPxF
         y6qUfcCL4OGO0YgYNjKxh4wms2CX6h5DTHhnD8iNpdB5jA0O6KGR9hgltSI7FBaBQL6U
         cPQj1cA+1fSs5mb2Sbux6lyeS0f34r9Bq8CGNwwrX4dCYlqXHDTy1grRSSo0hBUv4K1l
         tf2Yg658H5O4X/0tJZA6NReAjhrxYPr9B6cSZHx/aEdA85sg/GNWdoIKkauzV4dEZayX
         SBvg==
X-Gm-Message-State: ANoB5pmg2CX9bs6r0cVidks6d+gO/Ul84gQIB99CObiRUERXtA2qE28r
        zv7l5F0oMf8SwUV1qvla6g==
X-Google-Smtp-Source: AA0mqf4sINa2t2XydjWBN/1d75ne+X4d+3nvk2RXDH/iplrAJ1owmL/DpO9cHAVg+yGj7EE6duQ8+w==
X-Received: by 2002:a05:6808:2d7:b0:35a:2325:7aff with SMTP id a23-20020a05680802d700b0035a23257affmr1668308oid.41.1668608914171;
        Wed, 16 Nov 2022 06:28:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l12-20020a4ae38c000000b0049f3bdd791esm5872269oov.26.2022.11.16.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:28:33 -0800 (PST)
Received: (nullmailer pid 3804306 invoked by uid 1000);
        Wed, 16 Nov 2022 14:28:35 -0000
Date:   Wed, 16 Nov 2022 08:28:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, quic_srivasam@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        quic_plai@quicinc.com, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 01/11] ASoC: dt-bindings: qcom,apr: Add GLINK channel
 name for SM8450
Message-ID: <166860890990.3804146.6416157036563364508.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:25 +0100, Krzysztof Kozlowski wrote:
> On SM8450 and SC8280XP with Qualcomm GPR, the GLINK channel name
> (qcom,glink-channels) for ADSP is "adsp_apps".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.yaml        | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
