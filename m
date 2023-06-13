Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A6072DDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbjFMJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239912AbjFMJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694A13E;
        Tue, 13 Jun 2023 02:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87C70632B0;
        Tue, 13 Jun 2023 09:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70438C433D2;
        Tue, 13 Jun 2023 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686648493;
        bh=WrUaJlwPOdtH8Grtb3bcTqhOd6ZRH6ivcqiAJBGA61A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtlBEDlInPiJlEo/p+6W2w8iVMXBB22HyclMjkfcITxusrVvmqDFUEuYUUZPxc1Vm
         DTcPGiAyzmxCRrsp0VnF2bzZx7bUByoo90KmsgR0MkVDkuFefTzWtNIX4g7jTBWkR6
         B4zk5+zqCTaex4SDzxWPGIb8g104LSPq59B/IExiBEERUpPUrX2c4TyBW5PlkMEQjl
         dPo0z3nRcN7+5XcZutQiaHun1uwKML5YrvXObDjUPUTFdJ10Wumn5p7SVMsSoJih9G
         BvDpTvoOe5D2JvLuWFPtka8Nagz1pzfa0SoKOgQ/8qB102ITVqPQvc0Yu4br3/0eIy
         o91t+00olmZkg==
Date:   Tue, 13 Jun 2023 11:28:10 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v14 0/2] drm: add kms driver for loongson display
 controller
Message-ID: <7rbtdidyfpctz22pw2mnt2a6yp34hwp2bdp7usp52ft5mfrfud@nokbyxjip5by>
References: <20230520105718.325819-1-15330273260@189.cn>
 <d4e647d8-294c-abd7-40c6-37381796203d@loongson.cn>
 <a23d6mgl4fbfa4ucgjvwgw7l3somxo4tkhit7ygy55fldlum56@vm3tyjdsx24l>
 <d2f744b6-e4c9-d1b5-d4ca-470b801c670d@189.cn>
 <hvfr6qkepf6l3ymqtp6vhlneeqihnli7g5v7nzd6rirwleffk6@4ernj6xng5rt>
 <42c54caf-0ab9-a075-b641-9e3e21b2a2f3@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="efolnwkilneuxbv7"
Content-Disposition: inline
In-Reply-To: <42c54caf-0ab9-a075-b641-9e3e21b2a2f3@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--efolnwkilneuxbv7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 05:17:00PM +0800, Sui Jingfeng wrote:
>=20
> On 2023/6/13 17:10, Maxime Ripard wrote:
> > On Tue, Jun 13, 2023 at 04:35:44PM +0800, Sui Jingfeng wrote:
> > > Hi,
> > >=20
> > > On 2023/6/13 16:30, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > On Mon, Jun 12, 2023 at 10:58:54PM +0800, Sui Jingfeng wrote:
> > > > > Hi,
> > > > >=20
> > > > >=20
> > > > > Any ideas for this trivial DC driver? Sorry about my broken Engli=
sh.
> > > > >=20
> > > > > What to do next? Send a new version?
> > > > Thomas already told you to merge it in the previous version:
> > > > https://lore.kernel.org/dri-devel/7b77020f-d543-13bf-e178-bc416bcc7=
28d@suse.de/
> > > >=20
> > > > So.. do that?
> > > Yes, that sound fine.
> > >=20
> > > But I can't do it myself, would you like to help?
> > Why can't you do it yourself?
>=20
> I don't have a commit access to the drm-misc,
>=20
> I think, I can get the commit access in a letter time when I good enough,
>=20
> But get the code merged, just merge the latest version is OK.

Look at the link in Thomas mail, it's the documentation on how to get
commit access.

Maxime

--efolnwkilneuxbv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIg2qgAKCRDj7w1vZxhR
xe2oAP4gD4M8YGkmV6iqul3AbWlc89QdI9EkMzUDaxAdh2wwhAD/RciCYKO5vjJ4
wHadgVBEHDBjHiKxJ5t/84BRjU5WewY=
=45xg
-----END PGP SIGNATURE-----

--efolnwkilneuxbv7--
