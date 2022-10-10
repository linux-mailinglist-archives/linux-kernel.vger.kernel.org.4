Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3675F9EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJJM6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJJM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:58:00 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ECE6C77B;
        Mon, 10 Oct 2022 05:57:59 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id w74so4386713oie.0;
        Mon, 10 Oct 2022 05:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02DHLrzLJP8kPkxHoMJSCUYhnTM9XF5dBkLVhcluWS8=;
        b=z6zniCBeM+25s3lEgCDWMqdVWJmDKSsBY+hi9DgJwqjyLaNNY1NlgLzOOxeZZwqlyZ
         bqz4CbUpUp6seDG7P2zqkfOLgZomGydvPHZ0pyFV3zgVmRM7XQsxIGBSqOhR9of0yjWl
         fFbz92faHna8h2K+uswdVBB+vZOwfzqGCgzHhMJwm87D1Sfqmf/5PhUP/ViL2KWJnzZV
         dKR/8cgYierfNZ6PXTxJ8WBpQUwFh7IDfL8C5mzhzEKSNPVV6EBd8k87JdVOAQhYiOTT
         VfPJE4qDCpIH96cpNzxvvKFNGdoVbO/wQ/q40fl9/MByuaw7NbBbnFzfC7TkhR82EbBO
         1Bpg==
X-Gm-Message-State: ACrzQf2zQKH0NQ5H095v/Qi5bf/Ue4LU9CbKlXqT4HQecDPECxIWobJf
        mwotF7EKvwZaFxVUlk0HMXWcq97uYg==
X-Google-Smtp-Source: AMsMyM4hDBKrNCy/IKcknD8z6j4T3aIcEYZni5TT/Sd0AwEdQJZodfTyV2Z5vEFV6hYchEOk+ypASg==
X-Received: by 2002:a05:6808:1511:b0:354:28c8:d034 with SMTP id u17-20020a056808151100b0035428c8d034mr9038170oiw.208.1665406677472;
        Mon, 10 Oct 2022 05:57:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020a4a3702000000b004806f494d2fsm1260498oor.11.2022.10.10.05.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:57:56 -0700 (PDT)
Received: (nullmailer pid 475796 invoked by uid 1000);
        Mon, 10 Oct 2022 12:57:58 -0000
Date:   Mon, 10 Oct 2022 07:57:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795:
 Fix interrupt count
Message-ID: <20221010125758.GA468288-robh@kernel.org>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-6-y.oudjana@protonmail.com>
 <0769c6c8-567d-68c0-323a-9aaee1241e13@linaro.org>
 <6c889c7e-4c5a-a201-e37c-bf95b6826584@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c889c7e-4c5a-a201-e37c-bf95b6826584@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 01:47:18PM +0200, AngeloGioacchino Del Regno wrote:
> Il 10/10/22 13:13, Krzysztof Kozlowski ha scritto:
> > On 07/10/2022 08:58, Yassine Oudjana wrote:
> > > From: Yassine Oudjana <y.oudjana@protonmail.com>
> > > 
> > > The document currently states a maximum of 1 interrupt, but the DT
> > > has 2 specified causing a dtbs_check error. Replace the maximum limit
> > > with a minimum and add per-interrupt descriptions to pass the check.
> > > 
> > > Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> > > ---
> > >   .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> > > index 73ae6e11410b..a3a3f7fb9605 100644
> > > --- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> > > +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> > > @@ -47,7 +47,10 @@ properties:
> > >     interrupts:
> > >       description: The interrupt outputs to sysirq.
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    items:
> > > +      - description: EINT interrupt
> > > +      - description: EINT event_b interrupt
> > 
> > Is second interrupt really optional or you just wanted to silence the
> > warning?
> > 
> 
> The event_b interrupt exists (and fires on certain events, if configured to do so),
> but it's currently unused.
> 
> It's really optional.

Optional for DT means may or may not be wired up in the h/w, not what 
some OS 'currently' uses.

However, you can't really add new required properties or entries to an 
existing DT without breaking compatibility. Maybe that is not yet a 
concern.

Rob
