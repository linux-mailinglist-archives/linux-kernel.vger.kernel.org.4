Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7595EB25A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiIZUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiIZUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:38:29 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24999A8CE7;
        Mon, 26 Sep 2022 13:38:17 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id m81so9754738oia.1;
        Mon, 26 Sep 2022 13:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=z4uefJDQsrqt5yW9Ow39DtCuB3blyIgQ7z8XNV7b08g=;
        b=EjeW/o7vKD/X3AhK/n6USRTTNMxkbejq89xVy69IWkg1hSnaAG60UROc0YRGRXr6fk
         J7+dRAFwyG/UuvXu/r7lgMpNJ2jT5pbcnZMVFM6FL1vKCzbkJqrAnuOgelRnCK38Q57l
         9Of4EkEcHTTVY1qGbU1n3OS2Sc0HbtfI04FoqWS0bRvK4zHKxpKwzGmisbn+THuXYynb
         n+gRCp64LnOv20qG94UCO4+SvC1jrWx9dZcE6qMtsU/dKQd4yd5i5J/JohCtEFiMjLPm
         sDKbd6EcmVDhkfxh4hynPkYwM9daZFe+HohirHXOO9cWZs68+i3bwYTdQB34ioohVhYK
         eG1w==
X-Gm-Message-State: ACrzQf3hMeHpB1Z3NeOXlj/qNkUHNdvxd8sPG7EbUgJ31l6g6/0LAmYs
        p0pCN5V5WSUs2n6s6ay54Q==
X-Google-Smtp-Source: AMsMyM4RjU8fLvllGdrIiA7dteRyyHjZ6sR0007IiG1ahZMHOUbsnaCeCs+Kbav2zelXp/PReXEJ5g==
X-Received: by 2002:a54:4485:0:b0:34f:b741:9932 with SMTP id v5-20020a544485000000b0034fb7419932mr274689oiv.42.1664224696188;
        Mon, 26 Sep 2022 13:38:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o188-20020acabec5000000b00344afa2b08bsm7691630oif.26.2022.09.26.13.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:38:15 -0700 (PDT)
Received: (nullmailer pid 2768521 invoked by uid 1000);
        Mon, 26 Sep 2022 20:38:15 -0000
Date:   Mon, 26 Sep 2022 15:38:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 05/12] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: fix
 matching pin config
Message-ID: <20220926203815.GA2768458-robh@kernel.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 21:56:44 +0200, Krzysztof Kozlowski wrote:
> The LPASS pin controller follows generic pin-controller bindings, so
> just like TLMM, should have subnodes with '-state' and '-pins'.
> 
>   qcom/qrb5165-rb5.dtb: pinctrl@33c0000: wsa-swr-active-pins: 'pins' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../qcom,sm8250-lpass-lpi-pinctrl.yaml        | 36 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
