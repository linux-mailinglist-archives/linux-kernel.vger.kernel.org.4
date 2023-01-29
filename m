Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23B67FFCE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjA2POs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjA2POq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:14:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F381C587;
        Sun, 29 Jan 2023 07:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675005279; bh=Xkk2wNMvCc6Xw7jVSI8Ne2p6gqEgoFqQ1RMVFA8w0Yw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=sh/NfCDI9eCn9BPMAgRPaidw6AV/PvMbIvmkJlt2FluBL6d08DyfkOYQkGt6jcEeQ
         4n7/mHBo3/lQu4cyJwGr/oK9TgL0v4/QMChmsqKF4/48rBI9aaOzVNnMUy2FpGyPwW
         MIMg5aAzrZn4xkUBLWKXwq8fluA/BDr7bvVuuan2ckdUU2iAR6N6zwiIper6oOgNgL
         12YqfKWexdgvMZmuIQHYQcBbNkE/56ic52Wxm4tOMu91BwiF/ryYHFJgZEF1ux+7Ke
         dDI71NNRZQaCY2hiu61sT3qHPc2wVLKKNe8+CJD4xAMELwPnubIQJdsfYPyFalht/K
         lm2trhMJYhsTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1oUjmv2KAM-00rUtE; Sun, 29
 Jan 2023 16:14:39 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>, cocci@inria.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: coccinelle: Escape --options to fix Sphinx output
Date:   Sun, 29 Jan 2023 16:14:08 +0100
Message-Id: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uFBiIphmXEeRlB5va60ud01KyrW18ZmJLRIIc6nBb6esVmlpr6p
 JZaPv0QxjZtJVFkj7PEPH/zF6GGDNhx3jucFh5vm7g6QGRo909p7YAj0d2sLBOCfs8ggd0u
 LQIC4lwvlGgRnA/otQNn9JZXQlJwila2brqU/T1Q/a2JP93Sq5AmhPacdgreGg7Fl5yGZ8y
 eVcL0sKMRsY+jWd6YNFAA==
UI-OutboundReport: notjunk:1;M01:P0:h+JDJ6+TucY=;Zm25VJ/b7OpIGuDIL1u9y3y+QEs
 uKB/BnXtj6JNNyOKpHrtyCHz5a1wPIvrQO2zjjkj+hvCkQss+xjM1ItwXJYB0pXAHQA9RNPzo
 8mKD8aMur5PWpIa15J2FKYnXd7jdTjZ2eit+YKXzwx1Z0gREhPZnk3+vsKzEe+IpG7LDUblAM
 GMEOPNuIDF5QaGkWa8YkVN4d7Ymq4oHaH7p+EJSa5sa8sA19SmGJ5fxDvA12lYb+sWmSJ92Ls
 7uQN/QRwi7x0iMm3N4Ryye4f/oa//bMg0J/oxl7wlAdzNk+ufPlK9Jge5rutf7LogEfGxKU0I
 zF4AVAwMG7um7GchGt2MFDSAb8Ej21otZ6FNNKHsTOpBBGFWACBOidh7TMew3okWmBKQA4IQ/
 xwMyUCTAMZPPIK4OC/jl3lO7ewqc7Dw+OHd76ml4A50t0QjOzcJtQs6E5AMrso/KuwJV5/qeG
 alpwYKCKkixH52/cXihYol4JGgZiKJPyD03rsJH3v4wH3tt5L+zMLO3SqsvGAQzE0UQqgjY/7
 jAhRUa/P8g1DZ/uvOGZTJ1yyJDbqMXO2us/YkFDa/QjDazHh286QmlS4/hmyKaNF2CamuJa+s
 Y2MDFcsjMdFdyPIg9C662sPv/0x5XSBPrmVBjchjpgpavOdDMuGQlP3CQ2OZHsYCE9aYk+j07
 pf5Fapzt+ke4gRYSjjwU5m2gM19XhhFornmxGVwh5wLpGewV6BqLlFLCilNJ+fPNsMsg/jF1o
 9g/579AHkZ//GtbmstXOXzDOly6pv6rlVTVXNJsif3GJinb1iBJgaZpVTCsV43yC2GiOCRtfD
 lH9Ykb0HsdrzbEbhXhi+C7Lk1zao3U1aBQyDBJHzxnIER2Gxl1NZnPmdMPpd19KN9Pdy3G1Wr
 ZEn/E4oHkpuA5VCTfxUD1jtt5ufgPLgssPU+G1T5dcvOtjPKB88QSVSY8M5X5if5P6iQIY3Q1
 wxZFz+gjwqUF12iprgPTnpN6GB4=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without such escaping, -- is rendered as =E2=80=93 (en dash).

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/dev-tools/coccinelle.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-to=
ols/coccinelle.rst
index d9976069ed126..535ce126fb4fa 100644
=2D-- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -219,7 +219,7 @@ instance::
     cat cocci.err

 You can use SPFLAGS to add debugging flags; for instance you may want to
-add both --profile --show-trying to SPFLAGS when debugging. For example
+add both ``--profile --show-trying`` to SPFLAGS when debugging. For examp=
le
 you may want to use::

     rm -f err.log
@@ -248,7 +248,7 @@ variables for .cocciconfig is as follows:

 - Your current user's home directory is processed first
 - Your directory from which spatch is called is processed next
=2D- The directory provided with the --dir option is processed last, if us=
ed
+- The directory provided with the ``--dir`` option is processed last, if =
used

 Since coccicheck runs through make, it naturally runs from the kernel
 proper dir; as such the second rule above would be implied for picking up=
 a
@@ -265,8 +265,8 @@ The kernel coccicheck script has::
     fi

 KBUILD_EXTMOD is set when an explicit target with M=3D is used. For both =
cases
-the spatch --dir argument is used, as such third rule applies when whethe=
r M=3D
-is used or not, and when M=3D is used the target directory can have its o=
wn
+the spatch ``--dir`` argument is used, as such third rule applies when wh=
ether
+M=3D is used or not, and when M=3D is used the target directory can have =
its own
 .cocciconfig file. When M=3D is not passed as an argument to coccicheck t=
he
 target directory is the same as the directory from where spatch was calle=
d.

=2D-
2.39.0

