Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2681719D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjFANPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFANPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:15:43 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7997;
        Thu,  1 Jun 2023 06:15:38 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c8e:0:640:3460:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 2174F5EB4F;
        Thu,  1 Jun 2023 16:15:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XFOhPv2DRiE0-etdAdjS2;
        Thu, 01 Jun 2023 16:15:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685625333;
        bh=jNLDHhaZuY6BnkmxGkDjaMPBq5Gi/3MfRJdAPIziHPQ=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=gDNlNZgBe3ohSxL4z3KqGvmqRwcD1uK+4tJROo7VXhs8NNNE5+JT5RxtkOk5B5eeu
         FI397brfQ0bjhy8b6vmNP2S+epn5pLOtFiVmgBgI47wYlYFtFl6vyoxcHoGan/ViqB
         /GR+q49G6Te+ob/6g6+PLIAFJ3lwQV/2+6dQrRSs=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Thu, 1 Jun 2023 16:15:32 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 17/43] dt-bindings: spi: Add Cirrus EP93xx
Message-ID: <20230601161532.1902d16b@redslave.neermore.group>
In-Reply-To: <b2fc1733-4841-42e9-8bf7-1534a5d1a1b4@sirena.org.uk>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230601053546.9574-18-nikita.shubin@maquefel.me>
        <d6bc264b-9c52-49c0-8012-b938da37337f@sirena.org.uk>
        <20230601154154.57ae1b93@redslave.neermore.group>
        <b2fc1733-4841-42e9-8bf7-1534a5d1a1b4@sirena.org.uk>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 13:55:03 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jun 01, 2023 at 03:41:54PM +0300, Nikita Shubin wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> > > On Thu, Jun 01, 2023 at 08:34:08AM +0300, Nikita Shubin wrote:  
> 
> > > > +  cirrus,ep9301-use-dma:
> > > > +    description: Flag indicating that the SPI should use dma
> > > > +    type: boolean    
> 
> > > My previous feedback on this property still applies.  
> 
> > > > +  cirrus,ep9301-use-dma:  
> 
> > The reason is that ep93xx DMA state is not quite device-tree ready
> > at this moment, and clients use it with the help of:  
> 
> > https://elixir.bootlin.com/linux/v6.4-rc4/source/include/linux/platform_data/dma-ep93xx.h
> >  
> 
> > I was hoping to slip by without changing much in ep93xx DMA driver,
> > so  
> 
> You're definign new ABI here, that's not a good thing to do for a
> temporary workaround.
> 
> > I can move "use-dma" to module parameters, if this is acceptable.  
> 
> That's less bad.  I guess you could also define the bindings for the
> DMA controller so that the properties are there then instead of
> properly using the DMA API in the clients just check to see if the
> DMA properties are present and then proceed accordingly?

This sounds like a way to go. Thank you, Mark!
