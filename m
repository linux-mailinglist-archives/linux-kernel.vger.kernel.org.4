Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA76143A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 04:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKADWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 23:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKADWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 23:22:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE37654F;
        Mon, 31 Oct 2022 20:21:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N1b0Z1kr3z4xFy;
        Tue,  1 Nov 2022 14:21:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667272910;
        bh=gJAMlhqFJxY4eqbUvZqt0lS+2cllxTmRtZrVonDm43Q=;
        h=Date:From:To:Cc:Subject:From;
        b=oeoL2V+ZXgzSo/LVVdmONnkt4oQP8QpfdfmrxDNJTh26SqXR/ULOy+Wm+G+B+UONB
         Pq5iYJnHbt21h0gdBMkpKIUEj/7Xjd3aqhF+jfFy+JMzuUY08Ta5Uj84448JHbu6fB
         lYaL9OvT/zXfaBglSx5z8GXWzEVnct4jg+E+eSV5mTPT1QZi9gPK0kJgCmZb1MbPPB
         VAoDqDCZ3olvMvO7pSEGvoJ1bVOo2nBq8lultOnxkxZZ5lgsFfXbctCGCPMb2dgxFc
         +k5ifi0q2c/ooTq5SGCaRB5JqNQIE4sGIRCTLtZDc5x/kL547+4u4WIIvp0QHE66If
         5+D+mW0QY6FeA==
Date:   Tue, 1 Nov 2022 14:21:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the nvmem tree
Message-ID: <20221101142146.16f7b14e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ab9XbNEmLasJPYzzhBHjrSa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ab9XbNEmLasJPYzzhBHjrSa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nvmem tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/nvmem/nvmem_stm32_romem: struct of_device_id is 200 bytes.  The las=
t of 3 is:
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x73 0x74 0x2c 0x73 0x74 0x6d 0x33 0x32 0x6d 0x70 0x31 =
0x33 0x2d 0x62 0x73 0x65 0x63 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00=20
FATAL: modpost: drivers/nvmem/nvmem_stm32_romem: struct of_device_id is not=
 terminated with a NULL entry!

Caused by commit

  55ca3192d007 ("nvmem: stm32: add OP-TEE support for STM32MP13x")

I have used the nvmem tree from next-20221031 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ab9XbNEmLasJPYzzhBHjrSa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNgkMoACgkQAVBC80lX
0GwIfwf+Lk0EuILQ1Qq3nt3u2K2l7+ViDzCkICw5IuKJiAnPiV7R1M2CBhN+vpEf
XrAgdTfqbH1DfZJNi2+AUiw1pj/x99nB2HwKNxJzv5eTfSbIDdpHv1F3vofLx2D3
52HHWeTYF5LdpsqdY77sHEWaMiPepj8en7QUcu6zJVEkxfYiOTzAHLvcJxGslb37
ogTiKQYZRSL7B8i+EVG2b6erz5qhWBPmG4zwxoX5TiUkR4D0dkRhntSGSI8P+14G
7ugJropdyA+r2xc1LWWBjS4+RKyaO8cojJigJUULJqAZcotHVGP7rBhIyP4Evq+0
G0r9D9IrQjNv4fS/Gr2q9IZXAjKGAA==
=8caR
-----END PGP SIGNATURE-----

--Sig_/Ab9XbNEmLasJPYzzhBHjrSa--
