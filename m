Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73D5FE555
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJMWes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJMWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:34:44 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D1660E6;
        Thu, 13 Oct 2022 15:34:40 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DKbNN7025411;
        Thu, 13 Oct 2022 22:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=gpDka5aq0uNZY5kBQF7VSc85+uFfPA11XCV40cZWPww=;
 b=nvThzCilyS8gay+Li9b+UxurzfFDsv1EpqL9OD40//BjN++FlScWJzkbKV0n++SJWTXN
 4lW3J7SB9jk3O8DRzakPEE/DMsZ0NJrAgdq+4efviaEUlcoM1GnHj09b61nnbvgz/cu2
 MT8WWQFt1YkY4cp1zi8v/9Ukdr1Cb7IMwTDlceCnVTZfOcRVEiFPIWnLH+e+Z/htIwey
 PmopvjKZyop9SKn0d0VLrq/lz3ma3rOqSGpZ70wXrJXircRf9Om2WPihYBXZdD4zfWaQ
 DuhxYw6/HeRU+9c4D4Bq9LGCPdETC1mxgiJ7m4JETmO1p6WSTfwjk7Vm+wBk/GVGaf5d ow== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3k6skugy5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 22:34:28 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D37E8295AD;
        Thu, 13 Oct 2022 22:34:27 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:34:09 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 13 Oct 2022 10:34:09 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:34:09 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyeMi8MeNE52Bt/ms9QW8vMo3C1J73APjG6/aAFUz0ytMJlAzyBR2lMThYl8SrlCOpdgFEQBSFV9tzO2TSFjQCx5i/IYnX7V0q2EGnJeIqYY3AYBdaLsPfbegHaltQScnK3JBu7HpbXUi7Q043pTOFmAUb49+wg9UUjnOdLfFUlNl1vWMrnk3OfbGrkPLawAXV2IDixCKkW6K5lLQvnfkyjSGjNR6q7sVfTYvTUoVJRxAUcIEIJ+pJxdT9W1LiG7Qw3OM7e5v64KL61qAsVKdzXsQyUuhOyL92LDny3N8NXIXHJwv3QFRrERrpTcEOFo67LrwkpyHss2gzZVnZPang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpDka5aq0uNZY5kBQF7VSc85+uFfPA11XCV40cZWPww=;
 b=oJY2ds9LzrK7wVKXDeTyTRUsSraSscSnUdxruyUNEdb624eMjVABjXFFVeHNuUmGPZ4Vtulbe77pEFaApKYmJ5uWlvzNiOl4hm8ISh5Q43F9U9U/UQeesITCE6MzDeNslaNjZzwF4tsIxkwfFIhzBp9keVRJyJc8onfrQqwd0k7TPxx1h10YA8aBAN0qHf7A/1MMEkZ1Ow4LFSQP7Pz3MqA8etfK0pQc06XYuvubUgyKhqJuHu+dfMcJEUQUHzm0Fkhr1hkmRJ4rxjDRVKIp2UemZuKHAYhT2cNad/nrWp0pRfsHlnJTjvlPBUXwFF2B6TP7unUtg3xSMYg6lc4KHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1422.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Thu, 13 Oct
 2022 22:34:01 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 22:34:02 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 05/19] crypto: x86/crc - limit FPU preemption
Thread-Topic: [PATCH v2 05/19] crypto: x86/crc - limit FPU preemption
Thread-Index: AQHY3oYIGawv1P27002drIVzPEZ09a4LkfsAgAFVjQA=
Date:   Thu, 13 Oct 2022 22:34:02 +0000
Message-ID: <MW5PR84MB1842FCF31D9CE954873250BCAB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-6-elliott@hpe.com>
 <Y0dxJrRx/Neo4r1Z@gondor.apana.org.au>
In-Reply-To: <Y0dxJrRx/Neo4r1Z@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1422:EE_
x-ms-office365-filtering-correlation-id: 1acd0ecf-0bd6-4b79-40a6-08daad6b078d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uML4Fb3ckqkQLaCiZAW89MRkRaz7odAwuXrBCEAdFIEi8Ofuy7HwKfIsyJ5Lbd947CQ99qdNVsXWpwRKaqpN2/kEEZY6S4mffMrT68AY5UCKyFMi3+7I9Tpvb2DCOP0fHiAO6jq+6R2dOfwvu0otw2phiNYyVwXBlqe9yhDDCY7QLQCyT+9psUWGIlOmoFlUtz6hleEp9ltrYS+vUMqsXNykM+gdf3wYW04doVHByBkWomMYuENqYqqxY0s76MAEiJhM2WkRDio5qQj0FPmSHrGnRfKsSnP1cjc1xcW969jy+gguYFMQ+EnffxLpL65clywaw9O80RxSLZmp6g+Dp1xy+IbN+//qBEPwb9guP4S+wwjjG9TQba0jVSwmYYsbCX7Ibqabc36ehI9Ic0OInr46QOIIboEnGmtRE+S/+PDfjEHHuoHU6Pw60lhIHkjbyxZK4MZQc+wEhcdo3dPc/fyWOtu2Yv+/apbOHBgZtJL1HVFgjRFDrdVfOjci+RSHuhBAj8BNVVOAEAgA/Bv1XWdKi+i9ZIRBH5acE67FYP0pzE2WuutRwdbHQFoD5X9jnCaJEw6lWqRp/T1cotEitO1zgTTv/N1uwFd3pjt3jInprJttchDrSiR24CaQEkbP5rFyBVzRDFENJAur45bCJgTVJBfr5w/95edqOQyqbrctAiuaFrDaRQNHMYBLiNVV1XAWV3P3oLLj3HQhQGqtPjT66xE0DpL/YcVAchfLda+N2L9EgeCmlMQ+Cj9t7C3JMxDUmTcq186deUF3wS2nFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(5660300002)(53546011)(41300700001)(38100700002)(33656002)(316002)(86362001)(54906003)(66556008)(71200400001)(8936002)(6916009)(38070700005)(66446008)(83380400001)(82960400001)(66476007)(2906002)(186003)(7696005)(6506007)(4326008)(64756008)(76116006)(66946007)(122000001)(55016003)(8676002)(478600001)(52536014)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SYnPMpT3tqtbqvhHKki55RbxtkzvJLVlGCh/lrx64J3H7HxPRSAqW39VOYVE?=
 =?us-ascii?Q?D9NynV6psrfa15SrGyw1oHRL5sUrMSOmxPVud8NIqVaf6YVJ9OP9ciLSVa+i?=
 =?us-ascii?Q?i9fxMgWeLJcvE/te9/6Dp35XkJPMJ+lzOGKg5bH5qHN/FuK7eLgcJhhZNZNF?=
 =?us-ascii?Q?gW/rdKg8ty2q8C8+da4R+BN6luVct9pm/lptYAYEHKZrKoyIxBavRUVC3OUO?=
 =?us-ascii?Q?nQvvMJGaMaXJPuikP6KLXr3udYcKjgz0Lq9SQ7nE+sXQ2DNMMRa4GDpDlXSh?=
 =?us-ascii?Q?BNhvqkAtQo+pr6td2HY7J21Y4ZEhsHOVd/ewiD9k8Ijt+pHXKuYtBJJ62K/t?=
 =?us-ascii?Q?03YICj0gTHjI5eUDMG32IAm/AGGudvo9wlcVFO4CK1O82/Xt9Cfjhg5LIQYA?=
 =?us-ascii?Q?a0JXXGQBWDZh9c6x6lHsxNYKVqO9RbzwJolPvkCbbjwLfvNJ1Wo88tgEvRys?=
 =?us-ascii?Q?vVRh+/4Uhl0hHrheEKoUYdHrdTS6IUI5KZRS7OmvN2YsU0Z/6wdIFW4+ZWho?=
 =?us-ascii?Q?4GTA/caqNIIjqN1d32sYCbjJKadSeFPYL98iDTcQTp41FRaLvFPcOahsPg1H?=
 =?us-ascii?Q?epM91XXjZEGSaCwwwJqiH1Y5Ks9R4Zt8azzpZYgHCDedZDLIBz5JRjfbaLk3?=
 =?us-ascii?Q?5nONRh+4Bj5dNkBMk1yM6nYR3Ym+BdIIVXVimk+OziM1qHsSb3Di4YBV9KKr?=
 =?us-ascii?Q?lHPieWxbV6T+WSkEBPKo8mTDr+DI7b5FuCsNIg8xtVM+ojc2W9pTUd6Qbq9s?=
 =?us-ascii?Q?NpQ8ux7QUHqPdtufVU4/0z9MAFAwz56iVsxXMNhRdzGHQchEi1BrZb+Cc6FD?=
 =?us-ascii?Q?+DYNZRgE0YfYeueHbsWclxxvvTTazcx+IPVM8TLsJ16djab+JG7Qbe4rDzsB?=
 =?us-ascii?Q?DYsfq0Fkr5AQIRyFZ4cbA6rwKWW/S5pY8v+0XjlXhJwLV7ZZEy/z/l7n0HIH?=
 =?us-ascii?Q?sF8zf6o53MeDzxjgz5/4L8dZC/NKDtEjHRt+1jYcMFb6fOUKLZ3dkUUliag0?=
 =?us-ascii?Q?lviACvmro/6hEmfu8eHDzEVp4fAUDT3cJ+kzFw32s5zC+hQIJnKJs0wuboBt?=
 =?us-ascii?Q?0N74h+v0R2WOy3Ie4Ks7cueIJD4Ih/c98xHYryUJApq5FdB1/QOhH/i8jfMP?=
 =?us-ascii?Q?ChAqDvR1mM+Qcbxok/BKzczgc9qSDg03BbxIk9SQSj2uwIGR7RvMnV48CYPJ?=
 =?us-ascii?Q?1ay4C4eMxQRsNAiepLq+ihT+j1YxXf9hXN82QYeDb0FiEUoD5VNWcb9H785d?=
 =?us-ascii?Q?0fZIxkboraoQd+UBOVqWWyxMFZnf8POym+XxyWstaWglpI0v4KMJcmwevyG5?=
 =?us-ascii?Q?3k7z71k/Iss3Zqxa8nNbzo5nxtYbm7IrE8yeyLi0/V/uAxp2l1ch3hUCP/up?=
 =?us-ascii?Q?tF4ygN9M3Y0iVWQjWtzskAEfyUM8ETtGHDGuRcEIQewoomO5hx5e1kFZRcK8?=
 =?us-ascii?Q?Vghu/rfLGT6qu2/EL4XshbfaM0PXOLbgTanR5V+sPqmXEVDviUFni/LegY82?=
 =?us-ascii?Q?zLIW7ObsSGOQzRiKqPfHPfXFEn/G6N4lJQuryzsawiyqWERNRzmv0fH6Vjkf?=
 =?us-ascii?Q?rFBNciz9qIDrwGst2FY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acd0ecf-0bd6-4b79-40a6-08daad6b078d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 22:34:02.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpKVHCTS+RNtLWM7FVVDtGe5XNfxin2FvU8CMTDgMiAyzBFsGuyEvqoe2S+3iM/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1422
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Wy9YLNyCqFeNKU1TZiR2nNe7j_oRVPDc
X-Proofpoint-GUID: Wy9YLNyCqFeNKU1TZiR2nNe7j_oRVPDc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=869
 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130125
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Wednesday, October 12, 2022 9:00 PM
> To: Elliott, Robert (Servers) <elliott@hpe.com>
> Cc: davem@davemloft.net; tim.c.chen@linux.intel.com; ap420073@gmail.com;
> ardb@kernel.org; linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.o=
rg
> Subject: Re: [PATCH v2 05/19] crypto: x86/crc - limit FPU preemption
>=20
> On Wed, Oct 12, 2022 at 04:59:17PM -0500, Robert Elliott wrote:
> >
> > @@ -170,9 +179,17 @@ static int __crc32c_pcl_intel_finup(u32 *crcp, con=
st u8
> *data, unsigned int len,
> >  				u8 *out)
> >  {
> >  	if (len >=3D CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
> > -		kernel_fpu_begin();
> > -		*(__le32 *)out =3D ~cpu_to_le32(crc_pcl(data, len, *crcp));
> > -		kernel_fpu_end();
> > +		do {
> > +			unsigned int chunk =3D min(len, FPU_BYTES);
> > +
> > +			kernel_fpu_begin();
> > +			*crcp =3D crc_pcl(data, chunk, *crcp);
>=20
> How about storing the intermediate result in a local variable
> instead of overwriting *crcp?
>=20
> Thanks,

The _update function does so, and it's not marked const here,
so seemed prudent to keep up to date.

Do the callers understand it's no longer valid after finup, or
is there any case they might treat finup like an update and try
again?

