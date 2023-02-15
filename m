Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C721C6974F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjBODlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBODlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:41:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7962ED57;
        Tue, 14 Feb 2023 19:41:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGkQ65tdwz4x4q;
        Wed, 15 Feb 2023 14:41:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676432479;
        bh=k8bQIlv+dIeD8317OywvR5RAFvo7vhUtDJ5GcTK4s90=;
        h=Date:From:To:Cc:Subject:From;
        b=VcLQg21OEYMatHvDab6Buz06h4b9xnOeIF13D0C6OgghJMU63I1tw6REZvTPuzApp
         cPbujuOWKB+omihNUa11YSQLcwT5ma9JrQsEZgMZORdfkmVefxglQ/SaVRK5cTyk3w
         0jdY3nqYg11y8fGHYzNGWGWsy+cbQgOwnUnJApk5oAPsUlY1OZydNOG83aVoyQNtB9
         pMUJ1u3XpS34nA4K7fZyGgyBh/QTOCBy0qPGhVoDQXt+vur12ZmkkJmeAoJr3oVoRF
         kJTIxXSIprBQi/lbdKPo5+KRUvrqouqS76TPyh65NxCjaM5M+lvTDreWn2Klvdtv8/
         cWRS5TI/PV/CQ==
Date:   Wed, 15 Feb 2023 14:41:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning in Linus' tree
Message-ID: <20230215144117.369ffb5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UeZYp2ikCd+EDIzbtdDj.6+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UeZYp2ikCd+EDIzbtdDj.6+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Building Linus' tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/admin-guide/hw-vuln/cross-thread-rsb.rst:92: ERROR: Unexpecte=
d indentation.

Introduced by commit

  493a2c2d23ca ("Documentation/hw-vuln: Add documentation for Cross-Thread =
Return Predictions")

--=20
Cheers,
Stephen Rothwell

--Sig_/UeZYp2ikCd+EDIzbtdDj.6+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPsVF0ACgkQAVBC80lX
0GxYyQf/d8P4Gv2FR1DBZ+JBjgY44w9ZeiUjw0wAIGDOpBbpl8f1JbmQ6b1zEKXK
dMIKJH9xEpSn9PgIKHzRHawgKcFRP403YbMXr64dJvRS00IIMKFpCSguaikSC9lz
PLOrOzvfrH0D5AjYAm9l/HWOHR145JkcMpuUYdKdZpIXoY/jWKlKIay4vAyQ27af
cj2hEY/8T8MDRx0+kAbTKnunr+GPtjySP70c9kwb/n/lwg7hLCGHZBFA5xTxwkop
YClrZ1h/1S3ZLdWcNrg52Nj/FgKnUS39b5A2VPk5krPTQqX2IyjdlNPCiYr2Vqhb
pEJWzig2PjcnxGunXp2RfvMuNxglJQ==
=P87i
-----END PGP SIGNATURE-----

--Sig_/UeZYp2ikCd+EDIzbtdDj.6+--
