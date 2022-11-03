Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAA61881C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKCTBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKCTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:01:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A8101FA;
        Thu,  3 Nov 2022 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667502057; bh=y6ODappL0YkTif+pCw4EY7reX6hNd03JrdnmL87+lL4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Jc0nWk4jEg6sqa6GeXS7N+oXnoifryG5QFEcrGKqSZgttSYU1oY0Wug+Fri79ir+Y
         v509NPDu33TWPvh8cu5N4gWagqRs7+mOPKAL/msWnIB/7BF2YN0IFs6lUuHKkWKS0f
         5LV4XtwPnHkNXTjMOypnQd5v5z3qNt7vPWbtJUkHGYuBvff0LZNYXedtZ/rtm5I1Jm
         hBnnngKDWDsS1mI6NvcSEeru6sSU07Tz2fq3aQcQomljSF+tX81cAZT0jDWfNQEhbi
         WCADjLODdudG3SUW+YbsnKHtJ/KXiafK5HNkGfgw/adYqml1x7AqnN58f8s1HM2PUW
         Ls5Wa61OijmvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1oUEUI3Zna-00WSce; Thu, 03
 Nov 2022 20:00:56 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        John Garry <john.garry@huawei.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: hisi-sfc-v3xx: Fix a typo ("duall")
Date:   Thu,  3 Nov 2022 20:00:52 +0100
Message-Id: <20221103190052.915755-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jU2HSdldWdlFUnjmhwhye85P+6qlqbtaDZxZ8VGpSe/Zyjj74H/
 mOPTOjpB5UBGoBPYa1Rilbv2SLBLPo7+HvQrApx1OfLwf0w48Ima6UxXfKAcaA5VpP445uO
 t268UrgZvFTMtGyXjx9yhw93i329TXkyrmW/xNXVh5scrouWYv1+zkZbjNy+eGSKSnVogFm
 qLQLVjFzUy0Lwk1j2knpg==
UI-OutboundReport: notjunk:1;M01:P0:cRPZfCxS86Q=;GutQ29mYsva/S7bZSWxjH8G/3Ej
 fvhULHZ/RkMdMSEaFKvTkgCkYeNfL5dVLzVMyt6KKRVVVs9YJvZM+nGTPCJw7xA4LkNWfRMwt
 rBRlGNVSHpKqAsvTYFioE2E0uuPPP5Xx9Fn8n5IftXXY62T1tSWOGBJG5w+WNQXx7YrifmxYK
 dIUgnBhsfaKVLVG0IWkX+2iR2qdLGv9sR4b247OgTQejAZdYdRvCLmjwZeg15Zi+IEJXdFLo6
 839IZyv95XlmOKFtrqz4mX7jepOquW6iXN29PjtBMiiiZv88zUlcDDGKyYrRRS0VPjwV7JHp1
 oj9H0GzqVvNq0MPQqqYe8XYnZEZkOgxL0G94XiksZ/AnuDLDcRj1yh8cvuzv6n5R3TfEVHbGn
 qprYeUzHabEq5wBjQpZKvv3irv4Uz/kmBeVPfMqxUj9iU+V4jOOOgs5V1f309KMfwgZrs8xbX
 zCB42twW6hOKBM04dr/2AVs0AHWB0vXvpJ1B+IIs+2POk2C7LphFPobCyBpR+HVy73UFAE/sO
 DK7PTJR6lnrPhPyZMBjaEYmdhSHsgHhrQNiOAl5pR1qBWht5I9OKjL/Ibu3HjIox8DrZPcp5M
 kfM63ANd877m+Mm7flrROTtFAjMLq42pfWHBdVD/cs42A1GXdo/KqLFzGOK4FIqwsMgqlUAad
 2FF994+WQ+sWBC3Dcerq4lnkaJbvUqsHaO+tzjALUw/4RxhQRhCJRPNLx/z/2yp7c6rlaz8VZ
 P1JAA06ngOaGFODdTexrJaxlxKq4Fs0QTg4P+5v+e+5PKnznmgN8hOfDl6LOyjk/ligIgVbaz
 mckIb9obOZpuPZ1/IiM4wEYwEZhtyk603WhEOKIponQV5f5tY2uVnHgzG4Uymz2Q3wlEV+DXk
 sqHRsp5HOglqpgrHWAj0x8NqYZa8ORy0mlX95NvCYocaFX4yF2KYhjN4qdV45yhcrHt8DzDQu
 QUHLU40PRznViyyn88p48R7XjUI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple typo, simple fix.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/spi/spi-hisi-sfc-v3xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3=
xx.c
index d3a23b1c2a4c5..f07d1045a30a2 100644
=2D-- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -165,7 +165,7 @@ static int hisi_sfc_v3xx_adjust_op_size(struct spi_mem=
 *mem,
 }

 /*
- * The controller only supports Standard SPI mode, Duall mode and
+ * The controller only supports Standard SPI mode, Dual mode and
  * Quad mode. Double sanitize the ops here to avoid OOB access.
  */
 static bool hisi_sfc_v3xx_supports_op(struct spi_mem *mem,
=2D-
2.35.1

