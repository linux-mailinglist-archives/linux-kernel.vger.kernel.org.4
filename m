Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B872DD55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbjFMJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbjFMJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3921A1;
        Tue, 13 Jun 2023 02:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6331F630F4;
        Tue, 13 Jun 2023 09:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA14C433EF;
        Tue, 13 Jun 2023 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686647462;
        bh=3x1vQa4C2vZm/aLZjUrKsrmkj7ZCJR2uls+VZCZHrrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nni+VDRcxHMCmL7HaHuIamrAr+jGI5W845fK1XXI/usl+07uT8yr2iucRl71B9dC4
         7CJ04vWx0JZLFRpnZcWiEZ3xhEk3NBJp1jaHE6VeRmf6E858SEuZfimyzYFPg8M0VR
         YfHMlGiyAnsEl2iAzOPKtvDS4ID1z37/dyiIYqkBB3DOEzfWDBsO+dEHCt3104Yei4
         OLANcqsGG52i2UODN0aexcZT9a2/2njvvuk4oqRAMmRRHvlQ3KC1jax5YTcdfPHCZf
         XDvnNJYHVFOV/uxVEUbKL/qDdfwOHY4NsCkwerXxM/t0aBvZV722SDTcm+yRNsTUJ9
         mMyWhc7CZHEQw==
Date:   Tue, 13 Jun 2023 11:10:59 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>,
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
Message-ID: <hvfr6qkepf6l3ymqtp6vhlneeqihnli7g5v7nzd6rirwleffk6@4ernj6xng5rt>
References: <20230520105718.325819-1-15330273260@189.cn>
 <d4e647d8-294c-abd7-40c6-37381796203d@loongson.cn>
 <a23d6mgl4fbfa4ucgjvwgw7l3somxo4tkhit7ygy55fldlum56@vm3tyjdsx24l>
 <d2f744b6-e4c9-d1b5-d4ca-470b801c670d@189.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpffyxdlrw7g4k3j"
Content-Disposition: inline
In-Reply-To: <d2f744b6-e4c9-d1b5-d4ca-470b801c670d@189.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hpffyxdlrw7g4k3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 04:35:44PM +0800, Sui Jingfeng wrote:
> Hi,
>=20
> On 2023/6/13 16:30, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Mon, Jun 12, 2023 at 10:58:54PM +0800, Sui Jingfeng wrote:
> > > Hi,
> > >=20
> > >=20
> > > Any ideas for this trivial DC driver? Sorry about my broken English.
> > >=20
> > > What to do next? Send a new version?
> > Thomas already told you to merge it in the previous version:
> > https://lore.kernel.org/dri-devel/7b77020f-d543-13bf-e178-bc416bcc728d@=
suse.de/
> >=20
> > So.. do that?
>=20
> Yes, that sound fine.
>=20
> But I can't do it myself, would you like to help?

Why can't you do it yourself?

Maxime

--hpffyxdlrw7g4k3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIgyowAKCRDj7w1vZxhR
xRRuAQCrBuuVG4szTbawSRwgsoNQPfbuzW5fwxdZkFu+rKLDCQD+J6ujT7XS4QIG
mbiB7naiKmWDCd8R0jlmFZzJNw2kDgI=
=nhdu
-----END PGP SIGNATURE-----

--hpffyxdlrw7g4k3j--
