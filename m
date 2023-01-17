Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF16670E89
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjARAXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjARAXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:23:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C085F770;
        Tue, 17 Jan 2023 15:38:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxQLJ0K5Tz4xG5;
        Wed, 18 Jan 2023 10:37:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673998681;
        bh=6o8f/hsZEwlY53BGqySN9SPEz6PJroAobIGjrinQTSk=;
        h=Date:From:To:Cc:Subject:From;
        b=GdV8R3SkGkXScJGg4DCKpHQ7bfsdlEzxKsNHMpdAqjMBgYr0roTo3fojIUxEQdNOE
         bkWFsMKroeG9QJtw6GiypcKtKam+kmA4iK9rFC5f/MUsnqvN5OdMM8kCFQFPTzDssA
         Pg6gc7yuUQ2Gdhw/YWHxx27ZQOFC71u+foIkGUARKF4cMcnIGoXFuF+8BhZ9YaFrDl
         zsdHCMp3s1MS7flLhjElksxJlgUnRti97ixH7K7xMG6Zn6aeR0+oukIVZBT4GJs3mx
         8kCu3bTyOFRNMOzFJ2nCRwwSvifM0MfpVlezoWRPmwXzCzS681Ot0gJqB8HR2Ectf/
         54/Nsv1A5fExw==
Date:   Wed, 18 Jan 2023 10:37:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the drm-intel tree
Message-ID: <20230118103758.135fe5a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u7VdDh0MoqRd_0D7xHcYRX3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u7VdDh0MoqRd_0D7xHcYRX3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the drm-intel-fixes tree as a different
commit (but the same patch):

  0fe76b198d48 ("drm/i915/display: Check source height is > 0")

this is commit

  8565c502e7c1 ("drm/i915/display: Check source height is > 0")

in the drm-intel-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/u7VdDh0MoqRd_0D7xHcYRX3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHMVYACgkQAVBC80lX
0GyaAgf/dTYHcQK7vqkDT+y1zjCMVNrhHHQGIA7yZHREcvu/i1dtVJn6myl2zIwb
pMumbJmbC4dImXlxx8eVgXHJuEZDDW6wd9itn772o44YAPFmg2H+pGG8Evnvo/d/
n+1Coj1asHT2nceuTDsEZV/FZfoY0Ghtr0XMpSPZOrprtbc7nCEHvJMULRDn0XvT
TdfD0GSx/ntPWlAYsPTx4o0igTNRYvMfiJQ8C8i0CryKIqf5V6RuRJRUBDSW6vQf
jV0VK2Vg1YBb074rIosLRuA5MDvBg6qw3sBcfOChTk3lIlXaFfLjeu9ndAy2ixFy
kph8iZv0fmq/GBmJ3ZfGpeGv7+AroQ==
=E1Ip
-----END PGP SIGNATURE-----

--Sig_/u7VdDh0MoqRd_0D7xHcYRX3--
