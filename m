Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2366D663
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjAQGj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjAQGj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:39:56 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1815B1E29B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 22:39:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 027083200911;
        Tue, 17 Jan 2023 01:39:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 17 Jan 2023 01:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1673937593; x=1674023993; bh=6P
        bfiVfZSB7Htf0hbQguff5nySaG/rwkmuJl5aAz1R0=; b=RI3tUTU0VJIToE9fcj
        4gW+wSnd+e3YoazzOV6qoPAcUJOZi7VhlokvNZ0R2VFdZrDw2itBu3Rjf5OuKrSB
        ZXwe4yqEAHZRbRRkG4iFzebdcuiNHiNJTaFkqwSFZPDO39yNSl0CYZXUrrrvCpT5
        TndkQbncivqSIK+qB7wYq9k4vQY63EVlCIwKGvEZSqLCCT9wa6rz5mxHd0mu7GWF
        Y+sh755FuYN4Wty40cSDaw0Yb28Dtpf7oE+DLK8x2rLPLprde1014DiugmMF8L/z
        0t/zM2BVSeWzIn/sW/q3nZ5CFA/hf12hdGE2YiwjgfsiAsxAA6haiQ7zwie7zbME
        XnmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673937593; x=1674023993; bh=6PbfiVfZSB7Htf0hbQguff5nySaG
        /rwkmuJl5aAz1R0=; b=dOWv17x/b2J9ZKzEEkxPx7mMshoQIhPY7L7DS2PB3PNG
        iG7gble2kAQsUGsIXoDaMdB/6ZuL9TOKG/QkdA9Z6UdU97xVrRTB+6vVnoR81F/J
        KDG/4nxLodP3JB1IeWAwDM5aL3iWlXeU0srj1azuHUtq2MEmtrmxQJBpRBb873n+
        xqMxKKP+35yw93cTbZ4/fkzzMmQsDuvVWOTgY/zL0vpKZd2yKPbyVNPFqS0pSWfL
        lr2xHu+7PupN5bwKAdKWOa8+BS1pueqHUlHU8/tV7VzoJfmPuYJ1qTwJIkZ1y006
        tLLI6pQf+0aLrKN4iHm5CUSn3EsZUQLTtVaW+LNULw==
X-ME-Sender: <xms:uULGY6Btglf0TlmZsldBzvCiKs_YTt5FnFgQh-ypho4v9OKhjJuEGQ>
    <xme:uULGY0iJfIhYMrVKekAv8pFJWirRs5cG-Zlv97cJrgzYqedCwQTmD9Hl7le1MyVA4
    s8rvwrlkaH1trSobS4>
X-ME-Received: <xmr:uULGY9l7HfaEwntVJ6NoavdDb_44Ibrd-ogsCl186FsyLfImyAUh1cO2rL8p3yHhhPGFX_aWDbSlvzRScjrnEclL45Bx_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddthedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
    uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
    htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
    ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:uULGY4wdwuYkBwph5Uvq-mC_LyMmbOOHUNDGqbxYlOmhHjDWQ-Ti9g>
    <xmx:uULGY_Qghoin1cPxDaERPbrBlJnk2pDA76Fcw29OYCSn8fFVxsTb6A>
    <xmx:uULGYzbcjRxUKNGK9mjmgSFyc3vdT-iQcRXBIzx5V0MgTE-IIO7FkQ>
    <xmx:uULGY4T1usfWSSPu6VwCSjyZXXbY876lj8GStIMil47PQrxvnU10Ww>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 01:39:51 -0500 (EST)
Date:   Tue, 17 Jan 2023 07:39:50 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression on aarch64? panic on boot
Message-ID: <Y8ZCtla2d76MScEE@cormorant.local>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <20230117055819.GB13795@lst.de>
 <Y8ZA30EoAFaFPwVC@cormorant.local>
 <20230117063735.GA14468@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYMRuDI9Dx4/JvOY"
Content-Disposition: inline
In-Reply-To: <20230117063735.GA14468@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TYMRuDI9Dx4/JvOY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 17 07:37, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > Good morning Christoph,
> >=20
> > Yep, the above works.
>=20
> Context for the newly added: This is dropping the newly added
> PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> other boot tests) to fail.  Any idea what could be going wrong there
> probably in userspace?
>=20

Adding 'rootwait' to the boot parameters does the trick as well.

--TYMRuDI9Dx4/JvOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPGQrYACgkQTeGvMW1P
DekkKwf/adlNJc8OTZMlPAknaVEYJE/2C6dOApgihjhpfiCMuu/35Egf1UfkNES7
3cBVBmtMQyoGlGBxmEC5hIbdHyasMZuT5K/DrPzMkwO7oeUurPYaQMmbFgPaYsdY
73MOLoQ94XUO3DmsP9gcd4vW5mLJAkb/gtYZeyCr7RW3RrPbNGelIkjP2aX5NqM/
PDVMMKT/L6SEUXZzu06DeIbfdRo0/DoDgug/hRVJnKexEp77UpGkDTUmB0PiPO7j
MdA8mwyS1pY1u+yWxDMeL8GjxY3L7/RPdICoYyC4YOBVfBMfVPx0hjx+602JGlKc
uTIgAZRDZIY2Hq076d31quZAXTqUhQ==
=FRVf
-----END PGP SIGNATURE-----

--TYMRuDI9Dx4/JvOY--
