Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A3B5B7F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiINCz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiINCzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:55:55 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248665676
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 19:55:53 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0A5612C068D;
        Wed, 14 Sep 2022 02:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1663124150;
        bh=vnIy/SaEDuFb4tv1VNUdxda1tMaZIk/jObbQBpYLvgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/TXucfOMLxmXXpkni/XwQuOGNnejzuFEzvk56uT2QfG/R/DsIijSIF1iFNMppJW9
         wdrHVjCpQynbd9g/jAHmDFZWpk18nxmOduHLDDit88IhVaIe690mN7PtQhm1VjOKuy
         6/RTp8uUGATaD1ClridThh0JEPG8TN6pwQ6IXZo6WbfBwxp2yaUoecNwdcA/hiu2Is
         s9pOj8jAwo3BLcUWP6WZcRzny8ao+wFBvgVqjN0G5MrwtY/ra16EYa1E35HamxsVqM
         wSMas0qhYCUtvOwoN4+2i5MeDih15FsJMGOnDjc8gXYE4tg6KISKtyQjnd8YwNzgER
         QtFtwHEBl1njQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B632142b50002>; Wed, 14 Sep 2022 14:55:49 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id D59F113ECD2;
        Wed, 14 Sep 2022 14:55:49 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D327C2A00E3; Wed, 14 Sep 2022 14:55:49 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     hyamamo@allied-telesis.co.jp, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] USB: serial: option: add support for docomo L-03F
Date:   Wed, 14 Sep 2022 14:55:41 +1200
Message-Id: <20220914025541.1018233-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
References: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eJVtc0h1 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=xOM3xZuef0cA:10 a=7hGlWx8YpV7YH9KAU0IA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the docomo L-03F modem.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2065f0fb2fa0..14eaff50820b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -527,6 +527,7 @@ static void option_instat_callback(struct urb *urb);
 /* LG products */
 #define LG_VENDOR_ID				0x1004
 #define LG_PRODUCT_L02C				0x618f
+#define LG_PRODUCT_L03F				0x6366
=20
 /* MediaTek products */
 #define MEDIATEK_VENDOR_ID			0x0e8d
@@ -2079,6 +2080,7 @@ static const struct usb_device_id option_ids[] =3D =
{
 	{ USB_DEVICE_AND_INTERFACE_INFO(VIETTEL_VENDOR_ID, VIETTEL_PRODUCT_VT10=
00, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZD_VENDOR_ID, ZD_PRODUCT_7000, 0xff, 0x=
ff, 0xff) },
 	{ USB_DEVICE(LG_VENDOR_ID, LG_PRODUCT_L02C) }, /* docomo L-02C modem */
+	{ USB_DEVICE(LG_VENDOR_ID, LG_PRODUCT_L03F) }, /* docomo L-03F modem */
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x00a1, 0xff, 0x00,=
 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x00a1, 0xff, 0x02,=
 0x01) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x00a2, 0xff, 0x00,=
 0x00) },
--=20
2.37.3

