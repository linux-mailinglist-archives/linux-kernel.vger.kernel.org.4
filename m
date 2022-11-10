Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC06623E22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKJI6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKJI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:58:05 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D1657D9;
        Thu, 10 Nov 2022 00:58:03 -0800 (PST)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA8XalP019576;
        Thu, 10 Nov 2022 08:57:33 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3kr9d73vht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 08:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONP8oNYlX7Qc+C7cWCywZyw//kvR4/pWqa4O0NMwpAK5reEkGJq2v+idKZLzHbLVi+9JBf520uPAU40Tl9qanUtufp68fAyFxN0NSo74pfZ1MqRs6MxCGP1fhfQZxIW2I3+iV9a//P8ski4K4OyCckYb+Xe9GBgzoH7K+sa9Tg/kFVIapHJLxLonA90Neo9jqwkWP9dqSbjHKb7qRCskL8TTpKgHv2HYAqkg/vICyC2IrRfT1dgOi+UnRCYv26yBffhBL593oj0ebkDpxMqvQKktkvn3wOIn+x525gp3nJFF47mDZr0BjJxrmEMgOwb8h45zRMXJ2EeGWsPW0Dsnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcW+NVVeeduweYjZD7yPr4NghgcLnJ3t8K40X7/1iW4=;
 b=kOEQk2ibF/Pnuuh4XBImQPqfYi9C1//abi3PmkeUN3JJj49Xf7sR68LYPH0n5XF7nMdIaofG+Z3St11J/puBb4kOoyz9iHSTEMjJ2KOqRO8CxCEx+AtPCnJIigagkE69d/e4yCFlM8SJiZJBRMAjUe7kEbnoDaqRPacp0/i0axTW2Eh7IydmuYTCUkNrrsnyI9ny4iSDvD4A1Ji/JVLpNImp7kMicQbKvA77nGFYgygTJN1K78zGffSuln6Y8EskFmE+J2UL2Gp26WHs8sKEGPc5F7x0GrL2Xn4p246tSZAQbRbC8QbNmlOW/IBSs9lJcr+sGTXN0ECayv4hKRCs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcW+NVVeeduweYjZD7yPr4NghgcLnJ3t8K40X7/1iW4=;
 b=XURzts98T8OfOOL6eJKcrqSV+qZJALwTJZ+buxWNp5dnhJgfb6+KpxPArVaZeXw5FYft4tJvhp+GiOxXcwxUsf1LcB1wP4Z0G5+tHA3eViR7Y5VIgTnpg6iGECG1ZX6cjO5WfnVxrFAP2lWe/sE+S6s4d9BJmVTjkY0ieDYYvo4xVHFxR6EtCLYWWHgH3odyoSi9fQ3oh6F3dSGf3lq8V5kOIvJU5nMCEN4md76TZ3NS2gpSjq0s+6FccpnpWy6AgQgvTd1UfXus2YdbdlGW1taONZE5E0e/JGVDeKDDyQhCjqu53eIFcG+Y8R3JOhWTo6xGeU/tUnGg1f2N1n/cpg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS8PR03MB6822.eurprd03.prod.outlook.com (2603:10a6:20b:295::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 08:57:28 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::cc80:5238:61b7:43c4]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::cc80:5238:61b7:43c4%5]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:57:28 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 2/2] dt-bindings: Document common device controller
 bindings
Thread-Topic: [PATCH v6 2/2] dt-bindings: Document common device controller
 bindings
Thread-Index: AQHY9OJ1y3k80CKnGk2nkmUaURfjMw==
Date:   Thu, 10 Nov 2022 08:57:28 +0000
Message-ID: <c869d2751125181a55bc8a88c96e3a892b42f37a.1668070216.git.oleksii_moisieiev@epam.com>
References: <cover.1668070216.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1668070216.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS8PR03MB6822:EE_
x-ms-office365-filtering-correlation-id: caf65f31-dfe6-45a1-a9c4-08dac2f99872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1NFtc5qoPCv3+t9vwmxwtnmwb7dw4YurQdeoLPWdJCcNZDLyRXrHFo/kWqK9PGryROoWSd4aUGQKjaP/OvC0jMswkERDyafna4/7nHTihDPdyObQE1wg83oDbx75jlObTDtM82fWY3IbEbo5IovjfopxqU5QEy8h+rMoNFL2Qvz4YDof62/szHLXGZ47uXUXD1LdLnhK50R9mCrI5eHAmaCbdkYEcL/HsSXVf9XnFaWB2TjXKvhzVji/R1MZg7K2org+kYBGfewdZVyC97cRWmZsB/FyEg+ox7pUOjXlM/mabMcBwKjZQ5Lj18kFFtWaJl1Li0K4q8Ci13ye2hr1G45dBrTrlkEIJLQkexRkIfm8k9ZXkGHVM+1ON9xXnqhJigt7uNjpvMUg09lCKudhXau0eYjGV13Q3BWDv+SqH3emx8m1wtpRJmW7OeWZT7KR2QNg8G1bsCv1u1/GvC8HZojx6+aEyRfYvkK9tg9d2Bxq4XFgisewZ2/pQ1vqnUXbs40GtCbTXh8RCWA2xUmePiJPVbE23hPY+4IN6JOHh5DeFeEaG4J3eZPgYIsChcDyDpagsTrhCsvvtp6OTliFJK4RYEIuAaal5Xq0V33lQR/xWY2CgBjlnKVujPZQbmkPeHjX9R5acQ5FjoyuxXqltYZYbJRc12wqWMA8xjf/W4kU7zrm1NyaCf1Z4Qpbt0FZcHSrOZaqKgBTAZiD6Ou9EVSqZ3vhxp8wroMhXE/r1BDVOXVpoBihlSBysvcKsqBftdrLuLYlx9uuXH1jWYB5CKG44OIPzejNIiaEXvc+IM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(86362001)(38070700005)(36756003)(7416002)(2906002)(2616005)(6506007)(6512007)(26005)(83380400001)(186003)(5660300002)(38100700002)(122000001)(91956017)(66946007)(66476007)(76116006)(316002)(66446008)(64756008)(66556008)(8936002)(71200400001)(54906003)(4326008)(478600001)(6486002)(8676002)(41300700001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DzGC+OavsbpWS/IC4wQr6L+RRP0+z1eMZtaRHe1wJm/Vk4X3KXYvEyMQWQ?=
 =?iso-8859-1?Q?U1XBDY2tzZishiSdSfmuTkn3xasLiVsZbabgUCT5NPr4To46xVxJnmZR7f?=
 =?iso-8859-1?Q?6oj6legRQukwKN0t0m3aIJ9u7yjwAIBJ9auCw3dngZwCmPqrvpM5uKgXnk?=
 =?iso-8859-1?Q?GISwIG/RWnq0lcS0U6Tk6fK3pauKtXxLBjuKFfQ+sgHBwWAWLnsREArd3t?=
 =?iso-8859-1?Q?34LZQKpfO+4whoqx/NNkldPqpg5ykBCLAH+8EbAaeKKFUqd5ZoDcyvXjje?=
 =?iso-8859-1?Q?LyTfaCd2edYKuLIH5uBp3R9hAKcSgmbABOCRxsFQ8tPNZHfCW3JRsBrSHD?=
 =?iso-8859-1?Q?/h5PQgGiIvYJkCRWHsiVRbPqLNF9HK/plj/PEo4BT2lbjrxfjcnSt9r1u4?=
 =?iso-8859-1?Q?MCojD8Bc6XU4tITd7iUqh2jxY8qMLM5JD3JovOXL8/qFcNIl9ozXh0LU/U?=
 =?iso-8859-1?Q?y21QiVM26w4rUyoGUuR3V1a5ZhKFbZPPzSzO2FO5TWX5bF9SiMQBj62PKQ?=
 =?iso-8859-1?Q?eGfD+LtV4ozAn0a4cCfvx5Npo14hAUu1nPf+tJjyxY2/cTQhjmJkaf0FU0?=
 =?iso-8859-1?Q?gFFAeGtxv2g7dQARj5T7lu0zrye2ToaLb5CK+RoDkDl86EQg1sZ8G0YIgC?=
 =?iso-8859-1?Q?cD4QWHTuktHVoHqn4b1d3S2btY+3TRRIwPABbuWePlNtECJcUCxLdfXcJ7?=
 =?iso-8859-1?Q?NQnT99R6O/ps/2C6HLPJMy5gGnvviDmy6dVUU0hqAjwHpmwboUmGLQbqzA?=
 =?iso-8859-1?Q?ip85n/GAEXjeAEBpy/tN/PA0kqFkO61OGy4J5GMOQ0kARklgHX/qbg2jWt?=
 =?iso-8859-1?Q?YnizPwVAsc6fBntDsZk7S6Ad85k61AOqF76s4/i0GHZheQfXxrqhISC3fP?=
 =?iso-8859-1?Q?HvrfuzIXYzJ7B2WC/lHWqvvuOORCm4+N89Pv5Z7b6VbZVRZNBDf8b5vWgX?=
 =?iso-8859-1?Q?93Aio19WhAFIIf9/BZON8dqWTnD0+q6Zqyq1O23UCqrEzcf3M6VigKLTU2?=
 =?iso-8859-1?Q?CTV0tUB8SxOY+KofZeVXaustwTuWa+hmxT2e2laNZEZsb/OV7Qe84gOaHd?=
 =?iso-8859-1?Q?fy3uT2ExUzV76qXBr9xZ5Cc9gHKalrCU/a8BmXtsYLLiM9EFWOylN15Ff9?=
 =?iso-8859-1?Q?w6tvfkkF4g1InrOV2d9GXB3I3Wy3Zxs4XRW8bgHghjzGGc9H6Shm9ZHDZE?=
 =?iso-8859-1?Q?4juGxo4u3R5t7dRLAbNz9c2oFoZKhbk31ANbmDyn83XpVS1vurPYO6sIZk?=
 =?iso-8859-1?Q?gmVd9pRex7uC6+kC6ynko8PAyjp1MWp3p/Jl37zJWPh/el9GSbKY+G2zTP?=
 =?iso-8859-1?Q?B+DGQ6DzjnF753QrzHFyWpcLQStkgvdU5qUqw8+x8Mp6OjkuCEpSP3qOPa?=
 =?iso-8859-1?Q?LkHR7AzR/zV1W2YqGY6NqQv5gbMluUorj0ssLfPFXVtM1DY6aPD7tjudai?=
 =?iso-8859-1?Q?7gOkUfT3uBpW33JiSIzQXyzylXkUKX6RecUWKbd9/u8eqaLrQ7rfMajBqc?=
 =?iso-8859-1?Q?WvVMv9FHNzj5O59HF1vm7COwgMUZOfT03kZKArqrUE38CntG8AszpdNha9?=
 =?iso-8859-1?Q?fpBp6vv7bZJ2l1oINmBXnZPSgRa6StQREElpD48EsbVbBK827oX+7bnJl9?=
 =?iso-8859-1?Q?LUikikmUvsHFstQS9K/SDGBFnWNL+yW+zySDQIvyJa0rBkppX6CMxtiQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf65f31-dfe6-45a1-a9c4-08dac2f99872
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 08:57:28.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55QX06jU18t8jB2yaCLgjwQ3JVaoa56lHukuHll6oYKqKG3/WdTc6Dq0e4/DZhY+R3tL4fiJqdG12UhR4Oerzmpbz2giUpbvQvZDMmq+nJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6822
X-Proofpoint-ORIG-GUID: BflOH_Dlch5EHNUp2LnhOPhOOX6NPNHg
X-Proofpoint-GUID: BflOH_Dlch5EHNUp2LnhOPhOOX6NPNHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_07,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing of the common device controller bindings for the controller
provider and consumer devices. Those bindings are intended to allow
divided system on chip into muliple domains, that can be used to
configure hardware permissions.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 .../feature-domain-controller.yaml            | 84 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/feature-controllers/f=
eature-domain-controller.yaml

diff --git a/Documentation/devicetree/bindings/feature-controllers/feature-=
domain-controller.yaml b/Documentation/devicetree/bindings/feature-controll=
ers/feature-domain-controller.yaml
new file mode 100644
index 000000000000..90a7c38c833c
--- /dev/null
+++ b/Documentation/devicetree/bindings/feature-controllers/feature-domain-=
controller.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/feature-controllers/feature-domain-cont=
roller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Domain Controller bindings
+
+maintainers:
+  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+
+description: |+
+  Common Feature Domains Controller bindings properties
+
+  Domain controllers allow to divided system on chip into multiple feature
+  domains that can be used to select by who hardware blocks could be acces=
sed.
+  A feature domain could be a cluster of CPUs (or coprocessors), a range o=
f
+  addresses or a group of hardware blocks.
+
+  This device tree bindings can be used to bind feature domain consumer de=
vices
+  with their feature domains provided by feature-domains controllers.
+  Feature omain controller provider can be represened by any node in the
+  device tree and can provide one or more configuration parameters, needed=
 to
+  control parameters of the consumer device. A consumer node can refer to =
the
+  provider by phandle and a set of phandle arguments, specified by
+  '#feature-domain-cells' property in the device controller provider node.
+
+  Device controllers are typically used to set the permissions of the hard=
ware
+  block. The contents of the feature-domains configuration properties are
+  defined by the binding for the individual feature-domains controller dev=
ice.
+
+  Each node can be a consumer for the several providers. The first
+  configuration of 'feature-domains' or the one named 'default' is applied
+  before probing the device itself.
+
+# always select the core schema
+select: true
+
+properties:
+  '#feature-domain-cells':
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of cells in a feature-domains controller specifier;
+      Can be any value as specified by device tree binding documentation
+      of a particular provider.
+
+  feature-domain-controller:
+    description:
+      Indicates that the node is feature-domain-controller provider.
+
+  feature-domain-names:
+    $ref: '/schemas/types.yaml#/definitions/string-array'
+    description:
+      A list of feature-domains names, sorted in the same order as
+      feature-domains entries. Consumer drivers will use feature-domain-na=
mes
+      to match with existing feature-domains entries.
+
+  feature-domains:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      A list of feature-domains controller specifiers, as defined by the
+      bindings of the feature-domain-controller provider.
+
+additionalProperties: true
+
+examples:
+  - |
+    ctrl0: ctrl@100 {
+        feature-domain-controller;
+        reg =3D <0x100 0x10>;
+        #feature-domain-cells =3D <2>;
+    };
+
+    ctrl1: ctrl@110 {
+        feature-domain-controller;
+        reg =3D <0x110 0x10>;
+        #feature-domain-cells =3D <3>;
+    };
+
+    foo@0 {
+        reg =3D <0x0 0x1>;
+        feature-domains =3D <&ctrl0 1 2>, <&ctrl1 3 4 5>;
+        feature-domain-names =3D "default", "unbind";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 046ff06ff97f..2d1a5023e61c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7920,6 +7920,12 @@ F:	include/scsi/libfc.h
 F:	include/scsi/libfcoe.h
 F:	include/uapi/scsi/fc/
=20
+FEATURE CONTROLLERS
+M:	Oleksii Moiseev <oleksii_moisieiev@epam.com>
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	Documentation/deviceree/bindings/feature-controllers/feature-domain-con=
troller.yaml
+
 FILE LOCKING (flock() and fcntl()/lockf())
 M:	Jeff Layton <jlayton@kernel.org>
 M:	Chuck Lever <chuck.lever@oracle.com>
--=20
2.25.1
