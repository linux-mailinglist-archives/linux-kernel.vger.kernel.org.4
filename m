Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2895B81F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiINHXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiINHXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:23:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D54DB70;
        Wed, 14 Sep 2022 00:23:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MSBdg5NDdz4x1T;
        Wed, 14 Sep 2022 17:23:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663140216;
        bh=PuqeKAEOp4fOu0sMwEauEi1UeWSNBz356aK1LLvMod8=;
        h=Date:From:To:Cc:Subject:From;
        b=chJeCu/kVusOCTktV3zc5SwNHxMzazlMdLSqN3G8u3RDAwWPbA2+nWyNyVXCYHf1h
         rDg2itpuey3DRKsY5qPU6399nMWdyTdK32X6QQJ40/MoUK4XuZNWLtoNOPdAqsNCG4
         8zZRcLxle3/4AoKdiFxlfRcF+8TJ7z3Sb04LORwvpyF7ka+Og3iHbBRL+CbGrqPioJ
         EhE7/lrUZvB0C9zIwK/ucTebQALOtUnhbmNLMKGKrLNH1I93ZEhU+WRuH0pzD9/4we
         cz+aWJWrMAxHVWfHQbieljFJBJPkks+gRnbazl55JVFFjMS+ef5P33c9dRcddNTgu4
         D6VHF4zk+/cPw==
Date:   Wed, 14 Sep 2022 17:23:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Dang Huynh <danct12@riseup.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20220914172334.39b3730f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=gtO1y.DRmM/DhFDjfte1_P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=gtO1y.DRmM/DhFDjfte1_P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  50ee65dc512b ("clk: qcom: sm6115: Select QCOM_GDSC")

Fixes tag

  Fixes: cbe63bfdc54f ("clk: qcom: Add Global Clock controller (GCC)

has these problem(s):

  - Subject has leading but no trailing quotes

It should have been:

Fixes: cbe63bfdc54f ("clk: qcom: Add Global Clock controller (GCC) driver f=
or SM6115")

(no truncation or wrapping).

--=20
Cheers,
Stephen Rothwell

--Sig_/=gtO1y.DRmM/DhFDjfte1_P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMhgXYACgkQAVBC80lX
0Gw9RQf/XU48rdwqVb68RQfOLo7ADOOURDAiMdfPo4eHNWMJLVEA0RnwS5Q7GWuQ
mZG1yj85LUotaZ+XazSi76Wz4+XlQbSCvGOiUC1ybJ7xzqfW1ySAFf7SroZNdlvn
R64pYtJZrV0sDL17bmdmGv2ThTG5Cvrt3qMTnWeNayciW5QnoCZYwGFbEsGveHdP
04snwPDQm80Y2BWcH89BR/+zHgxAOFbZ5tRGPAH3pRGIb48/HJkJIsL3vR2C6ltP
N06cgYB6GO64peQ66dtWo4ObtG1c+HcWzWB6EemQAdWpO9iY3OTYhgnz9pEjSgcb
g7DFs8uz+B3nLsuYO3AFGPrP80p+jA==
=1Gii
-----END PGP SIGNATURE-----

--Sig_/=gtO1y.DRmM/DhFDjfte1_P--
