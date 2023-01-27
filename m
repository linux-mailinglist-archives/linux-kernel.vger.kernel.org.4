Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091B967DA36
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjA0AIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjA0AIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:08:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76C4F872;
        Thu, 26 Jan 2023 16:08:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2ybQ5kWcz4xN1;
        Fri, 27 Jan 2023 11:08:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674778115;
        bh=/bX5AMfUVWqKnUOm2OnZehqp+a/+dvIdoG2O2L8XH9Q=;
        h=Date:From:To:Cc:Subject:From;
        b=PvOvkGhYNSOqaK6QqlqDZzq3Q7KInXq8oxUGF/QKQ4gdewUPEdimX+i1IsvAIvnjc
         8F7od8ka0hSteVZh6oPidQ+b78S/v8JkU5nlpxNjPRo2ygeqQwh++A+okpUJKU4l5e
         a8vRpyhQPWO+sO2pb/nAchMLgI5LC7jz5P8gdPuwE/lL+L8+uK6BSBGxhy3FCs3fiy
         jo30QWUcCokRpIr5fUl7ih1gs/geBqYHgEyBXWCR5KVQ+UIhKw8SMdh8NnV+ClUuNp
         xKu/8jwjREVeyUw6Bq4dZqEAWXvyEls5sPeMXiP33vu5yygEqSlzBYPiJ8BdORIj61
         uckADHUDYR/1g==
Date:   Fri, 27 Jan 2023 11:08:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the imx-mxs tree
Message-ID: <20230127110833.6cb7f4c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WAlN3HLhJ.BygoVK1mxeb+5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WAlN3HLhJ.BygoVK1mxeb+5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in arm-soc tree as a different commit
(but the same patch):

  b82765d04e37 ("ARM: multi_v7_defconfig: Enable wm896x audio CODECs")

This is commit

  74ab23d5a7fc ("ARM: multi_v7_defconfig: Enable wm896x audio CODECs")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/WAlN3HLhJ.BygoVK1mxeb+5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTFgIACgkQAVBC80lX
0Gwmiwf9GFedHPu7BgyAL+v0iTJOwTWdhdXUPshpCY23Imm0a8lyDRRf4YZc16L+
Rny/nblZ3rE+cYXrmS5QE4kkPByBcqs0Fm1xwGMzlitHxO3dHM1t8V4GCur+8rXk
bAvcDc//U0tdd0pYUiJsqltmTe4pS2YB1OtG4kJh8A6QTzZcIPl2XCAJQrnbOJDc
ZrFQVfPoV1YEwrVYnWvDOvq4hOoT+5GrGpcWbkWIqz63+aSy5qIWK+1b7++OE4V7
0chdKIhkq9dVqoEKhrEIWLBNpat0oHtqM8ST3wE+wAboJDwfU7TFgJR6rU0dESqq
izvzAvoP2BEG2YP5Jz/T0bUXjC7JeQ==
=SI1Z
-----END PGP SIGNATURE-----

--Sig_/WAlN3HLhJ.BygoVK1mxeb+5--
