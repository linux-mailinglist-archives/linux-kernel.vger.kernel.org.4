Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A998764B18E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiLMIwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiLMIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:52:28 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACC2EAC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:52:26 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 28EE7320034E;
        Tue, 13 Dec 2022 03:52:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 13 Dec 2022 03:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1670921542; x=1671007942; bh=FB
        3GTeThf+PxfwcfSkW3UMFO7h6VBRdiAGE3OquQ1yg=; b=Ra23TVkwDdC5DO3wHi
        rSroRzvXwZiJMYDoYsYQfnFAz6T6sWoYphvE8bt6628DlsM3GoIu0kpt5RWfpB6T
        oXeKgTM9VU43Mgl0AP2DaPouNmm0bZAkXxaz+v675sjyMDuURFrsZTfp5gc9pPqL
        4fLvbOmD5PBflstHuSlEnapdqZATLgMTe8m99x8f4cRZeipfGy5W3XYETctaKnJ7
        R0NrzYVVWNjdREJoxABddO7yuedrnuoFk/Z7uWlldwoDpTB9mIeSydI2MTJVjbZG
        XFdfFdEDznwUNL3ez4B4818fywdfWlWAGWc299QQx5XTxqDz0WoIJou0MS0XRG9z
        pqHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670921542; x=1671007942; bh=FB3GTeThf+PxfwcfSkW3UMFO7h6V
        BRdiAGE3OquQ1yg=; b=WlsZKabHR0KMxBttNypfS8NJ0GCVpZA8f2UQX+k9eNWj
        j0/NgWY3RDShLRkoOUmPxF+i+bewkwoB91+CX/3x2ibAkHj8tRUCEBbyfLcEaaH3
        8CZWNJJ71D2MTezzrWozqXqgIEzIwg8nomNKaC4vIOWY8eM6y2UwjJznoPnlBZzJ
        lARAygzZS4nM4z96c0s4BHoSNISPgCTT0cfBR1EMI13mzRdgSuyJVyzjqqBtWuAm
        epEKYgnPndXw/VtiBQUhs8K4boBlxw8X4bzg4I/Zo28ucoh6KfrdKxFGJswH6+qk
        ZmAWpCchAXWYO4UXHhy7in8bqX2KHdkHOqfDGnVejA==
X-ME-Sender: <xms:Rj2YY5yih1YhilqionqrrmqsuycQWLDaVkZ7mYZiVTK12QO_tXnkYQ>
    <xme:Rj2YY5SAnivRyqghrMVTyB9WZgiwt8-8I3m-RILz2bKoAfcKyKnldQ_x5prkAVb5S
    7xxmIGTfEw5uYbSg0Y>
X-ME-Received: <xmr:Rj2YYzUP0tF5xiqacPrBOS5aQEMTFB1sxFLUrRwh7XbpZhyT-QEC_C9Ukh5-WweX2UDGtBM86S2epOSjNBidqVe-dXAOcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Rj2YY7iD2U8_9CLOflJYjVSXe9W-bALVhxT_gbqJkf-I8gdD-SeKnQ>
    <xmx:Rj2YY7Ap2KV4yj_cLtgHFg6cf4FqKZDWuRRA6oLOkzwkqAHCYibnuQ>
    <xmx:Rj2YY0J8pGFTAi_pZfLocquXQmuWYFhW843iyMl2us7GbMBFM7A4uA>
    <xmx:Rj2YY9BXuQUY4EVqKvK2-dh2CFEWOymXllrtpLVyey2w03KbLIXgdA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 03:52:20 -0500 (EST)
Date:   Tue, 13 Dec 2022 09:52:18 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, Klaus Jensen <k.jensen@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] nvme-pci: fix doorbell buffer value endianness
Message-ID: <Y5g9QhH1asYdXpZx@cormorant.local>
References: <20221212150243.41283-1-its@irrelevant.dk>
 <20221213085057.GA3998@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6KDFeo6ijDRncdJ"
Content-Disposition: inline
In-Reply-To: <20221213085057.GA3998@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6KDFeo6ijDRncdJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 13 09:50, Christoph Hellwig wrote:
> On Mon, Dec 12, 2022 at 04:02:43PM +0100, Klaus Jensen wrote:
> > -		old_value =3D *dbbuf_db;
> > -		*dbbuf_db =3D value;
> > +		old_value =3D le32_to_cpu(*dbbuf_db);
> > +		*dbbuf_db =3D cpu_to_le32(value);
>=20
> As the buildbot noticed, this now means dbbuf_dbs needs to be
> a __le32, and the endianess annoations will have to wee through
> quite a few places.
>=20

Yes, I'll fix it :)

--f6KDFeo6ijDRncdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmOYPUEACgkQTeGvMW1P
DelZbAgAjUBmJQ3Vwc+bf2H2i5eMeE6lMqnNtytTmRAE7zysG9f6Xj4tHORjniAP
IWfnTH8xqTuD+LY2QoHDb8/VlGwy0v8Jx+l71zScPtetvKJbL4ei7YMi195aQPxP
4kH3UyfWgrKZKZT6zlT1mecyvZqNZDM7ie/syoIRY9p4BaQAibKXhp2Oh8hu3Qkf
y3sUo2tVvoeqqeNbFXbQ+f2IaQViNViB47iT13USIDr2K4q87D/lJMsXBGMDKgxd
sJcpLhfd1X/VnfEPHOef/JgqwV0xNFz/7ETwEeOQD42V2Z1lKbprztIs+UBV9fM8
Hl+26hwhmSe2cBmDfGUlQacynyy/cg==
=UqF1
-----END PGP SIGNATURE-----

--f6KDFeo6ijDRncdJ--
