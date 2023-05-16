Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80B4705A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjEPWJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjEPWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:09:54 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A1C2696;
        Tue, 16 May 2023 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LnbBKJpfQ3I4gQ84zOmiBBremfoaAJsQslxmEhMP0fk=; b=j9wUm4Nb+Cj4O7khI9goKFiRv8
        b5O8jzEpFLFkUBK0au07ekHpTyX4VTIbE5QRGV97l0fzL0lZmFzgIP+qbyt+zQl4pcOqXcM4txlYp
        +5A7avbtwzJZ9zjKBuS6hvYp1aUuGLIt4Jd5i/HyvuSLMQuIDJq7RrGMt7HsLTRsnoVE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37790 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pz2rW-0004Vr-I0; Tue, 16 May 2023 18:09:43 -0400
Date:   Tue, 16 May 2023 18:09:42 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Lech Perczak <lech.perczak@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Tomasz =?UTF-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?UTF-8?Q?Drobi=C5=84ski?= 
        <krzysztof.drobinski@camlingroup.com>, hugo@hugovil.com
Message-Id: <20230516180942.46a51d85746e4246a9a4bba4@hugovil.com>
In-Reply-To: <20230516115906.9d93685696ae7dc02faff752@hugovil.com>
References: <20230515160206.2801991-1-hugo@hugovil.com>
        <2023051551-quickstep-outshine-5526@gregkh>
        <20230515125155.bf6d64c292ba96f4f6971ac0@hugovil.com>
        <a27271d5-6d28-d994-b06f-905eea0514aa@camlingroup.com>
        <20230516115906.9d93685696ae7dc02faff752@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [RFC PATCH] Revert
 "sc16is7xx: Separate GPIOs from modem control lines"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 11:59:06 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Tue, 16 May 2023 10:50:11 +0200
> Lech Perczak <lech.perczak@camlingroup.com> wrote:
>=20
> > Hi Hugo,
> >=20
> > Please see my answers inline.
> >=20
> > W dniu 15.05.2023 o=A018:51, Hugo Villeneuve pisze:
> > > Hi Greg,
> > >
> > > On Mon, 15 May 2023 18:20:02 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >
> > >> On Mon, May 15, 2023 at 12:02:07PM -0400, Hugo Villeneuve wrote:
> > >>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >>>
> > >>> This reverts commit 679875d1d8802669590ef4d69b0e7d13207ebd61.
> > >>>
> > >>> Because of this commit, it is no longer possible to use the 16 GPIO
> > >>> lines as dedicated GPIOs on the SC16IS752.
> > >>>
> > >>> Reverting it makes it work again.
> > >>>
> > >>> The log message of the original commit states:
> > >>>     "Export only the GPIOs that are not shared with hardware modem
> > >>>     control lines"
> > >>>
> > >>> But there is no explanation as to why this decision was taken to
> > >>> permanently set the function of the GPIO lines as modem control
> > >>> lines. AFAIK, there is no problem with using these lines as GPIO or=
 modem
> > >>> control lines.
> > >>>
> > >>> Maybe after reverting this commit, we could define a new
> > >>> device-tree property named, for example,
> > >>> "use-modem-control-lines", so that both options can be supported.
> > >>>
> > >>> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control
> > >>> lines")
> > >> Please do not line-wrap these lines.
> > > Ok.
> > >
> > >> Nor is a blank line needed here.
> > > Ok.
> > >
> > >>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >>> ---
> > >>>  drivers/tty/serial/sc16is7xx.c | 14 ++++----------
> > >>>  1 file changed, 4 insertions(+), 10 deletions(-)
> > >>>
> > >>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc=
16is7xx.c
> > >>> index 5bd98e4316f5..25f1b2f6ec51 100644
> > >>> --- a/drivers/tty/serial/sc16is7xx.c
> > >>> +++ b/drivers/tty/serial/sc16is7xx.c
> > >>> @@ -306,7 +306,6 @@ struct sc16is7xx_devtype {
> > >>>     char    name[10];
> > >>>     int     nr_gpio;
> > >>>     int     nr_uart;
> > >>> -   int     has_mctrl;
> > >>>  };
> > >>>
> > >>>  #define SC16IS7XX_RECONF_MD                (1 << 0)
> > >>> @@ -447,35 +446,30 @@ static const struct sc16is7xx_devtype sc16is7=
4x_devtype =3D {
> > >>>     .name           =3D "SC16IS74X",
> > >>>     .nr_gpio        =3D 0,
> > >>>     .nr_uart        =3D 1,
> > >>> -   .has_mctrl      =3D 0,
> > >>>  };
> > >>>
> > >>>  static const struct sc16is7xx_devtype sc16is750_devtype =3D {
> > >>>     .name           =3D "SC16IS750",
> > >>> -   .nr_gpio        =3D 4,
> > >>> +   .nr_gpio        =3D 8,
> > >> I think this one line change is all you really need here, right?  the
> > >> otner changes do nothing in this patch, so you should just create a =
new
> > >> one changing this value.  Oh, and this one:
> > >>
> > >>>     .nr_uart        =3D 1,
> > >>> -   .has_mctrl      =3D 1,
> > >>>  };
> > >>>
> > >>>  static const struct sc16is7xx_devtype sc16is752_devtype =3D {
> > >>>     .name           =3D "SC16IS752",
> > >>> -   .nr_gpio        =3D 0,
> > >>> +   .nr_gpio        =3D 8,
> > >> right?
> > >>
> > >> Don't mess with the has_mctrl stuff, that's not relevant here.
> > > Sorry, I just noticed that simply reverting commit 679875d1d880 is no=
t sufficient (and will not compile). We must also revert part of commit:
> > > 21144bab4f11 ("sc16is7xx: Handle modem status lines").
> > >
> > > The problem is that the commit 679875d1d880 was incomplete, and it wa=
s (unfortunately) completed by integrating it in commit 21144bab4f11 ("sc16=
is7xx: Handle modem status lines"). The relevant change was only these 5 ne=
w lines, burried deeply into the second commit:
> > Just as you noticed, this was required to support full set of flow cont=
rol lines on this device.
> > The commit you're trying to revert was a preparation for it. Disabling =
has_mctrl will break it.
> > I kindly suggest to suggest a fix, instead of hurrying a revert, and wa=
iting for a proper fix later.
>=20
> Hi Lech,
> the [RFC] in the subject was there to discuss about a possible revert, an=
d/or maybe a possible fix that would allow both modes to be supported. I am=
 not hurrying anything and I am certainly not waiting for a later fix, as I=
 very much want to help and maybe submit such a fix myself.
>=20
> But the reality is that commits 679875d1d880/21144bab4f11 broke userspace=
 by forcing GPIOs as modem control lines. I understand that reverting these=
 patches could also potentially break things for applications depending on =
these patches. I am simply wondering what is the proper course of action he=
re: revert patches and work on a fix to support both modes, or skip revert =
and work on a fix (my preference)?
>=20
> > > @@ -1353,9 +1452,17 @@ static int sc16is7xx_probe(struct device *dev,
> > >                 sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_RE=
G,
> > >                                      SC16IS7XX_EFCR_RXDISABLE_BIT |
> > >                                      SC16IS7XX_EFCR_TXDISABLE_BIT);
> > > +
> > > +               /* Use GPIO lines as modem status registers */
> > > +               if (devtype->has_mctrl)
> > > +                       sc16is7xx_port_write(&s->p[i].port,
> > > +                                            SC16IS7XX_IOCONTROL_REG,
> > > +                                            SC16IS7XX_IOCONTROL_MODE=
M_BIT);
> > > +
> > >
> > > Therefore, I should also remove these lines if we go forward with a r=
evert of the patch (should I add another tag "Fixes..." in that case?).
> > >
> > > And what do you think of my proposal to maybe replace has_mctrl with =
a device tree property so that both modes can be fully supported?
> > I think the proper solution here, is not to invent a new device tree pr=
operty for every single use case.
> > I would start by looking for other drivers, if, and how they handle sim=
ilar cases.
> > For example, imx-serial driver respects "uart-has-rtscts" property, as =
do a lot of other controllers built into SoC-s.
> > On the other hand, other devices which can also provide GPIOs, respect =
"gpio-controller" property.
>=20
> I think that testing the presence of the "uart-has-rtscts" to force GPIOs=
 as modem control lines would make a lot of sense.
>=20
> > According to SC16IS752 datasheet [1], respecting one of those should be=
 enough,
> > as GPIOs can be enabled in groups of four pins even for dual UART versi=
on.
> > Every group matches a single port, so probably this can be probably sel=
ected per UART even on dual-port versions.
>=20
> I am trying to see how we could set "uart-has-rtscts" for only UART chann=
el A or B in the device tree, but cannot find any example or documentation =
about that. How do you propose to do it?
>=20
> From what I understand, the property "uart-has-rtscts" can be set only fo=
r the whole chip (channels A and B)...

After some analysis, I don't think that we should be using the property "ua=
rt-has-rtscts". For our chip, this doesn't make sense because RTS/CTS are d=
edicated pins. also, like I said, this property applies to the whole chip/d=
evice, not to indivual A or B channels (like sc16is752).

The way to go would be to define a new DT property similar to "irda-mode-po=
rts" (for the same sc16is7xx driver). Defining a new property named "modem-=
control-line-ports" would allow us to specify an array that lists the indic=
es of the port that should have shared GPIO lines configured as modem contr=
ol lines.

I already implemented that as a proof of concept and it works great.

Hugo.


> > I'll be more than happy to assist with that.
> >=20
> > >
> > > Thank you,
> > > Hugo.
> > >
> > [1] https://www.nxp.com/docs/en/data-sheet/SC16IS752_SC16IS762.pdf
> >=20
> > --=20
> > Pozdrawiam/With kind regards,
> > Lech Perczak
> >=20
> > Sr. Software Engineer
> > Camlin Technologies Poland Limited Sp. z o.o.
> > Strzegomska 54,
> > 53-611 Wroclaw
> > Tel:     (+48) 71 75 000 16
> > Email:   lech.perczak@camlingroup.com
> > Website: http://www.camlingroup.com
> >=20
> >=20
>=20
>=20
> --=20
> Hugo Villeneuve
>=20


--=20
Hugo Villeneuve
