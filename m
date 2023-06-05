Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8C721C69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 05:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjFEDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 23:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjFEDKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:10:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F098A9;
        Sun,  4 Jun 2023 20:10:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZJWw3bhPz4x1N;
        Mon,  5 Jun 2023 13:10:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685934636;
        bh=oT3+kjfYuvGhpdaIOKpvo9YtYmWSFs9yFo3UMgXcQH4=;
        h=Date:From:To:Cc:Subject:From;
        b=m+2ds1jW8FMrNxWxCiXwZZgpdUW1GNiJrzqG2KpXP82CpDkFzwT9iJtAyVOotkilN
         a+CgVkROxiH7bRo/nWoulH0qo7r29hsfKdeHndKoA8JPpimmopOoDPOK0ZIn5JHERW
         wdmW+rupt2kjPc3Hp2skwokU8qMjosZGQ/OeRESqZWVBZsxWXRHZSwq1wP0DGNlv9q
         MSultBNAkpgtobWbFCB1CLgYD//sJD2YKjja6i6QrgKPrLFldrQQ/ahVbYVQJck6So
         +Q5O2RFRgs2X5fmu2h0oOKxuv//kpDHQ9Wp4RQSAe6w+z4254G68d45QivjC9yHy9C
         lKm3EvZ4mcncw==
Date:   Mon, 5 Jun 2023 13:10:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230605131034.3e795180@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uKTEPknx4lUkbJF81CqF8Lw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uKTEPknx4lUkbJF81CqF8Lw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

mm/memory.c:1705: warning: Excess function parameter 'mt' description in 'u=
nmap_vmas'

Introduced by commit

  c57d0b88196f ("mm: change do_vmi_align_munmap() side tree index")

--=20
Cheers,
Stephen Rothwell

--Sig_/uKTEPknx4lUkbJF81CqF8Lw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9UioACgkQAVBC80lX
0GyphQf/VmkgqdeCfXlHx5MzxV14H0yJi/CIpDPqdC1m3JkE4XKD/8W3vn0heYpS
p3ZbuEQKIkXG6uS2nSoQr8vfp/ghLIH4znfQGoEPtfL0UOqezXTsFLluulFb2nHq
OW/7nngaOG1LRLFzeheQSX4refaXYQWY9ig5wPKuI3bQG1NTZm5oVm52BZRF/oJX
DQ2RaUbyk8lhslEAbF7sR+A8xGXBQFRdR31cjrcWUsV7POS43Mld0ELe7Pm4wPUP
+Q0Tr0w5shhUmmnqvDGSVW/4xv8zREXS9lAYKwLGmcN+D3tkK9rTKccLwdIU9CWg
Y/GjsY/DaDxQ4vFklGeEqJDzKtPRGQ==
=9hZJ
-----END PGP SIGNATURE-----

--Sig_/uKTEPknx4lUkbJF81CqF8Lw--
