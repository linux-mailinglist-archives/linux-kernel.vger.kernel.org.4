Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9405872DD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbjFMJLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbjFMJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC5D1B0;
        Tue, 13 Jun 2023 02:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3544862A60;
        Tue, 13 Jun 2023 09:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45984C433D2;
        Tue, 13 Jun 2023 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686647486;
        bh=NMjSzXNKLluKLHGJe1lvDUHDWx8rVkp+8Ry49RSqBsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xlxj2Iw8Th0bn9oqhEpqydffv5ympRO/M0SWtCJ8+UMw89dP09pY/p6LWWwVmv/Ma
         Ktf37wYvaPYoOm71JMFYEaHCXjUlKM//55lt/a8vkqm3oF1pQUQDRcS1wu+vZPzpWY
         VL71mlZka/cDJyRIEtWOw6tfdppAy+egNvpIbl1JwUutF+2Fs3UA34CG+wxZiPYNun
         gfCufdzCCs8QhkAaNoxC39QPTPFO+mhPobVaRH9JsZjLW/KvqhMR7z/c8zZsN7pw9/
         /jqZ4PsD4QAkVFx50JpiTTM6gCFguCOQMOtsC3XcDc1yzHeXIEcwZsEpNlUpX1YZvy
         BcbY0IIjOkwzw==
Date:   Tue, 13 Jun 2023 11:11:24 +0200
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
Message-ID: <zxnddcy34246wjs7zj2mdynqaets4oo7tqublnufi7yo5ssz7c@u3z76c5m775v>
References: <20230520105718.325819-1-15330273260@189.cn>
 <d4e647d8-294c-abd7-40c6-37381796203d@loongson.cn>
 <a23d6mgl4fbfa4ucgjvwgw7l3somxo4tkhit7ygy55fldlum56@vm3tyjdsx24l>
 <555e160a-0c9d-9145-88f1-a0ecff62240a@189.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svayteyeejfe2ndn"
Content-Disposition: inline
In-Reply-To: <555e160a-0c9d-9145-88f1-a0ecff62240a@189.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--svayteyeejfe2ndn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 04:40:07PM +0800, Sui Jingfeng wrote:
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
> OK, I also want to merge this.
>=20
> If there are any other problems, We and other contributor will take the
> responsibility to fixed it with a separate patch.
>=20
> It this OK?

Sure, that's pretty much how it works :)

Maxime

--svayteyeejfe2ndn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIgyvAAKCRDj7w1vZxhR
xR1EAP921S7BWqvuVN6l9ckYu3AHlvFzuVpFxxP4kU1R8ng3hQEAtg1EkLHb7jdz
WVeTn6c09kUK0jgN60fL+U+AzWdxKAs=
=A6nC
-----END PGP SIGNATURE-----

--svayteyeejfe2ndn--
