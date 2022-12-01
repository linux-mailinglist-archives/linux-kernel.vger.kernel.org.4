Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E70F63ECC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiLAJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiLAJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:44:21 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2061.outbound.protection.outlook.com [40.92.107.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93402FC15;
        Thu,  1 Dec 2022 01:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjq5nvtqn4Zwx0ixmSrAHNAiUbJ2sszDp7nu1QTIAzn0mks9dNwxfoCDC+Yl9V3pQbpqZL5D8ztU6tHI1W+HaGOSAdpiSlhqDDv4f7W7NXuyNf5zYhpSQtXN2ovsZD+v1ujsFuT3ZnYtBVti7QUBnHl6+P0sKR6nbu7wFIsgwmeUcVDfYjCbJ91E3Bvc+LjFXlqNre/WXtCWSVtaD4sbZ7AcMbnYOQAkPUjvuXrTF2DNOEouc40gdU84sjuM/LKjEff778yIWFneKDopNw4eIqpP6gFV3zIoHyS40teMu1djMR4LN0J2IgBqK+F357Wy0KjBj6Ws/NMz5EAOiIDnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l4y46THO9iiVLLibbJ7FAhhzKgjZPnJDgK/n1iqgJw=;
 b=IRIT+cbi/632dZ17sZcCS0M0ZpuNgeRlbWMiZu1J3SQrFDCuryMcE5aTtlqvc1zgOcVcAZCIvN8C0NHN217PW9IUVoJDka2zNOn8jdp0RBPsSq0tyRNAPzzQUyNRyfni5geeR6+3lHIjUkCYh+RtvliBk4JuFcncqqSV+spmOOV1VpEkqLeZwuDObNJiHaDuUNdlBeMkFrCZoMe4ppUSttsNXrTZcfwWrEEmaVvy0CN31q3Zdc3MPfA7N9aPy5thvPrnnJI+Tm3q4mPbf60S0vnIWVjXg1uIm8SD1LDxqjuVxapd4qKPXlPbmWa5+BGI4se/SkZThBHhyKJDiHPwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l4y46THO9iiVLLibbJ7FAhhzKgjZPnJDgK/n1iqgJw=;
 b=jVIkUrI1duJACd38mUEI1DM0SpY1QOdlcl7njnT6YJ96bVrBhdfHlVdFPTCe3z58af05u9TyHNaPrd2F1WDpctP+LN1WVvv/Kys8/pjBLm8abVx5NRk2+YQvZuGHFbxXwOX6FS+jgCPkB6LeLf++rDnsI50CUi9FutV429AxgPnii2y04cv/cGGn4RmDjYJ6N6mHy2Jpxcf0P4sSEcnDciipMd9nCCX/EuZ9Z9VMyY4wixOHn7V54DndcJLSQ22O5EKjWrZfT/oAZcuEFexsftghdy6RVmQSxBVdOEubK99VWatr5ynsmivndbclULNBlqsk0UCPqZbeCvLfTzR6iw==
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com (2603:1096:4:10c::14)
 by SEYPR02MB5704.apcprd02.prod.outlook.com (2603:1096:101:5c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 09:44:12 +0000
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::11fb:db8f:df36:c049]) by SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::11fb:db8f:df36:c049%7]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 09:44:12 +0000
From:   Gongwei Li <lifangpi@hotmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, 972624427@qq.com,
        Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH v4] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
Date:   Thu,  1 Dec 2022 17:43:53 +0800
Message-ID: <SI2PR02MB4603E18266419AF72EB5864BDD149@SI2PR02MB4603.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [QbNIoBfGYPW7ClqmKi0H8+s0rbqtmD5Sb9el3icS2dc=]
X-ClientProxiedBy: TYCPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::7) To SI2PR02MB4603.apcprd02.prod.outlook.com
 (2603:1096:4:10c::14)
X-Microsoft-Original-Message-ID: <20221201094353.16654-1-lifangpi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB4603:EE_|SEYPR02MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: e5905c97-e5ac-4666-f56f-08dad3809a25
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSyqZVVgBkTCpibAa3vfdchxCmk5s/TtTqAaTLI16nFYdEq8PHxLs7NIRVQOhpsNnbZRhDW96qZ/Y0nVj7JD6TsyYF2shxntvk00knLIKnwqHdI8UlkDB7bSLeCAT2QsY/FJVWE1l0ePbRALv50MjqqRerzj0qqRGieez1oAPRp4ihTQfQXESvV4QNl4c/O9AxiHpLXkn4sVPksV0w/Iji16/9yPHvqPCF1DwrSMyE9Vrr6amza6EqqqyBKL6CANBDTkzz6AIf4DgKQf8fZnYxbtqMWBZs736/o+sFRCDQYlJxBhne4OZxvHcIVPqQ174GLIM6Dxrsx+JoX0LDbAqINPT6hZsfP53UWoo+R+YSRSvETLe4Lti9zB4/LqXLb7YyR5RaEsMNSFVMLEN6UHDKSKrsK1IAiEon9yyvqh8WcmXTdqyX9g/iYY7GwVlwauPTXLa6DhgF6T3PiAhoIwVk36O2gGGWmeBprtGRvBswdsvNMDCq432pY5UnzKOyQEbX98PDpZX+58ceF7K01glnwK6E9p8iq3DdPoQlPfbqMz8AOzVBX9e/ha7+8G5mo8jllEYTMzY8HGL74V6IJyiBkTQfppa5kEn9dJSrOwLIM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQ12KFnTUOvVyY0X/C2B+LhC4LgcdbgZYgcAgc3ccAx0WXhvshPVkynF7O4q?=
 =?us-ascii?Q?ORjSFOjD44T6VBk8h81oNEQ3wBcUfw278izfKCcW090pO1YwMFH/VVBDOBhr?=
 =?us-ascii?Q?hHt0NURVxz0hyjIld19sEmtjs67/nW/uSg1iK2K1darUrRKYbJQ6NLlbso2h?=
 =?us-ascii?Q?4Pq0B7/Zci9XYLN2OXuWx9yqVCIFq1ibfEyq0oDJvXt6vv20mqyPONkqiAUz?=
 =?us-ascii?Q?hshoJRFTE594kPmLpD8InSKKW3V9PrM3+YEQUvJvYq/i/Kmpvhv1PL3+lzuz?=
 =?us-ascii?Q?5SvapV6oWqtLkrkiI8obOnz7LOynd2dDEPqLPY98yJUvI1Ndn4QBz5Gxnkti?=
 =?us-ascii?Q?KLvNUfDG0afOVrLGGJdRlCBq0gB484LnU51wb02Idwxp8aWCgfJ1ZWHm4BuE?=
 =?us-ascii?Q?hvgONVbPPvXAL4m749Cr8eflI9uyWJ1Zq3G/zzyrREyxg/O5tr/DJtEsc/wL?=
 =?us-ascii?Q?gPN+XYURzCXb6j2SAtoGa7cODQUoT34ksEfQ52kXUZEuRQlIMwAObSzZyIhe?=
 =?us-ascii?Q?jZtPsgjLRxgnLx7kG9g5Xkxp4jS0REydhHrLfCERSrqzD3oK7tY9QPiTrCv+?=
 =?us-ascii?Q?K+PsrO4Eaa1aaOFiCUfLsJXfUIHTWlSRlbRP5ZyPnH9+6gXkCvpKIV1rphmy?=
 =?us-ascii?Q?c1TnmmIaarIgU4opAZ5tdNBzAZCKPfulz7MwZow/CXn3Zz78AoroVhWL6+KZ?=
 =?us-ascii?Q?oc3mdZuXUtEXGHcvuJlGIUf569WJ3ufMr93q2/j1qTTcj4vVMq764WNxPxru?=
 =?us-ascii?Q?Dxhf2zD8V/Oo4qHTVx9V4JLz5Uwj6IBEZw4k5EkQg8tw8GC4FH/n639Tc3Y+?=
 =?us-ascii?Q?/AE7fUgiee3O3oetyDYj8JWgxIa4WPIowAXnjrqJP8z+1Gst2j5SyY+NpRIw?=
 =?us-ascii?Q?GpHg1FwK5bOzlqpKpUMmh75mOKwMxeWWGW7pqqRmOAAE/2ZI/hwmK0Qgn2tA?=
 =?us-ascii?Q?8d4duebzUHPq+SMeN3BkuC5gYCYqA/sNiDOT0wy6MXR9+lblaayKRfYebZnq?=
 =?us-ascii?Q?FGOu7FitqkycHEJi7obgMy9AtmL8Vmz2LT4zmunXyLBxuhksP1Ihyj5z9MF5?=
 =?us-ascii?Q?+k5qpzHXPRvu8TZQBau3KW+hqsNpvsUWlJp0jISHEGO2ovobIDboQTAqiSuU?=
 =?us-ascii?Q?378ODsvBO2xMhJmAFXs37uXUAGxbVEOZ3pPaZmY+BqS0c0KkHNEG6QBxt3nT?=
 =?us-ascii?Q?Hpn+4qDFBFry9ZVQahj+1DvtLRTzrkJTz/TyRjcbRAXwlcxIN+b23yPbgsRf?=
 =?us-ascii?Q?nlANXrNury3mRGGyTcpQHn3oIeH7PUURasWCNDoPvQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-20e34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e5905c97-e5ac-4666-f56f-08dad3809a25
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB4603.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 09:44:12.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5704
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gongwei Li <ligongwei@kylinos.cn>

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
 - Modified the commit message

v3:
 - Modified the author personal information

v4:
 - Mddified the email address
	
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

