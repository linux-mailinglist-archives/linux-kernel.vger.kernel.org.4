Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC6708B59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjERWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjERWPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:15:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D258121;
        Thu, 18 May 2023 15:15:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QMkms5f31z4whk;
        Fri, 19 May 2023 08:15:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684448110;
        bh=JF26jiMZvmHyIjw6Qtc9tIKeL2esaj8G8bzCC1cRzpU=;
        h=Date:From:To:Cc:Subject:From;
        b=tA1vehgefZfIm2TrR9Sg+LTT5xvBv0FxX1fODfT+OqVHt3p9+orpa14Vg2O7vzmPH
         e9uyC9cqC6qI4149gwC1H4WgGXI4AbAqr2PbSnu7tuAoVdI0tbT2dQzJ979vSnWTSm
         ZZREbTVUcxCp87AWZFgfBVDcOe6Hd5Ptp6u3j+ajQYwH2v2t7wqPCXVSKgMAARCi+v
         m0TVFXgIndQLD5RQaDqAQGGW/qiBIC3lWWWaUc8krkPopNlS/5rVaeSaDbXnl1eJZi
         baYHSC0avlZy2dc18deesQJeMGV6ZgP4SoNKXMDx6F4GdqPizQa5FTex7evmM/+olg
         87AU7QsXGjYzQ==
Date:   Fri, 19 May 2023 08:14:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Zhen Ni <zhen.ni@easystack.cn>, Corey Minyard <minyard@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ipmi tree
Message-ID: <20230519081456.0dcb82fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IkkOGqHNB5N=_3l.XMUP60Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IkkOGqHNB5N=_3l.XMUP60Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7ab1f268ced2 ("ipmi_watchdog: Fix read syscall not responding to signals =
during sleep")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/IkkOGqHNB5N=_3l.XMUP60Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRmo2AACgkQAVBC80lX
0GwqRQf9HERCpkKh4aytp/u2Bi5xvSOL/6u7S01kuhPpMTEiwBwMdHxnIMx+A2VR
UuNp/nPIiRrdhdVzcQXtt6NGy70s7Y1Q5GAgllR3k3Lr/2ESoIsPcgfWjdVqDmT7
vuLUCgwlpdPUcUs+q0DEoXPUJSoxx58bk3+UGXvQeJyg0EFST9UFb5N3YsfuWKcr
4GyBlXtzIrRzRt3Nlv5o2dGG70UZ3/66UM8akljq472gy7LkuzbYAIfxd8nscKN6
2qt54toxBRqOexehGVjyEfi4GU6E/mAgypCCW/QnZjXxPUAWSwo1WPiLK/ERF/gT
iUZwTmQp1BA2C9LKzh5fBzGbm4SYqw==
=McK/
-----END PGP SIGNATURE-----

--Sig_/IkkOGqHNB5N=_3l.XMUP60Z--
