Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE14F6193F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiKDJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:58:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630381CFF4;
        Fri,  4 Nov 2022 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667555924; bh=mQO1KZtVW41h4QMxt8zmnc7+t4rWxxBsqaL/3wGPSOs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=rnLoRfXNGrRvq1Z2tVCUMFlBCcx4s/0Kq5QGJ3cVHXtWdM2W9G4i7PJbY7GYY2dUW
         unV+zD/UwJAz9V0CIVnQpuKbHpvMBX2ZF6GJtd0UEOD+j07D/kGVW8yTzXHgaLETLu
         X6kRa5JPN0I37fcF5gabJLEDqQQWYcGS+38BXpCMUAobxpAL5EdTzRdUI4wmiwDmvm
         BUe0Fc2IA/58p0q+a+8DjqPW6id898WrWxiB2LQHFGRK5C2XOlN73fifLtSMC3iMU4
         JtV2xrMg2Kte2EEqwu3EZOV0uf/lwJP78Js0NlYqCqqNNJORYiwFjlw40FKDeN4xk/
         /93bLPtSDa19w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ81-1oTzP71wIv-00WGY4; Fri, 04
 Nov 2022 10:58:44 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-usb@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: chipidea: ci_hdrc_imx: Fix a typo ("regualator")
Date:   Fri,  4 Nov 2022 10:58:38 +0100
Message-Id: <20221104095838.2132945-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V/ucTA5zBC1LuWA4bSeNtvNU5Y6rnvk4Vh3J/CDiJ5maFAgzbi9
 RqS+RYWtthf6ZHDyeONto8Hojjs+kWTMZJYmdj/Z5xfBEH3UCq1GkG/WFiXOpKOgG1HGuDn
 /Rxb3Vz1670tiYNBdRs4uA6QcUwUi5pdZKaAmy83VzIp37/Is2Rbo64WLc5XsA6dSnSDhr6
 M5C5U/aTdB9eBOHNd82EQ==
UI-OutboundReport: notjunk:1;M01:P0:IAAyuORdYPc=;n45qCqztgHAcf/HjvNCE4GXwxSa
 WrlkqzW+LojMqVoB9AdCMYtcOiF7oZjVth4wzYcBcpyhen3SEvQ3tQNO2vx57yPxax1Amjbxg
 mMHMwztXpkNoeiVnSt60ADsMPT+vKYUV6+GurHGTqD/HOtDoq25j9WxAUJ8244sWpEZdh4cnB
 jxoHydlwxI7A4bLAmnSPYfUHwNMS2h9o0+g7JTqsQ884w5EcwLSM6amK8KYKyhz1w6KZ6L36Y
 YV2YuRJy+d69KkSoOggSmWaNfBkwmCytLWx4J8w6moyQ1Pqa/mwSad9/vWzm/z85lezpyVq17
 ajyqSiAXBR1fPYTjIHmRvoQia38wZ4Pml3EXZd7oPr78KwZj3X3wuLSvRZQ/Nb3cq7S+AF/HZ
 h1YAoFrCR9NVf7CQ4+zCBQq1i3Tq/6xDOC1D8CJ5Eh78He5l24KULBdPspFYTc6ufFe9EqUuE
 Q9rJcgZQ1Q0JxMOorobRjXBGr26EkYgISzE88UO+YHWAHE391x+YsWKT0YUq8TXnp/00VPOVu
 ECQWvVDzpBblFf5ybxemDHxYUBIzlpI3VYG5i0ihF6GXuf3O2DCcFU9nBKzdMifwS3JNAeut1
 kspgATADtVZDsvuIhWBATs5nHOCocrasITCWddaWBcpdpOvjWhvWiN/Cy3gExWbKLSBkbukPu
 IlzkKt0H3R3sEiS9mK2VoZe1zJpR7NuTAljXKDCmAHM/P7y6UFMDEGBFgc1EcJdi2KeDsuXSJ
 pvHcMhWyrxpBsMHdevwFUvMweVIdEJHz0QYMwXKHH1Ev2i40ESAYBqwthn+v9OAY7gkrrNbca
 /8acwR+iWry3JQ2m3hkAXRhqzYGYNbOGSFWc4m0nS/V1jFpFoq5HqkWAZY6tq9fq/+TTyT1f5
 WYPxQlcnwgUZdmEPf4kdPJZ+U8HO6QXMEhJY9LouCZeZIh/uDyud3i77RNakOM1GuAsiqyu01
 b0oWB8D6s0eopSrGSgIDmXtpIto=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "regualator" to "regulator" in this comment.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_=
hdrc_imx.c
index 9ffcecd3058c1..1d6ee1d894f01 100644
=2D-- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -355,7 +355,7 @@ static int ci_hdrc_imx_probe(struct platform_device *p=
dev)
 		data->hsic_pad_regulator =3D
 				devm_regulator_get_optional(dev, "hsic");
 		if (PTR_ERR(data->hsic_pad_regulator) =3D=3D -ENODEV) {
-			/* no pad regualator is needed */
+			/* no pad regulator is needed */
 			data->hsic_pad_regulator =3D NULL;
 		} else if (IS_ERR(data->hsic_pad_regulator))
 			return dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
=2D-
2.35.1

