Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383466A2CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 02:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBZBs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 20:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZBsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 20:48:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02955D33E;
        Sat, 25 Feb 2023 17:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677376113; i=w_armin@gmx.de;
        bh=WUcYVEwqrG6usAiQFxSS5/w7vamMXRwl23OvRi5cT6o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=I97Ono275JMIR9NazH2Rjw2tD1SSrKjYRayQKSTB+W/BN+SYo4fjRwoYBC8ixcl/L
         L1ywzcJ4+hhMee1aFgMqBVKBepHYP26MVaff30Pc805fZDRn8Pqg3QCQIlIpg682Of
         vQ6dJ4zoqfVmexUaygnxfI8NSo712WKL/jMLwAAauHH8U+purR+QiZyUAqoQyh/Eu4
         9tMHcILAnPtCyMTHmu3cptA3lV1UkQgV2yzvdMcWF2N1LA/ZLiAGqzFl/eCYyc6lob
         5BOqSXkEFAvDInyRCF7zZ6iy2MoMLT3KP7U1Z8NvJ3SRwm+R6cwuZzFMtZYoeX57gs
         py2L/caJEMC/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MsHs0-1ocTMZ2UYc-00tom9; Sun, 26 Feb 2023 02:48:33 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (ftsteutates) Update specifications website
Date:   Sun, 26 Feb 2023 02:48:30 +0100
Message-Id: <20230226014830.10929-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KJfAOvKDHvVsmTGKmNASb4WX+dMdFthNqzuX6yhwDdxyEwtZ7WJ
 iBhadcBQjFBWJ+hmC/Er+F7WGsv2cAVzFqcPeRtnDNLbUvfCJwMm0uDA2ysNVc3gd+D07V9
 ZwV7RWTWltGPQi3Hm3263p4OFLYcwwFx6QBBa1eFq8u9Nnr5z9z7M1a0ASEhzZAq2rat8Vv
 7vYmLymHWTBcHqWcbD3dw==
UI-OutboundReport: notjunk:1;M01:P0:sVSSp4pGbGc=;YG7R0optsPk+XgcLp70gjL2xbJ9
 1pCohmGnqs3n34oeOgukXte742FHGOpfTSJ0yYXqT++2tTuoGxcY7VFqYZD85XUbrT/kLylxF
 sMt3DsK7AYMPZE7AIr5QrM6pe9hXwpgTboYjYLyHRw+AGHqonkrGskls5oTNcdWeqtT1dAxwB
 hwx0nyRlzS3aPFeJlLZLfS9DIBGeu9HG2UEcCIKk0yfpUZSv8NZCt/v6sd0M7/tB32g4n5KW2
 hyBVotgdqRfuuJD5TJ6juKbolboF21AWSocJ5L6gKuJbiNgg0QBAtYJ6dAkQcymyBS9ExRu+U
 JKgDaJhXORMRPA5SGZRvhe5QbTTRzVSq9VLVrdResIerICLMgi7KUbievC4Vda6IMmWfRaplZ
 caHObdYZyPNLSnDIadduFmAB/o1MCxCd7wQbf05Uk1Uv4uIwdB9uc3eQFX5u+TrPZWwt27n45
 kv5moWqIlpTeo5HXqDlzWKxtY90t9vBD8ZOKfWxOHYRiM1bbR9lxhU89Y0V7rwD8QWFDffM61
 lGJoKv7msHE1SDRZM0yRj+EfUfP7kYI87SDXrpNekcZkbJZZHgvlNb93DO0ZB2Fykj4ma4DJD
 wKO7bm6pyErgdPtoOTE4+MDEDo8EJbVhxORreTcJwK04tqDAI+6HC+Pe8eTGqBusBFJFlj4hF
 7ECVuTIdNEd/FMCQGgp8p1JoXRWt/JskNGTP+pvPmFlCgGnbZ4J2ChepAu/L2GfFY4jPPHeoW
 YP8k/YYMPmtPfaSmwBN5cJgFN+X9ivoBFF7fwAOnPRKoH6EOnQhLGh1mjcit2c7j0SbMuVNaV
 R2znAuU3xcdxXXLmRLjSEMNbbCpD4uTdamKPm2yq1iZesDC61Ra1gz8UxP4NK21IhgsZNAhpR
 CLOl98veU12B9tis4/otuNndLPcNb5zkqEjhQH2RiYxOMmpk8ehPH2z0aeMTUorzV1nqgVClg
 I2rknsl3Ud5i4NZGkoobNv0cB0A=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fujitsu OEM Mainboard business was acquired by Kontron,
so the specifications of the Teutates chip was transferred to
the new Kontron FTP server.

Update the specifications website accordingly. The outdated
sensors how-to was omitted.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/ftsteutates.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/ftsteutates.rst b/Documentation/hwmon/fts=
teutates.rst
index b3bfec36661d..2abd16830c99 100644
=2D-- a/Documentation/hwmon/ftsteutates.rst
+++ b/Documentation/hwmon/ftsteutates.rst
@@ -36,7 +36,7 @@ correct path to the alarm file::

 	echo 0 >XXXX_alarm

-Specification of the chip can be found here:
+Specifications of the chip can be found at the `Kontron FTP Server <http:=
//ftp.kontron.com/>`_ (username =3D "anonymous", no password required)
+under the following path:

=2D- ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Software&To=
ols/Linux_SystemMonitoring&Watchdog&GPIO/BMC-Teutates_Specification_V1.21.=
pdf
=2D- ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Services/Software&To=
ols/Linux_SystemMonitoring&Watchdog&GPIO/Fujitsu_mainboards-1-Sensors_HowT=
o-en-US.pdf
+  /Services/Software_Tools/Linux_SystemMonitoring_Watchdog_GPIO/BMC-Teuta=
tes_Specification_V1.21.pdf
=2D-
2.30.2

