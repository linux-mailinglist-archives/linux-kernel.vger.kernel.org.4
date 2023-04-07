Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393B46DAB5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjDGKSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjDGKSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:18:41 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA956EB8;
        Fri,  7 Apr 2023 03:18:39 -0700 (PDT)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377AcPN012311;
        Fri, 7 Apr 2023 10:18:30 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2173.outbound.protection.outlook.com [104.47.51.173])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3pt36rt822-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 10:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2AbzriafOgfv7u+cGDtzSqoXy2C2wMpbT0S8s9kCROaBlFmsGdxWL6ngHjTiBLqUnpCGod5QqXhpuATrdUKbKXDtm2bkiwPARi6KavSrh9WUTTJx92JF1fDGv/9u0yFf7Ad6Asq4MfRVIi0qVXuULPV5+L+1vpwMWzs6KVrLct0mh/R/DSf2KX0l4Z/zQPDA2V52a02K2hiZLRQCTkNRfxOiP2w80GVfdzbWQmJoKCtAiC5/PWK0xIqYNrsaXscQeV+Re4XD1RpmEYPWTgcQOZDNwezx5ACtTLyOuGcE4wqTB2IVK0kUt4m8bdWRJQvQBdKQ+hdSjWIBUHnR2wung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gEzj8M/qBq2nViwGArWCEF/Y+6J0YPlby4Xnbig4p4=;
 b=kpt/hhwdPr3BEdB9DfQ50M41wglKS8a4jJb7L2P8CdVUF91t+o1TTE44wyUvloeAdbunTPUZednFCHiMUbCrpjK71YGEJ5JqM4Ya0AJTM81Q2Xi0JDlWTAU7C/BgjrZcemG0kG9R15iHdBJmVJh9kHbtF2Zh43xogUUgsy0hJnUrlolaMIwD8AggS+HvaP5SuVlyryoB8J8/P35F1mSqvadN61IMQi1hwKonIFQfsiupcdHAyaahQqIR1XluduX0Qcdp6DSvwY+QIWqzCYgvU58gx895mtuhdpiTmKydNX6e+jYzkrfOCkTEEKwQiSYkj1E/CrxW180WzDf7ACq0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gEzj8M/qBq2nViwGArWCEF/Y+6J0YPlby4Xnbig4p4=;
 b=PTPvXiH47a2oyupONoSmDZMegxDVvokJWABaNNF1QiaANNi60fcUURfxGNA5mTYf9hxzfG7asKpRgDjSHe631duaIlpBU9+i/BsmIvqzBobflwya1km/arck5yxcyUDrNqxP3pENGAw/DcRkhTQzfNKod3WNwBjuhsKkar+LI4HO8t7NgEbUtzL2gJe21AJTWE8WZPL6CWMmStcy99eo2Xn8L3h0KbW4OWOa5NVffG/qz7RgJVd9NRe4kEQdJZT0A1IT1j1laHPmpRRd6waVuQTxtHVnUBHK0lmwHuwyQja99L+tatTKzeyDTcZ3LfGxhrmQELjnSE/yr2CSca84YQ==
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
Subject: [RFC v1 0/2] Introducing generic SCMI pinctrl driver implementation
Thread-Topic: [RFC v1 0/2] Introducing generic SCMI pinctrl driver
 implementation
Thread-Index: AQHZaTpKIJukhxiTuEKOByW0ATiTmg==
Date:   Fri, 7 Apr 2023 10:18:26 +0000
Message-ID: <cover.1680793130.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DU0PR03MB8743:EE_
x-ms-office365-filtering-correlation-id: f9d55726-5037-43e7-f315-08db37516d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14py8lkow/7fbYixHz5E3Tjbiq4HAl660+JdUKqBRqtIa3EmeNBunCqCEfp/Ho8P6zJ4lyz1ScpKwwtLEy92HVR3kgkastx4ZO4mjul0200tfc109pDNz9Va4G8xJSx7/HrJ0LLdREO5zO1kyw7ZSEdgUYqwbgG/+Aop5zBGk/xQsVEeZA/+mLlxNFAHKLj6LnSX+IzsO1lNy9LRhfe98yAZGs8us6nJ2416UjWVHZmncmOF04/gFCmdbZih4Tu930Ejiqcw9jsrWI4nKCT+Hbwm2Zsf17WZfzwfmBWZvse4bsy/d4y2lKhOLE9eAfnKFSNu1GPNdiSOT95dh0mt7bMchoXT5FwptlWQ1oCuQShR0kB6fXDFv0K0G3Trq05DPodzBc4ChFCp6S7v+PoaG1AUEs++qXX+RBMhLnZmj9cJRVE0uQobRGGX4ZqcLzw7UX7rrmbXyB7gV9dNhe27zeau7Ob9OC0Hp3QwmOfYIflPo4SLRtxjzm/ELYQUWt7tMg+tBaesZyZP4TXZMBXPSdi7dPCyGoXXFfT+lg9EQDTun1cCdDUZyShO3LP7LsvaoXpJrPg+BqNDngl02uULFU7GRXfNbCIOyoBt+TQxxvTzdkHa0nMmrIqYsAS8OBpR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(316002)(6512007)(6506007)(186003)(83380400001)(26005)(54906003)(122000001)(5660300002)(966005)(2906002)(2616005)(6486002)(38100700002)(8936002)(38070700005)(71200400001)(86362001)(41300700001)(36756003)(4326008)(6916009)(8676002)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(91956017)(478600001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aAsMDJHhUYyOZ59mHoZoY11L7oGoefRCZp93wj+K1g3ST66e4ZGGkbKVCy?=
 =?iso-8859-1?Q?tF60nr7zFIhhNEubPvlDdp7ILXvxx+zw5lcueTWNnAtTnelzlbAqyYXrt5?=
 =?iso-8859-1?Q?4L706ygIEbZ0GnoPssFGhGJK5kpERTMc6RmmHxyCA1dOBlR/WyabgYDOG7?=
 =?iso-8859-1?Q?NjVLvUTIBc7KgdCvlIiP2RNEvElIOKqpxp+2ThOchRheWA98mmGMeG3BSG?=
 =?iso-8859-1?Q?8ROvzvsHTIwuECn6n2TKpHnKglkzHUyDWowHG5lBU1+plTKn0kiYvF6ON4?=
 =?iso-8859-1?Q?pK3S2OS33OtxtRqRGZT2yfi4WzfqqDVJEk4IOjGpfY0eM2zwvZYZIlgIXf?=
 =?iso-8859-1?Q?87x4YSJyQ2C+vXPgL7sY5AcvsaxR1+kNZ3g50dvFnjUgFBT7cXATm2RfKN?=
 =?iso-8859-1?Q?OooJ66JcKp1gcbSD6faBT82QoyIFQbLwt4C/XsycRIM0EuddCi7iybOkWA?=
 =?iso-8859-1?Q?kZKHCKicYEBP4/asdMEG23ED2lKSy0WYhUSpuvX4iqUE41WgT1FE5kauHx?=
 =?iso-8859-1?Q?Z+m3AAmg+f1fV/fbylv5N2i8QdUgUQI1lnm9PJBVzCs0+fvrMhp3vVs1mo?=
 =?iso-8859-1?Q?bjoG8ECQzMZlyfba7y7MUy2wrwtF/tvipfQ7Idl1w1QMkExU3vvgcjIubi?=
 =?iso-8859-1?Q?H3w6VR/AmTutwHUlaTDo6N1UqcTwBwwq6lytKGorzlvko2G0DCKj0NPosc?=
 =?iso-8859-1?Q?L47yISrgZbU+SI/6ZvpBcDgkM961VfYQctZcAHlquqiTjTaeTGgM1XyfMw?=
 =?iso-8859-1?Q?q1zeWdAv7tJ5gLUXMr1A8Y4nbSuzUfC+iOnRMQYrc0YykSfojNd6Gp9e0A?=
 =?iso-8859-1?Q?NvVHwJPEDgK2hMwhydlWZO7SzvAiOAMvNEl1dVDxoM5oqEjWb5vTlAdM5J?=
 =?iso-8859-1?Q?bXovGIPk+PsZnfJmx0x+yYFXOdYQW1RjAY8DqAQ+CTa2tvnCHfTPtJDrU8?=
 =?iso-8859-1?Q?A723QXr78gJ1aiXtCKLoSI4r5SEsKJ2MPJos+pQ82mR8Q8dfd9Yq6amjto?=
 =?iso-8859-1?Q?tF8DCMBCEGDNc8tSLI40qVu6xyaPloTxe7dII/VL+Wv0y3zaQ6qujAv4VA?=
 =?iso-8859-1?Q?YNJAwiV4yrUF7ka6ZLA4vFHd8D45mXvn32kFOzESYsJQkKOu+v1SruEas/?=
 =?iso-8859-1?Q?Ivxd4qNKSelE8UJHnWwvqt/VMr7N4jMXe7kK1iX3CGUmjm4NeL1UpI38LF?=
 =?iso-8859-1?Q?+EsThCMUHcTkcykXJf0ccQXBzCwQf7v7Qa7cP5Xo1SvLgHBOXhfCiUmqc0?=
 =?iso-8859-1?Q?x75NGIGdPzpLxG3EEQD1beOAs8sbCTd0hv0F80RfXu5PyFHS2+5qeJzW/f?=
 =?iso-8859-1?Q?MImpyQVhWgg21bc7f1ox0tZ3aBqjIvYXsOOZxLwIXR1660AaYI/1keg9fr?=
 =?iso-8859-1?Q?XkhuKV0suB3QcUr01cEdGQ4DMikJHWPPv8/YMHM+ZU0jcvI7riMz3HKV3R?=
 =?iso-8859-1?Q?BzMxwxEJMSu58z9EG0xkTPjVkZIcjxb+Cirr4RuqkmxmTf/YZVb5nEr6ci?=
 =?iso-8859-1?Q?+wVRSnyDqYeF7hiIjfTKLXy8lKHUl70DcFrnPBpHRhuzcEyK3PWsWpbCS2?=
 =?iso-8859-1?Q?noY7H3Pu9GWkT8C9ffrXWXxRIzsJVts40cOvr9GagmKp3QBwozPhnZ2nwT?=
 =?iso-8859-1?Q?z+j+HbPaeR+LA1Df+1XBdIvKgs79rKNbsCrg9+2cte832x2EjI6O9B0Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d55726-5037-43e7-f315-08db37516d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 10:18:26.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQh6yMxCSzzUtkqsF8FmMQrv+MhVRB6pf4qgoURnCyk+x+VIbym8eV09Lf8w6RjCEeqDnshQbpKP9ewBB4nqNkBKhw9ljprZNDeFY09cClY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8743
X-Proofpoint-GUID: iuUuskTTjD5981GonQV_QkpmsxFTltlg
X-Proofpoint-ORIG-GUID: iuUuskTTjD5981GonQV_QkpmsxFTltlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=785
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
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

This RFC patch series is intended to introduce the potential generic driver=
 for
pin controls over SCMI protocol, provided in the latest beta version of DEN=
0056 [0].

On ARM-based systems, a separate Cortex-M based System Control Processor (S=
CP)
provides control on pins, as well as with power, clocks, reset controllers.=
 In this case,
kernel should use one of the possible transports, described in [0] to acces=
s SCP and
control clocks/power-domains etc. This driver is using SMC transport to com=
municate with SCP via
SCMI protocol and access to the Pin Control Subsystem.

The provided driver consists of 2 parts:
 - firmware/arm_scmi/pinctrl.c - the SCMI pinctrl protocol inmplementation
   responsible for the communication with SCP firmware.

 - drivers/pinctrl/pinctrl-scmi.c - pinctrl driver, which is using pinctrl
  protocol implementation to access all necessary data.

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	cpu_scp_shm: scp-shmem@0x53FF0000 {
		compatible =3D "arm,scmi-shmem";
		reg =3D <0x0 0x53FF0000 0x0 0x1000>;
	};

	firmware {
		scmi {
			compatible =3D "arm,scmi-smc";
			arm,smc-id =3D <0x82000002>;
			shmem =3D <&cpu_scp_shm>;
			#address-cells =3D <1>;
			#size-cells =3D <0>;

			scmi_pinctrl: protocol@19 {
				reg =3D <0x18>;
				#pinctrl-cells =3D <0>;

				i2c2_pins: i2c2 {
					groups =3D "i2c2_a";
					function =3D "i2c2";
				};
			};
		};
	};
};

&pfc {
	/delete-node/i2c2;
};

So basically, it's enough to move pfc subnode, which configures pin group t=
hat should work through
SCMI protocol to scmi_pinctrl node. The current driver implementation is us=
ing generic pinctrl dt_node
format.

I've tested this driver on the Renesas H3ULCB Kingfisher board with pinctrl=
 driver ported to the
Arm-trusted-firmware. Unfortunately, not all hardware was possible to test =
because the Renesas
pinctrl driver has gaps in pins and groups numeration, when Spec [0] requir=
es pins, groups and
functions numerations to be 0..n without gaps.

This implementation still reqires some features, such as gpio support, but =
I've posted it as RFC to
start the discussion regarding the driver format.

[0] https://developer.arm.com/documentation/den0056/latest

Oleksii Moisieiev (2):
  scmi: Introduce pinctrl SCMI protocol driver
  pinctrl: Implementation of the generic scmi-pinctrl driver

 MAINTAINERS                         |   7 +
 drivers/firmware/arm_scmi/Makefile  |   2 +-
 drivers/firmware/arm_scmi/common.h  |   1 +
 drivers/firmware/arm_scmi/driver.c  |   3 +
 drivers/firmware/arm_scmi/pinctrl.c | 905 ++++++++++++++++++++++++++++
 drivers/pinctrl/Kconfig             |   9 +
 drivers/pinctrl/Makefile            |   1 +
 drivers/pinctrl/pinctrl-scmi.c      | 555 +++++++++++++++++
 include/linux/scmi_protocol.h       |  58 +-
 9 files changed, 1539 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

--=20
2.25.1
