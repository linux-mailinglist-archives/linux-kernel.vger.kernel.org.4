Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F776F1F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbjD1Uka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbjD1Uk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F63AB2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FFA61900
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 20:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5354C433D2;
        Fri, 28 Apr 2023 20:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682714401;
        bh=kRkwhFw9tUt9pvZtFhcCkpceLR2nAirWUbPFJXxQbJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4dI+QfqK3Jv6oLxF4ejC13xXL1fgemqhUJA52PReaBILgKz5eLEsm7K+fW3PibgS
         UJADqsAMZe05FvsqIWbhb5swXeFKOE2zkMrPVYRc0J9aBCyGIkRZWFCZkqg01Qk70N
         nP3YpsPZwgZXkD39QL+OS5aTzt0Om/wn84ySqSzUekF2pvFZRT1PFe7p4JMmOik0Eg
         VIXnzVQAnhSoiNWs9uyAcQV8iYKP5YMqRK/KUNsHecgj7xK3mkvbkLnN69mUEkrZmX
         mYEXU3K8jXyEjdVmLA4zX8SKdE2uYI3RMB4b/X3SktdpzKyM9VwaPbEK2zqpVs+cvv
         pA1b9Z00lMvvA==
Date:   Fri, 28 Apr 2023 21:39:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes 1/2] riscv: Fix huge_ptep_set_wrprotect when PTE
 is a NAPOT
Message-ID: <20230428-shriek-thyself-72c092b26834@spud>
References: <20230428120120.21620-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fGjaU7WWIijtn1nI"
Content-Disposition: inline
In-Reply-To: <20230428120120.21620-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fGjaU7WWIijtn1nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 02:01:19PM +0200, Alexandre Ghiti wrote:
> We need to avoid inconsistencies across the PTEs that form a NAPOT
> region, so when we write protect such a region, we should clear and flush
> all the PTEs to make sure that any of those PTEs is not cached which would
> result in such inconsistencies (arm64 does the same).
>=20
> Fixes: f2aeb0118ddd ("riscv: mm: support Svnapot in hugetlb page")

For both patches I get:
Commit: 0146c955ff59 ("riscv: Fix huge_ptep_set_wrprotect when PTE is a NAP=
OT")
	Fixes tag: Fixes: f2aeb0118ddd ("riscv: mm: support Svnapot in hugetlb pag=
e")
	Has these problem(s):
		- Target SHA1 does not exist

This particular one is 82a1a1f3bfb6 in riscv/for-next.

Cheers,
Conor.

--fGjaU7WWIijtn1nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEwvHQAKCRB4tDGHoIJi
0oIYAQDf7qmbUTaa1HnSmVfONfqLSCzj+CzQkZfHpn01h+Kb/wD+NpXUXVSHkCin
5fZlaVwD9P+kj3OpuLKWYyg/4xPAKAg=
=eSUs
-----END PGP SIGNATURE-----

--fGjaU7WWIijtn1nI--
