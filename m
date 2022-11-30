Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574F63D184
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiK3JRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiK3JRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:17:05 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2046.outbound.protection.outlook.com [40.92.107.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75202EF6E;
        Wed, 30 Nov 2022 01:17:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUEKgvTNLoyWnzeYtHVqaOqZIGpRjOshdSjB1SHh1IJ9bDT6avPzN4ARigtCdEfKgMUsz80/wGvgnGk9+tXANxa1X2iJx6TeAPaBQZzP8tndhlmivJX4ywAoas9KACAu8/4WTeHcNY3w9vwo2vXhH8eCAiWaXUbTsbmbuEJl+in69kPWqYinMcrxlF7ZqgNdhguS2sUdSxzv8HTT8U0OULUX3o6zuf+TRUZ0zz2MMFLw1sqfNlx6OcBylQYfLrLANIA/ju/mC7fBP0kUct8XTWnSFz9dIj15++DZvkgs6f8aNfbBXEg8h1tKMyipND2k//C3KnqgqY6rjQefLQklUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWcd9Ua059X2Oerpl0e1v3/+gRFkW2jAP/4vsO35dO0=;
 b=QX1XWZ0zvFUfH2wJDmMhFhZbDZ3d1LvS7ctA0YPghF7T5H4hzsHuGNXI6bY9xlPY2YrGpkaX2ACGzM4Q6dgPC/wVIs969BigWpTpG94iNrAHEqkqmaabfFFgx7s9tmTi81afb1+hS1FNKRFcRFQ4QT5Eqg2/gJjnpxSQUVjfXpMAsPGt7/umEFd+5NLEkkpBXqGQ2JfHisgtxfOnLy6BsMIQUBJYV1K4r1A0rtsKmG3LZWIf+oBEzJLTkaGsjGA655l1+4l5aqnLlVlTeuWLQmkAVQq/Se5ue52bRkopgJqcvEUOV1zA2IiQ20GjZoiXOurJt8JMfUG095L1osVG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWcd9Ua059X2Oerpl0e1v3/+gRFkW2jAP/4vsO35dO0=;
 b=J2aBFsRqu7BJRggWgpkmLpnJ//0/ef2Suo6dK0nOMKBC4odTHaZlC9ShGhO5yXRI4Z7i4ybYerPuK8cdCkSJt+N3XTPgqa7d1p9qwJ/jhXnJei4mSKxh1BK9i//1SH6yyCLsoY/CjK6MH5wx8dtRa4RCODQ0LIF3ipaLOm1nDtmIxE7KxtoZFtrPNYsNybkjrNvYorXWzGD2gXWIFN9xDdF+KqdKk9KI8clrKhnttq3YcwSxQpoPWVcyrZAIEcVMoSAV8cAJS1hh+WY0v2d6fzW7V0LSJvgKVSOxbD9XhXdTfV+VTM0YwHeyyopOkktR+hE6mKujmYxPFswEYREgTg==
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com (2603:1096:4:10c::14)
 by PSAPR02MB4902.apcprd02.prod.outlook.com (2603:1096:301:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Wed, 30 Nov
 2022 09:16:59 +0000
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::11fb:db8f:df36:c049]) by SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::11fb:db8f:df36:c049%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 09:16:59 +0000
From:   jinchuan li <lifangpi@hotmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        972624427@qq.com, ligongwei <ligongwei@kylinos.cn>
Subject: [PATCH v2] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
Date:   Wed, 30 Nov 2022 17:16:44 +0800
Message-ID: <SI2PR02MB46038FD0DE47A12629F9FB25DD159@SI2PR02MB4603.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Wx2oghGhzBrW8XQsHPS7SQjzzhDD8tMB9HYmOVXQrK0=]
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To SI2PR02MB4603.apcprd02.prod.outlook.com
 (2603:1096:4:10c::14)
X-Microsoft-Original-Message-ID: <20221130091644.6162-1-lifangpi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB4603:EE_|PSAPR02MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9dfd08-f16c-42e9-165b-08dad2b3a2ab
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYs+0Qv9vMQv+N5ytVjyiXkPiFwiCru/bNXLaRIISujs1kJFxLU0MfBraq5HFvIBJXfvFyCaRTY8IG+TLUPYSnFJo/p4B2X64Vk49AV5uz/Dj5y3GmK0itgKS/YVZcR6Rkiz8Sz7t5ZFzKGWzJHKVtEs5uGiGLsPLFwSBysSqJ+z2TBGSO4o7okGTOHO+HglB9f+ECQNjkuN9eKOxrhyO9ZexB47tixeB/TqqPZBkP1KqkVg6Bz72cPMUvhipBVw8Vg8+8h+pKa31XUw077j2PbhjhVtWgAXomwTFMLbO4Cmb7ig0CWyeBIU4P+zAP4lMhLRpcVBGmwBxJIj/ikVWSsy9eZC7b3qMtXR74elyweRlpMegi9DXejj8xM+IDhk2Jg95a/RjGbYC91ob4e2w1QL455tls1K1WrVHgFxr1qjFICY+FDWupzg6VSlL4OahHPcnWHn4wnDymkT9kkRfsB2zWmkjnB9qqdTU5rUYWBrwwnWj19+b4qv8MpXbNkwYUThhjTbrjo4BBKLpsv0V4835wD3DzV7pljIUQurksLHit786bvMkFy+5zsaDkzU7D/ifoizORq3dSJFmIA+uSP8C9SUeCts9gBURg7NXv4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVb+G4jYAmpvP3/T7brR3oMsOYFfY+stoa2LPpc+FRVnZ1CN0QZRLPk64aTs?=
 =?us-ascii?Q?NvwXO4Q6wJmTn1FhmMrjJt1gY1a1u91ptilyNDUMJp9kLq1FVYZMnw6Wb/3V?=
 =?us-ascii?Q?zmLwPqxJZuEfAvxRAUZA7YgHZBUtbxW/dVCviHjTdxKQDKo1BFwqh1Cg4MLE?=
 =?us-ascii?Q?vHg7XD0vi+ovyWsJDvi5sWsaWXHQ/ZUVdc4+AHdIkIgGfOyMyasO6E5CK7dC?=
 =?us-ascii?Q?gszakbTo5EJWCp0YSJVcZAIXFWMvb3CGUe+Zdr0eglUVSHnFHy2K1kthENXp?=
 =?us-ascii?Q?uAyVIcZ7eBhAz8aZk3inJE538RjVpr+SnU/TgPJADwov383TKdYyGbNAu4W5?=
 =?us-ascii?Q?P119geFbcsBpAmhYkkstIWW6loRqYz3uDgJJVKGcnBR/6m2I4dtDBnAxG2WO?=
 =?us-ascii?Q?EcD31UE7dra+e56ahrG7ur/aQEdsjXS2CsiLVwR8GBCwv9Q4/jMygfpq1Vd8?=
 =?us-ascii?Q?c/23ivfb4ZP4TBrwEuGT3G2DoMFj0plm/n5XugZtQ8vzs7WE+B270pkUb3hV?=
 =?us-ascii?Q?OzxMTs2OO9ZCMB0JyJmyWYAlpz0zr22XGhBW+sZMMQhcwHB1hgt1w2MqfVKh?=
 =?us-ascii?Q?8auquV7Z9WNPhfmd5+No2jtAorZ5VLAcIDuCFmjjDBfoAIHkD621CWKL1ICE?=
 =?us-ascii?Q?KvKj/y5DmoA9QhrWCPufSVsDgJ98gei3gwQ+Hg2sbBNhsf9lqByAzV2FEv2f?=
 =?us-ascii?Q?RDSp/6mtn6WzNca6j+OezH5MBvaTF8VQgbxRpmGPylNVTkG9ptzL0o7VwQcE?=
 =?us-ascii?Q?tnu+vOAWtwPTM/NNPeYRx20kT16amryQb63y89ssTppD1hJB+m5mOWp+qkUu?=
 =?us-ascii?Q?CTslQsmSWnYlOAIInzVPdE2ag5MYFQtUlsGH6PLoooo1EBnChvI7LdJ4WHBt?=
 =?us-ascii?Q?Ozerq0crbiRMEIYQT4IpruUdf/6oLW87uLbLdWAFw2Hmkh6RxqDG+FKXgytI?=
 =?us-ascii?Q?JhlEnqGTgASl4dsVp1ex+OKzGfSPQ7iLWFIhmwS9vsJnVpwNWI2Euh/SZcDL?=
 =?us-ascii?Q?AcVtiRT1QSppHvkMDTMCc6+Ltqcxu2Q1GJlQ7NR4uJP5+U/WYlsTMCW3e4dL?=
 =?us-ascii?Q?V+ZGYrKyYRiFnk6g7ABCWYUTZIWDU56w1bGmcAgf8Qahi39rmvyjKi2yq1fS?=
 =?us-ascii?Q?Et7Wbt1PECXxFLf/pCq3RlKEd6aDXxNYl5VCGlEoUeLE8nW4i1y288k4glMv?=
 =?us-ascii?Q?EwoI+o0BcHGgSNt7pXCppzUYKYaFDgJ2VTGFeTkwy5GaLzZ9MOyzkCOT7Mkm?=
 =?us-ascii?Q?uTqOpJlW9HDLMI+5TZoOdnBEHIZ3bPNsShAS3stwdA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-20e34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9dfd08-f16c-42e9-165b-08dad2b3a2ab
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB4603.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 09:16:59.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB4902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ligongwei <ligongwei@kylinos.cn>

* /sys/kernel/debug/usb/devices
T:  Bus=03 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#=  5 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b85b Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---

v2:
 - Modified commit message

 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 64a3febb9dec..437d0b53efe7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -498,6 +498,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0bda, 0xc822), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8822CU Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.25.1

