Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D016B72728F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjFGW7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFGW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:58:59 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B31FE3;
        Wed,  7 Jun 2023 15:58:58 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-77499bf8e8bso337322139f.0;
        Wed, 07 Jun 2023 15:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178737; x=1688770737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB9XrQ+a6WIZmp+zbM7Qeq67vgXTSlPM9tziF9ThlVU=;
        b=AzcAxLFNK9c24EE3wIwa/nUQNnX3AuUTXnlWxPTsjypJgoo4GjOiFORDCWp1vRIYr/
         QH/crDOq3SQ0kfPLnLJG11cM00StF/SmrgIOTuGLR1pd1eLETpnTQNvYIZKCoHaKAfTe
         4nXoI5MtnQ0cVaT+YEwW5Q1NTNjErLKqIAJ7xXmjXjiWpmT0aiFVRnN2QUZNUyfnRaDX
         SEUHuoh53ymQCdR8oIXzQ6kjWDEVB0XIcRmA8jn2C1moPqZD3m/ZAjX9c0/oX3mVWuJf
         Lx3KZgtipTNTJ0hJe9GONSn1hJHw6M4DWLu6VOWRxv3w8J55brUqo8F+dL2QLv759M/v
         03Sg==
X-Gm-Message-State: AC+VfDyqn+0/MgHe494Khr3uD0pSBFdwLyAkbJzBjKeMePPhYdhq1xZ+
        FMABQqbdOpsCIPvrsQdYtUGBiGD1VA==
X-Google-Smtp-Source: ACHHUZ7GyWclAIE0PzlN9Vgtpl3sBod7vdf2FQhPd2yqzwfylkGB++YMGy6fetz+l45NA7qKGSVwng==
X-Received: by 2002:a6b:e609:0:b0:76c:826f:2188 with SMTP id g9-20020a6be609000000b0076c826f2188mr6026686ioh.6.1686178737285;
        Wed, 07 Jun 2023 15:58:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i24-20020a02c618000000b00411baa5ec5asm3665517jan.154.2023.06.07.15.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:58:56 -0700 (PDT)
Received: (nullmailer pid 139626 invoked by uid 1000);
        Wed, 07 Jun 2023 22:58:48 -0000
Date:   Wed, 7 Jun 2023 16:58:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/8] dt-bindings: display: panel: mipi-dbi-spi: add
 spi-3wire property
Message-ID: <20230607225848.GA131389-robh@kernel.org>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-2-l.goehrs@pengutronix.de>
 <69fdb6a2-12b6-547d-019b-c77dd2bd98cf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69fdb6a2-12b6-547d-019b-c77dd2bd98cf@tronnes.org>
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

On Wed, Jun 07, 2023 at 09:59:47PM +0200, Noralf Trønnes wrote:
> 
> 
> On 6/7/23 13:55, Leonard Göhrs wrote:
> > Some MIPI DBI panels support a three wire mode (clock, chip select,
> > bidirectional data) that can be used to ask the panel if it is already set
> > up by e.g. the bootloader and can thus skip the initialization.
> > This enables a flicker-free boot.
> > 
> > Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> > ---
> >  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml   | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> > index c07da1a9e6288..2f0238b770eba 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> > @@ -87,6 +87,8 @@ properties:
> >        Logic level supply for interface signals (Vddi).
> >        No need to set if this is the same as power-supply.
> >  
> > +  spi-3wire: true
> > +
> 
> I don't think this should be added here. spi-cpha and spi-cpol are also
> supported but they are not mentioned. Instead those are documented in
> bindings/spi/spi-controller.yaml. Why they're not documented in
> bindings/spi/spi-peripheral-props.yaml instead which this binding has a
> ref to, I have no idea.

spi-peripheral-props.yaml are properties of the controller in the 
peripheral nodes. spi-cpha and spi-cpol are properties of the device 
which are completely invalid on some devices. We can only check that by 
documenting where they are valid. I think spi-3wire is similar. There 
should be more explanation in the spi-peripheral-props.yaml commit 
history.

Rob
