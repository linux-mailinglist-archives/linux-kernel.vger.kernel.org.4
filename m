Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930F15BBC8D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIRIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIRIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:37:57 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85544248DC;
        Sun, 18 Sep 2022 01:37:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D18D93200A08;
        Sun, 18 Sep 2022 04:37:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 18 Sep 2022 04:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663490271; x=
        1663576671; bh=7v+rGLNpuFE2Em5iZaB/vqDeW/4Qz8JC3g7aTU2pIGo=; b=D
        jNjxuqQsv4PSckw59PLQPNyyd+BbA2EkUYAzjcXPP6jCBRMmzGwdKVuttUKq3ksb
        z0acJ6/jDKGAZiLuj96/Zmv7oTqZbdi0yhE/N3Ee1JO41Ax3PveTNlJGAVrcbU6t
        vzWEk1tAzWwS5fM7K0Ps8myP4qwoayFVZ2TXo5xIgKfKrkh0cnUHQsjAij9HO7S/
        GarCKN4dv2hhu4pms3RQLAYHBDI0ylCvuV0Rbu1lPQAmcOpWoI2YKHCQFL1P3Sqo
        ei4B828breq7DssHd9Y89othaEqh6QjCph1eATPiMc86FH+HN03iW+4Dn1gXwd71
        Sm81fG+WzBnI2QW5EGBAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663490271; x=
        1663576671; bh=7v+rGLNpuFE2Em5iZaB/vqDeW/4Qz8JC3g7aTU2pIGo=; b=Y
        OCCq+IbIKPkEtLDegm0aakJeHJ1dznoK6HSjzBRKSCLMQGTRpEqgewp7YGee9b62
        lul4RKI5CL/5Wqhm347g1A6lAvmTn7VJe5D36YS7agelU4Wnej8hxRpcdH4VHyJz
        ENbjEJUydBN5OJHVoQ/f6bTvwBYML6zvWnuw22txVInShf0UP6V9LJT8xxE0pROz
        u5jxy/Cq++KmZHFjpfIKOM++R1+GCPDP4h+1wCJUDeO1z2362oZtAUIHknUbfUBL
        ftLxwcpfFw+kPg5X4OspM1wO10+C8srH1F+vxz4cgaJ6n3rLgCJGHywKtXvUmTHQ
        ggDX4uFD7cKsVEnHg5AaQ==
X-ME-Sender: <xms:3tgmY66TsGIi5yN2XBLTS34ETP2ninmtZJHdHxTWYxn6YahrPfnRyA>
    <xme:3tgmYz5RO_pO6_vugOHIRaxh99-4eWgHkla6pq7cqQ6a1_T1fHHkSqsRP3oqV0uy2
    4GNncD8k3VRIxJHWKA>
X-ME-Received: <xmr:3tgmY5ejx3bCOM9FuBdkc6cKl4Vfax1JMFaMrf6HVeFGHpJJjOWUhxHH8Bzo6OhZ3xOb7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:3tgmY3K9Efbx5UHCNyHBlW_dr8v56pzkGIMVkYx5Prf1mQfps_L5IA>
    <xmx:3tgmY-LZHXM6kJcx43r20c19_Bdqj674BjgY8i6O1Ab-rx8t4WW21w>
    <xmx:3tgmY4xttS4prKJAp8fkYxIQNV9riIpFDEvHgiOIFdYI_j2qOBZJ7A>
    <xmx:39gmYwhU2d37PdNNV4VBE_8hdhddRg0Ye2IXAc6FhJ89Bs8qjFPSyA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Sep 2022 04:37:47 -0400 (EDT)
Message-ID: <b94e6fd33938877d5863c9444ca9c68c01417d8f.camel@ljones.dev>
Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
From:   Luke Jones <luke@ljones.dev>
To:     Philipp Zabel <philipp.zabel@gmail.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "catalin@antebit.com" <catalin@antebit.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sun, 18 Sep 2022 20:37:39 +1200
In-Reply-To: <Yx9K88pXilS6qqL9@rog>
References: <20220909180509.638-1-mario.limonciello@amd.com>
         <Yx9ItlBjl6bxxu2H@rog>
         <MN0PR12MB610147F4362BB95B7B5397B4E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
         <Yx9K88pXilS6qqL9@rog>
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

Hi,

On Mon, 2022-09-12 at 17:06 +0200, Philipp Zabel wrote:
> Am Mon, Sep 12, 2022 at 02:58:51PM +0000 schrieb Limonciello, Mario:
> > [AMD Official Use Only - General]
> >=20
> >=20
> >=20
> > > -----Original Message-----
> > > From: Philipp Zabel <philipp.zabel@gmail.com>
> > > Sent: Monday, September 12, 2022 09:57
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: rafael@kernel.org; catalin@antebit.com; S-k, Shyam-sundar
> > > <Shyam-
> > > sundar.S-k@amd.com>; Len Brown <lenb@kernel.org>; linux-
> > > acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt
> > > laptop
> > >=20
> > > Hi Mario,
> > >=20
> > > Am Fri, Sep 09, 2022 at 01:05:05PM -0500 schrieb Mario
> > > Limonciello:
> > > > It was reported that an ASUS Rembrandt laptop has problems with
> > > seemingly
> > > > unrelated ACPI events after resuming from s2idle. Debugging the
> > > > issue
> > > > proved it's because ASUS has ASL that is only called when using
> > > > the
> > > > Microsoft GUID, not the AMD GUID.
> > > >=20
> > > > This is a bug from ASUS firmware but this series reworks the
> > > > s2idle
> > > > handling for AMD to allow accounting for this in a quirk.
> > > >=20
> > > > Additionally as this is a problem that may pop up again on
> > > > other models
> > > > add a module parameter that can be used to try the Microsoft
> > > > GUID on a
> > > > given system.
> > >=20
> > > thank you, these also helped on an ASUS ROG Zephyrus G14 (2022)
> > > with
> > > BIOS version GA402RJ.313. Patches 1-3
> > >=20
> > > Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
> >=20
> > Did you use acpi.prefer_microsoft_guid=3D1 for your system then too?
> >=20
> > If so, I should re-spin this series to add your system's quirk to
> > patch 4.
>=20
> Yes. I also tested with the following diff applied instead of the
> module
> parameter:
>=20
> ----------8<----------
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 6a2c94fdbeae..a247560e31de 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -420,6 +420,14 @@ static const struct dmi_system_id
> s2idle_dmi_table[] __initconst =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DMI=
_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming
> A17"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0/* ASUS ROG Zephyrus G14 (2022) */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.callback =3D lps0_prefer_microsoft,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.matches =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DMI_MATCH=
(DMI_SYS_VENDOR, "ASUSTeK COMPUTER
> INC."),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DMI_MATCH=
(DMI_PRODUCT_NAME, "ROG Zephyrus G14
> GA402"),

Just a note, this needs to be `ROG Zephyrus G14 GA402R` or this will
catch the GA402Q series as well which doesn't require this quirk.

In general the model numbering goes
<Range><Model><Generation><Graphics>, So for my old G14 <GA><402<Q><M>.
Or for example a ROG Strix machine <G><513><Q><Y>

I don't know of any others that may need this quirk.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> =C2=A0};
> =C2=A0
> ---------->8----------
>=20
> The full DMI Product Name is "ROG Zephyrus G14 GA402RJ_GA402RJ", but
> there is also a near-identical higher spec model GA402RK.
>=20
> regards
> Philipp

