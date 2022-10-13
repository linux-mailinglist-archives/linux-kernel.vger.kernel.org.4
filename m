Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093C75FE599
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJMWwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJMWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:52:22 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFFF3C152;
        Thu, 13 Oct 2022 15:52:20 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DMdS2p021069;
        Thu, 13 Oct 2022 22:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=5h5N7NC1lFM5s6F8z203/iF7cx5ODpMXXq1TYAg4Gg0=;
 b=Kdp/8nHxDcF1Qyc2y5HWY8IGH9FYK6gHauXN1FTmibG0Y442HjcvWx5nmGzq0yX93hP1
 pVvUQES7t9IvWPuPIF3p1BfL8k45NRLk6ocAUvFCxVC0Uh7A24wi/hN/WYab+R8eGm7M
 k3rbijzAPSpvqUNo6eEGeHo/dHrhA6lbnK2GDlq2KZDl+tqgUhtbYFsMsyeEMH9Z0RLr
 PzxSag2MEAvAQf5CtCc95jXVrL+hn23B9Re7JaArrRtn/SkpS9zCHESfaZwmfIKtyPVr
 QrFPYSofXn/vTFTCghvCljS/JibhV5pfb1wgwbaAe5ixPkClah0Zom3Cua5W4K5RqqAv rg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3k6sk3h3qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 22:52:12 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 5705280470F;
        Thu, 13 Oct 2022 22:52:11 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:52:11 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 13 Oct 2022 10:52:11 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:52:10 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/UNkGfQc6zh1sRo9JPo95UnL++psbUa17n1GNahesTGwCQhbq3LnHMngsBQAQVBQsAv3r2W9RjHKgq0UPh0zXGF6h4Z7WoIhgK2OhvhuxCKjD42ORWDh8Qm7kw5hOg8M8lA31Soo8/TqHwNj5WJ0NPxonpN/FTVxSLx1F/LOYtvagCI+X9m6MOJkaWAU5621Mj7K3S3ukNlqF+Bi8NchX4Ll3ESdz1wcBpvh6PxeKug3hoBbS5h+gZum7vZ88Gd1mraFJfuZyBtGyGPTkCaolKpHHO9KQxRjd8FcfwQNiK3lqCqTOPuZOUoAvdP4TKsB69EtIWFyZ1p3wSzuRFlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h5N7NC1lFM5s6F8z203/iF7cx5ODpMXXq1TYAg4Gg0=;
 b=NVMgTnK/wmlaFCefRkRv3Mw8O0QdH7/t5KjKK0zZ0woTT50yjkXmuCwaFExPJGojtcavp8riPGJoQRJMWOPV9ATZw431ls3i9EoNuWw2lvYdeve20Gq4HKXOyd5DpeRhKiIYnBzsf8TYUcaYMZqCCHnVKxInz2NUsHnMJhgcOIpuzwmzAc1+lbUMeDUPBiu4GBP9DR+1JJIZpl6c6mqJbMMH1oTxPbYuz+yxvXF3S0A8cmaVNFZQxOzkXuPV6anWaDzFuCly0PzSPBnlzULPVVWeQ3/MrC582AWMHC26j7zgYPzc2wcMpytjuhGSYnPJvtIgkIjDvv/q76aZHOHCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW4PR84MB1779.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 22:52:10 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 22:52:09 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 08/19] crypto: x86/ghash - limit FPU preemption
Thread-Topic: [PATCH v2 08/19] crypto: x86/ghash - limit FPU preemption
Thread-Index: AQHY3oYM3+AW/SnRa0SGahudUyKccq4L1eiAgAEXJ1A=
Date:   Thu, 13 Oct 2022 22:52:09 +0000
Message-ID: <MW5PR84MB1842F8D372B8EA06EC1349A9AB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-9-elliott@hpe.com> <Y0eqIQ9PC3Edd+D/@sol.localdomain>
In-Reply-To: <Y0eqIQ9PC3Edd+D/@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW4PR84MB1779:EE_
x-ms-office365-filtering-correlation-id: f7c4e57f-03d6-4daf-0fdd-08daad6d8fa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4D3lq8QD5JOwcKdf767kkWq+umesCiRJO5Z5C8v5FPhMCm5nIJVtVj+9oPs7Q0ATh1fdvcV+ovk4qP5FkKhXtZirYdBEeqtQyLb2fge9YrwwD//K+2GPw9/aSvVsGStpF1kGBaORI2hTGyam14XSa3Lkn6XgWoqRdjb1GKBE/0oYWRZ5BHtaSfBpbp1A1XNQtgUhbe+KbzISnHOaBP1+gkP8nsLFcXMT3aJc6wszTyr/YN/n02At7BVwKU1mB8+vJal4+g2Jj3KBxga/TuYWx2tvUZArzl4frPfHiTrx+fN++ijc8uohewYqnRmvXR0m3sLOp/TL67Vp4v1ni5PeRPk0Mw+Cma5Bo++IKJG8F3W2FDyn7SP/FzajGq6DCKQx+OMqdm5pFshWiJ6AXpd4c2QfmljB5xQD/kIxAw/tfpykDEbnYYmupPpBFA8xwVRtbmFZeNi0iE1eDorrx1OFThcaSTgy+u7y9RFMCe8XiQriyXT55xtavrHE2vjYCC7G4H981ZihOkhCVCNMRfjo7ucmbCUIcd4vtbdPSYQjXqNCJU0zQ60DqSyDeJi7JQYdhKSApvXx/nhY6uOJ/hE1a7wR5PSogLR9Br/UEIdkyEJUq7bZhbVNFs0FchGfgVYWsCACMSuO8rHl91PzjvaRVu0ZhKn1o0D4NyV6u9eg0pjaGJNQFOH383QBfm0DkB9rWkTeN4oAKHiUAz2aKy/tDx3qb0NBOlKEy/eHPDJUZmb8rrpD/kZ3rYTBNe68Kndbg7yWcXM1F2eKKGmZoAMpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(33656002)(86362001)(4744005)(2906002)(38100700002)(5660300002)(122000001)(82960400001)(186003)(83380400001)(38070700005)(7696005)(6506007)(26005)(9686003)(478600001)(6916009)(54906003)(66446008)(66556008)(76116006)(66946007)(316002)(71200400001)(66476007)(52536014)(4326008)(41300700001)(8936002)(8676002)(64756008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r8TCRb95FWbr0fCZSFH4sL6CMZbjvAUFktbOZyA8PnUso+gUMqrEuA2+WIL7?=
 =?us-ascii?Q?wW5rM3j9O0egOrXCkUakFDV1yYgJAIl5xbN64BZwCSRdtpR8FqJUu+RcLj4G?=
 =?us-ascii?Q?/n/bgKybyPhNoTTM0RsOGQqAfwC9/qmJAEbhO7+UEwqw4j7v9w1AMCQiIUUK?=
 =?us-ascii?Q?DEo3ljmRDa14WE1ZyPDFb3xN4KzOe0xuu8OZUCsLWk07Do28ctx1EvaZkn9m?=
 =?us-ascii?Q?yaV/wKlqSDX6wG4X1mNst38UEnZql3G2veOUJu7M7XPZ0ol4JUJK+4fGT4qw?=
 =?us-ascii?Q?oRX0fG9HJabrXjQB5+9R2cViDklJWs4oj8Zjq+0qGo1XXQFNJ5vqO42ZtF6d?=
 =?us-ascii?Q?BDfkePQ0qUlzz9hfqs4otbIbVgV4Q11vQ/xzg0JrsduWO+IG8sQGPHDUYajg?=
 =?us-ascii?Q?JoW8T4AIf8kGpB/PQwZA8ZF64i1e8R0IMoFsPiojQKhhdQLyfCelM0bzYcy5?=
 =?us-ascii?Q?b3dzWZPOwqY3wp5XD7P+e7O3Ukjw08PaJjQS/mpuYsnogA5t96Rj+bbS2kNX?=
 =?us-ascii?Q?c7EsGdBX9YFHZsSW2osqJ9pKwounCOcpLt6DrETD+4Mhvkv3x1OYWIEFjtOd?=
 =?us-ascii?Q?nBA7d/JRbcDAj+kE4dcvr956qtpdzbduDND7SOW31AjP+gvsco8GaVe79UwV?=
 =?us-ascii?Q?Sor/VymuYvcFqgvabF/K41P/f+WqaKwuGdPC2Ad24xa6jGh0lqLarmz2NIc/?=
 =?us-ascii?Q?toucTjD7Jd10vcMsyHbPorYIZUbd/5CYQpc71tJHty+HaMByL7I/tD5YEJAn?=
 =?us-ascii?Q?kPvzc7I1F7pxn9UrAa4u+HzW9IWQzAXiv3xlLw9BzD2St0GNR1OXN9bx9gat?=
 =?us-ascii?Q?OG4ldwzqYIxZHQSVNQcYD93LcsV4JSagzlCc43Bn8u6DswRjTnToxJRqGg5u?=
 =?us-ascii?Q?qBUFc6kBHBZR4kwD0ZXdjCU5egZGqcbhR8yo8i0QX5RAdZ14Q8wVv9g4f9Pr?=
 =?us-ascii?Q?0YqihQfJ9jhuOGCiRoOI3F0tHoPlSxPHJQepHTjXKgDvFuxvvsltLuq+/SYu?=
 =?us-ascii?Q?i91KJUhGr45xmchIhzbVOGjbSncw5bFUWZePNabklu6uhuvPhVhHDsjnAScg?=
 =?us-ascii?Q?Db37k3cEvJxqbO2pTcD+Bc0jVmpErKGLt7OThE9k4ksqKZWEK7VaYeexfaFn?=
 =?us-ascii?Q?6KQxFXYliISIIhwJeI4eS6RedcQ2UEYVsRV6f5j42B3YqFrjUiQB7dKKdW/8?=
 =?us-ascii?Q?ze8bkbQkTMaw6o2+QGyt2PkhlNeo8e4y5aGipNqIuxzwJ8dF4SHzBgLX/Xr2?=
 =?us-ascii?Q?5kC5I9wk6oAofa6KoRbj2v8znSAey+CXufO6In2v2W1+ouhEDhQkVc2c5ja0?=
 =?us-ascii?Q?Z5h7XSv6XT6FUlVuFWyezh6voqCc+eGRccoXDaQPI8rJ2dxPvNdE7QE9P1pX?=
 =?us-ascii?Q?3YelSoX7JtsCnUx0EcGZlCgEwp6bllYapjVlb89RiiOK4rHUMrenXTZgyFE2?=
 =?us-ascii?Q?7ECH3IBZi/jzaxpjE5QIbPUpElG+GjpYUOZRnV+YydH4X3+UFmWwhN+wtfi7?=
 =?us-ascii?Q?BfLL1wqK3JKrQVddZIl7Rdpq9TQ8/nBMwW8vMzYmL/gOKIHqrldO1QkuTx1W?=
 =?us-ascii?Q?tM+pA8HSpjRbkzAekb0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c4e57f-03d6-4daf-0fdd-08daad6d8fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 22:52:09.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svRtghv0PXmBgktIUZgWJwg9IJKRg4zWHv+2orQqlM+502bm10PCInwxP1QkX7t7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1779
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: UzEK99qEAV6x5hXoPYYz6WRESiPln3IB
X-Proofpoint-GUID: UzEK99qEAV6x5hXoPYYz6WRESiPln3IB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=884
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130127
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> > +	while (srclen >=3D GHASH_BLOCK_SIZE) {
> > +		unsigned int fpulen =3D min(srclen, FPU_BYTES);
> > +
> > +		kernel_fpu_begin();
> > +		while (fpulen >=3D GHASH_BLOCK_SIZE) {
> > +			int n =3D min_t(unsigned int, fpulen, GHASH_BLOCK_SIZE);
> > +
> > +			clmul_ghash_update(dst, src, n, &ctx->shash);
> > +
> > +			srclen -=3D n;
> > +			fpulen -=3D n;
> > +			src +=3D n;
> > +		}
> > +		kernel_fpu_end();
> > +	}
>=20
> Another loop that doesn't make sense.  Why is this only passing 16 bytes =
at a
> time into the assembly code?  There shouldn't be an inner loop here at al=
l.

Thanks, copied the pattern from another function whose assembly function
had a size limit. clmul_ghash_update looks ready for all sizes, so I'll
simplify that.

