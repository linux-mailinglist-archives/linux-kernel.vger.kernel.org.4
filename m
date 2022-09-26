Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535B95EB234
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIZUhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIZUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:37:09 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE326CD2F;
        Mon, 26 Sep 2022 13:37:08 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1279948d93dso10786349fac.10;
        Mon, 26 Sep 2022 13:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Lf/L/7btd4/56IaLxS/+ylhU4Ie5TSh7uLYhF3NDTM0=;
        b=qHA31eSIhMwQta2rjb/MKdMZMWrwQvDahEA0BnAqSWI6Soh4nQehD5+lXXfUxsWpqd
         GILh0Y8XUbJOxTBFR34HVhI56D4ziHHLnR813NuQ0Px740AWGreTnDcrDfZebD9ZWn4N
         x31MbKKuGJEUiiMZnA8ezuSDbr06NBaEy3yGhr0lbSn3cGzEK8TzrUj5WxhctHwtrqE+
         Wi0CrXlofG+lhiFXbA9e1FaXAPEoNj7oqh9U3gbw0+ORS8/D3YyOQUSmHU4aSF+Udtiv
         8172tof+xctlLVj4QnmsaRpJppHmwOWJ/y1PH/P7KLtfkAyno+Zj9/lW2aVEocg/xnM4
         K88w==
X-Gm-Message-State: ACrzQf1TToJhG3FgiaHXDlsNsaVQlKFzpI9bQguskgQU4HwCzEhk95Lj
        gxDD+jpKHqOJ2jjF1x6qiQ==
X-Google-Smtp-Source: AMsMyM6UBjBZTxPbS5L/71E/JSzuaY4J5yMIrEFWVNp7EobIm7sTaNtyYDwjt1ZgbJfmchTrPGSg5Q==
X-Received: by 2002:a05:6871:154:b0:130:fa5d:1d39 with SMTP id z20-20020a056871015400b00130fa5d1d39mr283489oab.225.1664224627623;
        Mon, 26 Sep 2022 13:37:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u27-20020a4a6c5b000000b004761ac650e1sm7045001oof.42.2022.09.26.13.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:37:07 -0700 (PDT)
Received: (nullmailer pid 2766197 invoked by uid 1000);
        Mon, 26 Sep 2022 20:37:06 -0000
Date:   Mon, 26 Sep 2022 15:37:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/12] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: fix
 matching pin config
Message-ID: <20220926203706.GA2766135-robh@kernel.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-4-krzysztof.kozlowski@linaro.org>
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

On Thu, 22 Sep 2022 21:56:42 +0200, Krzysztof Kozlowski wrote:
> The LPASS pin controller follows generic pin-controller bindings, so
> just like TLMM, should have subnodes with '-state' and '-pins'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
