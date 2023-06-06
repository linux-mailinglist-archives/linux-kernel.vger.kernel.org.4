Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479E27248F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjFFQXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbjFFQW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:22:58 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928210EA;
        Tue,  6 Jun 2023 09:22:56 -0700 (PDT)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356G3fee006627;
        Tue, 6 Jun 2023 16:22:47 GMT
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02lp2112.outbound.protection.outlook.com [104.47.11.112])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3r2804r2hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQJixJ3k7j17ZvnICaTg75pwRLb4D8507lQROfXen5t6qFVtkmStS74C4zlrGk5AwbpvfzfWLbJXBKG4cthC2/Fb2lvv3j9uviw2sA3htcYyWhcqV6GVOyO9xRrrKjYQj8ef0e9Gm/eFZQ3Z8/lMPq+VoeikuPqOpCjHyLZxgDYMDT0gLGO2bxvd7FlV7MDHsT7LZuE//bRAZu3mgWKvGU7GcXnpUXepxLruU7I5w7Jvpw7l9dcWct3kQikQzH4xRUWyFjU3hY7I3K+jhK0hh8lvr09bQVkX8LE7IQjW++NkRMRzfGz/Oqgsol+lOgdut4+UxsVomM8ZPMkLflwnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPyoM93CIg05EExfADs14Sex6K6txv6z7yh4h8HoPVU=;
 b=JgdTi7c5D6nShM3KFPvkp7UlN60EPDS4tIx1PtQjNdUHf9K9gHlIvV86ssIKy2C+LB/usdHQ5iybwKHC0DJ+pc4mzCl0KYKFa6l8hS3vyKBYE8MKVrDgqxAt6ut7fyotw18fWRDhBPt1bzDFerP+1EKzy97EiO8UYVFrhKiVjK28ZNkwEYt8EcxjM9i4AmHB+sJ9EK/qLLN2UI4we2vILEZOa0BJ4AGkLQvNx3MesHMZ+nq1ISjbn/pLdLtl7P7jdPf6GkAMCyIIE/xsZL4vsQLDtLlR+N2m8XmGb5aPlfWi+PtFe3/ZHZ4VlQMsIoJqg3srmeyvJQwhh6LdxVVKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPyoM93CIg05EExfADs14Sex6K6txv6z7yh4h8HoPVU=;
 b=L9M7NlpAL1dJHwl3zvUdhdct3RA/uVezTPUEa4dZt9WCs+2s+UkKs0JOlD3NiUKod+0V2nGPFrAZz9XQ5PrzY39M2CXZWdYmH5h8krpqROzX2RGxN/jQ69H8lx0seY0/0lcV47vFz7wyJH0mhyg+NCL9hkiyze/oU5YvVab7Li/ujHOS5v3UUaf5VdaVm0IWrOHB7ETqf7HvGMnvF6O2NnUJ9AkftiAYxbc6R7RL+PewjQdEadTzXFlwtV5hBsTgWfqibOMhuvc+ly8+rIIRUcwy5UkBU0kpO2q/LV6DElNJ+cd5UZ7ZBb5uIFqnX68IzOwio8gq3SUU7ZEKuXYZcA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by PAVPR03MB9383.eurprd03.prod.outlook.com (2603:10a6:102:308::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
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
Subject: [PATCH v3 4/4] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Topic: [PATCH v3 4/4] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Index: AQHZmJMWJkxtIOd1SkGZy3MMJWizGg==
Date:   Tue, 6 Jun 2023 16:22:28 +0000
Message-ID: <a2be28c0aec04fdc3684f56801c78bcc498c3471.1686063941.git.oleksii_moisieiev@epam.com>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1686063941.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|PAVPR03MB9383:EE_
x-ms-office365-filtering-correlation-id: 59b85e82-598e-49e1-0078-08db66aa38df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnaQAf9+y7OqzCgdgQrG3UzF4eeGd9/fsVXgeGMd3RhcyjMtDk8Qt4B2oZRC20AjPPdWnXRLnxxhlnyFZd6UIYrANrvLRvPHMyPjUWV2xGGU8PYcKCEFhmlBzER2Ryq9p+6OgWW4ox/3awieRSTtvbiY2UyBJhX2Xqlr48PxW3kjCYP7zbkaa/VPHM/9K9lTjdrrF9EniF1RbBp5SdJTMplgbpgvdtsTCm/YLLURGFh9JQM+GBfIYLnnfXfLIWIwGd/zpOBXH71CiFstwxoqAxe7ZMc/NoYh4ZhREzfzqpOBVkdFgpGSa0OltW2Ixrw7dPkCJnxV7Cv4/5OMo9FwsasCZVtmO9J8TyTl8NJ6E1R54nVB1PMq3+npP4MoYghJ07eUOJnvQWja62ki0X3XG5r6px/e2vVJDsBEXTbUkiWqQ9psR8KO+kf0TPI1xjaKOThjmEnTrcAquS/E5/PLFtHyty4xMlJTFfh9/6fOgjo5YX9HybNgvQX9nzQDqj8+bdI6r3auLv0v/ppn2EkmcqUI5sGwNSnFOTF15KTDiWgZsYkWO/T9FtpAUoZFW6IrGwj166/atYbCLd2NDz8GuImjf23UYLPoKvxdSDkQk/6ZezmX+C9yF6dUyTBYF3D8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(38100700002)(86362001)(38070700005)(122000001)(478600001)(91956017)(41300700001)(71200400001)(6486002)(54906003)(5660300002)(8676002)(66476007)(64756008)(66946007)(76116006)(6916009)(4326008)(8936002)(66446008)(66556008)(316002)(2906002)(7416002)(2616005)(26005)(6506007)(6512007)(36756003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/BmKN2/Ax6Y5H3KwL3zWa5Iu84U4IiPFHIECnZ95fs+6oxR95F6UEUuCSN?=
 =?iso-8859-1?Q?XbsOgr80VH18t9aP7uKNueuNOEDN7vvOnUouf+tmUdJp+k6yKlxKcsHPlK?=
 =?iso-8859-1?Q?pheykv1eEcFCYAxYz7bSMqaI53aw+yiwqBAg94Xq7FxuJ9MzLmaEYeat0P?=
 =?iso-8859-1?Q?6xZrsnTdTwKFdDledSHl3QOAjZ62Cyp92j0XvVj2GSg7MOfWSz6cmBKnKu?=
 =?iso-8859-1?Q?WDT7ofRyPVVUkDW7FKaU/G7J/hStwMjgb3oft6kUOeRIeC36B2S8y15L24?=
 =?iso-8859-1?Q?f0vpJuk2/2RNaerfCi8JZnbMOVzoDDk0sLBCElDEISAs4M48aAP/wJfmAR?=
 =?iso-8859-1?Q?pFLbAzGt+ykfwChdGIl991dpo9ERcQosm8vxgx65qbUD3WHeuF5ERKrVZR?=
 =?iso-8859-1?Q?Pti9VbfJ3C+kJ/sQ1rKaGOEVNY5AkXwNKnKWmCgjDICiaR3PffsWnCqxnc?=
 =?iso-8859-1?Q?fN+lVobBtp0b7xQ/KGvX4IALez3+7laQoh8UhV8CggVecmwmscE1l5vMZI?=
 =?iso-8859-1?Q?nx1TGAPf5e3/+OVBhyhQk/Q1ya8byOTyo8AC60phHMF9xEDc93XaUs2y3I?=
 =?iso-8859-1?Q?nV1s2zdDtjdeR4ohx25kcUKesYTc1s/2l3ydFKJJRQNeG5PC9AVTPNG6RJ?=
 =?iso-8859-1?Q?rlwBargQAvXypg8pXIKwIyYIodbJ0sVSymUC7OaHv4ODd8geFX1+jlhXQX?=
 =?iso-8859-1?Q?cCSyJy3N1oyy50kE1KMRbEOSD0ie79yzPAiYcCRS0OzlOFoFLPhzfU7YqV?=
 =?iso-8859-1?Q?rAmxI44N1aFYY1ab6MiTNTxovHEoa9xi3ZNYk33b8AwNzqeb/QhzgerBBY?=
 =?iso-8859-1?Q?UtsTkCPWhmD6EDni5fwOM7PA8Wzut+rLRSKOnfS11Lg+gjrC5NJNGaeSDw?=
 =?iso-8859-1?Q?hUX6F/4uGJ0ypzU0uI8zBErfKIpoYGjzuMOsBBUUfGjtogCItLkFQaF5xz?=
 =?iso-8859-1?Q?oKacZQlJ9LHALj8lqM3CR/jIqHn49xlsJPNc4JZhAPKUEIzuBgN9LhP5Xl?=
 =?iso-8859-1?Q?DTBUZp3W9rFZMzah46N4z2cRXUOPawLA/t05AX/VOw9VBpK+9zVVC7/9fh?=
 =?iso-8859-1?Q?FhTVqtQaRE2Kr2PqARE50LNv1NvOorDctQRBeRbyEvfwR7AFuFGBeB2iEQ?=
 =?iso-8859-1?Q?MHuWzdsnVe6jrhRt89bpz7jdnxTF0JdRPwePZCtovScRSoGh1T7owvMx8L?=
 =?iso-8859-1?Q?Y8BOiiME6MnHx+UGnufnyYlRp05PnRsfX3bE9JHexLr7lHHVu626dxmzft?=
 =?iso-8859-1?Q?weLMhwGINPwRPDU8GsGpUlH+JGBnhMYg5ZILHbXdAcncPEmF6zpc8ccGbw?=
 =?iso-8859-1?Q?xDLyLU3wmUoQf1hIEAozNKp9q8R41lMQyN4EM2mBZOWWsUgxe7mdndHfWI?=
 =?iso-8859-1?Q?92GhUcj/pW0POqkPIliaG/b2o9bnaAR/GvbW3AdiRjMnmP6x1P2tVS0CeP?=
 =?iso-8859-1?Q?YGTyoBpF5vY691RJckb7xERiscuRIWN/HVenai70ynTz1qplrUySjXr61E?=
 =?iso-8859-1?Q?+sWCYqQBFUnabzv37IfjEX5X1YmAlUUsPHkRi/UMxbUmUio2AC6l3Ya2qJ?=
 =?iso-8859-1?Q?mnhdZCU04/XbcDKDCOZW69JtOZ7MNHfAJGn5FDHjmYHkWZi7J040F8AeSx?=
 =?iso-8859-1?Q?jC6Q0jDftsOLI5DOTUSydUoB1r3jzqPIm/vGB16BF4zxz6kE0I//SxMw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b85e82-598e-49e1-0078-08db66aa38df
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 16:22:28.7228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mg3GCMSTf75ZTvi9TQAPCHt1vuqCJmH4vD7ze8Hzus+W3kciS5SwLSlT44UfUz3297QZc2UyMNqbKKqYCj10nXuDM8+Cjzo2F69LNRKoPbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9383
X-Proofpoint-GUID: QgVRBiERD4BkcpQ3nj8aX8SMvmGa8gl9
X-Proofpoint-ORIG-GUID: QgVRBiERD4BkcpQ3nj8aX8SMvmGa8gl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new SCMI v3.2 pinctrl protocol bindings definitions and example.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 .../bindings/firmware/arm,scmi.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Doc=
umentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5824c43e9893..a19aa184bbd1 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -233,6 +233,39 @@ properties:
       reg:
         const: 0x18
=20
+  protocol@19:
+    $ref: '#/$defs/protocol-node'
+
+    properties:
+      reg:
+        const: 0x19
+
+      '#pinctrl-cells':
+        const: 0
+
+    allOf:
+      - $ref: /schemas/pinctrl/pinctrl.yaml#
+
+    required:
+      - reg
+
+    additionalProperties:
+      anyOf:
+        - type: object
+          allOf:
+            - $ref: /schemas/pinctrl/pincfg-node.yaml#
+            - $ref: /schemas/pinctrl/pinmux-node.yaml#
+
+          description:
+            A pin multiplexing sub-node describe how to configure a
+            set of pins is some desired function.
+            A single sub-node may define several pin configurations.
+            This sub-node is using default pinctrl bindings to configure
+            pin multiplexing and using SCMI protocol to apply specified
+            configuration using SCMI protocol.
+
+          unevaluatedProperties: false
+
 additionalProperties: false
=20
 $defs:
@@ -384,6 +417,26 @@ examples:
             scmi_powercap: protocol@18 {
                 reg =3D <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg =3D <0x19>;
+                #pinctrl-cells =3D <0>;
+
+                i2c2 {
+                    groups =3D "i2c2_a", "i2c2_b";
+                    function =3D "i2c2";
+                };
+
+                pins_mdio {
+                    groups =3D "avb_mdio";
+                    drive-strength =3D <24>;
+                };
+
+                keys_pins: keys {
+                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
=20
--=20
2.25.1
