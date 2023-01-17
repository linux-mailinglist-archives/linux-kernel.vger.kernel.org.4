Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2FB66D65C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbjAQGcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjAQGcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:32:08 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FEC2312A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 22:32:06 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8B64E3200908;
        Tue, 17 Jan 2023 01:32:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 17 Jan 2023 01:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1673937123; x=1674023523; bh=3o
        w1fCrD+zOWtfP3/Gt028lm73Y+Br7BqZhWSBeKjwI=; b=w6hlmdA96VKRRoHZy7
        Cv5WzXEZ+7QrFxyVeX4iFeZpTEMoL+KjDNdUlxRdAPIpSL3leK0E+TQTvhTekzy5
        QeSci+Jsy6c+r7pTScp0STjgN9E9oCIyJwaCsvtnA1z0Egl2iGNNmhaCTh0KHDGr
        NYKs12WE1/sTESVnt9kZjmXHVGonrBAyDP+JXckOPS0XM7aq70Rzs3H+ZIuwY8CF
        Hc+aN3DbZ9wzt17z5FbVyUn2yHRpjJrq5JDDG32v7WSB8HwiF2wpt83hyl2xxQ5n
        c82R499M+xrgejd755SusFqJzRyz4lqjJPSJIeb2QqPfkeTIqLIAhLkEcFT5ovpZ
        xF7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673937123; x=1674023523; bh=3ow1fCrD+zOWtfP3/Gt028lm73Y+
        Br7BqZhWSBeKjwI=; b=dUoULwzv1CMjGdIebJI7rLKglTgvjsMl7Gjag1f4XkDd
        Wh+0uDlqEgBsL2KnI+7OQXdcBG8rS9gJj1g9V+WyXuVtSjWS/IUsJQ1DZ/SS/7rd
        pwWYU/f/RBYLyuoeololB8J7qdIwwQkTTsR9/RIqYzg4RTtb4P7bPGnaa7nUD0Qh
        /BhYbW8hqUhbtSDiU+KC3TId7K5qlTecgNrlYVPuRYuF6bcQOgNnF93pj/fE7E5Z
        INBfDm0PCI27ybZKG59i0h1evmPfFCcAUtG7uzaM0J2LkefvYW861YxNadNo0Yt6
        sZzE1I1eKUS+nflwEQzqHyWO5odeD47qNYMe5MZUmA==
X-ME-Sender: <xms:4kDGYw0lf2FyXoZc6i0cyH6vWiAhM_tI824DYV3a2fHMDN3bDN5LIg>
    <xme:4kDGY7GQXnRMrk_c4AVINw5d_LGzy7TXaQq9GvwCOP5ITrHHmQ5HhaKzVOcua8Gpj
    CQ2A1MSOD9__gV38oQ>
X-ME-Received: <xmr:4kDGY475zlpDxc0-Xjalf97xGMXfUy9sY7ruhAky5GPgvYD9gLCuSPkQIoHBdKZ8AIedkapTRhzxFz1k7QTx6XwwCm2Png>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddthedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:4kDGY51BIRaSCFFxB3c5a_LTgq-KxaY9VIGVTZ5BTiB_va7EBoJadA>
    <xmx:4kDGYzHCGyx9O6SmBdyEa_XRA_ObTcIibChSoJnR76F3K3Aqmigggw>
    <xmx:4kDGYy9RXLwX_YlUxgLsnBLiv9X8qxCebMJkG08iw5UQnCLzYK9_vA>
    <xmx:40DGY0OQnO14SShPCmzCMRhN0z_ZZh_06-2x84Jgs1ZVHVnu_5TXlA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 01:32:01 -0500 (EST)
Date:   Tue, 17 Jan 2023 07:31:59 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: regression on aarch64? panic on boot
Message-ID: <Y8ZA30EoAFaFPwVC@cormorant.local>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <20230117055819.GB13795@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cUqTUeXB0r3Qvrag"
Content-Disposition: inline
In-Reply-To: <20230117055819.GB13795@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cUqTUeXB0r3Qvrag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 17 06:58, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 10:57:11PM +0100, Klaus Jensen wrote:
> > Hi,
> >=20
> > I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
> > guest in roughly 20% of boots on v6.2-rc4. Example panic below.
>=20
> This smells like your setup somehow doesn't wait for async driver
> probe.  Does the hack below work around it?
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b13baccedb4a95..f47e19c701d520 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3508,7 +3508,6 @@ static struct pci_driver nvme_driver =3D {
>  	.remove		=3D nvme_remove,
>  	.shutdown	=3D nvme_shutdown,
>  	.driver		=3D {
> -		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
>  #ifdef CONFIG_PM_SLEEP
>  		.pm		=3D &nvme_dev_pm_ops,
>  #endif

Good morning Christoph,

Yep, the above works.

My setup is a buildroot qemu_aarch64_virt_defconfig booting from an
emulated nvme device:

  qemu-system-aarch64 -M "virt" -cpu "cortex-a53" -m 512M \
    -nodefaults -nographic -snapshot -no-reboot \
    -kernel images/Image \
    -append "root=3D/dev/nvme0n1 console=3DttyAMA0,115200" \
    -drive file=3Dimages/rootfs.ext2,format=3Draw,if=3Dnone,id=3Dd0 \
    -device nvme,serial=3Ddefault,drive=3Dd0 \
    -nic user,model=3Dvirtio \
    -serial stdio

--cUqTUeXB0r3Qvrag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPGQN4ACgkQTeGvMW1P
DekUlQgArSA3SHObjDm25ViUP7dge6sNgHpVj03FApy3trji+haPhfnLk7M8Uruo
Qqw5rCbESeL3xVYSPdyzJRX/JsQDYaRnzs2EzH+yygD+6NmD+nIakOTx6u00Tiqh
r/3fY+KBIc1B1VfGHFQbUMVHL2lye6tqdSiBUsvCmHmYLXJGcLUD+vXXhy8jGpU9
fglg63OMtZ9Dkf7iUVC5PL/RDAhgCUxhXmk5b0EIUIgr2zJUy7+xUC9hCNmcYjaz
k6G2e0UFc6xbk/5N0svNPc0Q4PJ8Z0pT9ru1xvUNoHUHdYhtaeMkKdgogzo54m7w
5taBf7+AiPseaxTMjJKc5GXBdqTFZQ==
=KGuL
-----END PGP SIGNATURE-----

--cUqTUeXB0r3Qvrag--
