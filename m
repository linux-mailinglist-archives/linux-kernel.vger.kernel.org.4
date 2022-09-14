Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D55B8B43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiINPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiINPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:05:46 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3625C948;
        Wed, 14 Sep 2022 08:05:44 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id d25-20020a9d72d9000000b00655d70a1aeaso7447859otk.3;
        Wed, 14 Sep 2022 08:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=80//9U4S6KsWyMgkd9OiwJsN9gRoyLztpU/FnVB8ROI=;
        b=rjS73MzAQrLV8oiXkqN7vSp/NiZldjAs0wGccHvey8PDxrvkBOio1IdnZDX+tcxL7p
         E0uek3G7HWSniNU/0UyUmoYAWEeDREQSUf+zBAz/jNsYf0rPLmGtJpc72abLPIv3PBVq
         A6s4LQIsGDmbjnCFX93Q9AhaianS86klPljLRthksUFvqyAQ+XxgBZNZDgI3e+9X6CeN
         QZcEqyPdXHaaTUh6l1qJDJXdu/1DYqHZXaxFQkd83sEHFSibiJFDGIQ1JwBzrLgN7gLf
         TMzAp/ICNCYadyzpNOGrV8mM58D9iSmqYGBGcMIU6PPmmv2DnblK1vUCVZkqkTNbT6Ig
         CevA==
X-Gm-Message-State: ACgBeo1Y0WwMeZYLI4jH/oiOBxfOY7oO7h+dqwrTiPfhWL5UU7BbD8Me
        3u8wSLnUGiTSy9Jax5PArw==
X-Google-Smtp-Source: AA6agR5zJBQVMjWrqECTLtJ5QNTsna7ICAdaJtE7muSiIc4MWJbSXlOqCD8A1Zi0t18uXDKx2/3fxQ==
X-Received: by 2002:a9d:be7:0:b0:655:b6da:7eda with SMTP id 94-20020a9d0be7000000b00655b6da7edamr10632379oth.46.1663167943740;
        Wed, 14 Sep 2022 08:05:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q14-20020a056871080e00b00127ba61535fsm8664215oap.15.2022.09.14.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:05:43 -0700 (PDT)
Received: (nullmailer pid 2218149 invoked by uid 1000);
        Wed, 14 Sep 2022 15:05:42 -0000
Date:   Wed, 14 Sep 2022 10:05:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: gpio: Add gpio-latch binding document
Message-ID: <20220914150542.GA2218095-robh@kernel.org>
References: <20220914071306.3254881-1-s.hauer@pengutronix.de>
 <20220914071306.3254881-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914071306.3254881-3-s.hauer@pengutronix.de>
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

On Wed, 14 Sep 2022 09:13:06 +0200, Sascha Hauer wrote:
> This adds a binding for a GPIO multiplexer driver based on latches
> connected to other GPIOs.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v1:
>     - Add license to binding file
> 
>  .../devicetree/bindings/gpio/gpio-latch.yaml  | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
