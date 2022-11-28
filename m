Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B063B1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiK1SuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiK1Stj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:49:39 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895121E2F;
        Mon, 28 Nov 2022 10:49:07 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASHHb4R028043;
        Mon, 28 Nov 2022 18:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=5T8G2Oa4+MbGVdBq/+qTbfsHUsc2skPJ3iIb5a6Nm1g=;
 b=fB8/J3NesjRpUOa9ovdvepvEFywXcTHwMqnmZMY3Zt0ZLQYmqht7Y9/ONHRewrDiNIFU
 gV8m2INPptj977j5QOjGe+Bs7/htNoKSh4OOnaGqtXJGH57taGmP8UwrmqErTs7ilaer
 hXpDlemChPUC0Bw1CnMB5gGWQcqHptmUj9ok79eau70oDZGVn+YtKPkxNmWCjv6W/Vqs
 LBIbxiJVy2l5FclxmLYVFfUFOUhZqt6PjVHIqWSqA1TTOpxpWfS2OyaF3+brZiXUzt5G
 1AZhi+d6J0gYIX3b6XpW3ABK3xK0DkNC2AcREAeluW7jaiHR6Z6l18NZw0otOAX2Uqle Yw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m518pgnnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 18:48:55 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id B631B2EEE6;
        Mon, 28 Nov 2022 18:48:52 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Nov 2022 06:48:52 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 28 Nov 2022 06:48:52 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Nov 2022 06:48:51 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEnyoKe+2MU/2M5CMEyImHT/YYnJvr3rboXR9JsNswiibdU3xWBI2Cu0X0vyLYLunWd18x5aIowJte7cBV5rOfo2rBs98QXj55y0TYWffYyYm3wU3FLQ/HAZNQlQVIeA8n7VvOynaO5JIFBP07I3X+yI3FMBXXXonbnMAANlZ5Q8f8EiYt1/rRqISf14PbakJZhepM7m2I1CP71fKK1SVv5vGMyR7YesA1eww1qwiNNUIYOmygeZC626RYwYKwIvskF3qA2HohlfBLjY6NZMlqrqpEM2lMQgwySlXG1dpRQfeit7rKUT+FywzsoBYJpmFhoac3rs9M75+HxsNkNSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T8G2Oa4+MbGVdBq/+qTbfsHUsc2skPJ3iIb5a6Nm1g=;
 b=JXR92JfuHjTg9YfTC7i1Ncm7QEQ7Jg5kDjb3F79GpQw8Y1XM2UGghJY5hux1L4c5rg7lIqjlUqqq1USNc1KGaSGLCgF4djmegwwuJGSVy0kB8KrCSOXAPYMsaPIzBSSS3uYLop14pduX3UqW9Z3xtFWTCNELSrpztiCYscUiAx91pwlKH/1NqPHv34I2pkdGBuuVPPibmD6hlridGMdOe7AurQGEvKiqMahi6Q7Vy2sPm84BtoUp1xEdtwdSM0BnEuD+CNGyVvbSFyJXrXx95+s6T+/F4xr4Qckou54+mjiTCZ7/DCb0MvO2x/3AYwQ9pyO7BnwDPIlj/oyLox6BUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1578.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 18:48:50 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 18:48:50 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Topic: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Index: AQHY+XHqfLLvXNGxcESumjNg7U4Mn65BZh+AgA36OwCAAAUngIAAAQwAgADfYdmABHgXgA==
Date:   Mon, 28 Nov 2022 18:48:50 +0000
Message-ID: <MW5PR84MB1842A5CB8CFECFC90FDA1B65AB139@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com>
 <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
 <CAMj1kXHHm+L=qE5opDXhjoWZt+1eKXFeGVS=OdvyF0VNFZivCA@mail.gmail.com>
 <Y4CExnFX46mk4/1+@gondor.apana.org.au>
 <MW5PR84MB1842E182C47F77FE8C8E755BAB139@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB1842E182C47F77FE8C8E755BAB139@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1578:EE_
x-ms-office365-filtering-correlation-id: 4f11b449-a4f0-4070-2249-08dad1713077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Bzgnlkvq3PU40ZPzc9GzFM9Rp36KCe4cEgPSNW0OZe/lWqFVNHMmJYw7yNIhExmmBygWf0j9aafAu/Rl1+T78EGSkJkgc6hBMweMPYs3kiW6ZoqIE8x3pA3kikjTYpMmKhZk0Gwf8DhyWsEL7WGL0WlwjCRtloJsDXAE//BaSEaVH4NIXpKGGyGogyhwFW3M/HrG7TnBQ623iEkkkWATd5VAbbtMYz8c0J6yUUElChImVUZFJpPNyntuMNU3QNiMm019Zbr5CJ+6RwczGIpU+sfFNqEFQl0AUlicZFDrpSYwpo4FuoBHtqA/vQW5O82+xCS7Ofx0YYl9+8sbRv1R3gAmuQnxj0/dFJQoPg16Cvrvwjbq1LG3MfM7CBCbJeV+cbT/dHr+55ftbCXIqZ5WwBK0FIwbqnlxDwl+FcIj/oY4rbhSjSRCimGshBqfLpCAtpw+MLl4yQZMGsfm3eT8P/2kMv6ITtWwXL+BbrwGvTDICPw0zLWw76YxQif5oxK27/SqBsGlp6aSGxId70OE9OEPzE4pCnQtQZ/OlUgAFuZzAcJCGMcnL3NSwMgj3GQ6Zqw0ADMebR5+lGn70qCPy+8pO8JdwMTrxNUvZUJ6SkEEDdx//vLfyZ+Ky5GtTArXGS8KwjkSD786FavKN2sTpG7PcBd9B+A/qHoW5Jbhg99JtgASbfjTHwu1idHVLORFa72D51HUaw3HQofVqZX9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(6506007)(7696005)(86362001)(2940100002)(38070700005)(478600001)(26005)(2906002)(9686003)(71200400001)(82960400001)(55016003)(186003)(122000001)(38100700002)(33656002)(8936002)(5660300002)(76116006)(52536014)(316002)(7416002)(66946007)(54906003)(110136005)(66446008)(4326008)(8676002)(64756008)(66476007)(66556008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MAw2lUsQ7DnPl+2rf9VFDtZivo0j3vC5ec6itKf53vpggAviYNdTkYm/WqTq?=
 =?us-ascii?Q?7Pn74LKVoRMMHj3QDQ7YXEy8khCmcWuVulnssWUHhNhsfC+0sufRFRgkd/cG?=
 =?us-ascii?Q?RLvug3/dCTJNKBlhbq/GbfauH45VqaVGgjP77CxrrbIcswFlE/Fa+jKJi0VL?=
 =?us-ascii?Q?bUgMpAM7bJiCr/QTx3QZj1nz1O8WvCkTBy7pS9uvtX5CpuvYY3YPO8HckzCJ?=
 =?us-ascii?Q?Imb+s9jAgIq376aDb+BAHyTJuq2VKFgHgR9hJ9n5iuXgJt1+r8SGE/8cv1y5?=
 =?us-ascii?Q?5/CHi4qlG066f/H98knEufpi6rvQNPDeBd3B+szG43gQzUOiMRhS4i6hf05t?=
 =?us-ascii?Q?6ur9f+5AUpdkPKRH14R4BURavBSoIa4IUPg7A1SDsZ1ZlOegSk+PJv/1ehI7?=
 =?us-ascii?Q?caJfUCuX7IxvUUSluLEs/03Q3P80jSntUigmy9ILZW2UkCdlfVDBuibUK46J?=
 =?us-ascii?Q?VnFzdPYI4sCbnGEMj2kKf7HeuBkLT09ieOQEJ+X+6sS1A7Odhqr33NxE6Key?=
 =?us-ascii?Q?coblhBfXevbltecqUk/57wsMlWHC2JCuPCU1KO/8cRkanx9vQEuUzer2kcfO?=
 =?us-ascii?Q?pTir4Xnv7UmAn64Vx4RdOXIeMs2VdWrQIm8ovLOLZjyjXyWGFDejXQr6iITT?=
 =?us-ascii?Q?zQduc+kiUfgUDsDIqMN/aYSvGsMbyuRlh9ZEsJSKso6uduAS68sxI8RHoaTY?=
 =?us-ascii?Q?FhCkD66odHC0GHMaKE7/4ByXcIA74SbKB7kBWHACEZKYpjKA5cVB7m9+vn30?=
 =?us-ascii?Q?jjQkG2opstpjAFtDvsadOFjUGysftl6eFFM98BQJJ8lVHwXHIoHOSoPuKXwe?=
 =?us-ascii?Q?bevIruel0t16zKyWmepR76vVYWj2QI7o02r1cngfiidAE0Hwa+AhNIiMQVfs?=
 =?us-ascii?Q?+11twl1mt5r0K8Fe5cwQWn7sGNgmb8zvy35IRy7Sue/qt5eNHU3vFBlP6KQ8?=
 =?us-ascii?Q?3TLI6LzMxMAOV7PcJy7BUXyrCbl5k5qa6GLSfCXD7bCPYMDoGU/bnRTY9ZZU?=
 =?us-ascii?Q?dNdTQ7z3JEdWpp0+gcbQs4QUdXiM9OhQPA8XV9WzZuOYC+XR3ICeKhafwIoN?=
 =?us-ascii?Q?uAeX3V+X8KL3IZweqLPBOz0NqeyoatX4YSmANPPXCH3twJ4XVM5iti8PjeMK?=
 =?us-ascii?Q?XTm7agaxoRyDNucWIOptuqAOjIl3GrS14fosfQAakohCpFRAmX9bcDAdnPSD?=
 =?us-ascii?Q?/1TnPvXmwxCIPhvFYY6kfmp8SOxceGxy6E1ttr3kEoZO/wyzerQBeWpfCbA1?=
 =?us-ascii?Q?dXQObbvrwG8wgMxbJOAAH2J5cBmVUCENdf4OpPwzjyLq8HtxMFk/O7k+33Ni?=
 =?us-ascii?Q?4CCha8SqXKNd5J/ibtbb1UhASO76PHhqbezxWWtbuJq9x5fjE9e6MuxZEX2N?=
 =?us-ascii?Q?vdyPvWACHLx88NgfrYw/z+5QWT9AcQ7YF0UOHfzRYEyrs7PxuIjjGPNruBDx?=
 =?us-ascii?Q?1f1275ntsD8Jdls08BVNU9hwkUXaKJ8wPjykpaQslP5GDs8j7AENrsjKIoI6?=
 =?us-ascii?Q?oTMhDf4zi4Mzyqw6OtZHiihrrEqKKF8ScoFufRuNIMwiZJcswhWJx1L8IcHS?=
 =?us-ascii?Q?xRVrgLxE2vd/HIDAvVI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f11b449-a4f0-4070-2249-08dad1713077
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 18:48:50.0501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7oWB20hEikuhPnce8hLANLmKz6efhOsBokqtvnpj7xcp7qm2hpveosKyLN2l51mN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1578
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Yqxb2IqZsYjv72NVa-EjXMaS0IFEBYcq
X-Proofpoint-GUID: Yqxb2IqZsYjv72NVa-EjXMaS0IFEBYcq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_16,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280137
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Fri, Nov 25, 2022 at 09:59:17AM +0100, Ard Biesheuvel wrote:
> > Note that it is only used in shash implementations, given that they
> > are the only ones that may receive unbounded inputs.
>=20
> Although typical usage probably doesn't stress this, the length of the
> additional associated data presented to aead implementations is
> unconstrained as well. At least in x86, they can end up processing
> multiple megabytes in one chunk like the hash functions (if the
> associated data is a big buffer described by a sg list created
> with sg_init_one()).
>=20

Reviewing the two arm64 aead drivers, aes-ce-ccm-glue.c solves that by
including this in the do/while loop in ccm_calculate_auth_mac():
                n =3D min_t(u32, n, SZ_4K); /* yield NEON at least every 4k=
 */

That was added by 36a916af641 ("crypto: arm64/aes-ccm - yield NEON
when processing auth-only data") in 2021, also relying on
41691c44606b ("crypto: arm64/aes-ccm - reduce NEON begin/end calls
for common case").

ghash-ce-glue.c seems to be missing that in its similar function named
gcm_calculate_auth_mac().

