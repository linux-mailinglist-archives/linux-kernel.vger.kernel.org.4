Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57876D166A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCaElJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCaElG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:41:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCCBC16D;
        Thu, 30 Mar 2023 21:41:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pnnfl71npz4x1d;
        Fri, 31 Mar 2023 15:41:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680237664;
        bh=tF2OJdP8x/JdGnmC9sJoVuzBm8P11fesX9WeNdHQ6yY=;
        h=Date:From:To:Cc:Subject:From;
        b=nM9ZPo9eube0oVX2LNKieG1GTPtgJ361hm4IrfblL87Z//pLtmit7B5/n5TX2QKyq
         FVp1XPkILJ4vaYHNQ7KevuFBFc6zIh971BPu1myv0tt615eDNTYYRiP01H9Y63TJey
         H7kErSgsx4FJJhRifzQEHYVCBWv4LPvcgsK69JiLfmAo01IBwtzkqSTGgdK4rrn6lG
         pt9NjEHak2XewMdfoasu8Gpz9WBY6/p92Dl39h4BnObFsa5NEmaQ3QVhmINKXIrnWX
         vub2h9qQofHgGNIrgO6/WpCplkQkPKpobIRoP9l448w4MpNMHaklRgSzSIfdV54/aA
         VYt35jaPxw9hw==
Date:   Fri, 31 Mar 2023 15:41:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the iommufd tree
Message-ID: <20230331154102.1758a9ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p+NVSYV7wjxRNF67zkHcUgM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p+NVSYV7wjxRNF67zkHcUgM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iommufd tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/userspace-api/iommufd:184: drivers/iommu/iommufd/device.c:613=
: WARNING: Definition list ends without a blank line; unexpected unindent.

Introduced by commit

  e8b57a50334c ("iommufd: Add iommufd_device_replace()")

--=20
Cheers,
Stephen Rothwell

--Sig_/p+NVSYV7wjxRNF67zkHcUgM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmZF8ACgkQAVBC80lX
0GwfEwf/Uf9RFkQ5YtburLTOYu4GbIDnizcA1Fvx56B3uB8e7fCw/EBo0u/XzqZw
T4rxDS8FtcVcT9V/IAJtYcGFkCAEOX5HR8bjrgHvJH6n/lPsh5tnqoBphcReZNFK
04e8SPd2MALCmCRwFRGfkANGIy4BWl2yAaK0zu/576O9yVNhR1OZgF0wzbxKCHQV
JTWJcUisX5gykBcgcMyGtRGpoAL0S8NMdsro7oj6ZRwecb+36+7RVWy4BrmS+z2l
wLtBfsoZnfu3n64j0p7s1yrxWiu+SHRW6jdvzDh9CkuaVR9ICwe69JGzVh79tqFN
hJD6YZbEpkkFPS8WzMHExREduXAxbQ==
=QAih
-----END PGP SIGNATURE-----

--Sig_/p+NVSYV7wjxRNF67zkHcUgM--
