Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6746828D2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjAaJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjAaJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:28:23 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8571FC14A;
        Tue, 31 Jan 2023 01:28:18 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V9KiZ7020093;
        Tue, 31 Jan 2023 04:27:52 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3negvtn42n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 04:27:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8F2smzPPUMlY+wXBZjwGstXM6ZlfAn+NZGBTSa+B/ZTBB64gnfxFHLh4+vSLjXWRmNUjr4lfZgXZfnnXJ2t5UuZMFtRzF4gZ6qSn7Rc8yUwBjebBjl2kDZ+B8tmvPIJZV57bi5ed1N6w4jXCjkDt2GUFEsXT+mlVwtpT6fJgRgZr81w5WxjUGar8dPECC3uzrio9uNEoTT2QmrX/jDBRsKAPWTxXyQm5XwQT9/VqBOEXXpmi5oA0/kmxEHL/bMJqI9dXq24iRTY/Vj1WjcfcDkvLyk3FrKG0QWTUGMOz/Xvr6A+FF8aLQhtLAROu2ZesZ7fayxgRJD/cbXmewyFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55FXE0p14RP2qkUPvAXu/OBoi9Jp94F4khuQAU3C7LI=;
 b=KJ043ix4iYWyC0TVvKnPvavfW29dmJIcflydEQ2+CMG5d2tf/w8FjBsRtnZVaRSpJZDlHTA7wc1Q/PYzWcCs1kUDUThbsWZoxF/nNHh9LR9upvMewLIH483SmREAtBfNPWFeEPp61ECF0jRxVzKUYkKUgVOV2OX7OqNe+AB3OJp0hA87kxaf/4mqT8Ci9wXRxWtRQPQR9KWmo4mrTkPmPiQbPH3a30YfbnEpOUZMAFQ7RVsYJdVdOF06D4k/iIQSfOl/uaktDZcfY2cpmHvpzkvShdZ8TW9UQMCjc2zpvc2rUMReBRLoab8wPQAq3rJZwIr+FbjN3gg2mu2s8pBSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55FXE0p14RP2qkUPvAXu/OBoi9Jp94F4khuQAU3C7LI=;
 b=sjXRToR7bekgUjdGIWICweHQe4pE9zyvV1NMrJGV4+Jx7qKQX9u01gAfpKnjTkvCHi1C3T5ALFFRcGD/LHB1yuVOtjrbZEOdgO46UO01EPmXvszt3MlxlD39G67kb3xkCoA+5bzGjJS7PrLr+5pHmFdpyxItF4dM1GZqm/4YzBA=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 09:27:48 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 09:27:48 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Topic: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Index: AQHZKwfLM9q3yL8ciUSLt6aTy9zYOq6j1SEAgBRcQ/CAACJtYA==
Date:   Tue, 31 Jan 2023 09:27:48 +0000
Message-ID: <MN2PR03MB516865804044A798AEB5B6C0E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
In-Reply-To: <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTgzZTFlY2JjLWExNDktMTFlZC1iZTk2LTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFw4M2UxZWNiZS1hMTQ5LTExZWQtYmU5Ni01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjM0MTciIHQ9IjEzMzE5NjMwODY0?=
 =?us-ascii?Q?NjQ5NTA2MCIgaD0iYVh4bXZKRGRBaDZXdXdRMXQzUEtZRUhkMjVVPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFCVWcwUkdWalhaQWZBV3ZEOVF5QkxROEJhOFAxRElFdEFEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFSczFnRlFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|BY5PR03MB5202:EE_
x-ms-office365-filtering-correlation-id: 00a574b3-c383-4020-8c36-08db036d6b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffpXk4G2HkNxI/mToJTUuvFYNAD3/83Z15+OtgEfH/Hn3iR+bSUhvqD/IasQmBrWMw44i0ztaou/ldDFaq2IOnVNsY8T3pbD104T2dMG7Bu56vCfg3qL48krJECFpeHWSrOWdPvyblLwZ6qEKgQ3kkkJh5JsP7rNpz7IuyDC1Na6Xa++hnTZ/iIOCzzsY7yrPylCvTXjcBEnL7lFEOW1JFpFgp53NJ4jwzP1lpPr0/egqfcmWhpu5hjyKt7XttEWoccaMWWM6fLEaXlYPgEwqxPaYU/KEqECc5k35647H/jtM7axkiPiQwiLtTiIFJlNxrgy0uFwChEyU8QxYby3ClrPFBcsIw42Au91rRvvh6VvX15T81sm7h/XjngQ52qKkijw52ewrIbRm78wrDlsiKsdL8b+xoU5t1aIobNelyR++MOwNxj1nxHb7A6c1DaY9QHaCdSgoSxX/51UnDUjro/sge8TO30LvHSzwcU7M3WW/NBR1DcqY0RPKzqn8CAESgOd3ju5Nh+Q7436nfBSm7E3uSG7xvbNbwnGz56uvRlo8kbPoIvpsl7PlL3V0UXgdShJmhdFlrR0DpOhBPYbS+QUFeyzmiakurU/N3F8Cf6wsxDHfEBpgAhwriMpXYcE2MM1hIeQjQ5YoLABheKsKZUdhx3V8GywiVUYyXXzZPBm1DjteBdTrwuAIKHS/XNS+G+Ao1wDkPQXHqcUL6DUJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(52536014)(2906002)(316002)(2940100002)(122000001)(186003)(53546011)(6506007)(5660300002)(38070700005)(7416002)(54906003)(9686003)(26005)(38100700002)(55016003)(7696005)(71200400001)(33656002)(66476007)(86362001)(478600001)(66556008)(8676002)(6916009)(64756008)(4326008)(66446008)(8936002)(66946007)(76116006)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YDdISysTQ4Whd4s/z5CAyWaE2Mr3F5xDsqksgRluO2pUWRUrWKC4idBanFqN?=
 =?us-ascii?Q?yYbcDjPwSJv14CIqecIEHlbUKSn9kN9ADVOpH1mk1ki2YMjHhPanHsJzQJJ1?=
 =?us-ascii?Q?4zGwegAjPa+q0v6JjBk0YghpRmRQ6I2q7PTnznu/ejT0T/NyI062fnDCZvR4?=
 =?us-ascii?Q?q8KgS6XcG6EcCoKaTtnBz/NZY7hKre5Hp5DBi6BgMb8APx2j0giOK/Uzcf7U?=
 =?us-ascii?Q?mzXtuspOXQflQMhTpqh9Ve1FD+wXfHmoK8egzQa0fvpmeiuaq2HuAoS2+ivh?=
 =?us-ascii?Q?IvyZe1ccAgz0zTRDxPr4JuVYx2be7GQocCt2ccHsOaUA0BIk4foWynx30swV?=
 =?us-ascii?Q?zv5ckIEXgu2erAb7FShkeZpxibBA80mWobh7uoHp/+tjI9Fp6JeRhUmIvurP?=
 =?us-ascii?Q?t5vSm953XT1NRrpGnAO4Gcoy5NY02X+THXQQCtBbZAKKT649qADL0fGoX1K8?=
 =?us-ascii?Q?sDbEE38w0aLMGDTtmkgkzq1awPaP9lDaqFNmWQKFVLusGC1ydfTiXvQLojRo?=
 =?us-ascii?Q?nddNxDoCWOgUOauO1Rjuhbsde2rwD6bxvw1FDeof+P8oxKaUg9jmVlZg6QD2?=
 =?us-ascii?Q?BVwwzlp9MLDqRM3Cz5gI3kUT8YoCBdKVGm6wMzFJkwToQwdgijh0I/38ahAM?=
 =?us-ascii?Q?My72BZmy2QGqDWia4E2gtaBD4lAwFVmK6GkjIj6X8i5XT3FJMEsuBiUiceXB?=
 =?us-ascii?Q?9DLgti4YV3lmOA7gg8jXQOhp3Hmc6284/0bzcrxEJXGr5YJQWv2TF7ON3CjW?=
 =?us-ascii?Q?1dfvqged8RA4XDmo0rHiyyUOIpISKD98zprYf0EGEaigrSr3VAP8LqKaTsMr?=
 =?us-ascii?Q?+ZG7BRimiNKxV8KQZtSM2anzWw710E/ILVxKl9JEn5CqKI0pbzZZThctveqe?=
 =?us-ascii?Q?Tc2DV+HtsYCFDPfklywOGczzy0CqpiwOQhZHK8s3gB5rNDNSPLxNGuNU+qiR?=
 =?us-ascii?Q?TboWG7MTvSViaKJTiW/a469zW4Q3FLAYx+860f8dFAu3urmhlb4jApjrNe1S?=
 =?us-ascii?Q?te5IfFoDMUlExdzpLzYcGx5fdS6EZ3urP8NuG1jKV76cRMnXPGDeC4x73E0I?=
 =?us-ascii?Q?KEyqEkAMyxZM+6gJEigGj3ywE5m7zL0fXp8DZ5Tb2XkjXdEOP9FlcK837yRw?=
 =?us-ascii?Q?lrixiwucmcgdanUI411BHBZzsfct3XKX5P5iUGXOAn1KfHKAXLr347dudl8O?=
 =?us-ascii?Q?74tCKb0+wHlpO6Ze+QHQvdevULJbIR+ets0lKcfGj8wB4TLMeBHXqsaNR6mx?=
 =?us-ascii?Q?G/D0VEYgBanlmDQUdsjc1yrlyjvlQvK39JRg3hBI1UYkC8CJyn9MLZmASRdY?=
 =?us-ascii?Q?dsEDxeo2bsUzaalEbhAl0jZPFdAsyTaI5gcbxJyLUan3WrMFxBMWCxOW1Tzs?=
 =?us-ascii?Q?O5gG5XMAHn1EcatskcaMK5xiCXGlyg7q071LQ+ASoe7DHDhFW4tWTaAkdhtY?=
 =?us-ascii?Q?sDDjp4Ar8DxXdHXLQPjUD8zcYRd5pDBFrfm064V2f4krvihX6I//Bym6fUak?=
 =?us-ascii?Q?Q1CDdbwhQBI966nOxaibopPVvIzCqHgY7Z54BXHoc9Hz1BKAyQ3tDqUEg2Rd?=
 =?us-ascii?Q?x9+CexeGNS/CVjTAUTIot7CetkHeUOlfoweSxWRd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a574b3-c383-4020-8c36-08db036d6b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 09:27:48.6750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKI59ObpyqOZWtK3wKZQyKp0vRE5o2pinx+jsiIKRrQagF5eOMs5a/HwORemaJXmhAve8oqNQi06vBsldGatvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Proofpoint-ORIG-GUID: A42d89DgJIZih9m4JxHsxS3QynCj8U9_
X-Proofpoint-GUID: A42d89DgJIZih9m4JxHsxS3QynCj8U9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310082
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,

Sorry for second question. I do not want to bother you, but I realized that=
 I need to be sure about driver_data before sending new patch. You said tha=
t you need to use pointers directly for driver_data then I fixed that part =
in mfd, but I do not need or  use driver_data in regulator since chip_id co=
mes from mfd device so I think using like below should be enough for my imp=
lementation.

static const struct platform_device_id max77541_regulator_platform_id[] =3D=
 {
	{ "max77540-regulator", },
	{ "max77541-regulator", },
	{  /* sentinel */  }
};
MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);

static const struct of_device_id max77541_regulator_of_id[] =3D {
	{ .compatible =3D "adi,max77540-regulator", },
	{ .compatible =3D "adi,max77541-regulator", },
	{ /* sentinel */  }
};
MODULE_DEVICE_TABLE(of, max77541_regulator_of_id);

What do you think?

On Tue, Jan 31, 2023 at 10:21 AM +0300, Okan Sahin wrote:

>Hi Andy,
>
>Thank you for your feedback and efforts. I have a question below.
>
>On Wed, 18 Jan 2022 11:20 AM
>Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>>On Wed, Jan 18, 2023 at 09:38:10AM +0300, Okan Sahin wrote:
>>> Regulator driver for both MAX77541 and MAX77540.
>>> The MAX77541 is a high-efficiency step-down converter with two 3A
>>> switching phases for single-cell Li+ battery and 5VDC systems.
>>>
>>> The MAX77540 is a high-efficiency step-down converter with two 3A
>>> switching phases.
>>
>>...
>>
>>> + * Copyright (c) 2022 Analog Devices, Inc.
>>
>>Happy New Year!
>>
>>...
>>
>>> +static int max77541_regulator_probe(struct platform_device *pdev) {
>>> +	struct max77541 *max77541 =3D dev_get_drvdata(pdev->dev.parent);
>>> +	struct regulator_config config =3D {};
>>> +	const struct regulator_desc *desc;
>>> +	struct device *dev =3D &pdev->dev;
>>
>>You may rearrange this a bit
>>
>>	struct max77541 *max77541 =3D dev_get_drvdata(dev->parent);
>>
>>> +	struct regulator_dev *rdev;
>>> +	int i;
>>
>>> +	config.dev =3D pdev->dev.parent;
>>
>>dev->parent
>>
>>> +
>>> +	if (max77541->id =3D=3D MAX77540)
>>> +		desc =3D max77540_regulators_desc;
>>> +	else if (max77541->id =3D=3D MAX77541)
>>> +		desc =3D max77541_regulators_desc;
>>> +	else
>>> +		return -EINVAL;
>>> +
>>> +	for (i =3D 0; i < MAX77541_MAX_REGULATORS; i++) {
>>
>>> +		rdev =3D devm_regulator_register(dev,
>>> +					       &desc[i], &config);
>>
>>This is perfectly one line.
>Thank you, I will arrange it.
>>
>>> +		if (IS_ERR(rdev))
>>> +			return dev_err_probe(dev, PTR_ERR(rdev),
>>> +					     "Failed to register regulator\n");
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>>...
>However, this one is not fit when I set max-line-length argument as 80 in
>checkpatch script. What do you suggest? This line has 99 characters.
>>
>>> +static const struct of_device_id max77541_regulator_of_id[] =3D {
>>> +	{
>>> +		.compatible =3D "adi,max77540-regulator",
>>> +		.data =3D (void *)MAX77540,
>>> +	},
>>> +	{
>>> +		.compatible =3D "adi,max77541-regulator",
>>> +		.data =3D (void *)MAX77541,
>>> +	},
>>> +	{ /* sentinel */  }
>>
>>As pointed out, better to use pointers directly.
>>
>>> +};
>>
>>--
>>With Best Regards,
>>Andy Shevchenko
>>
>
>Regards,
>Okan Sahin

Regards,
Okan

