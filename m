Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54D63E715
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLABaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiLAB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:29:58 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2039.outbound.protection.outlook.com [40.92.53.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE70C9801B;
        Wed, 30 Nov 2022 17:29:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui54m7JqNWH471RSZxKTBBku7o9PBsBhYWh+fjfnMMRb6TZXe4cEUpkTqMW1EX/FmWcfTlyVyKcIWhydW4e+DfYovz8vLo6VihJ2dwOcMS4x+MDsAVFuyz72vIZrIBBxkF0jU6Kmjb5hv5FWgwQaieZ0QeUfCArK/rhwTaKyVSLdBtFqW8XDbkU4FcplWs+uHx2oKe/wZTUjrEHpqERUD9COW0q+2A/Ux5I8lNVQXqczQfPme9GvCoGci79HiyubgbKR0UAJeHAcsu8QFbyNhd2H0g0i4VaHsWPY07JcOcEM3Ltvrw6GTMi8+UnzSKi0CKh7izIui+PoRmpuoIQ1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9agmhi0aVElqPUVcoBGalmNrg9vO8UAEPDwyEi+nWug=;
 b=GEQOQ1Tcqod/NnEBWmDrVFEXkNbm3gUuVgf0PCOVE0nvab7FtuwePL/t+n/tp4eAjY23lty6/xP5OIA9oidu0rY2KjTDz8z2NYQJllmd8HrQTj3RaBDjfY7kliwhO+2wDIsYXLm6AjK5pzzuzdBoC3T8C7mzo1o1J32QsldfNPhD9q/N/C85ON7bGx2ylJII/bQ8MpN/1YQqChqtmJi+JMz73GvjKKEMf+/bUX2U3FsaSpUsy8y1+Z7k+pUJkRAoyhigTs72VAF/DdExb9VjFf1hwwmCWEEc5wnwcsSVzvvRMCn/KvyTkIO3PSfdK7j69clGoqj288TShjIWV/q8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9agmhi0aVElqPUVcoBGalmNrg9vO8UAEPDwyEi+nWug=;
 b=o7DloGwOXzbTZBIF17jzyjsWhAqHkf3jS2HL8VOdhfHsMdT/JcMaxXx+SqTvoIZGO5mOiPDWnfos+pbHcuQjer9IySRKqpkfKZmUsLJ+j8TUGKgrYscLzODRHD0SHGMxHWhEm+2fz+Pxv5HqUOOrbbUrtMEDhfa96uQTZXj9g/Xwvx7I+XYxpax9DzaiV9gNHKlh1vPA6rScUraQBrteDc+j+hLn/vPQNz06zq6usAGg4sPEe1RMNZ2UTyfy1mboo8fUhguHs+vHXl14cH26HVUUaYF5g+6N2fZjdS1B1EQ4aEi/0VuFf09ELW9kDkn5k0bIhIv6GQHsS0FukvjwvQ==
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com (2603:1096:4:10c::14)
 by SEZPR02MB5590.apcprd02.prod.outlook.com (2603:1096:101:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 01:29:53 +0000
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::11fb:db8f:df36:c049]) by SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::11fb:db8f:df36:c049%7]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 01:29:53 +0000
From:   Gongwei Li <lifangpi@hotmail.com>
To:     pmenzel@molgen.mpg.de, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        972624427@qq.com, Gongwei Li <lifangpi@hotmail.com>,
        Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH v3] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
Date:   Thu,  1 Dec 2022 09:29:16 +0800
Message-ID: <SI2PR02MB4603E1ACBD47EA74D555A198DD149@SI2PR02MB4603.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5kT7chJk+2imqRB9ZiPSzpqL/e+dD2nKDyKycHm7+mo=]
X-ClientProxiedBy: TYCP286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::19) To SI2PR02MB4603.apcprd02.prod.outlook.com
 (2603:1096:4:10c::14)
X-Microsoft-Original-Message-ID: <20221201012916.12385-1-lifangpi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB4603:EE_|SEZPR02MB5590:EE_
X-MS-Office365-Filtering-Correlation-Id: 091e2c2a-ebb2-4075-58cf-08dad33b8c02
X-MS-Exchange-SLBlob-MailProps: qU6xv4dnpLHkcjlN9EE+U4lKp+zy0s8/ErPHOrkdtt8B5ORNeWwGfTN20UhHoWm22WTZHFtVpWhdP5++MKD8Ot0z9PsKat/ouBz635Ag5d7pFcO0Ravbg9rIZlGTzTNOFzuc/RcIDn9wa4QV4DgkPcbx1E+TUbeDgDaRqFrjD2emNkrj7b14nRJdwEYSPw4ZE3qPHSvggr1lVgsoSgLo+7sXt0w0hUp2SqcL1FhwNCMqmFCiyYbmyFStCzJ6d8ANCGHZAw4fcpOxgapTZKKEMvb1IL4Ga9QEuzOEtycPcFW5FGLwKz8tCYl/HKN0llTlOkjbSAt3jEdyY7aLrkF6KC/j1Fx/CT0jLqMdt1HPLjrVflGOvD16HecEvxSzHWDH5T+nfRV7mz9ewKZie/fPDEpgN0ofR2veQ/FeLD3ItuUoKiqYA0El+65b67curss3wiUUOolBCrrxn+Ku9d8hJRAjn7SwJThbH9SLTGI6+GFGOxqsqQOvMd1eZnaOG+ybcqEAZtp7SCZXUl1nx1YH8KAIdKUv7Xjm3pcHt49RdjVN5dwZNNuCAPYt424RXZT+dRxKI7dNsy53emQOsCcQ6joE1pFLgt5Dypu2hYZUAj/u2/GghqK0Z8byIqO83UKji56oN1XkqrR/gZ6M14EIOnlszEZDEBgfI6ZbGGG2/eJnQ6FesMOrcciqfaVKyHrPyN5y1mRUhLZeUW/emqB7e6NORrS/Bl1krBJ/TV5S2TRNh8H8hETasFPmPK2vh8Lp0orHeGNWcoXjdXIH2glz8g==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+LEfSBL3USESJgEssnXcnWuXLEogUmoc683VXscJKx04Qqo5Ot1bA4SUUgrFXUQTo7elME7mr7N+almTZCIb0zTl7CRRMF5zyGaxZTJoCx45t9kryxrC1GL/UbhZVaurgLCqdqWJUs+5SX3dBIhfoQt2JtaA//dQaBgM1W8Hq4ns9VcU35JZEEb347+HQxeElh7obYj6id3d4QqnGEri3YsUTYtKlp0wikB4Ie9cPeqG/cZMzN5uDkViKE4c2yUa6+R8h9/C895XCv81gZFcfO75f+HInZ0LY5KGJBXoLYDN6lo2Zao0lYsy4EjW5SuWFqypIqQ6FzsHLwA/HFTmP/pTlmvhemNTytidudqBxUALqFGb4hRsZKftWy4Fb50yhhROjtutSLy2YE0nmstTsAl6ZXhjXSCHZS13pWfJ7q51cW0q6pzbc+eNgUsrfJIHwYk3dnuhBJ3na6Cx6p6DevHutEwicgdbS0S1NN/8vFz+FRbksiDts5OCy1TiQmL1FCiV/BUQu/A/3LvqLdsouv+qXbibEgDI90aPuc8ODhv8qZQjngTHGEYiDj4Ux3wFI6ki25Apq55g4or9hGJauVIVkZULEQxWd+bzUnYX/GkQm2DRb1pdVlEWdHZijWhdc5IgbSDp85gQ2dQVx8wQsXwnH9OxoBEIDIjIUasHfE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xgox/BN3HC/WTSZbCvDJTtctEJRVuQrVEPq6kMA/NlU0/YtG0WCUhuWsqf65?=
 =?us-ascii?Q?PgyvlpjPRIHxNZYRp2ZOHhnyjHPfRyDgKrRje3LWrI+na0o89ScCXyY06Hs/?=
 =?us-ascii?Q?/G8VUIkFjGY8HYHER76/+dTPG7lAOTZaQu1r7yr/eqQEF/aeZAQVjYGgCusy?=
 =?us-ascii?Q?05TQew/XAmM/FPEt1fa8DqP/lJp2veXvKl1tUhTED+kRz0wOJjdf38Cqoejv?=
 =?us-ascii?Q?TAc+0z6Mvmrya9n/WfXCYwdrMCxStrVHM0c1dHEiS7M7BVMhoRNl0DMBEWmt?=
 =?us-ascii?Q?TPkNebwwtbukZemXlqnyq91SDOACsEtrm4IeZ2myhNarzjFNMq20pwD5L3+F?=
 =?us-ascii?Q?A/P+QS4ztHZvQJdBZegxD83e5I5k2YUPsIBqN2btjRHGe1eLdY4uynDi4xIN?=
 =?us-ascii?Q?3YJBeLZmALfESJz5eepTrA3Pqcv/+7Ascw5Me5hl3HPOrRRaE4dsIo2VsL+m?=
 =?us-ascii?Q?5un2+SOGbqWutA49GiP03ljq1HPbVacFMR+0R7b4lChhx4WXRhP/Br69HuZO?=
 =?us-ascii?Q?x0TVNaxQ/oTP0pZuzVlGBbCX4INsUgjhJOaJ1vOqHRalkEJLfLCsXotGn2eR?=
 =?us-ascii?Q?jWrH4onVKiCaZRzoAHRK2bmj4bxcflBerLt+Aywjjc2sVqEm/kPBj2CZtTIc?=
 =?us-ascii?Q?Lx67zOkcLm6up+B+J3WAeIbYo8kD2Yb+O4ah29eJBFuuaggve02vhFMRWluM?=
 =?us-ascii?Q?WMCIblkoPgN9aEmjPgnLVk5a+4p4i35GkwAxzP+UIWEXfrANx5N3LfiGob7+?=
 =?us-ascii?Q?KWtrwDH2yUJyPbUtZIG+vxxRQSl0Gv196RlgCBRH8sn+EIRZPrqHRJZjrxRL?=
 =?us-ascii?Q?q0U9Tf0837kM+JZH5GK4bnrG2B4S/vBDbcROd7BtaoAkeklzvBqE610p8LRx?=
 =?us-ascii?Q?n16PEj/aaf/QeRpomGvuvL8+a0h+k7xRhqQvHB3Ap2LHwk6Rp7UQUtTGWh8+?=
 =?us-ascii?Q?PiMYbsPaCrxqXQ54wpmhCqkPzxGBI2hipz9GoDTCryWAd660HTjKY4Th/ryJ?=
 =?us-ascii?Q?R4jnx6cUNW8MZV6epc0Fo9xdRD2gJvJpWTYGlvMssqxKzM6PhmrqXbxAokJe?=
 =?us-ascii?Q?IUw4M51j2UBNVlk1HMeoU7JuHEh8q1NwRYxMyXvultgUspUsTLMS5DH/HSUz?=
 =?us-ascii?Q?5jj84r73VhCn0bVul7DNQa1livSuHPMACNmigmCiXwAyrws+BMneCxcjUi62?=
 =?us-ascii?Q?wM/zUq62t/oKAAfqNt08xEtq9qkABlbpyuN4RBgxBm19Ly7jJjoz92MWXeVA?=
 =?us-ascii?Q?PDSaYCg7GSHjtuvE+06K/4U/031q3U7ziHO2wlRFlg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-20e34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 091e2c2a-ebb2-4075-58cf-08dad33b8c02
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB4603.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 01:29:53.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

