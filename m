Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC25EB274
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiIZUmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiIZUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:42:12 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D456AA6C26;
        Mon, 26 Sep 2022 13:41:59 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1279948d93dso10799197fac.10;
        Mon, 26 Sep 2022 13:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=t8Pxstafi1ZYmfHdmZVqLjGxt/CEl5MiJcdQGf3rGTo=;
        b=4+8u7o8Q7l2zGttyfS/ePBUQvIvnuXD+eig03RtGVpgmEk0YIkpyU2OwrHoujIX6v3
         ToIrrtW4ZLC2wiojZk+mldD/uT8Otx2a6mEf5TQPb8toEkFFw7T0oO39v28PUkyknAUM
         ubhX9p0XLM2em+Or72R7+4w/wXf01tH56exvKJXfb1arsjCVJt1fZA/oEgjvzHJ99j8L
         43RKPYM11tZGgCyV0Y9yfRPpNpaymliPj9gyZwFhwX3LV2E2Lm+Q9vgl99qHfStHlcUN
         4BCfdyhlSkdn9devBedd0UraQPNqWuSUuPSJv+nxSvL0YJ1mr8wwTDjQb1HVT9qdrzX+
         4wJg==
X-Gm-Message-State: ACrzQf1Yu7dynsg5tnL0Jv2Wbp7spdKOEWKJdheqDNBiObgmgCfQL2F4
        lZxnEFVEcZq5R24fisb0yNZaIS4gUA==
X-Google-Smtp-Source: AMsMyM7P3YPDDvLX5vmZrov5YnzZrj2holA9MF1vwNJHMzaO+olGD4bBWTuEfK2x+8sAcOuMvlU+cg==
X-Received: by 2002:a05:6871:5d3:b0:12a:e853:b0d3 with SMTP id v19-20020a05687105d300b0012ae853b0d3mr314917oan.124.1664224869323;
        Mon, 26 Sep 2022 13:41:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d23-20020a056870961700b0010e73e252b8sm9504805oaq.6.2022.09.26.13.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:41:08 -0700 (PDT)
Received: (nullmailer pid 2773581 invoked by uid 1000);
        Mon, 26 Sep 2022 20:41:08 -0000
Date:   Mon, 26 Sep 2022 15:41:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: fix
 gpio pattern
Message-ID: <20220926204108.GA2770206-robh@kernel.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-3-krzysztof.kozlowski@linaro.org>
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

On Thu, Sep 22, 2022 at 09:56:41PM +0200, Krzysztof Kozlowski wrote:
> Fix double ']' in GPIO pattern to properly match "pins" property.
> Otherwise schema for pins state is not applied.
> 
> Fixes: 4faa4e73011d ("dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi pinctrl bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Other than the same confusing commit msg:

Acked-by: Rob Herring <robh@kernel.org>
