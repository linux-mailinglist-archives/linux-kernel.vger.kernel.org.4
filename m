Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7E695917
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjBNGUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBNGUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:20:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A61C2719;
        Mon, 13 Feb 2023 22:20:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGB0T5H6rz4x1h;
        Tue, 14 Feb 2023 17:20:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676355641;
        bh=bAoRYp+dliH4i5EFnrZiJBYV+DjCrs4TOXIzVQflibY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q+XziyvzR2r1IOMScNsHSmlqtXiyz7usyK+pLO0ODtt9zalVJYUrUEyMOA+SJ9z6h
         5JCjgGZ+YcmLwpBAeZxdl3OUQFBrPZpdfPWSuHdi+/D7XB6Ohgt9asVJ6DWM6m/w4+
         Unj8/27pE65aaouqPqs1Di44+QqgTWydZNVEsk6He8PLQ4tc43k7/uWOSsEroseqIM
         j05ARI0Pt+f7bujiKh5dt5R3SOVAAlurLM7yStSlpj6kJhVq2/oecq7ftOmo7Mewa2
         VJtgpLYWsciRszj2+1TYuV99ibTwPvItlN6tZN+gr1B4TMSq7ai5lBQVW0RQikxJmh
         88japn2vbfrlw==
Date:   Tue, 14 Feb 2023 17:20:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: nvme boot problems after merge of mm-stable tree into
 linux-next
Message-ID: <20230214172040.60657882@canb.auug.org.au>
In-Reply-To: <58fb32f8-ce1e-913b-3b85-c41b0630d4c6@roeck-us.net>
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
        <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
        <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
        <58fb32f8-ce1e-913b-3b85-c41b0630d4c6@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4iCVPVl+K7UIlDj2sf6wPDE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4iCVPVl+K7UIlDj2sf6wPDE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, 13 Feb 2023 20:01:33 -0800 Guenter Roeck <linux@roeck-us.net> wrote:
>
> Overall, that suggests that there may have been a change somewhere
> else in the kernel which is incompatible with a change in one of
> the mm branches. It is interesting that the problem in next-20230210
> was seen after the merge of mm-stable, and that it is now seen after
> the merge of mm-everything.

That could be because I moved some merge resolution fix patches from
the merge of mm-everything to the merge of mm-stable (they were all for
conflicts involving commits that are now in mm-stable).  So one of my
merge resolutions could be bad.  Or there could be some interaction of
something in mm-everything (that is not in mm-stable or
mm-nonmm-stable) that is interacting with some other change in the rest
of -next.

--=20
Cheers,
Stephen Rothwell

--Sig_/4iCVPVl+K7UIlDj2sf6wPDE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPrKDkACgkQAVBC80lX
0Gy3VQgAmsLqEwiht9eEPOFGcO9vdu4eckgQtsah8VGnhR896UwibHZEmqchugDm
2H+f4jLQyqZAr0YuWJOfYemnJXWKnI3db5Ss6qgONMvkrjWh6OOuLWR2TD0zB+5K
JKukeiVfruFJcBiOoZk47SfJbf4h8fryyUJwbotN1AKTNmRfRZv4xST9clcldkkY
r+oACp1dMG4iwxldGBKwKSvbVPusFmdLxG/MJoSLxeQWWh+pVjTfdPcjlv+6TI9H
2sIq/rvqLAcU2R9e0jbBjCazwi8ZBBv4NzqvgohJ/1cZvtCOuqfy6opPT8j+rNWQ
WRJmT8GGibtPOz7dtLbSNy7YP2m+Qw==
=H3Nl
-----END PGP SIGNATURE-----

--Sig_/4iCVPVl+K7UIlDj2sf6wPDE--
