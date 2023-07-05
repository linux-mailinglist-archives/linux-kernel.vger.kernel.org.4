Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3374915C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjGEXKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjGEXKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:10:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD5171B;
        Wed,  5 Jul 2023 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688598628;
        bh=YVkuJPiWwtlS7KO/QL4Gwb8sXKsudGfh4JXCqcwYuto=;
        h=Date:From:To:Cc:Subject:From;
        b=NwsJ/fzJ7xs4RjczsP5GqR8reJMzegIwOQnb5bs4u9VCc4lmeAeNn58tH43ktXglY
         Gpr3Ze6SFWSK3oTDUpSnTfHYFF1l+cg3ZDPN2TUzYok+kKvs0Cgs6hPxE4QKt1Y3DL
         y4uNwr+ZGf2xGxQ1aj7NuiaLetBt91dNXeMcxfcRX7MUGSNBRA/Mjn6lp93d5NF71d
         0ORmehjY7tZReqofRQYgqKuS9gP1LJcODlkPs8F4W4+xVSh6jT2VNKYG9lgTkeNP+R
         Y9oP92PQbsqcATUggSqZs6G1lEDzb+pVytQpBSFKeWFiWGcuDTHI+0cM+UjWtwxgt+
         gjguWgAXO3cBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QxFkX1XPbz4wZw;
        Thu,  6 Jul 2023 09:10:27 +1000 (AEST)
Date:   Thu, 6 Jul 2023 09:10:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Valentin David <valentin.david@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bluetooth tree
Message-ID: <20230706091017.0bb8b233@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IFAn7M_HVqwehm4tJqfeSXW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IFAn7M_HVqwehm4tJqfeSXW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  10912d85b17a ("Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device")

is missing a Signed-off-by from its author.

Also, please separate the commit message tags from the rest of the
commit message with a blank line.

--=20
Cheers,
Stephen Rothwell

--Sig_/IFAn7M_HVqwehm4tJqfeSXW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSl+FoACgkQAVBC80lX
0Gy3vgf/XOYgBSQRRKuXz17jG5283vqsZwNr3xLozryrr1L0QaDoq/R8MIxf+KsW
NMmR0u14ecxWwrxNTnWH2spjgNfmycnABC7oLB40lq3pACvm1boFN/Lk4Zkb/JYg
dUbObgiGi0IN2XcACKXT8NKYPw5o2BW6X2XzCEFeoIyk4ezQLfnoM+ANcbVX/Fpv
EqX5v5+3A3UOF2U0/a4IAghJJfdo+VZuHWSW8rISQA7QJWDLq1FLsxRBVJHcFLeW
RGtJjReAeLCBL4VJRujTCjIcHaqSh5fN4y4RljLGFMXC2LB/AnxAM1LRS/YRQrsV
uxgdoxKXfb/7PvCCZ2pnbCj6mjO6iQ==
=icJG
-----END PGP SIGNATURE-----

--Sig_/IFAn7M_HVqwehm4tJqfeSXW--
