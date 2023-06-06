Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CB724BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbjFFSwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbjFFSw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:52:26 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589E01727;
        Tue,  6 Jun 2023 11:52:23 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IbYXf015230;
        Tue, 6 Jun 2023 18:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=iaYVpq98EX0gKuVGPwHKqzfVgRRN3lXVm18594y7ark=;
 b=dX0aa7vyPSza5r99bO8QAovnUmrmTh9TEDiB6Y9Nhl98VqQLKMBR22UHKCQTVMdRxe/b
 hK6M/8ZnzYpv6bytC/BlgcgsS1BJ6Jl2axAyHvvssvZATnGWKs1kInGB+ShYhPdUEwnl
 ENAa/nFjBbfUCoCvUGTiRsZV89DVHSstt/D+zWZSPM5OSPmULoQJeOSh1LHU2bBZZ6uM
 fa1BD+Ry/f+D+C1BawsUw0GAIMSuept+R5xu4caR73YAKv1csdJMHlZgMW1R+Zuq/BFu
 F/mZLJaNpz1EDNMFrIVdz5BDQg+u4BaAD4oMXaSnuUU4kdgZGTvXGOUJ4aRyVOSRVxRB +w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3r2a89g3h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 18:51:58 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id B227214790;
        Tue,  6 Jun 2023 18:51:57 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 06:51:49 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 6 Jun 2023 06:51:49 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 06:51:49 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIL2moS2aZGwEABE1M2TEtSaSadiOgxcyHtHpPwjlhDDRWJUigMy2YMMHJSlRLKNKofNr0VBy5hXirfk12prXk2I2LAQoAruFN56VfZaYXAjff2PNCREbT++9y2RSTudgOXrb3W/0ycquu0OZ3sSokLrTSuUQHbSpsPMdj/BOGccMllAzCTVof2jjAuL7uWJv4vCFr5q/2A2Bhbg//yNTHunwDk5Jwj6tL8TYkoosxGalKviCppUSSgd7E6SKWqgiV8xGbi58pq58rzGHug5agHvWw8Gkoy/hZ486yEwEAs5eP9c8QsBmiF4NXsZZ9MptfypnFZsSQL0M8ddmV5S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaYVpq98EX0gKuVGPwHKqzfVgRRN3lXVm18594y7ark=;
 b=TOgFoxIql96G7ySqVMK7InSHJzma3vzfmB0AbWhKEiIzgXgYXUhbfeEwY8KSueW0wJ0mu6V1uWCxtIbzP+RgrKFc6Jd8yIZ++k3gN5a5trEW+E9+iMkawCQaqLLG2V1Po9RBe4Jc0qJhVLYlCUsZSNvdgPwoMvtedmp6jzaguBPv28F+FIZNDPcv13no7rcnrPoHpB2hLWc8pY5SyCryWqXaRh2hf5gcREl7zuLsD17LlsOUY+WOTYAuuxxjsyQKrSUI5DgwOG8jlTieQxNAmy2Oqev/OVgtiIYmouVUnB5BIUIG3j6Gj66NceFvaq1TPPB7TrPDztKbHdherJ5k9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1732.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 18:51:47 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 18:51:47 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Thread-Topic: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Thread-Index: AQHZmBjF4JEt/zYBEESMQ0szz/IlCK99gJKAgABZOsA=
Date:   Tue, 6 Jun 2023 18:51:47 +0000
Message-ID: <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
 <20230606014234.29491-3-nick.hawkins@hpe.com> <ZH76x6E9cbfrJHeu@surfacebook>
In-Reply-To: <ZH76x6E9cbfrJHeu@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1732:EE_
x-ms-office365-filtering-correlation-id: 3b8b0349-4427-4997-a17e-08db66bf146e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ps6yQ+fdHPkvRlq+PMAwM/GxCVjfgfZsRue9l0KnpIGYHDCr6FF4lMwtO2ej4+2W2pBOZcf1z2bKoI/su177uaUMEWFp8FoeBNz0P3WFlHu6TtuU7gH903iv2KZK0+Of8y++/MBmdSPGb7xZDbYtRw2m11kiJ0yphVTi7AC370EOu3z89iDg85A2CidG8Syveg8rWbXhkbGj47lWz9yPsWIEo+xhIMZMATk80CGxIU13mdonlszsIoEMboI/IBoXC+iDeoyoOeSRurSKbw3GDQ2oV7ey5g33cam1EonjQQShvl25HdSv036ipFj+Tztn4UbiVIV/MAe8mXzeVCqIO6dKClNMBvH31ufcWMHWY2A9aSW4uxI8gJiTSTUjP85TNPQpHZAM+kuQGIhhvV1nWvKRc5ZSnNlwaz1MU/w7vPSLxkduIwclokMrt28oy6EfEXD1d5gWUAEAtp0OlBtrkTcathmFXjNvaoG68ToaygHCDcznIu7+wOYQwZOGkKmRlmUYHFNju7ANt6Al45CC92uyLf2/b9E2EtvknqYhZjC1JzwaYgTBwqkD/sgPIjerB8/5typMQFtMccjXYdNPnFVS9UdlA4WOHT1uZcw7rdMcxg/Q2o4+SuxFYsMEG1/5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(55016003)(7696005)(186003)(54906003)(478600001)(82960400001)(316002)(6916009)(8676002)(8936002)(41300700001)(76116006)(66446008)(66946007)(64756008)(38100700002)(4326008)(66476007)(122000001)(66556008)(71200400001)(83380400001)(26005)(6506007)(9686003)(86362001)(52536014)(5660300002)(7416002)(38070700005)(2906002)(4744005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ccEA4RUEOa0wPjqYe1jHqF0Wv2ugSfGy+oorWxxGEgVZnXGYpRBEb5PLq8o?=
 =?us-ascii?Q?K3kbVL8jMmAkULyZ07RpVMYxINJS1OkQ9V4rqxygmZd1W6a5QYzlebtaTuet?=
 =?us-ascii?Q?kFgDmQC33frEI2TcDX2QFZGoi52SdI8xSfIGskcr/SKmYAHmNltq/ffz9saA?=
 =?us-ascii?Q?c8LoA940vk4R0XBNF4hR0OHIVrE9ZSSce0D2PZx2venToAZwsK/7kxzJ0SmU?=
 =?us-ascii?Q?1D2vn+V0V7Q0BGI/I6U7wcnC3v0qMsy4p3kwICVEXS8biQjMVIrpYxdD6n54?=
 =?us-ascii?Q?a9cQobxFUIG/5TNpXxkO0rfT/DoE2Jc8gwB2YHn698bZudxLtcEvJCKYDBWu?=
 =?us-ascii?Q?FXPw8fzn14fAMtWjWjOfkcIah0Q0k8oSaZdSUT2gx3XjUvtHxCO7XhhLc52z?=
 =?us-ascii?Q?/XZTU1liviAoFRR7/E0qJbY6xgX6Z1wzonnjTyt9DtAeY2WKTEQNLRy4Cw/Z?=
 =?us-ascii?Q?8tnaeK904WqhucLOLIBAGwRE8XRMskww3wGCXPdLWRPsJMojZxNi0nyTQuBy?=
 =?us-ascii?Q?k9cEeO8EtTDeXLdQbgclC69dwzvq+vO56BzTuwyNG01Mt/kwq4tqB+BtDkK5?=
 =?us-ascii?Q?rv3aHwSMWrKwYQSmziAlyy3N/uLDHU2EwQgbulO2qnB+M8D6/VGpYnsr3h17?=
 =?us-ascii?Q?V7H3DfBSoHvJ2lV7VJIHusfUcxZF+WKmpaCYvChnHTPC+RkfEiTIsZnQpnDW?=
 =?us-ascii?Q?1W38menF+uIS2ommYgj1b+yYVu7lntvC11mtFn3JpIDbnxFwVPHAmdOZ8WYx?=
 =?us-ascii?Q?OBAyr4v6XAWJvruu4jQalbGPAZmsyHivg2orMR/1crurIFgBujykvcCYgDCb?=
 =?us-ascii?Q?nfpSfK4V4tp9rZNBk5w2/EktU59TYSTjOhyjhhXk9uyAAxxqiSB9EgRjGafW?=
 =?us-ascii?Q?C5BQw2JgmMYWE4TjvwPYiH6kj56Uo+kFaxATBRVcdkIKIXXC99Tthz84NfpS?=
 =?us-ascii?Q?mFSvpB9xWPVMX4n+bM43ddpMMuliMa9VTOLdYTdP311PVaCAus1mqeAoIILT?=
 =?us-ascii?Q?MbigM1M6E/auVM2XZTTOu8R8uhkYG4/tSy/7Ecuyb8RTjEqFXiJJexCNmHuB?=
 =?us-ascii?Q?J6njDLcrNswTMwdOQUOtKBarKIJsIIitOrXnfoG+I1RZePkkQlvS6ed8YEqu?=
 =?us-ascii?Q?wee7DKTW0FpC8d1aMXHpEZw6bB/pAPfSOSoc44TyMfDrGbIOVZWNiekI25dS?=
 =?us-ascii?Q?RZ67KZDclYTpB0IaIjGxkaYQLSsL1iv19BKQABwzZ3OHhwwg/yclTQoFgwAv?=
 =?us-ascii?Q?nCkj7S+C2oOccXKptbKY4GiP2NFY2Lf6GGdCN0F/Ln+uTVOJHu9uhsn2OJis?=
 =?us-ascii?Q?AIxPOakGOZB+Z5ErikdazA4HckjVtZWpx96JSU75VcuQta7yfSQAaSoTyTbl?=
 =?us-ascii?Q?SyNrFy2LjQnvRct7njH1AgCdgamBNNikLWyb8tA99+dbsI6uHWcmO9o85wv9?=
 =?us-ascii?Q?UE2ePNe+GpsFwDE4KFRK8+9Eu6np8+bitw36+Vn2wwkkiDHb//FGc78AseIe?=
 =?us-ascii?Q?GokeCnc5DZLWmwJwoaa9WGsRsyCdiRfFB00Db7XcDT8dZxZNuqH3rvcPPk3C?=
 =?us-ascii?Q?yOQ+COgXx5uxaBRViu1co9FxIP+YmkP+x3bGO8lY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8b0349-4427-4997-a17e-08db66bf146e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 18:51:47.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/cGzu7Nn9Jo4e/m5hMaVKH20dBRpbLCFru9EQkTa1SRmEus4iqskNWt7b5ybSGHnG0x0T5e+Z66mGzXxKiMDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1732
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 0v47d4oTxYSbMX54-GAkOwB-j2nLTKlB
X-Proofpoint-GUID: 0v47d4oTxYSbMX54-GAkOwB-j2nLTKlB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_14,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=658 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306060161
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the feedback. I have a question below:

> > +	base =3D devm_platform_ioremap_resource_byname(pdev, reg_name);
> > +	if (IS_ERR(base))
> > +		return ERR_CAST(base);
> > +
> > +	regmap_config.name =3D reg_name;
> > +
> > +	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);

> Why are you not using gpio-regmap?

Is there are good example or previous commit you would recommend
looking at that shows how to convert from regmap to gpio-regmap?
Later in the code I am using regmap_read and regmap_update_bits
with large differences in offset registers, and not so much a
contiguous block.

Thank you for the review and assistance!

-Nick Hawkins

