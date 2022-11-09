Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326B0623574
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiKIVKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiKIVJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:09:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8E31343;
        Wed,  9 Nov 2022 13:09:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N6yJt68Vbz4xZY;
        Thu, 10 Nov 2022 08:09:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668028175;
        bh=WdEMKlPmE6cvS+4UxE5MDkzm2xXLyjq3CrEKnZGzouU=;
        h=Date:From:To:Cc:Subject:From;
        b=BTJ7naoK8COV451kwu6MvOECUNZumWPO9O9phY+FxOu2+JKQJ0LpSB+ld4yNsjAC3
         R2xW5N52uq4Fg9tma4lTkXIsi+JPva7maDPA0zlJwzKTOtnPiyu9CsIw70Wc75zV5N
         N3nHH+kvHJEXb/1H7Qluf6i55M4yx5cPzdnLIHQ9fvAKAjOUrg4ZKnkfTB3HrpOzhA
         6NpuqJqVGilVC9GrfHXxUyW7PDHO86++F3mnYQ8yqkZD8zJZG/H3/PiIzkT3zBF9q+
         evemggYOahTB5ag8Ei36ypw0bXMDYe9Bs19Nb6DB7FHCHfmPgLtJQZzl0xE1Dh26/D
         a4PRg0axNRK2Q==
Date:   Thu, 10 Nov 2022 04:29:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the s390 tree
Message-ID: <20221110042914.5d9cdc75@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LfuEonrlo8lCo/Mq2t_bAsn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LfuEonrlo8lCo/Mq2t_bAsn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0de03a40d599 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/LfuEonrlo8lCo/Mq2t_bAsn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNr42oACgkQAVBC80lX
0GzxNwgAnsFXt1sIFy0jEI9+BaIaLkvq04lZPF32Wffm54Z7DnhYSaMJWtDpcdZN
nbxDkC3X35yp5hmxyHmdDjzznF/JzQHvpYwZNkL5NwR3rIG/EcFUxVYzBhn94aOI
lyXVR9AOj4ejJxFmSphDnoK3wxd2LDMPmOWxh4oJl49og2NRZLww+egkjN/8rBdP
wZ27yIP3XS7RmRYffTA5+HL2s1ODIkJRqrxt2QpL1eGfihmkS7f65QmUkLBQXRd2
gZbr6zfwx507ZfZrW4GubYh9gwcGPW6Ra7Z8aGqywUFvdTfeUAqtbMJhFagef+8n
wkSNzJBTZrHbhgZbFMuvMbwBSnSf5g==
=nZvD
-----END PGP SIGNATURE-----

--Sig_/LfuEonrlo8lCo/Mq2t_bAsn--
