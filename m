Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A6C5F9733
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJJDlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJJDln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:41:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23AB27CD4;
        Sun,  9 Oct 2022 20:41:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mm4TW5MzXz4x1D;
        Mon, 10 Oct 2022 14:41:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665373295;
        bh=FQMj3mxoK78PV/RZb+hvIJ3Rd0CZPWOj7mzGsZt+wu0=;
        h=Date:From:To:Cc:Subject:From;
        b=Ff3bPdWNo6KuaIGKAtFHpImOIYEi6UeAlQ6WKo/3+rDcg8fBMYmU0femxoGYWnx8w
         dDjtJ0GoWUgCHraf6A1vab7gNADCE7dft0uvP+j/UQdpwIA9DNgrKBN/6a/xI4MmjQ
         qYA0MFvmFp4BMq2YBmMHYDI1PXZlWHi4AqX3/qiVYm6VizBrvcBPq0kMcKnAAKcDoE
         Xwp6X0nQ1CujWm5RP+cYIeXoHXuJCd+dk57sknPe2OfEFa3f+S5n61EeBGMdejmf5L
         TJsqk3VSu9MB5RBZX7U/5WHinxMQu3+YbgqiqZBdhPp+5Twn6efgbM4i0lUX4jsxLi
         WHWsbIjMlw3uw==
Date:   Mon, 10 Oct 2022 14:41:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning
Message-ID: <20221010144134.1a806e7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fi_R9K2z1Xg2PMnhMLw3alu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fi_R9K2z1Xg2PMnhMLw3alu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

My linux-next builds have started producing these warnings:

ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
ld: warning: vmlinux has a LOAD segment with RWX permissions

I assume that these turned up now because I upgraded my binutils to 2.39
but I have no idea what the root cause is.

--=20
Cheers,
Stephen Rothwell

--Sig_/fi_R9K2z1Xg2PMnhMLw3alu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNDlG4ACgkQAVBC80lX
0GzXCQf+MtWVG+WJx1y34/HhdCIXD1uFeyPeYTPUrE/yD5ngU53EoCaR0XtNQB8u
e1AsWtvnNxNwudWvNc91XoCsA60UNnbtUmtNxuZfd33oB4vDds3msWVK4PRR/3pL
cUhPOL+dizJxF2MP6smBDwa5GN1Waj7p2iDXCpevuJPY0IaLNU2kas2AEd6v8mmo
czCSSnhMIqz8M1oiDTq+Pp6I4aaiPkxADCEnPGAs5WhH5zlnM5JkI5niuy6weKop
310ZhtWdMZUJVicOTSK0zfNYk1oT+bzEP0EcBlGmu4twVsyydnJX490pdb54Z5NB
hRwlgqfQ5ovBu2aKgQ36Dg2qQFDNwA==
=k8dp
-----END PGP SIGNATURE-----

--Sig_/fi_R9K2z1Xg2PMnhMLw3alu--
