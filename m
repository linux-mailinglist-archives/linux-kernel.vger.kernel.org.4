Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437EE637552
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiKXJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKXJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:36:42 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F85B112C44;
        Thu, 24 Nov 2022 01:36:38 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0F858E0002;
        Thu, 24 Nov 2022 09:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669282597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rcc/VLJhnIPcUIXAJXpEyGU4cTxXoPW1YhsTj9pYau4=;
        b=AVTqUeh2UEHQERLiHe8AS3tBrXfBaDEzPEb5FRhYg8fw4AzD4smmEJ6Ox2TpW/ssCM2h93
        IX9qxu81xkXMeWnOyGjnrn+AE74qLYgnXr7aqjaqU/t5IB5G5V7k48T09eywo0XHJA5Jaf
        xk/HMu01I81JmatXPrjPriw0C82OPPGJzbZMFeeChHbeYAznKTV9JZLt7n/QQ1H8M/FPmn
        QMAvFgQHVgS2S4o0rTAHg32C2a8sSyfqUBURd4fVZWzXUjGTHItyOw+o7Fj3xrYu0WncmJ
        BEmCdLRY2uGLCOf2K0kBEWThASIAn1f65RkcZPjvMfvtemTMHJTS453k/JBiqA==
Date:   Thu, 24 Nov 2022 10:36:33 +0100
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
Message-ID: <20221124103633.4fbf483f@xps-13>
In-Reply-To: <02db6a5d-ae9d-68b5-f5c5-bebb471e0f70@linaro.org>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
        <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
        <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
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
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Wed, 23 Nov 2022 10:39:41 +0100:

> On 22/11/2022 11:47, Geert Uytterhoeven wrote:
> > Hi Krzysztof,
> >=20
> > On Tue, Nov 22, 2022 at 11:30 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote: =20
> >> On 22/11/2022 10:07, Herve Codina wrote: =20
> >>> On Tue, 22 Nov 2022 09:42:48 +0100
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>> =20
> >>>> On 22/11/2022 09:25, Geert Uytterhoeven wrote: =20
> >>>>> Hi Krzysztof,
> >>>>>
> >>>>> On Tue, Nov 22, 2022 at 8:45 AM Krzysztof Kozlowski
> >>>>> <krzysztof.kozlowski@linaro.org> wrote: =20
> >>>>>> On 21/11/2022 21:46, Geert Uytterhoeven wrote: =20
> >>>>>>>> This does not change anything. Herve wrote:
> >>>>>>>> =20
> >>>>>>>>> probe some devices (USB host and probably others) =20
> >>>>>>>>
> >>>>>>>> Why some can be probed earlier and some not, if there are no
> >>>>>>>> dependencies? If there are dependencies, it's the same case with=
 sysctrl
> >>>>>>>> touching the register bit and the USB controller touching it (as=
 well
> >>>>>>>> via syscon, but that's obvious, I assume).
> >>>>>>>>
> >>>>>>>> Where is the synchronization problem? =20
> >>>>>>>
> >>>>>>> The h2mode bit (and probably a few other controls we haven't figu=
red out
> >>>>>>> yet) in the sysctrl must be set before any of the USB devices is =
active.
> >>>>>>> Hence it's safest for the sysctrl to do this before any of the US=
B drivers
> >>>>>>> probes. =20
> >>>>>>
> >>>>>> Again, this does not differ from many, many of other devices. All =
of
> >>>>>> them must set something in system controller block, before they st=
art
> >>>>>> operating (or at specific time). It's exactly the same everywhere.=
 =20
> >>>>>
> >>>>> The issue here is that there are two _different drivers_ (USB host
> >>>>> and device). When both are modular, and the driver that depends on =
the
> >>>>> sysctrl setting is loaded second, you have a problem: the sysctrl c=
hange
> >>>>> must not be done when the first driver is already using the hardwar=
e.
> >>>>>
> >>>>> Hence the sysctrl driver should take care of it itself during early
> >>>>> initialization (it's the main clock controller, so it's a dependency
> >>>>> for all other I/O device drivers). =20
> >>>>
> >>>> I assumed you have there bit for the first device (which can switch
> >>>> between USB host and USB device) to choose appropriate mode. The
> >>>> bindings also expressed this - "the USBs are". Never said anything a=
bout
> >>>> dependency between these USBs.
> >>>>
> >>>> Are you saying that the mode for first device cannot be changed once=
 the
> >>>> second device (which is only host) is started? IOW, the mode setup m=
ust
> >>>> happen before any of these devices are started?
> >>>>
> >>>> Anyway with sysctrl approach you will have dependency and you cannot
> >>>> rely on clock provider-consumer relationship to order that dependenc=
y.
> >>>> What if you make all clocks on and do not take any clocks in USB dev=
ice?
> >>>> Broken dependency. What if you want to use this in a different SoC,
> >>>> where the sysctrl does not provide clocks? Broken dependency. =20
> >>>
> >>> The issue is really related to the Renesas sysctrl itself and not rel=
ated
> >>> to the USB drivers themselves.
> >>> From the drivers themselves, the issue is not seen (I mean the driver
> >>> takes no specific action related to this issue).
> >>> If we change the SOC, the issue will probably not exist anymore. =20
> >>
> >> Yeah, and in the next SoC you will bring 10 of such properties to
> >> sysctrl arguing that if one was approved, 10 is also fine. Somehow
> >> people on the lists like to use that argument - I saw it somewhere, so=
 I
> >> am allowed to do here the same. =20
> >=20
> > Like pin control properties? ;-)
> > This property represents a wiring on the board...
> > I.e. a system integration issue.
> >  =20
> >> I understand that the registers responsible for configuration are in
> >> sysctrl block, but it does not mean that it should be described as part
> >> of sysctrl Devicetree node. If there was no synchronization problem,
> >> this would be regular example of register in syscon which is handled
> >> (toggled) by the device (so USB device/host controller). Since there is
> >> synchronization problem, you argue that it is correct representation of
> >> hardware. No, it is not, because logically in DT you do not describe
> >> mode or existence of other devices in some other node and it still does
> >> not describe this ordering. =20
> >=20
> > So we have to drop the property, and let the sysctrl block look
> > for <name>@<reg> nodes, and check which ones are enabled?
> >=20
> > Running out of ideas... =20

I'm stepping in, hopefully I won't just be bikeshedding on something
that has already been discussed but here is my grain of salt.

> One solution could be making USB nodes children of the sysctrl block whic=
h:
> 1. Gives proper ordering (children cannot start before parent)
> regardless of any other shared resources,
> 2. Allows to drop this mode property and instead check what type of
> children you have and configure mode depending on them.
>=20
> However this also might not be correct representation of hardware
> (dunno...), so I am also running out of ideas.

I see what you mean here, but AFAICS that is clearly a wrong
representation of the hardware. Sorting nodes by bus seems the aim of
device tree because there is a physical relationship, that's why we
have (i2c as an example):

	ahb {
		foo-controller@xxx {
			reg =3D <xxx>;
		};
	};

But what you are describing now is conceptually closer to:

	clk-controller {
		foo-controller {
			reg =3D ?
		};
	};

Not mentioning that this only works once, because foo-controller might
also need other blocks to be ready before probing and those might
be different blocks (they are the same in the rzn1 case, but
more generally, they are not). So in the end I am not in favor of this
solution.

If we compare the dependency between the USB device controller and the
sysctrl block which contains the h2mode register to existing
dependencies, they are all treated with properties. These properties,
eg:

	foo-controller {
		clocks =3D <&provider [index]>;
	};

were initially used to just tell the consumer which resource it should
grab/enable. If the device was not yet ready, we would rely on the
probe deferral mechanism to try again later. Not optimal, but not
bad either as it made things work. Since v5.11 and the addition of
automatic device links, the probe order is explicitly ordered.
<provider> could always get probed before <foo-controller>. So, isn't
what we need here? What about the following:

	sysctrl {
		h2mode =3D "something";
	};

	usb-device {
		h2mode-provider =3D <&sysctrl>;
	};

We can initially just make this work with some additional logic on both
sides. The USB device controller would manually check whether sysctrl
has been probed or not (in practice, because of the clocks and power
domains being described this will always be a yes, but IIUC we want to
avoid relying on it) and otherwise, defer its probe. On the sysctrl side
it is just a matter of checking (like we already do):

	if (!sysctrl_priv)
		return -EPROBE_DEFER;

To be honest I would love to see the device link mechanism extended to
"custom" phandle properties like that, it would avoid the burden of
checking for deferrals manually, aside with boot time improvements. If
we go this way, we shall decide whether we want to:
* extend the list of properties that will lead to a dependency creation [1]
* or maybe settle on a common suffix that could always be used,
  especially for specific cases like this one where there is an
  explicit provider-consumer dependency that must be fulfilled:

	DEFINE_SUFFIX_PROP(provider, "-provider", "#provider-cells")

* or perhaps extend struct of_device_id to contain the name of the
  properties pointing to phandles that describe probe dependencies with:

	char *provider_prop_name;
	char *provider_cells_prop_name;

  and use them from of/property.c to generate the links when relevant.

[1] https://elixir.bootlin.com/linux/v6.0/source/drivers/of/property.c#L1298


Thanks,
Miqu=C3=A8l
