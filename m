Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1B7214B3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFDEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDEwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:52:47 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25441D3;
        Sat,  3 Jun 2023 21:52:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B9BF65C008F;
        Sun,  4 Jun 2023 00:52:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 04 Jun 2023 00:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685854362; x=1685940762; bh=bSF3knhsyo6x+HkZM6LU5ZPXdrNyfSbm99C
        LadPv7iU=; b=GjmkCnxGh0KYf9d6pxxVJBLRvxOOkJlfNBO1gm9aO3oyXo6C+xL
        Bc2J+P3f6kV1D/cbPJax4HmuRnaJ/UzmFapkLKFNIXarmoi21c6R0cpfl1VLcl2e
        t4neW2h9L+KOuHnqi8De9B2D4QUWNdoK/LQwHtm9q6sk1FELmq+JGWaJaO27q6U7
        PvHeyBwvGyjnuXogb5qLmOo5OXsZM08XOE0cPFqkVIcvYvH5LbL/oErtyNmWIXaD
        uYMRoXv8PYMTktJAGPk7ETW6XEV6oMULSwf67ekiQP3oK6Y6XPSRXjZAo28MuV44
        LSZIS/A08nc3ar7RWFZj+Ttc71sbB0RXg4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685854362; x=1685940762; bh=bSF3knhsyo6x+HkZM6LU5ZPXdrNyfSbm99C
        LadPv7iU=; b=oafric0s2fRhMuzz4af83sQNsFUZIyD+Rl5VZ3LLGAiNTHAZH7D
        ucJbEZni6FG8OjuvUCIX4EIIR77F6G2ICMbNH+ot6lJ6fLpLdh5K7MzQF7aE5pn9
        QxfN77XuZXZRY0fJOEpUqL/C8U9eenjttVNCuJnvhR+zerGUHJm0d/0ivva5rie/
        gvVXU/1cwyCgaqEbPzEVgVUMqz5GsI1aKiRqmkG2Z2LM8llDvYq7muOT0gRDNbnR
        KbHzk60WEg3Y/TiZUv/2lPCbV196njY/gPfgtMAOtvFUtR0B/hEyotLrH6WodOdo
        +gZR5ii1dr92HkXhG2txYOKd1/lWR5ktpVA==
X-ME-Sender: <xms:mhh8ZJrXGf6dTv8bsz_jySe2pKr5tH9-tWK6CSLdIdiFso8opI0BGA>
    <xme:mhh8ZLpEo_4u9JtkGHqvjUC_Qiv_cgBABBHBsprkptTHmId9GMcyPTO-VDU-ztRxB
    8H0GgiG1hpLbFdf7D8>
X-ME-Received: <xmr:mhh8ZGO3G7raKKtq-IADgp5gP_BAO9sxbRW5T-5BbGLzOtlBLU6Qf3CC_hljW_xYlIjVyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeetgeetfeehhfetgeeljeduffffgffhkeelieejuefgffetiedufedvteetueeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:mhh8ZE5zt1I5qHOta0ULSpc1O6-EHbfke3MZnLFPW_K6eWw2IfOi5Q>
    <xmx:mhh8ZI7w3zVn8zDRCwp9ArPmglJ3ZbWDlubl1d4QrNIVciFYDFqFJQ>
    <xmx:mhh8ZMicR4prRq4iczf4JiTxxsHvggYrRJ6PchvXNWUHg7MPk5Zw9g>
    <xmx:mhh8ZHZxr8TtM8sw_BOmGQlirmlwP0JV2uh2DyY4fKBLwamuNwDIqQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 00:52:37 -0400 (EDT)
Message-ID: <06314c8dc4adeb69cd7801f9621c831f75a37c89.camel@ljones.dev>
Subject: Re: [PATCH v2 0/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
From:   Luke Jones <luke@ljones.dev>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Date:   Sun, 04 Jun 2023 16:52:28 +1200
In-Reply-To: <ade1f0d1-0a6b-7eed-cc79-139e0036e562@redhat.com>
References: <20230505043013.2622603-1-luke@ljones.dev>
         <4be2cc57-59b9-24e2-fd10-f2af175ff518@redhat.com>
         <02f28fe4-bca4-f9d7-a9be-0f1999662d62@redhat.com>
         <FD1QUR.SO09CWU6HM4Q1@ljones.dev>
         <ade1f0d1-0a6b-7eed-cc79-139e0036e562@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-25 at 13:09 +0200, Hans de Goede wrote:
> Hi Luke,
>=20
> On 5/16/23 00:34, Luke Jones wrote:
> > On Mon, May 15 2023 at 14:39:10 +0200, Hans de Goede
> > <hdegoede@redhat.com> wrote:
>=20
> <snip>
>=20
> > > > =C2=A0Thank you on your work for this.
> > > >=20
> > > > =C2=A0Unfortunately I did not get a chance to react to the v1
> > > > posting and
> > > > =C2=A0the remarks to switch to using /sys/class/backlight there
> > > > before you
> > > > =C2=A0posted this v2.
> > > >=20
> > > > =C2=A0Technically the remark to use /sys/class/backlight for this i=
s
> > > > =C2=A0completely correct. But due to the way how userspace uses
> > > > =C2=A0/sys/class/backlight this is a problematic.
> > > >=20
> > > > =C2=A0Userspace basically always assumes there is only 1 LCD panel
> > > > =C2=A0and it then looks at /sys/class/backlight and picks 1
> > > > =C2=A0/sys/class/backlight entry and uses that for the brightness
> > > > =C2=A0slider in the desktop-environment UI / system-menu as well
> > > > =C2=A0as to handle brightness up/down keyboard hotkey presses.
> > > >=20
> >=20
> > IMO, desktops need to adjust this expectation and start offering
> > controls for all possible screens. This would open up the
> > possibility of setting brightness of modern external screens also.
> > And then they should use the "Primary display" brightness controls,
> > or at least offer an option to set which is controlled.
>=20
> Right this is what the proposal at:
>=20
> https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@re=
dhat.com/
>=20
> is about. ATM userspace cannot reliably determine which
> /sys/class/backlight device belongs to which screen /
> video-output . So before desktops can offer this functionality
> we first need to fix the kernel <-> userspace APIs for this.
>=20
> <snip>
>=20
> > > > =C2=A0So now we end up with 2 "raw" type backlight devices and if
> > > > =C2=A0e.g. gnome-settings-daemon picks the right one now sort of
> > > > =C2=A0is left to luck.
> > > >=20
> >=20
> > In a test KDE at least picked the right one.
>=20
> That is good to know I'm still not entirely convinced using
> /sys/class/backlight for this is a good idea though.=20
>=20
> See below.
>=20
> > > > =C2=A0Well that is not entirely true, at least gnome-settings-daemo=
n
> > > > =C2=A0prefers raw backlight devices where the parent has an
> > > > "enabled"
> > > > =C2=A0sysfs attribute (it expects the parent to be a drm_connector
> > > > =C2=A0object) and where that enabled attribute reads as "enabled".
> > > >=20
> >=20
> > Ah I see. Parent for screenpad is "platform", while the main is on
> > igpu with parent "pci". I will paste some udev info at the end of
> > this reply.
>=20
> Actually for the backlight-device on the iGPU the parent
> should be a drm-connector for the eDP (and the parent of
> that is the iGPU PCI device). Note I did not check
> the udev dump.
>=20
> <snip>
>=20
> > > > =C2=A0Luke, question how does the second/exta panel look
> > > > =C2=A0from an outputting video to it pov ?=C2=A0 Does it show
> > > > =C2=A0up as an extra screen connected to a drm_connector
> > > > =C2=A0on one of the GPUs. IOW can it be used with standard
> > > > =C2=A0kernel-modesetting APIs ?
> > >=20
> >=20
> > Hi Hans, sorry about delay in response, just been tied up with
> > work.
> >=20
> > As I don't actually have this kind of laptop I can't easily get
> > info, but I can ask a few people in my discord for information. Is
> > there anything in particular you would need to know? From my basic
> > understanding some of the points are:
> >=20
> > 1. It does show as an actual additional screen
> > 2. Internal wiring is unclear, when dispaly MUX is switched to dgpu
> > the screen is still detected but not drawn to
> > 3. Point 2 is actually more uncertain as it seems only wayland had
> > this issue? I will get more info.
>=20
> Right, so I think we first need to better understand the interactions
> between the WMI calls you are making and the drm/kms interface.
>=20
> Question 1:
>=20
> If you turn the second screen off through WMI, does it get seen as
> disconnected by the drm/kms driver then. Or does the drm/kms driver
> just go on treating it as an extra connected display, still drawing
> now no longer visible content to it ?

It is most certainly viewed as disconnected.

> IOW does the desktop environment's monitor-config panel no longer
> show the extra display after disabling it through WMI?

That is correct, it is no-longer a connected and visible display

>=20
> The best way to check this is look under /sys/class/drm and find out
> which /sys/class/drm/card#-<conn-type>-# entry belongs to the extra
> panel. Step 1 check for all card#-<conn-type>-# entries
> where status returns connected, e.g. :
>=20
> [hans@shalem ~]$ cat /sys/class/drm/card1-DP-1/status=20
> connected
>=20

On disable the status does change to:
cat /sys/class/drm/card1-DP-5/enabled
disabled

> Step 2: for the connected ones cat the modes, e.g.:
>=20
> [hans@shalem ~]$ cat /sys/class/drm/card1-DP-1/modes
> 1920x1080
> 1600x1200
> ...
>=20
> And find the one which matches with the resolution of the extra panel
> (the one which does not match with the resolution of the main panel).
>=20
> Then turn the extra panel of through WMI and cat the status attribute
> again. If that still reads connected then that means the desktop
> environment keeps seeing an extra display output which is not ideal.
> This will e.g. cause any windows which were on the extra panel to
> stay there, even though they are no longer visible.
>=20
>=20
> Question 2:
>=20
> If you turn the second screen off through drm/kms, using the desktop
> environments monitor config panel does this also turn off the
> backlight ?

The screen is dark but there is still some backlight coming out of it.
I think this means I need to add a small pre-off to the patch to ensure
backlight is fully off when display is turned off.

>=20
> After disabling the screen in the desktop environments monitor config
> check that the enabled attribute, e.g. cat /sys/class/drm/card1-DP-
> 1/enabled shows disabled and after verifying this look at the extra
> screen in a dark room, do you see any backlight bleed indicating the
> backlight is still=C2=A0 on?
>=20

Shows as disabled

>=20
> We really want the backlight on/off state and the drm-connector
> enabled state to match. My proposal from above will allow this once
> implemented. Until we can hook this all up nicely I think it might be
> better to just go with the custom sysfs attributes from your v1 patch
> rather then adding a /sys/class/backlight device for this.
>=20

I would like to go with the backlight patch as it seems more likely I
can adjust this without breaking userspace if required in future. The
WMI controls behave as expected to.

>=20
> > So I think now is probably a good time to raise a particular issue
> > I've encountered with the last two years: the display MUX.
> >=20
> > As I understand it now, there are two types of new MUX - the manual
> > switch, and the newer "Advanced Optimus" automatic switch. The
> > issues I have are with the manual switch since I've not encountered
> > the advanced optimus yet.
> >=20
> > When the switch is. uh. switched. the dgpu drives the internal
> > display, and I expect that since the display is now detected
> > through the dgpu, this is why the dgpu is kept awake to drive it.
> > But, the igpu is also still active, and because of this the initial
> > boot from grub to display-manager is a black screen including tty.
> > This means anyone with an encrypted drive will never see the prompt
> > and they believe they have a failed boot. I don't know what to do
> > about this?
>=20
> Is this with EFI booting or with classic BIOS boot? With EFI booting
> the EFIFB should be put on the right GPU by the firmware. So I
> suspect this is with classic BIOS boot?

No this is with EFI boot always. I'm not even sure these machines still
have the ability to boot oldschool bios style.

>=20
> I think the best thing to do here is to just use EFI on machines like
> this. That or put grub in text mode so that it makes BIOS calls to
> display text. Using GRUB_TERMINAL_OUTPUT=3Dgfxterm combined with
> classic BIOS booting will make grub try to directly drive the gfx
> card itself and I'm not surprised that it gets that wrong in this
> case.
> Note I think that just using EFI is prefered over switching grub to
> GRUB_TERMINAL_OUTPUT=3Dconsole. I would expect
> GRUB_TERMINAL_OUTPUT=3Dconsole to also work but I'm not sure. I don't
> think that the classic BIOS boot stuff is still tested by laptop
> vendors and esp. not tested with non standard BIOS settings ...

The grub gfx mode is GRUB_TERMINAL_OUTPUT=3D"console", fedora default in
all cases here. Grub itself shows fine when the MUX mode is in dgpu
mode (aka, internal display connected to dgpu).

> > What I would love is somehow to either disable the igpu in kernel
> > if the MUX is toggled, or to change which device is the primary. Do
> > you have any thoughts on where I should start on this?
>=20
> Not really, on the hybrid gfx devices which I have when optimus is
> disabled in the BIOS, muxing the main LCD to the Nvidia GPU the iGPU
> gets disabled by the BIOS.
>=20
> If the iGPU in these models does not get disabled then I guess it is
> still needed for some connectors, e.g. maybe for displays connected
> to one of the thunderbolt ports ?

Yeah seems likely. I'll have to actually check this (I have TB4
connected monitor).

> Or maybe it is left on now a days for things like Intel quicksync ?
>=20
> > An additional problem: `boot_vga` property of display adaptors.
> > I've been using this as a first-stage check in supergfxctl to
> > determine if there was a switch, but it is never ever reliable -
> > sometimes it changes, sometimes it is entirely blank (using udev to
> > fetch properties). And then I need to use a combination of checks
> > to determine state. So this `boot_vga` seems to always be available
> > but is practically unusable.
>=20
> I'm afraid I cannot really help here. I think most of these laptops
> ship in Optimus mode (so both GPUs enabled) by default. And the non
> optimus mode is likely only tested under certain circumstances so
> there are going to be firmware bugs here. And Linux' code for
> detecting this likely also has issues of its own. Combine the 2 and
> you get lots of "fun".
>=20
> I guess this is also what trips up grub. I wonder if this is better /
> more reliable under EFI mode though? Esp. since that is what vendors
> actually QA/test.

As mentioned, the machines are all booting in EFI mode right from the
start - the old mode (CMA?) doesn't seem to exist at all.

I really would like to find a solution here as it is tripping up a lot
of new users.

Cheers,
Luke.

P.S> I will go ahead with the screen patch as it looks like this
behaves as expected minus the need to turn off BL before turn off
display. I will submit revision later in the week.

