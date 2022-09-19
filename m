Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038F65BD6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiISWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiISWEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:04:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA621D0;
        Mon, 19 Sep 2022 15:04:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWdxj3BQ5z4xGC;
        Tue, 20 Sep 2022 08:04:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663625066;
        bh=Wmeah96pU6QyJLP44bwQ43l9G2pSQWtlT47Qh4PRDqA=;
        h=Date:From:To:Cc:Subject:From;
        b=aUHvDr1CClwAUF8uzwqVLcSHhqfJ4dGdv9AAmqLwAp1CBnvpj1tSJqTIuVk6HPRfu
         KaVdGwaClNaNBoiUGOLDKzROZfdWPcb9AuiY9GnxBkgcrRbCZwEsYrYZIZshsQuAii
         lMMc+WASpGma65zeBB67Eh8XSj8QH8sbGYWV4VSY+c4TNr0InP1/WVCrF9ohzszDcX
         fmOOxbxC3jXEjzxnwdYJy2xCU0+HTn7Ccw+1l+T2UBgEsYbApQRfzUeiov3fS95VQa
         xvvUEWyKP5c0TpJMjWNTVIseFu15OpvmOEhWmPV4Gdpiz/P9N6ENlhHW/KeXVDr1UB
         GrgVJk6TKjRoQ==
Date:   Tue, 20 Sep 2022 04:13:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Lin Yujun <linyujun809@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mips tree
Message-ID: <20220920041309.5edf2451@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//cxmJ4nPUHyqle5APy+B+Nl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//cxmJ4nPUHyqle5APy+B+Nl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1e6d11fe72e3 ("MIPS: SGI-IP30: Fix platform-device leak in bridge_platfor=
m_create()")

Fixes tag

  Fixes: fd27234f24ae ("MIPS: add support for SGI Octane (IP30)")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

So

Fixes: fd27234f24ae ("MIPS: SGI-IP30: Free some unused memory")

or

Fixes: 7505576d1c1a ("MIPS: add support for SGI Octane (IP30)")

--=20
Cheers,
Stephen Rothwell

--Sig_//cxmJ4nPUHyqle5APy+B+Nl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMosTYACgkQAVBC80lX
0Gxibgf+OBsN/kVzgCM368OvEYJpqcvsde57oil11wE64fzfMoUodCx+0J6iSA2Q
JVJCjFzjccnI1tv8PHi9SGLhK07Zg+Jiinu4IseRHUmkF3/OUWa2lHc/NvSogGU8
aA2bI0WuoX/iYfTSFrHatXOK4NEntUBYNRyBP9gf67JNLk7s6nCzwSfE8ync/BZo
49RqfMTqT7xyOd3gDvIL/jlDOm/BEWHkpEjeSHt/JFBAcSMTRO/ljMdI18RvRHl2
Fxxr3rD7RMnDJoI3FSyRUp4DFNsl0UDmTnDJJDf82ypKMSDHlzUHLQzpybNLnF6V
TA3ntFnOAJR67oeRhfb1BKLEAZIQlg==
=8jfI
-----END PGP SIGNATURE-----

--Sig_//cxmJ4nPUHyqle5APy+B+Nl--
