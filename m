Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496FF725013
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbjFFWpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjFFWpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:45:30 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5659E;
        Tue,  6 Jun 2023 15:45:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C11845C0160;
        Tue,  6 Jun 2023 18:45:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 18:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686091525; x=1686177925; bh=qT
        sN8/KZ+hN9RAJDnxfB3SZQWIHqrMFhBdUFAir94Tw=; b=miMofI46PbgaIrZEQ8
        YUGXmwXuTak8KWvsNI/wC8uMkkXTFwoJpJdpCc1pnmljcGVXje82ygNzL+P8j+0/
        t8FxcIZrrAt37cYg/mw5ZYRBREtMsPNhP05vsXKhREGHxdoFrDxpQJqSJtwdG/hV
        bKbfEs4365VH0/JQq+OIDY8yVM/ZAqcapLZrbGepnYjw1Gr32TkQTZiMgOSsDV8x
        VlVIc2bamEPJA96wZpwBomGGzi52r1lr5GOjLOpTUIU1mIXZt44jHxO+d4m8rF9k
        /pmkYBECloyM265SfCjfviU+MaQScUvu+uq7yOjbgE5pRZuWiv3gQYaQNnbs9rAz
        hikA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686091525; x=1686177925; bh=qTsN8/KZ+hN9R
        AJDnxfB3SZQWIHqrMFhBdUFAir94Tw=; b=k/XVMEUKlLAKq89cCRF9i/x3eT6Zc
        icvEJHvxEoeLzw7zexlz4GR++fYseCZEz0FGtl3GGaGgPYUYb32vWXnPLegs1r95
        VPeLf4zPpS1KBamKHE3h75AxZPEpbH6BWz1h/Qg01cI1cGSheLB6ol/DDxgiPWJx
        1LJsMSO9lLjAEabHvgSdtYGtq+OT3J531+1bcmQxz5izNa8qpRQzv0v8P3xLxcw0
        pzvkaFxCLGVLoe5VSHjdctPhgP254aF0Ankv/6aTJ8pz4Vz3G411Mf2ZXncpidU+
        GCANz72GE+kVtnSIPRi7vTxtIFZq2KldmHj+kUQ7HxHmEX/pv2p3srp7Q==
X-ME-Sender: <xms:Bbd_ZNx_7L-KGaDXf2sGVsD784baLVYEqLWLcwE-siaT3cmJcj2YCw>
    <xme:Bbd_ZNQ0WCGtjCDvfLn4otw6dRQWxapJfmNR4eJ30VAfGddUVsyeiuRgnGshh0ycc
    8PfWrkSpTOndcrYCCU>
X-ME-Received: <xmr:Bbd_ZHVO1fR7HXuHAGB4N74Izhyqd9dgryMOOhcxwK7jgSRbBpZsG9KuQZ00i6wM2ghaCYoeVgiwFTH4PzEq6gdckSw5ijt2V8sLoVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkjghfgggtsehgtderredttddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    eghfejudffteejleehleegfedtkefhtdetueegueekhfelteelgfelieeuuefgteenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Bbd_ZPjxDvI9QUOOqrRWA9scTKQGnN0MZ-S-rAYYZN6tXBjCHaqigw>
    <xmx:Bbd_ZPCapdpHQFLoHQWkI8LzHc0B9aWVac3YOA3C6Y8OzS16VrQdUA>
    <xmx:Bbd_ZII03VeZ87qW5f1JQvx00WmUT7gKAtEbw2F3l5uCRXEyFvheNA>
    <xmx:Bbd_ZBCcSIrvyJfKM52i8wXP4kg8LLMroYist_02fj8Y7xzpCHvObw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 18:45:20 -0400 (EDT)
From:   Luke Jones <luke@ljones.dev>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org,
        =?utf-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Subject: Re: [PATCH v2 0/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Wed, 07 Jun 2023 10:45:15 +1200
Message-ID: <5946924.lOV4Wx5bFT@fedora>
In-Reply-To: <ffdd2d13-975e-1c74-0d2b-132ba461a3ee@redhat.com>
References: <20230505043013.2622603-1-luke@ljones.dev>
 <06314c8dc4adeb69cd7801f9621c831f75a37c89.camel@ljones.dev>
 <ffdd2d13-975e-1c74-0d2b-132ba461a3ee@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4841190.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4841190.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Luke Jones <luke@ljones.dev>
To: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 07 Jun 2023 10:45:15 +1200
Message-ID: <5946924.lOV4Wx5bFT@fedora>
In-Reply-To: <ffdd2d13-975e-1c74-0d2b-132ba461a3ee@redhat.com>
MIME-Version: 1.0

**snip**
> >> Question 2:
> >> 
> >> If you turn the second screen off through drm/kms, using the desktop
> >> environments monitor config panel does this also turn off the
> >> backlight ?
> > 
> > The screen is dark but there is still some backlight coming out of it.
> > I think this means I need to add a small pre-off to the patch to ensure
> > backlight is fully off when display is turned off.
> 
> I'm afraid that this is not going to be easy to fix at the kernel level,
> we first need to tie backlight control to drm-connectors as I proposed
> (and plan to implement when I can make time):
> 
> https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redha
> t.com/
> 
> Once that is in place we can simply make the drm-code call out to
> the backlight driver and have it turn the backlight off when disabling
> the output through the drm/kms interface.

Okay cool. But until then I can set the screenpad to turn brightness off when 
it does the call to:
err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
here I can also do before that call:
err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,ctrl_param, NULL);

Then when the patch you mention is done this can be removed.

**snip** 
> > I would like to go with the backlight patch as it seems more likely I
> > can adjust this without breaking userspace if required in future. The
> > WMI controls behave as expected to.
> 
> Ok, lets go with the v2 which adds /sys/class/backlight support then.
> 
> I must warn you though if this does turn out to cause issues I'll have
> no choice but to revert it.
> 
> I must admit I've lost track a bit of the state of v2 during this
> discussion.  Can I pick up v2 as is, or were there (other) remarks
> which need addressing and should I expect a v3 ?

There will be a V3. I don't anticipate any issues at all with this, and some 
folks have been using this patch with Gnome and KDE since V2 was submitted.

> 
> ####### Switch to (off-topic) GPU mux discussion ########
**snip**
> >> I think the best thing to do here is to just use EFI on machines like
> >> this. That or put grub in text mode so that it makes BIOS calls to
> >> display text. Using GRUB_TERMINAL_OUTPUT=gfxterm combined with
> >> classic BIOS booting will make grub try to directly drive the gfx
> >> card itself and I'm not surprised that it gets that wrong in this
> >> case.
> >> Note I think that just using EFI is prefered over switching grub to
> >> GRUB_TERMINAL_OUTPUT=console. I would expect
> >> GRUB_TERMINAL_OUTPUT=console to also work but I'm not sure. I don't
> >> think that the classic BIOS boot stuff is still tested by laptop
> >> vendors and esp. not tested with non standard BIOS settings ...
> > 
> > The grub gfx mode is GRUB_TERMINAL_OUTPUT="console", fedora default in
> > all cases here. Grub itself shows fine when the MUX mode is in dgpu
> > mode (aka, internal display connected to dgpu).
> 
> Ah ok, so I misunderstood and the problem only happens *after* grub?
> 
> Have I understood that correctly?
> 
> And this is on Fedora with the nvidia binary driver ?
> 
> The problem then likely is that the nvidia binary driver is not in
> the initrd (which is by design since it may need to be rebuild on
> a driver update while the kernel is kept at the same version,
> so the initrd won't be rebuild).

That was indeed the issue. It also creates new problems for when a user wants 
to use iGPU only via the plain (and frankly not adequate or good) method of 
simply removing the dGPU from the device tree.

Currently I maintain the supergfxd tool which is a lot more advanced than the 
other gpu switchers around, and I expose both the above method, and also PCI 
hotplug, and the ASUS WMI method (which I now think is used by other vendors 
also). Hotplug and Asus method can force the device off, and it can't be 
brought back by a PCI rescan - but to do so safely the Nvidia drivers must be 
unused and unloaded. I guess I'll need to tweak the boot process of supergfxd 
and block things until this is done.

Maybe we can move this to a new topic, because there looks to be a few things 
to discuss in relation to hybrid laptops, and specifically Nvidia with MUX, 
and Advanced Optimus.

Cheers,
Luke.



--nextPart4841190.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWREWzoOl5TYvoo5xMJobe61BDbQFAmR/tvsACgkQMJobe61B
DbQgEQgAkTzdVjHJNUI25x6De+haJeiIwi84h1Rs8eKq26ACisldeo0PwbNFG2kS
TTtnunNh5WTULem8wVbof1+zVcmf0euyQERPRulnx8CteGOhOEmAEq/pGHTIAYvV
uKEDLKb1BoNBGwT4fRGflgqbD5p54TCoszYeL3AxDVyg7ttcbu60pmyBdyj7PnqS
i7yUWYIKIAzX6fIUCue/ZjgTq55u3SGf7VBFp4SkrJG8FbZk6QE3TYy+ro4rGzyR
vCg5NoYeGzLLyZ9iblj+lV3HluwCN6pFXrZmEXJDGd5XTCKsyQyG6xK165sTBti5
dCCqkIt9x8rnppiWDsisg38Z3Eb90g==
=RmpV
-----END PGP SIGNATURE-----

--nextPart4841190.31r3eYUQgx--



