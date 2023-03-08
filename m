Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA5E6B1322
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCHUeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCHUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:34:17 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6909B9A3;
        Wed,  8 Mar 2023 12:34:00 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id y184so22233oiy.8;
        Wed, 08 Mar 2023 12:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678307640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNHngVArvUe4TZ5wXF/PVQPNweMWjFvEYaHLAdJdEdQ=;
        b=f/HfAQhhsXX+HWPk/6ueBZA4SJKAurdXh/kwWK52mJAWsVQIlCyg/DxLJCOX0rnO6O
         52MCUf/z2iL8q5Lt/h2LZR1NAvEfEoDjOvGUIgAnjS1F3SidelKR6D8QmKMx20uyHjiM
         SPkANSwej3B3JtC4EhcXDffX9Opt2XioAKsToNvsaySnxhd3H1nVQxLbX5n4npQNEgPT
         svEDRdZ/jpOsNo2WlXe7m35CTw1zHcochaXd20E3GXCksILtS1NidKVgJp29bH4xKxug
         +L+56ZVlQPrfmrFc70vYCqniiMw8uMSzmKZuXBxpFids/Dm33G8/nTcuw6z3KHWj0P6P
         gLSg==
X-Gm-Message-State: AO0yUKWPYZhtKJcBBZRgRTxOkZm2QDvMfllXDIfAKl3pn4bljBz2MlBY
        a1d2MSsvVqxeed9BJpqGTg==
X-Google-Smtp-Source: AK7set+cX6eAVVNyP2D3iu9WQi1/qy1OrWz3g8hbqOZ6LB0+sYqYhTHndH/+r4wIQf+TR0vZzguqqA==
X-Received: by 2002:a54:4684:0:b0:384:2d3d:8dab with SMTP id k4-20020a544684000000b003842d3d8dabmr8310460oic.58.1678307639893;
        Wed, 08 Mar 2023 12:33:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b7-20020aca3407000000b0038478923768sm6798430oia.3.2023.03.08.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:33:59 -0800 (PST)
Received: (nullmailer pid 3732566 invoked by uid 1000);
        Wed, 08 Mar 2023 20:33:58 -0000
Date:   Wed, 8 Mar 2023 14:33:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom: lpass-lpi: correct
 description of second reg
Message-ID: <167830763825.3732507.15662293104214662677.robh@kernel.org>
References: <20230302155255.857065-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302155255.857065-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Mar 2023 16:52:55 +0100, Krzysztof Kozlowski wrote:
> The description of second IO address is a bit confusing.  It is supposed
> to be the MCC range which contains the slew rate registers, not the slew
> rate register base.  The Linux driver then accesses slew rate register
> with hard-coded offset (0xa000).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml       | 2 +-
>  .../bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml         | 2 +-
>  .../bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

