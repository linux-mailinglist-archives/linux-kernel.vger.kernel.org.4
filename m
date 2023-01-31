Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2EC682DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjAaNYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjAaNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:24:10 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD842BDC;
        Tue, 31 Jan 2023 05:23:55 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VARJIG022187;
        Tue, 31 Jan 2023 08:23:36 -0500
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3nd17bj4a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 08:23:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gypQj9wrBZkKiIDPncryPq3u9Ob6MT+YCprBQPebCFseY934lISxQcrLCCEcOT2rmeZae4YuunQvV65BUPCSl3Dp+7QDB99Sdq5EdaBmy9QoWo5SiOT71/qoYL1Q8cgdUHiSXqZAPkEam6usjo4iO6HFES0YV0uCbVL8oL+akFHe0arWeMR1JZWOizH0rTOOC/LH/DsZOULCxjDEwrAmg1+iNeLm8Aq6D5hjtrL7NdclvWkZrVpmSrNR6ZwxeJQH4oGa2eFnvOJxcFO4azMc0qN1Y/4UaLse8pNS2RQPtHGkFoqviVfTIs0lWuy8UVOER6vnaWxgYsYhisctE/PUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHf0+qP5hiheyxiXcdI6yyMvvxrDX5nlkl3n4LPMEZk=;
 b=YTw3z4SYDarG3zdlMlGWA2wLZ8XopuI2VbCOeUOWaYAcs5DFuatzml+pYStctoUY2FlOv6Og0sFCNm/IBExUHzBo+waxbnlCubkhVFOAeUdaQfmW7IHawRAlrTV+ZaE4XQPIogpw1+zGZkKMVx8cD2Ph0cTShfAx74365AEr8HMYmgFwe4FZplT5uTBBLxgMQ2rw62Drkyt1vnw6vFJKIlcPzUrA5cZk9sHN9X3GnE+PaoCOut1zowz/PEkfvz/fgQUXf8kiBw9Al8QX8a32gRAepY5bIz0YAL6MirHzSOp3GdqDzNbddS3y7Nv4Hzqj8HzCbTLtaaR6sas9JQJ0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHf0+qP5hiheyxiXcdI6yyMvvxrDX5nlkl3n4LPMEZk=;
 b=1eBWk8hA8PAeZ69F6sgyLosAUoShejU8gFfH8TvYt0qlk2srjyxmFbMI52TCwtzCgCiRxIwGZJXxWwXRX7/ygNwFr0wtfEdMwy4i7eLtJ8wIBDX3d7drzUvU4oo8Ua3QGruKtIQAGKNkkvVXYlb3oDwL812Zem7YnT1n3DRqkCM=
Received: from BY5PR03MB5153.namprd03.prod.outlook.com (2603:10b6:a03:22c::21)
 by MN2PR03MB5342.namprd03.prod.outlook.com (2603:10b6:208:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 13:23:33 +0000
Received: from BY5PR03MB5153.namprd03.prod.outlook.com
 ([fe80::f306:167:891a:c68]) by BY5PR03MB5153.namprd03.prod.outlook.com
 ([fe80::f306:167:891a:c68%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 13:23:33 +0000
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
Thread-Index: AQHZKwfLM9q3yL8ciUSLt6aTy9zYOq6j1SEAgBRcQ/CAACJtYIAANL4AgAAM2mA=
Date:   Tue, 31 Jan 2023 13:23:33 +0000
Message-ID: <BY5PR03MB5153C18E65B954E9FEFD96B1E7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <MN2PR03MB516865804044A798AEB5B6C0E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <Y9kJEsjkG8h79tcR@smile.fi.intel.com>
In-Reply-To: <Y9kJEsjkG8h79tcR@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTczNzFlYWM0LWExNmEtMTFlZC1iZTk2LTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFw3MzcxZWFjNi1hMTZhLTExZWQtYmU5Ni01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjE5NDUiIHQ9IjEzMzE5NjQ1MDEw?=
 =?us-ascii?Q?NDE4NTkwMiIgaD0iYllmeDNGeUVXTUthdHIweE9zNGJGZUxoZDk4PSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFBdWxNMDFkelhaQVVBOW41NnRvNGtyUUQyZm5xMmppU3NEQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: BY5PR03MB5153:EE_|MN2PR03MB5342:EE_
x-ms-office365-filtering-correlation-id: e1a225ba-ff5f-42e4-00da-08db038e5a2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UavDH4BjfyrrGRPppO72T6IUWLtbKJrBSoMq52UsOrUgHBGdmwnwi7rvFrmDMTwbMMIao8V9bBtdjBAC392h2JXc2dMEGK6BZl5vsKlRVqC6IQOIfyRrI2QBBUQ2p3RROFYiA2cLhR0I1DoHnK6QTv7nJ3FE9xSMDIWSsi6zFfnsI/VC9Z4uuOnAZpnkeLrFH1zFCITH8IoWuhWRzUzjZoBQAnDfupdBOLR/hmjkhZ784eiveDqhXd3Mx7dsAe/UU75GzIIgi0P05xFh2VuhxUZ304rn5FwWbUxJPBNqZUX/DH+56vqeW03B/bw/yVMxFcWyuKz8vvnMpLHmoroPpQPNN00k+vX5PIm3kwPvzROcXAZMfjeC7URhlx2oXuDKWznveJxnC9sDBEgwbUObzSz/n59mDbWQYa2DFMw2pQPae1/lrWrDrgp/eZtr4AFWM9fGKzNbsrBjI+z/20kpM9M38nCDIzmOVrhhTFpE9t4sYJBH7+ysqfaIE0ufCKH4ovS2XUg3k+S52SG4gqkieeDmdMAVI97Q8lrDCIMWAEa0Bk9v2lH8e5qu6pF6v1D83jh0KLxF3Oc8rdCNh7i9o5TVnUrmbEiRb8Lwovt+9G/RJrsOjmVx2sJ/+guavshtcw3DV+84i5fU/9r8gGgtBlouCyDrRWo3TFNTDI+xDhj6HcCVh9mJEx3j3vf8aOERovocmUODYiI7cCMKPVLftQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5153.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199018)(86362001)(33656002)(66556008)(38070700005)(38100700002)(122000001)(52536014)(5660300002)(316002)(8676002)(4326008)(66476007)(54906003)(66946007)(76116006)(66446008)(8936002)(64756008)(6916009)(55016003)(2906002)(41300700001)(83380400001)(7416002)(478600001)(7696005)(26005)(6506007)(71200400001)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tybOQNCf/jSB8XatZrA2ZE+6R0AtStgZHI63PFmv+f3+z83ykCOgH4V85kvF?=
 =?us-ascii?Q?UifvmYrQeYOV4U8h5CTHVIuZBjZD6pkWqDxEynUDjQy/OKdl5rpPJC8yAdYm?=
 =?us-ascii?Q?LSd3CHJxCuOGv40KWuhU9RUHajJ1Vu9XRClK5t1athL3xuUNgRGmAofsAvjP?=
 =?us-ascii?Q?FM+bEYoxxDAoc2lKzg3L3z27eO096wXcvgqTna6EUuL39jdUGEOus73F9iLU?=
 =?us-ascii?Q?8YVac2jUl4TcOA09MfvtjQBIpdD+ajqfDffj25ZDVIW+fdPyujnStaS9HL89?=
 =?us-ascii?Q?wuXf9RTje1i+gdwVMa82UwBssHwWUHYC8Yx0crppM6WZERT4/d2+r0MB7G+7?=
 =?us-ascii?Q?qb2Lqx6X0VZOUgvMsVzUUnmdmlpJ6KxVgghNDXx2d3M5prAf0homMqzWiWxV?=
 =?us-ascii?Q?QeZUzQm6QPBIubEn+zLh+23iLJdzahaMGR7liA+yZWvf3Au+D0vokW5jFu34?=
 =?us-ascii?Q?RLRi6XMKeaTZk78cL1gXqvWn79/SeXe1mqfMc1qFb0nKfkNn9dIWHe/7bFwZ?=
 =?us-ascii?Q?WpfT7NdbAzADiGWFppQ5uWIfy5qlpds8LBYoFKNdxRDIl5xKGTH9bgqW5kJM?=
 =?us-ascii?Q?ckVmvBQ0WuKlu42i15ha9kN1GUenuRgL8XAbjLZWb20veUHtLH/AO2kWi0s/?=
 =?us-ascii?Q?CX79RwrO7gJSjyYv5bWYrzyeo8fFk5hw1zBt0ExjP+1nAQq45/Tqtt9qhLIk?=
 =?us-ascii?Q?2dLFt79Xo7oYENvgo3f7tcIeNmcHq75zoL5/tOsTOQltBmhV5zOWNC5DaZJK?=
 =?us-ascii?Q?jZgRHhr8/mBX2qbMrfH2TFP/CjTfdiNxRRE1aF6Z5wOMLTOzPMI6gUV7n64z?=
 =?us-ascii?Q?NcqbukMmWVLSIf06JPWBzEvI9sKXMJj0R8zoASpygWHNp0SPUdWVlU5wTYvu?=
 =?us-ascii?Q?EMV+Ued28Ik5xdYXtJDHRq5zWkXWEtyMF8Vc7aMKVLYuDQ45PLfPw0LiI3sF?=
 =?us-ascii?Q?A2zmZOiD8k05y3XqhpHB+1PbtMmyL8ScWnybz/o9tR/qPaIrjYPRdSaghsRR?=
 =?us-ascii?Q?XUpg4s04XgscfyjJfLA88PjDoNR0DlLE+kQoS0ksXoZCWh8jKrirlK6fV4YT?=
 =?us-ascii?Q?VgwqQFZuHzc8h744Cap7fm1lBBMrgtL61vd5jTD7b+69p36w+F3zTF8rCVkB?=
 =?us-ascii?Q?5SF2QL0iN5SKXrxAiwsi4uOzsBXM1/EmVeebb5rX/T4K0za1h+Tgixb90Loc?=
 =?us-ascii?Q?DlS44T3DzP5vMR2AMw+TET6jI4jGfyzEjErCZPbaFJJBymi85/grM/MBFGD5?=
 =?us-ascii?Q?ltZCI2BrjCG5Th7PqSXpfQCNnzhV4o6+ISMs1Yqyt91jjjFUPF1zKjidKIt3?=
 =?us-ascii?Q?OKABSG255lMHKbI59ytIXogCqe4HNMAPG3JdCjpu7dJwNmKy2gukrzc/2b3O?=
 =?us-ascii?Q?i7JqstisxHEFqN2MkOmr1Ej650zwn4AHHX5Ks/bmBXsyKssqvpNVAYeLHATm?=
 =?us-ascii?Q?S+ygVC7v745q3/lamybEZdpMpqwuAR7IWAZ6iAH9T6Lp93cN9+YI56gyi6Ss?=
 =?us-ascii?Q?WqOVuQmixzBC6rHa77GLF7oDjkfjxLzrx0+C8C/4uNmxrzXTfy4JLAtuxR0X?=
 =?us-ascii?Q?pEEY5VhtfpUKEfVf1HHFJ58O5+Gpzjvy54DoN6Jm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5153.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a225ba-ff5f-42e4-00da-08db038e5a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 13:23:33.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCi8EGbZI38wjd+cFO3werY54DlMWLWfITM1el6cPbfl6sRYmOEnZlu5hyAD6yF2n800azdKoy9kKI0ZGGfLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5342
X-Proofpoint-GUID: hTykkw0F1SzqTXH5idK_Hdwvo6AwTpgR
X-Proofpoint-ORIG-GUID: hTykkw0F1SzqTXH5idK_Hdwvo6AwTpgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310119
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2022 3:27 PM
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

>On Tue, Jan 31, 2023 at 09:27:48AM +0000, Sahin, Okan wrote:
>
>First of all, please do avoid top-posting.
>
>> Sorry for second question. I do not want to bother you, but I realized
>> that I need to be sure about driver_data before sending new patch. You
>> said that you need to use pointers directly for driver_data then I
>> fixed that part in mfd, but I do not need or  use driver_data in
>> regulator since chip_id comes from mfd device so I think using like
>> below should be enough for my implementation.
>>
>> static const struct platform_device_id max77541_regulator_platform_id[] =
=3D {
>> 	{ "max77540-regulator", },
>> 	{ "max77541-regulator", },
>> 	{  /* sentinel */  }
>> };
>> MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);
>>
>> static const struct of_device_id max77541_regulator_of_id[] =3D {
>> 	{ .compatible =3D "adi,max77540-regulator", },
>> 	{ .compatible =3D "adi,max77541-regulator", },
>> 	{ /* sentinel */  }
>> };
>> MODULE_DEVICE_TABLE(of, max77541_regulator_of_id);
>>
>> What do you think?
>
>If you have got all necessary data from the upper layer, why do you need t=
o have
>an ID table here? I'm not sure I understand how this OF ID table works in =
this
>case.
I added it since there is regulator node in device tree. With the help of d=
evm_regulator_register(..), driver takes parameters of regulator node. I al=
so used id to select and to initialize regulator descriptors which are chip=
 specific. So far there is no comment about OF ID table so I kept it. I tho=
ught I need to add both of id table and platform id table as name matching =
is required to initialize platform device from mfd.
>
>--
>With Best Regards,
>Andy Shevchenko
>

Best Regards,
Okan Sahin
