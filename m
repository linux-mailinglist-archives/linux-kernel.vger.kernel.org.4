Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618D7682E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjAaOAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjAaOAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:00:08 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88C8392B8;
        Tue, 31 Jan 2023 06:00:06 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VDs7k7020461;
        Tue, 31 Jan 2023 08:59:48 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3negvtr3d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 08:59:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql76dtwHV/wEc4qSW5sH9t6CU+amSZeqjBtQ4tDGZdmCmKEorsLhHsowOhtWsjTsWUpgwLP+g7XbyD+rOAx2I/J7wWzx5/bICPEDiugIDO/nQIXuYH9dXhjQpZ7MrWXoOOMKazdyotxYfu8rWk2sj7zzI7H9YnIDf0VY40JItJ+fj+6hKmKPOMpnEr9axaiumri7PfqH7ONT9N9x598gnB6+C10HZBIjFUYEeItr20LX9kZBYeP3m69zTd9ZQsXNxgaRs5dZevfZgBH8RaflD83ytrnq0FK90rsDR5KJmGCPBm/ggTNMrmXp5Hjzsr0hf/g4C8C1Fs6b9K3Y49EGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mQtYTZPumEw3Knae0NUmF+BqsDt4pLfvJSuxKkU/WA=;
 b=UfDMu8+dJ9/fWArwjYMEzdhJnACHWT72LVniaq+N0MUPPPj1qRzqGuN5l37vDMEMdLgNxl1fjtT/s6juSDdVoi7hPv9KwzFtYonhmKETdvocr7pkiXiiSVlHZ8hwVuIojrGb3vpYyTqtwR2jjRwdbZxcF05kfp7+Nzhe5gMfnHa+2XZr5/hEEleS4w5ySwUfxo5V0w7ZBbaA4Z8AEGvKKqFKCfjP/l9oF2VW5gkmY6x+KjwlZCn290FMbdzMIJOEpay+JqmHV2XC52JkruIQvCd2c9wNQFonZ6xohR8uJoSFLT2JAD53FkqP6Ey8TfLF68csXu4Ve3eyoVQNi+TcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mQtYTZPumEw3Knae0NUmF+BqsDt4pLfvJSuxKkU/WA=;
 b=8KJcHW6XRzqjTt1FePpeF85xYcUaliBz+Jmtz37TTEdJT/IXxsMyDXlLpJ2/QYlgxi3XBaGx6CSFElHvR3m2qIH33QEcHmTfZAtM7Zo6VXKqM8TMyyC365dFgXhyIDKU2YsVlyo9e/Y3dALGU5YpsMqY5KqUdMcIvrer1Abq1mc=
Received: from BY5PR03MB5153.namprd03.prod.outlook.com (2603:10b6:a03:22c::21)
 by CH2PR03MB5238.namprd03.prod.outlook.com (2603:10b6:610:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 13:59:46 +0000
Received: from BY5PR03MB5153.namprd03.prod.outlook.com
 ([fe80::f306:167:891a:c68]) by BY5PR03MB5153.namprd03.prod.outlook.com
 ([fe80::f306:167:891a:c68%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 13:59:45 +0000
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
Thread-Index: AQHZKwfLM9q3yL8ciUSLt6aTy9zYOq6j1SEAgBRcQ/CAACJtYIAANL4AgAAM2mCAAASrAIAAApHA
Date:   Tue, 31 Jan 2023 13:59:45 +0000
Message-ID: <BY5PR03MB51539CB52778A945C8CB788FE7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <MN2PR03MB516865804044A798AEB5B6C0E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <Y9kJEsjkG8h79tcR@smile.fi.intel.com>
 <BY5PR03MB5153C18E65B954E9FEFD96B1E7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
 <Y9kXxP/cEBJ5gyoB@smile.fi.intel.com>
In-Reply-To: <Y9kXxP/cEBJ5gyoB@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTgxMzQxNzhhLWExNmYtMTFlZC1iZTk2LTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFw4MTM0MTc4Yy1hMTZmLTExZWQtYmU5Ni01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjMwNDAiIHQ9IjEzMzE5NjQ3MTgw?=
 =?us-ascii?Q?OTk1MzQyNCIgaD0iZ3I1a0N1UmIvMGpmc2I3N0M3Rnp2WUZ6bFZZPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFDUVRwRkRmRFhaQWRCd3BoZi94dmlwMEhDbUYvL0crS2tEQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: BY5PR03MB5153:EE_|CH2PR03MB5238:EE_
x-ms-office365-filtering-correlation-id: dd9e348a-c4ef-48d1-09ad-08db039368cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHmDMhnuvkFdh1KMl1fm9dTH9NJ2gaUnMRQ4J4Lvofp/9rmml32femibVcnvIuZoQ7982KxuLYQEG95OdalzyUZGQRDrigOfEH54vXFjAt1FbV+HUXp+4Y0N5mijTzjHYUGeNtGxbuWFct1b54ZKX6R1pkhfl/FFHkTMQ1ByonJ48kI/thrrJKpwij196dMymICUkb6z6FBJ8iyP1tS8KSYtxLg3h9CaZT8iWvaT238OucnlTB1HhRLs5TtSR0XUx1BpRIal70MzZ1mKwBBe6jmt2cDRo+6MvZerlbJn5XIyE8J79jLx0TE/7vqzOTFM80TKHTzYi/8Cp1gR5Czpo392Q7Juqrocfu7ubNq0XixfTmDaG/PwoYFbl6N2opTXfYzYzLcl9SzMKJEZwPEH8dHhJyiJwO72Hdqtx6vF+uRmGaDiQlbbevwwOHpAYCat9I2NDEkHnc2nPsHJsJTvcRyYJyp8BuSpf859e0Ekj8oSrOyO5hibzlj1zPDFDWnkeRFovjWb7bWrypzK20PWfdskgeREt43r5jXrk+mv//0yZrkUe1hOi4pgZEa/lPWQTuHK2l3ukodSijQDPEk3P5TVt7w86t4URL2WD1OsTmXIri3oxQ6XEnbCL8ROQEUDTJ+ZS6G+emKp5We2tF4RPfl3dugj2K8V84T983lB36OKoUwcFaUrdxTf+1Osi6uMIfbjj1FLQEHZJ00Kn6+oTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5153.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199018)(41300700001)(55016003)(83380400001)(86362001)(38100700002)(38070700005)(122000001)(316002)(8676002)(54906003)(6916009)(66556008)(66476007)(64756008)(4326008)(76116006)(66446008)(66946007)(6506007)(33656002)(186003)(9686003)(26005)(7696005)(71200400001)(478600001)(2906002)(8936002)(52536014)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i2meSJSvG//5OfkTl2jG14wv8OsWp44wMx3BnzzkY1TLvy+/5jkiu0cZgkjX?=
 =?us-ascii?Q?ZIvBT//RhgHBEYjfDo/egj9vFJFyX607m7z9nOq0Oj4v0avmyNZdoHFnF86h?=
 =?us-ascii?Q?O6MoIdfzDv6GSoVAZ9klTrXla2v0fYC5XXRMQV+oKxq9q1Lc8zlCsiVlj5N2?=
 =?us-ascii?Q?bEgDPb7TDqAory8L5JmINuu1wRimbHsw2tp1GAZpg009fU9ULyVz76PSDwDd?=
 =?us-ascii?Q?rxfKIxh+yBI2m62q5UwRqC5RimaA8BbAP+l8XnmjAxTFrqeVEvHCMC6G9cNg?=
 =?us-ascii?Q?FFy99rDkktln41dj8iNHkmT0UjC1CoEc0ev87ZUfh0rC24GSe3H8liuvWe8m?=
 =?us-ascii?Q?Bbl3SXR17uw9qC8AWQCvFrt7MaQdbtddOdVGi+NiJXtLDUqfRPI4hKkBykic?=
 =?us-ascii?Q?jwymSpDGnQj6oJlcxcuQ4F2b6KH1Vkoohj5hDqYAsE9UK3zV19Hz5Ih7bJBO?=
 =?us-ascii?Q?i8mGdf3UqQxY1trLdCD7Hp1/aYEK7xt37V0kCoAv8KdIgDuMqWqPbMG8mQ2m?=
 =?us-ascii?Q?zuPzvm+Nj3DJZ4kghjlovTnnHoKSfRl4Pp8n3KJC7Op4Xm052cIpuqK6VdKU?=
 =?us-ascii?Q?kAcFAYmFcFPimDPxyBVzgM32oezOM6bsNuIBWNhLrstfoOzUlSbker3/rnME?=
 =?us-ascii?Q?GUYRedvu7tC6MXZTFWDCkU/bBxLAXCIlbZNsjJHC9SNm+d5V+Tgjmqwl44oP?=
 =?us-ascii?Q?Oi7u5bV3GTqDQIDmP4Gwuq6tUpqaPuWXwk3hMbq0+LiZbzYM7Vl832fiAlGt?=
 =?us-ascii?Q?0XYBrEwmrzWrRgzRvVxNjF50UoxhYij7E/NdmJl7eTXeJimkBSHfSwoeMKSq?=
 =?us-ascii?Q?x7LFCzZgjEdtLCuF+dt+yVVrVL+fMnZWYT4H/YJb3gUrshOECZWZTZMCztiK?=
 =?us-ascii?Q?dc72KYlDOmnaFJ9IctUnJu5dsr5KN15lKM+5OxAnenictgNA/aiW6Pw+wyIv?=
 =?us-ascii?Q?Pk6UAUc1gZDlQM3Ki9F0SFImqOynWXPI+iBobx78m1VXKTyISgwkOtJMDode?=
 =?us-ascii?Q?7J/+DDDNG8RcR9+ymOstOXeGfEWF3GkvAmmy4mvDdHFjlo/nVcNHKiTHEa6v?=
 =?us-ascii?Q?V/fWmNH0WbP1N1J6XXnfcU/bPdqoMuHIYQK6VSykgmoWxtEmntMol7hz1jgw?=
 =?us-ascii?Q?LiKoXxu29dyCqeHldi4SwYRrUUKZlm1SwKwDM4urM/QmalbIRUHk46HPVqwA?=
 =?us-ascii?Q?NlTtUk1lPPEsM3dbvFeTAznDDeAiIlMa4txVCsDdB0iryijbT1RsXsq10UNn?=
 =?us-ascii?Q?a4MbQFVBw7OA9YOvZ3H3rLTQPvdOt6AoTUhBs/G0mWNzgJghHfMyK7HfrU4Z?=
 =?us-ascii?Q?whrn6hHRJzgft96fBB920HfGIqPgrb5QE3kbA0HWUm/x4EViDK6/O4pzBYpa?=
 =?us-ascii?Q?VChRTzUKmas0eghVinL6nchT3E6aRZP6zq+5xjkGVe7TNe51leKX9w9sMTL+?=
 =?us-ascii?Q?ooI+J9UUfrvaCRBJZIFgMV+P0o5pYHkZyOy/z0ZnBXN10rSp5Ng2du0yjaIL?=
 =?us-ascii?Q?bN+EJv8UxsWjR/eG2pYVbfMt62gQXXw503vPihsYcBIlJ4zEaDejRSgLGzOt?=
 =?us-ascii?Q?e3VJS9XiQqffFGME3pubAGYCHtWHQz2hVN/BVF2o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5153.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9e348a-c4ef-48d1-09ad-08db039368cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 13:59:45.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02ikxYCkZvQiZkSeYo16jvxjKCqqFY/aAxVGeyo2UiZ1mzlbxMYlIlzcbWFI/eX6H+7g7nuJBYp/9CvrnidTww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5238
X-Proofpoint-ORIG-GUID: d4jPkaIWvPgmEvGIicp6xTJRzUiPx3Cz
X-Proofpoint-GUID: d4jPkaIWvPgmEvGIicp6xTJRzUiPx3Cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310125
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2022 4:30 PM
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

>On Tue, Jan 31, 2023 at 01:23:33PM +0000, Sahin, Okan wrote:
>> On Tue, 31 Jan 2022 3:27 PM
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >On Tue, Jan 31, 2023 at 09:27:48AM +0000, Sahin, Okan wrote:
>
>...
>
>> >> Sorry for second question. I do not want to bother you, but I
>> >> realized that I need to be sure about driver_data before sending
>> >> new patch. You said that you need to use pointers directly for
>> >> driver_data then I fixed that part in mfd, but I do not need or
>> >> use driver_data in regulator since chip_id comes from mfd device so
>> >> I think using like below should be enough for my implementation.
>> >>
>> >> static const struct platform_device_id max77541_regulator_platform_id=
[] =3D
>{
>> >> 	{ "max77540-regulator", },
>> >> 	{ "max77541-regulator", },
>> >> 	{  /* sentinel */  }
>> >> };
>> >> MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);
>> >>
>> >> static const struct of_device_id max77541_regulator_of_id[] =3D {
>> >> 	{ .compatible =3D "adi,max77540-regulator", },
>> >> 	{ .compatible =3D "adi,max77541-regulator", },
>> >> 	{ /* sentinel */  }
>> >> };
>> >> MODULE_DEVICE_TABLE(of, max77541_regulator_of_id);
>> >>
>> >> What do you think?
>> >
>> >If you have got all necessary data from the upper layer, why do you
>> >need to have an ID table here? I'm not sure I understand how this OF
>> >ID table works in this case.
>
>> I added it since there is regulator node in device tree. With the help
>> of devm_regulator_register(..), driver takes parameters of regulator
>> node. I also used id to select and to initialize regulator descriptors
>> which are chip specific. So far there is no comment about OF ID table
>> so I kept it. I thought I need to add both of id table and platform id
>> table as name matching is required to initialize platform device from mf=
d.
>
>For platform device is one mechanism how to enumerate device, and bind it =
to
>the driver. The OF ID table needs to be present in case you are using it f=
or direct
>DT enumeration (there is also something related to MFD child nodes, but yo=
u
>need to check and explain how your device is enumerated by this driver).
>
>I.o.w. please clarify how the OF ID table is being used.
>
>--
>With Best Regards,
>Andy Shevchenko
>

Hi Andy,

I do not use "of id table" directly in max77541-regulator.c so do I need to=
 exclude it?
However, devm_regulator_register(..) method initialize each regulator with =
the nodes under "regulators node". If of_match in desc and name of node mat=
ches, then regulator will be initialized with parameters in the node under =
the regulators node in the device tree. Since I am using device tree to ini=
tialize regulators, I added of id table. I hope I explained the situation c=
learly.=20

Regards,
Okan Sahin

