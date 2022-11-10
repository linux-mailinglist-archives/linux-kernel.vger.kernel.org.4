Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA33623E23
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiKJI6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKJI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:58:05 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B8968291;
        Thu, 10 Nov 2022 00:58:03 -0800 (PST)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AA8XZIM005288;
        Thu, 10 Nov 2022 08:57:30 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3krwuag33q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 08:57:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCfN+atovDxJxX7HeRjHwExf9eRflozp+8vMo8PgMRbje+fZ9IxxGn5164NaZAknvFRmOszTej+OOK9nWvgn9A28qKzwqIt9jAdF+3XP5tPZS82cftWL/NoEUhI1t+6oa5FlKyinufoay+7i8qNWheroCv33mN//LzB09jrqhzX+vErO1eofF0s84KASN3fJ4Ou/498X5xUgE6ne1a0Vi7YK7PEZaAGOQViZbKUvbWOtTQbuzHgjVAEReELUnKC9JQV5aBj+EgXwWKX1rMf7CfK7MMlZmvb9bJLP6qL1kSQWfXDR6u4DYZe2RgR7j3dXU8InA5sUyC4QRN/DBjzAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6MY6GLpPznR6Qx+Uq42csnjWYlGniYaNAZ1jcOWQ6k=;
 b=DzgS5bekaa9X6FylYZof6zfyWuDOLFRhd/4bC7MDoqXgHhfSFm9BzyibO/yH4SLTD7EXdbOebht1BoMPZSrJbAORtVfEE3E6aCM/y3ctkIykiwVtdMMPx2buvarqQlhhLQE/PmXlqOurjVV1jvyxyggLn5lZPkQzvTPwk/tW0L301IiVSfUFC5+6RUUWPFYk6DInCgZVIfUIO5GzxRo4UGWsRx/EmgHfSKPlOdn2vy/Jfko+vu4vdMg+Yq6ae72AVBEjpXbk8/uCxiLwTrhVpOptbAJ5b22H4EGUR+87Jy7sKuBlmZzLYEdxtL9pVtbQZaR6F9THXLYoLh04UwAzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6MY6GLpPznR6Qx+Uq42csnjWYlGniYaNAZ1jcOWQ6k=;
 b=MOAKOEGPC9gVxQwiLO1DwPcPqyn6ufQw/I2A04A2dHSkEg3C5f2GZQsfL9cpZeQSYtC0E32DlmL5vfamTr/FDOdDOo58GEtgBbK+Y9lJhQtjdxABE0hiNQEPlyUsvOQ7V2iWj5FKpLwFUexUo7ZIH9XW4b1LusWUU5I/UdqYquajbxHwXTP0jMHOHuZTq7hMscNKw6MZK6eVyJVZIqKbn0S4vuRAqBEhRDITKX7KtB0Mw2qrK9jp2HajwHHFx7eRX7DcqyGvfAy0vuOMxYrMxY0el90W7L8r8MmjiEZld2cv6+Vb2uj1f67CEPvzf++b7lDrugslzpVdfsitve7Lhw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS8PR03MB6822.eurprd03.prod.outlook.com (2603:10a6:20b:295::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 08:57:27 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::cc80:5238:61b7:43c4]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::cc80:5238:61b7:43c4%5]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:57:27 +0000
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
Subject: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Topic: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Index: AQHY9OJ0NJO3IBK0dkaU7boFPDCicw==
Date:   Thu, 10 Nov 2022 08:57:26 +0000
Message-ID: <cover.1668070216.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS8PR03MB6822:EE_
x-ms-office365-filtering-correlation-id: f2f0472d-c19b-4dbb-90d1-08dac2f9977a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvRUG/K+RIgmto/sZnHgU6ftf290oNfRik+0nUTHBtFeTIcSpeciVxk1SVhQvY+2ozafCobRiBHrpxM7aDmPKIGRcUGWlMNEM6RHeHxkc3zgn5LR0DOgZ94tUYmTviJJkBJzpLCRV8IndNNRupR5ELP13hQQNcHVUG52FLpyPkqV4hr58Fsuk5UlhrXNIZ0b2mZFwybQGmbCKDBMFw4CzA1bLbvEv4UEHMssUltYjBpL3TxcGHiKPxvSCG6leNmM0+Zy+1/8PrWSVrB1M2+rCixcyQF/CNf1KQVMgrRLsEV4AXZzexY42OZRa+Tve/cG4prkPwHkEqwia6tQYbhAQAGNbbTrhkQPNa4RhIIm6q7UzNgg/Q8UZOq9J5I6MAD6eYkfPOrQzE1oBrY9XkoGQWI+R1LGBKNnnF7ZbQwUAib7oYlcFLQTnNTm/wzri2meuM6LLNWy8LuZ+FyYSbQujuXr3RVc3nLQJAMt9go+6MU7VxBKNIFmtUIPIBEuKQ3cDsFEFQOmnhRx+lmLXHdPGXRpuHOXu5lRePGRctAqTSocmG0SqrYHqx28nXqPRIFB94klQK1BFYxB12m9sE9fogUjjp5f7uY6ZJg25UcHFKRgbr7xohhkbUV7oibOrDwzP7A1fkwimn7bcMvJ1QVjWqtu0AIDAyCkL/WSMTXB9NViqPfPzIdQydyqTis6LbGjVB42l2XvDb+cOXksd90c7C7FS9qT65mGOF8wv9tepctdksuvXmr9wT/rvVXtLJwpLRXDfelZ/+EQnW9+L6qcJG0v+viF4Lr7ZfuahdERarWccPpilNl4ksaYIkZogYbzBMir9ADVaAQJFeIMIAq6LA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(86362001)(38070700005)(36756003)(7416002)(2906002)(2616005)(6506007)(6512007)(26005)(83380400001)(186003)(5660300002)(38100700002)(122000001)(91956017)(66946007)(66476007)(76116006)(316002)(66446008)(64756008)(66556008)(8936002)(71200400001)(54906003)(4326008)(478600001)(6486002)(8676002)(41300700001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zrxh9HT1zNY9DuOHg16DH4n61i67DefNE0Wq4DHZssZa+jNGhhw6+mK8ls?=
 =?iso-8859-1?Q?tVou1SPR9v/Dn1bOPhIosv/UaE+EdhvDi2sm71pOB3GoP//V7lqczNbRnH?=
 =?iso-8859-1?Q?M9w2PyVd8lvfnkiF8IkW4MsHE4Bm606BEE+mE8R6cMdbH8U/vRwOnRgxbK?=
 =?iso-8859-1?Q?LFIcmG5/wnz7R2nceOx9gvYxYax3yvP1wvT0RtHLp2lnMbGcfSgRK8zR1u?=
 =?iso-8859-1?Q?guTqyMcF+SMHpX85AovBXZiWkSVcwG+aJn7IXY7SX4D0kUevfVJ0h0oNiG?=
 =?iso-8859-1?Q?nitAba/El06h+mWVI8mqweOU7WUFM5YfhvXMmeVUpmX07nJrhN+jaCHrav?=
 =?iso-8859-1?Q?mgdWg9pNIjhF+/QJ9NtxVCAKiyT/1csYEeVqRxq9X2CyZoo9qBrrR/xdSE?=
 =?iso-8859-1?Q?GTE25D5jtttJVjalkqIVyxBLhUhmBPka0mZOm/wLkvY9OKauLr/7Qu1Pfo?=
 =?iso-8859-1?Q?0G07RfVjqbRBqD8Slm+vPmQFBFk9sQDCgYYysr5eltOGyMBJICyhOYLK3T?=
 =?iso-8859-1?Q?kTgPhHvxkmebZihJFLmmeB/lsZOCpzE5zdSnIsYlcyG79WN0J2viNfA8ak?=
 =?iso-8859-1?Q?mFF2o4SQVH0MTHfZOM+lDoZzZc5LgYr+279y+Klvv7hr6fyQXAC2Gnmd+a?=
 =?iso-8859-1?Q?Ek3WH5MZSsEUfTKE30jy0rGt2aFEaOX+iV5EGVgfd4CPqH651Ii4O6Fa34?=
 =?iso-8859-1?Q?EhQV1vDCiG9S8beNe5fjyNzciM2lKHc5vMIxwy2ydAsQVVmdD2RiA5/Ztt?=
 =?iso-8859-1?Q?4UhtY1E/EaT2A0g3rTLG1rG4xJRaNXL7UPoLEjEawJ81M29d/fHMPgNwgd?=
 =?iso-8859-1?Q?V24knmAph7GQXhj5Zf0UZDVcdIM3a+4OP5PyMsstwmmaEDx7j3C0U6cJ+7?=
 =?iso-8859-1?Q?umvP9BxQ+hw9JTnczHlZOofq/0f25SuA+j+nc8kqs3L4b/Kwqo5/gwomm1?=
 =?iso-8859-1?Q?Tuwi+xwTbGZdqRr8X2ZLHYVokiIxJWP/oYq/EGKbn8znMx6canbkYlAdEy?=
 =?iso-8859-1?Q?C3AncaMMh0YVGhIocc5DvavQF9v3XcTQRvsAyIpOuQjEiyt2X9Qg+gOgv9?=
 =?iso-8859-1?Q?HzJQoVYsmeYqf1hxjEmsMIDGz94eTG4gg1uxAXHIGSUAYOFOvWhKZ1sSDt?=
 =?iso-8859-1?Q?4bMCwxs7yfV14ykv94GBk1zpPRIQsJJoYvRMlNVJc7GVo7Ge7BLVZf4nLt?=
 =?iso-8859-1?Q?aR4esmsKWjTs8FI7h+RJ0H5ac3QpUze4W4MlzKrh8Z2fB8Wof1f4A4HfgO?=
 =?iso-8859-1?Q?h4Sumv6oousWkpDG4g1DExzFPfPSQJdH+cZsQ3nMoHMQ6TTotDQA4tsw7X?=
 =?iso-8859-1?Q?ZMlZumn9tD2u4d5GnCk6rpeKRbwA7ax9rS5a9riG4H8aUZFemY+7b94nzv?=
 =?iso-8859-1?Q?bG9cGS2b7LrGAYrME7LoIcwQh8z3LiUAPgEir4XvLUkNj+ry1t0A0zgAXy?=
 =?iso-8859-1?Q?o2mg7me7tX7rAbB/RhNgRxC7lKmbMQTBhUjDVd7ue91Ucpah1NtTwMi3o3?=
 =?iso-8859-1?Q?JkfOk4bgwvbsXMrtotroP0xvFajHOXJS6NGA2mORNL62K+x/6DrtGbHq4j?=
 =?iso-8859-1?Q?Ckbn28LgUoVhUE82ED5dOKQjlJ5sEOcrkjtbYoyvzoAQkwzXlC+dlrPE8t?=
 =?iso-8859-1?Q?c1PFt4G4eq8hHX18GPkb7orHID2aNQStA1jZ8Juvyv17UmSRQNH24jNQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f0472d-c19b-4dbb-90d1-08dac2f9977a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 08:57:26.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZ2Bo0vKV9ZGxkZQjBYj6mBrrIZZseg0KJbIPpMyjT5B7leVzvcAnDK2tTIowKUAu9LEqJZeVAp1jIxv1ewE90UyHrRuP71jwGC/+gNwQXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6822
X-Proofpoint-GUID: 2SRUNt4g_iHX6uAf8t9y23duWvjz8i0H
X-Proofpoint-ORIG-GUID: 2SRUNt4g_iHX6uAf8t9y23duWvjz8i0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_07,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1011 mlxlogscore=908 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100067
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the feature domain controller provider/consumenr bindngs which
allow to divided system on chip into multiple feature domains that
can be used to select by who hardware blocks could be accessed.
A feature-domain could be a cluster of CPUs, a group of hardware blocks or
the set of devices, passed-through to the Guest in the virtualized systems.

Feature domains controllers are typically used to set the permissions of
the hardware block. The contents of the feature domain configuration
properties are defined by the binding for the individual
feature domain controller device.

The feature device controller conception in the virtualized systems is to
set the device configuration for SCMI (System Control and Management
Interface) which controls clocks/power-domains/resets etc from the
Firmware. This configuratio sets the device_id to set the device
permissions for the Firmware using BASE_SET_DEVICE_PERMISSIONS
message (see 4.2.2.10 of [0]).
There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
determine device_id is not covered by the specification.
Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
Given parameter should set the device_id, needed to set device
permissions in the Firmware.
This property is used by trusted Agent (which is hypervisor in our case)
to set permissions for the devices, passed-through to the non-trusted
Agents. Trusted Agent will use device-perms to set the Device
permissions for the Firmware (See Section 4.2.2.10 [0] for details).
Agents concept is described in Section 4.2.1 [0].

Feature-Domains in Device-tree node example:
usb@e6590000
{
    feature-domains =3D <&scmi 19>; //Set domain id 19 to usb node
    feature-domain-names =3D "scmi";
    clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
    resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
    power-domains =3D <&scmi_power 0>;
};

&scmi {
    feature-domain-controller;
    #feature-domain-cells =3D <1>;
}

All mentioned bindings are going to be processed by XEN SCMI mediator
feature, which is responsible to redirect SCMI calls from guests to the
firmware, and not going be passed to the guests.

Feature-domain-controller provider/consumenr concept was taken from the bus
controller framework patch series, provided in the following thread:
[1].

I think we can cooperate with the bus controller framework developers
and produce the common binding, which will fit the requirements of both
features

Also, I think that binding can also be used for STM32 ETZPC bus
controller feature, proposed in the following thread: [2].

Looking forward for your thoughts and ideas.

[0] https://developer.arm.com/documentation/den0056/latest
[1] https://lore.kernel.org/all/20190318100605.29120-1-benjamin.gaignard@st=
.com/
[2] https://lore.kernel.org/all/20200701132523.32533-1-benjamin.gaignard@st=
.com/

---
Changes v1 -> V2:
   - update parameter name, made it xen-specific
   - add xen vendor bindings

Changes V2 -> V3:
   - update parameter name, make it generic
   - update parameter format, add link to controller
   - do not include xen vendor bindings as already upstreamed

Changes V3 -> V4:
   - introduce domain controller provider/consumer device tree bindings
   - making scmi node to act as domain controller provider when the
     device permissions should be configured

Changes V4 -> V5:
   - rename domain-controller to feature-domain-controller
   - feature-domains format fixes

Changes V5 -> V6:
   - formatting fixes

Oleksii Moisieiev (2):
  dt-bindings: Update scmi node description
  dt-bindings: Document common device controller bindings

 .../feature-domain-controller.yaml            | 84 +++++++++++++++++++
 .../bindings/firmware/arm,scmi.yaml           | 28 +++++++
 MAINTAINERS                                   |  6 ++
 3 files changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/feature-controllers/f=
eature-domain-controller.yaml

--=20
2.25.1
