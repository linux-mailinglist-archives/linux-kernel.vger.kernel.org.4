Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999656376B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKXKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKXKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:44:20 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0414F53E;
        Thu, 24 Nov 2022 02:44:17 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9B82F40007;
        Thu, 24 Nov 2022 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669286655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAWWyykXty0Wgx9OT7J3calSn4zWgrBkGn5htWWJalM=;
        b=MPydypr+YKO3XXsQo24DBMftQFnAHS97cjzCuA7S8jN/iDEW4NYTvIuNC935gMS8Rb+R9p
        lWvcHj/u6cvuv3hqx9YTGibvYwL0TtmzKBQYhO9duwRZ7pC7PYr1TBaCIRZTICtJJNRB7B
        mRcqZzYPk+t6P2NeymoJpNhUpD4tAClEbg65eo83CARRhoeuN3+0zeWhwvso8j1zfHBcot
        M7VL/sIdRKCaC4MIKNXRlse3IK2LVq8TV6GbihNElfwu1PrqgjJ5SdHWV1JY8hG1HCT/ac
        uF37rydM7zILlyg1QEvFnMDqVwRozIbJ9wC+y5er0dzDk7cxK4ye+BpoRMLPKg==
Date:   Thu, 24 Nov 2022 11:44:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 Add h2mode property
Message-ID: <20221124114412.49d89b5b@xps-13>
In-Reply-To: <20221124112757.13f200c4@xps-13>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
        <20221115150417.513955a7@bootlin.com>
        <20221118112349.7f09eefb@bootlin.com>
        <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
        <20221121165921.559d6538@bootlin.com>
        <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
        <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
        <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org>
        <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
        <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
        <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
        <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org>
        <20221122100706.739cec4d@bootlin.com>
        <3856e2d8-1c16-a69f-4ac5-34b8e7f18c2b@linaro.org>
        <CAMuHMdXPndkt=+k1CAcDbH7eK=TFfS6wMu+xdqWZSCz1+hyhEA@mail.gmail.com>
        <02db6a5d-ae9d-68b5-f5c5-bebb471e0f70@linaro.org>
        <20221124103633.4fbf483f@xps-13>
        <d203a6ce-7032-a423-5158-fa551922dea1@linaro.org>
        <20221124112757.13f200c4@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

miquel.raynal@bootlin.com wrote on Thu, 24 Nov 2022 11:27:57 +0100:

> Hi Krzysztof,
>=20
> krzysztof.kozlowski@linaro.org wrote on Thu, 24 Nov 2022 10:46:14 +0100:
>=20
> > On 24/11/2022 10:36, Miquel Raynal wrote:
> > > Hi Krzysztof,
> > >=20
> > > krzysztof.kozlowski@linaro.org wrote on Wed, 23 Nov 2022 10:39:41 +01=
00:
> > >  =20
> > >> On 22/11/2022 11:47, Geert Uytterhoeven wrote: =20
> > >>> Hi Krzysztof,
> > >>>
> > >>> On Tue, Nov 22, 2022 at 11:30 AM Krzysztof Kozlowski
> > >>> <krzysztof.kozlowski@linaro.org> wrote:   =20
> > >>>> On 22/11/2022 10:07, Herve Codina wrote:   =20
> > >>>>> On Tue, 22 Nov 2022 09:42:48 +0100
> > >>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > >>>>>   =20
> > >>>>>> On 22/11/2022 09:25, Geert Uytterhoeven wrote:   =20
> > >>>>>>> Hi Krzysztof,
> > >>>>>>>
> > >>>>>>> On Tue, Nov 22, 2022 at 8:45 AM Krzysztof Kozlowski
> > >>>>>>> <krzysztof.kozlowski@linaro.org> wrote:   =20
> > >>>>>>>> On 21/11/2022 21:46, Geert Uytterhoeven wrote:   =20
> > >>>>>>>>>> This does not change anything. Herve wrote:
> > >>>>>>>>>>   =20
> > >>>>>>>>>>> probe some devices (USB host and probably others)   =20
> > >>>>>>>>>>
> > >>>>>>>>>> Why some can be probed earlier and some not, if there are no
> > >>>>>>>>>> dependencies? If there are dependencies, it's the same case =
with sysctrl
> > >>>>>>>>>> touching the register bit and the USB controller touching it=
 (as well
> > >>>>>>>>>> via syscon, but that's obvious, I assume).
> > >>>>>>>>>>
> > >>>>>>>>>> Where is the synchronization problem?   =20
> > >>>>>>>>>
> > >>>>>>>>> The h2mode bit (and probably a few other controls we haven't =
figured out
> > >>>>>>>>> yet) in the sysctrl must be set before any of the USB devices=
 is active.
> > >>>>>>>>> Hence it's safest for the sysctrl to do this before any of th=
e USB drivers
> > >>>>>>>>> probes.   =20
> > >>>>>>>>
> > >>>>>>>> Again, this does not differ from many, many of other devices. =
All of
> > >>>>>>>> them must set something in system controller block, before the=
y start
> > >>>>>>>> operating (or at specific time). It's exactly the same everywh=
ere.   =20
> > >>>>>>>
> > >>>>>>> The issue here is that there are two _different drivers_ (USB h=
ost
> > >>>>>>> and device). When both are modular, and the driver that depends=
 on the
> > >>>>>>> sysctrl setting is loaded second, you have a problem: the sysct=
rl change
> > >>>>>>> must not be done when the first driver is already using the har=
dware.
> > >>>>>>>
> > >>>>>>> Hence the sysctrl driver should take care of it itself during e=
arly
> > >>>>>>> initialization (it's the main clock controller, so it's a depen=
dency
> > >>>>>>> for all other I/O device drivers).   =20
> > >>>>>>
> > >>>>>> I assumed you have there bit for the first device (which can swi=
tch
> > >>>>>> between USB host and USB device) to choose appropriate mode. The
> > >>>>>> bindings also expressed this - "the USBs are". Never said anythi=
ng about
> > >>>>>> dependency between these USBs.
> > >>>>>>
> > >>>>>> Are you saying that the mode for first device cannot be changed =
once the
> > >>>>>> second device (which is only host) is started? IOW, the mode set=
up must
> > >>>>>> happen before any of these devices are started?
> > >>>>>>
> > >>>>>> Anyway with sysctrl approach you will have dependency and you ca=
nnot
> > >>>>>> rely on clock provider-consumer relationship to order that depen=
dency.
> > >>>>>> What if you make all clocks on and do not take any clocks in USB=
 device?
> > >>>>>> Broken dependency. What if you want to use this in a different S=
oC,
> > >>>>>> where the sysctrl does not provide clocks? Broken dependency.   =
=20
> > >>>>>
> > >>>>> The issue is really related to the Renesas sysctrl itself and not=
 related
> > >>>>> to the USB drivers themselves.
> > >>>>> From the drivers themselves, the issue is not seen (I mean the dr=
iver
> > >>>>> takes no specific action related to this issue).
> > >>>>> If we change the SOC, the issue will probably not exist anymore. =
  =20
> > >>>>
> > >>>> Yeah, and in the next SoC you will bring 10 of such properties to
> > >>>> sysctrl arguing that if one was approved, 10 is also fine. Somehow
> > >>>> people on the lists like to use that argument - I saw it somewhere=
, so I
> > >>>> am allowed to do here the same.   =20
> > >>>
> > >>> Like pin control properties? ;-)
> > >>> This property represents a wiring on the board...
> > >>> I.e. a system integration issue.
> > >>>    =20
> > >>>> I understand that the registers responsible for configuration are =
in
> > >>>> sysctrl block, but it does not mean that it should be described as=
 part
> > >>>> of sysctrl Devicetree node. If there was no synchronization proble=
m,
> > >>>> this would be regular example of register in syscon which is handl=
ed
> > >>>> (toggled) by the device (so USB device/host controller). Since the=
re is
> > >>>> synchronization problem, you argue that it is correct representati=
on of
> > >>>> hardware. No, it is not, because logically in DT you do not descri=
be
> > >>>> mode or existence of other devices in some other node and it still=
 does
> > >>>> not describe this ordering.   =20
> > >>>
> > >>> So we have to drop the property, and let the sysctrl block look
> > >>> for <name>@<reg> nodes, and check which ones are enabled?
> > >>>
> > >>> Running out of ideas...   =20
> > >=20
> > > I'm stepping in, hopefully I won't just be bikeshedding on something
> > > that has already been discussed but here is my grain of salt.
> > >  =20
> > >> One solution could be making USB nodes children of the sysctrl block=
 which:
> > >> 1. Gives proper ordering (children cannot start before parent)
> > >> regardless of any other shared resources,
> > >> 2. Allows to drop this mode property and instead check what type of
> > >> children you have and configure mode depending on them.
> > >>
> > >> However this also might not be correct representation of hardware
> > >> (dunno...), so I am also running out of ideas. =20
> > >=20
> > > I see what you mean here, but AFAICS that is clearly a wrong
> > > representation of the hardware. Sorting nodes by bus seems the aim of
> > > device tree because there is a physical relationship, that's why we
> > > have (i2c as an example):
> > >=20
> > > 	ahb {
> > > 		foo-controller@xxx {
> > > 			reg =3D <xxx>;
> > > 		};
> > > 	};
> > >=20
> > > But what you are describing now is conceptually closer to:
> > >=20
> > > 	clk-controller {
> > > 		foo-controller {
> > > 			reg =3D ?
> > > 		};
> > > 	}; =20
> >=20
> > Which is not a problem. reg can be anything - offset from sysctrl node
> > or absolute offset. We have it in many places already. What's the issue
> > here?
> >
> > > Not mentioning that this only works once, because foo-controller might
> > > also need other blocks to be ready before probing and those might
> > > be different blocks (they are the same in the rzn1 case, but
> > > more generally, they are not). =20
> >=20
> > But what is the problem of needing other blocks? All devices need
> > something and we solve it...
>=20
> What I am saying is that parenting only works once. All the other
> dependencies must be described by properties.
>=20
> The h2mode register, no matter its content, should be set early in the
> boot process, at least before any of the concerned controllers, which
> are totally independent hardware blocks, probe. If one of them has
> started, a change to the h2mode property could just stall the system.
> The USB controllers do not *need* this property nor want to change it
> (see below).
>=20
> The fact that the USB controllers are totally independent hardware
> blocks make me thing that they should *not* be children of the sysctrl.
> In our case one of them even is a PCI device! Would you represent a PCI
> device within the sysctrl node? The other is somehow memory mapped
> behind a bridge. Again, this has to be described somewhere, and
> parenting usually is the right fit for that.
>=20
> Hence, the only real thing that remains to be described, as you
> rightly pointed out in your earlier reviews, is the probe order which
> is nothing related to any kind of parenting in this case.
>=20
> > > So in the end I am not in favor of this
> > > solution.
> > >=20
> > > If we compare the dependency between the USB device controller and the
> > > sysctrl block which contains the h2mode register to existing
> > > dependencies, they are all treated with properties. These properties,
> > > eg:
> > >=20
> > > 	foo-controller {
> > > 		clocks =3D <&provider [index]>;
> > > 	};
> > >=20
> > > were initially used to just tell the consumer which resource it should
> > > grab/enable. If the device was not yet ready, we would rely on the
> > > probe deferral mechanism to try again later. Not optimal, but not
> > > bad either as it made things work. Since v5.11 and the addition of
> > > automatic device links, the probe order is explicitly ordered.
> > > <provider> could always get probed before <foo-controller>. So, isn't
> > > what we need here? What about the following:
> > >=20
> > > 	sysctrl {
> > > 		h2mode =3D "something";
> > > 	};
> > >=20
> > > 	usb-device {
> > > 		h2mode-provider =3D <&sysctrl>;
> > > 	}; =20
> >=20
> > No, because next time one will add 10 of such properties:
> > sysctrl {
> > 	h2mode =3D ""
> > 	g2mode =3D ""
> > 	i2mode =3D ""
> > 	....
> > }
> >=20
> > and keep arguing that because these registers are in sysctrl, so they
> > should have their own property in sysctrl mode.
> >=20
> > That's not correct representation of hardware.
>=20
> Actually my main focus here was more on the "sysctrl-provider" logic.
> We need a probe dependency so we have two choices:
> - pointing
> - parenting
> For the reasons above, I bet the former is the most accurate approach.
>=20
> If the h2mode property bothers you, it's fine, we can just drop it. The
> USB device controller can do without it:

I'm partially wrong here. I forgot that we somehow need to know whether
the second USB controller is host or device, and decide this before the
USB controllers probe. It is still possible to do it without the
property by looking up the tree against the USB controller
compatible or node name. We would do this in the sysctrl probe and set
the right mode depending on its presence.

I would definitely go for a property instead, but if this is a no-go, I
guess that's the last resort.

> - either it just probes without knowing the mode, its bus will remain
>   empty so the device is useless, but nothing will break.
> - or (this is my favorite) we add another sysctrl helper that exposes
>   the h2mode, very much like we've done with the dmamux [2] and we just
>   avoid probing if the mode that we receive does not ask for a USB
>   device controller. Speeds-up the boot process.
>=20
> [2] https://lore.kernel.org/all/20220427095653.91804-5-miquel.raynal@boot=
lin.com/
>=20
> Either ways, we would still need the probe order to be enforced,
> which might be achieved on Linux side with the below explanations.
>=20
> > > We can initially just make this work with some additional logic on bo=
th
> > > sides. The USB device controller would manually check whether sysctrl
> > > has been probed or not (in practice, because of the clocks and power
> > > domains being described this will always be a yes, but IIUC we want to
> > > avoid relying on it) and otherwise, defer its probe. On the sysctrl s=
ide
> > > it is just a matter of checking (like we already do):
> > >=20
> > > 	if (!sysctrl_priv)
> > > 		return -EPROBE_DEFER;
> > >=20
> > > To be honest I would love to see the device link mechanism extended to
> > > "custom" phandle properties like that, it would avoid the burden of
> > > checking for deferrals manually, aside with boot time improvements. If
> > > we go this way, we shall decide whether we want to:
> > > * extend the list of properties that will lead to a dependency creati=
on [1]
> > > * or maybe settle on a common suffix that could always be used,
> > >   especially for specific cases like this one where there is an
> > >   explicit provider-consumer dependency that must be fulfilled:
> > >=20
> > > 	DEFINE_SUFFIX_PROP(provider, "-provider", "#provider-cells")
> > >=20
> > > * or perhaps extend struct of_device_id to contain the name of the
> > >   properties pointing to phandles that describe probe dependencies wi=
th:
> > >=20
> > > 	char *provider_prop_name;
> > > 	char *provider_cells_prop_name;
> > >=20
> > >   and use them from of/property.c to generate the links when relevant.
> > >=20
> > > [1] https://elixir.bootlin.com/linux/v6.0/source/drivers/of/property.=
c#L1298
> > >=20
> > >=20
> > > Thanks,
> > > Miqu=C3=A8l =20
> >=20
> > Best regards,
> > Krzysztof
> >=20
>=20
> Thanks,
> Miqu=C3=A8l


Thanks,
Miqu=C3=A8l
