Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB87366ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjFTJEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjFTJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:04:30 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8B10DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=iynYUB/RGTAC1b/vklnCFHuKoTfV
        0D4pmfoX3gYSYyg=; b=lhbcpL+Hnp0MkQskiph9uF5qSMjNUI4LrXOmCaS1d6qw
        Pawl3DWwCicnWKHjvwpBupflD1yRKncAaFLjTQA48u9hw4Kf4WyFdeVc3r4h8Nd3
        5zYbusHillK7xfQxkUTtqYCsYM/26atTu5HQU0f23cvzsD0UgRAM4RHBRFT4kyU=
Received: (qmail 569791 invoked from network); 20 Jun 2023 11:04:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 11:04:27 +0200
X-UD-Smtp-Session: l3s3148p1@FbMx8Iv+UKRehhtC
Date:   Tue, 20 Jun 2023 11:04:27 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [RFC PATCH 2/5] gnss: ubx: use new helper to remove open coded
 regulator handling
Message-ID: <ZJFrm1KYVfEDD9s1@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-3-wsa+renesas@sang-engineering.com>
 <ZJFn04P7_JhC24ST@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UtCMpp4hadYMD/BN"
Content-Disposition: inline
In-Reply-To: <ZJFn04P7_JhC24ST@hovoldconsulting.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UtCMpp4hadYMD/BN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I'm a bit torn about this one as I'm generally sceptical of devres and
> especially helpers that enable or register resources, which just tends to
> lead to subtle bugs.

It is good to think twice with devres, but I also really like this
helper. En-/Disabling the regulator matches the life cycle of the device
itself. The boilerplate code it removes tends also to be error prone.

> Care to respin this one after dropping the merge patch?

Sure, I'll respin this series right away


--UtCMpp4hadYMD/BN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSRa5sACgkQFA3kzBSg
Kbb/NhAApUidZOTNxSjTIxkp9cTvCW0bZiVev1d4N2ttWApeKlqbJyFb4eCwziv1
Asd7jChn9RHS1X5+QracbHH2oUw0c0aGxKq8omdcDaJjeBXtxzhmjovfyxuu5lmN
7NZ/+iUVuGdCydiors7AWhQOiR7iRJG27SLNldcrBEZPMjr3Iv5SqL2qREFh7/gN
cajXrV0rUUAeKzAQsqd8Unim0gQudbn3WD1C7+T5Bt26BDcNyARjpDoBx5QstLDb
Z5mGUW7WLeuSCQhXpeQ0HwLCLyOmgM8yTSILTVNYj71jWYRsAznMmIQFOvmBxjI9
QzRLosej0vvRVBsvM2SEm1tGl5HBKolNrR/IBnhJllMwKFjeS4BxydS4Pq2hIZkk
wltlS0p5nNXmAhtmq4U0mLxPMOGlpitSnRkgptxo0eAc8d1mCQcn7sRUQswHyOOW
Vi65iN8YQUe1t1dEAH9LV/z9uc9cQVaxzEGatt/A2s0X6ontuwTY3dZyBRTlgz1c
LkzlK/zS5dpkpEnAN1Q39Exux797fIzhpyCtArVL+2Iw5Cykfx5N7sDTK5hVpBFW
kqdFdgZjFgDYtFGoG2IGBTrURABqMCY6sI6PxEPAqd7N07Xfw/JXbn9kdsHsH7s8
cvoGVHvaxPML5SjjC0X9z5Llr5e5qv1wSODX3nkOEpz9CkVkaG0=
=L/9p
-----END PGP SIGNATURE-----

--UtCMpp4hadYMD/BN--
