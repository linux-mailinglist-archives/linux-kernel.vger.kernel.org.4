Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B702681A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbjA3TWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjA3TWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:22:44 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67573B648;
        Mon, 30 Jan 2023 11:22:43 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D5485C0113;
        Mon, 30 Jan 2023 14:22:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 30 Jan 2023 14:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675106563; x=
        1675192963; bh=KNt+7PkgzzwHFSHpj8U0dqq9ln2d5tUNkUj7Uhb+OKo=; b=O
        t4LQUGR2xd/scmLgUk1kd516BBgVCVeagpYfxUr3w70pCEgZfAk073r+sntypqPG
        fDbk5CPJTJ1hGv4VT610OzP/DVc0vkmX3xKD7R31N3j/j3L3MKwE5H20QURXZcg9
        SpRu/xwx8oxGgdCliddOokKvmdCLYVZR/64Alyf3k/4HDLlBgbrG+acB3twKgO9f
        Ly2+tf96rFN+HDIPiLJsSufTl2vdkaXPy15Xv6o3pM1bfj75ETehUHiBnnLsxg0T
        iXDERC52BbhDjwu1fnOwj02oXXfBqRGx+FAXokelKPo8wOpTkAbrrFM6R1IE84pM
        dByK710UqYZ24295icwuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675106563; x=1675192963; bh=KNt+7PkgzzwHFSHpj8U0dqq9ln2d
        5tUNkUj7Uhb+OKo=; b=GX80KXFAM6lZTqQJP/jvCgoYIWw443siAjfTy7hQMtPA
        LjEUzBT2fQToj2+lMLXgjn9D7jwMe7SuLB1h+gRrv9c2cmH1F5zDQ3Rj0caCOaJG
        MJvcjXTaeay4ShdTIoWU4CwFAcMIJAiSMZ4kgZkjScnUGcRz6nNdoOvy/sSv6eti
        5YkXfJAeUC8K1pZI3l/9bkHrChkjteJ5TlDvceAuHz8RXk5/KUGY32fQqAccqxan
        t8pYoMzpEIdkj3zQHEJAx7ZMkPGkMhgPLYil/M/S2/lBcanwTybmtcR0Ovzj72Zw
        ILLt0/G/BQoEfoMLwqRFD5s/J7XF2xYBDavLZDoUPA==
X-ME-Sender: <xms:AhnYY1Q1XfWtWC16PPLAcp_Gf2VtYOqAObiw9NI7BEu89hK5P-3m1A>
    <xme:AhnYY-xI_38rnWmq9PYdtuHC1FxYoDT_iA31FRljUxZ2d9zPV45uyvsMfA7MajyD2
    azbgcsZGIEWl80>
X-ME-Received: <xmr:AhnYY61sJrThxxQg18Ukc1a_Jn1yQG8LsPakw24NPlIp9W2ygXBbMUPLk3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:AhnYY9AfX7SUdxbslFFwWo0gVuj6Rbw28MSTPFtM3pemJGbdwZnSIw>
    <xmx:AhnYY-gvGTMfCsfvdhFZsPkPxsBkID8Ayg6dMuS-2HGln5VyWF8WNQ>
    <xmx:AhnYYxpyij34kl-4BJmVw1PMXjDAkPr-sllIShH_uTKFDQE3_f2lbw>
    <xmx:AxnYYxtSU_zcbxiKz2JZYI1eFqLbRgZ1eiMpjI9TafjrAJrx3Vc-dg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jan 2023 14:22:42 -0500 (EST)
Date:   Mon, 30 Jan 2023 14:22:39 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device
Message-ID: <Y9gZAJGgdjFtsm9I@itl-email>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-2-demi@invisiblethingslab.com>
 <Y9d692WEX/ZvBhXI@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RRwmfEv3VarUJ+Tx"
Content-Disposition: inline
In-Reply-To: <Y9d692WEX/ZvBhXI@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RRwmfEv3VarUJ+Tx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jan 2023 14:22:39 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device

On Mon, Jan 30, 2023 at 12:08:23AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 25, 2023 at 10:33:53PM -0500, Demi Marie Obenour wrote:
> > The newly added blkdev_get_file() function allows kernel code to create
> > a struct file for any block device.  The main use-case is for the
> > struct file to be exposed to userspace as a file descriptor.  A future
> > patch will modify the DM_DEV_CREATE_CREATE ioctl to allow userspace to
> > get a file descriptor to the newly created block device, avoiding nasty
> > race conditions.
>=20
> NAK.  Do not add wierd side-way interfaces to the block layer.

What do you recommend instead?  This solves a real problem for
device-mapper users and I am not aware of a better solution.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--RRwmfEv3VarUJ+Tx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmPYGQAACgkQsoi1X/+c
IsFo8w/+PRPFlxjsv/u7uuyDb+aQfqf4B2QMR3JEra1QQ4wMrxv/d5Jp3tA+g/p0
aoeHXGmyRcqNvPv6tfpnMoIhyOUSGMDind2IcaYoRU9TnRlXgnQm7PAOGoBio+Xu
kPfhALH/5Tp5PVWlsw+LW7HYx6dzvMC6Y44OVjto4k0myKvZl4Z0IesnziI3gav6
UI8yL2FqSoDIRafvxnlIDO/+Yd3SZbnwVdZiBFwEroEPCvxvkUl2hAJlbirZbc+o
eZW6VfLONnDjus2TH5b20QsBWT2z30KPHJimaKvjq5XL+E7+EzFjmC7MFR2OllrH
4haYuQSUzMEFKykvxHrOTO4BYPJ28wCgdBQrBvfPeMSNwfNzf4+kwjSawYPXNZW2
ZhXTJ+wTb+DyWbwvDhScmpSU8rlxZyQdb2DESrpn17c1ssaWlUeaoW01SQ6cpK9r
WlxBsQ1xkwK0/6v66ysdQEzvvnPq6IJzoMWRf2Cn03po7Mj0BK0jsi83kjc+5Hxw
Ubl0fMPlE0DRewdCuFwzMTiWmY/+jqubZMyslg5OOD8CqX9EORSk5PlJMZLpPYGm
hGyp+rlnLa22tqWoGpUIUnN5930tUYk5YntnaJ8yJy8h5VV3LTW0qmuU0J8dNGyZ
3+mF4HlILRtcVUzPjBDwW2Xgbi1JdMYwrwDirSI885Q2T3b536E=
=rREv
-----END PGP SIGNATURE-----

--RRwmfEv3VarUJ+Tx--
