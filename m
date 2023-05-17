Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED7A706A50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjEQN6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjEQN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:58:44 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903B2D4D;
        Wed, 17 May 2023 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=snKbJx8WgUHGUFVQUZxzI8XTXmyzIqcZz/fXoLl5UPA=; b=JZwXHCI1zwIGZQMRJiGFGNGLYs
        mUJQxDMdY/a0RpQ83uSBvvoVAyCR+FQlXU3L8/3ghT5/hT82nLcCNlUbqEDcNg4FohVjA1dIGZcmO
        PwaY1CoV+8v6wkBaAV4q6LnNJiid13T/vjiNb4eu10zhliDgPu3Wy/zPyVc4EcoqkEO8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:36556 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pzHfk-0006ci-7J; Wed, 17 May 2023 09:58:34 -0400
Date:   Wed, 17 May 2023 09:58:31 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Lech Perczak <lech.perczak@camlingroup.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Tomasz =?UTF-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?UTF-8?Q?Drobi=C5=84ski?= 
        <krzysztof.drobinski@camlingroup.com>, hugo@hugovil.com
Message-Id: <20230517095831.5bde5dc2671e98c36631888a@hugovil.com>
In-Reply-To: <35a79a3d-1fc6-5f18-fc11-2cee3c1da148@camlingroup.com>
References: <20230515160206.2801991-1-hugo@hugovil.com>
        <2023051551-quickstep-outshine-5526@gregkh>
        <20230515125155.bf6d64c292ba96f4f6971ac0@hugovil.com>
        <a27271d5-6d28-d994-b06f-905eea0514aa@camlingroup.com>
        <20230516115906.9d93685696ae7dc02faff752@hugovil.com>
        <20230516180942.46a51d85746e4246a9a4bba4@hugovil.com>
        <35a79a3d-1fc6-5f18-fc11-2cee3c1da148@camlingroup.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

On Wed, 17 May 2023 11:18:57 +0200
Lech Perczak <lech.perczak@camlingroup.com> wrote:

>=20
> W dniu 17.05.2023 o=A000:09, Hugo Villeneuve pisze:
> > On Tue, 16 May 2023 11:59:06 -0400
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > > On Tue, 16 May 2023 10:50:11 +0200
> > > Lech Perczak <lech.perczak@camlingroup.com> wrote:
> > >
> > > > Hi Hugo,
> > > >
> > > > Please see my answers inline.
> > > >
> > > > W dniu 15.05.2023 o=A018:51, Hugo Villeneuve pisze:
> > > > > Hi Greg,
> > > > >
> > > > > On Mon, 15 May 2023 18:20:02 +0200
> > > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > >> On Mon, May 15, 2023 at 12:02:07PM -0400, Hugo Villeneuve wrote:
> > > > >>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > >>>
> > > > >>> This reverts commit 679875d1d8802669590ef4d69b0e7d13207ebd61.
> > > > >>>
> > > > >>> Because of this commit, it is no longer possible to use the 16 =
GPIO
> > > > >>> lines as dedicated GPIOs on the SC16IS752.
> > > > >>>
> > > > >>> Reverting it makes it work again.
> > > > >>>
> > > > >>> The log message of the original commit states:
> > > > >>> "Export only the GPIOs that are not shared with hardware modem
> > > > >>> control lines"
> > > > >>>
> > > > >>> But there is no explanation as to why this decision was taken to
> > > > >>> permanently set the function of the GPIO lines as modem control
> > > > >>> lines. AFAIK, there is no problem with using these lines as GPI=
O or modem
> > > > >>> control lines.
> > > > >>>
> > > > >>> Maybe after reverting this commit, we could define a new
> > > > >>> device-tree property named, for example,
> > > > >>> "use-modem-control-lines", so that both options can be supporte=
d.
> > > > >>>
> > > > >>> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem cont=
rol
> > > > >>> lines")
> > > > >> Please do not line-wrap these lines.
> > > > > Ok.
> > > > >
> > > > >> Nor is a blank line needed here.
> > > > > Ok.
> > > > >
> > > > >>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > >>> ---
> > > > >>> drivers/tty/serial/sc16is7xx.c | 14 ++++----------
> > > > >>> 1 file changed, 4 insertions(+), 10 deletions(-)
> > > > >>>
> > > > >>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/seria=
l/sc16is7xx.c
> > > > >>> index 5bd98e4316f5..25f1b2f6ec51 100644
> > > > >>> --- a/drivers/tty/serial/sc16is7xx.c
> > > > >>> +++ b/drivers/tty/serial/sc16is7xx.c
> > > > >>> @@ -306,7 +306,6 @@ struct sc16is7xx_devtype {
> > > > >>> char name[10];
> > > > >>> int nr_gpio;
> > > > >>> int nr_uart;
> > > > >>> - int has_mctrl;
> > > > >>> };
> > > > >>>
> > > > >>> #define SC16IS7XX_RECONF_MD (1 << 0)
> > > > >>> @@ -447,35 +446,30 @@ static const struct sc16is7xx_devtype sc1=
6is74x_devtype =3D {
> > > > >>> .name =3D "SC16IS74X",
> > > > >>> .nr_gpio =3D 0,
> > > > >>> .nr_uart =3D 1,
> > > > >>> - .has_mctrl =3D 0,
> > > > >>> };
> > > > >>>
> > > > >>> static const struct sc16is7xx_devtype sc16is750_devtype =3D {
> > > > >>> .name =3D "SC16IS750",
> > > > >>> - .nr_gpio =3D 4,
> > > > >>> + .nr_gpio =3D 8,
> > > > >> I think this one line change is all you really need here, right?=
 the
> > > > >> otner changes do nothing in this patch, so you should just creat=
e a new
> > > > >> one changing this value. Oh, and this one:
> > > > >>
> > > > >>> .nr_uart =3D 1,
> > > > >>> - .has_mctrl =3D 1,
> > > > >>> };
> > > > >>>
> > > > >>> static const struct sc16is7xx_devtype sc16is752_devtype =3D {
> > > > >>> .name =3D "SC16IS752",
> > > > >>> - .nr_gpio =3D 0,
> > > > >>> + .nr_gpio =3D 8,
> > > > >> right?
> > > > >>
> > > > >> Don't mess with the has_mctrl stuff, that's not relevant here.
> > > > > Sorry, I just noticed that simply reverting commit 679875d1d880 i=
s not sufficient (and will not compile). We must also revert part of commit:
> > > > > 21144bab4f11 ("sc16is7xx: Handle modem status lines").
> > > > >
> > > > > The problem is that the commit 679875d1d880 was incomplete, and i=
t was (unfortunately) completed by integrating it in commit 21144bab4f11 ("=
sc16is7xx: Handle modem status lines"). The relevant change was only these =
5 new lines, burried deeply into the second commit:
> > > > Just as you noticed, this was required to support full set of flow =
control lines on this device.
> > > > The commit you're trying to revert was a preparation for it. Disabl=
ing has_mctrl will break it.
> > > > I kindly suggest to suggest a fix, instead of hurrying a revert, an=
d waiting for a proper fix later.
> > >
> > > Hi Lech,
> > > the [RFC] in the subject was there to discuss about a possible revert=
, and/or maybe a possible fix that would allow both modes to be supported. =
I am not hurrying anything and I am certainly not waiting for a later fix, =
as I very much want to help and maybe submit such a fix myself.
> > >
> > > But the reality is that commits 679875d1d880/21144bab4f11 broke users=
pace by forcing GPIOs as modem control lines. I understand that reverting t=
hese patches could also potentially break things for applications depending=
 on these patches. I am simply wondering what is the proper course of actio=
n here: revert patches and work on a fix to support both modes, or skip rev=
ert and work on a fix (my preference)?
> > >
> > > > > @@ -1353,9 +1452,17 @@ static int sc16is7xx_probe(struct device *=
dev,
> > > > > sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
> > > > > SC16IS7XX_EFCR_RXDISABLE_BIT |
> > > > > SC16IS7XX_EFCR_TXDISABLE_BIT);
> > > > > +
> > > > > + /* Use GPIO lines as modem status registers */
> > > > > + if (devtype->has_mctrl)
> > > > > + sc16is7xx_port_write(&s->p[i].port,
> > > > > + SC16IS7XX_IOCONTROL_REG,
> > > > > + SC16IS7XX_IOCONTROL_MODEM_BIT);
> > > > > +
> > > > >
> > > > > Therefore, I should also remove these lines if we go forward with=
 a revert of the patch (should I add another tag "Fixes..." in that case?).
> > > > >
> > > > > And what do you think of my proposal to maybe replace has_mctrl w=
ith a device tree property so that both modes can be fully supported?
> > > > I think the proper solution here, is not to invent a new device tre=
e property for every single use case.
> > > > I would start by looking for other drivers, if, and how they handle=
 similar cases.
> > > > For example, imx-serial driver respects "uart-has-rtscts" property,=
 as do a lot of other controllers built into SoC-s.
> > > > On the other hand, other devices which can also provide GPIOs, resp=
ect "gpio-controller" property.
> > >
> > > I think that testing the presence of the "uart-has-rtscts" to force G=
PIOs as modem control lines would make a lot of sense.
> > >
> > > > According to SC16IS752 datasheet [1], respecting one of those shoul=
d be enough,
> > > > as GPIOs can be enabled in groups of four pins even for dual UART v=
ersion.
> > > > Every group matches a single port, so probably this can be probably=
 selected per UART even on dual-port versions.
> > >
> > > I am trying to see how we could set "uart-has-rtscts" for only UART c=
hannel A or B in the device tree, but cannot find any example or documentat=
ion about that. How do you propose to do it?
> > >
> > > From what I understand, the property "uart-has-rtscts" can be set onl=
y for the whole chip (channels A and B)...
> >
> > After some analysis, I don't think that we should be using the property=
 "uart-has-rtscts". For our chip, this doesn't make sense because RTS/CTS a=
re dedicated pins. also, like I said, this property applies to the whole ch=
ip/device, not to indivual A or B channels (like sc16is752).
>=20
> Hi Hugo,
>=20
> That's correct, my idea was to analyze what is available and pick the bes=
t one, if at all possible.
> "gpio-controller" could also be used - in theory - but it isn't a great c=
hoice either, because it doesn't allow us to specify, which pin groups shou=
ld be used as GPIOs.
> >
> > The way to go would be to define a new DT property similar to "irda-mod=
e-ports" (for the same sc16is7xx driver). Defining a new property named "mo=
dem-control-line-ports" would allow us to specify an array that lists the i=
ndices of the port that should have shared GPIO lines configured as modem c=
ontrol lines.
> >
> > I already implemented that as a proof of concept and it works great.
>=20
> There is nothing wrong per se in adding new device tree property, I'd jus=
t like to avoid jumping the gun in inventing one.
> After quickly reviewing documentation of available bindings I see that it=
's most likely unavoidable.
> The "modem-control-line-ports" proposal with a mask of ports sounds very =
reasonable - please share your PoC,
> it will be easier to discuss having a concrete example.
>=20
> The general approach I noticed in other places (for example, the WF8960 a=
udio codec) is setting a register value directly.
> This would allow us to control the IOLATCH bit in IOControl register, to =
make inputs register behave as interrupt flag register,
> but I think that if we ever need it, it would be cleaner to set it with a=
 separate boolean property - I'm in favor of modem-control-line-ports.

Hi Lech,
I think that control of the IOLATCH bit should be part of a separate discus=
sion (patch) if we want to change it. For the moment, I just want to restor=
e the GPIO function as it was before your patches.

> I think it would be a good idea to include DT and GPIO maintainers and ma=
iling lists as well.
> Especially the DT maintainers - they would like to see this property docu=
mented. They however, are not concerned with the code changes themselves.

Ok, I will submit my PoC soon.

Thank you, Hugo.

> BTW, the commit split between adding has_mctrl property and the rest of i=
mplementation warrants some explanation - this was based on my previous pat=
ches,
> which Tomasz reworked and submitted. The split was kept to split up the c=
hanges to minimal, logical chunks, and to maintain correct authorship of th=
e changes.
>=20
> With kind regards,
> Lech
> >
> > Hugo.
> >
> >
> > > > I'll be more than happy to assist with that.
> > > >
> > > > >
> > > > > Thank you,
> > > > > Hugo.
> > > > >
> > > > [1] https://www.nxp.com/docs/en/data-sheet/SC16IS752_SC16IS762.pdf =
<https://www.nxp.com/docs/en/data-sheet/SC16IS752_SC16IS762.pdf>
> > > >
> > > > --
> > > > Pozdrawiam/With kind regards,
> > > > Lech Perczak
> > > >
> > > > Sr. Software Engineer
> > > > Camlin Technologies Poland Limited Sp. z o.o.
> > > > Strzegomska 54,
> > > > 53-611 Wroclaw
> > > > Tel: (+48) 71 75 000 16
> > > > Email: lech.perczak@camlingroup.com
> > > > Website: http://www.camlingroup.com <http://www.camlingroup.com>
> > > >
> > > >
> > >
> > >
> > > --
> > > Hugo Villeneuve
> > >
> >
> >
> > --=20
> > Hugo Villeneuve
>=20
>=20
