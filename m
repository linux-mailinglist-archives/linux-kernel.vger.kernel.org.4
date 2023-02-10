Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3107B69179C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBJEim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJEij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:38:39 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58783A59C;
        Thu,  9 Feb 2023 20:38:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PCgwW65vyz4xwy;
        Fri, 10 Feb 2023 15:38:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676003916;
        bh=ToT9uDC/VpKryulLh0oyQPGvdZ/SNUC+D4CwHsEY4PY=;
        h=Date:From:To:Cc:Subject:From;
        b=hYSOmmiUbXRk4fmNe9DMu8SsaBCwJtAoCECYOITHsCcUfQ08jEWDdx+GcY8N1pu81
         tjH08NO18COto6cW3cuLGN6X/Ew3DPW3Fo2KgRvDHTdWF9ULynsMM8crMa9cRdtR6z
         tEojsNr1/QzcewjapnM/aILn/gBcvJtYFq9Df03toE/taLU2PU897Q4yLNOMMNBUgJ
         5nmyMJvz1ISEWSYP6HZmTTVaQaOlOT6gvFUuRlRieIelhPmQHNBuJkm8HcKArd9KiJ
         ct2IGcS7YYB0wTe9edYmRiv2ng4xlCCjEM+i7VprsrUKjyEtiVgXGjNTHILtFTyuXF
         IOBkbFE1Qsn+A==
Date:   Fri, 10 Feb 2023 15:38:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20230210153834.0452f24d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y8CWY2NETcgZF82BgWOQxQ9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y8CWY2NETcgZF82BgWOQxQ9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  da006a8c9352 ("dmaengine: dw-edma: Use non-atomic io-64 methods")
  e3042508ac7c ("dmaengine: dw-edma: Fix readq_ch() return value truncation=
")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Y8CWY2NETcgZF82BgWOQxQ9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPlykoACgkQAVBC80lX
0GzNiQgAhs1Z2vKJqZzPk1Q7mI7Il+7MR3WwwkNReXwF/JyCK19o4P4d3HoXRe1U
dgg4jOvHIVvGJLes8ve/m0iSi3UKQwBTVIehXmIR65tvjM7kjP6Ieca3NDulAcIF
J9EOO3XkB2wEywqVWbanz/0b14xIZX4WSh7T6bCn3xqk3BXZjNZ4izDt4MO0AtEe
rXk+MEYnNbb5EPK0LtzPw0PWy5VVBTKKUiK6iOHW8XQVHnrcoZ3DdDhD8l+cNBlo
fqUqDVJHySSULToUMJL2+uuAYyJMpdJAcczlTZ3AQ6xhDKk1Jx6oCM3daL4D9CmV
hA2LC3odEnhXWpOah2KJQX7fTUzr1g==
=/OmD
-----END PGP SIGNATURE-----

--Sig_/Y8CWY2NETcgZF82BgWOQxQ9--
