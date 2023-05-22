Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB60870B5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjEVHJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjEVHJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:09:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0062BE60;
        Mon, 22 May 2023 00:07:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QPpRY3WzBz4x1N;
        Mon, 22 May 2023 17:07:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684739241;
        bh=9AAupwg6CnHq31ddZPI88CZCwhSmdjwofpazJabS+Vc=;
        h=Date:From:To:Cc:Subject:From;
        b=S+tCR0PRWJQWrdRBqUskUGQzG0BuaajnI74uBZzfseJc++nE2umZPMD4iNIwE46RM
         jCv/3qzU6/9hp1pUhFUJleyqPXTCR2P3MRK1faxlZckZ3YPCOG57WItjUcU95IcDfD
         TwtnjC3KCuw3kmiMg7vKwioBhoYscS9Tj4OS6Imk5yIMPke+/m86fVosA6UVRypKf0
         rak3XPdgvpPZoQtyrozZ0pWTUlKgvHt4k9k44Q03CaWzMEWYRQeea9lKI7nXPu023O
         vI1p/W422oZJOcfm2twLBq5bhGXccQGffM0W9N+TDJY1FCwyeVF8u8cAVEkNdG+VCl
         ZidW4UV0yYEfA==
Date:   Mon, 22 May 2023 17:07:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Reviewed-by: Arnaud Vrac" <rawoul@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-msm-lumag tree
Message-ID: <20230522170720.23ef6adc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vPOZ=SH6JbghCGNloRqJk_W";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vPOZ=SH6JbghCGNloRqJk_W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-msm-lumag tree, today's linux-next build (x86_64
allmodconfig clang-17) failed like this:

(in function _dpu_kms_initialize_hdmi):
drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:647:28: error: variable 'i' is unin=
itialized when used here [-Werror,-Wuninitialized]

Caused by commit

  ea767bb1752f ("drm/msm/dpu: add HDMI output support")

Reported by the kernelci.org bot

--=20
Cheers,
Stephen Rothwell

--Sig_/vPOZ=SH6JbghCGNloRqJk_W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRrFKgACgkQAVBC80lX
0GzZwAf+LI3L5IirdWBUoZTl8xiKrFcw55jIOWf9xLrv/sLNGWEjXciWFnnQkHqO
29FQif4nU8NDt1PggSC7r/vjGBg29A4XfC8HgecztqdBlrP3FI6lkEbe2j+9Dlr6
KKyQbZaGzXEtI0oRsxDlHtjno0gdF+ZwBjZN+EBlM3WUl3M6Tol9x1Tk4Kvvb/QJ
Lgi41aJiQrPUtLzl4l+Vx5BOabyBWgVePU+TTqsC4SvyNg629Kkx5sbgq7SAp+Ul
7X3pi99K7NmTVeZfDQtlAj2MBF4nI9f5GKhqaOmSZiTIAdIntOWgr3C534GkZhoN
oCsIBvaxvmB88vfF27oGA/Ir2/mhiw==
=zFg9
-----END PGP SIGNATURE-----

--Sig_/vPOZ=SH6JbghCGNloRqJk_W--
