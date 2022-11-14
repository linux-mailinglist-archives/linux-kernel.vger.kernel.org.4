Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C33628901
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiKNTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNTPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:15:53 -0500
X-Greylist: delayed 3909 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 11:15:51 PST
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD7264B2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:15:50 -0800 (PST)
Received: from pps.filterd (m0166256.ppops.net [127.0.0.1])
        by mx0a-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEI8BsC005247;
        Mon, 14 Nov 2022 18:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=8/xjAcKJ26v0RyTE/HbDhXqsdTUPdqHhlZ0ALvp3q7s=;
 b=fQASbBm+Bp6Ci6Ls7hekV+wopRdCBZqVefFMw+mkvy6TTESXtJ9vgwga4kCAUW8Mu01T
 UunZVseVed7/5UhQLsCCUeqiRPVcfg0zJoWvOgNoujYo5Ve5dLsaKOeapJWt9BaUvMgW
 ZSJY1VokqE2r+ibT7nrxytnHZ+T7AIoBQRjpNQEygZRqF4aQ/bjXNkLHViuewbTa/qFX
 Cl58nSz4FC56HPcw7yefiuxub1b8R/dz9uAMm5Gy/DIpT0YbCKA5Q6j2ZCSDpLTRbIIa
 AFIIXAMvEg1jti6pglPOZI6ugXukaxwyoV4i/JWdoqcR7GbJ6GlG+sIbVyLtjedt2Sit uA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 3kt90very4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 18:10:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jdl8PGlBK/jxC/lROwKPjLM3w8zxnHuf+GoB/QrWDUiH0JQ+baAW7XoDrjdts7cXpU7678Po4vEXeMStk9AVFGWH6ZSzjz/kARwVKonsjf7WNsZYB07AhI6A+GENwIgm4H1slS4WKY1j6WyEpqwKZGILZfaJ7KFTow0x2QepsO+FnhoS+YbGZ55l+pvFH77BKHzQy6ey5u4ilxqWmeZI75xZ1AmDQ8ROz+zSJRzFwdTsRYsLncJi28QzoZbvgVXLEbdBDNRUERsrUtKD4zxOV2jQfDIfr6rf0wPGOgxOy92GfFlpGf8n4sBLro3aJrhpBkowsTHgLDbOeqr1Aw9sYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/xjAcKJ26v0RyTE/HbDhXqsdTUPdqHhlZ0ALvp3q7s=;
 b=Ea/cRXXTAIrLbvWKGm4GUrhpQ4rjHRdxByCZXFYz06DNSVEXZBSPug2uKgtkU5B0W4vP2PnD2n7XbdHqA7iiTBl3E3OE/oaAcgl90OOQ1rboIJh0ptCapcmwx/wgE1xJkt5glgOphiOnByrJ8cOpj0y/YND67eBz7Zzs9ndJT6WI440VvXxrYgWxEzgneekWP5pTsYQ7qHNc4IAGpGHdQd0y2g7UwzIs++Z4Z01reCh704uKBTTQAWXCTsYuPSA3gJ2DFV5vS2ifoah/qK/iD4U12j18SzsJZC2F4LDbkn2aroV/VQe6MQvpK4huuHmUc16Si9bRj8p4gLdZmuAG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from SJ0PR11MB5919.namprd11.prod.outlook.com (2603:10b6:a03:42d::15)
 by SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:10:39 +0000
Received: from SJ0PR11MB5919.namprd11.prod.outlook.com
 ([fe80::b129:820e:4c47:f662]) by SJ0PR11MB5919.namprd11.prod.outlook.com
 ([fe80::b129:820e:4c47:f662%2]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 18:10:38 +0000
From:   "Rawat, Arnav" <arnavr3@illinois.edu>
To:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH v2] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga
 14ITL5 laptops
Thread-Topic: [PATCH v2] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga
 14ITL5 laptops
Thread-Index: AQHY+FRm82Res3hQu0aWaSFCgIB+0w==
Date:   Mon, 14 Nov 2022 18:10:38 +0000
Message-ID: <2655386.mvXUDI8C0e@wirelessprv-10-193-125-189.near.illinois.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5919:EE_|SA2PR11MB5177:EE_
x-ms-office365-filtering-correlation-id: afb60f22-d9b7-421c-c387-08dac66b8906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hd472KXsSpZrxHrlcI4/1/eUrJRCQc5CFE56YmfpUuysgxyb3rPc1ke1oy97iKXBa1WWfjN1DcT7OGn0QH+ecSRwKKODIJYfSLtLt0cFJNCswNdoOLzNanEqTd2dnRqPaZJzHQ/ksbK/M8+iKoJHSQXsuP2kntaucX1keY3eTniOrOtJPSi67yS/wI0DEINOyQFxHnZ5TY2fHMvd1KpEQ9+k023KIgL/EaePA9s7Zz9upN84qApzJZYQQgIsxkS5IOwtJBaCbggP7TFUTufxLTUVCaiBBh38qLz7NW6moguTEkff3DwsQ/maAGv3cmZBh9XdoE+w6qzIHmL0fzeusrtqrYnoTopkRFg01Do65p4BQ+DkoUyJwKZkAHDigy/OBu1AaKt7YrXRJ4l1B7qfarejuMjYrWs/WjGhU5oIxReXO2i0fJwzZtQN+1xuXh0WGNk5gfsMzesjv69NUfoe2BCWgmVmE3du25xU4sO4mNevUrumbw+BF1QqCKOd1/U+cXb9RFu6gGhWrThN6lO5Rzknq8+vmHFgVOS/ijQwJPIBorAOZG6scMtE2y48TMxT2Gb86g8lq9VOwGNNf/OLkEP0ANKqCEjGCbh9xbZMEF5nhYH/8jlt749kvrXVNfd74EWsTR2Hqd3lUq5w2JslyuFRz2eKqK2jIkOXJIdr709altrWGFjCq+hqMbxxVXvEDQFW+jaI+bGrXJeF1W7umth7UQLp21ba2HG7QbxLwdfEhAE3BZAlOp3zvGwwgkdHxVHY3W/iaR4F/nC+IdGZv6Y1wI/zji//LEP06+du9zJNGT4tJgflmtxRi23JHQXX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5919.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(6486002)(71200400001)(66476007)(450100002)(786003)(316002)(76116006)(66556008)(66946007)(66446008)(64756008)(122000001)(75432002)(86362001)(38070700005)(38100700002)(91956017)(478600001)(6512007)(26005)(53546011)(6506007)(186003)(41300700001)(2906002)(8676002)(41320700001)(5660300002)(110136005)(83380400001)(8936002)(39026012)(102196002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sUOGeLZLf87q/s0MkGyMS/hHTJ5zPtDRP+UWRhbiNlzBDlDPMaizT2ICRTQk?=
 =?us-ascii?Q?r9CPWoAnty9aDoNAZrRTif2rFFZiah6CSHmcTRl+hdleMkLoXWsW3MxaMFK2?=
 =?us-ascii?Q?+3bG/mgFbdIOmAfys/RTSv2G6Ly79QuDVQEqummk+KBCiOWX18lCFWVH5GdO?=
 =?us-ascii?Q?BfdxYN58BoNnvxFcx7wxhu2O85aiOHtf+AkMPVN+wI9IHI1iNCvDrTTeuJ+8?=
 =?us-ascii?Q?XNOQPgi9Z/cqdpZmg7QPiG7piUikI0KROs7HTR6FdYTYNvu8SApSYmPfAHlK?=
 =?us-ascii?Q?tFYUz0KTm057pcSBlNu9X+8f4kJqxN6JimOjC5qFAMEutKzuGwVRXov00KKO?=
 =?us-ascii?Q?7mBNHQDzRe34XV36HrhYmww5OPY6JMn5mr+vjpF2IxCvNZjdDf9VrTlsXbZL?=
 =?us-ascii?Q?KcXmZJfmz6E7fX1ChnT+XNXWuxuLm9PNFeZFDHOfsG4b7TOy7GMguw9Yfgt0?=
 =?us-ascii?Q?nb9bTnchsF3Lx0gQDuK1dUCYakhIXv6C61Fq5x9a9KrB/GiyIbSQeEVamJH8?=
 =?us-ascii?Q?hFPQl2oJiT0tI8ttikhsiGG587DrLVFElP9rCuDzPk1IgL93PNb+74GtaoNn?=
 =?us-ascii?Q?UDhYft9areGG36dS6ypjwJMmTtb/bzFuwwu44E4U+uioaxUhjuEvajU0lLjC?=
 =?us-ascii?Q?MfM8vByq+xUN0bOuyp1G7HOVn797IFQSQGl4YbSsH9AXaQH86xO+MiQXTwH6?=
 =?us-ascii?Q?+NON2xf8F5TV3M1RzJMl5UTpv4fRg+HXXkJbsV8FL0WuK8/dnXK+20iChoX6?=
 =?us-ascii?Q?lpt7H8twl//mxIA07rB7+pO1aaS1R9jZDr863j9uyx/2UINg1lBriDbbhKEe?=
 =?us-ascii?Q?UU8MTFRGTWOqC7wlFPjMsIchJ+YpgZ5P3b4dLH9pLCHZ6PlZHRkHXNT9IPRB?=
 =?us-ascii?Q?Pn6l6Xdto70GyxzQUhd+KOfTteJGl0vjce+k2vSKe0n436t18A8tfTYVD5cY?=
 =?us-ascii?Q?O2J70EIIf2tsGOty9lhGUAOwen6p3ju4zrLQ8Nc0ZGuM3BYMnFJrkdIs8nCa?=
 =?us-ascii?Q?VfU0iESJyMMnkn3KTMA6sw7AseXo6PsHnbU0DPrghjALvm5Y2J/MGogtIVjZ?=
 =?us-ascii?Q?vwksqbJgJzzGozc4Te0fi8e1vZID16SwLmTYyvFFhW0G8dDYhTJb5pElMFPf?=
 =?us-ascii?Q?/r6vUb+yMV/ftdQdFzSKr1Xbi3hsx4sZ/C8vUv3iTup5I5QN3DW8KwtDTn4g?=
 =?us-ascii?Q?hCGcpNOXd45CYJaYWaC3vJVOjN06Oec7Hrnr7rO6rBgudFfGce+fiTUj1kIe?=
 =?us-ascii?Q?ODCjyrRLZfJIQEV8xCyp4PjJfHqBxR1DhEDX5k6dZ9GDTMiTiHjBGGe1tzPn?=
 =?us-ascii?Q?lT+KkFfHBd/jWptCGW6EhTfRCZi7xU53UdlMnYED7dXGt2NO6UVpRPstC5j+?=
 =?us-ascii?Q?DFMr/o7+LB3r2gjWorlwiEs7gUnyNlammhxh8Q+W5V01T15NP8K9ngT4BErn?=
 =?us-ascii?Q?9DfApaQ6PzhfBZ6Wdez2RsAHhnKGxLFpRwP3nwLbt1ilp3zLwlf3ef5xyFMV?=
 =?us-ascii?Q?aqjXVj6iz45VXa2OXo39d7v5vN3bf2/4/SDJhHrv22fwWz/Lu9oR5nMJvEdV?=
 =?us-ascii?Q?Or2RxNUZj3sdE6bq2H7YbKhCsa7VBI2cTf029wCru+61fx/uGTHCj+F/J8jn?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7A26BBD8375CD49A0568089705C9609@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5919.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb60f22-d9b7-421c-c387-08dac66b8906
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 18:10:38.8912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vB8cMo/46M5nk+OQCNRXrFl+lIh6/hV0Ax5yvGPKnwRtqWnwo8LlGLjo64y8wlE14YSd0AwLC3PW3ortV9zQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177
X-Proofpoint-GUID: AzKNDyI9dtrp80MBLNUpPORuD54XnBBj
X-Proofpoint-ORIG-GUID: AzKNDyI9dtrp80MBLNUpPORuD54XnBBj
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211140130
X-Spam-Score: 0
X-Spam-OrigSender: arnavr3@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH v2] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga =
=0A=
14ITL5 laptops=0A=
Date: Friday, November 11, 2022, 8:32:09 AM CST=0A=
From: Rawat, Arnav <arnavr3@illinois.edu>=0A=
To: Ike Panhc <ike.pan@canonical.com>, hdegoede@redhat.com =0A=
<hdegoede@redhat.com>, markgross@kernel.org <markgross@kernel.org>=0A=
CC: Rawat, Arnav <arnavr3@illinois.edu>=0A=
=0A=
From 90832a9a373570db2a62c3edf00cf129b59b0ba3 Mon Sep 17 00:00:00 2001=0A=
From: arawat <rawat.arnav@gmail.com>=0A=
Date: Thu, 10 Nov 2022 13:13:11 -0600=0A=
Subject: [PATCH v2] platform/x86: ideapad-laptop: Fix fn-lock LED on Yoga =
=0A=
14ITL5=0A=
 laptops=0A=
=0A=
The commit 3ae86d2d4704796ee658a34245cb86e68c40c5d7: Fix Legion 5 Fnlock LE=
D=0A=
set the WMI id for the fn-lock event on some Legion 5 laptops. However,=0A=
the same WMI ID is also sent on some Yoga laptops. Here, setting the fn-loc=
k=0A=
state is not valid behavior, and causes the ec to spam interrupts until the=
=0A=
laptop is rebooted, so include a check for this line of laptops.=0A=
=0A=
Signed-off-by: Arnav Rawat <arnavr3@illinois.edu>=0A=
---=0A=
 drivers/platform/x86/ideapad-laptop.c | 14 ++++++++++++-=0A=
 1 file changed, 12 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/=
=0A=
ideapad-laptop.c=0A=
index abd0c81d62c4..d1dcf57ce596 100644=0A=
--- a/drivers/platform/x86/ideapad-laptop.c=0A=
+++ b/drivers/platform/x86/ideapad-laptop.c=0A=
@@ -1491,6 +1492,17 @@ static void ideapad_acpi_notify(acpi_handle handle, =
u32 =0A=
event, void *data)=0A=
 }=0A=
 =0A=
 #if IS_ENABLED(CONFIG_ACPI_WMI)=0A=
+// Set fnesc state only on certain ideapads=0A=
+static const struct dmi_system_id ideapad_fnesc_allow_list[] =3D {=0A=
+	{=0A=
+		.matches =3D {=0A=
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),=0A=
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Legion =0A=
R7000P2020H"),=0A=
+			DMI_MATCH(DMI_PRODUCT_NAME, "82GR")=0A=
+		}=0A=
+	}=0A=
+};=0A=
+=0A=
 static void ideapad_wmi_notify(u32 value, void *context)=0A=
 {=0A=
 	struct ideapad_private *priv =3D context;=0A=
@@ -1501,7 +1513,7 @@ static void ideapad_wmi_notify(u32 value, void *conte=
xt)=0A=
 		ideapad_input_report(priv, value);=0A=
 		break;=0A=
 	case 208:=0A=
-		if (!eval_hals(priv->adev->handle, &result)) {=0A=
+		if (!eval_hals(priv->adev->handle, &result) && =0A=
dmi_check_system(ideapad_fnesc_allow_list)) {=0A=
 			bool state =3D test_bit(HALS_FNLOCK_STATE_BIT, =0A=
&result);=0A=
 =0A=
 			exec_sals(priv->adev->handle, state ? =0A=
SALS_FNLOCK_ON : SALS_FNLOCK_OFF);=0A=
-- =0A=
2.37.3=0A=
=0A=
=0A=
=0A=
-----------------------------------------=
