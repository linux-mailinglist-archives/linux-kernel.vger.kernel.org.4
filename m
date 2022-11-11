Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6A626255
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiKKTqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiKKTqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:46:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77879637C;
        Fri, 11 Nov 2022 11:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668195958; bh=yIQdbqKmMk0fkcfdZ1ob+a4oeQtt5Pk2MeJErVokxpA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZykDxtrJ8EzugdFIPCZHEtHKaixIt3j3ejnbcTgELV5ISMfBRvF/hsNC21ruYTJ1i
         poRKi+jFbuumhl6Ng2xLj9FCLlMKF7DvQndpMBM5O3IlezT76rLUUQYvn94aCoPhMv
         BqqG73TLs5rj1U5+5UwL8tiNu0qqmw8NlJrYgYlnIkAkOnxc/VwcKdTf5ogaOZhGW1
         AqIZT1LAk/JVQQlMOn28C72N7NvHedpfamkL7lzRH2NWJjlq5sRr4e3HLU/T2x5NF1
         zL0FmkttNeb8RFitDMaQYxFL/ggwBYBqyXKIVW3L3dVrKAvdscfMrD6d5X7Va6Mlvo
         uJlHuoXIEnS4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from 9300.fritz.box ([93.221.18.29]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1pMqIr10BL-00oWkI; Fri, 11
 Nov 2022 20:45:58 +0100
From:   Andreas Bergmeier <abergmeier@gmx.net>
To:     lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: Send SwID in GetProtocolVersion
Date:   Fri, 11 Nov 2022 20:45:26 +0100
Message-Id: <20221111194526.1375601-1-abergmeier@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bjKnsDkSjTyFeheKeU4NmzzGKoiSRrwSuvhF8eUmOTtxxAAWrCy
 Rx8nYLXkhLhP7PjHjRIPQp60GZXrjAnEMAkNo5APKAdms/8bdMm0AZLO2rgOmwTxlssXK9U
 SuSM7Z90T2Zwo8pg7XdFckQEsw/lOBzP/k/w1kvTF0v2k44EJTaQAG2fY0EGEBCNQ4pDgbF
 orq1XJaJ15lgAkhRu/IqQ==
UI-OutboundReport: notjunk:1;M01:P0:rZd/KR+GrhA=;49kZDaL0yTQk8UUmnM//4WnDzqB
 ClGtvsIoaVA+3CBjQMme/92ICy+VrXlb+QzZraEvS+WXWHZuKdtZe9OIxE2qPypJ973qs2AIX
 Vk314JZ68o9i/VNShyVUxA5kgWAOECaYrjM9g1IicY+CZ/9BaGIIyA8xe1Q4//eKZ1JP8OCYm
 P3X6ckaH50Q7rBJ7QB/GGU08QuPiu3I2dqPARJ0u5pSvMQY5ZCxjCWFJ+NuvvkBx2KjjqxQdo
 uv3hNXyyre0d+Z4rltLy+rKd9XaQ8F5kdgRahDKaO/8oY0OJWylrwvVgJyUqvEJBF5AgbYxKf
 1IKL7dfnry1MtR1VpU3mijvnYmkX2SxNkEL57JtJswlb94dg3F44pnmmYhMXHBuRZFRaJD4H7
 cYkzPjbafSuCVzxXyTzO8L4I8BvBj2TpAYdTMthrlLkciOPEjLRMFWIlMjsteU3F8fJMu+y89
 feV9f2HObszh9WMdZjd/KlUSv25Y+5M7p6FqOdoHr+ZLwi1PL2Z58qFZsJ5IekJLSsE1qVqai
 MdNdxx+FVun7rXl6W9USlv+8wPUzI31s6b9HwVddpj0RIhh7qa8ntoCacEJa6U88cLLtnY6jH
 SezsPByVvyEjK40SurU8WzkBNtm3gKbSaq/I9ahLYGt5wohd1ITI7boodZ8aaNFxCBcmDdOxv
 VFdnnRqOb6pzMZEuJpuH8aNg3WYNnHeEQ14F5bY0l21EcW9felHLaoqnDmJB5fcrVADYAxYvi
 cBUzJfozGgZ9Qm02nRLiD9NOtpcW3X6UzEGhtfW/zTlOe/avewIuNJqNs/MNNj4KHwIz18Cd2
 2+zw4SnzXg7xiMY5+fKoljtTLBJOluTEKTwYY8LTEouet9mg4hZ494m/jXfHfWtCxgS4qrigh
 C0awdxiv2QU60RPWpK9bKse0VcHFOZ27Syo8ZD5iHtdC02PSvvR6sd6khw4Peu6A7Yeh8PEm+
 ErEFPx96CG1qwxcgZUTRTLamhoM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to docs a SwID should be sent for GetProtocolVersion.
> 0x10.DeviceIndex.0x00.0x1n
where n is SwID

Signed-off-by: Andreas Bergmeier <abergmeier@gmx.net>
=2D--
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-h=
idpp.c
index a0c148a8df6c..964a523c3de7 100644
=2D-- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -896,7 +896,7 @@ static int hidpp_root_get_protocol_version(struct hidp=
p_device *hidpp)

 	ret =3D hidpp_send_rap_command_sync(hidpp,
 			HIDPP_PAGE_ROOT_IDX,
-			CMD_ROOT_GET_PROTOCOL_VERSION,
+			CMD_ROOT_GET_PROTOCOL_VERSION | LINUX_KERNEL_SW_ID,
 			ping_data, sizeof(ping_data), &response);

 	if (ret =3D=3D HIDPP_ERROR_INVALID_SUBID) {
=2D-
2.34.1

