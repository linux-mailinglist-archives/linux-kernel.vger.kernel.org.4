Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78BC6DFDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDLSkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjDLSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:39:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461C861A5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681324722; i=j.neuschaefer@gmx.net;
        bh=e3csk9QDtuoyy0hLFZXVSqs18PWEMHsMdfYpX2DjbKI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=F0OHcD5qharOJwVe/I60yV31iXqhUkwkvS7Z18lHz3OANRoAMWc53umHtYYhB+jKi
         5TbBM0ck9cpngzWF7C6K1QUqqRMIZo+uCa159JP3Fll76YXg29cNhPzvge9vDsp8gV
         gMPmYzBb+uH/22ldeDBJbV0FE/mLYs72c/VGcsYTewAO9/MHf1FJ2zJ+XBWJSgQMxs
         MAGLNWs629BiovipPQ6OUSMfmfsAPzfQzx/dbJwoItNqsBFB13elNn6oYj1MX6ayx9
         gcdkAbaFvwl9VNNb/XMU7Q4G1RWmOjTB7+Sz++E4B/58BpN6JrllbNIcUzc56kJwna
         yIZQlzYfi9Kbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1qLRx43G5b-00aH3p; Wed, 12
 Apr 2023 20:38:41 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 2/2] soc: nuvoton: Add "select REGMAP" to WPCM450 SoC driver
Date:   Wed, 12 Apr 2023 20:38:33 +0200
Message-Id: <20230412183834.3769519-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412183834.3769519-1-j.neuschaefer@gmx.net>
References: <20230412183834.3769519-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sah6L9Z4qPYitnzI9t240ENQHo3+eFI+OoSRtsT2MmfdOy5jjO+
 VP9P4lD3CzwU7l1sYs83RBd/iKKCVbJt1jigQWaDTehB1kGqPC2W1l5Iqw2j+9hUrj0WvSc
 G1t/4bo5bl+yr0Y8kVY9jw4RA1lVPhGsgJPrfVE230KMDFaEE3dRxSC0tTetNCz3ZMVmKqK
 Uq/X2Ibd+/vcjyRE5jeUw==
UI-OutboundReport: notjunk:1;M01:P0:hGUsEb3yO9g=;7aSRVvyg+8zefx7QX4jTJYPKutv
 gEiSEsjtKIQrN42icmzeWvhj2iml8muSLj9X6Klfwxx4q6j1QTe3NypI2o9Rp4nfhA2WuUy0a
 jX4EJukddIEW1Zt9vxppsmJYqu2cf/9CanqQLNVt1qYGDCq87oaW57rkvwixu7DJWhi/ZQKjU
 dWRUU5ntPDR9mXPliSyvld+kgZ9RDjQ3uyi4paKqhMc5TY3PMVuP7KKAfc+R3e4j0djtBMGYM
 iyDnzxfl5oLNXabGrXJwf52lnX6uMJz1Kez/wCYEKg4WTqFLIUSaSCNPLcqkpcamdQatjqCwt
 5SLc9JAhejkwyT3Pka5P9lE7+/6Eb2Pek2E0x9Fvdbh7Adogq3njy8W+wT9dfrAJvSQ5fFBWc
 IDjq+gNAmWthmi4AZwGR4IThMJw3OJDaYhuW/Gxg7P5CICMCBs92Y/kY+ag+E8mKLIiIe9J9Y
 lQhV3pyAPvGSX7zaRZG0OCA7zAcV728nH2xE7L4w07pjiXJg2gE0FZLXqRoKmmW9hdabNrRro
 G/OW7qEHkyi/1+URaJBfAVdMQ5bzHx05da9OvaM/uKsy8v3bpBTHCQ9gQCO+uicY4SHuTSGQD
 3fUbFj4d8Or9bjA+DlWUBIqCpvlGTy8rSglVuhM8BA199UBz/zV5WqcRgK/riP3D6nZ2Z2JTr
 /RvJOB7YO8CNDh3LxafE4UeTUrjGiDVHpFRh8joSMQtaFAnIC87sHRgVdN3XNjIFwLz5QUlbZ
 ldcCtQ71Hel9iRI1twuuN6wZMAtgYz8J0nb1xiZ95D/1f4UXkr0suqrFtqHINFTvc7rCVkNs5
 wnQ4Lfzu9QPivRvy4nBkz4hUxJFuDXYGze9cT4nCFBEIm6/Dr85Ss7kqAguwddq+ON8bj740G
 u4hGez7nF/Kseql0tD8xGJ5ArCncG2q3SAEf1feZs3Alol7/LaOfJeNeXso5/GXgL0URB89c6
 9aCKwA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_REGMAP from CONFIG_WPCM450_SOC, because the driver relies
on regmap to work.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ=
5u+4Q8c7-wYQ@mail.gmail.com/
Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v3:
- Split the commit into two
- Reword the commit messages a bit

v2:
- https://lore.kernel.org/lkml/20230212215234.2608565-1-j.neuschaefer@gmx.=
net/
- Commit message improvements, as suggested by Geert Uytterhoeven.
- Add Link after Reviewed-by, as checkpatch.pl now suggests
=2D--
 drivers/soc/nuvoton/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index 853392c8a9151..2167d3d739d84 100644
=2D-- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -6,6 +6,7 @@ config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
 	select SOC_BUS
+	select REGMAP
 	help
 	  Say Y here to compile the SoC information driver for Nuvoton
 	  WPCM450 SoCs.
=2D-
2.39.2

