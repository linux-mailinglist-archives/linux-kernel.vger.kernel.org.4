Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80A671E26
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjARNke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjARNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:39:59 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA1BF88E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=/BEhkrzChlQXvg2hAfIBofFUKgnV
        dX34XgXLMaAuwWE=; b=UwwGDDASYwJsXWllaE7o29VN50vaVt6Bz2P2+ZePEI8d
        MzxGqEiSNl9IzMkReNfem+2PE7fc+/bxgyJjnQV9s1fvdS3/vBhTEAoKu059ckGX
        Q5tMmprWb3DQGETGWm0Men9EM3wjJcR28/c4mqM+s4jLS7KynywnxgJYgcr1mZg=
Received: (qmail 3912013 invoked from network); 18 Jan 2023 14:09:20 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Jan 2023 14:09:20 +0100
X-UD-Smtp-Session: l3s3148p1@iG09honynKRehhrZ
Date:   Wed, 18 Jan 2023 14:09:20 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: renesas: vsp1: blacklist r8a7795 ES1.*
Message-ID: <Y8fvgCBbBVCqPDUZ@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118122003.132905-1-wsa+renesas@sang-engineering.com>
 <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3EpkLQhnVcpYjhA7"
Content-Disposition: inline
In-Reply-To: <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3EpkLQhnVcpYjhA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Overall, how much support do we still have upstream for H3 ES1.x, and do
> we need to keep it ? H3 ES.1x is relatively old, does someone still rely
> on it ?

SDHI also had numerous problems with H3 ES1. The agreement was: If it is
"easily" upstreamable, then we want to support ES1 as much as possible.
If it is complex and a maintenance burden, then we don't upstream it.
This is why ES1 has no HS400 support for eMMC. It would have involved
activating the SDHI sequencer which we don't use otherwise.

I copied this behaviour and think it makes sense (for upstream).


--3EpkLQhnVcpYjhA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPH73wACgkQFA3kzBSg
KbZ7vQ/8D2J2izzciRLivt8xC5TeF5wBHYcprVPKDbqkzOAlbeijUb/8liccRYU2
rqdPHQEsmMrDKoVRGQMW6dWh5qZqkBycSVWcOAnY00qM/ZSdDAh8/+J5sxrUtnWW
xA6soTkuOL4G3aT6cN8lYjOFzev9LmJEChLiqjrlGl89Yc/jajry+X+wMk+Jtviu
YUaMeTthTabaSy/v4KkwZdznCCC5jGoNBH8HeC5OjGDYWOGWqgyCEJ0k763wuHm6
Hzgikwflw42Dm9T2t0bxU2H45g/0H5ZibBRSiBswDyj2RBfoc2Wo5jPWMTYTPzMy
MCUAvpnSL4AQRw5l0mQLbCOqyE03F3lwyup4PM8UIXjC5lbv8h9ba38EQAIIx4o1
lYN5N92orFb9psDtYd+ZLpbk03hjOUs5Wznp38cutOEJ+ugnkdCvaPuDmEMWMpM4
UH+pfQxkerbtx7RxjfmXGMiCFUJE5aW5U404Aoy4KEvkRoychU3uJqhnb0ZhAj1N
ayA6vuy8N3q5EM6MfsjHAYFYSpRofoSmxnhumqnqltcNinjKcyEO97g4E1k37IMC
MEM6c3VE9UFsJF06geEiQk7GKiaC99qncIt2AUmf0VvN6VNYT4iACTFMvYExl8fx
wEGLzkvvNQlcznF4vQ7zGuReSUGO5k1PHuWb2gAbJbrhcT6WSAU=
=MDTb
-----END PGP SIGNATURE-----

--3EpkLQhnVcpYjhA7--
