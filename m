Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960163A081
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiK1EVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK1EUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:20:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729D9FDE;
        Sun, 27 Nov 2022 20:19:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NLC056gkfz4xG9;
        Mon, 28 Nov 2022 15:19:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669609142;
        bh=H0oBK7FCisXB7btwPM/HOT6CxyeXJHanPbSbd1866cs=;
        h=Date:From:To:Cc:Subject:From;
        b=qRLdWAhqOLx5JOKB7U0JC7CtoCpRYyZjJWRCAhFMGN8dWUipRwaA0IYfJU8ChPh48
         EdUvfGauB175Ir1MjeM98KJefXC3NaQIFrDfdSi/sU+4krIvSECDfUFEybwhXzNu3e
         8UeprO98/zm9CL4Nh/N4EsPWAyjOw5CEY6BsOy7ZzQUda4PGjQbL5uF5qTWhvncDNE
         kdUuDunfJd9kI7AWwRuio+fIhcyDlbnMjAKbn2PVK4pDj2wCU8g16h8uxXme2Ev09w
         g1QzA09SnECkCC7kkwhshkKP3jwlSS6G6k6x40lHWiNRFqYXcNgj/igJiP+UM5IiFf
         GjRIVAdzWgqHQ==
Date:   Mon, 28 Nov 2022 15:19:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Robert Schlabbach <robert_s@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the v4l-dvb-next tree
Message-ID: <20221128151900.5eb94a01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bch6x3wADM9GUP3yHwWko7j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bch6x3wADM9GUP3yHwWko7j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb-next tree, today's linux-next build (htmldocs)
produced these warnings:

include/uapi/linux/dvb/frontend.h:399: warning: Enum value 'QAM_1024' not d=
escribed in enum 'fe_modulation'
include/uapi/linux/dvb/frontend.h:399: warning: Enum value 'QAM_4096' not d=
escribed in enum 'fe_modulation'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-1-3
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-1-4
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-5-9
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-7-9
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-8-15
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-11-15
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-13-18
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-9-20
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-11-20
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-23-36
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-25-36
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-13-45
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-26-45
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-28-45
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-32-45
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-77-90
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-1-3
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-1-4
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-5-9
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-7-9
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-8-15
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-11-15
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-13-18
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-9-20
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-11-20
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-23-36
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-25-36
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-13-45
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-26-45
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-28-45
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-32-45
Documentation/output/frontend.h.rst:6: WARNING: undefined label: fec-77-90
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-8-l
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-16-l
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-32-l
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-64
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-64-l
Documentation/output/frontend.h.rst:6: WARNING: undefined label: qam-1024
Documentation/output/frontend.h.rst:6: WARNING: undefined label: qam-4096
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-8-l
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-16-l
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-32-l
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-64
Documentation/output/frontend.h.rst:6: WARNING: undefined label: apsk-64-l
Documentation/output/frontend.h.rst:6: WARNING: undefined label: guard-inte=
rval-1-64
Documentation/output/frontend.h.rst:6: WARNING: undefined label: guard-inte=
rval-1-64
Documentation/output/frontend.h.rst:6: WARNING: undefined label: rolloff-15
Documentation/output/frontend.h.rst:6: WARNING: undefined label: rolloff-10
Documentation/output/frontend.h.rst:6: WARNING: undefined label: rolloff-5
Documentation/output/frontend.h.rst:6: WARNING: undefined label: rolloff-15
Documentation/output/frontend.h.rst:6: WARNING: undefined label: rolloff-10
Documentation/output/frontend.h.rst:6: WARNING: undefined label: rolloff-5
Documentation/output/frontend.h.rst:6: WARNING: undefined label: sys-dvbc2
Documentation/output/frontend.h.rst:6: WARNING: undefined label: sys-dvbc2

Introduced by commit

  6508a50fe84f ("media: dvb: add DVB-C2 and DVB-S2X parameter values")

--=20
Cheers,
Stephen Rothwell

--Sig_/bch6x3wADM9GUP3yHwWko7j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOENrQACgkQAVBC80lX
0GzRWAf/QKKv5C3S0BMm4aDqEDk0QjO64jFFETkbLJJTYDHw4Re+WsNGvYYy9fNJ
3LFt+/deehrmphDkO/oJhM8Ba9WrDTny4ooQrEg2pF2jBgh2xdKdgSaAJhLSiSIK
6l3YUBy2MnNIHaoCVidYBWRqdVyZw5FjsudFk/8bT6Z3myBSgNXtjRlA2NbGOtSV
gGFimN5kFwxeXMYoSPJK9Z9fa1rh7vEv2ah05YbeOrTuqmarC3hJBzdeRl+TpPNR
PHx0ObjdjX/GX9CuJ9dFoqE78Un+CNGx3k9+kIQSti4rZ2jUAMe04dWfemkVsD5o
/F/fq2X57yE5G6W5PndYaV6UOO/ROg==
=hP+H
-----END PGP SIGNATURE-----

--Sig_/bch6x3wADM9GUP3yHwWko7j--
