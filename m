Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F0567DD01
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjA0FEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0FEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:04:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8BC5CE67;
        Thu, 26 Jan 2023 21:04:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P358D07fxz4xG5;
        Fri, 27 Jan 2023 16:03:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674795836;
        bh=2CqNtGXTIRHq/C6b2X3x0XnLtgJLdXluF2a0hJS2wX0=;
        h=Date:From:To:Cc:Subject:From;
        b=BnYbTHIaivwemK8ee7hMTcYKK1Kc7BiqhvBvb0B/rs9LU5g6sB2/VbnODMk7hlPr+
         riD3bEBTwCPnm37LJNC4WZYyhL9pWy8Z1ZZT2Qvf1mARQIh8jcRuPbrdlEG4zJe5FG
         Rn3Fe0oaDt8nDMSfLCC5IZzoabzQymGonpOC/16RYCjTIgZJBXBaynTN9Ftelio8rY
         jQchQ6ncpVoNdzQIgRao6x3hLb6XIyDDYcIXWuo5TdsbbDbPwSdUmY+1qP9p/jmsLV
         ucVipeg3ZdRlW4bNrPh2PHzZGpy17YvGJnMZTo9YtL3TZHF+DBAq+mmdjJieW70xgk
         4AUEzLy24wMfA==
Date:   Fri, 27 Jan 2023 16:03:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Alexander Potapenko <glider@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tanmay Bhushan <007047221b@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230127160354.4ede93cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZaQKPh3=OLiHCGc3G6c_LMH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZaQKPh3=OLiHCGc3G6c_LMH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in btrfd-fixes tree as different commits
(but the same patches):

  49213d02d5c2 ("btrfs: raid56: fix stripes if vertical errors are found")
  dda3dc127f22 ("btrfs: limit device extents to the device size")
  ed55a190fc3e ("btrfs: zlib: zero-initialize zlib workspace")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZaQKPh3=OLiHCGc3G6c_LMH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTWzoACgkQAVBC80lX
0GwDwwf/eBmvITYrwKx6nejd/z8Uw8y+CzvOxyzPZG2zNbjiz9oWud+wi1f0oeGA
y8FQ7geo1Z0XA5yTaQFo7yS/UDxS+vZCUGVCqKeOHOJucsqJ0ftUHFnaMHBfeRLD
Mapcq/SUbfxR7XRvW1cd9gOUTInz7qtltav14vbGmVp6uzU47xYCREb62+BwnTMM
yqAml+UK8xuaPCUiZmQ9LR2Ov8AtcxArUetDtC/GIcs5BFKklX5v+TMf3HXqmxTp
wRru+kvoO993J7G22WSSAGB/KDhydw7sA+hL5ACLCAME+MZ9OuYdHAuc8O2C9+1N
msQRIRjVD77Xp8+qeiyT3urorikYeQ==
=EZph
-----END PGP SIGNATURE-----

--Sig_/ZaQKPh3=OLiHCGc3G6c_LMH--
