Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C09664767
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjAJR1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjAJR0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:26:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B3568B2;
        Tue, 10 Jan 2023 09:26:53 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AHNu5G028072;
        Tue, 10 Jan 2023 17:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DLtHLudUuE9jxtpouIIp/zt+MX87iSkIzQroi+66BC4=;
 b=ABWz8S0KG58vPHrDHEq2pkU+HRmYU0BgY7yh4RXrfy4VZz8hVaxG4P9rzABpJITtT1tA
 byqzxTHxz/Q06bdhIKryOVusTSW6lGPAwCJpqVGNn7iAsYuqNNuLum9Gvqy5FDjlK28/
 C4O7CSobwOZVGB+72SlxWKZGgC9PaQ1erYQ0rvDPe4oelWdyP4TPWrgnOPSPr8B/pqPo
 TDIofJZzx6DEncNhcLCFdTdgiFRsbr5Jb/aNl8IN8lGdmohDKV6UPm1yT0Ek8LyJ8QZY
 aKQWEkK9iHoP6xeFCejJaK1BLy8cpRv4eQxRPQ4cJvUi4zdRcHkV6d1lXFsuk0FHQVAs aA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btnwaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 17:26:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AGmeDn003520;
        Tue, 10 Jan 2023 17:26:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1bv7a3n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 17:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxJ8/Z+AdVSXwy0Vco6hoPwtTYnLGd4PE7e6Ww9gbR51vo4zXFu9Dd1cIrxgmoFeNBCK4tZiqtSEpKsAg9mn8jzLsDOJZl8fWnvlb9h61QLaHcEzmiY2ZCIxjqrs7WKEZBLdBhRp3UrwiPTVWjt7agxzi0MSe6OpDPnLZXdv4LTskrHM/ObDjRlD+qxhn/o989fA9TkfJazmCURfhwJWbZdruZ95KbdkdKvjd8sIYBe5o0/PY2IHzL0coPdx2d0vyy/7gvFPgtLrjMgg7qSNARGzgrti7kT2it51LpannID+EqB7F35wzgqO/jcdL0wKBaK1U0hYII32qbrWeABOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLtHLudUuE9jxtpouIIp/zt+MX87iSkIzQroi+66BC4=;
 b=gLv+RBwj3Mc8T2kJv0UuISqrCwJ5umNt7jSitvW5jP6AtrMX5MymatbuKAnBZEV6EcZQgpdMW+ftLc5gRuHgYT+mSRaVlFLZQocqh3T6Ob9sNy9jrGkLWBZU4FhHyYQxmjo6J68uINvDrcZz1sOXSjZ8qX79CxDw7A7x5h26+0LuFIbXhzA1UBGSsWYDBU4YYSD82pYCfh3kMi8m71GPOOjodZjfVOgtoGC2nP2Kjtky4iIt79b6o91ChdV/STqI2re43f14iXOegTY/jUClyjM6noAWp4bUzBDjXkO5dLqEhugkHKa3miLKp44Aqs2YNcgFwqYmZMQb6FNRsrczDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLtHLudUuE9jxtpouIIp/zt+MX87iSkIzQroi+66BC4=;
 b=T3NBjPX7fwfrYNokawIuH9Q+pzEPfbl7K47+xbCTzTIY5wstUyt+No227V9mJU3gxvtAwIetOtGRPundNE5Cs0Xs8+oQhASw/aL5jv0yR8aek+DwBlQJ6n6tAs8Rn43bO00yRNgmw5UHjRAw1uFd04VaZBtH2TNR5KZfQpAFSJ8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA3PR10MB7021.namprd10.prod.outlook.com (2603:10b6:806:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 17:26:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 17:26:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2 10/44] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
Thread-Topic: [PATCH v2 10/44] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
Thread-Index: AQHZIToisBO9Z9ubPkeL2T+WGrJSTa6XxFKsgAAqjQA=
Date:   Tue, 10 Jan 2023 17:26:39 +0000
Message-ID: <20230110172624.fuxgm7jpimskzgvs@revolver>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
 <20230105191517.3099082-11-Liam.Howlett@oracle.com>
 <yt9da62qbfut.fsf@linux.ibm.com>
In-Reply-To: <yt9da62qbfut.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SA3PR10MB7021:EE_
x-ms-office365-filtering-correlation-id: 2229a460-9395-461d-9126-08daf32fd589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YdZJg/wCHpEOsdLX8CESbbYnjTYi08mlGAJb/PlQT+DdNoZDK/qp1/1MGNCnsJMoHRdt2MI42tspvlDiEAeuQwebj74YFb4+SxzRfMhnl9/iv1161FkyhDKTIrHWFVkoYbVjlS4jdDOzFrMHWJ8PJsFOugMzdDea1ZAVGX+vP71BJh+B4rZQE5QP3aCR8e3fUk5gzZET5yBprSsXZj1e4Ijek9+cVHUY2dxu/NoaoLyXUIoY82PmLvvvq6GdQRWLRw+vnOU6CVKxNgrOvi8bLYbs6+JglQaQ8z3LkA02iyOcFowGw9mRB7OScqk7phwCgeU4gSRjP1KpWs4Z4kV/LyVrcpJZ6CNV4JAwa41+Ca+Du9Nr8ij9eIvOftfuoIcvXLu3kRoULV+J3btlEXapgYf9kbQ9Pgu+sax+v+UKPYKihEHJYxZxuA6ogiT+VTccYCZfLQU3GRtJq3VOvDRVgaHkzmp5rdhgdsHCOZNhs7NwHGQ/7g1U1JiQxq8PCEeLDYfUZnFa24ES5f8ygA4Sewp9rsX/ZncqgDZePGgoO5GDIeL7Dg6JQJQjf0TF5Mdc+N1YNcmrb9hVEuR9+SGGY0WwLS8WhYWbha2FJUr2Yuo+xOaIWl7oJQQaytfMEpeM+xj3zokdAoNagwY7KQ6nKXPyAboEStN0OHIGrO6i3fJWH2EnZi561Linin+r/4gMKmyUtRu865f7TkiLWljdrD+thf9Z3cwBsNNCXoLg6g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(91956017)(41300700001)(66476007)(6916009)(4326008)(66446008)(8676002)(64756008)(76116006)(8936002)(66556008)(66946007)(5660300002)(54906003)(44832011)(38070700005)(316002)(122000001)(2906002)(86362001)(45080400002)(71200400001)(478600001)(966005)(6486002)(38100700002)(6512007)(9686003)(26005)(186003)(33716001)(6506007)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wUapxN9Obu0ujyK6izUm6oPXCu/84TJjU22mk1ZWf3GfqYGykA8Hq0hJgg9n?=
 =?us-ascii?Q?kk5CGXK1jr6rg05cv1ZNflB7/uroxKFH58f2y6mbMCqhSTj8/iOt9niPIaqL?=
 =?us-ascii?Q?lno2NDJPMpCHD74lH91AH8i9fSqn20mqmeTNEtjO2bD2uh4VZwlKiGsMt2My?=
 =?us-ascii?Q?gkIET9sym5UFg4J/Bg8puxoV6V693PLaKksRcwpgRFHX3nymZH0KXdvDt2DB?=
 =?us-ascii?Q?EzWC6Sx6CWpb2I+UlDdskSS9osNYtapz91UM/R4eTsUs1tzi5A+moUzqx8zU?=
 =?us-ascii?Q?hd8ScRqBpY2s7hxnlLRczsiq0X86VyVn/6t7XLBskam7ue1K3fgSobqEu6ua?=
 =?us-ascii?Q?BTKfOOF6WGqsBUFH67FsTWCgW8GMuK8I6YmaXIrv8k+setCh3H5PlTZj3d3X?=
 =?us-ascii?Q?4uXtNnL4O+qq4K4Q3yi+Q1QtVAm1sCf0FGp+YStt3GDfToLxshzfbrJBrp9D?=
 =?us-ascii?Q?jWU4PIm+42VkjtxzFHuGKX9/TK0TE5OIsb2UyTSqku4RAcVk8NTxiehlyYV5?=
 =?us-ascii?Q?msiCNp4XNGkL2laOpheakknBkWlLhEfs/jOGk7UhzNDwAPzVMxN9uVGrhhku?=
 =?us-ascii?Q?RfeA7pxOn/j+UUK3mU6fO9t8OwqPc1SVBH3/Mf3mKqpo3HOvJfETA223IdrJ?=
 =?us-ascii?Q?67iJU+oALIkgC5KdvH8zUN2/GXSDgVq7wLTcZmPeWs1I5C8wmB3jJ7owBGNW?=
 =?us-ascii?Q?j1Xon1pzFnncO5o2dtMtq4sfa2Rqv3LK4pMUjSIqHbIptErxLiKdly8o0/j1?=
 =?us-ascii?Q?d8isdDW20xbeM8p7b9G8w5fZ/0DwXj9U+Qqs4Jqw1I5QHkvJaSnJnxbxHf3I?=
 =?us-ascii?Q?Lc0qYLyNT0+a33YgPw6zTUhsXxPdKloMCj4HzT/F3Aic4/tEgsGFpA9g2b54?=
 =?us-ascii?Q?uluvOqY3SDDqNupg30QZd333CsiCUb13BV0BGNhQcsZkuqbe/3kkEO9hgru6?=
 =?us-ascii?Q?eShif2l4PjlCiXn8sjhRVOKpgnr70yAkCsaqCIlxXNKQyo2tBWekpiM0VdMG?=
 =?us-ascii?Q?gv44PVO7j3AL0jQtwG9hYeSMq05Xf+1tKuIN0o901abAm9xUCdnOMr9TTF22?=
 =?us-ascii?Q?P5r397mMFPVILdKZW+0OpXXPvjkA5Z0Qo5rSX26zN98yKsKJnPcP7Nsm02om?=
 =?us-ascii?Q?j9MsC8C3z/u6wv/AaeOFaTagq94FUrEsHUjHf4TSfg1RHPWDJm2XS8W0eGmT?=
 =?us-ascii?Q?7zEJr9vbWm6DlXzwGe8nHwcrg3nEse5sWhmfG9sDG/XCTCh4na7bo1yI130X?=
 =?us-ascii?Q?M3nQGWqOdHJf20hbOh2LPbvb5fdmTysAKnKI4xPwBX5/u/k954m5E7mSEZpU?=
 =?us-ascii?Q?aw1GivY+0tgaxWTod3zGCOKT4KbAY6+6I3iZ2cg5eKiD6MW02CY5TM5Lvnof?=
 =?us-ascii?Q?Kbnu0D5NisOsHRHR7cXkwX44G6RaQ7YKHyC35YxABDp4SdL6XRNgX3Kdcx3B?=
 =?us-ascii?Q?TwmuU06Hp3brJJwCuFBKYyROG+SZdZmGcnu68FzgOnhANLWAHjGPeUIFzD4E?=
 =?us-ascii?Q?Whnh4Hu9Tw0nbA1RONlIVBVBWmTbQnzVsErs+Xgm7PNnb9EAw2nvlocJarLD?=
 =?us-ascii?Q?W73e2pu+k9sVM74zOP0OwwY2z9NuHXWKfmbEviKkdvqf3B8jMkxw6AGfQlYz?=
 =?us-ascii?Q?1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99E2E528590BAB4BAB80095D4308F9D4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XJZ0l1WYxFNHNJqckBclbl2lfEQ4AIcNd/orG2rLRP2Kc+3DJvEJZpKx61yB?=
 =?us-ascii?Q?QkgiheYJ0Ta+Q26+HsLfnkbiIzGLKhbWfUYo57kQW32jqR7WKYWvrNNQWE7L?=
 =?us-ascii?Q?869SNdh1wDlbybTrWTCPtuPE26rG7mnoFRy6g0rRxJ6SWuBdDLpKQfA+mSCC?=
 =?us-ascii?Q?DC6O10Pddum08LluUGju36tL01uFScx06WdOoQ178T8r33/5MTxxD5Ah58HT?=
 =?us-ascii?Q?oL32mKVH4BH9oZNd/hJJ1pcSkdssjsl4ueKWoEzKkiY29adKDQOeicV8vQqr?=
 =?us-ascii?Q?9YWOcNfXbwHWnFN0hFTJSLzYQjyWLrU4oPO5VHn6urBTeQW6TulaZ1fMhVzI?=
 =?us-ascii?Q?YvQuUVDVhmPhjwgzHIK25o3ARW5zIV0MrsmpjHz6u3hgOk7NYn2bpAERrlcS?=
 =?us-ascii?Q?RH2wuM3oAATyAMl9zqOBjpGWY7ZB8bH7WSK12Ovz3FhmiY4cCz4U41jeCxcM?=
 =?us-ascii?Q?nvK5BrH7Fl+xNt0TKPQhrRJEII4n/ayxZm9eNRWy1Y3jWoBcxIcuVB8/WueR?=
 =?us-ascii?Q?x4hMtyylHcCRSOLIUXQpfVjlW6MGoUk0WVtyLj3/PrLg88J9Y6MswUMRWLCt?=
 =?us-ascii?Q?MFR0D8TEESuIiQcFzXF9Z6rU0ZV6oKHkXsjPudwYRbWJBkShtlzDAGc/yof/?=
 =?us-ascii?Q?zZI4jE0R/u/5rbTP9ZWStQTcIPWmEmcl3hWhtFatuLUqcH29n35ganccGq3i?=
 =?us-ascii?Q?4XUF/3Vk0JjPBo1qPgHCT1EJHKK1sALkSTG9N8BnWxLwmNhEHek8FfP/walI?=
 =?us-ascii?Q?MCfk+CPE26XiPaM7mJSpTEtM8pw8sc5omNtVOQStSFZjsG4z85DPe4Zu6Sb7?=
 =?us-ascii?Q?Ph58Spjd+9QtkFmovisurkwdcARyLHFC0n50OmtTbANj2fwFY7C82rgRoAcS?=
 =?us-ascii?Q?vpRUVUB25H2irgJaeDv2nRF3x+3MOWMSYYH0MZu1ikbQLMBa57pcsBKXCfBj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2229a460-9395-461d-9126-08daf32fd589
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 17:26:39.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1aUSwoWv3r8EMljr4VOD6hm72qq0u2MiJ4LdaHqvZFsxLr5i79drK0qCfAVmjlWRv6X678E7u+1ohBKPy8QwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=859 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100110
X-Proofpoint-GUID: tQUGdAoXQ-4saLOajsjyKUvv9eD0Cv5u
X-Proofpoint-ORIG-GUID: tQUGdAoXQ-4saLOajsjyKUvv9eD0Cv5u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Schnelle <svens@linux.ibm.com> [230110 09:54]:
> Liam Howlett <liam.howlett@oracle.com> writes:
>=20
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Start passing the vma iterator through the mm code.  This will allow fo=
r
> > reuse of the state and cleaner invalidation if necessary.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  include/linux/mm.h |  2 +-
> >  mm/mmap.c          | 77 +++++++++++++++++++++-------------------------
> >  mm/mremap.c        |  6 ++--
> >  3 files changed, 39 insertions(+), 46 deletions(-)
> >
>=20
> Starting with this patch i see the following oops on s390:
>=20
> [    4.512863] Run /sbin/init as init process
> [    4.519447] Unable to handle kernel pointer dereference in virtual ker=
nel address space
> [    4.519450] Failing address: fbebfffb00000000 TEID: fbebfffb00000803
> [    4.519452] Fault in home space mode while using kernel ASCE.
> [    4.519455] AS:0000000001a60007 R3:0000000000000024
> [    4.519482] Oops: 0038 ilc:2 [#1] SMP
> [    4.519486] Modules linked in:
> [    4.519488] CPU: 7 PID: 1 Comm: init Not tainted 6.2.0-rc1-00179-ga7f8=
3eb601ef #1582
> [    4.519491] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> [    4.519493] Krnl PSW : 0704c00180000000 0000000000929464 (__memcpy+0x2=
4/0x50)
> [    4.519503]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 P=
M:0 RI:0 EA:3
> [    4.519506] Krnl GPRS: 0000000000000000 0000037fffb1f990 0000037fffb1f=
990 fbebfffb00000008
> [    4.519509]            0000000000000007 0000000000929480 0000000000000=
008 0000000000000000
> [    4.519517]            0000000000000009 0000037fffb1fb40 0000037fffb1f=
880 0000037fffb1fc58
> [    4.519519]            0000000080288000 0000000000000001 0000000000cf6=
5da 0000037fffb1f5d8
> [    4.519527] Krnl Code: 0000000000929456: b9040012            lgr     %=
r1,%r2
> [    4.519527]            000000000092945a: a7740008            brc     7=
,000000000092946a
> [    4.519527]           #000000000092945e: c05000000011        larl    %=
r5,0000000000929480
> [    4.519527]           >0000000000929464: 44405000            ex      %=
r4,0(%r5)
> [    4.519527]            0000000000929468: 07fe                bcr     1=
5,%r14
> [    4.519527]            000000000092946a: d2ff10003000        mvc     0=
(256,%r1),0(%r3)
> [    4.519527]            0000000000929470: 41101100            la      %=
r1,256(%r1)
> [    4.519527]            0000000000929474: 41303100            la      %=
r3,256(%r3)
> [    4.519547] Call Trace:
> [    4.519548]  [<0000000000929464>] __memcpy+0x24/0x50
> [    4.519557]  [<0000000000cfd474>] mas_wr_bnode+0x5c/0x14e8
> [    4.519562]  [<0000000000cffaf6>] mas_store_prealloc+0x4e/0xf8
> [    4.519569]  [<000000000039d262>] mmap_region+0x482/0x8b0
> [    4.519572]  [<000000000039da6e>] do_mmap+0x3de/0x4c0
> [    4.519575]  [<000000000036aeae>] vm_mmap_pgoff+0xd6/0x188
> [    4.519580]  [<000000000039a18a>] ksys_mmap_pgoff+0x62/0x230
> [    4.519584]  [<000000000039a522>] __s390x_sys_old_mmap+0x7a/0x98
> [    4.519588]  [<0000000000d22650>] __do_syscall+0x1d0/0x1f8
> [    4.519592]  [<0000000000d32712>] system_call+0x82/0xb0
> [    4.519596] Last Breaking-Event-Address:
> [    4.519596]  [<0000000000cf65d4>] mas_store_b_node+0x3cc/0x6b0
> [    4.519603] Kernel panic - not syncing: Fatal exception: panic_on_oops
>=20
> This happens on every boot, always killing the init process. The oops
> doesn't happen with next-20230110. With next-20230110 i see shmat
> testcase failures in ltp (shmat returning with -EINVAL because
> find_vma_intersection() tells shmat that there's already a mapping
> present).
>=20
> Trying to bisect that i stumbled above the oops above. Any ideas before
> i start trying to understand the patch?

Yes, try the patch for fixing the invalidated state I sent out yesterday
[1].  This should come before ("mm: expand vma iterator interface").

1. https://lore.kernel.org/linux-mm/20230109165455.647400-1-Liam.Howlett@or=
acle.com/
