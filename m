Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C56D165C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCaEb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCaEbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:31:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093B113F4;
        Thu, 30 Mar 2023 21:31:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PnnS50BH1z4x4r;
        Fri, 31 Mar 2023 15:31:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680237109;
        bh=9l+hJ0cGB0N9iPXXYNCkxegr1Aiek5amfVwzwHWYp6Q=;
        h=Date:From:To:Cc:Subject:From;
        b=TM9Zk3YVCG4i2iP+I0c+9r0KPUTpXWFDSSmbXe+8PL5jpgrrsAa133u0inAm/dZAA
         +W+ApFQBz9uNyaZx8Ae0wUG9pCiHL+lKIJzpPTzONY6ni/k0kcMey3knWKY4EbDlc9
         0DQE/lJa0CSKhPE/X3flLh8LsydmEVSDvkvpgFI/4GlcgiSzAddtx+YY91pH+8VRvQ
         uwgT6gdak3STWVibAQTYrnmd59vD7R8M6+dwm+iThUUdThHscTHSwbi2fpMQT71CQN
         MXxaDT+XjCiDypGWvvGaqwxTLPZ/TJa+Tn67jk7P204bJvHBizYCNiVsG7PT3ogNWm
         Jte+gw/udC7CQ==
Date:   Fri, 31 Mar 2023 15:31:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the iommufd tree
Message-ID: <20230331153146.478c4d56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BqWXWCdARU35S.aPhL+Xzv5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BqWXWCdARU35S.aPhL+Xzv5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the iommufd tree, today's linux-next build (htmldocs)
produced this warning:

drivers/iommu/iommufd/device.c:674: warning: Excess function parameter 'ioa=
s_id' description in 'iommufd_access_create'

Introduced by commits

  7540af571dc7 ("iommufd: Create access in vfio_iommufd_emulated_bind()")
  8003e9a6c169 ("vfio-iommufd: Make vfio_iommufd_emulated_bind() return iom=
mufd_access ID")

--=20
Cheers,
Stephen Rothwell

--Sig_/BqWXWCdARU35S.aPhL+Xzv5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmYjMACgkQAVBC80lX
0GywZQf8DNJij+j06Imzjz7UhltEHrGzWK8Vxhk+P+Y0W6ZNKBb9dv5oDwZmtqxw
aBt1eQF0hri/Z4TBuauvqePy41ABEdd8BjN2LpXLTFEbwnZm4qoYgFX6OlHO9wTY
fL83F+0zFJkvgD1G2+Uisra6rHWghqFig9CTT70hjVkscIYo6xqOE3sm4bkg+R94
sJR+hq919E/sa48iAfPu5FIczbCIUQsCoD4j3WVGjUjzx2deOdZsrBOOkKwyXHJE
Sew0ciOvYnPyTLmpXNkP+rifGCqgHTzpJ/bqEVEI3jEC2rTiHYX7NSiAD2yxxcZE
pIUTbJcnFmwxrP/XIt90+koMoUyZkw==
=QQRc
-----END PGP SIGNATURE-----

--Sig_/BqWXWCdARU35S.aPhL+Xzv5--
