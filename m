Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0234566D52E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjAQDvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjAQDvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:51:12 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB7C1DBAD;
        Mon, 16 Jan 2023 19:51:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nww0q2lTWz4x1N;
        Tue, 17 Jan 2023 14:51:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673927467;
        bh=IkuBlRaULUm+QPJBiYBhljxG4fkr0eUeds2YFECyeqI=;
        h=Date:From:To:Cc:Subject:From;
        b=p0du5cRWFrTNXma2MZX7+BB8CR8plDjVsS4ETxzWXCdEuNlFFx0CCnY0GAmEl2sGm
         T/pvsWtuNfSStYX4jWB17XZJSSPukTZPeHB5RSKk9ZFNM8vK+gvdsqYBSMuYokkpoI
         9K972/QdRgAnVDQDq7W2HHl/zQZNFMLb9+XyHXOjDgo7b+9wNBzo/YyB3y4ZrHLlXm
         WfKIexQXWDaip595hH2IPY1CCadUe/1vz5ffolHCrero16uLGRZ/artjjFmTBcVlE2
         0Kz3az4vAK+tE6qqr6OwWr2lTyeKikRccBFOXi1qWfbmDbZ6U5cqXU3ZuAX2D6y5uI
         o9qWgFWO6Xiig==
Date:   Tue, 17 Jan 2023 14:51:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230117145106.585b277b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L+g4y9/ubEcxfzDHt0qP6sy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L+g4y9/ubEcxfzDHt0qP6sy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/mm/unevictable-lru.rst:186: WARNING: Title underline too shor=
t.

Vmscan's Handling of Unevictable Folios
--------------------------------------

Introduced by commit

  efe2b9e7bb9d ("mm: remove page_evictable()")

--=20
Cheers,
Stephen Rothwell

--Sig_/L+g4y9/ubEcxfzDHt0qP6sy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPGGyoACgkQAVBC80lX
0Gze7Qf/civljZzpyqPuv8bSePO5DzVpvGuSJqVT9ZMTT8/0FYmgtWeRld3asQBp
LLmLrzYK4xANGvkWm7yRp8Kcqd+qML5i6hzTM9OCx5WqHW0C2ID5DTVM/gTbTjbg
NZ2QqX7HA9oh9bpIVvfrDj97bylgaWDDXVo5bTiq0ms2mcqpaG7gSWDNvPNHOTyy
B5d5q3OFgtkHRtECtA6SVHvmJ4g29dOzxmESjgE+HesiqHJ6Y20kW4UhX37LiyAV
7JAxIvKWOhaO/7/XN9eQjUdi79zt/TiYUqwtajt70dlvDPS+Gl3Ge4PziI2o8aCE
03eDqIG8Q3xBHueOJpwfdRTu7hKFHQ==
=629m
-----END PGP SIGNATURE-----

--Sig_/L+g4y9/ubEcxfzDHt0qP6sy--
