Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86125BC05B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 00:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIRWRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 18:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIRWRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:17:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2203417E01;
        Sun, 18 Sep 2022 15:17:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6812A3200A26;
        Sun, 18 Sep 2022 18:17:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 18 Sep 2022 18:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663539464; x=
        1663625864; bh=ptMNyOiiXn2yiXp14yCrudEDPcN1y+JvW8WnE6N8naU=; b=X
        UuZtaWa8KilZiAAf7ku6TYKeQJE0kz+sreLBsEJrqIhZmaexdW5aInwaQ61xg4pa
        0K3+u03SUayLuhoe8b7SnKEwH0b9O2jt37I4qeOcuJgv/KLftXF0iCcNR8RtWWP8
        RiSNgjHJjTrCrnlntxuteu43Yau1qYsYA0OwvOW8ofAk9jmxIY1Gs5hzQZoo1gLd
        Bf2w09TiCGzdCTRlnn/oBNFumNSha0vMC4COI/SsjRlip0EX56qLpLAPnDeZVdLS
        IJjIUS/CNUvy4Oey85DMiSBii3hMRwHhHhoBHyOQa/jkQEhrEVOMP2YWAvFoeSvS
        28TXZGnKddeVyqvdxM6Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663539464; x=
        1663625864; bh=ptMNyOiiXn2yiXp14yCrudEDPcN1y+JvW8WnE6N8naU=; b=h
        j5DBbUwhridMq/RhQ9o0uTVZP24R/bCMZVW1B2jJrXRCBJY8zA0+pmr7UHDjGfGQ
        7xaAAEexE0dXgg/2UZHSzPKgTEHf+YdYS1KiABi0Fr4TQI6lYxua699JuHChG/IO
        T9Rb8YiSkV+gWYq64DuiFUMQPCY6m+klWdhHaiqCC8SHfLNEukVesSgbIbWHIqv2
        AifBWEiHG/YnXza1uyDm8udBrkSrBOrAxFE6TJgsNnSLx6AXM2nz4d2+ce+L0VQ+
        98D7eJfeLiun58wyGI7CXaE7oxzv5GNh1y6rsORabjELMeF/CMd0KLDzve+eUBIA
        Fvwg9dp8JVUv4dBMZI7kQ==
X-ME-Sender: <xms:CJknY8GMgcZVLR3EI33oyr14EMSXBvrN206oHuRxFQUd4OjjT_Jy2g>
    <xme:CJknY1VwgFG8MvN9iKZDYkHakmsys82E-JjRMVqS8-BbRB3Ve8zIGX528KRiakqGf
    fBMWRUS30RBd0Lmtfk>
X-ME-Received: <xmr:CJknY2KKWFQC800x4dM9WfTNOuHelirtCgn8Gb9P9TvOKzKLvwhZBYYAI5nXZTprwxTmJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedviedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpefgtdekheektdeghffhfffhgedutddthfehhfeuiedvjedukeffveevudevheefieen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:CJknY-FjQkndGs0rWBB4OJMOCNpyNNBNeaQK90ADdw3RGOhCvkO4dg>
    <xmx:CJknYyVxsEQxxakxGQ6OaNqC1Re1LlM3ICwQMJo-5m73JhpN9uKY5A>
    <xmx:CJknYxMHyqkexUruZZCazACvesU1v829x0XbNBO5FbtQTkMl8ujFBA>
    <xmx:CJknY0dfqwFbRyKbTOKoRzJGbdogCbjpH6fHjkm4IsJlsSys8g0gXQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Sep 2022 18:17:40 -0400 (EDT)
Message-ID: <33aec4d4782cbd915cfba3f06f5c8993c3414e96.camel@ljones.dev>
Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
From:   Luke Jones <luke@ljones.dev>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Philipp Zabel <philipp.zabel@gmail.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "catalin@antebit.com" <catalin@antebit.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 19 Sep 2022 10:17:31 +1200
In-Reply-To: <d3dd18be-9c03-7c29-eb2e-d8d617994259@amd.com>
References: <20220909180509.638-1-mario.limonciello@amd.com>
         <Yx9ItlBjl6bxxu2H@rog>
         <MN0PR12MB610147F4362BB95B7B5397B4E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
         <Yx9K88pXilS6qqL9@rog>
         <b94e6fd33938877d5863c9444ca9c68c01417d8f.camel@ljones.dev>
         <d3dd18be-9c03-7c29-eb2e-d8d617994259@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.3 (by Flathub.org)) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-09-18 at 14:46 -0500, Mario Limonciello wrote:
> On 9/18/22 03:37, Luke Jones wrote:
> > Hi,
> >=20
> > On Mon, 2022-09-12 at 17:06 +0200, Philipp Zabel wrote:
> > > Am Mon, Sep 12, 2022 at 02:58:51PM +0000 schrieb Limonciello,
> > > Mario:
> > > > [AMD Official Use Only - General]
> > > >=20
> > > >=20
> > > >=20
> > > > > -----Original Message-----
> > > > > From: Philipp Zabel <philipp.zabel@gmail.com>
> > > > > Sent: Monday, September 12, 2022 09:57
> > > > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > > > Cc: rafael@kernel.org; catalin@antebit.com; S-k, Shyam-sundar
> > > > > <Shyam-
> > > > > sundar.S-k@amd.com>; Len Brown <lenb@kernel.org>; linux-
> > > > > acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt
> > > > > laptop
> > > > >=20
> > > > > Hi Mario,
> > > > >=20
> > > > > Am Fri, Sep 09, 2022 at 01:05:05PM -0500 schrieb Mario
> > > > > Limonciello:
> > > > > > It was reported that an ASUS Rembrandt laptop has problems
> > > > > > with
> > > > > seemingly
> > > > > > unrelated ACPI events after resuming from s2idle. Debugging
> > > > > > the
> > > > > > issue
> > > > > > proved it's because ASUS has ASL that is only called when
> > > > > > using
> > > > > > the
> > > > > > Microsoft GUID, not the AMD GUID.
> > > > > >=20
> > > > > > This is a bug from ASUS firmware but this series reworks
> > > > > > the
> > > > > > s2idle
> > > > > > handling for AMD to allow accounting for this in a quirk.
> > > > > >=20
> > > > > > Additionally as this is a problem that may pop up again on
> > > > > > other models
> > > > > > add a module parameter that can be used to try the
> > > > > > Microsoft
> > > > > > GUID on a
> > > > > > given system.
> > > > >=20
> > > > > thank you, these also helped on an ASUS ROG Zephyrus G14
> > > > > (2022)
> > > > > with
> > > > > BIOS version GA402RJ.313. Patches 1-3
> > > > >=20
> > > > > Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
> > > >=20
> > > > Did you use acpi.prefer_microsoft_guid=3D1 for your system then
> > > > too?
> > > >=20
> > > > If so, I should re-spin this series to add your system's quirk
> > > > to
> > > > patch 4.
> > >=20
> > > Yes. I also tested with the following diff applied instead of the
> > > module
> > > parameter:
> > >=20
> > > ----------8<----------
> > > diff --git a/drivers/acpi/x86/s2idle.c
> > > b/drivers/acpi/x86/s2idle.c
> > > index 6a2c94fdbeae..a247560e31de 100644
> > > --- a/drivers/acpi/x86/s2idle.c
> > > +++ b/drivers/acpi/x86/s2idle.c
> > > @@ -420,6 +420,14 @@ static const struct dmi_system_id
> > > s2idle_dmi_table[] __initconst =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF
> > > Gaming
> > > A17"),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* ASUS ROG Zephyrus G14 (2022) */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.callback =3D lps0_prefer_microsoft,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.matches =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DMI=
_MATCH(DMI_SYS_VENDOR, "ASUSTeK
> > > COMPUTER
> > > INC."),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DMI=
_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus
> > > G14
> > > GA402"),
> >=20
> > Just a note, this needs to be `ROG Zephyrus G14 GA402R` or this
> > will
> > catch the GA402Q series as well which doesn't require this quirk.
> > In general the model numbering goes
> > <Range><Model><Generation><Graphics>, So for my old G14
> > <GA><402<Q><M>.
> > Or for example a ROG Strix machine <G><513><Q><Y>
> >=20
>=20
> What _HID is used?=C2=A0 From your description GA402"Q" is Cezanne
> generation=20
> right? Can you please share the acpidump for me to confirm what is=20
> happening and if it's expected?

Sure, dumps are here -
https://gitlab.com/asus-linux/reverse-engineering/-/tree/master/ga401qm/408=
-fw

That repo is a bit haphazard as info tends to get collected
sporadically when issues arise, but it may be of use for you for other
things. I'll try to clean it up some.

>=20
> > I don't know of any others that may need this quirk.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> > > =C2=A0=C2=A0};
> > > =C2=A0=20
> > > ---------->8----------
> > >=20
> > > The full DMI Product Name is "ROG Zephyrus G14 GA402RJ_GA402RJ",
> > > but
> > > there is also a near-identical higher spec model GA402RK.
> > >=20
> > > regards
> > > Philipp
> >=20
>=20

