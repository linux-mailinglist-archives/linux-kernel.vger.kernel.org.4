Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF416439AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiLEXyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiLEXym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:54:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33191D310
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:54:41 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5NiLw9017169;
        Mon, 5 Dec 2022 23:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=VEIFR7SSlOgZ9B5GP/2WbrspEx3HhmAum+A/rqnkjE4=;
 b=OmE1YTWq/iu23YbxXG2M/yjje47CWKZJeug8UZm2iLI/RiYGOunfVLtoLNYBj9uXiCQ3
 lKhD6dWWzGFp+EhZZC7ClWPwun3/DlIkFxo5mt2W49hJ8mqixsFVvdzwSGso6P3Rl11q
 HPaCuVHV4sGPrf1Zb+XcK10azWI1ESSLG8O3HLT8V++whho+icxS8HC6iR66DyKpH9Ec
 JWPY9Ai8ry8kmjEIfEmMj3j/917mb5rsVfoxAMcZco+mfBKFdDo6n7YGWAp9y5aryIOv
 2OtrQ4Htijkho1uZRV4+H+yRRJUHTRbkWgSHihgvkop2WK5sOf/KyAjuiYKaKRs+0z2l 7A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ya45tw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 23:52:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5Lix6A027871;
        Mon, 5 Dec 2022 23:52:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8uaa0f3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 23:52:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdU1afklm8v4BMFamLwbY6jO7Ou5JZRI98SM9HtFA+yjoqME4pKDCd2t50qNoAU1TUq6QUnEhN5JRXYs8ibD57uU6cYci/9Xlsx5wYMTqMZHJRkzmFcZRarJsStQqxVuazRldhEOHLtlvaRnOWuGbksSaChA5k5VP36de+afWdWoa8d0CdlRvyFRRx/+E7SoY9c8DMavdzPk2LciAYyYZgBCi9NQuzuRi3pXiehQybXG964aZZBRuyPR07JKJnKjquyUMYYbHvYZ+N2a2h1OAyV8OTTTZz+OHDWjJRnvhWzluLtWS4eQpsI36evZw2Z3zKekBjk5t1WivEWLMXvhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEIFR7SSlOgZ9B5GP/2WbrspEx3HhmAum+A/rqnkjE4=;
 b=Hugi48Rkodd9KaNjRcMTXFt+72VXbPPYHAY2bsylYR27WcPY4xSDw6Ft8TyNG+9JjCrLe5Qy/sgPsCDQU209jbjZf2HWgAIejVEKK1nTkLOM9Go7poV7YxJF9ZNN/kkkQXOWQvMDqAd18RboEO7ZSq2QRvqWJuBx3I0/niUf4PJr0C+s8D8JfpfOyaApBBKOOhsa6Q93gQFKmFmYVzUC+uJGzoNp2wqPAuaJ6bnr3DnyDLbIfT2Y5JcUjLETwK6CL1RWWZmjswvjviPIKzlUHPvjgMug7B36IzZlhwYkpcHXUiFM5v02hx+HZV0dEKI2jlMLY3qaoUKBwy0VAo/SQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEIFR7SSlOgZ9B5GP/2WbrspEx3HhmAum+A/rqnkjE4=;
 b=pk+hgMS6N6pwIOuFqvpGGO0GGrOcpoCSXtUSbjQvfHCgtpLBO3beii/cN+LWNkw+9WIC9m7zRYDg+2XccO3qYexwmQILgUBft2RjHXjJX9k0nSetrI5bAw4SxXj1iJS8iTDvbSGtZCOnzlQuyvBqTVJAwIR3ZEo+sjHg6Cska7s=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7340.namprd10.prod.outlook.com (2603:10b6:930:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 23:52:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 23:52:21 +0000
Date:   Mon, 5 Dec 2022 15:52:18 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to
 pmd unshare
Message-ID: <Y46EMlDLCThbrl+E@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-10-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-10-peterx@redhat.com>
X-ClientProxiedBy: MW4PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:303:16d::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: b5091ce7-da5c-4bf9-0ac6-08dad71bc02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cj3Wnndi+Q4r/yDLeMYzzJ1jUbUxBfgG0s3yCnNkG2RBIyyTxpwMY/Kal3gKFWHVpi7NyCC5ym78El96VHPDFymAC3xse8JZMBLlNHXNDIi6RdiCRs5HOJsq+x8+yvXNf12r6ixpGsbTu0e9Oan/pbEx+uL/FE5vdvimXlXhD1jbrcHfM6Zb2iipL9zVBtspONCxUtWnKfEIOo+xnXtT4yvYIukHceXlK+xuAeru0UnSBVbMZkMKjzJ/1UYDfewc5HTb3m7DLOdxqyvJ96pgsdCr967PNUslDaGdK0yMUBN+6J0nGWsRfVe1WwCBtmXlKep9Ub6lbgpQae9Son9cuMyLUFJwZQlZrtmcM+n9wq3o2xIAHWoXhY+mDlahw2AiYTPOd1/CRH9cYVKwbzaRCe9r/BYzDSaufDU/SdmdT2DsE1xEbrhuHHgZZk4sMD2B+jLgALgWGwpNWgVUyoQozjXsDEBHCIhWRUkLMEH2rh7Fxmpnigow3Z4ce6DgYNSdG8oFMG00O3S3fw0YpOTQXUA2XCEXt1BWQs7tYmAYzraPsAPOgNk08LWfjEox6p3in98dMraHh0PwfQITebYkXRI16QIQo7zriANTdG17RPbzbb2AzzcNFplh5awuRG2e6VrdmwWDTyKB774wnzFlqt0bpp2+aDKsOXk4n0rXOl9weynr3LoRfkSLZ7Q5NhkW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(8676002)(86362001)(4326008)(8936002)(5660300002)(44832011)(7416002)(2906002)(41300700001)(6486002)(83380400001)(6666004)(478600001)(6506007)(53546011)(33716001)(38100700002)(6512007)(186003)(66476007)(6916009)(54906003)(26005)(316002)(66946007)(66556008)(9686003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3x9/6mmGgKA3vcESoaWsk/TfupjupfEPQJBAjxkSfTaiWGDGG6WRqosqd7Ka?=
 =?us-ascii?Q?Fdx52MqsZm20tZzagkdR5zaRmWTmhqInj9TU4P50YYuQJuiLn5vktRkm712G?=
 =?us-ascii?Q?PeFSib/OIlaIkOzDeHfAOfOH9QOhbzQ6lyzJcAYiBCM8Bo58urJUVomyAY80?=
 =?us-ascii?Q?zsq2w/pqxkWPHTFYng5PoicY4w0MFQchtowah4CL+Aqt2IPVHK1H5gfMFTqE?=
 =?us-ascii?Q?rtrtYAklmvelWVsPprDupOIv3BDd6Jg257337A6Z+OK3H0zNNkqAyS5PJ1PO?=
 =?us-ascii?Q?FHgYaN0q80Ue7jwxSHUbsD5jbSkEirFv6zxVGUmGqWmbyXe212m97Ml7DjE9?=
 =?us-ascii?Q?bcM3H1x9YgDJ3oQbcfFimkmB20CnZmMqiMPS4PU9FyS/86QV+s2qiVzNHGeV?=
 =?us-ascii?Q?Z4xo+58oGQHEq6LckDa6skCCfA8R7neIMo6cj2sbDfr8IGnairoU0nE6GpDi?=
 =?us-ascii?Q?44DElpn7LDzy4YUPJiIkl4unFPsekBPwjKWaKp5sEvmOM1b104vaEJWhXPia?=
 =?us-ascii?Q?c+mbYvxvVa2QgCda1qqBcP3/e9gD4e0ix62NlVLKaL66OnEh8DdD/dz4lt+4?=
 =?us-ascii?Q?/c3DQ6bf7fnNGl4JzBby0LGw0rv7heYh6MVZkm2JTeo0rN87IGcbqPuwZInC?=
 =?us-ascii?Q?eDag0uo7WJp5JjgObckEcHsZpz7eaBYibBSDkMAPzGlZ5npdwXkoqP+b/GC9?=
 =?us-ascii?Q?GRVEh/wFkglYJbo4jMzCT12wzzDPTvwdZduwOl/cE4JYRalXnQKr0zGYBptN?=
 =?us-ascii?Q?kp4Xhbd5nhbYV8OBrLVJRQ2zZ9jtiPT9s8O8Vg/srJAcMnrQDA33X8g7F9hq?=
 =?us-ascii?Q?tRPt+i8Hkxtp8/HHB317ltzacu16tPvR5pfuaP9wstUGIz4mcK0GcUUkj/gc?=
 =?us-ascii?Q?uFwp8upptE+k9+JNW0g6cQJplH8Q8SvDNf262adZxJhGTNfvTCUiR2C5ChUQ?=
 =?us-ascii?Q?o4QOmx3iF3G2oPTk1fZDu8UdZBzX7cPhU+hw7qVmqMXDLEMVehoNO+FKbM1+?=
 =?us-ascii?Q?sn0q7RSiEdog6FBf+qPW6GACifJzcng2hceLoot33Hwl8NwTo+D3OGfc+d/I?=
 =?us-ascii?Q?Oh9H2w1gb3l4ObN153ddDBKwhLSDg2FLDBMUi6Tcg9chfwL6fEQb6INFrDNS?=
 =?us-ascii?Q?nx5EMA34bnQGgdmVVIqx+jOoreEt3sSgbkKXC+l2gXHRv9ckvc7rPzBbQ5/v?=
 =?us-ascii?Q?3fxZY+gQd3KIkP8GiO/PuTZ8aQe1tI+ND1nvsK71UYhS0YCawVGv5r6jNSLB?=
 =?us-ascii?Q?0ixU9z5vjbHS25CpClwzs6li1WIoJ9VAuMtJooNNDsvYh2266MC/Bfv3SaP8?=
 =?us-ascii?Q?O/bc2ziVx6jcFa3FFZkmvgKF7yn0GocYYGMxDBMBHp1jrGFtSdU1IN2FFFN7?=
 =?us-ascii?Q?lU3N6ZOSKKz1O2MZdiBbal0pfj5obQh3a/lpiKzFoerrbAnl8PgOGbkXEKLO?=
 =?us-ascii?Q?MKKrs/+cJ7eii2oQTbMI9Xg2T5ySOut+8h5VZv1Z6f9zm7aRQAwYX2dhCLpi?=
 =?us-ascii?Q?WlUoMgjnXm0aN1tnZ6lnhR+bNxSWLVtwvXq1IoRZUBAbvDvRBUNOb4Ht6Kvx?=
 =?us-ascii?Q?xDaZQmPhWZo5F779O3D/+c+OnJEYXtoyo5Ic7GY5Vb6oS67b/IM+5lMaZbEn?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?B62frI37llYCF64pQ9jzBsXUeLBQn8Lho1JkRS/jOksdJ1PAvHYAAQvPtRqr?=
 =?us-ascii?Q?g9Qf4zzTunOc/Igxv11jyGUAonYrbNXSDYH3neoiEIAFFm5CihCu2R0mi8wV?=
 =?us-ascii?Q?iE3Vrhb3k0/QE7WOIYZNA9tbE6PrBoHfGl7NQBwnXFkTsjMtiaz3P6NsUPXd?=
 =?us-ascii?Q?X4TdVKpyMoSDDKWZ/HuP3i53Wx2EyNp1JKGfL46svTaj9M4p/aRDnop7u4Bf?=
 =?us-ascii?Q?uUb3s7Q98sCfwzDRGD4x6d0a66DC+Uq3JuJ2yXR2X/xPIRuHxO+AosTnb/6u?=
 =?us-ascii?Q?HFzHt0rm/UlPk3TFd+PjaGYg71Ahdcq6DjkOsGP/eRId+QFJor2/3T4tZ3O/?=
 =?us-ascii?Q?kUIihj4SNBrFoao5o3UR/XkzlY1qWL+3XVlays++Yv4SoP33xuRPdKObkQ+N?=
 =?us-ascii?Q?Eu3D5bZ+By0IjiNaaFRWMy3pi/hnhVh5qDmani0TCsQyElGe+guiT+RNLBcP?=
 =?us-ascii?Q?uWa/SyJn47Mbe/DdyFSTf9k10jY/AqHOO0dMA4WgRUJZmdgjvn+TUfruERq5?=
 =?us-ascii?Q?kKxOmhve2l/3mS0C+k/6FcOMzuJ+oBiDCqZcb6BUaTtrO/VaureweG86t5Cx?=
 =?us-ascii?Q?6K/jtzBfa9xmT4IRu19KI4Z3spbIw/GKPsT//T7hBnDObvkq5okPgA2ia9nt?=
 =?us-ascii?Q?jqlBJv1S3pStJGfz6sLdL59fDojJY9S32+VC3eWOGLhM1EwBpg4ImkfN5ZBc?=
 =?us-ascii?Q?x5MSQou4KkY07z24d3kblyLM3/nW2feYUxiImgPHQQQUj3j8PtnXNNzn1uQ7?=
 =?us-ascii?Q?oKrfXc58TcodIizJvxYdz5GmSdSXsSisUo/yA0779jg/b8EDY7p/WUw7Sao8?=
 =?us-ascii?Q?2xkcLnIV1JLu3idB+i7hX3Y5GtQ0je4nXQqNDqUkYngTVetkYYfsdGYy+SsH?=
 =?us-ascii?Q?mZPI5vvYIMr5PzbW+RiNhem9+cg2/f/OjkRJvgG8IC2fR+biWKKjKO6mY3rB?=
 =?us-ascii?Q?GMdiN/XY2Ci55bK/tBcHJZvhaYNhXEAXY1vuAISGC1R+eIONb6uttIbKBvNM?=
 =?us-ascii?Q?2s5PnnFJ/ZnWkmiyEVIm2GjzwPku29O+BPJXX8ATGcqcYLvvCe7t5/nrVVRq?=
 =?us-ascii?Q?lmNfvgjKvecIu4aiiNej4a9QGQAmyQ6gBvuNriNmEPt/LNczJmQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5091ce7-da5c-4bf9-0ac6-08dad71bc02c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 23:52:21.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHU5VQLG7MAOOfssGc97DhbQsELM0C6n59/hBld77IEa3drgvGNY/rQJUrIa/dPLRUJaWCtbAqVrAAORsIBxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050197
X-Proofpoint-GUID: Zi_5qLl7VetbvFalhXhx7s61B0iaWoLp
X-Proofpoint-ORIG-GUID: Zi_5qLl7VetbvFalhXhx7s61B0iaWoLp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:35, Peter Xu wrote:
> Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/rmap.h | 4 ++++
>  mm/page_vma_mapped.c | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index bd3504d11b15..a50d18bb86aa 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -13,6 +13,7 @@
>  #include <linux/highmem.h>
>  #include <linux/pagemap.h>
>  #include <linux/memremap.h>
> +#include <linux/hugetlb.h>
>  
>  /*
>   * The anon_vma heads a list of private "related" vmas, to scan if
> @@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
>  		pte_unmap(pvmw->pte);
>  	if (pvmw->ptl)
>  		spin_unlock(pvmw->ptl);
> +	/* This needs to be after unlock of the spinlock */
> +	if (is_vm_hugetlb_page(pvmw->vma))
> +		hugetlb_vma_unlock_read(pvmw->vma);
>  }
>  
>  bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 93e13fc17d3c..f94ec78b54ff 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  		if (pvmw->pte)
>  			return not_found(pvmw);
>  
> +		hugetlb_vma_lock_read(vma);
>  		/* when pud is not present, pte will be NULL */
>  		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> -		if (!pvmw->pte)
> +		if (!pvmw->pte) {
> +			hugetlb_vma_unlock_read(vma);
>  			return false;
> +		}
>  
>  		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
>  		if (!check_pte(pvmw))

I think this is going to cause try_to_unmap() to always fail for hugetlb
shared pages.  See try_to_unmap_one:

	while (page_vma_mapped_walk(&pvmw)) {
		...
		if (folio_test_hugetlb(folio)) {
			...
			/*
                         * To call huge_pmd_unshare, i_mmap_rwsem must be
                         * held in write mode.  Caller needs to explicitly
                         * do this outside rmap routines.
                         *
                         * We also must hold hugetlb vma_lock in write mode.
                         * Lock order dictates acquiring vma_lock BEFORE
                         * i_mmap_rwsem.  We can only try lock here and fail
                         * if unsuccessful.
                         */
                        if (!anon) {
                                VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
                                if (!hugetlb_vma_trylock_write(vma)) {
                                        page_vma_mapped_walk_done(&pvmw);
                                        ret = false;
				}


Can not think of a great solution right now.
-- 
Mike Kravetz
