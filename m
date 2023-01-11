Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605426651B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjAKCXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAKCXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:23:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5423583
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:22:59 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B2GHV7002864;
        Wed, 11 Jan 2023 02:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RconWpa3mwgiXCBZO3cFqEXjES+1EHMDSp/lDssnf9E=;
 b=asQ1kUk3HcvXoe1BiMqn90wNOPSLLHaI+9WhNErqC9qgS/uidhpoAI5rbshpZL/zKj0a
 ODJ2h2d0FMKkq6Gigsc5uIgYZi4Wk1Xef3tuhFS28Nc5nt/W6oOtrGAyIZ3V4W8OkwlS
 Iplp+zDJHhQwYohyVjdAh98Qby/jQ1vV25BjUqceLv8YtFdpEjJZlp2wEaz5u+rRiq+G
 S2SHFPb9jR+z7FYdWQFmrrU9GcldYqTRzgoKSLpT9ybCdr16h4ssCd4ihkt7g0I20U76
 z2L0aCPRIDr3wlJG5oVq5PGV0Aop+hW4VHx3bcRtZP6RFbOmiBB8UefBLjYZD6ynxUHs bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n185t9m9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 02:22:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B13xVB040661;
        Wed, 11 Jan 2023 02:22:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4d2c0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 02:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqgMHWG2YBQ/Lkcx298+dXXOW6Si+JaUMsfp3EDT7ckC7noECvPUTu2M1dvxQQBoCIhDbFDoLmKray6d7GLumteGAIHUCdgKYuCayzIrA6hDbjj0FFwFFlSbrhwWpMSKKkG5dqRMhl+JGUgppw8WJzp152cfVQhiKyRP06zKKrNqLUzLRmkoQhinnhg0jba4TH4vKsQo0o4NBeT/TNIKQax4eTpWIZDnACEPeRFzb+JtirFSk+lUhBP2oLiE6i4SOLJedFnbjpPUvEXKDYmtIKdaN5T4rvU00Z8bAPCfiJbyUmP6fmETowlrRa9YSkV86JL2gC44LVOEIIsF/PzL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RconWpa3mwgiXCBZO3cFqEXjES+1EHMDSp/lDssnf9E=;
 b=VoTvYpJV4beAL+/OCxbABuatVPp3A9HhcoQnR23vpDH3ANW/ycBWDTtf85NIDW8J6F6egrBB86RKmU+zWcmQGoMMIYvS539XY7ZpMjMbkh/e60lB7VpYs87ffycQ3pNCHX+ha59/W5cM3Xtzo4oT50m7f31y+P4+WAJfuBcE8KXLxm1HdZ5IDCIJqFjNQJgoRsh5bRF+wZ+l35LrUhrTl5uwP4M78T1kwgRj0eB/oYL38z6RuggBE4X8OuFLTiobgYyTsOK9Pd7n9hR+uPEl5v4DXdh8U+x3pM13x9iJINtR3iC5W6nNIMseceoa/0EOz6hV7FSdhpQc3O5U95zqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RconWpa3mwgiXCBZO3cFqEXjES+1EHMDSp/lDssnf9E=;
 b=mToJbtPGKoc/ud/jJ6oCLn5N8WOMEgn2cpK5y7+1hMFjJggoVv+lkj7UJ96/FpOugguSj6olS14mr2GorIRF2XG1TvQmoYoR8IDzEFKlNopwm2p16xckBJnRoRgb1LwjpcYtpmH5fETdtQ6Spb7t55PG5N2bP/a8SMauqHOsq7s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7482.namprd10.prod.outlook.com (2603:10b6:610:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Wed, 11 Jan
 2023 02:22:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 02:22:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/44] VMA tree type safety and remove __vma_adjust()
Thread-Topic: [PATCH v2 00/44] VMA tree type safety and remove __vma_adjust()
Thread-Index: AQHZIToccOuEFtBclUuUQ7tIi7gZoa6YSckAgAA64wA=
Date:   Wed, 11 Jan 2023 02:22:41 +0000
Message-ID: <20230111022234.vkbei4m6jya4zxsb@revolver>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
 <Y73sBPPA+kaJCiZY@sirena.org.uk>
In-Reply-To: <Y73sBPPA+kaJCiZY@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB7482:EE_
x-ms-office365-filtering-correlation-id: c990b58f-d52f-4929-f2fd-08daf37ab748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yau6bWJFNfpiHW9cOrPm3wOSvqEBlOcqFvI8MGNJiZzAuyQg5RQQ0Q7uGIXI6maaNVfq9rW9/clRPTeHD1lF8gfmzFrlGMX+2F6X3zeR4psfax7aI6V4iY3SYbtQ3pSN1EDdF8o0Q+VudZvuPR38ggxYfEnY5Atfs4iwaY3g4gW+N1h+cxsy2HvQdtKhwbibuPuskJ1CKhEyDmrYlzztVTsGl3rwhTJ/AY+lPF1bf48fcx1IUcfAWdZKV40aBFodHmr2F9KCZk0sAT/uaXhbhs0WS+UFk/A9g1hamoQ9dCB5zMImku/oXl5SLVNXSHabV7rXBBLfW21no2lhQOKDu1b3pFAJi+GlvAd7cLnuyEFIxHkbUSQzzHs9VjGb3Nn9oMvrWWGCyqECfVnwvThDq603oimwSssHkk+TqCtJZUowZbEUtzVJIMlVko/vTXLsRVqiUI69H7BcVqZAkgqm5apIZC3h9Mp8p4z67r3ctIpO3a0gPvoBNrWvmnC4GDYEjwlHT5etyeIgITfaNCuc4zLIv/hYNgPGUwj0PrtdiUsbGiEneYeKXvDk9j6Rd6TmvcIlOnzjFFVTT8MFr+wnJI/3ifVoTBwVuZuQVzrckardxWmWeXMqgfl8x6pN7KpucguUR8ZvnwffNVCn2FiyeytYzmRWucTN8jrbuxtAd2KorigVcMnIHzBnI2Zf1R9vyJArZdKYCjAUGpV+OpZq6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(38100700002)(6486002)(478600001)(33716001)(966005)(45080400002)(54906003)(316002)(6512007)(38070700005)(86362001)(83380400001)(26005)(1076003)(9686003)(6506007)(122000001)(64756008)(5660300002)(66446008)(186003)(2906002)(44832011)(71200400001)(8936002)(4326008)(41300700001)(66476007)(66556008)(76116006)(6916009)(8676002)(66946007)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m1ben2JkHTapBVlPnxg7BgHDrN7OuJ2GerHes6XkO4jAfceqMtjn31uFHxon?=
 =?us-ascii?Q?1i/6YTdhsZ8kU1X6KWXzeJWdTY2fOOog1GaLoVLwSmUH/MOWEpREyoa21dZG?=
 =?us-ascii?Q?mqbyo6A/Bz/dIhVC0acatzWM1gWy6MfI208BLYgXUNzLEYJ7Y4/d7qX/SsWQ?=
 =?us-ascii?Q?ul/RKw7OB9voTba1hTs7Ll3zgmcm46jMwQofx2wIBRXlK8OqKaBR6oSGbHz8?=
 =?us-ascii?Q?wgAVnLbTSNbYbeG6UygT1/cXc5sEjceS4EGddcc0iVXVFpoyFfm9R5CaiRpt?=
 =?us-ascii?Q?8sUnY8CVNKpuWVQlAo/vHtrFE9etZbc9fbLoN6tKvUmLOag+vTykxZOJlr+k?=
 =?us-ascii?Q?PtJDbKMn4FhVjlaUaHKjfXw9A54mqvF/j6Qo43CRUaZ1/IYYHQui0gwc5Tv8?=
 =?us-ascii?Q?tnWO3jr35txat22ZkvwJT0GAA4eZQYPfvaHq+B4J1D4NrP9kZYNTZrrZdGx1?=
 =?us-ascii?Q?DWXKXtG9FiexibIXN8DMG52AID33Vz3A6Utp13azVE//wOhMoj3lpwCLSM2q?=
 =?us-ascii?Q?pTw8s4vw0WuvzsGvFasOLiF9ljBqjKDjIiUskDGzGWls1rALzKm5zX2ZPn4b?=
 =?us-ascii?Q?3I3UYe3rk9hLCAVPrDpuDEcoQashyBo6joW+J0YAybYNAIlv/4rVcJXi7zbB?=
 =?us-ascii?Q?CrAq8De2wze6l8HabODIRmk3Lwo+DC3XHVyk8lOKadTHEvdWjPgCJbZXvZsw?=
 =?us-ascii?Q?74WGCUG+NQzAkudteENm7fblc5fDxO/9O9+uiUQU4SMsEAWpRx9w+5w20zrv?=
 =?us-ascii?Q?CMzmUD4c5v83RMX9sd0dYRCNUeIlQPWphalpBwKxN+vyTUbvd/lTz77GhEhc?=
 =?us-ascii?Q?ZPAtAEf1rIUhc8+iNRj/5mlGE8nIhAJqxMRwdAjHwgLu9D3QUJJb1QmNo2ku?=
 =?us-ascii?Q?jJe6OGIlZZrSkZsFU/dLLQIrd/qBTjZuJdQsJPqW1Jr7AuDXmcvesHz+sff/?=
 =?us-ascii?Q?Ch5D/xH/jMBv/Xnb2sRIDSbs0+Izj8NZoMDXGsH735CP1DswKq3kgJs3AroC?=
 =?us-ascii?Q?Tnvr9qxmkQZjsn3XVyKcHxa4kSbx8E3moKasXakdw+7jXzrGByKCB0yJKKa8?=
 =?us-ascii?Q?ukOfDqWabcQbSGxcPMhyYAFVimUxGcKXpUWip/XuAJmrSKxIDE5r9NYufB/B?=
 =?us-ascii?Q?ijb+QLM1XCrH8t+z7e2G6W+QHeEohCcv71oNS6JzJh5qiFG3rhaBEE8sj3aM?=
 =?us-ascii?Q?OQj96LA4VBHyN6UJIICcB4R7h9EEk3FnZEUDMgASKd1n6N+fdzNl4WYd7MWr?=
 =?us-ascii?Q?WNSZO15ty88h3zWO24Cm+kkgIC6PFcMGGGQEmiq0x4+OMNC7j1a7DbBlh9+B?=
 =?us-ascii?Q?YkE8bJDL8bZwq7Xtjdyv0KQlaKr6krnStjF9yzid7gKnBbWH2YojcxQbMvUA?=
 =?us-ascii?Q?pujgzNprgJPqQm9GYrdTK9DNbqdET3zvic5+dl3EwZ709dupvozZLwZgLiVb?=
 =?us-ascii?Q?ATHAmAjS5SxmyqoniDv5Jf7DqMIskDdTG0gBV13Vyk68tJPLX7BkPs+czpPw?=
 =?us-ascii?Q?zUmN0+VnxNGTNMenCwDkUdcejNaVtQUnKdvJFm9XdiRTNz4A7M6icNo8dCT0?=
 =?us-ascii?Q?dtgLdlbpydHG0Vd41vVzd7epIWYjuXmYta1gGoSg2QYABb4uOX6QqjpsnhES?=
 =?us-ascii?Q?UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FA7C42B3A889A4BA83CA1922B631462@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jjb7eTs4UNxzAkpILlDXhA6ViIByheATc2j7cFkoRJX6vqiHxVnp3wVJnK+fddByFySOG9PnrY5u1J4VwwC8AErQtTBmvW9UY6vpdPA9Y8/EnCmT9cW3zifxalw74UnhxCJp8vUyzIQ6B4wI5KDlB4tn0bqMprhBqEmf2muRp10//p3r3o8uDmnJ++Rf+vtlseXMH7PtoVD7rugO+e2aKvYsnDtPuvw+VxOjETB+G8ky8HCReKLDxfWbrIMi1oZllyktfmdBPK8C5giKKupJ1qZsh5KUrjxwKAi6gptdsst7LS9RHnNMDDQOArK13zFg6U3U+xbkd+2TWc96/LIEMg58qu/hdt0MY2GJLy+p3PBeFsE7KaJOICbvlXt00eISWhHfPPRLqNWuBWuzzFggYMOC3iqPsBS6lVCa4nFyrBgzttwdjdvCtG516NkRqe1Ne/CcFhrTjVs4WpkgK+VbQj3hgJ2EJbLxUOkF3PLthVYywhCc474QirYgFceeUYCpnDC/EhHZm30llSVo0EuN+uBrxC4MkccT19maOfVjVn/hzGQ5dykXHYqYg6nEUkYWbCIs55I/iFEkNCLDeHzPBMlBtkRkTwcUybsw6/iMp97NoDhI5LHllfbps7Z9SwvAKgpiplLDhwkUsxf2fSfzvPifuEHayRIpABT83UBoNp3s8pF1mrArEQ/vL2wx39XA5Yr5sC2+YkHOAqwCgqXs1hjY6CD89zQYUIjHoQyf+KOOvNSAnrJWr1b7tJO2trOQSkMEmeI6ujikUx9Ug3TWuJRfYyKwYTihCsmI9QFFOYfGYEcHnKmCsHkUYD/yp+s6rLJMwt21QKLz9Dr6XuXMEekmfYnwZlttAe8EKOVlBhj8Jgs4DhFaOC0xOuv9excC+loZAVlw1/yMKLMJGtLKrxQrEjrV3U8j3UPLdroNfxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c990b58f-d52f-4929-f2fd-08daf37ab748
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 02:22:41.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +csjBGft5riUhxaZgAzOzjTKQMmSAmU6+enyV9bDT/ATnitu7x6SLsaEwaXaLhYL/1OAQMX/fXoju5IDAepeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110015
X-Proofpoint-ORIG-GUID: E0zEFBb0GXgQMkYkSKRQB_k8fmFiYHzj
X-Proofpoint-GUID: E0zEFBb0GXgQMkYkSKRQB_k8fmFiYHzj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [230110 17:52]:
> On Thu, Jan 05, 2023 at 07:15:44PM +0000, Liam Howlett wrote:
>=20
> > This patch set does two things: 1. Clean up, including removal of
> > __vma_adjust() and 2. Extends the VMA iterator API to provide type
> > safety to the VMA operations using the maple tree, as requested by Linu=
s
> > [1].
>=20
> This series *appears* to be causing some fun issues in -next for the
> past couple of days or so.  The initial failures were seen by KernelCI
> on several platforms (I've mostly been trying various arm64 things, at
> least 32 bit ARM is also affected).  The intial symptom seen is that a
> go binary called skipgen that gets invoked as part of the testing
> silently faults, tweaking things so that we get as far as running the
> arm64 selftests results in much more useful output with various things
> failing with actual error messages such as:
>=20
>   ./fake_sigreturn_bad_magic: error while loading shared libraries: canno=
t make segment writable for relocation: Cannot allocate memory
>   ./sve-test: error while loading shared libraries: cannot make segment w=
ritable for relocation: Cannot allocate memory
>=20
> I'm fairly sure we're not actually running out of memory, there's no OOM
> killer activity, the amount of memory the system has appears to make no
> difference and just replacing the kernel with a mainline build runs as
> expected.


Thanks for the detailed analysis.  This series has been dropped from
mm-unstable and, I guess, out of linux-next by tomorrow.

I will retest my series against a larger number of platforms before
sending out the next revision.

>=20
> You can see the full run that produced the above errors at:
>=20
>    https://lava.sirena.org.uk/scheduler/job/88257
>=20
> which also embeds links to all the binaries used, exact commands run and
> so on.  The failing binaries all appear to be execed from within a
> testsuite, though it's not *all* binaries execed from within tests (eg,
> vec-syscfg execs things and seems happy).
>=20
> This has taken out a bunch of testsuites in KernelCI (and probably other
> CI systems using test-definitions, though I didn't check).
>=20
> I tried to bisect this but otherwise haven't made any effort to look at
> the failure.  The bisect sadly got lost in this series since a lot of
> the series either fails to build with:
>=20
> /home/broonie/git/bisect/mm/madvise.c: In function 'madvise_update_vma':
> /home/broonie/git/bisect/mm/madvise.c:165:25: error: implicit declaration=
 of function '__split_vma'; did you mean 'split_vma'? [-Werror=3Dimplicit-f=
unction-declaration]
>   165 |                 error =3D __split_vma(mm, vma, start, 1);
>       |                         ^~~~~~~~~~~
>       |                         split_vma

Thanks.  This was reported to me before and I had a fix in mm-unstable.
I'll squash this into the series for v3.

>=20
> or fails to boot with something along the lines of:
>=20
> <6>[    6.054380] Freeing initrd memory: 86880K
> <1>[    6.087945] Unable to handle kernel NULL pointer dereference at vir=
tual address 0000000000000078
> <1>[    6.088231] Mem abort info:
> <1>[    6.088340]   ESR =3D 0x0000000096000004
> <1>[    6.088504]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> <1>[    6.088671]   SET =3D 0, FnV =3D 0
> <1>[    6.088802]   EA =3D 0, S1PTW =3D 0
> <1>[    6.088929]   FSC =3D 0x04: level 0 translation fault
> <1>[    6.089099] Data abort info:
> <1>[    6.089210]   ISV =3D 0, ISS =3D 0x00000004
> <1>[    6.089347]   CM =3D 0, WnR =3D 0
> <1>[    6.089486] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000043e3=
3000
> <1>[    6.089692] [0000000000000078] pgd=3D0000000000000000, p4d=3D000000=
0000000000
> <0>[    6.090566] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> <4>[    6.090866] Modules linked in:
> <4>[    6.091167] CPU: 0 PID: 42 Comm: modprobe Not tainted 6.2.0-rc1-001=
90-g505c59767243 #13
> <4>[    6.091478] Hardware name: linux,dummy-virt (DT)
> <4>[    6.091784] pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS B=
TYPE=3D--)
> <4>[    6.092048] pc : mas_wr_walk+0x60/0x2d0
> <4>[    6.092622] lr : mas_wr_store_entry.isra.0+0x80/0x4a0
> <4>[    6.092798] sp : ffff80000821bb10
> <4>[    6.092926] x29: ffff80000821bb10 x28: ffff000003fa4480 x27: 000000=
0200100073
> <4>[    6.093206] x26: ffff000003fa41b0 x25: ffff000003fa43f0 x24: 000000=
0000000002
> <4>[    6.093445] x23: 0000000ffffae021 x22: 0000000000000000 x21: ffff00=
0002a74440
> <4>[    6.093685] x20: ffff000003fa4480 x19: ffff80000821bc48 x18: 000000=
0000000000
> <4>[    6.093933] x17: 0000000000000000 x16: ffff000002b8da00 x15: ffff80=
000821bc48
> <4>[    6.094169] x14: 0000ffffae022fff x13: ffffffffffffffff x12: ffff00=
0002b8da0c
> <4>[    6.094427] x11: ffff80000821bb68 x10: ffffd75265462458 x9 : ffff80=
000821bc48
> <4>[    6.094685] x8 : ffff80000821bbb8 x7 : ffff80000821bc48 x6 : ffffff=
ffffffffff
> <4>[    6.094922] x5 : 000000000000000e x4 : 000000000000000e x3 : 000000=
0000000000
> <4>[    6.095167] x2 : 0000000000000008 x1 : 000000000000000f x0 : ffff80=
000821bb68
> <4>[    6.095499] Call trace:
> <4>[    6.095685]  mas_wr_walk+0x60/0x2d0
> <4>[    6.095936]  mas_store_prealloc+0x50/0xa0
> <4>[    6.096097]  mmap_region+0x520/0x784
> <4>[    6.096232]  do_mmap+0x3b0/0x52c
> <4>[    6.096347]  vm_mmap_pgoff+0xe4/0x10c
> <4>[    6.096480]  ksys_mmap_pgoff+0x4c/0x204
> <4>[    6.096621]  __arm64_sys_mmap+0x30/0x44
> <4>[    6.096754]  invoke_syscall+0x48/0x114
> <4>[    6.096900]  el0_svc_common.constprop.0+0x44/0xec
> <4>[    6.097052]  do_el0_svc+0x38/0xb0
> <4>[    6.097183]  el0_svc+0x2c/0x84
> <4>[    6.097287]  el0t_64_sync_handler+0xf4/0x120
> <4>[    6.097457]  el0t_64_sync+0x190/0x194
> <0>[    6.097835] Code: 39402021 51000425 92401ca4 12001ca5 (f8647844)=20
> <4>[    6.098294] ---[ end trace 0000000000000000 ]---
>=20
> (not always exactly the same backtrace, but the mas_wr_walk() was always
> there.)

Thanks.  This was also reported and a fix had landed in mm-unstable as
well.

>=20
> The specific set of commits in next-20230110 where bisect got lost was:
>=20
> 505c59767243 madvise: use vmi iterator for __split_vma() and vma_merge()
> 1cfdd2a44d6b mmap: pass through vmi iterator to __split_vma()
> 7d718fd9873c sched: convert to vma iterator
> 2f94851ec717 mmap: use vmi version of vma_merge()
> 7e2dd18353a3 task_mmu: convert to vma iterator
> 756841b468f5 mm/mremap: use vmi version of vma_merge()
> aaba4ba837fa mempolicy: convert to vma iterator
> 8193673ee5d8 coredump: convert to vma iterator
> d4f7ebf41a44 mm: switch vma_merge(), split_vma(), and __split_vma to vma =
iterator
> 4b02758dc3c5 mlock: convert mlock to vma iterator
> fd367dac089e include/linux/mm: declare different type of split_vma() for =
!CONFIG_MMU
> 3a72a0174748 mm/damon: stop using vma_mas_store() for maple tree store
> dd51a3ca1096 mm: change mprotect_fixup to vma iterator
> b9e4eabb8f40 mmap: convert __vma_adjust() to use vma iterator
> c6fc05242a09 userfaultfd: use vma iterator
> b9000fd4c5a6 mmap-convert-__vma_adjust-to-use-vma-iterator-fix
> bdfb333b0b2a ipc/shm: use the vma iterator for munmap calls
> 3128296746a1 mm: pass through vma iterator to __vma_adjust()
> 80c8eed1721e mm: add temporary vma iterator versions of vma_merge(), spli=
t_vma(), and __split_vma()
> 311129a7971c mmap: convert vma_expand() to use vma iterator
> 69e9b6c8a525 madvise: use split_vma() instead of __split_vma()
> 751f0a6713a9 mm: remove unnecessary write to vma iterator in __vma_adjust=
()
> a7f83eb601ef mmap: change do_mas_munmap and do_mas_aligned_munmap() to us=
e vma iterator
> 39fd6622223e mm: pass vma iterator through to __vma_adjust()
>=20

...

I appreciate you running through the bisect and bringing this to my
attention.

I will do a better job of emailing linux-next the fixes, which I
obviously overlooked.=
