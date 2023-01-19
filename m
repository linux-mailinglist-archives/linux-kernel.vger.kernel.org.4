Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574B67453F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjASVxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjASVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:53:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECF2AEDB8;
        Thu, 19 Jan 2023 13:34:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NybVh4Sdzz4xwp;
        Fri, 20 Jan 2023 08:34:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674164060;
        bh=04p20k6x+zOHD5csIvRkYgr9m4XP4xceFZWPkOVjwHE=;
        h=Date:From:To:Cc:Subject:From;
        b=eltusKszsrKu4Fx2cTzMHVxORZt4RF+4DmlB+b7u/u+LqzBoPjHoJ5yVZv9I2eN4r
         hxdRmOMxWbn56fhIIg+WSUeA0jMcqbSPapgiFCIneyIH4YWHLI4ks01dU4/1all3YE
         EVUvuvJ3qJGBsi8LXXk6EMzkWDBOnZ1k8zUrS+zqCB4S74JJep/5gXAFGwKigDktyF
         j4Ba1zNaf5mkiJmFF5oeJVo2uaWR3LxE1jk37++FPBDPBSPQhdF3nWRl+ZvEquKDUt
         9xdJqGrte6cKz8iz3Vnv/uQR5svEiUY1h+4ivSIR1xXsrLOu09tdaFLTuv07aX6f5Q
         V0PvIWR67WgnQ==
Date:   Fri, 20 Jan 2023 08:34:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jakob Koschel <jkl820.git@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the jc_docs tree
Message-ID: <20230120083419.1fff9149@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H9ZMt6mqee.EXXLyOER8Cx2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H9ZMt6mqee.EXXLyOER8Cx2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6b25b190a9a3 ("docs/scripts/gdb: add necessary make scripts_gdb step")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/H9ZMt6mqee.EXXLyOER8Cx2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJt1sACgkQAVBC80lX
0Gz2mAf+NRyxKWbCLtl9QxIdlOVPFE1nmPvGAtE0TlV9OWM3zssYoJ3tQglWLZ31
MS06iBE9y/QP2x13esV2NSyXRhpI6G3BfUbjEVrO8yDdPAa9HJ5QoOov7ZBOHzzP
ZEgZUYXi7Ctj2dyLKT1sDhmP4mgw4tMlInyfVdUNYwlQrxMzMiJzEl2AQ+ge+BjC
kTEjjc6lgLh679nasX3bdAueShE7croW7liHfFOsKfY25VkZllWnavQoX4HT8Xey
VebIJVXUd1Gwqf2LLm0uwwocD3VB9eXODDks9I0gWETadZekkmQLGztidDrF3Vbq
ex59mmBe5zjZkfVavWa0t4w/2m2JJg==
=sHlf
-----END PGP SIGNATURE-----

--Sig_/H9ZMt6mqee.EXXLyOER8Cx2--
