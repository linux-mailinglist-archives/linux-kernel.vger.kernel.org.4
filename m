Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C996201A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiKGWAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiKGWA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:00:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C5D73;
        Mon,  7 Nov 2022 14:00:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5lXQ52X3z4x1G;
        Tue,  8 Nov 2022 09:00:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667858422;
        bh=TlPAsMsF2PF1wwx/+sxBPe7+SbL9yB2Jav3Ljb06x0Q=;
        h=Date:From:To:Cc:Subject:From;
        b=KcEJ+qEF6E1obXgclUloWzVQJtuUTaZvO6UTATx/f9vSvtryvt4uidhhA9VAUAJKG
         7l5N6vrSXzzkKPLOPszRHNWs4n+UseuRAxCOyr2NR2pCFe3y5RAG6gXYldjVwbiZlO
         oE5cetP6mWU6ooTUVe1EKQszSrePU/qgGMqSa/gAPVXCONBmAhLpJnbE1lv+9DsZaY
         d5JRq+At82cJ8ii7gxZ0j1wsOWcyh925016zo32onkVtGIBKUA7B9OEH+r8dNM1YKq
         F6MRUfFneMFYYG147mHrVJ2aOP4QoC5J0DlFp39jKLYI9ttOYzBcpZbHdY1DvkRyf2
         GA5rDr1RnuE8g==
Date:   Tue, 8 Nov 2022 09:00:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Matti =?UTF-8?B?TGVodGltw6Rr?= =?UTF-8?B?aQ==?= 
        <matti.lehtimaki@gmail.com>, Rayyan Ansari <rayyan@ansari.sh>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the qcom tree
Message-ID: <20221108090018.44624610@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_fGDSTkbUX.xu8hWqGNsyh6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_fGDSTkbUX.xu8hWqGNsyh6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the qcom tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/boot/dts/qcom-msm8226.dtsi:302.21-327.5: ERROR (phandle_references=
): /soc/cci@fda0c000: Reference to non-existent node or label "mmcc"

Caused by commit

  4ab2f41b0850 ("ARM: dts: qcom: msm8226: Add CCI bus")

I have used the qcom tree from next-20221107 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/_fGDSTkbUX.xu8hWqGNsyh6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNpf/IACgkQAVBC80lX
0GxOiwf9HG886A5Q+7Qu8M/eBNRlr9Z6xYdDSTfJZrlJtONEBI2Mw3vL/IPiM7Ln
rnUd/OjauoAM5xNw1ooLKvr3X17GtWU9J+Z7dQlEUp3J0uRUH1JJAN/B+nVIcNgz
tU/L7y7Ee07aUkXILvwTPOJBtN+lU9dLnHY6v2DzIvojq91+Oot9f5AVELRXK3Gu
ZmyfnBqzRfUQkygyV64UawdE+bGLgDLn7y2I1Dpsvx9+aHEPnGwa6Z5F1XMghalZ
Cl5O5uYxyYcrsGSARDf9QLzoUtqPK7kjvSGhlrrWzLe7e4ajqr7Pp9GRLYEoqZkv
bZb1PqcsAM/nCagJqoSPgcsQ22pWMQ==
=Zlxn
-----END PGP SIGNATURE-----

--Sig_/_fGDSTkbUX.xu8hWqGNsyh6--
