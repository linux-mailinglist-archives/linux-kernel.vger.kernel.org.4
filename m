Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C82667748D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjAWEFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAWEFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:05:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D2018A81;
        Sun, 22 Jan 2023 20:05:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0c2L27ssz4xMx;
        Mon, 23 Jan 2023 15:05:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674446714;
        bh=/8vrsN3gyRrivKzj1cWVwLLM9aGKkQ53WPa75jPGdg0=;
        h=Date:From:To:Cc:Subject:From;
        b=KXlA13yqqhqdS3PiiBg6lP7vB6Ax7uDtMFJ4phugf7jz3ujOdaXlsR8LriLFpZ3T1
         LYpxKcttmSzfVJxzKYOqWQvO25eqi+MhPJ5rjeTFRJji03e/gqUQ7agLbWlpSAXdZH
         5Bb0pEgCh/B9SYZBd9beoQkP//rYer7t1+4B2W+wMoZk6Q101GI5GX5xvJR1rEz79Y
         BthoDWA4/RZ9oTLxnPpiSd63e/UFHG5wUMC4WArEbzZsNieqdH30pIjTU8fJM3Vq5J
         rQT96DJYD5nxIfrFDK+WiW9AJOoLTSf+szx4hkHXvAz/zP8YCHaPOjT17wlgjFfv2+
         8l1+Dfjg4dXCg==
Date:   Mon, 23 Jan 2023 15:05:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the coresight tree
Message-ID: <20230123150513.4d9cf5cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/76NPO5N3_NC5k7qu7zB3RfR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/76NPO5N3_NC5k7qu7zB3RfR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the coresight tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/trace/coresight/coresight-tpda.rst:3: WARNING: Title overline=
 too short.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
The trace performance monitoring and diagnostics aggregator(TPDA).
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Documentation/trace/coresight/coresight-tpdm.rst:3: WARNING: Title overline=
 too short.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Trace performance monitoring and diagnostics monitor(TPDM).
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Introduced by commit

  758d638667d4 ("Documentation: trace: Add documentation for TPDM and TPDA")

--=20
Cheers,
Stephen Rothwell

--Sig_/76NPO5N3_NC5k7qu7zB3RfR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPOB3kACgkQAVBC80lX
0GxXHwf9Gd6JOsToh7OdfKSkFN50riA7gufmRT5ZHssDqckZgWmA8RAh/aC/0ChH
mJlSbOzhrdicu2k0BBTQ3oQaqOGbfj/FACD3zp/tGTlLCOqlBDl7usPWdw2QqDdq
61FlhhTsXbwspK3R65xchgtczxrJHzXWdsvSMurt2S/LNywJ+k3APgvYCZxczW78
LpdKB3GlNxcQ6cFCPS30q2S9FVmSmGqIhTp+Y8p0lS7pcxF9v9YVYax3MF4YTgtr
35I2Igj2TWhkDz0WMDQxxnhVzqaZTO7XSk64C1UFsWx41b5u9g8Z6smDnFSnDDhv
SX7Nd2e/ZN8B8akYCaq9c22JIJjvCA==
=erew
-----END PGP SIGNATURE-----

--Sig_/76NPO5N3_NC5k7qu7zB3RfR--
