Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE79B69C4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBTFbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBTFbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:31:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754FEBDFD;
        Sun, 19 Feb 2023 21:31:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKrd25Pkvz4x82;
        Mon, 20 Feb 2023 16:31:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676871095;
        bh=gBmo0TN95mb7CUHM3s3ZvsNFVOEMgcqzQUoS0x4tA8w=;
        h=Date:From:To:Cc:Subject:From;
        b=JliKbLjDZ7xBu+f1+kT2gbnlZhECHdKn5E8SYforSoOhewnJWsxBTm+AiUzqC8iXB
         V3BVYWs6dpDFa4aNQhHotkEN+Zs5K2Ylqc2f1V7qcp7EMVTPdfAZ/aIqFG6bz+57q1
         4o96+EgXmVu6HCbbySw7EtsFnj3Uam0n3iN3MrbnvRkKKJ36JvuJ1wWE6goBhwMD8K
         GD6/+2+27XpLV/SiqQL1xl4qS+Ez74iPDR7DL/eNk8SlAARn9P/+l2jzfsWNdEzJ2T
         L+bthiwbmCYD9H5x6aHERZIhfZRmEMHG9+SVEPnhWHathqZDWJ1GTLfJRbW17QKlF0
         SspjHkXxcJWyQ==
Date:   Mon, 20 Feb 2023 16:31:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the driver-core tree
Message-ID: <20230220163133.481e43d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v+1hp8+gtYxSdL44PGiY79/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v+1hp8+gtYxSdL44PGiY79/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build
(htmldocs) produced this warning:

Documentation/filesystems/api-summary:146: fs/debugfs/inode.c:804: WARNING:=
 Inline literal start-string without end-string.

Introduced by commit

  d3002468cb5d ("debugfs: update comment of debugfs_rename()")

--=20
Cheers,
Stephen Rothwell

--Sig_/v+1hp8+gtYxSdL44PGiY79/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPzBbUACgkQAVBC80lX
0Gyf3wgAjiXdcYU+fPh8hp/rmr5RKjreo5nJVkSR5VFR8dkQTjH+x3Gbyr0GfI8f
o8JftQNYOCgZ3GCFZBZYKDXtyKiqBWWC+IxICxZPZDWc6xpBX+ulknaRU/Fsl+8j
apqgFr+i91MVlrGVNa93ypNFpYDUFegOYcbKPYK9lUiBD/ueFqBOHBAV3rgUV1WU
1ZCv2cPQyX7Rsam2z5CAqi16J7ui0fTDd/Euu6gp4fNPWaBeQEaVOImF10bCQLhX
wA3/FkDEQWW5JDL0H/lm/LL55PWri8IWKrgjh7tP1Z6gvQQcPtMoRaoUuIa1VK2R
ZLXtHMO+qMQHzVYTaG4dRIq1HdAahQ==
=D4Em
-----END PGP SIGNATURE-----

--Sig_/v+1hp8+gtYxSdL44PGiY79/--
