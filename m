Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE7A6D67AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjDDPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjDDPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:40:35 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464F5259;
        Tue,  4 Apr 2023 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1680622817; bh=gUC07j0BF6Ats3pO8KtZR2khuJGxBN6yLNKDq0ZvG30=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=INqbPpsh/s/pyXwwSr3hAKvrhnRGaA9cMvlZ93RrKGcfJFPGWN20zK6g1VSjZpqex
         4FXM4fWK4Amlp3oeQBN9XLKYT+xwH4j7d7+TvRFW8l2TCfytSWp6vpnm3J8ypwmRIX
         kwF8qWypcZFyJJkX9LdNAihL+BOQnlcQoZDNZaBI=
Date:   Tue, 4 Apr 2023 17:40:17 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
Message-ID: <20230404154017.7n6rcgqyv3edfahd@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
 <20230404123646.5iiznbhnyoama5pp@core>
 <87r0szd9q2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0szd9q2.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 04:04:53PM +0200, Javier Martinez Canillas wrote:
> Ondřej Jirman <megi@xff.cz> writes:
> 
> > On Tue, Apr 04, 2023 at 09:51:11AM +0200, Heiko Stübner wrote:
> >> Hi,
> >> 
> >> Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
> >> > This baud rate is set for the device by mainline u-boot and is also what
> >> > is set in the Pinebook Pro Device Tree, which is a device similar to the
> >> > PinePhone Pro but with a different form factor.
> >> > 
> >> > Otherwise, the baud rate of the firmware and Linux don't match by default
> >> > and a 'console=ttyS2,1500000n8' kernel command line parameter is required
> >> > to have proper output for both.
> >> 
> >> The interesting question is always if this will break someone else's setup.
> >> I've never really understood the strange setting of 1.5MBps, but on the
> >> other hand it _is_ a reality on most boards.
> >
> > Normal users of the phone probably run with UART console disabled, because
> > UART is muxed with audio jack output and to enable it they have to add
> > console=ttyS2 to the kernel command line and flip a physical switch inside
> > the phone.
> >
> > Fortunately, not sepcifying stdout-path baud rate in the options part
> > of the string, will make the serial driver probe for the baud rate from
> > the previous boot stage and make the user happy by keeping whatever was
> > already set in the bootloader.
> >
> 
> As mentioned in the first email of this thread, I tried that but it didn't
> work for me. Either using stdout-path = "serial2"; or stdout-path = &uart2;
> gives me no serial output with console=ttyS2, I needed to specify the baud
> rate explicitly (i.e: console=ttyS2,1500000n8).
> 
> >   https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_port.c#L3496
> >
> 
> Is that helper really used by the serial driver in the PinePhone Pro?
> (drivers/tty/serial/8250/8250_dw.c), I was meaning to dig why just ttyS2
> was not working but decided that could be a follow-up patch.

It's called by univ8250_console_setup in 8250_core.c But looking at it again,
this may only be used to match console=uart.

  https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_core.c#L638

Bummer.

> Since chaging to 1.5 MBps seemed to have merits on its own, decided to
> post this patch anyways in the meantime.
> 
> > So we can make the kernel just keep the baudrate setup from the previous
> > boot stage by:
> >
> > 	stdout-path = "serial2";
> >
> 
> Did it work for you? Maybe I'm doing something silly but as mentioned it
> didn't work for me with upstream u-boot.

I was just eyeballing the code. I didn't test it.

kind regards,
	o.

> > regards,
> > 	o.
> >
> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 
