Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA668B1CB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 22:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBEVJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 16:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEVJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 16:09:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D9E3B5;
        Sun,  5 Feb 2023 13:09:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P927j4q91z4xP9;
        Mon,  6 Feb 2023 08:09:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675631345;
        bh=gzv7BUsqb+iqyfn1FZUDeB/KqUoFa0v4EsNMoW9YcAg=;
        h=Date:From:To:Cc:Subject:From;
        b=RGSFId1UHSMYQNaiZZFDnNm/F87HcaQEmxEcAy1SG2oTuK9YA8q9aoEhYl6ohpQtW
         9ueuGrESc8nW2w2PIPAOxmL3d71GRZKmbD1U+aivG2hetqw1DCWqPF6VtL/qciQLkr
         umSyOcg9y9mp4qH13+w/bVw7BDF9OPr6wb/LZ7ZIl1YuUxDG/GfAUmgNfuQW9FO/dI
         ttHCWRpmI3s3WDVZiw7tjbneU/uuft38j04O8ebR7zpC++baoBqayCurvoFjK9M5No
         P69AqQ+bq39YkHY0u4LxqJzfZbXPxQdoCVrDGFIT3HKjroMovyg9kcBbP84jdVKr6F
         Sd97YhlRXZ3nw==
Date:   Mon, 6 Feb 2023 08:09:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20230206080904.4de83254@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LbqtGm=EbSzIzZn0cuA/JXt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LbqtGm=EbSzIzZn0cuA/JXt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  19eee67386fe ("arm64: dts: qcom: sc8280xp: add p1 register blocks to DP n=
odes")

Fixes tag

  Fixes: 6f299ae7f96d ("arm64: dts: qcom: sc8280xp: add p1 register blocks =
to DP nodes")

has these problem(s):

  - Target SHA1 does not exist and the Fixes commit description is the
  same as the fixing commit description.

--=20
Cheers,
Stephen Rothwell

--Sig_/LbqtGm=EbSzIzZn0cuA/JXt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgGvEACgkQAVBC80lX
0Gx5/Qf/Snb6eG+vVdD1XPcRnjtMog0sJxzfLInC5taZcjV5GTxFAUFAqqfrsyX9
CdPA0+Lf2CKRZUhc8mqWRikqH7h5oUxO9mTPsSmjZ0bss5JAPG6ntLo4QZ9uEkyS
LPxeH5uJe9iCxKCmjecg8DCje7tvzeEztGWw9aAvWN3Zjm6VlYaTv2SDLBgVhbez
YyTYa7Vb5DfgCRrBr2GBSJVXz3MPMBozi3YetG7j6qm8jxataA1Dg+EyIG/gKroS
tRUHimtqpV6yhs0zSkgiw+psi+v+bcDmvt92TtQ9FAd0oB2QYsjW70us6IZca0a4
XQcgUZ4mQ0jkC9FpsAeeTXSx5PcXTw==
=mWXJ
-----END PGP SIGNATURE-----

--Sig_/LbqtGm=EbSzIzZn0cuA/JXt--
