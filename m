Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66676805BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjA3FwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjA3Fv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:51:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFE71A4B8;
        Sun, 29 Jan 2023 21:51:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4y473C4hz4x2c;
        Mon, 30 Jan 2023 16:51:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675057911;
        bh=FaYRlLtyom6sGLZXfBU0cRcPV9pg/I/ONovwpTR2m80=;
        h=Date:From:To:Cc:Subject:From;
        b=C42774UiEENFt0Hl5AM9PX9c5E6gPL6P0fKZ7bgc5b2bbUZrCKMmBaHrk15Pu/BML
         ZXio38ouF0c8zFDMbPoNZykfuSahYK/d8Ynahu8rlHsA8viuZhMorgXqdxQptQsg1x
         K6nIHJSNzKVJR0ivc9TsyxGSh9poz48F6P7ejDVzV+cmrI/QYhibunHcVbx3wXBeuk
         1/90s+ClKJM/IxuYhMt6nLjQcpKVBn7FbMudoMP50V7PNctOMtUTg1xUy1G6EVVO2j
         /7EH2sAzHW+9WEQ69oIefb92LEWbo9T+/FGxBkUqwTFVu1YgRT+HUquV+c1CDEWaDu
         yRVrxqQ6Kcvvw==
Date:   Mon, 30 Jan 2023 16:51:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the ftrace tree
Message-ID: <20230130165149.7933efb1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aVSjTNY6PcKhiYOof4Hx0E5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aVSjTNY6PcKhiYOof4Hx0E5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ftrace tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/trace/histogram.rst:1969: ERROR: Unexpected indentation.
Documentation/trace/histogram.rst:1970: WARNING: Block quote ends without a=
 blank line; unexpected unindent.
Documentation/trace/histogram.rst:1982: WARNING: Block quote ends without a=
 blank line; unexpected unindent.
Documentation/trace/histogram.rst:2014: WARNING: Definition list ends witho=
ut a blank line; unexpected unindent.
Documentation/trace/histogram.rst:2016: ERROR: Unexpected indentation.
Documentation/trace/histogram.rst:2028: WARNING: Block quote ends without a=
 blank line; unexpected unindent.
Documentation/trace/histogram.rst:2030: ERROR: Unexpected indentation.
Documentation/trace/histogram.rst:2040: WARNING: Block quote ends without a=
 blank line; unexpected unindent.
Documentation/trace/histogram.rst:2042: ERROR: Unexpected indentation.
Documentation/trace/histogram.rst:2052: WARNING: Block quote ends without a=
 blank line; unexpected unindent.
Documentation/trace/histogram.rst:2055: ERROR: Unexpected indentation.
Documentation/trace/histogram.rst:2065: WARNING: Block quote ends without a=
 blank line; unexpected unindent.

Introduced by commit

  88238513bb26 ("tracing/histogram: Document variable stacktrace")

--=20
Cheers,
Stephen Rothwell

--Sig_/aVSjTNY6PcKhiYOof4Hx0E5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPXWvUACgkQAVBC80lX
0Gz50Qf+IlhiokUh2h5xWHhhOR/7xkU3NBUwXm3lch0y5T4kzgpQAXm00e6CJUA0
F3uOu044w3qWRkh4DLNk15pOjLZWO92VQhVPj3usra3FjD+Z97WwxbG1A//6U+Uh
CpCCIg6Nbkk9EZV99M46kMSWJjJ9KCUjck34uUEvEqA7TV7aamUwK2iPKJQLvMaj
n/alcQczsLnPwjvSBsqVFLjDLCV2lsxPl1lVIwjJUmdtGWMi/1QmTX8wLUVtwFpS
PebkWfoZe3+W8N7OiEDV6M9fbBsiF38FYQIi6yhSLyEdTjTdi5S9Mlmmm3etPCux
e3AuFsbtFnSXBh/1Y9GskEJ+qjNoVA==
=AgLy
-----END PGP SIGNATURE-----

--Sig_/aVSjTNY6PcKhiYOof4Hx0E5--
