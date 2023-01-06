Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099B565F82F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjAFAfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjAFAfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:35:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD551304;
        Thu,  5 Jan 2023 16:35:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Np49p4pZJz4xHV;
        Fri,  6 Jan 2023 11:35:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672965310;
        bh=QsNb/dZSl0i/GsaVdWZJ0dRUuCpM7s2aweu/6a6ssAs=;
        h=Date:From:To:Cc:Subject:From;
        b=krkcu8KJPbnR7HmQ8lO1K+j+2+f5NtCCEJI6k76fH02wgKn9JMcyVse9xlLlDieU3
         7JS3nszI9vnbjRVsI7OpYod8qSSmNYPg934CI2IPWFd2rsSDTXjfaSZ4O+99P1TCPl
         h1+xl43NVF7Gi6nNVHB6muRRy6C6VMgksZC/yYcDvbyITuBDS9m8XJkIrNTQ8L1uIU
         AxjqzHUD1jqUuCD0QXMp41QMRe1BvytrVQpR4bTrsRmxfRRaGJZTfAS79ux/p1VVtF
         Fprgjjj2SAf5ztJbt0Ya9/XFHEFI0oZtYsA4UskE3A4Wu5teWVpQLxk7Qg9L14PKFI
         Dbhky9qrc3tZQ==
Date:   Fri, 6 Jan 2023 11:35:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the backlight tree
Message-ID: <20230106113509.5c101b53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rc4wOj2XaBsdv9.Y9yMiBYY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Rc4wOj2XaBsdv9.Y9yMiBYY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the backlight-fixes tree as different
commits (but the same patches):

  44bbdb7e3a67 ("backlight: ktd253: Switch to use dev_err_probe() helper")
  c0e09423bbb4 ("dt-bindings: backlight: qcom-wled: Add PMI8950 compatible")
  73516cbcf8d9 ("backlight: pwm_bl: Drop support for legacy PWM probing")

Forgot to push out an updated backlight-fixes tree?

--=20
Cheers,
Stephen Rothwell

--Sig_/Rc4wOj2XaBsdv9.Y9yMiBYY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO3bL0ACgkQAVBC80lX
0GwEKwgAj2Z2W1uPI0BvHJuIFekuQ7+FbcBstqf1XmKERZPWQRxJZ29tsNChK0Ql
xvXYAatulbJwNVPQe90SquCyWNVDQdiQ7GAipx6wzXz3ijBhukJNWOx4RNebCs/z
eGtv8wYhvSaJxLq875n0Cz2Y1jpbUFmUcFyi23h04qOMd8NF38czlhA2pP8o0YNW
WdvfiwNnZ+ogUT9LdO7d8fiT22uHH2UU56DsbfEPkIh9aeu+H1cmvEpBmtMPhJFC
2HzaBmk46lpZP/nDAn2V7KKx/jfyIPAzHgBN69A+au1FUZtrRMisTYCxveHus+1h
JlR5BjTy1jHQPFYyA81CEqWSHZPDgw==
=PEt6
-----END PGP SIGNATURE-----

--Sig_/Rc4wOj2XaBsdv9.Y9yMiBYY--
