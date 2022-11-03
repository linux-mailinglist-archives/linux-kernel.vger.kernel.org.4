Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47A618797
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiKCSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiKCSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9B6448
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A38D61F8D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7F0C433C1;
        Thu,  3 Nov 2022 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667500371;
        bh=Hck8cjJ+4R3//xB7Q8qTKGJ9aassQ5/yidi0JVA2cWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejOx1hr62Urb3MPgwsvwVgy8/5u4h4hzChkyJEo5u06oUX+ssYAcJqI6cInVX1LhP
         hOpUu/zXdK9PWCBk+zBXwdNLgiA1YuPzZDawmP11vMRnXpbNoaTCdPoVmeRIn5cNEm
         TFxYWFocut+w26Wm6BgeI8uWEG0Pbin78DGlZU2cNKWl6MdEbuIOxkNHn3TRvraDeF
         HTDIGeYUPnSikE4nctDrqWgR89VPqaMOENOFCyzY7ZGnY6qgXXhXWqgDTrFDdxLB9Z
         zDjBOyxgEBIO/UY5LOuaP1JF7s44fL2UW7JNOJBbbGKR9XUY29oi/ss+9HvRJ7kOmm
         MuTW6+RXC/ECw==
Date:   Thu, 3 Nov 2022 18:32:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Joerg Roedel <joro@8bytes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>, alsa-devel@alsa-project.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] component: Add helper for device nodes
Message-ID: <Y2QJS+M1xX2RaK1v@sirena.org.uk>
References: <20221103182222.2247724-1-sean.anderson@seco.com>
 <20221103182222.2247724-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZW7Ag/fXdrbtoky8"
Content-Disposition: inline
In-Reply-To: <20221103182222.2247724-2-sean.anderson@seco.com>
X-Cookie: Dead? No excuse for laying off work.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZW7Ag/fXdrbtoky8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 03, 2022 at 02:22:21PM -0400, Sean Anderson wrote:

> There is a common case where component_patch_add_release is called with
> component_release_of/component_compare_of and a device node. Add a
> helper and convert existing users.

The usual pattern here would be to split adding the helper from updating
to use the helper - it makes things easier to merge.

Acked-by: Mark Brown <broonie@kernel.org>

--ZW7Ag/fXdrbtoky8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNkCUoACgkQJNaLcl1U
h9DfiAf/fccSbdTPcf/MR3+HytglBkaO/HlwepPSW582YcQ2/3q5mNX8QDYVAtq5
4LQR5pjemiBDY+lWTqufmKlDBjw8h9NY0L6v/NApr7x+PK1ZUEW2Ecqc6zcZ8LRT
FzBdTQMO00sV3mkJywGQBQGuqyvZrHYNL1RWP0ZDYoRU+27RZn7zOmnNuiA1g8IQ
AoMLzEGkIxhXEF1cmblJ7JuiB1p694k+nltDrbjqc0FsuGMVbfwOG2sTbHYYZJF2
EcaVTqEpCkwmxU2XAY8lgt4SXVO9m26QvgAFqyHSXOvag/H3HaSPNmNPWpUamabu
UWfwTYDmTIOxKFZxy+b7VIfdb/ZWrg==
=igBE
-----END PGP SIGNATURE-----

--ZW7Ag/fXdrbtoky8--
