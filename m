Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390DA727293
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFGW7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFGW7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:59:12 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7952139;
        Wed,  7 Jun 2023 15:59:09 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77a1cad6532so131259939f.1;
        Wed, 07 Jun 2023 15:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178749; x=1688770749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFzGl5Y+j+urK0M5uIWGN6STqdqRcNA1KNyN7xsd4bE=;
        b=MrcutRWS85/3qN9c/LTv1i4if6iWku781RKZYQdvg8YkHSXjs8I1sVmhjLPQHmjhcl
         TSWRglIpnAS4EkzdCgN+8DjyVDYHxZXcooRMzVzRqzS0o42ejMGdXtILJHz3krdmoIcr
         JrwJiG15JNB9816fnSaxyYD/cX1qGwq66Qyc6la8F7H40iZ/GJa8WIqmbLlRK84mq0GV
         jVaTy3qT9D1aNQRfpWD2UixiEU+ZSCOUcA99ElzG5b0u487eAiG0c7HlpMYfpiQFvCJ8
         FYrZ8Q2AAnMkLM+DK2LL2ltWI0EDu4mPCzds4BE4d+Q7J+9XqW9V39n+y2hcd0cx5suf
         uAFQ==
X-Gm-Message-State: AC+VfDyD/v36TPCj6Wwk1205QSyKUfRJRPQD4742deOuNVS/YCOA42wu
        Eqzr2CChpM3BYaeBzOjV6w==
X-Google-Smtp-Source: ACHHUZ7BnuCAFr2Z4+bfcxl0bBN4CcwOY5nGwEMqgQt5lDW2zkMr5TY+fuJnHMs9/ZGreuSuGR+eQg==
X-Received: by 2002:a6b:6511:0:b0:776:f6cd:f68e with SMTP id z17-20020a6b6511000000b00776f6cdf68emr9602991iob.1.1686178749147;
        Wed, 07 Jun 2023 15:59:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id da26-20020a0566384a5a00b004165ca8e789sm3695833jab.117.2023.06.07.15.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:59:08 -0700 (PDT)
Received: (nullmailer pid 140068 invoked by uid 1000);
        Wed, 07 Jun 2023 22:59:06 -0000
Date:   Wed, 7 Jun 2023 16:59:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/8] dt-bindings: display: panel: mipi-dbi-spi: add
 shineworld lh133k compatible
Message-ID: <168617874553.140010.12334195424988048324.robh@kernel.org>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Jun 2023 13:55:00 +0200, Leonard Göhrs wrote:
> The Shineworld LH133K is a 1.3" 240x240px RGB LCD with a MIPI DBI
> compatible SPI interface.
> The initialization procedure is quite basic with the exception of
> requiring inverted colors.
> A basic mipi-dbi-cmd[1] script to get the display running thus looks
> like this:
> 
>     $ cat shineworld,lh133k.txt
>     command 0x11 # exit sleep mode
>     delay 120
> 
>     # The display seems to require display color inversion, so enable it.
>     command 0x21 # INVON
> 
>     # Enable normal display mode (in contrast to partial display mode).
>     command 0x13 # NORON
>     command 0x29 # MIPI_DCS_SET_DISPLAY_ON
> 
>     $ mipi-dbi-cmd shineworld,lh133k.bin shineworld,lh133k.txt
> 
> [1]: https://github.com/notro/panel-mipi-dbi
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml   | 1 +
>  Documentation/devicetree/bindings/vendor-prefixes.yaml          | 2 ++
>  2 files changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

