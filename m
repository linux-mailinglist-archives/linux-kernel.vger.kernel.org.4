Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1C69754D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjBOETu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjBOET0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:19:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A39E34C25;
        Tue, 14 Feb 2023 20:17:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGlCr19C7z4x1h;
        Wed, 15 Feb 2023 15:17:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676434649;
        bh=xvHGv3AUa1jLMT89wbFXdW021KIQIA0Mxn7RtBMvnDw=;
        h=Date:From:To:Cc:Subject:From;
        b=nrIxFQFcHFkVwdfLinUXKMualepMXkmrqDaKx4Bn8XXNNs4xe+gA2rV09pfdBERYU
         ELynH41o2KIzu68TwMZmSqCsuNTc/d7G1oG7LMje3i7Dl9m42kjvbvOd6P9MOCfTNM
         WvPmZRHQoUveaLx4AasGkNjj1S14qb3Cgp5eRjmkhMjd5Ds8V9XwAc/fd6hqrOP3bK
         dsKdJhJe4+V9rAljowkL9jlGE0qRnXC7zWKYHpOtFCyk5p0sXHLiwjqWU144dEpk8g
         mcs33+DrhOC728r/4mupfn09Gx2Lv41tmhwM9stBMvIMpHIlzseAxvXR6m+eB+oLqN
         TXP+VJkG4lsOA==
Date:   Wed, 15 Feb 2023 15:17:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20230215151727.414d5655@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9VCKprA=_cIGlxmlyc4oHct";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9VCKprA=_cIGlxmlyc4oHct
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:8958: warning: Excess function parameter 'gfp' descr=
iption in 'cfg80211_obss_color_collision_notify'

Introduced by commit

  935ef47b16cc ("wifi: cfg80211: get rid of gfp in cfg80211_bss_color_notif=
y")

--=20
Cheers,
Stephen Rothwell

--Sig_/9VCKprA=_cIGlxmlyc4oHct
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPsXNcACgkQAVBC80lX
0GziMQf+OWmiA8poBPN4UWIg+34kRSAV/Ak4ttuqRpm3Xhc/qDTLglMEUkuHnwE2
1z/nYZyFqlVfHQzhIxwkhEHauWx1DnUNubqy66juYUiiP+CNW9Uc8emDLq5CP7u+
vAf/hBT2j4zjY/rblUvHUevSLm0xliHw655yIP2vslBhGj9Swtm33901HnA2PizR
QPC+5hSu8s+A/6v8tI9MQbBvTHmYeGs3Tg50RRmkRlvpmsxKuPII/a4YBNTS8g/9
UZrDDztMwnfSC+ecIbwUp5KrGbSlT/yzwpPgDqC4YusQ6VBWWRbtBxKkA8UD/qPt
iAWjRyNg6WjYNwj3QIYcHBVdb0I8Bw==
=TlMp
-----END PGP SIGNATURE-----

--Sig_/9VCKprA=_cIGlxmlyc4oHct--
