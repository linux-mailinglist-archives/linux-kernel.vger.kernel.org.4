Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FA74CF21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGJHx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjGJHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:52:56 -0400
Received: from ir1.moh53n.ir (unknown [178.22.121.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ABFE73;
        Mon, 10 Jul 2023 00:52:33 -0700 (PDT)
From:   Mohsen Tahmasebi <moh53n@moh53n.ir>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moh53n.ir; s=mail;
        t=1688975549; bh=+Nhy1TbkSWhYfYGqNvVnJw+7u9eF3jLTXDt10/LLKW4=;
        h=From:To:Cc:Subject;
        b=YIawe2jcW+chmnB7uVJgy4rhbXYJ/Q9NRcDm7V3cfj413BqFoeWcQh3Mz4+HricFU
         WmDCC7SSa8cTuDzbOjZ/jiVN+ueaXsXAyYNV89gGmBUdcsu6Zl/fIXMDMOyPxanxK8
         89I64JvpjGvW3xftAK55N9gsINq7FwG5F4tNc0dfZWu0ym3ojSbwMXXVihvJsWZDWM
         hTEHeRdhcqSAexQtncvA8DWCeu+Jw/s2bMyoTco318CBwAMqXsUEv+W5i2A6EsAbWM
         F6RQAyBQBKOkNVhqvh+ZtbMknClhiBbdvbTGxGv7pc7RVEyBE+DW9urb2+osbxy+RG
         R6u5nmaB3J/nJeNc9z/rq6GfXGzqS5NPR2s1U2Qh3Nn1eQPYnLNN76VsYTAuckuuta
         LfHQTe7j94wGX54/46nnI1RfcuNz+o2uOolK7pJJU2B70VvN9I2g6l+ax5IaXSQEZd
         kXtZ4YmxJOvAhOrgHRi9A+1G2znGh1xDBALe9bRoC6h3kDQgRkUBFRYiaAy00khCL4
         cFNfnkyC8Cdep4XlSE8TUcthillppddVo+LtfKcVDpvRYl+n8IQUC+kv855SRduKTl
         yZWTAlQSUtN/+9OokUK+4G5CR22wSXKVbEBkn5mUa9RUwl4IhPQH9mZxOIPeEnQWzR
         1IEm/WDO0J7HtereC19i/XiA=
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, moh53n@moh53n.ir,
        Mostafa Ghofrani <mostafaghrr@gmail.com>
Subject: [PATCH v2] USB: serial: option: add Quectel EC200A module support
Date:   Mon, 10 Jul 2023 11:22:18 +0330
Message-ID: <20230710075218.8895-1-moh53n@moh53n.ir>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Quectel EC200A "DIAG, AT, MODEM":

0x6005: ECM + RNDIS + DIAG + AT + MODEM

T:  Bus=01 Lev=01 Prnt=02 Port=05 Cnt=01 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=6005 Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
S:  SerialNumber=0000
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms

Signed-off-by: Mohsen Tahmasebi <moh53n@moh53n.ir>
Tested-by: Mostafa Ghofrani <mostafaghrr@gmail.com>
---
V1 -> V2: Add proper changelog text

 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 288a96a74266..ed4405efc18f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -271,6 +271,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
 #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
+#define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_RM500K			0x7001
 
 #define CMOTECH_VENDOR_ID			0x16d8
@@ -1228,6 +1229,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
-- 
2.41.0

