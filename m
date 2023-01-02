Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CED65B372
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjABOlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjABOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:41:10 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2039.outbound.protection.outlook.com [40.92.103.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707C610AF;
        Mon,  2 Jan 2023 06:41:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6A1CT0WMIY4f1oAujysoCV9M7QOF9zP695f7OOM5tRVYTNs/63xX5audfgpaGD3Gki/YnA4BTT2bpU/xadE7i5zr7AczdWRKNBfuSMJJy2+hJwIojiNZQXzGjaaD3peOCmA7T54q/N07mI8Tc5+SJ0RRR7sQbSxRfgj384G1S1uXR6DsNFiRx44PrMPOwCojHRiujkhQhcKhNtjzwvVQiNm1TmNtG4K8iz+PISoZmO69+Xb7Gs2pIgP8gP/bI+dKFDw6p0mCGJptn4bDuPTaFGkwDgzVyyb3pvooqZwO9GyfuP+rfyAYcnjqyIthuCk0xEevPAJr29X/K0ewCfB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW3/Kw8QHWc2ywFMsT9T7eZ/+DR4ICnrc4EyrsasRIc=;
 b=Pp0xCYDOyzj/4ngpwwtpjLC8QkSetJpZNkmXIVdhJZZh/fmBR389cJQL5Vum82Gbxo/57ZE3NOOA3B0U4cD+rYzZJdptL7SLTV2mX8CefBfe0KKCJgA22EeSlFlKWsZoytLuMbE+m1zM1W2125jBa4TUQcec8xh4wB5PE7cI+zFSzeOyMsnfBIThlVVMD9LISdpLI1Zu/x8nzbvVUBz2WTE36aOhVnlvgZFseRWocHBvJ/gSksrwiQP9UIWAVdlAqSwwCDhSrBUHVfwwIY5qs9m/Lk7Eqi/tOgH/N3HOp5qZ+Yma6j+A2xRIzjwJQWlm8E9csrhZ4sSKBweAquXDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW3/Kw8QHWc2ywFMsT9T7eZ/+DR4ICnrc4EyrsasRIc=;
 b=S+MUeDw2tkY2hEtv/ZwG3W5FwCrfLFo+bE/G85bnsEUCgUHvU/Au06/F7zQimr7Re7Vx0hMO/ackYV50XwgIQLAoTs0B9oDHfWnsrQcX4YQs1JGmnP0PzoS5Xs4Lz+sOMhSzs/Auxi46n6gAbptcTvGVZZpz7x//KRTXKzJyI2wjiYErjPc0lyl+IqbkQSIf+3FWPmmTqSVpAU6va1/QjOnA0ll+S2WAJESgnIBNQ6brTfJwWI6pZOkODn3NLZu+SdlYU2Jvlpl1jFHMcH5Ru1T4q+m/dY5n+x9BR+FqTL8ORTMLW9hBoKbCDLxzzi9r3+AVPFzWJzGlf1ygG70hzw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB9277.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:117::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 14:41:01 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 14:41:01 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: [PATCH 2/2] brcmfmac: Add PCIe ID of BCM4355 chip found on T2 Macs
Thread-Topic: [PATCH 2/2] brcmfmac: Add PCIe ID of BCM4355 chip found on T2
 Macs
Thread-Index: AQHZHrg8x1kT5HSHkE2GsL/urEyCtg==
Date:   Mon, 2 Jan 2023 14:41:01 +0000
Message-ID: <B5647DBC-3D99-412F-BD04-071950D3CD48@live.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
In-Reply-To: <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [6kIr0GQZxgep4qQw6YJIlW8+YaR3s7HGleoaVYbKqGJQYchN3kB7UPTPYHAzqhsC]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB9277:EE_
x-ms-office365-filtering-correlation-id: 6ac702d4-58ca-47a8-3554-08daeccf5e9e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0DTF3ke3cBskdwdIRND6FIWH6foOHMMA8XbiHUsOW14s3+w2xw2euP/ZYvXKTCqS9CiE/kybUk+QPhmhBvbp2aabYYuGtYR5KBB701Vpea3hfR8pRI9EV9k+OwDam3Kp1tLhNhsYMcxswFIDpCAs5R6Oj4otjJk64cOKVlWyYOAFTg2lqgevpZEb6hCRUxeQC20ByEgHYXplPi+lyGVA5gfSUUDfuULHnBkin/uK6poEghZp1OAq62poZoBCjvz1sHx/cNSAGow2gTGuz4MaZ5plSuJg+2/gueQBqbkhg1cBo6xDbW8fDSRyXesUahdr12TOhPwX9dmCR9EMCtpzwg/aiir7aY4/fAxdeqvjhJHh9/FRehE3wfIa3rziS3P/wz7R/gx0DQc65FL7Pab4Op+t0citli7sWnq/COaVREGWGaknzC6AVSv00QEc0rMOaOltieaCBWmM86WkEH8I4vesu7kRguq/bTJj6+7laQnqOasBt/oSMTE4HgJB8URNFI1eSRWOX/w/r1RYGweaO2jW11r382fbvGXmwnDOXbps5nfa1aPBAtDJ6JjjA1OmMaCO1EZMioH3ZwEu+nfFGgYfAUKKun0dGIsg7+Fxi4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+xzfGgIT54gy6fk8e5vX/QZ84ZAqELKLz9RjZeIVRW67DQoa5BfpDG4Iynfw?=
 =?us-ascii?Q?QfzD0cY/7FAF8xivk1V2RM3ohK0sFotKGmux7htrjzObmMTwpUA8r1TrgTTI?=
 =?us-ascii?Q?RayjwiwLqtU+1P2roh8qvNUj/0QXqLo0OpfiGW7cbAFNTURSDQmDsNgYUOMt?=
 =?us-ascii?Q?y2EBVvBvi43LsPeuU9Hc9mPerAB/guyZ3kGWK8gBxKPesgS9JfeSOp7vHqOr?=
 =?us-ascii?Q?hx38eHLNyGEDAKKnNB+yj++MnzBp+DfCUtX/oD/x6byM8XPZDMafT64/S78y?=
 =?us-ascii?Q?bZorpon/qeka1sjnLhNd/VbD8L31Ex409Ypm/TcveUEPgrWCuP62izA4X7Bl?=
 =?us-ascii?Q?ON1CjZ+QA3ksLnKXvDLhnbJAgtqd+52Zxgmjr9AtKILyrz7DbST7Asq0aqng?=
 =?us-ascii?Q?pB8Xnq4uA/2sUmZ7O7BjTk0L1NHudvLzuZ/bwO3/fk7EVfXe7rAADCfcyLOm?=
 =?us-ascii?Q?y/wAlswzRUKvhzb208Wt7dc8NR5mhmrSSF3Mbe9k8YdcTM0i3zAzYbo5Rp7c?=
 =?us-ascii?Q?wj8sBEga93D0t1V/PqLSrAKTpxIvfzSOTfpzEAKqJ7Erpywbbu1Rc8f+qgbN?=
 =?us-ascii?Q?AZxvVEDuMHqVGqZT4Cy4gLkEDnJ1519fWJ5jEKrrvc63o2P6F+PVHkyuoal5?=
 =?us-ascii?Q?WL9s57FBxd9qUg/JSmMQpZHD3Shw0nVwPwykDH3knQxkmut6DMtVDeHeP060?=
 =?us-ascii?Q?opuKPNprCGu4tkT2qHqk1RpvI4Cy9h1qgSH5caVh34rHbdIrzQUGfUIQ4S0g?=
 =?us-ascii?Q?Yy8T6esuE6LggX3QGO8NJV5iueoCwZDUj3c2IiCKsuYbuQbrA04P/z5lczi2?=
 =?us-ascii?Q?cuChH1Ad/JPLRzf9N6kRk20srWYewfMjpRIRNOzmWMy6UlN5Gl7ze536LVYv?=
 =?us-ascii?Q?rjQzqX5RyzCAOh9ESi7OVOyR8GRVE1Hh9GiPOYaHoXxJarAv5riBhk21p7CR?=
 =?us-ascii?Q?lcjGWqi0hBwPzcH8rPcMYNdsLM7S7Ti7jsoj+6VcsfpaDB+B7BWgdTEZ5DAH?=
 =?us-ascii?Q?v1XGBSj8Oz8CFbSyei64+QookwBnzH+izGaNIBrmm+VrhthYOqMeqiEEzBsF?=
 =?us-ascii?Q?L23OIad5DIhLoMQ2F1gTwbJ/VXU1bNyDeZ8XUYq0FHiw5HqAZiWTwBQ7rilg?=
 =?us-ascii?Q?bhxk6cyYyXw8ZEYtRS5ob5OyIRW9WUsva6SJPRuGf7A/49Ax3fdknRhKphsu?=
 =?us-ascii?Q?xcNHVoE4fJofOdMrXgy5EDt5t/YYPyTCjgUKsNtM+5vbdQGJ7Zbi+y4SnVZy?=
 =?us-ascii?Q?BunO6FXpX+P58jgis9fJWEhU4ezBrn/IqAT/7bbRjOj4m7rEyogx8HJUt+pI?=
 =?us-ascii?Q?wBs01JbISLgIqZjQY8uN62Re/Y4mqg8Fl6EVjJewcishEA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD0C6D3F3B183141919161D9776759E9@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac702d4-58ca-47a8-3554-08daeccf5e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 14:41:01.5533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9277
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

Commit 'dce45ded7619' added the BCM4355 chip support. This chip is also
found in MacBookAir8,1 and MacBookAir8,2. This patch adds necessary pcie
IDs to add support for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 3 ++-
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 121893bba..2f338c5d9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -735,7 +735,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_pri=
v *ci)
 		return 0x170000;
 	case BRCM_CC_4378_CHIP_ID:
 		return 0x352000;
-	case CY_CC_89459_CHIP_ID:
+	case BRCM_CC_4355_CHIP_ID:
 		return ((ci->pub.chiprev < 9) ? 0x180000 : 0x160000);
 	default:
 		brcmf_err("unknown chip: %s\n", ci->pub.name);
@@ -1427,7 +1427,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		reg =3D chip->ops->read32(chip->ctx, addr);
 		return reg !=3D 0;
 	case CY_CC_4373_CHIP_ID:
-	case CY_CC_89459_CHIP_ID:
+	case BRCM_CC_4355_CHIP_ID:
 		/* explicitly check SR engine enable bit */
 		addr =3D CORE_CC_REG(base, sr_control0);
 		reg =3D chip->ops->read32(chip->ctx, addr);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ad7a780cd..0a7410196 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -78,6 +78,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwn=
ames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0x000000FF, 4350C),
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
 	BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
+	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFFFFF, 4355)
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
 	BRCMF_FW_ENTRY(BRCM_CC_43569_CHIP_ID, 0xFFFFFFFF, 43570),
@@ -92,7 +93,6 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwn=
ames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
-	BRCMF_FW_ENTRY(CY_CC_89459_CHIP_ID, 0xFFFFFFFF, 4355),
 };
=20
 static const struct brcmf_firmware_mapping brcmf_pcie_otp_fwnames[] =3D {
@@ -2599,6 +2599,7 @@ static const struct pci_device_id brcmf_pcie_devid_ta=
ble[] =3D {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4355_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID, WCC),
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h =
b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index f4939cf62..fee1ff526 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -37,6 +37,7 @@
 #define BRCM_CC_4350_CHIP_ID		0x4350
 #define BRCM_CC_43525_CHIP_ID		43525
 #define BRCM_CC_4354_CHIP_ID		0x4354
+#define BRCM_CC_4355_CHIP_ID		0x4355
 #define BRCM_CC_4356_CHIP_ID		0x4356
 #define BRCM_CC_43566_CHIP_ID		43566
 #define BRCM_CC_43567_CHIP_ID		43567
@@ -56,7 +57,6 @@
 #define CY_CC_43012_CHIP_ID		43012
 #define CY_CC_43439_CHIP_ID		43439
 #define CY_CC_43752_CHIP_ID		43752
-#define CY_CC_89459_CHIP_ID		0x4355
=20
 /* USB Device IDs */
 #define BRCM_USB_43143_DEVICE_ID	0xbd1e
@@ -72,6 +72,7 @@
 #define BRCM_PCIE_4350_DEVICE_ID	0x43a3
 #define BRCM_PCIE_4354_DEVICE_ID	0x43df
 #define BRCM_PCIE_4354_RAW_DEVICE_ID	0x4354
+#define BRCM_PCIE_4355_DEVICE_ID	0x43dc
 #define BRCM_PCIE_4356_DEVICE_ID	0x43ec
 #define BRCM_PCIE_43567_DEVICE_ID	0x43d3
 #define BRCM_PCIE_43570_DEVICE_ID	0x43d9
--=20
2.34.1

