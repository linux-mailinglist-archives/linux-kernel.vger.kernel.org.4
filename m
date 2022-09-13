Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2875B75DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiIMP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiIMP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:56:46 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E790816;
        Tue, 13 Sep 2022 07:56:19 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11eab59db71so32749431fac.11;
        Tue, 13 Sep 2022 07:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2/8jBgH5RIn75yN488C2+nFWx/pd5MIa7k/cppE49Xc=;
        b=IylgFFqiMqhJtvMhyWG7SacuzseFzceVslDMByZF3ur4yJrP0mWnKmmCozFs4u1Aub
         hPL6yfuWWi1avOVfrknon89FAp89Orl9gNnGuQf8W/a3K4mXmd7dtDbN3Ywjm8cVNUjH
         zmkmi68Zczh7N4iZUvikMku396+MorHd6Dy5sIzjhhmi2IzK3dks//vS//vc8A74eUVw
         4mF13hQRNersuEFYVNMyG6JA4f1MI5+AfKaNMzq16hW2bi5YEFCfDeI0BGFVftNSxwGa
         1FCu6se4uP9et9f1Tzo7ZXBx/dEn2ehpplJwGesIuXkeAyCQtXYv00Zf1Lfyavx/sbq1
         CkMg==
X-Gm-Message-State: ACgBeo1nmtuxPDzfKIP4/uInftlKZB09lcjykrubsxZ2puiJUSPb0pPX
        pAmP+E2ybo/uIebIaG95tQ==
X-Google-Smtp-Source: AA6agR6YnP6ot9GFC2YmsPAFaS8mzStQhLIBYsq7Zg+QUzJJFdErvSL6rj1KCpYcElzx/lMxYLblxA==
X-Received: by 2002:a05:6870:f203:b0:10b:ad04:57ff with SMTP id t3-20020a056870f20300b0010bad0457ffmr1944683oao.219.1663080893771;
        Tue, 13 Sep 2022 07:54:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q125-20020acac083000000b003437e4f2510sm5203060oif.11.2022.09.13.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:54:53 -0700 (PDT)
Received: (nullmailer pid 3659687 invoked by uid 1000);
        Tue, 13 Sep 2022 14:54:52 -0000
Date:   Tue, 13 Sep 2022 09:54:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 15/15] dt-bindings: soc: qcom: apr: add missing
 properties
Message-ID: <20220913145452.GA3659654-robh@kernel.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
 <20220910091428.50418-16-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910091428.50418-16-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2022 11:14:28 +0200, Krzysztof Kozlowski wrote:
> The APR bindings were not describing all properties already used in DTS:
> 1. Add qcom,glink-channels, qcom,smd-channels and qcom,intents (widely
>    used).
> 2. Add power-domains for MSM8996.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,apr.yaml           | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
