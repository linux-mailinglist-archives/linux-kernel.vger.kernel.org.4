Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF3719C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjFAMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAMmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:42:01 -0400
X-Greylist: delayed 25448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 05:41:59 PDT
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33351137;
        Thu,  1 Jun 2023 05:41:59 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1b89:0:640:6638:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 0057A5F14B;
        Thu,  1 Jun 2023 15:41:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tfNF5f2DdSw0-Fykeqnqt;
        Thu, 01 Jun 2023 15:41:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685623316;
        bh=CuJFo+ksv+TNzCWobFFC4YBQzZRXzXYhToyTXj1R3uI=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=X3GMM50E405IR1tZ8HFcM+PO4yMKaYlbasoy9HS8XSTw7FtJePX9yD43hYwu7Qfcp
         BCPRNfYHmU5cAURMl0+D3k4cj189jRi4dRuj6zaUkDwYU8Nwgxbjx4/bNbUbsMKBYj
         5O6Yj7wXKU2BO2c4WzUxXNcZlFGhOBh7tphCMyBM=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Thu, 1 Jun 2023 15:41:54 +0300
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
Message-ID: <20230601154154.57ae1b93@redslave.neermore.group>
In-Reply-To: <d6bc264b-9c52-49c0-8012-b938da37337f@sirena.org.uk>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230601053546.9574-18-nikita.shubin@maquefel.me>
        <d6bc264b-9c52-49c0-8012-b938da37337f@sirena.org.uk>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark!

On Thu, 1 Jun 2023 12:17:27 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jun 01, 2023 at 08:34:08AM +0300, Nikita Shubin wrote:
> 
> > +  cirrus,ep9301-use-dma:
> > +    description: Flag indicating that the SPI should use dma
> > +    type: boolean  
> 
> My previous feedback on this property still applies.
> 
> Please don't ignore review comments, people are generally making them
> for a reason and are likely to have the same concerns if issues remain
> unaddressed.  Having to repeat the same comments can get repetitive
> and make people question the value of time spent reviewing.  If you
> disagree with the review comments that's fine but you need to reply
> and discuss your concerns so that the reviewer can understand your
> decisions.

Sorry - that was totally unintentional, i was tinkering with spi and
got distracted on other part of this series (it's quite big for me,
first time tinkering with a series more than 5-6 patches).

> > +  cirrus,ep9301-use-dma:

The reason is that ep93xx DMA state is not quite device-tree ready at
this moment, and clients use it with the help of:

https://elixir.bootlin.com/linux/v6.4-rc4/source/include/linux/platform_data/dma-ep93xx.h

I was hoping to slip by without changing much in ep93xx DMA driver, so
i can deal with it later, especially seeing it's having some quirks
like:

https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/dma/ep93xx_dma.c#L471

And edb93xx and bk3 don't set use_dma with SPI for some reason.

I can move "use-dma" to module parameters, if this is acceptable.
