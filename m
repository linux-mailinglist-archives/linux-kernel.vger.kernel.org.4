Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B36617F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKCO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:28:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC27BBF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 963AFB8284F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A0FC433C1;
        Thu,  3 Nov 2022 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667485720;
        bh=DN2U+zHMYnYDwgy2AjoN9CxQeyhHUhZQ799Av3LTZss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QT0qCEuzToqRdOi78UsQP4nWmCj9Qg/ZpOsbe5z5B5rPFYhTlSTu7csMVb+eL9Ppz
         iauBwEJLckJoDceYW0lB+sSR9EmKfPjdL1xd3jv9bLot8voUNe3DS+KQlFq0Q4h9/e
         LaHKlAk+u3oYrkqslNspUzd0qwb3owSqj5jvbFXQMzVLXaE3s9gXfB/thvpnVgVzZU
         YLMJDI8TwJCYLTHCx+yxfh988i9Km7rcBDqOO3EykIAicySG7pPldFieOXkf2w3Z3p
         Dpt99/1YqATgzW8JJpzwOuoxSBno9RdoaKsGXY7c2fSZVR57MMy19RWFGFM1xg51bg
         5YWuToDNhH9ZA==
Date:   Thu, 3 Nov 2022 14:28:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Juan Alfonso Reyes Ajenjo <jareyes@gmv.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?B?Ik1hcnRpbiBQb3ZpxaFlciI=?= <povik+lin@cutebit.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Fabio Estevam <festevam@denx.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Plaza Roma <gplaza@gmv.com>
Subject: Re: [PATCH] Fix tas2562 volume table values
Message-ID: <Y2PQEvY5Iu7jzVVv@sirena.org.uk>
References: <VI1PR07MB5839C95198DD090316E87B78BA389@VI1PR07MB5839.eurprd07.prod.outlook.com>
 <Y2PA8Bo59YDKvlRG@sirena.org.uk>
 <VI1PR07MB583938C86519E34431A248F2BA389@VI1PR07MB5839.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AoDXkSSXIdUF6v5A"
Content-Disposition: inline
In-Reply-To: <VI1PR07MB583938C86519E34431A248F2BA389@VI1PR07MB5839.eurprd07.prod.outlook.com>
X-Cookie: Dead? No excuse for laying off work.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AoDXkSSXIdUF6v5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 03, 2022 at 02:22:52PM +0000, Juan Alfonso Reyes Ajenjo wrote:
> Sorry,
> maybe outlook is doing some weird things. I will try again with send-email as suggested.

Yeah, I'm not sure Outlook is able to cope with sending patches without
mangling things - I'm not aware of anyone using it successfully.  The
nearest it gets is sending as an attachment but that's really not good.

--AoDXkSSXIdUF6v5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNj0BEACgkQJNaLcl1U
h9ARaQf9EqgOpZ/hYoHse/LAeK93F8o6OEPruckRCah5nJmt/BRqorRmIlH3mSU9
r0p3/OrJbm0dkYUyC0MMyE2lXS2TxfpekAYDqR/uIgnKCIPzeRZvWCT/EtRjL5he
yWo60S7jEsDutDTEZ0F7QIvVxFtvRD7d5lS4anSEGfJM0mIAz+YYmT0VOteCvv1A
SdoWGvXO6wXbpWsekyLWD/8d1Ex9IerJfstJHdvC9C9gllOs0X+GpkNuUqYUGeGY
MLa2Zq7emBYR5Vg2gwFDi8jbK/kzbnDDvjhOk9La8F56VtLi4URwEayApac5IBMH
LrHBpcLsgQEkfc1XNT4dzjViKLEG/A==
=4mnn
-----END PGP SIGNATURE-----

--AoDXkSSXIdUF6v5A--
