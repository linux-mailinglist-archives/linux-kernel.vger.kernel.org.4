Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07306BDAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCPVaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCPVa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:30:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E343581;
        Thu, 16 Mar 2023 14:30:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pd0mB3VxYz4x8y;
        Fri, 17 Mar 2023 08:30:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679002218;
        bh=d7CZnlyHwzcaacv6olGZ1NTe9PfgfeOOBfqcODtWMFQ=;
        h=Date:From:To:Cc:Subject:From;
        b=dR6O14o1ynyWkuismUysLFvlYaQHlh2p5m0CvU9zpRujfR7aAhvLFOigeUkNz5yRA
         rBacaxMvOknCtxJu3pk6Lg9GQvdqgv0VbkP8XCzwMdmeCf2+8gTTCIGdq4VzpG7R91
         BaFjLDf0iIERohykiVEkVTpSIYrmSg45UoyXyrDpexsfwwuH9Gq6QzTRVxRhL5+W3f
         AkMPR37vTPNSHxXzayt0JFbG3PBigyPHy83y8DgfqrRvZ3BamVdkFQreV06TD5KA/S
         7RSbvCmrUyANeeyzVXVdDmitTSyLsow0xQv46SbZX+vF7ncfIzmnpIcfnc1+pgkIip
         qIjzeQNlHioEg==
Date:   Fri, 17 Mar 2023 08:30:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the efi-fixes tree
Message-ID: <20230317083003.1b8b0ffe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rSy/7q+Tn.tW2bQdCJX7lsc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rSy/7q+Tn.tW2bQdCJX7lsc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  261b4ba2d70c ("fixup! arm64: efi: Use SMBIOS processor version to key off=
 Ampere quirk")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/rSy/7q+Tn.tW2bQdCJX7lsc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQTilsACgkQAVBC80lX
0GwKsQgAjEJkmWImvmCAQYmHBlKnqbbkbbFXFYOURCMEr9tFrpFELwA5x8E8T3h/
MJXKdhIunmR6DjOZIDeS6IlSqDA/4GfRBEK87vKp3A7Jlzw2BfIDlI3GRmOP6CJr
dgZtoeKx0KgWbZ+WkO3sj/mr0CpW2j8TrQMv6X171ZEH3CVeMqFZvejyoTrWw/dW
5ZA2HiFHEb4kVzG1vapGMRU3MtmrJVeHMrhGO9C9KzMsnt0n54oKDDkZb+qq2arB
H6J7L8WDW6uMa5yQlxSfJoLAO5Y/3aLUANmBPF+FZlCXnnZk1ghu6I134qsS5iE6
vb/Mhk47cJCvFEcBypdjMf+zv7lNug==
=II9h
-----END PGP SIGNATURE-----

--Sig_/rSy/7q+Tn.tW2bQdCJX7lsc--
