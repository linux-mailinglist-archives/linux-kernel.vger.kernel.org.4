Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BF5FF04B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJNO1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJNO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:27:01 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F9155DA1;
        Fri, 14 Oct 2022 07:27:00 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EELx1Y019863;
        Fri, 14 Oct 2022 14:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=w5o9hMl5oLLgkAUW/Fyw+w/IsCfUQ1PHytwOjfrOf+o=;
 b=PDSUzNdP6WCV9a+wOF2NzCgxQj4UM/WusuW4kNL05V1Rr1YZD15Yi8NdZ03TvJez87Y4
 uWnyJFbnYem/NCSVZtXyg3aoCtgd0sxV0StRrjhgFmgzAA7gv2qewANndl5+/fvf0Yyd
 6uJSHR7tn4ShLfAMqVl6UrvxVMjOt46rk6HXq39JA4Ptha8PHFWhBhWCCneXiQXc7Ze3
 VCCtebS5loiE9he9BuDaf0l52K0JdWd8ukupQhtdV5txPDo+NILgenzrat5G4cQyWXf7
 0Q8kavtgAaGRqaqwTFG8XN44EsdTGEF5TltYv4OUMIed1hTAAegV4JjAAISYjX2Nrf3k zg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k78620sem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 14:26:48 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 42D308040CB;
        Fri, 14 Oct 2022 14:26:47 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 14 Oct 2022 02:26:32 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 14 Oct 2022 02:26:32 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 14 Oct 2022 14:26:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvoAk9wcqiIew0o9uzNKBjNUh+qb5cWZo882w1joaa+R/8KoxtUY4nzwfT4DjLIhUySGD+FNnj7shEdJlsZznwqqUAfKEaX2DFvHt1UaxZxR2EL2TBNyl/dWPUfF0o+BwzIAPT5ff2nlGPDUpEyoVqDrhIAtoL2qhjKp5zAa3azGcxhERvbdnNgxL7/MemylXTbCPJHxB/sKKY1rSku5S5jhZESGkCW98gxY6b51JuOl7RedEhmEmjMX+9vEwSQgRrBuSAQoPoY7crxPKyrmPfU/KdAVjLYE2WbjiQi1/v19dSxM+ZigGFBvA2VDr7jU+CWLRFrQbu38/e2A/rFeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5o9hMl5oLLgkAUW/Fyw+w/IsCfUQ1PHytwOjfrOf+o=;
 b=fqOPIg2MY7QEbUXbB65LacqbwjJ63sMbKrtlWuGsMxC3muzTls7xMyO+5eN6z2r94sTbk/PHk+0GN6IYJyQipCXckP02gvP8zfRAB5G4YEWhGBEV05kugw7ZB+ChLtBFrf4vcXYfVAxpDs8MViJPxZxbf4UxugdP/tXtrtvAFSE3oumRGoiqO9d26YQS8UH2b2LLd498dstckRdXW/TjXlu9iaw1vklVVnRQix4AmPM6ZjNcQfjjc5Q2vQqDsF0s1dY8PCxPBgL5kK9g/nH4ryA9JSFiXOnM8Fq9kYmz+M1/S5yB+E06Algjo0qHQMtzJ0/nFpvHxQxeNcmTbyYkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW4PR84MB1540.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 14:26:30 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 14:26:30 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 14/19] crypto: x86 - load based on CPU features
Thread-Topic: [PATCH v2 14/19] crypto: x86 - load based on CPU features
Thread-Index: AQHY3oYSLJyjU4itAEesP4iDFGvtMK4N8noQ
Date:   Fri, 14 Oct 2022 14:26:30 +0000
Message-ID: <MW5PR84MB184243ED714033741CA54B3BAB249@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-15-elliott@hpe.com>
In-Reply-To: <20221012215931.3896-15-elliott@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW4PR84MB1540:EE_
x-ms-office365-filtering-correlation-id: 83c4d7dd-b2e7-43c0-4fd4-08daadf0168b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: joTi3eFhShsDiMgg+9GPAIVRY/ETAdGcIoKhUUIkd+HepwZckZzlFotLW2SUjzRaTCPlnfC5Mhb6TT+CJmiuWvoHjswccDiBs3Khd0KXiRFrsJx5bfAlDUl1Ak0H0gHilofm2tAlrDw0gZAawNxN9ymuJuMKvSzZzyNWUvlm9zBcR5tL0KqF0J61eNF70HahS1enDCIkdi069p6w6tkNydoqS/MOcJX0npOOgEGCRD+RsyGCIlj7h6hdjRlKFXuhhnafRPy2FDNTigVcFsa1rzB5/juOiwiDwvE5SgNUp3EbzM9jRYuNeZbRm+mSNUG2f7pNA8f1Dpg0Vpzv5nGWZDybMlNvyudjJGqHsPm//S+IN6O1US3ziP07O1nNUiACm2MSSHF2HSJK4WFmqn6Oh77+b6Hktn5YtXEN6HuruU5pRW4GRiJw7mRmLVtR1iaRh7lNNB8KGV9qhcWPcDYihwsBIv7AA5sZ+GWU7OAJX2JGUSwhx8K3aWTBUZi1sQYTEqfhGJmy9LxTxKOP+Q6iF1vxfhsbGu7jI59aJMkLyUUkPrZ6fkbd9TiLJ8yCMYg34nR0lJIkrEHNfSpOghExYisjWWuZsvIhKFcklEOVmAtsOcsvWAXKwaXI7lHyS+DfUq8NXJZFDCKi8wcge/3qj/e965/5KqF//lWVC8k6fRKMKd2HaQhUtmUSH9i47AvBQnTczw52mvk0KbR4uCLV0kkjeG/wsqnhMfH7HbI3932RDCqdtruUCPaKVpKLK7HLECnw39XjCwaIK5SiBE9gBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(33656002)(41300700001)(83380400001)(8936002)(52536014)(316002)(66476007)(66446008)(66946007)(76116006)(8676002)(66556008)(86362001)(186003)(110136005)(64756008)(9686003)(55016003)(26005)(122000001)(2906002)(4744005)(38070700005)(6506007)(82960400001)(71200400001)(5660300002)(38100700002)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aq6jU1paSC8ZtNG3DoI85jytaR1b3lk3Pm5EXeOKXgTTNDD/2elByJHP3yNB?=
 =?us-ascii?Q?uOYnkxsZaDJwoQl0jUJLLjWziTSK+fpoqbLt/5xgLyx8rkJanEvUHUfwqUtp?=
 =?us-ascii?Q?3upweDR5TmSYzXgxKR7iSiAgutBM2vM9cAH4LZrNDzvuA8/aNZK4D4Cj20oL?=
 =?us-ascii?Q?1AbYNOYPN67UVpTOGvBuLcJ3GfTwHFnP2OO0WaI7DSAVQF4bPDHZJtHNmygP?=
 =?us-ascii?Q?GGk+6X0XyXmFpCIApPdPtcj+xS3Yae6Kgb5KQL7YK3Ez6IaJ3bH9GWBzl4cP?=
 =?us-ascii?Q?pLun6asnvcZY/Ar15FWgf3iGLxdAffI6mDFvzKhwccKNQQBqcwb8lpUUg5kI?=
 =?us-ascii?Q?Fy/1N1L1CZDESYsCjaMouR5r82XKPOT7KWsESkccH4svGyf7RS7BXfTr+1iP?=
 =?us-ascii?Q?AaIVN7WeLiaxZ5lijCZqhLv9jDP+vdW/XFD1ISJq2bnqx0gAf6cg9uAmk8Dd?=
 =?us-ascii?Q?ru0yJkOmcebkEeVcG2PWqlQ/E2TYw32+1elCwXPIgxJwOKqXlW32T37ZsVU3?=
 =?us-ascii?Q?N+RKerTR6TQAR33DCyW1xQrZop7FK61L2fSxM2pqck6M3b4FgeduP4cg0iDS?=
 =?us-ascii?Q?uBGgdAJ6fUuas9Zp1G3Q34g3fv0jne9QWPNYyUfKqhyfu8Jkuiee3gIb/7sV?=
 =?us-ascii?Q?SljQ/ipJr8XdxLarZxHx3nhcZXZkT1Q3vfdPShfPeUDNeq8ttm2KSBSxZLEI?=
 =?us-ascii?Q?/2KxrOZZnglOCJ1A4w411Po3BJqd76W5riXIOIPhBEYwNkDfzYVC94rwJ72V?=
 =?us-ascii?Q?DuaSsWv8UaSsNp8zmHidG1WTNSSYnYDQpNDzD6HvhVQ9xS11GrzElYGvqX8z?=
 =?us-ascii?Q?/B8vVPboZoXfKaWkhWNGlETfb8JZmAXPee1pnPBgYiGVPibjVJnc3uLvDGbJ?=
 =?us-ascii?Q?YTA+XgoTvFiJ4fqpHH0JuyXdV2Bm3SJykw2d1N3Dj01JGgdpnUaGfXlSwp/G?=
 =?us-ascii?Q?BoLq2TQzj0iyj5HmFXGl8bNJBtE9BIfJPGW3UUW1XL5ATfJ5McSVQWRbQWyf?=
 =?us-ascii?Q?8Y1+2ZtHs55qnXEYfPdnNUH0YGY18Oob9K1v6qWJWiJi4tjig2gnhqMN3glv?=
 =?us-ascii?Q?tx2t1SbURt/6x9mFES8VxuAFd1FO7R3eUX7CAVX3RR1YJrntdh/OHYdyOYbh?=
 =?us-ascii?Q?QdPAyKC/Il8BnubRnvwiSCeU1kzoGfbZoEvfy/U7yXALawf9gewwqfC6oM6i?=
 =?us-ascii?Q?fBFubcsfrEJ+JCYELTR3AyWGgeshpmyIBZdpMbsEwTAqZTEoUzbqd2tGtcPi?=
 =?us-ascii?Q?idHU8xZmMyQIgfdaqbXbaZKWoskq+59xc+8Bsfg7kBdchqhETPT0yRfF8Isz?=
 =?us-ascii?Q?RuFo47iqqENVa63oh9gKlsubE0Q2n806T3iW2r6+iDe65v//XiPiDO8CbOzA?=
 =?us-ascii?Q?yIMCGGi8lC7x48zJ9uSEBPCU3vFIeLB9OzCKBnWDGxW/k41YzveYlgE6jxC6?=
 =?us-ascii?Q?Y6D8o14gYcAMfBv10oRCUiQ/NniRWsS0mGah0oxt+qdWGrkNdaM0bO3bzCqp?=
 =?us-ascii?Q?sv69/pgeiAVIYICZ61kZb60u9avqH5U5Wc32qtqFaI9gf0L3R7u0U2fPL31K?=
 =?us-ascii?Q?aM59QeJIdvb18Svsjuc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c4d7dd-b2e7-43c0-4fd4-08daadf0168b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 14:26:30.8019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoIIqzzp+4CE709gA3b++iKn1n4ITbFkyzzb91MlAZamu/INvHZWM1RDPHdyN0r2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1540
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 9gWgO1AYuBOQVMds1aK0YHnp6gGaJ6El
X-Proofpoint-GUID: 9gWgO1AYuBOQVMds1aK0YHnp6gGaJ6El
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_08,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=807 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210140080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH v2 14/19] crypto: x86 - load based on CPU features
>  23 files changed, 230 insertions(+), 8 deletions(-)

Here are some things I've noticed on this patch that will be
addressed in v3.

-  Add aria device table (new algorithm added at end of 6.0)

- Change camellia_avx2 device table to not match on AVX (just AVX2
and AES-NI). There's a separate module for AVX.

- Remove ADX from the curve25519 device table. That is optional,
not mandatory.

- Remove AVX from the sm4-avx2 device table. There's a separate
module for AVX.

Here is a script to review the device table aliases:

modinfo /lib/modules/6.0.0+/kernel/arch/x86/crypto/* | grep -E "filename|al=
ias.*cpu" |
        sed 's/.013D./\tSHA-NI/' |     =20
        sed 's/.0133./\tADX/' |  =20
        sed 's/.0130./\t\tAVX512-F/' | =20
        sed 's/.0125./\t\tAVX2/' |     =20
        sed 's/.009C./\t\tAVX/' |      =20
        sed 's/.0099./\tAES-NI/' |     =20
        sed 's/.0094./\tXMM4.2/' |     =20
        sed 's/.0089./\t\tSSSE3/' |    =20
        sed 's/.0081./\tPCLMULQDQ/' |  =20
        sed 's/.001A./\tXMM2/' |        # aka sse2
        cat

