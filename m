Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976AB6DAB61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbjDGKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbjDGKSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:18:46 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1D86EB8;
        Fri,  7 Apr 2023 03:18:43 -0700 (PDT)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377AcPP012311;
        Fri, 7 Apr 2023 10:18:31 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2173.outbound.protection.outlook.com [104.47.51.173])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3pt36rt822-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 10:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtx8NUzPOgunaLDey1jnoEJzaP0aWXfWYgKDhcup0ngWzwLJr6CjIUKkXmsmcFzPek6ntYC/tjKBd9MtslJamSnz+FI2d1LzclH3HLYNWUSRWWyZK3EtGspcqxwEia7alD3zECPCzC1dWH8XcrhfQNv7jm8CdR5Pn2PQzZXOSkut2KIEr0MArFzr+41uM+Oc2KR8oyUhlmJByO5qctUY9gkqJwxcqvYEDU306s5lzjIphppHHDiAar2NXA/U+KLAIqFnF3DtS7suBahJ5rR68Qgz0KNCqQy9MgCM7MJL2EmdXZkckK7jo2AOVtth5tSVmrjNa/8QegMX8n8fzxsiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+ojNIuyhnArDw8nSuFKzvpz5cZvC58oTkzY8aQDOoU=;
 b=D8EEBBemzJFZZw2Z/76rRr5JhHHpr5oLB7CSHZ5jc6YFvrZDnMwYPt0894Zulzl9euZVgTRVZhhxH9+fAE43YxWfsuuSgtoXZwMTpPEtud2aVOHB+dZ/FoqoMDkNlF8RSng/aVZn5/ZgXG/AvIsGV9iajdZeh2ZLwTxqywBIJ/Tne0Viuc/KMiqDyRUSnxsc0uplqkUJccbPbwhXys8VFQu4vRk4U/sH6I/HEVTT4nwXZP57h4H66mqZiPkk35DiIriGzztqf0j/ZpKHAZrqRKQPK79onuwG8SRy6fLZjIi/MOEflMg8gTf0/k9U4HX0yjWUa2hZMvXzYtH6CRyXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+ojNIuyhnArDw8nSuFKzvpz5cZvC58oTkzY8aQDOoU=;
 b=fm91rZYxY/cbIAJOPHKHtG2X+tPiJF3Nxc7EzAQLb+s3V3QJyh+MSXNmc7RuCbA1jODEjYrCt8Rc2TSEQu9HCr5BbuNuII3msLU32scAbDf/rqATZdbVY1YhK3jP3GxIgF/ddGtuCIhBLoqAQY2IbU/NfWfFvvB8lO1pgbgVwK4RBVhOC4GDTcpI4gzNW2i2bIUIxKK1QSLfcQ8X6jOmMuKYAOuOKNzaX9uuAtTqVYW/etjuksaeZKyaDdfKNT0v7Y6gROHSFRi+oyvw9Aaq81rnlWtlYzSTBAjhRSEzKR+0nHtqYV+fKqmg+AkEV/3bhSya2izRHHlwk3ehosD21g==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DU0PR03MB8743.eurprd03.prod.outlook.com (2603:10a6:10:3ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 7 Apr
 2023 10:18:27 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%9]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 10:18:27 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Topic: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Index: AQHZaTpLwL07BD9460y7/F64OnMs/g==
Date:   Fri, 7 Apr 2023 10:18:27 +0000
Message-ID: <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1680793130.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DU0PR03MB8743:EE_
x-ms-office365-filtering-correlation-id: 39aa0719-83ab-4708-8a28-08db37516daf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kz7PGX5ECqojNfyoBUPX6Jel54fJo+yofc1yGxc4BMvy94ENQd3r4MeysDRtc8uwkVBoA6izCnUAiDNj5ZHKr4T9t7l9FvagdTbu9+nhObqcT0VJR72KgWgJmUseZpp7qVy5Sq0f9srdO3CMHiZtL/7wAWhbRF6H/sSxQXhPURxsKPkI7M2ym3A560oSWyv1I0dvtMnLZ1VYqy1kpx55Qut7UlvsIkp4BIelgHw5aE/jtSsLxLiQskMQprxbi4m97aLVgi0VMnFgJulrvAB7XtwE8O3Eteq10SVD64GFG6bTr0B6SSfqHH2IXyW/NKmiG8sknnoEAAts8VgzQxANcSkNt1nccR7euPUy1/0yQZCghmjjZnKBhHqWTy98JZ+JTSukFuS31Rig1GDfrEniqWbCkk0eFRAJAfN4SOzhsyKrG5vyvPcR2Ryi5byWxdvcI1TcLlrIggxt8fh/OcyrL5SQ9phXJAm6RDJ5JNbo3tFVKSNUltX0++1WH3FAVrf1TExxcvcIs68RhDeRYUpxgPJ9BffjFRH/5h24YErqg/bt2HQmRc5XPZpTypeeXkkECY2Cb6sh0rW3FibFArm2QGu+pfdbvNtDDHkehrdsGo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(316002)(6512007)(6506007)(186003)(83380400001)(26005)(30864003)(54906003)(122000001)(5660300002)(966005)(2906002)(2616005)(6486002)(38100700002)(8936002)(38070700005)(71200400001)(86362001)(41300700001)(36756003)(4326008)(6916009)(8676002)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(91956017)(478600001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cGZDp/9M81y5Zw5FZwbWJf5SdmbcyDOD0wsBNkmXIc9/fMpFEeQ7ndZk+J?=
 =?iso-8859-1?Q?RKMgKt7AbDk4pqfA0eeooinAq7jQPLTjnBWKebIRzvJLbxs83WPhVAro17?=
 =?iso-8859-1?Q?DRsJORt7gzDSyWy4jcUu7A1iGlDY1XyUvAxxJONn6yVYQyv/sSafGj1Crs?=
 =?iso-8859-1?Q?LfalKBOKE38Zq/tnV7ifjD+UDyDP12FidcfwGGO2ANKOJVi8o9WXkBoxfp?=
 =?iso-8859-1?Q?5Z2bTlNeTlK21mH6gFy2/yspKswXHlAZz2Df4iLdRaCuwhU6usb411lRC1?=
 =?iso-8859-1?Q?bnHsUl+O0+VL5i1UdBXYrwuUyX0Wc1V/DXa2X1G0tzyEDAusR/FS6M1NTv?=
 =?iso-8859-1?Q?zpgV3aKDVKKnR811RpXt8AoNORTjVjHZaveA5LRVzp0EYyrmJhpXkpGyWV?=
 =?iso-8859-1?Q?CQ/IfD19NCo2CweZTXWLo8PkY3WGoDmhejjv7DIxnS0N1FNwABuUHH0ugv?=
 =?iso-8859-1?Q?ac8bziU8Ecbg6Xl1SclguJcbNc+6iUMchmNsun0wTSKCFiGKVW+5X8GHnL?=
 =?iso-8859-1?Q?g1EeZVWPnsRv+wuja1ywVwehtZlQ8mCkDWmqmu5v2nTHu3/FKX4JTLW2yj?=
 =?iso-8859-1?Q?URzDz7i0OgroesXOqLx8/YZzg85Tr5BK9TZwroKuuv4yiUI29/QiZKSsvh?=
 =?iso-8859-1?Q?FjYJ343vvaAsBCQt52pWQ1MsTqh9BC8l2W4XwttUaP52KOWwK0mxPsmjkE?=
 =?iso-8859-1?Q?Ytrdxk/9uL0Ey/22e1E4Kuih1JpXYqRJfNWyVmw3/7SgIaxN97fxBns5d5?=
 =?iso-8859-1?Q?kpvx7rN6JWH2+z8utCyux+Ge1Y1vm8DPVwv2jY6r/tut4Z4HTJswgBLd/J?=
 =?iso-8859-1?Q?P0cMvs9rSVYzDMKlpXZ1kWoumZomLubA44M26XzwbK11M9xBHDXFu9DO94?=
 =?iso-8859-1?Q?gFPCkTFKdAIP/I00vY+22WKJu1E1askfGp0zemFb1cBa15Ik6yvUziMucL?=
 =?iso-8859-1?Q?tsBjN/+rpBUdyTg82yFeZuoCkWu2aSiPrcuJOssQ/G+c8RxBXpgzRpxbPS?=
 =?iso-8859-1?Q?XgaFOs+I0ta8KfuVjhgIGLP+xhlYIDBPgRpZvSiRmUgMGitRgHS3V1y/Qy?=
 =?iso-8859-1?Q?W2LbjFskAGUHWN5IXXnZCFx9gcBXkf8VtliPfx1feFQhnYTAPiA/APoCuB?=
 =?iso-8859-1?Q?0i4E9TwczYlpVfwNExq5yAVR0YAJA5gMSphvBn78ZmcCmKZ8HaVnTjaijz?=
 =?iso-8859-1?Q?n/K1S31q3TA+0NPPwZFjO9p59yeauOL2KedajQqhR9Xq1hClVku3uZgrbq?=
 =?iso-8859-1?Q?l/qe58Ajomn87p46i3gLVEVmy3bD/q04ibmZjXr+U4kAFnhnI55I9R4Mnp?=
 =?iso-8859-1?Q?/NR2PAyu9azDK8SuH5nRu2luPjmkkRI8xuLwsKUXWKw2skSQZesMvaiYxo?=
 =?iso-8859-1?Q?Sq9vy6KvG6C1MFmoAzOeaDB1WV6rWRdnysHK9bjINmTFp7LxteGp5GfalR?=
 =?iso-8859-1?Q?k2YOS1kdk7sd3unpkS2oi6aVkA8Ijuz0cONtOvydu22ZxJoQ1zDwrDlJES?=
 =?iso-8859-1?Q?EAhVWWybkyxeJWKPhAHwEKAAaWr6Pq72niVlS7tP0UvIctYu2UOAhde+NI?=
 =?iso-8859-1?Q?s5bPRIWSPFTrZMCWVPMW5Y/2w+48r5v9rpr2OH5CrTZ7BiLdYEMAc3WsRq?=
 =?iso-8859-1?Q?tHRE6C55fpEKscumTklqyiaoG7hpnrJdvhup0EvYx0TMywpFBI9c4mCA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39aa0719-83ab-4708-8a28-08db37516daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 10:18:27.4283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GYhmQyG9+tEDigZx0gJy4GZKM9XEY0Hd2sDQMBGbPs61SJ9wvo2gDVY24hGAE8uycBkJtN7HFWnQYB0//+EYUibdGw+IebrnEMz9f8ouAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8743
X-Proofpoint-GUID: BZNxYFZZj3mvnbGA68aa6rixGcbpgzhi
X-Proofpoint-ORIG-GUID: BZNxYFZZj3mvnbGA68aa6rixGcbpgzhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070095
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of the SCMI client driver, which implements
PINCTRL_PROTOCOL. This protocol has ID 19 and is described
in the latest DEN0056 document.
This protocol is part of the feature that was designed to
separate the pinctrl subsystem from the SCP firmware.
The idea is to separate communication of the pin control
subsystem with the hardware to SCP firmware
(or a similar system, such as ATF), which provides an interface
to give the OS ability to control the hardware through SCMI protocol.
This is a generic driver that implements SCMI protocol,
independent of the platform type.

DEN0056 document:
https://developer.arm.com/documentation/den0056/latest

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 MAINTAINERS                         |   6 +
 drivers/firmware/arm_scmi/Makefile  |   2 +-
 drivers/firmware/arm_scmi/common.h  |   1 +
 drivers/firmware/arm_scmi/driver.c  |   3 +
 drivers/firmware/arm_scmi/pinctrl.c | 905 ++++++++++++++++++++++++++++
 drivers/pinctrl/Kconfig             |   9 +
 include/linux/scmi_protocol.h       |  58 +-
 7 files changed, 982 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 281de213ef47..abc543fd7544 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16961,6 +16961,12 @@ F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
=20
+PINCTRL DRIVER FOR SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI)
+M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/arm_scmi/pinctrl.c
+
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi=
/Makefile
index bc0d54f8e861..5cec357fbfa8 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -4,7 +4,7 @@ scmi-driver-y =3D driver.o notify.o
 scmi-transport-y =3D shmem.o
 scmi-transport-$(CONFIG_MAILBOX) +=3D mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) +=3D smc.o
-scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o
+scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o pinctrl.o
 scmi-module-objs :=3D $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-module.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi=
/common.h
index 65063fa948d4..8bbb404abe8d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -170,6 +170,7 @@ DECLARE_SCMI_REGISTER_UNREGISTER(power);
 DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
 DECLARE_SCMI_REGISTER_UNREGISTER(system);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
=20
 #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(id, name) \
 int __init scmi_##name##_register(void) \
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index 3dfd8b6a0ebf..fb9525fb3c24 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -743,6 +743,7 @@ static struct scmi_prot_devnames devnames[] =3D {
 	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
 	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
 	{ SCMI_PROTOCOL_RESET,  { "reset" },},
+	{ SCMI_PROTOCOL_PINCTRL,  { "pinctrl" },},
 };
=20
 static inline void
@@ -947,6 +948,7 @@ static int __init scmi_driver_init(void)
 	scmi_reset_register();
 	scmi_sensors_register();
 	scmi_system_register();
+	scmi_pinctrl_register();
=20
 	return platform_driver_register(&scmi_driver);
 }
@@ -962,6 +964,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_reset_unregister();
 	scmi_sensors_unregister();
 	scmi_system_unregister();
+	scmi_pinctrl_unregister();
=20
 	platform_driver_unregister(&scmi_driver);
 }
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scm=
i/pinctrl.c
new file mode 100644
index 000000000000..037270d7f39b
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,905 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2021 EPAM.
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications PINCTRL - " fmt
+
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "common.h"
+#include "notify.h"
+
+#define SET_TYPE(x) ((x) & 0x3)
+
+enum scmi_pinctrl_protocol_cmd {
+	PINCTRL_ATTRIBUTES =3D 0x3,
+	PINCTRL_LIST_ASSOCIATIONS =3D 0x4,
+	PINCTRL_CONFIG_GET =3D 0x5,
+	PINCTRL_CONFIG_SET =3D 0x6,
+	PINCTRL_FUNCTION_SELECT =3D 0x7,
+	PINCTRL_REQUEST =3D 0x8,
+	PINCTRL_RELEASE =3D 0x9,
+	PINCTRL_NAME_GET =3D 0xa,
+	PINCTRL_SET_PERMISSIONS =3D 0xb
+};
+
+enum scmi_pinctrl_selector_type {
+	PIN_TYPE =3D 0,
+	GROUP_TYPE,
+	FUNCTION_TYPE
+};
+
+struct scmi_group_info {
+	bool present;
+	char *name;
+	unsigned int *group_pins;
+	unsigned int nr_pins;
+};
+
+struct scmi_function_info {
+	bool present;
+	char *name;
+	unsigned int *groups;
+	unsigned int nr_groups;
+};
+
+struct scmi_pin_info {
+	bool present;
+	char *name;
+};
+
+struct scmi_pinctrl_info {
+	u32 version;
+	u16 nr_groups;
+	u16 nr_functions;
+	u16 nr_pins;
+	struct scmi_group_info *groups;
+	struct scmi_function_info *functions;
+	struct scmi_pin_info *pins;
+};
+
+struct scmi_conf_tx {
+	__le32 identifier;
+#define SET_TYPE_BITS(attr, x) (((attr) & 0xFFFFFCFF) | (x & 0x3) << 8)
+#define SET_CONFIG(attr, x) (((attr) & 0xFF) | (x & 0xFF))
+	__le32 attributes;
+};
+
+static int scmi_pinctrl_attributes_get(const struct scmi_handle *handle,
+				       struct scmi_pinctrl_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_protocol_attributes {
+#define GROUPS_NR(x) ((x) >> 16)
+#define PINS_NR(x) ((x) & 0xffff)
+		__le32 attributes_low;
+#define FUNCTIONS_NR(x) ((x) & 0xffff)
+		__le32 attributes_high;
+	} *attr;
+
+	if (!pi)
+		return -EINVAL;
+
+	ret =3D scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
+				 SCMI_PROTOCOL_PINCTRL, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr =3D t->rx.buf;
+
+	ret =3D scmi_do_xfer(handle, t);
+	if (!ret) {
+		pi->nr_functions =3D
+			le16_to_cpu(FUNCTIONS_NR(attr->attributes_high));
+		pi->nr_groups =3D le16_to_cpu(GROUPS_NR(attr->attributes_low));
+		pi->nr_pins =3D le16_to_cpu(PINS_NR(attr->attributes_low));
+	}
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_pinctrl_get_groups_count(const struct scmi_handle *handle)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv)
+		return -ENODEV;
+
+	pi =3D handle->pinctrl_priv;
+
+	return pi->nr_groups;
+}
+
+static int scmi_pinctrl_get_pins_count(const struct scmi_handle *handle)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv)
+		return -ENODEV;
+
+	pi =3D handle->pinctrl_priv;
+
+	return pi->nr_pins;
+}
+
+static int scmi_pinctrl_get_functions_count(const struct scmi_handle *hand=
le)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv)
+		return -ENODEV;
+
+	pi =3D handle->pinctrl_priv;
+
+	return pi->nr_functions;
+}
+
+static int scmi_pinctrl_validate_id(const struct scmi_handle *handle,
+				    u32 identifier,
+				    enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv)
+		return -ENODEV;
+
+	switch (type) {
+	case PIN_TYPE:
+		pi =3D handle->pinctrl_priv;
+
+		return (identifier < pi->nr_pins) ? 0 : -EINVAL;
+	case GROUP_TYPE:
+		return (identifier <
+			scmi_pinctrl_get_groups_count(handle)) ?
+			0 : -EINVAL;
+	case FUNCTION_TYPE:
+		return (identifier <
+			scmi_pinctrl_get_functions_count(handle)) ?
+			0 : -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_pinctrl_get_name(const struct scmi_handle *handle,
+				 u32 identifier,
+				 enum scmi_pinctrl_selector_type type,
+				 char **name)
+{
+	struct scmi_xfer *t;
+	int ret =3D 0;
+	struct scmi_name_tx {
+		__le32 identifier;
+		__le32 flags;
+	} *tx;
+	struct scmi_name_rx {
+		__le32 flags;
+		u8 name[64];
+	} *rx;
+
+	if (!handle || !name)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(handle, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D scmi_xfer_get_init(handle, PINCTRL_NAME_GET,
+				 SCMI_PROTOCOL_PINCTRL,
+				 sizeof(*tx), sizeof(*rx), &t);
+
+	tx =3D t->tx.buf;
+	rx =3D t->rx.buf;
+	tx->identifier =3D identifier;
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D scmi_do_xfer(handle, t);
+	if (ret)
+		goto out;
+
+	if (rx->flags) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	*name =3D kasprintf(GFP_KERNEL, "%s", rx->name);
+	if (!*name)
+		ret =3D -ENOMEM;
+ out:
+	scmi_xfer_put(handle, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_attributes(const struct scmi_handle *handle,
+				   enum scmi_pinctrl_selector_type type,
+				   u32 selector, char **name,
+				   unsigned int *n_elems)
+{
+	int ret =3D 0;
+	struct scmi_xfer *t;
+	struct scmi_pinctrl_attributes_tx {
+		__le32 identifier;
+		__le32 flags;
+	} *tx;
+	struct scmi_pinctrl_attributes_rx {
+#define EXT_NAME_FLAG(x) ((x) & BIT(31))
+#define NUM_ELEMS(x) ((x) & 0xffff)
+		__le32 attributes;
+		u8 name[16];
+	} *rx;
+
+	if (!handle || !name)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(handle, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D scmi_xfer_get_init(handle, PINCTRL_ATTRIBUTES,
+			 SCMI_PROTOCOL_PINCTRL, sizeof(*tx), sizeof(*rx), &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	rx =3D t->rx.buf;
+	tx->identifier =3D selector;
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D scmi_do_xfer(handle, t);
+	if (ret)
+		goto out;
+
+	*n_elems =3D NUM_ELEMS(rx->attributes);
+
+	if (!EXT_NAME_FLAG(rx->attributes)) {
+		*name =3D kasprintf(GFP_KERNEL, "%s", rx->name);
+		if (!*name)
+			ret =3D -ENOMEM;
+	} else
+		ret =3D scmi_pinctrl_get_name(handle, selector, type, name);
+ out:
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_pinctrl_list_associations(const struct scmi_handle *handle=
,
+					  u32 selector,
+					  enum scmi_pinctrl_selector_type type,
+					  uint16_t size, unsigned int *array)
+{
+	struct scmi_xfer *t;
+	struct scmi_pinctrl_list_assoc_tx {
+		__le32 identifier;
+		__le32 flags;
+		__le32 index;
+	} *tx;
+	struct scmi_pinctrl_list_assoc_rx {
+#define RETURNED(x) ((x) & 0xFFF)
+#define REMAINING(x) ((x) >> 16)
+		__le32 flags;
+		__le16 array[];
+	} *rx;
+	u16 tot_num_ret =3D 0, loop_num_ret;
+	u16 remaining_num_ret;
+	int ret, loop;
+
+	if (!handle || !array || !size)
+		return -EINVAL;
+
+	if (type =3D=3D PIN_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(handle, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D scmi_xfer_get_init(handle, PINCTRL_LIST_ASSOCIATIONS,
+				 SCMI_PROTOCOL_PINCTRL, sizeof(*tx),
+				 0, &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	rx =3D t->rx.buf;
+
+	do {
+		tx->identifier =3D cpu_to_le32(selector);
+		tx->flags =3D SET_TYPE(cpu_to_le32(type));
+		tx->index =3D cpu_to_le32(tot_num_ret);
+
+		ret =3D scmi_do_xfer(handle, t);
+		if (ret)
+			break;
+
+		loop_num_ret =3D le32_to_cpu(RETURNED(rx->flags));
+		remaining_num_ret =3D le32_to_cpu(REMAINING(rx->flags));
+
+		for (loop =3D 0; loop < loop_num_ret; loop++) {
+			if (tot_num_ret + loop >=3D size) {
+				ret =3D -EMSGSIZE;
+				goto out;
+			}
+
+			array[tot_num_ret + loop] =3D
+				le16_to_cpu(rx->array[loop]);
+		}
+
+		tot_num_ret +=3D loop_num_ret;
+
+		scmi_reset_rx_to_maxsz(handle, t);
+	} while (remaining_num_ret > 0);
+out:
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_pinctrl_request_config(const struct scmi_handle *handle,
+				       u32 selector,
+				       enum scmi_pinctrl_selector_type type,
+				       u32 *config)
+{
+	struct scmi_xfer *t;
+	struct scmi_conf_tx *tx;
+	__le32 *packed_config;
+	u32 attributes =3D 0;
+	int ret;
+
+	if (!handle || !config || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(handle, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D scmi_xfer_get_init(handle, PINCTRL_CONFIG_GET,
+				 SCMI_PROTOCOL_PINCTRL,
+				 sizeof(*tx), sizeof(*packed_config), &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	packed_config =3D t->rx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	attributes =3D SET_TYPE_BITS(attributes, type);
+	attributes =3D SET_CONFIG(attributes, *config);
+
+	tx->attributes =3D cpu_to_le32(attributes);
+
+	ret =3D scmi_do_xfer(handle, t);
+
+	if (!ret)
+		*config =3D le32_to_cpu(*packed_config);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_pinctrl_get_config(const struct scmi_handle *handle, u32 p=
in,
+				   u32 *config)
+{
+	return scmi_pinctrl_request_config(handle, pin, PIN_TYPE, config);
+}
+
+static int scmi_pinctrl_apply_config(const struct scmi_handle *handle,
+				     u32 selector,
+				     enum scmi_pinctrl_selector_type type,
+				     u32 config)
+{
+	struct scmi_xfer *t;
+	struct scmi_conf_tx *tx;
+	u32 attributes =3D 0;
+	int ret;
+
+	if (!handle || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(handle, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D scmi_xfer_get_init(handle, PINCTRL_CONFIG_SET,
+				 SCMI_PROTOCOL_PINCTRL,
+				 sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	attributes =3D SET_TYPE_BITS(attributes, type);
+	attributes =3D SET_CONFIG(attributes, config);
+	tx->attributes =3D cpu_to_le32(attributes);
+
+	ret =3D scmi_do_xfer(handle, t);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_pinctrl_set_config(const struct scmi_handle *handle, u32 p=
in,
+				   u32 config)
+{
+	return scmi_pinctrl_apply_config(handle, pin, PIN_TYPE, config);
+}
+
+static int scmi_pinctrl_get_config_group(const struct scmi_handle *handle,
+					 u32 group, u32 *config)
+{
+	return scmi_pinctrl_request_config(handle, group, GROUP_TYPE, config);
+}
+
+static int scmi_pinctrl_set_config_group(const struct scmi_handle *handle,
+					 u32 group, u32 config)
+{
+	return scmi_pinctrl_apply_config(handle, group, GROUP_TYPE, config);
+}
+
+static int scmi_pinctrl_function_select(const struct scmi_handle *handle,
+					u32 identifier,
+					enum scmi_pinctrl_selector_type type,
+					u32 function_id)
+{
+	struct scmi_xfer *t;
+	struct scmi_func_set_tx {
+		__le32 identifier;
+		__le32 function_id;
+		__le32 flags;
+	} *tx;
+	int ret;
+
+	if (!handle || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(handle, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D scmi_xfer_get_init(handle, PINCTRL_FUNCTION_SELECT,
+				 SCMI_PROTOCOL_PINCTRL,
+				 sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(identifier);
+	tx->function_id =3D cpu_to_le32(function_id);
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D scmi_do_xfer(handle, t);
+	scmi_xfer_put(handle, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request(const struct scmi_handle *handle,
+				u32 identifier,
+				enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_xfer *t;
+	int ret;
+	struct scmi_request_tx {
+		__le32 identifier;
+		__le32 flags;
+	} *tx;
+
+	if (!handle || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(handle, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D scmi_xfer_get_init(handle, PINCTRL_REQUEST, SCMI_PROTOCOL_PINCTRL=
,
+				 sizeof(*tx), 0, &t);
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D identifier;
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D scmi_do_xfer(handle, t);
+	scmi_xfer_put(handle, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request_pin(const struct scmi_handle *handle, u32 =
pin)
+{
+	return scmi_pinctrl_request(handle, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_free(const struct scmi_handle *handle, u32 identif=
ier,
+			     enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_xfer *t;
+	int ret;
+	struct scmi_request_tx {
+		__le32 identifier;
+		__le32 flags;
+	} *tx;
+
+	if (!handle || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(handle, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D scmi_xfer_get_init(handle, PINCTRL_RELEASE, SCMI_PROTOCOL_PINCTRL=
,
+				 sizeof(*tx), 0, &t);
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D identifier;
+	tx->flags =3D SET_TYPE(cpu_to_le32(type));
+
+	ret =3D scmi_do_xfer(handle, t);
+	scmi_xfer_put(handle, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_free_pin(const struct scmi_handle *handle, u32 pin=
)
+{
+	return scmi_pinctrl_free(handle, pin, PIN_TYPE);
+}
+
+
+static int scmi_pinctrl_get_group_info(const struct scmi_handle *handle,
+				       u32 selector,
+				       struct scmi_group_info *group)
+{
+	int ret =3D 0;
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv || !group)
+		return -EINVAL;
+
+	pi =3D handle->pinctrl_priv;
+
+	ret =3D scmi_pinctrl_attributes(handle, GROUP_TYPE, selector,
+				      &group->name,
+				      &group->nr_pins);
+	if (ret)
+		return ret;
+
+	if (!group->nr_pins) {
+		dev_err(handle->dev, "Group %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	group->group_pins =3D devm_kmalloc_array(handle->dev, group->nr_pins,
+					       sizeof(*group->group_pins),
+					       GFP_KERNEL);
+	if (!group->group_pins) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	ret =3D scmi_pinctrl_list_associations(handle, selector, GROUP_TYPE,
+					     group->nr_pins, group->group_pins);
+	if (ret)
+		goto err_groups;
+
+	group->present =3D true;
+	return 0;
+
+ err_groups:
+	kfree(group->group_pins);
+ err:
+	kfree(group->name);
+	return ret;
+}
+
+static int scmi_pinctrl_get_group_name(const struct scmi_handle *handle,
+				       u32 selector, const char **name)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv || !name)
+		return -EINVAL;
+
+	pi =3D handle->pinctrl_priv;
+
+	if (selector > pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		ret =3D scmi_pinctrl_get_group_info(handle, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->groups[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_group_pins(const struct scmi_handle *handle,
+				       u32 selector, const unsigned int **pins,
+				       unsigned int *nr_pins)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv || !pins || !nr_pins)
+		return -EINVAL;
+
+	pi =3D handle->pinctrl_priv;
+
+	if (selector > pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		ret =3D scmi_pinctrl_get_group_info(handle, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*pins =3D pi->groups[selector].group_pins;
+	*nr_pins =3D pi->groups[selector].nr_pins;
+
+	return ret;
+}
+
+static int scmi_pinctrl_get_function_info(const struct scmi_handle *handle=
,
+					  u32 selector,
+					  struct scmi_function_info *func)
+{
+	int ret =3D 0;
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv || !func)
+		return -EINVAL;
+
+	pi =3D handle->pinctrl_priv;
+
+	ret =3D scmi_pinctrl_attributes(handle, FUNCTION_TYPE, selector,
+				      &func->name,
+				      &func->nr_groups);
+	if (ret)
+		return ret;
+
+	if (!func->nr_groups) {
+		dev_err(handle->dev, "Function %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	func->groups =3D devm_kmalloc_array(handle->dev, func->nr_groups,
+					  sizeof(*func->groups),
+					  GFP_KERNEL);
+	if (!func->groups) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	ret =3D scmi_pinctrl_list_associations(handle, selector, FUNCTION_TYPE,
+					     func->nr_groups, func->groups);
+	if (ret)
+		goto err_funcs;
+
+	func->present =3D true;
+	return 0;
+
+ err_funcs:
+	kfree(func->groups);
+ err:
+	kfree(func->name);
+	return ret;
+}
+
+static int scmi_pinctrl_get_function_name(const struct scmi_handle *handle=
,
+					  u32 selector, const char **name)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv || !name)
+		return -EINVAL;
+
+	pi =3D handle->pinctrl_priv;
+
+	if (selector > pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		ret =3D scmi_pinctrl_get_function_info(handle, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->functions[selector].name;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_groups(const struct scmi_handle *hand=
le,
+					    u32 selector,
+					    unsigned int *nr_groups,
+					    const unsigned int **groups)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv || !groups || !nr_groups)
+		return -EINVAL;
+
+	pi =3D handle->pinctrl_priv;
+
+	if (selector > pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		ret =3D scmi_pinctrl_get_function_info(handle, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*groups =3D pi->functions[selector].groups;
+	*nr_groups =3D pi->functions[selector].nr_groups;
+
+	return ret;
+}
+
+static int scmi_pinctrl_set_mux(const struct scmi_handle *handle, u32 sele=
ctor,
+				u32 group)
+{
+	return scmi_pinctrl_function_select(handle, group, GROUP_TYPE,
+					    selector);
+}
+
+static int scmi_pinctrl_get_pin_info(const struct scmi_handle *handle,
+				     u32 selector, struct scmi_pin_info *pin)
+{
+	int ret =3D 0;
+	struct scmi_pinctrl_info *pi;
+	unsigned int n_elems;
+
+	if (!handle || !handle->pinctrl_priv || !pin)
+		return -EINVAL;
+
+	pi =3D handle->pinctrl_priv;
+
+	ret =3D scmi_pinctrl_attributes(handle, PIN_TYPE, selector,
+				      &pin->name,
+				      &n_elems);
+	if (ret)
+		return ret;
+
+	if (n_elems !=3D pi->nr_pins) {
+		dev_err(handle->dev, "Wrong pin count expected %d has %d",
+			pi->nr_pins, n_elems);
+		return -ENODATA;
+	}
+
+	if (*(pin->name) =3D=3D 0) {
+		dev_err(handle->dev, "Pin name is empty");
+		goto err;
+	}
+
+	pin->present =3D true;
+	return 0;
+
+ err:
+	kfree(pin->name);
+	return ret;
+}
+
+static int scmi_pinctrl_get_pin_name(const struct scmi_handle *handle, u32=
 selector,
+				     const char **name)
+{
+
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!handle || !handle->pinctrl_priv || !name)
+		return -EINVAL;
+
+	pi =3D handle->pinctrl_priv;
+
+	if (selector > pi->nr_pins)
+		return -EINVAL;
+
+	if (!pi->pins[selector].present) {
+		ret =3D scmi_pinctrl_get_pin_info(handle, selector,
+						&pi->pins[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->pins[selector].name;
+
+	return 0;
+}
+
+
+static const struct scmi_pinctrl_ops pinctrl_ops =3D {
+	.get_groups_count =3D scmi_pinctrl_get_groups_count,
+	.get_group_name =3D scmi_pinctrl_get_group_name,
+	.get_group_pins =3D scmi_pinctrl_get_group_pins,
+	.get_functions_count =3D scmi_pinctrl_get_functions_count,
+	.get_function_name =3D scmi_pinctrl_get_function_name,
+	.get_function_groups =3D scmi_pinctrl_get_function_groups,
+	.set_mux =3D scmi_pinctrl_set_mux,
+	.get_pin_name =3D scmi_pinctrl_get_pin_name,
+	.get_pins_count =3D scmi_pinctrl_get_pins_count,
+	.get_config =3D scmi_pinctrl_get_config,
+	.set_config =3D scmi_pinctrl_set_config,
+	.get_config_group =3D scmi_pinctrl_get_config_group,
+	.set_config_group =3D scmi_pinctrl_set_config_group,
+	.request_pin =3D scmi_pinctrl_request_pin,
+	.free_pin =3D scmi_pinctrl_free_pin
+};
+
+static int scmi_pinctrl_protocol_init(struct scmi_handle *handle)
+{
+	u32 version;
+	struct scmi_pinctrl_info *pinfo;
+	int ret;
+
+	if (!handle)
+		return -EINVAL;
+
+	scmi_version_get(handle, SCMI_PROTOCOL_PINCTRL, &version);
+
+	dev_dbg(handle->dev, "Pinctrl Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo =3D devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret =3D scmi_pinctrl_attributes_get(handle, pinfo);
+	if (ret)
+		goto free;
+
+	pinfo->pins =3D devm_kmalloc_array(handle->dev, pinfo->nr_pins,
+					 sizeof(*pinfo->pins),
+					 GFP_KERNEL | __GFP_ZERO);
+	if (!pinfo->pins) {
+		ret =3D -ENOMEM;
+		goto free;
+	}
+
+	pinfo->groups =3D devm_kmalloc_array(handle->dev, pinfo->nr_groups,
+					   sizeof(*pinfo->groups),
+					   GFP_KERNEL | __GFP_ZERO);
+	if (!pinfo->groups) {
+		ret =3D -ENOMEM;
+		goto free;
+	}
+
+	pinfo->functions =3D devm_kmalloc_array(handle->dev, pinfo->nr_functions,
+					      sizeof(*pinfo->functions),
+					      GFP_KERNEL | __GFP_ZERO);
+	if (!pinfo->functions) {
+		ret =3D -ENOMEM;
+		goto free;
+	}
+
+	pinfo->version =3D version;
+	handle->pinctrl_ops =3D &pinctrl_ops;
+	handle->pinctrl_priv =3D pinfo;
+
+	return 0;
+free:
+	if (pinfo) {
+		devm_kfree(handle->dev, pinfo->pins);
+		devm_kfree(handle->dev, pinfo->functions);
+		devm_kfree(handle->dev, pinfo->groups);
+	}
+
+	devm_kfree(handle->dev, pinfo);
+
+	return ret;
+}
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_PINCTRL, pinctrl)
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 815095326e2d..68add4d06e8c 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -431,4 +431,13 @@ config PINCTRL_EQUILIBRIUM
 	  pin functions, configure GPIO attributes for LGM SoC pins. Pinmux and
 	  pinconf settings are retrieved from device tree.
=20
+config PINCTRL_SCMI
+	bool "Pinctrl driver controlled via SCMI interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	help
+	  This driver provides support for pinctrl which is controlled
+	  by firmware that implements the SCMI interface.
+	  It uses SCMI Message Protocol to interact with the
+	  firmware providing all the pinctrl controls.
+
 endif
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 9cd312a1ff92..6a909ef3bf51 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -12,7 +12,8 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
=20
-#define SCMI_MAX_STR_SIZE	16
+#define SCMI_MAX_STR_SIZE 16
+#define SCMI_MAX_STR_EXT_SIZE 64
 #define SCMI_MAX_NUM_RATES	16
=20
 /**
@@ -252,6 +253,55 @@ struct scmi_notify_ops {
 					 struct notifier_block *nb);
 };
=20
+/**
+ * struct scmi_pinctrl_ops - represents the various operations provided
+ * by SCMI Pinctrl Protocol
+ *
+ * @get_groups_count: returns count of the registered groups
+ * @get_group_name: returns group name by index
+ * @get_group_pins: returns the set of pins, assigned to the specified gro=
up
+ * @get_functions_count: returns count of the registered fucntions
+ * @get_function_name: returns function name by indes
+ * @get_function_groups: returns the set of groups, assigned to the specif=
ied
+ *	function
+ * @set_mux: set muxing function for groups of pins
+ * @get_pins: returns the set of pins, registered in driver
+ * @get_config: returns configuration parameter for pin
+ * @set_config: sets the configuration parameter for pin
+ * @get_config_group: returns the configuration parameter for a group of p=
ins
+ * @set_config_group: sets the configuration parameter for a groups of pin=
s
+ * @request_pin: aquire pin before selecting mux setting
+ * @free_pin: frees pin, acquired by request_pin call
+ */
+struct scmi_pinctrl_ops {
+	int (*get_groups_count)(const struct scmi_handle *handle);
+	int (*get_group_name)(const struct scmi_handle *handles, u32 selector,
+			      const char **name);
+	int (*get_group_pins)(const struct scmi_handle *handle, u32 selector,
+			      const unsigned int **pins, unsigned int *nr_pins);
+	int (*get_functions_count)(const struct scmi_handle *handle);
+	int (*get_function_name)(const struct scmi_handle *handle, u32 selector,
+				 const char **name);
+	int (*get_function_groups)(const struct scmi_handle *handle,
+				   u32 selector, unsigned int *nr_groups,
+				   const unsigned int **groups);
+	int (*set_mux)(const struct scmi_handle *handle, u32 selector,
+		       u32 group);
+	int (*get_pin_name)(const struct scmi_handle *handle, u32 selector,
+			    const char **name);
+	int (*get_pins_count)(const struct scmi_handle *handle);
+	int (*get_config)(const struct scmi_handle *handle, u32 pin,
+			  u32 *config);
+	int (*set_config)(const struct scmi_handle *handle, u32 pin,
+			  u32 config);
+	int (*get_config_group)(const struct scmi_handle *handle, u32 pin,
+			  u32 *config);
+	int (*set_config_group)(const struct scmi_handle *handle, u32 pin,
+			  u32 config);
+	int (*request_pin)(const struct scmi_handle *handle, u32 pin);
+	int (*free_pin)(const struct scmi_handle *handle, u32 pin);
+};
+
 /**
  * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
  *
@@ -263,6 +313,7 @@ struct scmi_notify_ops {
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
  * @notify_ops: pointer to set of notifications related operations
+ * @pinctrl_ops: pointer to set of pinctrl protocol operations
  * @perf_priv: pointer to private data structure specific to performance
  *	protocol(for internal use only)
  * @clk_priv: pointer to private data structure specific to clock
@@ -275,6 +326,8 @@ struct scmi_notify_ops {
  *	protocol(for internal use only)
  * @notify_priv: pointer to private data structure specific to notificatio=
ns
  *	(for internal use only)
+ * @pinctrl_priv: pointer to private data structure specific to pinctrl
+ *	(for internal use only)
  */
 struct scmi_handle {
 	struct device *dev;
@@ -285,6 +338,7 @@ struct scmi_handle {
 	const struct scmi_sensor_ops *sensor_ops;
 	const struct scmi_reset_ops *reset_ops;
 	const struct scmi_notify_ops *notify_ops;
+	const struct scmi_pinctrl_ops *pinctrl_ops;
 	/* for protocol internal use */
 	void *perf_priv;
 	void *clk_priv;
@@ -293,6 +347,7 @@ struct scmi_handle {
 	void *reset_priv;
 	void *notify_priv;
 	void *system_priv;
+	void *pinctrl_priv;
 };
=20
 enum scmi_std_protocol {
@@ -303,6 +358,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_CLOCK =3D 0x14,
 	SCMI_PROTOCOL_SENSOR =3D 0x15,
 	SCMI_PROTOCOL_RESET =3D 0x16,
+	SCMI_PROTOCOL_PINCTRL =3D 0x19,
 };
=20
 enum scmi_system_events {
--=20
2.25.1
