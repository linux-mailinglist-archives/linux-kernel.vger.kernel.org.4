Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7935B52C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiILDD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiILDDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:03:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376719036;
        Sun, 11 Sep 2022 20:03:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQryp56HWz4xZQ;
        Mon, 12 Sep 2022 13:03:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662951828;
        bh=PZXVBFTRc9PawZxRYvPDAYLQ/1BYES36XHwRx6NId+0=;
        h=Date:From:To:Cc:Subject:From;
        b=lVf0UQ0m2J/IepLUhGqHLLevzYIkRXWCI13c9qKTYq/J8tKo2rE12vIe4UIukVg6b
         9mvFq+k77oOg2Q2uk1haL5iv+WXvpf7e8sBNW53ELLhkKJioN+ZDLMF/lrRHq491pp
         m5tkKrYSV5FEq9IgqKOu3W70rMf/cvWmnFwF7cnQMqNveIZ6e1047B0NbQ3MyJRAe+
         /DseYVLqg+LMCElTIYAIZhyOK06h3kLCFSndwXzc9oO/gAipGKEInwcoG0Sv2YHcnC
         7cNxQnQSheOy3qHmLIlDP5p/TxsA5GRhMczttmn/JtdGsm4sLvPrwBlGyU47ThRxqF
         GxLtzx7pqdkWg==
Date:   Mon, 12 Sep 2022 13:03:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>
Subject: linux-next: manual merge of the battery tree with the i2c tree
Message-ID: <20220912130344.2e635cd5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r.hfkDMdNhjGHPs6fsRQ2R4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r.hfkDMdNhjGHPs6fsRQ2R4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the battery tree got a conflict in:

  drivers/power/supply/cw2015_battery.c

between commit:

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the i2c tree and commit:

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the battery tree.

I fixed it up (the latter removed the code modified by the former, so
I just did that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/r.hfkDMdNhjGHPs6fsRQ2R4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMeoZEACgkQAVBC80lX
0Gxzqwf/ZaaOBzPUgOUclL8rN24moLr9QTZJFyTTyR4i0EptxHtlfOaoKgqc8+Cf
SfN1I9uegJTZkO1JjRM/o+E6bCuveS/715b8rd3kqv3whOMvU31Z4JCuIoz/Q93w
gPS3rKRfvNcWk3Sqq9uBdkgYje+UTsSiWVP4h2fsyhDu7KYKWMbiucJu6ZQN4h6+
R3XrwjVod5DkJ9CqLwU+MbGhp9oGgw+IHDMhP2jAMRFE+6NGu4pWeOHjr0jOqqyJ
8gFF5ihG6Db4xHbIpHgI2yj5AVVN4x95L0UrYW+VD6+L//GNh1LQeDTfRNjsVTgr
WMo8mRTrjbJ952R7aDk2E4sJAcCdQA==
=SNPk
-----END PGP SIGNATURE-----

--Sig_/r.hfkDMdNhjGHPs6fsRQ2R4--
