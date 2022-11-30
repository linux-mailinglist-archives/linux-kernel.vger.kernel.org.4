Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A270663DCE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiK3SPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiK3SPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:15:17 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD598B189;
        Wed, 30 Nov 2022 10:14:12 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-142306beb9aso21949648fac.11;
        Wed, 30 Nov 2022 10:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td3Xr2Q+awDyXlXFIW/cyg/A4VV5ml96UR5GP8aJN0U=;
        b=j16JWp6VwJmflIIdGoOfOa9FcvC/TofglDpkaq0U8KbaT/dCKpzGiCls5IcRFfwUuD
         D4f6tK+5ze9ft6umF1ff8MsGDj4tzEkQuIO6nw1hTOFNadMXh/bR/dzvI2t/XGCyD9mY
         VRCHrzzHpPGFMcUlx3ptWpRcI3kKYd57yv3SLyo1U+4WpxUQ3ZVDkbKoOQ3KyodB7/8A
         h2y19J2j4KKUX0wLsnbEkBlxkjmNLHZu6NLOenSh+HyjwhRsuZnlyKMn1keznnMx+I17
         RAiCnmjddseBbINdEbyrf8RxiO0H4sfovdqbCLeAeVaHkGOnmu6wdcG8JYf44HsVt3zx
         gscg==
X-Gm-Message-State: ANoB5pkYBybz6S0MRdA9P0wYKvbbEGu1hyChvezaOTlxba1GfZm8tTkt
        DwN3H1c+p5xru1OMmcravlYAwsr5+Q==
X-Google-Smtp-Source: AA0mqf6rplSnWR3Dtda3G8yfAeEo9Oxo7dSuf2gSA6aDMRlDbdPIXcJkcNiapuLS7HnD+a3TnN61Ug==
X-Received: by 2002:a05:6870:8a28:b0:13b:b528:1b8e with SMTP id p40-20020a0568708a2800b0013bb5281b8emr27403120oaq.3.1669832051465;
        Wed, 30 Nov 2022 10:14:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a9d590c000000b0066e67925addsm1218283oth.26.2022.11.30.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:14:11 -0800 (PST)
Received: (nullmailer pid 2553408 invoked by uid 1000);
        Wed, 30 Nov 2022 18:14:10 -0000
Date:   Wed, 30 Nov 2022 12:14:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pinctrl: qcom,sdm845-pinctrl: add GPIO
 hogs
Message-ID: <166983204981.2553357.10032176620298621895.robh@kernel.org>
References: <20221121081221.30745-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121081221.30745-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Nov 2022 09:12:21 +0100, Krzysztof Kozlowski wrote:
> Allow GPIO hogs in pin controller node.  qcom/sdm845-cheza.dtsi already
> uses it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Use different syntax (Rob).
> ---
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml         | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
