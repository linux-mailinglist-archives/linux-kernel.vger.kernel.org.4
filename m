Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BAD7248F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbjFFQXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjFFQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:22:55 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC82FB;
        Tue,  6 Jun 2023 09:22:52 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356F1eiF030721;
        Tue, 6 Jun 2023 16:22:34 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3r229jsu66-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCKbQ6tl/RRGp9NJ2K6OfXW/TbuG8y9TtX3GG70d23a8jKKfi1g4YOov25Hkp4Xy0Wj1HHSoxJ3gya2iv4fl3sUy+9/9qz8Mvq9IHxWcPp5o8LlnGOSzuBmv/DHwSQEbpPg9bZsC5ypYS442pfkt7OGi7mg0f1fxnXl6KjsQ0zKG2G3fuLfr9VgNcdUiqzkTdevrQn3OTAhxvWyAajgtmoJ88i+wHIs1uPX4acflrjOV/RI3gQj1tr8kT6yDH9P5pm3bX6GDU/gzyhQkkoQa3DraBCciokBY30HYcdUJXRsJpW2bq3VHAlVzxZZpbsalIQXrI/YXStpe8/gsjl2+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy5IamwpQPH4r3Ot6D9NYABpiNwrTZ+HXvTjh4sTqGc=;
 b=i4w3qKMik4j55hWn6RdfcnDd98LV5ZcBS27T58C3zNhNWAYw1cmua6u7zMgzs0VrWaLnecxZTEFjYeKZWyWhDI3qAJNLZdrjmn5W/jYyEPrUuAnDDPqvqQ/9DjW3rxr7Or9jdF2QjDdt2GPHoEOlFc/OK8vjRIp9gE/oZQfAOxan6IDNf28cdkNVGmEGV7LFGKJ6kXpENalYWRhPRf13wwgqT4ap6r+mweW8iKXujInnhPjHfMGMk4nlQg51kYe03UiXk6eOf7w0rq0gKjocXyUIhpCVegF2TFaz6MfBxxVDYEIEI1eRpxKYASB+Rdsq62m1ZsIYkYVZwS79Aif1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy5IamwpQPH4r3Ot6D9NYABpiNwrTZ+HXvTjh4sTqGc=;
 b=Trj6w0hS7+R/FNszQYwm8MbPrCdwi1/NXcgzezrDhup4UFpHX/kMkmfmP9+o8ZexDubMql1rU9x9Wf4wFHJW6v7GgxSV6U2EmR126YC1l/dl1aJS9sUgbWfKg8izLl6FIHC/ojeDl09TI18icqZZWNR+0AiwkgpBWc1/Zp1Dh+sHz1RVmD4pJKkEcV7bF6sj1LK0TINAktef41dixswWfpSIu3smWA7cA5vvk2ZhsyisTkHbsJ5U7/hBGIPSAPrR4zlZv9hKK9FTYt4SsPFHngMsVU0tKTuXzkrQuuH00TUgw8O2wAGt3S4G05vTNkyWBbmiCKoZ4uFjY9NmOqwMVg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB4PR03MB8708.eurprd03.prod.outlook.com (2603:10a6:10:380::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 16:22:28 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:28 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol
 basic support
Thread-Topic: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZmJMVZdZ9jTlnl0a4bbb/rGp54A==
Date:   Tue, 6 Jun 2023 16:22:27 +0000
Message-ID: <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1686063941.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DB4PR03MB8708:EE_
x-ms-office365-filtering-correlation-id: 99a61ef3-8853-4c65-0c01-08db66aa3863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWp2KThgXD93vGlQF+v8tLzSge2WIbzD/y3/JrpArCLb2UWwkp+EANLBZNZutIPdypXBwlnwLVA3WAoPOPntHSwJMBp60Nh8lbnoFnz2Jl1u6tZVRc6dD+qpUoV/paKCKxEtUsQiLQkkZvtkCosSYzQUtFk2MnV/RFRmIBmnKmqetLmhTyCGd1YvCbIgz6DQ+awYoNc33tEX2QO9id9S9P/ENqYfLlkUJmoDlm/oyL4u7cIo7N+3FS9qa9lna83WPbEpHCWGubzMDQdwB3WfmY9jqTwe2CWiSlIMC2gesvmWGqxDcp8SLjcSxSJOgZwzNvT8bnOkEIln6d4ZnC5xlBK56G+CoabRzaDSXjWOXyfdmBf6xwxByDnim+03h8ej8QOhbT1h4jrMyAr8IUVkKCr8ReHvLYqGjywNIYJquqZr6zrYW8pONzQqzFMbJ/D4YOh2e2nb1QWakM5QvYGEAUSsbOSBj+tAnK9AHFqmRB4zmE/CKCjQtdT5L7tetE2jMsWdiM9OxfHcnf3B1w6OU7jn1InEdbzMfi98M/NxwPyxeXIuMex7FpRkzJpDlJapyOwVJVevkJRCItFJICeJKzmhWtjiJWeimyQl/GuNNBoIxFOABTxGrO0VXfVZJlFn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(6512007)(6506007)(26005)(2616005)(83380400001)(186003)(66476007)(66446008)(122000001)(30864003)(66556008)(66946007)(64756008)(76116006)(2906002)(6486002)(71200400001)(8936002)(38100700002)(7416002)(38070700005)(86362001)(5660300002)(36756003)(54906003)(8676002)(91956017)(478600001)(6916009)(316002)(4326008)(41300700001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V9O+EsWZqtLSNhbyKbiW6R1lSbjS2r/vo+xZyJhd3b7fCWbYht8gPQ8qhu?=
 =?iso-8859-1?Q?AzeqoInx+RtHTGh5w/fQW7QgwOHuWnGm2YfyBG9NLw6C4iAewcRmZHm3zM?=
 =?iso-8859-1?Q?SVJmnO7U1zK866+nBQB0657MDUd3vvS06oK+34+mkdQXUBIuqilqkoPi/b?=
 =?iso-8859-1?Q?LOUTAjpTes/BOP7s69/V6vr2E/PrPuCLnIn3zGo+wkAavRlpFNqvt4m3TF?=
 =?iso-8859-1?Q?6xmR+Aebvu6TIczJxyt/NHZ0SOFIS7GUJhdhq0R5k7fnR5f0X8Z14Veo3J?=
 =?iso-8859-1?Q?YImBStJzXEU1ONNLpwrg79e3G71Xb9pFoH4j1qnSFgZMptKCXyfQ56JtD0?=
 =?iso-8859-1?Q?BdPBna3K5yY1/T+GZpJ//rJcIDW8nI+g1535HLMbBNoItLDv0TDvFRPunA?=
 =?iso-8859-1?Q?YI9Q30jTzTgUd9Je4WMi3RZiI4cnI2Ve4zg9kzc2IRC6s95BcrGn4m30eN?=
 =?iso-8859-1?Q?uzRyXarC9Fas2v3r46G6XFHpFSAe5VZXOlIR3d0BgEvbnMgoXUZJVY3PoR?=
 =?iso-8859-1?Q?iZcle4lh8KoDr1Jm/j7xFyxzBU3PYqPAmMdekkWAqXvnOC5im3HosAfaty?=
 =?iso-8859-1?Q?U74SYoAmFf3eUCFoPvxNuXjX+S71WfFiZl0vg5C2i0s4msA2scOYrCAK82?=
 =?iso-8859-1?Q?8yRGe/1hhVAqU7UU5cfCIIiD5i3MnGL4IuOBeLlMqJXW/5poOKZrQNCA3x?=
 =?iso-8859-1?Q?DWNN7DqmVhZNroIP8j7ZFCXdfRGpj7bVlvjs1vTxOIjH27kFpvAEBIqx/D?=
 =?iso-8859-1?Q?S+c8+PSnj54y+gBB97UC0xbsX7Ei7iJlRPQo8GMCyNrD2D/Ntlpf6KpAZZ?=
 =?iso-8859-1?Q?AaiP6urazM+iMAq+2CHNbu9oDZT4jgM4llRzrLoWBpEnwb6+i1fnWHxoAR?=
 =?iso-8859-1?Q?EPnkDuD9zskOMCegL8EO0316+34V4DtcMJ8Wlp0cxnPdHC4DkEO14bP35H?=
 =?iso-8859-1?Q?iZn86l2ab4o36PRrvBDfLqR2B+kWQx3XGuhzasoJ9RKjqH1uDLAsL/gHj+?=
 =?iso-8859-1?Q?7UiYIoYyzCr8MsQPOZIvNtcvSHs6TOVmhpeyzM1DinrrzcSXG/dCgPs55Q?=
 =?iso-8859-1?Q?aalOeBfJT2fOROkbLA4ttSXMOMTbisScVW7fiTvR1qs1Vk6PaKitxiTZNM?=
 =?iso-8859-1?Q?ctQ+QZCR4n/aAlNheh0lan+5Dc5y65aZA94dEnw8I1z20bpwRedDICHqNd?=
 =?iso-8859-1?Q?c8yuwK0CGROC9LulU/znoxC4pVcSoGgmuxHIslnWEJ+RVY6+bxhn/Pv9kU?=
 =?iso-8859-1?Q?CfHWoJ5ImtGqkYB5Ba5sRtPsilBDZjlBGqppODv1S+12ULB03dCuqAFwPw?=
 =?iso-8859-1?Q?PsVBKpoxlLDgbkEb+wCXXEn5LsXLYCJQwxVQBUT9cXlBQzeSWkWz4GjN0n?=
 =?iso-8859-1?Q?jSPtHUMFB/D9MoOYA7Q4r3exZcVbPPkK/m6Y7JANJLm9pZ+OwB/j2ChwhY?=
 =?iso-8859-1?Q?SDePbldulrTFXcg4Vc9V4pOl1qutKdMLvrp3fh5WIS2ezWyAgOU58b2Eow?=
 =?iso-8859-1?Q?KagKRSN6nWtBN+s1/OmcNcmTOp8nFhPAAQ6avf793JjOgdQfHtRSX07mne?=
 =?iso-8859-1?Q?xqlavycmLve4Z7smWnSWoMz75YoXus06YML/RXWTZgpww5nzeFFUxUu6xc?=
 =?iso-8859-1?Q?TvKj+O7EJb9QeKLmiAYLef/s4X7MkDz3en6b1fbbHc2A0jR7JpC2fkHg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a61ef3-8853-4c65-0c01-08db66aa3863
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 16:22:27.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrTr7zEWL6+C5zgcWO4cLNGoFMovREkdZXZetFHgnNfBzfvZ4smeyk9LoDURex5mHF/Oi5ucYKoq3FPT4CV5+47pWL1RQ7hbK9dGMlXOrZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8708
X-Proofpoint-GUID: X2RToP8dzqUpTtZWx6muOr6mZ8yKyBrq
X-Proofpoint-ORIG-GUID: X2RToP8dzqUpTtZWx6muOr6mZ8yKyBrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scmi: Introduce pinctrl SCMI protocol driver

Add basic implementation of the SCMI v3.2 pincontrol protocol
excluding GPIO support. All pinctrl related callbacks and operations
are exposed in the include/linux/scmi_protocol.h

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 MAINTAINERS                           |   6 +
 drivers/firmware/arm_scmi/Makefile    |   2 +-
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/pinctrl.c   | 836 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  47 ++
 6 files changed, 893 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dab9737ec16..297b2512963d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20522,6 +20522,12 @@ F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
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
index b31d78fa66cc..603430ec0bfe 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -10,7 +10,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D smc.=
o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
-scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o voltage.o powercap.o
+scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o syste=
m.o voltage.o powercap.o pinctrl.o
 scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transpor=
t-y)
=20
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-core.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index 5be931a07c84..a9fd337b9596 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3025,6 +3025,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
=20
 	return platform_driver_register(&scmi_driver);
 }
@@ -3042,6 +3043,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 	scmi_powercap_unregister();
+	scmi_pinctrl_unregister();
=20
 	scmi_transports_exit();
=20
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scm=
i/pinctrl.c
new file mode 100644
index 000000000000..fc0fcc26dfb6
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,836 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2023 EPAM
+ */
+
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "protocols.h"
+
+#define REG_TYPE_BITS GENMASK(9, 8)
+#define REG_CONFIG GENMASK(7, 0)
+
+#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
+#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
+#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
+#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
+
+#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
+#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
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
+struct scmi_msg_conf_set {
+	__le32 identifier;
+	__le32 attributes;
+	__le32 config_value;
+};
+
+struct scmi_msg_conf_get {
+	__le32 identifier;
+	__le32 attributes;
+};
+
+struct scmi_msg_pinctrl_protocol_attributes {
+	__le32 attributes_low;
+	__le32 attributes_high;
+};
+
+struct scmi_msg_pinctrl_attributes {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_resp_pinctrl_attributes {
+	__le32 attributes;
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+};
+
+struct scmi_msg_pinctrl_list_assoc {
+	__le32 identifier;
+	__le32 flags;
+	__le32 index;
+};
+
+struct scmi_resp_pinctrl_list_assoc {
+	__le32 flags;
+	__le16 array[];
+};
+
+struct scmi_msg_func_set {
+	__le32 identifier;
+	__le32 function_id;
+	__le32 flags;
+};
+
+struct scmi_msg_request {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_group_info {
+	bool present;
+	char name[SCMI_MAX_STR_SIZE];
+	unsigned int *group_pins;
+	unsigned int nr_pins;
+};
+
+struct scmi_function_info {
+	bool present;
+	char name[SCMI_MAX_STR_SIZE];
+	unsigned int *groups;
+	unsigned int nr_groups;
+};
+
+struct scmi_pin_info {
+	bool present;
+	char name[SCMI_MAX_STR_SIZE];
+};
+
+struct scmi_pinctrl_info {
+	u32 version;
+	int nr_groups;
+	int nr_functions;
+	int nr_pins;
+	struct scmi_group_info *groups;
+	struct scmi_function_info *functions;
+	struct scmi_pin_info *pins;
+};
+
+static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *=
ph,
+				       struct scmi_pinctrl_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_protocol_attributes *attr;
+
+	if (!pi)
+		return -EINVAL;
+
+	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr =3D t->rx.buf;
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_functions =3D GET_FUNCTIONS_NR(attr->attributes_high);
+		pi->nr_groups =3D GET_GROUPS_NR(attr->attributes_low);
+		pi->nr_pins =3D GET_PINS_NR(attr->attributes_low);
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_get_count(const struct scmi_protocol_handle *ph,
+				  enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -ENODEV;
+
+	switch (type) {
+	case PIN_TYPE:
+		return pi->nr_pins;
+	case GROUP_TYPE:
+		return pi->nr_groups;
+	case FUNCTION_TYPE:
+		return pi->nr_functions;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
+				    u32 identifier,
+				    enum scmi_pinctrl_selector_type type)
+{
+	int value;
+
+	value =3D scmi_pinctrl_get_count(ph, type);
+	if (value < 0)
+		return value;
+
+	if (identifier >=3D value)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
+				   enum scmi_pinctrl_selector_type type,
+				   u32 selector, char *name,
+				   unsigned int *n_elems)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_attributes *tx;
+	struct scmi_resp_pinctrl_attributes *rx;
+
+	if (!name)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
+				      sizeof(*rx), &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	rx =3D t->rx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	tx->flags =3D cpu_to_le32(type);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		if (n_elems)
+			*n_elems =3D NUM_ELEMS(rx->attributes);
+
+		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && EXT_NAME_FLAG(rx->attributes))
+		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
+					    (u32 *)&type, name,
+					    SCMI_MAX_STR_SIZE);
+	return ret;
+}
+
+struct scmi_pinctrl_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	unsigned int *array;
+};
+
+static void iter_pinctrl_assoc_prepare_message(void *message,
+					       unsigned int desc_index,
+					       const void *priv)
+{
+	struct scmi_msg_pinctrl_list_assoc *msg =3D message;
+	const struct scmi_pinctrl_ipriv *p =3D priv;
+
+	msg->identifier =3D cpu_to_le32(p->selector);
+	msg->flags =3D cpu_to_le32(p->type);
+	/* Set the number of OPPs to be skipped/already read */
+	msg->index =3D cpu_to_le32(desc_index);
+}
+
+static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
+					   const void *response, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r =3D response;
+
+	st->num_returned =3D RETURNED(r->flags);
+	st->num_remaining =3D REMAINING(r->flags);
+
+	return 0;
+}
+
+static int
+iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
+				    const void *response,
+				    struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r =3D response;
+	struct scmi_pinctrl_ipriv *p =3D priv;
+
+	p->array[st->desc_index + st->loop_idx] =3D
+		le16_to_cpu(r->array[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_list_associations(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector,
+					  enum scmi_pinctrl_selector_type type,
+					  u16 size, unsigned int *array)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops =3D {
+		.prepare_message =3D iter_pinctrl_assoc_prepare_message,
+		.update_state =3D iter_pinctrl_assoc_update_state,
+		.process_response =3D iter_pinctrl_assoc_process_response,
+	};
+	struct scmi_pinctrl_ipriv ipriv =3D {
+		.selector =3D selector,
+		.type =3D type,
+		.array =3D array,
+	};
+
+	if (!array || !size || type =3D=3D PIN_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter =3D ph->hops->iter_response_init(ph, &ops, size,
+					    PINCTRL_LIST_ASSOCIATIONS,
+					    sizeof(struct scmi_msg_pinctrl_list_assoc),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int scmi_pinctrl_get_config(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   u8 config_type, unsigned long *config_value)
+{
+	int ret;
+	u32 attributes;
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_get *tx;
+
+	if (!config_value || type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_GET, sizeof(*tx),
+				      sizeof(__le32), &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	attributes =3D FIELD_PREP(REG_TYPE_BITS, type) |
+		FIELD_PREP(REG_CONFIG, config_type);
+	tx->attributes =3D cpu_to_le32(attributes);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*config_value =3D get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_set_config(const struct scmi_protocol_handle *ph,
+				   u32 selector,
+				   enum scmi_pinctrl_selector_type type,
+				   u8 config_type, unsigned long config_value)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_set *tx;
+	u32 attributes =3D 0;
+	int ret;
+
+	if (type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
+				      sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(selector);
+	attributes =3D FIELD_PREP(REG_TYPE_BITS, type) |
+		FIELD_PREP(REG_CONFIG, config_type);
+	tx->attributes =3D cpu_to_le32(attributes);
+	tx->config_value =3D cpu_to_le32(config_value);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_function_select(const struct scmi_protocol_handle =
*ph,
+					u32 identifier,
+					enum scmi_pinctrl_selector_type type,
+					u32 function_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_func_set *tx;
+
+	if (type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_FUNCTION_SELECT,
+				      sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(identifier);
+	tx->function_id =3D cpu_to_le32(function_id);
+	tx->flags =3D cpu_to_le32(type);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
+				u32 identifier,
+				enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx),
+				      0, &t);
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(identifier);
+	tx->flags =3D cpu_to_le32(type);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request_pin(const struct scmi_protocol_handle *ph,
+				    u32 pin)
+{
+	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
+			     u32 identifier,
+			     enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type =3D=3D FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_RELEASE,
+				      sizeof(*tx), 0, &t);
+
+	tx =3D t->tx.buf;
+	tx->identifier =3D cpu_to_le32(identifier);
+	tx->flags =3D cpu_to_le32(type);
+
+	ret =3D ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_free_pin(const struct scmi_protocol_handle *ph, u3=
2 pin)
+{
+	return scmi_pinctrl_free(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *=
ph,
+				       u32 selector,
+				       struct scmi_group_info *group)
+{
+	int ret;
+
+	if (!group)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
+				      group->name,
+				      &group->nr_pins);
+	if (ret)
+		return ret;
+
+	if (!group->nr_pins) {
+		dev_err(ph->dev, "Group %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	group->group_pins =3D devm_kmalloc_array(ph->dev, group->nr_pins,
+					       sizeof(*group->group_pins),
+					       GFP_KERNEL);
+	if (!group->group_pins)
+		return -ENOMEM;
+
+	ret =3D scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
+					     group->nr_pins, group->group_pins);
+	if (ret) {
+		devm_kfree(ph->dev, group->group_pins);
+		return ret;
+	}
+
+	group->present =3D true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *=
ph,
+				       u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!name)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_group_info(ph, selector,
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
+static int scmi_pinctrl_get_group_pins(const struct scmi_protocol_handle *=
ph,
+				       u32 selector, const unsigned int **pins,
+				       unsigned int *nr_pins)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*pins =3D pi->groups[selector].group_pins;
+	*nr_pins =3D pi->groups[selector].nr_pins;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector,
+					  struct scmi_function_info *func)
+{
+	int ret;
+
+	if (!func)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
+				      func->name,
+				      &func->nr_groups);
+	if (ret)
+		return ret;
+
+	if (!func->nr_groups) {
+		dev_err(ph->dev, "Function %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	func->groups =3D devm_kmalloc_array(ph->dev, func->nr_groups,
+					  sizeof(*func->groups),
+					  GFP_KERNEL);
+	if (!func->groups)
+		return -ENOMEM;
+
+	ret =3D scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
+					     func->nr_groups, func->groups);
+	if (ret) {
+		devm_kfree(ph->dev, func->groups);
+		return ret;
+	}
+
+	func->present =3D true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handl=
e *ph,
+					  u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!name)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name =3D pi->functions[selector].name;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_groups(const struct scmi_protocol_han=
dle *ph,
+					    u32 selector,
+					    unsigned int *nr_groups,
+					    const unsigned int **groups)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!groups || !nr_groups)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*groups =3D pi->functions[selector].groups;
+	*nr_groups =3D pi->functions[selector].nr_groups;
+
+	return 0;
+}
+
+static int scmi_pinctrl_set_mux(const struct scmi_protocol_handle *ph,
+				u32 selector, u32 group)
+{
+	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE,
+					    selector);
+}
+
+static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph=
,
+				     u32 selector, struct scmi_pin_info *pin)
+{
+	int ret;
+	struct scmi_pinctrl_info *pi;
+
+	if (!pin)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	ret =3D scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
+				      pin->name, NULL);
+	if (ret)
+		return ret;
+
+	pin->present =3D true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph=
,
+				     u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi;
+
+	if (!name)
+		return -EINVAL;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	if (selector > pi->nr_pins)
+		return -EINVAL;
+
+	if (!pi->pins[selector].present) {
+		int ret;
+
+		ret =3D scmi_pinctrl_get_pin_info(ph, selector,
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
+static int scmi_pinctrl_get_name(const struct scmi_protocol_handle *ph,
+				 u32 selector,
+				 enum scmi_pinctrl_selector_type type,
+				 const char **name)
+{
+	switch (type) {
+	case PIN_TYPE:
+		return scmi_pinctrl_get_pin_name(ph, selector, name);
+	case GROUP_TYPE:
+		return scmi_pinctrl_get_group_name(ph, selector, name);
+	case FUNCTION_TYPE:
+		return scmi_pinctrl_get_function_name(ph, selector, name);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops =3D {
+	.get_count =3D scmi_pinctrl_get_count,
+	.get_name =3D scmi_pinctrl_get_name,
+	.get_group_pins =3D scmi_pinctrl_get_group_pins,
+	.get_function_groups =3D scmi_pinctrl_get_function_groups,
+	.set_mux =3D scmi_pinctrl_set_mux,
+	.get_config =3D scmi_pinctrl_get_config,
+	.set_config =3D scmi_pinctrl_set_config,
+	.request_pin =3D scmi_pinctrl_request_pin,
+	.free_pin =3D scmi_pinctrl_free_pin
+};
+
+static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *p=
h)
+{
+	int ret;
+	u32 version;
+	struct scmi_pinctrl_info *pinfo;
+
+	ret =3D ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo =3D devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret =3D scmi_pinctrl_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
+
+	pinfo->pins =3D devm_kcalloc(ph->dev, pinfo->nr_pins,
+				   sizeof(*pinfo->pins),
+				   GFP_KERNEL);
+	if (!pinfo->pins)
+		return -ENOMEM;
+
+	pinfo->groups =3D devm_kcalloc(ph->dev, pinfo->nr_groups,
+				     sizeof(*pinfo->groups),
+				     GFP_KERNEL);
+	if (!pinfo->groups)
+		return -ENOMEM;
+
+	pinfo->functions =3D devm_kcalloc(ph->dev, pinfo->nr_functions,
+					sizeof(*pinfo->functions),
+					GFP_KERNEL);
+	if (!pinfo->functions)
+		return -ENOMEM;
+
+	pinfo->version =3D version;
+
+	return ph->set_priv(ph, pinfo);
+}
+
+static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle =
*ph)
+{
+	int i;
+	struct scmi_pinctrl_info *pi;
+
+	pi =3D ph->get_priv(ph);
+	if (!pi)
+		return -EINVAL;
+
+	for (i =3D 0; i < pi->nr_groups; i++)
+		if (pi->groups[i].present) {
+			devm_kfree(ph->dev, pi->groups[i].group_pins);
+			pi->groups[i].present =3D false;
+		}
+
+	for (i =3D 0; i < pi->nr_functions; i++)
+		if (pi->functions[i].present) {
+			devm_kfree(ph->dev, pi->functions[i].groups);
+			pi->functions[i].present =3D false;
+		}
+
+	return 0;
+}
+
+static const struct scmi_protocol scmi_pinctrl =3D {
+	.id =3D SCMI_PROTOCOL_PINCTRL,
+	.owner =3D THIS_MODULE,
+	.instance_init =3D &scmi_pinctrl_protocol_init,
+	.instance_deinit =3D &scmi_pinctrl_protocol_deinit,
+	.ops =3D &pinctrl_proto_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_s=
cmi/protocols.h
index b3c6314bb4b8..674f949354f9 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -346,5 +346,6 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
 DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
 DECLARE_SCMI_REGISTER_UNREGISTER(system);
 DECLARE_SCMI_REGISTER_UNREGISTER(powercap);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
=20
 #endif /* _SCMI_PROTOCOLS_H */
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0ce5746a4470..97631783a5a4 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -735,6 +735,52 @@ struct scmi_notify_ops {
 					 struct notifier_block *nb);
 };
=20
+enum scmi_pinctrl_selector_type {
+	PIN_TYPE =3D 0,
+	GROUP_TYPE,
+	FUNCTION_TYPE
+};
+
+/**
+ * struct scmi_pinctrl_proto_ops - represents the various operations provi=
ded
+ * by SCMI Pinctrl Protocol
+ *
+ * @get_count: returns count of the registered elements in given type
+ * @get_name: returns name by index of given type
+ * @get_group_pins: returns the set of pins, assigned to the specified gro=
up
+ * @get_function_groups: returns the set of groups, assigned to the specif=
ied
+ *	function
+ * @set_mux: set muxing function for groups of pins
+ * @get_config: returns configuration parameter for pin or group
+ * @set_config: sets the configuration parameter for pin or group
+ * @request_pin: aquire pin before selecting mux setting
+ * @free_pin: frees pin, acquired by request_pin call
+ */
+struct scmi_pinctrl_proto_ops {
+	int (*get_count)(const struct scmi_protocol_handle *ph,
+			 enum scmi_pinctrl_selector_type type);
+	int (*get_name)(const struct scmi_protocol_handle *ph,
+			u32 selector,
+			enum scmi_pinctrl_selector_type type,
+			const char **name);
+	int (*get_group_pins)(const struct scmi_protocol_handle *ph,
+			      u32 selector,
+			      const unsigned int **pins, unsigned int *nr_pins);
+	int (*get_function_groups)(const struct scmi_protocol_handle *ph,
+				   u32 selector, unsigned int *nr_groups,
+				   const unsigned int **groups);
+	int (*set_mux)(const struct scmi_protocol_handle *ph, u32 selector,
+		       u32 group);
+	int (*get_config)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  u8 config_type, unsigned long *config_value);
+	int (*set_config)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  u8 config_type, unsigned long config_value);
+	int (*request_pin)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*free_pin)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
 /**
  * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
  *
@@ -783,6 +829,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET =3D 0x16,
 	SCMI_PROTOCOL_VOLTAGE =3D 0x17,
 	SCMI_PROTOCOL_POWERCAP =3D 0x18,
+	SCMI_PROTOCOL_PINCTRL =3D 0x19,
 };
=20
 enum scmi_system_events {
--=20
2.25.1
