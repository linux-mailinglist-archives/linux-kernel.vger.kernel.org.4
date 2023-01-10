Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC3664E09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjAJV35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjAJV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376AB5BA14
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:14 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AL75TY003384;
        Tue, 10 Jan 2023 21:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0HbIDU9gvROZzz6/UYBDpx1N31Qr4FGP4cShMjeUTgc=;
 b=njljbaOhL3N5YeyKZeNnCX6TrY2musWjLmR5Rpl1V0OPHc6pkph8IpEE2VlfpkF6LziH
 7AFSviSYFNDb7B/2+e373lCxzxwlsaHxDwqxuvVNZZyHn6GQx3OHOE8Q5Z6BkhVqf39O
 tuKw0iHg4RdDyAUURi2NS5bm3KZaESngj9DJcjxeqbw41kUrGiZgNKP62PGTdknQ9yF+
 plxQgYECpWUnoVYiuhVTSBBhiVQqJDSnUnaEHRBkNqECN5OhR23LKKAovMQmWFchVCXe
 iiQUgPQNEcrZJm21KueCBpn5IiZOq1vOVjdJrAZKeXhuqDm5O8e6Hha7oWw/tAMDj7xy Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scedta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AKY8kT022668;
        Tue, 10 Jan 2023 21:28:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1f5x25br-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRBJjOOnvG1jserSMLEHUEEH68giFPpMa1AAvA0PWSbAgeERLuKaIglq8GdzJoLrOWjUTpep4JGs8I9ZJcCQkSFCxwVmUk2kQi2KHuIr8oh7prL/rFNcULP7+9v0EpA4t/tK2oPDttLkksnau+yTNJu00SVPZP5GMp51Y5+lLzuT/9ishVPMagvk9WVmnxracJfhK8aNGfq1RCaX+Rp8wnLsId5HLbVmf5a7oQBccNq7ORZl4hdbShUo9Unw3Reok99s/mGvsAzXbOMreo1IgXpiJ+aKALlBYWvnMK+ORCbHCHu4f1VJwXzs2ZJhSZQ6tcz9Z6AJmGHy8T07YsixBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HbIDU9gvROZzz6/UYBDpx1N31Qr4FGP4cShMjeUTgc=;
 b=JDo91oBPJ6Jjz0DywgB1Ag/gxsSNG5B8Kn1sRiuw6jBvajE94bv7Co3Jhh3W/ktqJCTrzx/TXULgeNBOA3UidsFzYS5hdAN+tsREn2BpyoN/W4WFrJAU5KDbxPxNR3FqOzRKMwPew2y151WBkET78Wthk6yKVhQ4cBSFDkXG3r9cZofvrsj483Em9VuCvEzI0cu6cMOyNKad3Q30psVDLIoiUhFiVXsF8thy0RQHlZ0X7IWmkl2x/GjmbhFGP3lSt0ZfIqNTUBuEe1C+M+5RbZEJqhe4JgKpD/9abBCu0PrnQ/TtAWAAnFnrFrT7dokFCMwmEP98/BAE38ZoCFS28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HbIDU9gvROZzz6/UYBDpx1N31Qr4FGP4cShMjeUTgc=;
 b=tH9NMA72cmOPxLCU/xr5C4XarjTe9y8DGDVxrA9dZ9OGcpfZdGdhOG3PA4z/Yu1q+xTPgwPFSu1DvP61EmgHo4lq7EQVcyUx2fPy8OqsI5iiX0VixxU3Pz/fA+H93LCs5Diyao/2QKR5YIIbugbTezeBsERNPGiyuNyyxkXsEIs=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:51 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:51 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 8/8] mm/hugetlb: convert demote_free_huge_page to folios
Date:   Tue, 10 Jan 2023 15:28:21 -0600
Message-Id: <20230110212821.984047-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 43935b9b-26fe-447b-7543-08daf351aac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mNVaNsS/guQTrxyy2p95G+lLeWq/OkTCtVnsik/T7HgI8wWsIQb9gn8bI1gNgz/xx1KxJ1k6Z/VKiChOcYX5V5FzJcQC5ld5BCsLFUoSQ2chfbxQb5dk3lEX0w/3VYRZ92EtqCSOELTD8g1QX7XlLlgDAUkmCMe62dJTcBXK7tfhgFVDBQ06ndDbZEqaHEnINTQJurvopEsKFnmAONj/GzyJrvUhpHbJZuyDGFnat/uu7fCQZPTXbodq7tdTJAYHX+A1vZYIe1bi2cq92Klllx5YuN3xvUQxHr94viLEZOP2Cc3TkYlqpGGw8Weke8GMNrrb7IZBTookoP37eYaPmfgpHQV9fjTXkeolkoU6RLk8jsKoLRWg0SsJifhuEIVbD2WMeGiAGNsdWcFb3xx0XL/k1ocuD4BGs3wmxy/F3eAQfpQr0e3Nlfj+owEOn5LzsdMfmM+MmwgkaLuZo7kqfGlZDDBwndz9wNJb8eKyLWYnAV8cHDQYwq0vrooKsg4707rjjK0AtDnL5ClFLY8HMmmXopR85158lvpNk2sh515fvr8pnGnG0WX01CY18Gm6yu9p/qXfu0yNDYZMC8Tq58qGpAXsPNg9qk/no9RZQwOSf36E3XC+Uoq2XnHGe/nb1qu8RfX0XaJr+sMLWv++RC/bS8pzpiq4adxJSA7MvFQRoB/s9TD9ZIYpDpXBvbA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(38100700002)(316002)(36756003)(5660300002)(2906002)(41300700001)(44832011)(86362001)(8936002)(66556008)(66946007)(4326008)(8676002)(66476007)(83380400001)(6512007)(478600001)(6486002)(1076003)(6506007)(2616005)(107886003)(186003)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WfR9fycZJrlV+w33zHd3+UlD8TH81Dgs3hXBqUm59bub4cmph6Gw5A2GMFdn?=
 =?us-ascii?Q?h3dS6ryrT6EpEWcr33n0c3SciMSrkoUHbDWSEQ8bGr452fi643JDjkESoM7C?=
 =?us-ascii?Q?OHYRmbQTbgmWed7faiQ4s5X8SwCt9MAwuD8o/XyanZuvuC5wLypAK71Ej+sZ?=
 =?us-ascii?Q?LpUK5aXfRub9pV1zZqFkuIXmDryBHU5lfoCC+2InrUN4IhlraSJK0LgKTzuG?=
 =?us-ascii?Q?by4NUlgDC9Z8oUeCCsy1yt9qWAMESQrBi2yt173UwC7xcKk9wC8/DeOjSQca?=
 =?us-ascii?Q?Z8vsGCdNPYznbV9//Py5Zxvx7uhnVEKzebufONq92lC3sjml1W61FV+UUiNO?=
 =?us-ascii?Q?9ka3ae2pb9vuL31L9Nb41VWlZ05yUnq2rndiw4Ggg6pHhi7lwANRAkItgZGJ?=
 =?us-ascii?Q?4qQs9vfFF+7KerR6uT9UNjIB9J8bRz5auN2M0rumZuEl7zbsMfV0mLIm+aP8?=
 =?us-ascii?Q?z28Cc7KCvx+sNz9Lt5eu/TT6yKcO/lNsacSSAiPBzF0jL5B89c3SLwOwvnHX?=
 =?us-ascii?Q?0yAwQaAZn8b1pdlyjJKR4ujo5qgsW0nKyKsuEQEJMcj5x97Gj2yK7E6XDDMP?=
 =?us-ascii?Q?0E63zj6Su4KtYNraBrZDjn6vxiglPMpV63GUanyKng6WqAgtS6SpWhPa+DzC?=
 =?us-ascii?Q?W6AnQt4peU0emCqW1iqQydNbKQ74PqeJEI3NSh3xsCW5mTy+lecbHLF4Wqnb?=
 =?us-ascii?Q?37eEtf5fqhzbLbJb2h3xKAi2C/s1baxChxmiq84WNkraOPV97TLG8DnGPshU?=
 =?us-ascii?Q?gvSePYl5FtRDase5uFQwdY0wcH5oyPso1VlRJtQMFR5rSVXRZhzdv1HFuFhI?=
 =?us-ascii?Q?p+KeI8TG4lst0IX0tWN/gOeGrvAkOREwaWg3t4zpr/2olywu+/RSAFCXDmhB?=
 =?us-ascii?Q?0I+8KpdZcIIUpYj6us7JDVfABt8/uEJnmMLPi2aOwIQ7udbwXVqYGpagQYqy?=
 =?us-ascii?Q?RyablD/aTUxIuGlVTZNhM0BSJBqQl/1Z7fAhzYNTW77WaOkrJw6njssyuHig?=
 =?us-ascii?Q?GZdPlwoUzthvihJu6symbtUzxX+dGtp4oJ4Bq/UVW2raTvCgyAu1DXh4Z/A4?=
 =?us-ascii?Q?cjPpShHK+wGmVxpoUOMGLE5A6eIX+pKVuozLCuSmNHetGIy7upyWaVxbjEFn?=
 =?us-ascii?Q?yLTbJ5pR4kQiTfJi7BtjioG54P5ha8mgaUcLejBIKp7RAxwOYbr5bn4DJTk6?=
 =?us-ascii?Q?dIx0dlaW/5LD+bYwV9CNs6pgXlmPKHf7AGIAT5UZ6DxWSe81djPyKECM26TG?=
 =?us-ascii?Q?fUnSaANgCxq8Xy1Y0LJ6v+Jm1lfWdPlBCJ+NPBCmujKDsNUBkIk8L0Wjw+dh?=
 =?us-ascii?Q?FCt5ddpxbsF9Hq85ifAQTTyzOhDQWTxEaLWKfREP3shz5sUUN+FqxIJpvULr?=
 =?us-ascii?Q?6hap7GIJ60em+9vC8jY14xaJNV6SJmqndpSLLEw+WhlzyvfBi+JUmA59r9Bq?=
 =?us-ascii?Q?U/KAytIP7EAy4XZZaiBhCeSt8TVBCTHt/vc6Ww3zBBrbgM7u59nQguryE3cJ?=
 =?us-ascii?Q?rB4TeW8YItIKJDr8JrWAEppaemGnirFLary3gc9zWhrfa1PNbxs69I3HIuuU?=
 =?us-ascii?Q?2ZZ19a53DyXZZubwuSjR+WtRPTqAj0ePwPCw/hkdwkY5XBVal9h5mEZtf5RA?=
 =?us-ascii?Q?CoXs2Sq+7yQpED4MnhbE+b0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wgXLepa8X/0lwVDYyj4C2M+F9hYJ4qDDZI8EIoAw7ysGEjNqfJ/AaxF61r/w?=
 =?us-ascii?Q?Y5hWNPJdzKF5MFzRXKJMJmqGoo2jPqx7ztxBYjW02q2zfWX/MWWYrM9QDto9?=
 =?us-ascii?Q?wjmAoVlhcyLnb/gDBHejQMKi2s3+ak8uahNg2G92JtD97YAWn7tYNsZIbzR3?=
 =?us-ascii?Q?fYaZ+WOqh8x4FhqVjtZYma/jZBmHHVVRsGpC7V+a5Pm/PRSJFjNczL+5k8ej?=
 =?us-ascii?Q?Jzm7MZ8E8kYgTux7G8WnfZcRdRNYu55UHZfh6PUpYK+2ghUkjny3c+5MCpAM?=
 =?us-ascii?Q?NIhFJWUFCcOvW/SWrSzIhWK+BumlrwXVIROc/tTHARHNKNuqaEalntbmLFts?=
 =?us-ascii?Q?/dU9HpYl2EeAUyj8db/PUUQO5lNnLqrS2+Klm6mxkYMekLfIBSHZXOfp8pgi?=
 =?us-ascii?Q?QqNSCWrSYKrdKGDeSmNvBrG0i0wviC2zmTFJvjDvZtNg2NkYxeC8VlHiJ/C5?=
 =?us-ascii?Q?LAJvQh39ctDcB221fDqGZM0owlIuR1RByAKazFfsnEVZPZSFOMB+5Q49XcWA?=
 =?us-ascii?Q?6/2uNPAq3r2a29kblRg74Z+MNsbbuPDESGHY+GrZ93zTjGDT5LgR3Ewt44QO?=
 =?us-ascii?Q?GvkiDWLn8dY5e1O12xySkTWugiEIYsA+SoU+E7C8/6KoqA8RAV26aSRsNznV?=
 =?us-ascii?Q?DH4P7D/PNHh00UpQgEEoXNUNp0v6KgTikoW2X4x7DLS6aAqHZC6G4el7yjG7?=
 =?us-ascii?Q?wHoqi5k3I90otvqsd6lILhuYdlaeQ8XE2A4Z/eu+TGtKwp9agzSgFIXeeIT0?=
 =?us-ascii?Q?yVYiNVxLhYqcTEdbwuKwfD6v9GijYE7+FUjnUFM+bQbWl+U5icOsKRXGNncS?=
 =?us-ascii?Q?JwQxrov1vuZkR4dCX+jx2GnW/dfSmvq85X6t8YVstjKgE0wZNOdd/rjC/Q4y?=
 =?us-ascii?Q?zX3dvnvnWxEbvIdoT9sEQtq6OtLbemAhKvdFGm8RiXdaVf/EbeRXGgtTk70J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43935b9b-26fe-447b-7543-08daf351aac8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:51.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHwiKpbqr60yiE2+jZSaiTR2yVp9m03k8khCqSolb3D3g48R3EMXVZEZAhEp+05nV78VpqTkd8ZkqJrCjFGY09YZ+HjdYznt+NA/bZFn/AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100142
X-Proofpoint-GUID: TK6OfMZXmgatTfrpscOYNIbXxvyTBP7w
X-Proofpoint-ORIG-GUID: TK6OfMZXmgatTfrpscOYNIbXxvyTBP7w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change demote_free_huge_page to demote_free_hugetlb_folio() and change
demote_pool_huge_page() pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f8cd0c694fe9..21ffab744c8f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3435,12 +3435,12 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
-static int demote_free_huge_page(struct hstate *h, struct page *page)
+static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	int i, nid = page_to_nid(page);
+	int i, nid = folio_nid(folio);
 	struct hstate *target_hstate;
-	struct folio *folio = page_folio(page);
 	struct page *subpage;
+	struct folio *inner_folio;
 	int rc = 0;
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
@@ -3448,18 +3448,18 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	remove_hugetlb_folio_for_demote(h, folio, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	rc = hugetlb_vmemmap_restore(h, page);
+	rc = hugetlb_vmemmap_restore(h, &folio->page);
 	if (rc) {
-		/* Allocation of vmemmmap failed, we can not demote page */
+		/* Allocation of vmemmmap failed, we can not demote folio */
 		spin_lock_irq(&hugetlb_lock);
-		set_page_refcounted(page);
-		add_hugetlb_folio(h, page_folio(page), false);
+		folio_ref_unfreeze(folio, 1);
+		add_hugetlb_folio(h, folio, false);
 		return rc;
 	}
 
 	/*
 	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
-	 * sizes as it will not ref count pages.
+	 * sizes as it will not ref count folios.
 	 */
 	destroy_compound_hugetlb_folio_for_demote(folio, huge_page_order(h));
 
@@ -3474,15 +3474,15 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	mutex_lock(&target_hstate->resize_lock);
 	for (i = 0; i < pages_per_huge_page(h);
 				i += pages_per_huge_page(target_hstate)) {
-		subpage = nth_page(page, i);
-		folio = page_folio(subpage);
+		subpage = folio_page(folio, i);
+		inner_folio = page_folio(subpage);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_folio_for_demote(folio,
+			prep_compound_gigantic_folio_for_demote(inner_folio,
 							target_hstate->order);
 		else
 			prep_compound_page(subpage, target_hstate->order);
-		set_page_private(subpage, 0);
-		prep_new_hugetlb_folio(target_hstate, folio, nid);
+		folio_change_private(inner_folio, NULL);
+		prep_new_hugetlb_folio(target_hstate, inner_folio, nid);
 		free_huge_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
@@ -3505,6 +3505,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 {
 	int nr_nodes, node;
 	struct page *page;
+	struct folio *folio;
 
 	lockdep_assert_held(&hugetlb_lock);
 
@@ -3518,8 +3519,8 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
 			if (PageHWPoison(page))
 				continue;
-
-			return demote_free_huge_page(h, page);
+			folio = page_folio(page);
+			return demote_free_hugetlb_folio(h, folio);
 		}
 	}
 
-- 
2.39.0

