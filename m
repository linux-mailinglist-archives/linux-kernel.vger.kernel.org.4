Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0CF66191C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjAHULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjAHUK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:10:56 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AEFE027;
        Sun,  8 Jan 2023 12:10:51 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id o13so3937617ilc.7;
        Sun, 08 Jan 2023 12:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sh3DXez5ACXFc9XSxkBw94F8RRZDa+4rhrLswfSTRBE=;
        b=mOe1YDHFgG+xs0p+kCVlK/bWyNDeUb8CLFV5hg+IrHtPM5o4mLgMg7IcOgz8/vGX0g
         E8KxkKZSjXlIETJwbfO2Zm1Mz9yYRofOzPhK28OyEDlHjo1DQRcjTw7+IzuUIY3cImCd
         3OAVg/vrVarf2qlrhiTcg6DMa22cLzkXgto+SiTwZExES2FJ2rL6NSEDlqDDjdoMuZ+V
         8KJLT+Dvda2zj/90YDYff1A8HuIoRlOlJHbXafttVuYkOyQXxeLY1LLVpRJDFFWIjeng
         PEBbTLh3IDUMQ4xKM9pxDojnZHOOCEufwJ48DqbytxdU5IxWpGcV490245cli9ipBcQW
         Dzdw==
X-Gm-Message-State: AFqh2kqyNzcFyGxT7zW6/bAQOf1C0yS9tGeFNh/I8ogiabycqVmusoz2
        JQGiY6Fbs2wZFJFlQDC4ig==
X-Google-Smtp-Source: AMrXdXsaduou0NNr8UnH4fpV6NbxrfxOWDJGptSw+ZgTSnhagb8d020QpHbMGiorefVuGf4WZeBYhQ==
X-Received: by 2002:a05:6e02:12eb:b0:303:94bf:b0bb with SMTP id l11-20020a056e0212eb00b0030394bfb0bbmr54431258iln.29.1673208651262;
        Sun, 08 Jan 2023 12:10:51 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id l10-20020a92d8ca000000b002fc323a2902sm2151420ilo.62.2023.01.08.12.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:10:50 -0800 (PST)
Received: (nullmailer pid 215627 invoked by uid 1000);
        Sun, 08 Jan 2023 20:10:47 -0000
Date:   Sun, 8 Jan 2023 14:10:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Iskren Chernev <me@iskren.info>,
        Richard Acayan <mailingradian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 5/9] dt-bindings: pinctrl: qcom,sm6350-tlmm: correct pins
 pattern
Message-ID: <167320864018.215287.10419134874689372190.robh@kernel.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
 <20221230135645.56401-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230135645.56401-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Dec 2022 14:56:41 +0100, Krzysztof Kozlowski wrote:
> SM6350 TLMM pin controller has GPIOs 0-155.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
