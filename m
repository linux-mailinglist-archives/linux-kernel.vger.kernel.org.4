Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE66F9D26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjEHA7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHA7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:59:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FADD100C1;
        Sun,  7 May 2023 17:59:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF2xC00DSz4x1N;
        Mon,  8 May 2023 10:59:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683507551;
        bh=lzbZ5YT+gAhtC2fJBCljtSJEOmox2BKf9kEv4iv+sl4=;
        h=Date:From:To:Cc:Subject:From;
        b=SW+7LRltCXZOnACow5YtOC09h5iQSXM7GvUHBqltYYUfjEJdzSYkUBgvOQv/oiuT7
         GhjET8GPQwnCp22W6QaF75Ru8EjCqom0AKLjTgncAMIKmMP9ZKfTHYemTDIDmPGNAO
         cN+20AmtfHOrZOe0tix963k2Jt2ZqdK4tS1EI07bTKFH9Y5qwzGPaN8nkYeqannlY/
         812TVwAkRbn0l9E02DRzNq8QeiN7+7mX18jzByQHRAlFfasTgANqZlOhxgKKxa2zs1
         EEClJqqF1k+9Oe6eW++L8NPP/KoZgDOylGC9cgwYXQIoQY0FVGIMJP/ESdeW/vyZIM
         GRKx58XIiXwyw==
Date:   Mon, 8 May 2023 10:59:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the rpmsg tree
Message-ID: <20230508105909.6406d9fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KhYqbg/mtjPR4baEev0vYDL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KhYqbg/mtjPR4baEev0vYDL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  62efe3ed777c ("rpmsg: glink: Wait for intent, not just request ack")
  cc888eb072b6 ("rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT")
  f187a431c494 ("rpmsg: glink: Propagate TX failures in intentless mode as =
well")

--=20
Cheers,
Stephen Rothwell

--Sig_/KhYqbg/mtjPR4baEev0vYDL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYSV4ACgkQAVBC80lX
0GxEnwf+MtdOx3IZ1Fhmi8kwkP7gHdwr0/AZHwBDScHRfWBZAD+fZL62atsg1j4m
SWOpsIW1oq8uIRhlAzMfEiF/xS6gbpJvJcCxOyktj12OE4RPBC6ADOaO0QPQO9DJ
1w4i0LATnTGejcj8JKSQZrJvaQjJF2ZuBjm8rOGOy2IiySxe+cQrP4knLJI2OiQy
XXnZHghhzVp7SZipVGVyC0BO7DfVDNAihGF0GLwQDc1RWc4ax53jwCOdL2su35Xf
vWgwqr5FJEqoyHtCOToYRj3yuENRTouBF9o3f77UEVbzTl2nb39mmcd3aHma+zPc
Awuk+MwbwI00REM+gSINp2tlSk3DtQ==
=qc1Z
-----END PGP SIGNATURE-----

--Sig_/KhYqbg/mtjPR4baEev0vYDL--
