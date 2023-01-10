Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66E6642ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjAJOOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjAJOOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:14:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D395EE8A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:14:42 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ADMJDW021390;
        Tue, 10 Jan 2023 14:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7AZTMfsPfCxqhbvQjRpk1bBo4ypr6O+Af09KjiKuqus=;
 b=Ov+msmwa+vcGC4H+gD/IdXLZFwrfwWKObBh4a8HksXdTXrgz9BpGiLtFc0HYaX42D8Xp
 QdhM64sBH7UYD0um/VIF1GAqQRAnwjaTy+c09adO6RH/Df2h6ajOissv16EAe+MzlAWu
 IAGwlr3PUdWUzTmJ1XI93MrWPyOON378pyekx9HhOrbEzCI3zucX6YNAFq7HBT4WWcD1
 iKRcaUkUUdWhxr0yIVTPUZc5w4qeoGyQwtrfrfdd65daU4KqsZ2RcPte8QP4cgyC6Cca
 63+g3HJEA0q6WKJLQVrbSEDWwJcSp+G8lHZhjL/oKuwR/1zKIQtgXq2iNQDjDQ0koEMT 5Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n158qgjme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 14:14:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ADngtm014613;
        Tue, 10 Jan 2023 14:14:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n198c19p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 14:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwF/3xaN/1mZGaFOVVbk+2Oy5ONKp02ald1yvOB6Gfi6u+a95TAgQAQDf88vTAkJOO9eV4edmqbDqpQXB72S9nFYbgeD2BViBVUxT6+SxEsehnQozs69Th+4wSY+li2xgkgqhoqvufzJlpgyh76Xw8QbS1o7yq/0DocQOZiAgUhqC3Ua7N+ngyLD3w/F0ZE9BwSxACYYo7uTo1OJxnkwbfIT7ozBrvyuT76yGFUMm5BV3pyedcTuKvNneFCzzl3SCQCORITvHcseD7jgv4Gj1ZXqNU4FIEbCm4EA9bwQGdM/Twv9X/Mr6rxeijV7LwZfJx4XTgcVcz+XfqYK0dsfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AZTMfsPfCxqhbvQjRpk1bBo4ypr6O+Af09KjiKuqus=;
 b=HwQuz3B5EbxJeNrWTK/vod13RUNrUrDAxDmmcp5HNIZZ0EKEJwPFUHCm4W45RxeT6ogoTbLMppV+Vf/myqJiGlOCGn0GYjEaRhW6yzAsTtKhx7C9DVYH8oCnOEN3YUC2G58ajWQTBAw9WnD99c9yFBhprc/EOKUjDILtRwU3F9rzK7D3XvksCo6Q5r1DZtX0nQTWkxL6/x2nYl9GTEEe/dn9GoYxPrU3/p4dY47ssAGaOG8itEItfS47CJD7oSzWbzXdHplepHdNNZS30x+clNufkbIl0n4D6YacgY60fx3P1/5lSBLVlnDCsPrilhwHknmwgPmA/ly0K/RA0qZ2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AZTMfsPfCxqhbvQjRpk1bBo4ypr6O+Af09KjiKuqus=;
 b=UX1iUYM4R4Vo8jHl0Eu38wIjM5P3hiMT63XjjnaozVpgHdAyx6Cwh3xp/VRnFk68bAYnzgec7vzsS0fjyahF0rX45d5+3jPaKlfCiViSxOe+ok/vHzwT/NR7bNg0plyoEtacTtgR/fF6sPYNTwPFCE4jImK9+MPGw+jwqSou0fQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 14:14:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 14:14:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] mm.h: Fix "mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Topic: [PATCH] mm.h: Fix "mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Index: AQHZJGxp0qp5kEp0gkiaLsryS6zA066Wt5kAgAD7OYA=
Date:   Tue, 10 Jan 2023 14:14:29 +0000
Message-ID: <20230110141421.o23coymw44jga4z7@revolver>
References: <20230109205300.955019-1-Liam.Howlett@oracle.com>
 <20230109151512.6d06b1d73895414885a698d7@linux-foundation.org>
In-Reply-To: <20230109151512.6d06b1d73895414885a698d7@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SA2PR10MB4506:EE_
x-ms-office365-filtering-correlation-id: 5e23a05f-2270-4025-158c-08daf314fd02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKQ/ZOk384pYXCI3c+rZ+dGCtIIPj8KJzI5/GbdYF4Rdgcoy830HcZLnr+alogJ/KTwW2XQiD6dT+GF6sHDwQ9QiBZzRzOudDDK5Jb3F/HqUEr5ClEQ3nxLoxFlU0wx0tAhjFpaUA4Pwjs083TeCVCAdTYMUlyNeumeKcdJ0Tg0o+fzIw2hea9gHVPQr7WNMq09nRNNJ/CHOEWOWAvutJBiZWUv+bwk7lx5/PVCmcMCQCTv4nB4DuaF2mfyyTvZxhbba27n90dTqXNtOa6/i5tW/kbaCirLUoWMvGEksxZLLOcoABddIJHKXWj4gR465pTERwPhgA6OEf6ivVupRpeiWsznCciJyyCKhlulFx0ZRz5twq4eh/7In4IF8CxHVVGsbqLZML/c4cwyXWos/qDXwTKX9JV4dFBpiR/j0ziJUXJvz7F271QXCj/dCGIjdSuc0D4RvbNIrxNJ+NRhPnQMVgrqIXcRPhfVx8ycFjNaq5ePqYDAXpaQl4uWU0mGKmEqG53L7HJeCWL5HBYnb2EBcMpmB3vJ6yrv/g9EiWBZtYaeF9lcsWRnoXq/8pB9+bi2PHeIpm/bRq31PWIMA014tCHkUAtSIeDu9V5kuvrOG6xTIEDLUbq3pm8QdpUX1+JV2n3eCbFnHPeionjoW0F0w50FxgYCrfCMOkepl1WT1/9DgIMvMOm+sk904Lk5Le+7VFkbMqJ/mTauNn+rsJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199015)(54906003)(2906002)(5660300002)(6486002)(4744005)(44832011)(86362001)(8936002)(8676002)(6916009)(66946007)(64756008)(4326008)(66476007)(66446008)(76116006)(38070700005)(41300700001)(316002)(66556008)(91956017)(38100700002)(122000001)(6506007)(71200400001)(83380400001)(26005)(186003)(1076003)(9686003)(6512007)(478600001)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7sVLbYJkTH17O3XaaGVJVyMut4cCMDQ0aGeaqWq6QswZg9Ax/IhvC5n12wE9?=
 =?us-ascii?Q?qpq3uK0L33UDT7nRvZyXGml3k7RyqE92yRSOWla6yroCQrnMNvO5ahG1R++u?=
 =?us-ascii?Q?M+WQN1tc9/PtKcvFEo8W2gMWUhH7xHv9MWWxGXkyyHvSIO9iYoyP5n1tby4C?=
 =?us-ascii?Q?9HPEC1Oh6t1bziwCvP7+3eAqflrrnfMiBp7o5sgTk1C1WhA151xUFwsjpzCx?=
 =?us-ascii?Q?YGgvjYNpi2bAoAIpxM7tpUXMUYySfQIuYE7CpsJbB7NJUmPHFkLZnMMBk0vT?=
 =?us-ascii?Q?GkXdPcPxcb7bAv5b4kawkio0nEqAtxebOQ5L9shblr/1TeYGcumy0P4JR5yo?=
 =?us-ascii?Q?RKyY3o6qwndUiWF9+jRsIkGvSy5Igqr3CnmmGLJ3e7rjM2nz5dr6pyYryuVw?=
 =?us-ascii?Q?NoFwm46TF2JjcBVJRvjA0gvfs1TCGVrbXZ65Dm9sFxufaMqMGMFhdkmSPAfF?=
 =?us-ascii?Q?iZq2Uo86QSmIHKGuuIVEpDDGgs6KsLFsiOlugkRjc7xYndK/udpvQjqHh0S0?=
 =?us-ascii?Q?iLgu8dfonqBSkxRq9/9aceUsUPEqWsgyTWc3RncR8jSHI5ffcTYyeCZx/69L?=
 =?us-ascii?Q?JGqQXW2wUUc/YxK+fNQ/ad1QQYYqnKjU0rWq9xHvAlqaioqmKAVQpmhFVy95?=
 =?us-ascii?Q?RGWRgHHVa26mctI5OeJHXIHMjE/3BAzF9WsO3+xFHYnEhAtA8hHy9ws8n9Nc?=
 =?us-ascii?Q?eZs9Wjamzyv+fIHyMzrxVUOUyy5gZVBEeZFnstLygYTp56oPkd4pgfOpCXPa?=
 =?us-ascii?Q?o8CzUlUJbnLaviWwyz5bPxTDefsNyDIY2lylWhn6+j47vsYp9vlgQxQxm5Hq?=
 =?us-ascii?Q?iLIvYyeQxGhTdgDV1jR22gjxGpcwOZDHBzbyVL66iPVxHy2mEuNNfyGvT6FX?=
 =?us-ascii?Q?m1roUirxYnO11g9nCf9IvYae8y1xbv+LhI3v0Vxwb3VmRCiidJwgkRrmBXbP?=
 =?us-ascii?Q?iGKtLfSA3FAsTj86/G69c2O4KpeRbMt4s+/EwwmdiLgoVl4q7mmBv37J16ot?=
 =?us-ascii?Q?j9v/4wlhfFvHcwoU8ZH4FZweIJKKAyKKufN5jFSQCbAs2b7PQvl8RtIprOfk?=
 =?us-ascii?Q?CPp2aO6x652lXdkiYWwqB6srVCR9DGoAv5J+W04e7ICMy6X7UiK77vsPodQA?=
 =?us-ascii?Q?6hApbTviwK57CxZLjk2iAChkIA/OlyLz+yvQ451/iTsyMgyuzqTP6hd9SVND?=
 =?us-ascii?Q?oK2U4OHzWnqb3etKnmoQmyC9DNrpU8BVE8SRwrRIhF6gBCRsO69H8h1x/Ea9?=
 =?us-ascii?Q?FXDkgaRwUrr8+PFPylEkVsNaIiauIBzY/QT55zOicutormGZZDsrY32+vAhN?=
 =?us-ascii?Q?8mKn3R/c8UfSMJnCLLH8KRxqbD2EgLXiidAJiYffX1iLN8UXC+m1OfLn8ALd?=
 =?us-ascii?Q?a3rXaw5BTUjWYpkmVdqra1RZ6XLg4I9IyNeZouwbdD+2G6QVD17bxqIh9jxq?=
 =?us-ascii?Q?/ffWbBTUHrDeDU9JmYZETJavZBV+hD/ntnoPfcZTVldQy21jNYjHLLipuXzG?=
 =?us-ascii?Q?yQ8CJzuTDhkyYNTJ/QT5g8QdHz+22ZQ6p1OooqVFCuWYP3k3X56LPu8ylByE?=
 =?us-ascii?Q?Dn/Vjr0qgw8kLtb0d4guKo2EkPafwECIqg4s1fCuks2pUzo5p0MT2+PxAegb?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <760FC17CF24A094388DF7FBC57B2CA44@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qtDvy30Wkmahr8KK/gm8xctRZ7FylaBZddi0pJg4p2+pQ4Ne97hzH79YOASWwuyxD5H+WsYdkU6s0Ot5DEnvsxHubnTzcdlHryHiaEHznOvOAQRMkXHhhR4SHzljcAKGd+FcALvX6KVDHOstlIkSEeFgpfhiJ9viYElidKrmq+TL1n5ZcpKdshHTyzPVgqnK5ZKT7xLnglpKJgVtm7NEBxa2rYkvNZjDxkPgN/07IX2CcIznWwGSpQK3lMWJ2cLFIfDq9GH5qr4q9HyB9+tMy48Co8wx0Ij9FwtXFNKp/WLGXp9FFQX8AhVz0j2pSwg4Xb3+SHLiqEi7l9X/lE3Lzs/YqwTT4jrJKk/DK1MVBxulXBU6kpublYOlar7xd96n3MxfBrwhtlLC4AL2peYjjDLm9ur3r9ycSRRIyL/A5AQ9jYKSpse0peSwOuchhpjKf6385ByZtYCcPhRRSG5jtWUURttJgdH/gB06Pwff4Vv88n+/ZpjtlCJk4uxGAe1A1WZyFfkvls8qr/tEFpEpk0vtpNI/OhKQOkhXfJA9soDdmpTDEQFkDdRIvscpzzY+Du6naVDZXzTo8wcrDCXDX49Ng3M8Cw/9tk2+wUjzdxp+uh85u79nmBAdgOZKln/YTlhBiOWr0X5iEOouzHI2eIOpdUcxhT+/miJHCIhBs1383lJkFipCtNZecMH+LB7D0TJOa9mVFDfMDD0lJvJEVlax/j3L7jR82VS/HQFY+m6WzsEnPSmVXWytUEBVyrRscG1sIlewtLUdPORwM+3IPaBDTLTH50qHNyhCm1T+LAgZmJKUy41J+LcCGePH5g0YKf7VsAlZPp8lknLbtMms76ijiLS19VfzVvJKyGsUbkKOxf6OV2KQWZx2z+XyYI3gXMNx26VUkSm/795a2Q1hv8J8gVAZdNdjThw6vtPLRwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e23a05f-2270-4025-158c-08daf314fd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 14:14:29.5701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TE85MaugzHiO4B0nNMYtHzQS28+Uygqq/1a05L2YyIFeNMgJA7hOtTT41fL1V09dUqpGjhD39lWXWyttXCBw9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_05,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=868 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100089
X-Proofpoint-GUID: 4_g7NEzUeU3hTPPH82SbbUPiLfu7I0BB
X-Proofpoint-ORIG-GUID: 4_g7NEzUeU3hTPPH82SbbUPiLfu7I0BB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230109 18:15]:
> On Mon, 9 Jan 2023 20:53:22 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > The extern definition of __split_vma() was removed too early.  Re-add i=
t
> > and remove it once the users are all converted.
>=20
> I think I sorted this out.
>=20
> __split_vma() can be made static to mmap.c?

Ah, I don't think so?  SeongJae reported an issue that I caused by
dropping this definition from the header before mm/madvise.c was updated
to use the alternative.  I think it needs to be in the header and so it
should just probably be there until the function is dropped entirely
later in the series.=
