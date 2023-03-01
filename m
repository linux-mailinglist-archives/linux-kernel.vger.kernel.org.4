Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63F6A65BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCACog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCACoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:44:34 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AFD10255;
        Tue, 28 Feb 2023 18:44:34 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso6813283ota.1;
        Tue, 28 Feb 2023 18:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2mASzywLLLz3SL9h6D/hbMI9Q5P67uUV6RN/jUkz1w=;
        b=OR5zDjVCo2f7Mw833Y+AVPRqP4EgXXGFqkTIS2omfRi+ohz7cJG+2BE49DNocWzB60
         rw+a6Of7PEAS500edZaZ3AFGguEotHG8TE0LlrG+a50NDz+5aWrW8RJAEd8ZaF/2saqV
         tqXo0b56AeNUGPPqdZ66oAKYT+LmWICvXAjl7aMsG86dDLPjenfP8/xWjkER1McQ/scY
         VYdKS96kUTbNFrrneyzCJOVR3KKJiii3nZ4+I72A9GBIWqnIfkIg1myAGPt8GR2Zu4eb
         1UQjVAscNGuUsLgJ3C2stuXLmdy4laBmK7RPDZsEN7u/eWTMBpTcVQ5SzJDP12oBTSJh
         tH4g==
X-Gm-Message-State: AO0yUKW+0PMCwGz1GkK8uaJI3O7zpZ3O/ZjNqjJqT0mQxhr8mvIcv6/q
        3UURgDYajf6bufmXi6+0Uw==
X-Google-Smtp-Source: AK7set9UBWbgFA1YWvOE33zjSRJM6L7Ce9rJOQ8u6UdOLH1WrhEbJt1fAwKlmQilm3WSZq+MRsPCWg==
X-Received: by 2002:a9d:17d0:0:b0:690:ece7:62d2 with SMTP id j74-20020a9d17d0000000b00690ece762d2mr2898278otj.19.1677638673290;
        Tue, 28 Feb 2023 18:44:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c2-20020a9d75c2000000b0068bd6cf405dsm4451250otl.1.2023.02.28.18.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 18:44:32 -0800 (PST)
Received: (nullmailer pid 260581 invoked by uid 1000);
        Wed, 01 Mar 2023 02:44:31 -0000
Date:   Tue, 28 Feb 2023 20:44:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: Re: [RFC PATCH 07/16] dt-bindings: pinctrl: ralink: add new
 compatible strings
Message-ID: <20230301024431.GA251215-robh@kernel.org>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-8-arinc.unal@arinc9.com>
 <20230227173333.GA496999-robh@kernel.org>
 <d7aea90f-d077-3a41-996c-804c95d72e24@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7aea90f-d077-3a41-996c-804c95d72e24@arinc9.com>
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

On Tue, Feb 28, 2023 at 07:46:36PM +0300, Arınç ÜNAL wrote:
> On 27/02/2023 20:33, Rob Herring wrote:
> > On Wed, Feb 22, 2023 at 09:39:23PM +0300, arinc9.unal@gmail.com wrote:
> > > From: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > 
> > > Add the ralink,rt2880-pinmux compatible string. It had been removed from
> > > the driver which broke the ABI.
> > > 
> > > Add the mediatek compatible strings. Change the compatible string on the
> > > examples with the mediatek compatible strings.
> > > 
> > > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > ---
> > >   .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
> > >   .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++++--
> > >   .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++++--
> > >   .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++++--
> > >   .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++++--
> > >   5 files changed, 25 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> > > index 1e63ea34146a..531b5f616c3d 100644
> > > --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> > > +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> > > @@ -17,7 +17,10 @@ description:
> > >   properties:
> > >     compatible:
> > > -    const: ralink,mt7620-pinctrl
> > > +    enum:
> > > +      - mediatek,mt7620-pinctrl
> > > +      - ralink,mt7620-pinctrl
> > 
> > We don't update compatible strings based on acquistions nor marketing
> > whims. If you want to use 'mediatek' for new things, then fine.
> 
> Understood. Only the SoCs with rtXXXX were rebranded, the mtXXXX SoCs share
> the same architecture from Ralink, so they were incorrectly called Ralink
> SoCs.
> 
> I can remove the new strings from Ralink SoCs and add them only for MediaTek
> SoCs. Or you could make an exception for this one, regarding the situation.
> Whatever you think is best.

I'm not in a position to make an exception as I know little about this 
platform. Carrying both strings is a NAK. Either you (and everyone using 
these platforms) care about the ABI and are stuck with the "wrong" 
string. In the end, they are just unique identifiers. Or you don't care 
and break the ABI and rename everything. If you do that, do just that in 
your patches and make it crystal clear in the commit msg that is your 
intention and why that is okay.

Rob
