Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4F6195AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKDL4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiKDLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:55:40 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2075.outbound.protection.outlook.com [40.92.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE323EB2;
        Fri,  4 Nov 2022 04:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJBURa4VJmHhM4b5jMMqc7dCdfarHFfqHlZnWVQAFnhS5wuYXf5H0gO+ZyZokSoSQlNHa4zgpe37RznogyRzFf7FAevRbQxpkAfGDVSOEChS/DV6t0yj3PkJHKarGbU6XV8rVOWTAR13EV0d/yxIPx21x78lM+LPMse8TyED/sMUQp4C4UjX+KXs8YTUpvySTitU+ndBAoi4xdjoWMTDXSC8zFGmrzMbF1kHzFsBkevhcg9088SLDyDuisByn4BsMVQ5V+NtHGTEppClXidEMI5dVr4B3QIbtdVh4MXmkpQzFp1hULZbFhuKZfx4Jfsr0pPVknEmsFtSv0SGrJDUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AxIPdXcsYQrskZVcz927dpHO7YXP1jH9jfHvT5geFs=;
 b=c2f4+AUzH8YOxYGq+H/aVDPCppGjTBbx+jnphPABcjc1jpHnhW0ewZb37Lx+HRjuukS6BGepGhHTuwhi5LSgP/mJJXONwjImsOaM8QLfZh+81PgqxSJVLis4o4yxrPNV0g+gggKP19ziMuWwi14FNRjEOsYPirIiWqx7IsYARTLOfsAOZmS6fkGc3zUQ7rtVvq9BgDG0pToA6TVy6k0EcrtWZTr7wDh3v0ws40kArcV1Cvv5hjNxXxSfwnjPuapi+n3K0QHPA02tdpdZrC8dy3XT5DJ4M19TpMarwF6kfMO4oxpTHWF9WqND/YWWiBz5lAE8awx/8PX5RredfKd0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AxIPdXcsYQrskZVcz927dpHO7YXP1jH9jfHvT5geFs=;
 b=JRZf7xn3nLY/nfwfUizMls4TwsLkEw/aJTrO8etM5W79t6fIvwRCRQvaNVzzakQ/oLzikogMl20ofgI8mdvQUvnSSbmOhCEG73EZKVmH5lMFpUA9lrMoOtYUBiMWkgshSjc8gi7iJvYHCipGGx+OeczLzPst+RCH/vxk2R1iLSX1BwVZbW/Uqof+hHvYPTwWNl1Y7EDZuDoh7TsuXLFx58TSX6/8bpxtwgmn+W4otklkI7UC3WYiNap9sDb5AguDZeCI/lawo5ToiDV3RGloyO2DYrWGubxKhiGtBNpyU7kXq5nQsnpomXeP1qcaNQJ7VfUDL9eZcZqNmsvw8U8tsA==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAZPR01MB7843.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:24::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Fri, 4 Nov 2022 11:55:35 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294%9]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 11:55:35 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: [PATCH] HID: apple: Swap Control and Command keys on Apple keyboards
Thread-Topic: [PATCH] HID: apple: Swap Control and Command keys on Apple
 keyboards
Thread-Index: AQHY8ERZa3FoKSDxwkSesm/DJoXoaA==
Date:   Fri, 4 Nov 2022 11:55:35 +0000
Message-ID: <7AC64680-44F7-4605-95E9-B5FF97A78D2A@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [O0hB9y7RIPkVCcCO1Vy2KK5KnBzrGVR/]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAZPR01MB7843:EE_
x-ms-office365-filtering-correlation-id: 9dd6f6cf-cafd-4a2c-5cfd-08dabe5b7b98
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAl+VE5zpwasPoDcztDjSmqJgV83QJyzN3qQYE2DhxjXC9hHmFszBhaa0L4sT7CwdAzIz+QLlKRuwtkJlH6CebjCuonK3GFnlj5YUNv263ZBcVOoFFPfplBxUBAPzxLSER5mtxD0Maf3GT5NqIcO/vxwY6ACgsUebiADdatibOZ5jN77KWXKSOV1goWt0Wo0nN0onZXaQLl1pTg3/NcgypxdW3Pzu2Q1LcvdAy43Tm5MkHXIMTiC2egD/CGRWtY68z37BKZ0DRO4JprYXUuFkIX1xQJEih9OUqtkEjXdJd7nHeZgMqq9FLUanQH5M4w0MtfeZF1FXPHbCidzxV1B/aGrjsaLnT/TqH9bc9mlyo1eaWa6U57yPRqYxRQTGFO6f3R0XpYHojtNpGxvXNaIZrMezR1QH/n9zH24gTCFS8UI50Nf+DrELCgFq9SBb5Wf0dE5bvBAvPvcgcRC2GeqKtdy9WfRpEZI50DwUU/Xy6bIQLT7TOeA8ugNEXwiAuysw4/VHQ6TbgWXkr1nrAidXBlwGjRHuXMBFAkktXBbHQXMaz7Xs80wfLQ9OO6b+H/6UqYFa+tI00uPXh6R4eD3l0QIcalrd1qqIcBUvNwCUUJDSPEOFGle6m2MtzTEei6xEhOMKKkQbPSlQdGZcHGsig==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E3neTZTNx+ssHgvHBjd0COuXNPHnMEvgQqCLgkWeGvxD5g025hRsNgnF5J6O?=
 =?us-ascii?Q?Y/0BUdAtkXSvTNDh7Uj6We9rVewZzSpn35+gLEgWhN5Kn6aly46tPkWec5sR?=
 =?us-ascii?Q?1LgT6CcLHHaFdSJWwU5ORvVr3Hr3+ZSC8TZcby53V2ulWllUOADtnbwf2Ug2?=
 =?us-ascii?Q?kT8iPiiC9pWdbaUf48uZG96X8COlpyGQ+Ixdz29DJFnK8bE8/DDyve1ObKVD?=
 =?us-ascii?Q?tit+zShdVTb/x/6BH+RR9II0Zmr5Lh9T0j9Y2uDLsc32/Qm8VFEFfRl4IGxQ?=
 =?us-ascii?Q?K5MQpSS7XPI7gWKB4WM2B2nFch2W8WT4Q4S3IdGQJEfvUCatQbvrPCQ9BkWw?=
 =?us-ascii?Q?4gcYsaOXFvF13F8OtldtLM7CRfwRNcVDKm5iQTlO5nGOoQgPEWqRVKRr+2hW?=
 =?us-ascii?Q?7WPdL12c4aCio/KI+Xl6S+8E089u5S1AGKZdZfLgM8x0LgSYLT6MIMg0d6Tx?=
 =?us-ascii?Q?DNUsrPhnl+D66Pt8U0HNJWil8NK1Qvq+1sm3mHjSXg9V3HbJfRzf+zxsWzSO?=
 =?us-ascii?Q?AstPRyJjVtvETZfbnnl+Yk7v7bsbp/l9YYEKUwUcQjGV1Iy2Y9IqqrfP3Get?=
 =?us-ascii?Q?OfOBxfZqW/Z/0VhaRdUENtc0fY+lGw0Hn5tCQZzUtM40OqiJv/hEd3I0W+qE?=
 =?us-ascii?Q?ywCc8C7s+gcBAA647PxhzYOtAHrDIIt13qXi6nn8lotCwML8f0PXycLvWt0G?=
 =?us-ascii?Q?0XVFSdKYvCM9jyVcp+2lMiN8f7pdr3Lix5OBKeTsVPufjzEOoaGnq8fokv/Y?=
 =?us-ascii?Q?NCayNcErLnekwW71x4zcR8368ORCpX9miIvatXRkLe+Xjbj2/z4sJ1VbHgSl?=
 =?us-ascii?Q?rSuRxB22KmqOE4oXPJUm0lnQIgh+8XKRX/5yOiB6/tS9Qp13f9+Nx7LYS097?=
 =?us-ascii?Q?Qk5NA6vUw/gW+S9Vy2FVFeAzWyUz2V6zDElMh3Nv2rwyJDgWsCyAXajlpoLu?=
 =?us-ascii?Q?VL/glUqRTTmz2ciDkwq/rMRD4oov8dbJCTqX5tpl57WTJr8c0xYg3rlG7/b7?=
 =?us-ascii?Q?QaUBESWGIrjSBRg+CHGztuyOw3v52ipmOOlVGmrdTd8rcKRm6qbm3ejvWVua?=
 =?us-ascii?Q?sb44BIg8kY4YODNOwsqR7nmTVmtDcOZtezZJqU1aDm+BHlD1iuOmm8P1thSx?=
 =?us-ascii?Q?zE7IoUqKFUOgdBXrCBSd+/nb72UXte/+NZ9P/zstEYRSbUC9Sp5oFNlyGhFZ?=
 =?us-ascii?Q?Yg8yijTlUVMPpnMdQxUVBBWUoi4f9fbEu3HiA6NzgkLMsktgoXNyOQWNmn9I?=
 =?us-ascii?Q?xUTeIxkWvgRsjJMBwzx/KWv+0x4eLvMoM5Eb3QsOYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2C6CB428C4F204594415B0F4DD4E04F@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd6f6cf-cafd-4a2c-5cfd-08dabe5b7b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 11:55:35.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7843
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

This patch allows users to swap the control and command keys. This can be
useful for the Mac users who are used to using Command instead of Control
in macOS for various commonly used shortcuts.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index c671ce946..86188e803 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -59,6 +59,12 @@ MODULE_PARM_DESC(swap_opt_cmd, "Swap the Option (\"Alt\"=
) and Command (\"Flag\")
 		"(For people who want to keep Windows PC keyboard muscle memory. "
 		"[0] =3D as-is, Mac layout. 1 =3D swapped, Windows layout.)");
=20
+static unsigned int swap_ctrl_cmd;
+module_param(swap_ctrl_cmd, uint, 0644);
+MODULE_PARM_DESC(swap_ctrl_cmd, "Swap the Control (\"Ctrl\") and Command (=
\"Flag\") keys. "
+		"(For people who are used to Mac shortcuts involving Command instead of =
Control. "
+		"[0] =3D No change. 1 =3D Swapped.)");
+
 static unsigned int swap_fn_leftctrl;
 module_param(swap_fn_leftctrl, uint, 0644);
 MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left Control keys. "
@@ -308,7 +314,15 @@ static const struct apple_key_translation swapped_opti=
on_cmd_keys[] =3D {
 	{ KEY_LEFTALT,	KEY_LEFTMETA },
 	{ KEY_LEFTMETA,	KEY_LEFTALT },
 	{ KEY_RIGHTALT,	KEY_RIGHTMETA },
-	{ KEY_RIGHTMETA,KEY_RIGHTALT },
+	{ KEY_RIGHTMETA, KEY_RIGHTALT },
+	{ }
+};
+
+static const struct apple_key_translation swapped_ctrl_cmd_keys[] =3D {
+	{ KEY_LEFTCTRL,	KEY_LEFTMETA },
+	{ KEY_LEFTMETA,	KEY_LEFTCTRL },
+	{ KEY_RIGHTCTRL, KEY_RIGHTMETA },
+	{ KEY_RIGHTMETA, KEY_RIGHTCTRL },
 	{ }
 };
=20
@@ -407,6 +421,13 @@ static int hidinput_apple_event(struct hid_device *hid=
, struct input_dev *input,
 			code =3D trans->to;
 	}
=20
+	if (swap_ctrl_cmd) {
+		trans =3D apple_find_translation(swapped_ctrl_cmd_keys, code);
+
+		if (trans)
+			code =3D trans->to;
+	}
+
 	if (code =3D=3D KEY_FN)
 		asc->fn_on =3D !!value;
=20
--=20
2.34.1

