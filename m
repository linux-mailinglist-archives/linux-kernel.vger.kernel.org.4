Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA65EB25C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiIZUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiIZUib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:38:31 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E1A6C50;
        Mon, 26 Sep 2022 13:38:26 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-130af056397so10822701fac.2;
        Mon, 26 Sep 2022 13:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qq1TsJYGKDd8Wn1haQqnFr3RMoDaojbjPGdRkLrnils=;
        b=xyXj9198KWNqU2W6aET4SQk6qBfXr0otvlizudj8wPO3FgRIpGvfFcDKpI30osK1It
         5UAO7Wdm3AxNvy2V3lwblsgo8bM2PfRp1RK/Tv30+p5bCsK2W+5xWLTSb29OtFKZrO4M
         1GIbS7pX/6zTkNU9rxTTmnjGyTYaw548+KJdVXmzFmc0FOGSXaBf7ozU4/QCuIp7w+Xn
         uQYWXzuoYnIKrcVsdyPgLR+dfi9jMiQwOfB8rS4rgIL/NGTvQ4gNRqLNTzqZ2x8caDhR
         w/lRCnRdSr0EcLH8o0sp47MDOLoxUNg4qxVSpHwfG/pE6az2AX1LWJvUb8YTBVTONqRK
         FUlA==
X-Gm-Message-State: ACrzQf3H3zCT19uH0NK1Z/jRoTXjvR9UPyBAdP5Z5/4zCWC+9eNUEq7f
        BtfxbPGHwVe3HWn48KSwyA==
X-Google-Smtp-Source: AMsMyM7rzFTX7zydcfZXG8hepjYJMZVprsmtF7L7ca5Orkxh7yZk61A0H0rYLGT3nmUykuv70XvtnA==
X-Received: by 2002:a05:6870:8191:b0:127:e021:9f3a with SMTP id k17-20020a056870819100b00127e0219f3amr303854oae.164.1664224705804;
        Mon, 26 Sep 2022 13:38:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cd8-20020a056830620800b00639443424f8sm8450133otb.8.2022.09.26.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:38:25 -0700 (PDT)
Received: (nullmailer pid 2768863 invoked by uid 1000);
        Mon, 26 Sep 2022 20:38:24 -0000
Date:   Mon, 26 Sep 2022 15:38:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 06/12] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: fix
 matching pin config
Message-ID: <20220926203824.GA2768837-robh@kernel.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 21:56:45 +0200, Krzysztof Kozlowski wrote:
> The LPASS pin controller follows generic pin-controller bindings, so
> just like TLMM, should have subnodes with '-state' and '-pins'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 36 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
