Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6E640A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiLBQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiLBQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:15:52 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB7CD9692;
        Fri,  2 Dec 2022 08:15:45 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2GB8C8018156;
        Fri, 2 Dec 2022 16:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=jyvLXUSfBER6rqAoMHJQa8Bsr3AxLgu4w1vojBd2hCc=;
 b=HBxz/Bo1VBuDTxni9WustDy4LrXcTHZpEC2pRGQwWTCxGhBI2U4VI7pamP61r0Rhq5LE
 96nYVVj2DCi2trqJZIFU0T3zSTaP/PFMnOiE1q6Wx6yPhNPZwaSXL10rckM12zTsYII+
 st9YOIRneulO9SqmNbgagcC+3E0Yc8puJdvvnHn+n4A2A5+vblfHJBshskGZzKdesXlx
 tyh6B0kOic1iQSTHapuRRwJAnH922KFlm5WhwIk+D7Mj31SbM2IwYEkVTc1eeG8A5tep
 yQAVpW6h97E5SMtQ4r9/xdrl/YTTsov13fFojTdJZ5UDYLKoPBgTiSOjI2p4PB+eqYzQ qw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m7knrrpc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 16:15:34 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9DD8B2FB2E;
        Fri,  2 Dec 2022 16:15:32 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Dec 2022 04:15:25 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 2 Dec 2022 04:15:25 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Dec 2022 16:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy6KspJMk/dJjRUNF51fz1iNe9+PGwLpctDLNUQXZblnAZ+M+LeZgP3kB+CyDjDi4NLtIN2Z7fzHhCLcb9zQptbYyZTzU6cPa7ofUTgd44UnSgDDb6mwZCEUlkiXI24zrS25nHIFsm4mjTE2MGAlNHgTFGf2lOGJDi0wUPhr5bu+pQXOYdjX4m2d9FB9NIzyuMzNXHT4yUCpWOIDO2RqJhUzCnlYzQL5r6jCeutfMQga6+9u1dts9otR8Cj7jagoSC5u8qch1sngFLTQboDQplL+w3/mkc1aHrMJrK+iELLk4EiWvi2Bm/kS+58oXkoGm9GZOeqSeNXABFuH3tYaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyvLXUSfBER6rqAoMHJQa8Bsr3AxLgu4w1vojBd2hCc=;
 b=TpupN6S64O0LnTZkJTcgW1n8Oc/C0lFk+uDPQNyh2zwmLi8pE1Q1Jd9InUvL69PovUWC2XmLpcljLHs4SFL0ZtKFFNtjc4S00WonoHGhpbTyQYtoGWNsrnpADWc+RARoeKO00FKj/JA+vU2aSVjFj2ju/wZRDdtAr0jwMaFvWkUEeO60MJTI5DvqxAeVqwUMVTkHVSqt/oB9j9IiX+iQkXXxBxglQxBju7OvuRE2VeVOEpiGfEe64NQpasljqmV98FoPOT/WG2/29U2ZivcuLrdRqVeW4zJRwW8JqpU41gPBHt0njoppNu9yNPfZeQKWyuZnIY+TV5i1Q1O2Cd4uJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1656.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 16:15:23 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 16:15:23 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Topic: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Index: AQHY+XHqfLLvXNGxcESumjNg7U4Mn65BZh+AgA36OwCACrj5IIAAU7WAgABtSRA=
Date:   Fri, 2 Dec 2022 16:15:23 +0000
Message-ID: <MW5PR84MB184215302DC8E824812D6B13AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com>
 <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
 <MW5PR84MB1842C2D1EA00D5EF65784E25AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <Y4nEcV4w3eOEFYze@gondor.apana.org.au>
In-Reply-To: <Y4nEcV4w3eOEFYze@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH7PR84MB1656:EE_
x-ms-office365-filtering-correlation-id: 737d1436-cbe2-4a3e-d004-08dad4806a4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DyPaF2oKWPH0oZlUg4DTN/uZM6P66IXBwzP+f2I9RSL5cZJwPhKzyt/Z4cHq0uIQOhtlIgCJHPxuY1kUbVcn0KwtHWJOVu/e6zed6MplOBt7MXobLTbeBoCbpRZQH+Bl9T8RsfTWdweGXO7bmbqBb8H2xOx3zH+GQB3ZgtrTQ98U6ie9D1bhefkN5E5fg0orw8/62O+Wr/8Ogc2nt0k3XvVyWEaA1zQOWAjL6MGUHdLa4+fK23JUTroi3+glQ0hz/NM3jt8zoHAE5nWC27/u+IUMUMQpCH14+ikbm6CtqzmU1cYGk5wKUr/Emkvd30e3TqdXeYZJNRNyV7hwhW1+rxpiXs+eksI7GGXmNMIbUdrxSZ/n0qsgzhIB+si6TzqK+mlDNMi/3g5bU0pcoVJV7iFZwfeIyiCz9BkzAwEg+EBYS3EsbtqCJn6vJ98b3JcfKr95jcJuIbxADYFZ3KlCGol9QbcOM6TWtLo9Zcj9uAcEYdif1QKTkOSxmfVigTeGW5WCwrMeJGJflQgJd4Gt85mfiV84bKClIe0F0PwHC+QShXzX5nu96tC4/fFPUwyMKLRx1nXRb213y4ghWwdFyDodEj2EzJbSuyBxs/yIbsZ6Wfejhpv8qI0A9jEZy7fKipbSjn38npHRVYAs5PxJgN9K58w5C2lNmFUj6YVEXEs3CEqX4vQKcA7YNHUGQc4Qy3I23Fug5DszzcvXXIKcjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(316002)(6916009)(54906003)(38100700002)(41300700001)(2906002)(122000001)(52536014)(8936002)(7416002)(5660300002)(76116006)(66476007)(66946007)(33656002)(66556008)(4326008)(8676002)(66446008)(186003)(82960400001)(64756008)(86362001)(38070700005)(83380400001)(478600001)(71200400001)(4744005)(6506007)(7696005)(53546011)(55016003)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sH6aJeP/0dUD1QRls0gIGXp1qKEN+PX11ARbzeBW5zolRDHF3cmbq8/Qihrc?=
 =?us-ascii?Q?8Y8db8QU186J8jIOrOIpmVYx9d2s18K0Rg0oKQPb/GjJh7MhCsvvuLC8FBlb?=
 =?us-ascii?Q?vaHmONiRxTN4I5GFxIPP/GzQ7Xz3xDEFktAiLi6n7VJX0EwWX6mE/urai/dQ?=
 =?us-ascii?Q?xo/653sKC8AvShMS/aTFyHbOBBmx7lG3fAJQnY4EPijrxnzn9Y+5+pzUXS1I?=
 =?us-ascii?Q?hhltuib6NXxfgs85XYZIiF4xq1iiOHPxlnAUNlvK4TkpSqSKmCEJepEHPhEQ?=
 =?us-ascii?Q?ESEDweXGneyy86Ffh1hZbzDdRiWWoJuxJxaPEX9yvp3752BseAQIF2lTyqZo?=
 =?us-ascii?Q?y7c0/Hp/RJ6OzlNtegaMnhy/Rk7YwCAPqOUbDAK0lrSCm/W13K8720vLFb6N?=
 =?us-ascii?Q?/hrWQ3MZ0JU44OXtfFqWOUAlT77khpvbXNWpCbRK1nyQ+vlQq2T5WJAW2VBk?=
 =?us-ascii?Q?VDtUoWs7ZDQtXnATLbSnKvnNNy9Q15+tFUx42CzTrwMcuYHrtCtxY1mF63ow?=
 =?us-ascii?Q?oM8lM1YPZwCmquKNALC1oTTnh3rqcc6GD81oOycBa4STNYcCnXzc3PrzQtun?=
 =?us-ascii?Q?MPUYIn7qXrOnC9n0jlT1c58wbX9Fj/cPwb04/DBLIrw+NrNpDLOWGlUKUpnu?=
 =?us-ascii?Q?sdL6KfTlH4YxcUDza/LwR7VcFAdhK6ufQdGrCcbIEpjb7tBpY7klSEq7hEeK?=
 =?us-ascii?Q?ji/rEiXo1w78rDhICsJeRboXXd8JF4FSAFyEmR5dwIor5h4wXZCHEDoW7eXQ?=
 =?us-ascii?Q?G9HOGAWV9o8sEYzw2hCkhMjOAnPY1EUKLywQp/9Dh95hA14OG8t2J7+rH0yd?=
 =?us-ascii?Q?TfZ++2th/oSDhttrmBq2vU1MTirOshTA8GFxCpZs2QkmQNg7nqrIrIWM8SOT?=
 =?us-ascii?Q?dvReJw3D3rG0YxwA4FJeeErQJDzb/nwXfFZDKEpbD8gfL/66/IUx9ukQCIGl?=
 =?us-ascii?Q?11HVc0ZjXexqXJmrT2hX+3kgo9hLJ7MMMnj1WUv2Ne6ZOmhtq+vvEPwiTJVX?=
 =?us-ascii?Q?gD+9OKHr/DCOnaot5ab99plzF0OcPxbj6UWqYTXzC2+3oiO5/JRBhVem9WjO?=
 =?us-ascii?Q?ljd36D18KYIxT8nJLGUqL23X/AHV/TsV0D5caaKZpsleczz/W/pb+ntTRBhu?=
 =?us-ascii?Q?Kykxomv/241LIj5kfrZ5dXwhNGuKL3qoPGiYSJo8FXgUzdlrNZygUS5QZV1l?=
 =?us-ascii?Q?B1UPGgR8N8u/5CJe+zjNHfeo2FUtU8vDIAD0bOKvqKIbBLYHsAwgavRwwbEp?=
 =?us-ascii?Q?XWCqWBlIuIb2HsqA9r6V7eU974WvBnaJDeGB3BS9UgJ3NvN3Fv8raclsKPrG?=
 =?us-ascii?Q?H2gYoTzuo/XUUYiuWWzhyGEiqBJslNtWmou6WnNMUmfgsu+xNy+fkkPeOn1O?=
 =?us-ascii?Q?1m+kxcXlPg2k3w1BLNa/haqiEFsDKyq3TjIs2i69URepRYfNofHps/q5X0iF?=
 =?us-ascii?Q?wZu1mo+ogD7nolyV0PhDZJwUQnkb8yHp+kSTDrtSTIXCa0pGylOtOt/fs1Ql?=
 =?us-ascii?Q?zFwCXwpzTZYYbvR9MNyELNBXa7aDv0Nuh65T9cN4tfqpz82IIRxSNYjclbRo?=
 =?us-ascii?Q?zuUoqmNjsOTW5KbPuQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 737d1436-cbe2-4a3e-d004-08dad4806a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 16:15:23.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYhJLVg2h0TbmPwqZytKoxfzNjI80SdY/QBBQvFS/oy+OPVBCX6r0p2fYY4cuqNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1656
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: I3fXUD89744EKoZKh0WCzS5zno4i3HvL
X-Proofpoint-GUID: I3fXUD89744EKoZKh0WCzS5zno4i3HvL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_08,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=919 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020127
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
> Sent: Friday, December 2, 2022 3:25 AM
> To: Elliott, Robert (Servers) <elliott@hpe.com>
> Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
>=20
> On Fri, Dec 02, 2022 at 06:21:02AM +0000, Elliott, Robert (Servers) wrote=
:
...
> BTW, just a minor nit but you can delete the cond_resched() call
> because kernel_fpu_end()/preempt_enable() will do it anyway.

That happens under
	CONFIG_PREEMPTION=3Dy
(from include/Linux/preempt.h and arch/x86/include/asm/preempt.h)

Is calling cond_resched() still helpful if that is not the configuration?

