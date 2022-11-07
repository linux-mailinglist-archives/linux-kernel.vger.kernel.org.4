Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1F61EFED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKGKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiKGKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:08:00 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B715816
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:07:59 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 49D4E2B060A4;
        Mon,  7 Nov 2022 05:07:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 07 Nov 2022 05:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1667815673; x=1667822873; bh=H188XHf92e
        tTDREXnb/OEU+uV1P6JQ1CLPf/Yjdde+M=; b=gEu++7F4AOlflnhqJ5+fnbojCK
        nkwxbyG1C9qowPqmGKvGXMfSnZd6Na5Cv9NZc9vFSXozr0ESux2jCMak+G2yFE8v
        MRzjga1u5opjXxwqvSqZfjde5PoujC57ardG3mpdwwQDOxZxwc64AY90SeESm1vN
        4gE+nXkcGGxEbSLlyJ731jwgbcpXqQuvjgJub0eB8pwqZAiinUtQ8f2iJmdkVCE4
        BIxqpv/330HO8THURUc28ZD79L+iHrB19SHbRInPdsvoaHzVbq1AYHReSZLLVc9M
        KbAB4lzMj2Gmvu/WoqVnAECku015lEjiIwihD8aGuOvH5wanb/d+Ca+VWDtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667815673; x=1667822873; bh=H188XHf92etTDREXnb/OEU+uV1P6
        JQ1CLPf/Yjdde+M=; b=GPwBvSEh+VbRha1ATDffxsUxKJoKHXR0U4/4a72EmZ8m
        cvfOAdBBsFYfn1A+CaJfX0/fipVj7UC9aX9mz+sNlvWy8wC1e31MTWnviAeODQGa
        EUeHf0O2qXXPjiczR42LfsVeOc6+g3odf0RnzSFQvyG6nNKS8sJAaK9VMrrN7rg1
        +Gm10gYCJVRLDhFQ9+9nsv1bfInv6kJ0jwf9x44kiYI8V4zI7Rl4fZYTT6LqFhDK
        emDylnIlbdMhmhT7jsKRpb97XHqH/xiaujF1mXFbix4zBDhEveG4Dm2phwDSx5TL
        vVEot2nZ2gCC9DfW3n9JGnhQfOqxTr/8e4RSE7WL5g==
X-ME-Sender: <xms:-dhoYyARoCxVJrmtEvIS0_FmWfcCThrM8hWD7_kymH-uoy_vWS0xhA>
    <xme:-dhoY8gmAKHH-2SJ6SQcrQN2P971eTRB37opBZnb46FC8CqkapUP0iRX9igmmnE45
    nR529tZDD9KsccHerI>
X-ME-Received: <xmr:-dhoY1mLqNcrIR-iY8kn8Sr3xavRV6VyoQE8T8hOFtWm9p4ZwNrBovAe4WksBtEk5rK8s0jJIg_kKmqp6DtLKnZ_Az0m44nEenLBfbtGmL-xOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeevfeehfeekieffgeevleevtefgffefkedtfeeuhfettdegjeehgfegudff
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-dhoYwy35CgOY1mfusEKLuDywIwMdZh4S1RlyqVfAtfVe6RM4Do_Pw>
    <xmx:-dhoY3R8KkmhZLS8NSi4YHFEoTKBj8jDEQBwbtgdE0hbV4S6VmumWg>
    <xmx:-dhoY7bRvSYaXa8ZhULjpaGyHJFHKsxu144f2Aml4Vu43uds7EFUSQ>
    <xmx:-dhoY_yGyPAWT16mttzlT_5aevro2ZdJyAl9T3TVozzrbs9R5OR_wQNfK0g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 05:07:52 -0500 (EST)
Date:   Mon, 7 Nov 2022 11:07:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Mateusz Kwiatkowski <kfyatek@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Ben Skeggs <bskeggs@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, linux-sunxi@lists.linux.dev,
        intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        nouveau@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Dom Cobley <dom@raspberrypi.com>,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 16/23] drm/probe-helper: Provide a TV get_modes helper
Message-ID: <20221107100751.neijajfrazxloldp@houat>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-16-e7792734108f@cerno.tech>
 <8d0eee22-50f5-5b0a-c1e6-c5f61dd5bbcd@gmail.com>
 <eb485588-2e7a-8455-7ec4-6a9649d2bef8@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gnrypjdevshxh5ih"
Content-Disposition: inline
In-Reply-To: <eb485588-2e7a-8455-7ec4-6a9649d2bef8@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gnrypjdevshxh5ih
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Noralf,

On Sun, Nov 06, 2022 at 05:59:23PM +0100, Noralf Tr=F8nnes wrote:
>=20
>=20
> Den 27.10.2022 00.02, skrev Mateusz Kwiatkowski:
> > Hi Maxime,
> >=20
> > First of all, nice idea with the helper function that can be reused by =
different
> > drivers. This is neat!
> >=20
> > But looking at this function, it feels a bit overcomplicated. You're cr=
eating
> > the two modes, then checking which one is the default, then set the pre=
ferred
> > one and possibly reorder them. Maybe it can be simplified somehow?
> >=20
> > Although when I tried to refactor it myself, I ended up with something =
that's
> > not better at all. Maybe it needs to be complicated, after all :(
> >=20
>=20
> I also thought that the function was complicated/difficult to read, in
> particular the index stuff at the end, but I also failed in finding a
> "better" solution, just a different one ;)

I think I like yours better still :)

Can I bring it into my series, with your authorship and SoB?

Maxime

--gnrypjdevshxh5ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY2jY9wAKCRDj7w1vZxhR
xQwNAP4m8wqBDbHwkCGeLkJY5dnG5iYXcSUpkoA/Zr4bM1OOTgD/fQIl3YCLdhl3
wENLHmgU8SYR+x7PQD/yXPYL48w/Cgk=
=0OBV
-----END PGP SIGNATURE-----

--gnrypjdevshxh5ih--
