Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3165EFE78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiI2UQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiI2UQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:16:15 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1103114AD50;
        Thu, 29 Sep 2022 13:16:15 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l5so2740116oif.7;
        Thu, 29 Sep 2022 13:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AYBgl2IPMMwmLwbaMdRgrBahV880xHZeAH0uCotc0L0=;
        b=wv6SdqSU6A3hzW8QJB9WuBbYxK2eHVbBs0Rpj1OzmNkfRvmX/rfE8RmyAyoTGgAW4H
         g9gywP0cFc2lbw7eHR8BxS6KJPrilTQHLKITzLnvJaqD0LISe/lF7J5PhdDV/dny/nWW
         cUvvUhyek75bNl2wy1JSzgo8oluQ36VocUZSDjconktML84advwUqfBTL1KZtCYJw+Jp
         aW+gaHZMeNp7ikFbsAUpLoEzvcm7RhbKNaiQ2fIEs3g3PQhlL8Rx4ID/b2AVgf0vwIH3
         3VSwkvIsFMX7czwwNBhXctZLExC01LKBCncPTgXHsbV1jcA8Nh2ValX733yYKtQ84unN
         T0Lw==
X-Gm-Message-State: ACrzQf16s0Y6xhZvwdxYtCfpfo2ZtvZN+j1G3scYWr06eqM7HsnnOMSl
        kgX+x3wk9lRHgS5ySAQmRA==
X-Google-Smtp-Source: AMsMyM4S8IQZHV1IVoCFoklvlt4BoCTKjc+NzMKxPogIhfNkH8p9C5tkLQYwRfqsd+B7zIqizQ6FVg==
X-Received: by 2002:a05:6808:1390:b0:350:45fd:7d31 with SMTP id c16-20020a056808139000b0035045fd7d31mr2549024oiw.253.1664482574286;
        Thu, 29 Sep 2022 13:16:14 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u13-20020a056871058d00b001227148da8csm165878oan.36.2022.09.29.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:16:13 -0700 (PDT)
Received: (nullmailer pid 2666246 invoked by uid 1000);
        Thu, 29 Sep 2022 20:16:12 -0000
Date:   Thu, 29 Sep 2022 15:16:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 11/15] dt-bindings: pinctrl: qcom,sm8250: add
 gpio-reserved-ranges and gpio-line-names
Message-ID: <166448257197.2666184.15050572383285281044.robh@kernel.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
 <20220925110608.145728-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925110608.145728-12-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022 13:06:04 +0200, Krzysztof Kozlowski wrote:
> Document common GPIO properties (gpio-reserved-ranges and
> gpio-line-names), already used on qrb5165-rb5 board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml   | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
