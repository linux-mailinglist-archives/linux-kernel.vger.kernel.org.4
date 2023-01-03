Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424165C740
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbjACTQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbjACTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B67140E5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:32 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JDsTk019208;
        Tue, 3 Jan 2023 19:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Fo1RxbKBNEh+3O3z+QHKut+Np6Q7TabFfVnFvfxT3m4=;
 b=N04LDY8MUQExjChVeNA3rObejVRJDYoC9iMKq/IN3p7OvCeGzvEjcwdPx1vCyOa/7QNv
 WOJQ2NPHbart1X211pXY0d8bHO+87qFZ06vhhf//0HzL46Onh5MEoQj4StOoWevTP13+
 wa8xmeEGfalx5nHtknwQb2ynB0zmqHBbZBArgP0DnrTE5bAlr0jQ87PUTZDCVLEVPk1n
 72f5XrC6KnvvVfI2TJi6wpz4t1ji4m8uYveaoex5/H/EAcxsNvgmON5aJNXNbSXRm0kL
 l68lOhCjQDet9OA3K1YtgDwAjdTTKjNb44ndvusGCzTauX9QXra9ZenervFfji7XBQrW 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c4xs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IUVKw012246;
        Tue, 3 Jan 2023 19:13:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh58q0g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBz8r5XOsvWRBbhcyNKYI6WGPS6wbpJgmE8TRyWlTSchasMfNU4HiNx55HhNPeNgH2QYLoxqSAZ2E2FDU2CQ/2zbURUQhantW7mD/RXAjAyoF8QbgLfSZVvvQGaF/7EeLn/mh6dyOp6Nv8/TJ+pnIWtYsTojcjfv74B50isuBqXfFO7KzNwQ4XiBoEX1uxEnstJVE1tEn9PQz2Isf8wjPY/42HAH3Z14nheTev4/6FWvokIJrqnIdchCmK2sc63nLN3ISmG0cHANR1/7Loe7LNWcW1ql5GAl+0hJDntBH/nrv8mr1kjw6wSz37mzqZWd6wtmzpJutsel8yPZwjsz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo1RxbKBNEh+3O3z+QHKut+Np6Q7TabFfVnFvfxT3m4=;
 b=CX4AnSOa7XIvc97s5UsIcCXj7htdIwNhas3RSZpar0WcqQhND5Ns1UTCWkCCxIK7pjfidbMDqYu56fD84JOhldUssKek3ClRNiqSIQJmeCrkKOm/u+BetcCvyMuvyymeJ1JnC7GlnXMqpgMWJkRKW9CpTl8fAUYdXGpooETpWXQvpxypcJ/cbEf4VAEpkZdz7J7xpXf+IlRdMjvc5NuITMHESd3aTmon1VCKQcKbVCOKwbc4WNgejOp8Sjgkt7Pn/xZfKSKIi4De262PbCaqL50WcwvEBRAuYe5PZWo+7MaVkzlHWo6VpFmX8WTMJCiFT1XHNP4QOucRx+K8fjJUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo1RxbKBNEh+3O3z+QHKut+Np6Q7TabFfVnFvfxT3m4=;
 b=pxhrLbbGlZRfYfNSKfvUASqptX/FqYGAFnEDf09etDxW+fQHfsK/IdsTUWSKuW5JGP8U9WjUfAfOTVXKhriCx0Lzuhwk5g1i9br0HhyMi7n8icj494STgwrgCqOxtobONIWpjmY0e0dFceiQpRxAytILfPS9RND/uxT4kbgJPMc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 5/8] mm/hugetlb: increase use of folios in alloc_huge_page()
Date:   Tue,  3 Jan 2023 13:13:37 -0600
Message-Id: <20230103191340.116536-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0031.namprd14.prod.outlook.com
 (2603:10b6:610:56::11) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3946b8-6bd2-4c01-0d07-08daedbea677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhReCw9s5ezZvLdsxIolhaozI35mfBrm/mrKXao66fkL6i73M0L9L6D84oCR5YrJzEeb7Y4tNyYq/ldKXqyaqdftL0Xe3+S/VAS/3lgJUMIu25vSXq+unsn5m7p02FpZ++/horuDmCidIzXYEGWQfEnHvUiS/Hq7NIEh19erW/7W8WHflVf2Krm1+R4ObiGdIzPpAgvglXd+D9u1Oz8LNnGcVa/loWGEqOCTE1hQoGciJkYyWIsZe2G83AA5mXGLx08/36iQn4XuW5tO99qeVkYsFoaOfI8tQ9ARmr+5H2D1QYZQjJGYZnfBtkC0U2aD1YFFXJkLOYZhZLEem3a8ZKisAG6D6v9TNjkL5sch2M98Em1miWKfZMaRf5ZYkyR95sNQ7wy8gTEcXXSiqY+a92JGhoNaOXJXxlLZww4dLKNNJtE2F39/7iv3aKucQb0slnGmrkU6Vl0fST1yL3IGVI+MyuoYhi8dJQKIa8nXJbMJr8Udg/E6/6xqtL5lIlWZJ6/NPHT9KBZPKqOZte2Ps2P410iU2GI5n3iSrfvA5iLQ2dBHZhHb18b8t9ppYBHVLYI9K7dkuVzM0v3nr/8Uyzb827oNb2G+0CjP2fWU7gZwdgxRvYCDwssjhNDBDd8F1+Wciw9H98rUyF3qFD07hT3ydfbkxSqAKjShXHVJNregjC3iZDDloD1v7/Co5wDAvtqzb0EmZvFugZvYl4hczQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(66946007)(66556008)(6486002)(107886003)(26005)(6512007)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(86362001)(36756003)(22166006)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p44pkhzxN1SggM40PiTwDBnSD1cuMwULZSJdu85vGB1tORZKC4BLUpyaAKGv?=
 =?us-ascii?Q?vzZ7d2oJjHYp9E5v7EpJlJktbQtSGpVuZCCTcq3nQMf2CZNI+1oHoFHzgPGC?=
 =?us-ascii?Q?9h7BP5OICnLB3JemqVyNyrpH3h6JT8ZNwoQ+3X/s3INPCSUPDNSJMF62t0AY?=
 =?us-ascii?Q?MY1098z1e8K1TOY9+4ZO5e7p6NG9ZullhcyiN658w3cEuQpm3x3ZBI6PlwCU?=
 =?us-ascii?Q?Sj4ir5TTQow88LZE3ZeYUMwQDeDESaM4VVwKkP55PheV3IJBNvQ2rpFd+osB?=
 =?us-ascii?Q?O2i3FrrE+pFVW4ALbMae3CHrmMbCjR8gSXPDBkOw+g6R7H6MdskiOZW2+j+S?=
 =?us-ascii?Q?ynbJpBahw7UTNVRVkYWj53D+WIc50o7j4BPVyUpCK9rP7r2tpLuSE4SK57QX?=
 =?us-ascii?Q?b+GholfeT19Mv3XABfkYAANxXHVYwNDDI++Bvm4Jmxw37han2Wl1AdUb4OuN?=
 =?us-ascii?Q?6o8i39mX8ZMdSNGydzII1kV50xXnC1bTKwhQEadfWICM6ZrdkRyLyinu+NxQ?=
 =?us-ascii?Q?9UP8105UDKhpdlfhw/tENOKOPu/+UEUrLj2cBDlsgV2U11+rG6lJBmDCNfWe?=
 =?us-ascii?Q?mCYaYiUTD0aZEGZcMNTJ5Mk1rxhuP/LKLwOiUDiSP0BJ3qVyQbjRdIgF4KKh?=
 =?us-ascii?Q?inmYOoPOjMzCgz/VOPghPFGr4/6GdIIpmw9Xlw9jEeJt9J0ZMBtDSDJIYTTF?=
 =?us-ascii?Q?93CYhBntxjAYkh32JJxM6gEgruOcSC47a1Fod++11Mx/gyGuxNYS8yVnV3AM?=
 =?us-ascii?Q?sr3msDNoq6h9hRfPTFsg8LJF457SmPchRhXqD2Wf9pdNEZ/1qBvRo7R1ib2n?=
 =?us-ascii?Q?ubSRb1B09+TiNIn5bTwV+yleZm9rtVFTSwMb11Y1VjtEeWR3J6UYTVTrKtNX?=
 =?us-ascii?Q?BtDSAR65pyngHhU+Ao3cH23UzYG6KUCPbT/XExP8nzWoOZH+LfvmEumZRvjZ?=
 =?us-ascii?Q?dUFS4W4rclv3i+IE4tbqMYh3hObDsD9KM08slppOIHLk3sK1vl2EBxMO5fSW?=
 =?us-ascii?Q?HKwWk8atZSmFBd4e8XbiqznudnnuCjClwZm5L6q7ToCYg7H+o2LeLjljUdw9?=
 =?us-ascii?Q?0JB5UkYh8n0MpXeySnditJ7uXQhGQDJP5Mq869ezKw5RL+fWqN7qY5CODuyM?=
 =?us-ascii?Q?lHPXbpdemMMoPv8QLVyle7bYjtVVWpsP+ieJfuiGibjDsQCvwW/CzytOOm6a?=
 =?us-ascii?Q?i5mPn8qw7hdN8MaRsrqOz9ehgaaA3BmjZz3LcMG+rzapMscrli8RPRul7s4A?=
 =?us-ascii?Q?TYPQiy1Syy4KGglkeC3sEoHIlrTpNH8Wn2mfuBYi7j/ruQ4yWRqcFGLDLxiR?=
 =?us-ascii?Q?kSlOrwUKwAnNk3/Ob8xeCpZs21VyNsoYhE3m02nDKpt0I9zi1tO02a8jHcsE?=
 =?us-ascii?Q?zLU2QKhGYArnMHjj1Z/LnCdRl6nbkBMdZvhihpoqfQJ3ecYOlrCAK3YZ05uh?=
 =?us-ascii?Q?cZQilezylAgJB9E4TVgCyxQXIuk13B1asrFcIpjNha00rmFZrvaoPTFbMlhQ?=
 =?us-ascii?Q?gCSe2EQjlwmZ059/WrPUXjdpRF3M8gI4s/TYBDbFMPoxF+t5TyaKhw0LaPKV?=
 =?us-ascii?Q?vQLikvzERiYTNLxNGqHb3yrTj12D5pDjixJMIHGpwrtDlEpJRa/xpRrsgnq1?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9aYZFL/aLImMLvnYu0TlhU46S/HDXpneVc93wHMqIB6KMFnNnMi+fc3ffRel?=
 =?us-ascii?Q?eQXcesfPAd5OjTOnUS+qOP043zFOjlWMc+3imb3hTMQKMzkJ9C7aG4aWPd1F?=
 =?us-ascii?Q?8oqKedDpF8tEqxjbGb48x93983C5vFOyJB0usHiaPvz/aFe05t72G8E1jjti?=
 =?us-ascii?Q?sD9k7qIE5uTT2iITa7h7bDxTT1CIv+T+OBDW5ypObyyw9RNuPMy1xbH3WBn+?=
 =?us-ascii?Q?OVkEra6BkYGLU+8NHNa0ZYjNdE5rqF05K3YGth1C+G4JDNl+8pT9LPzVOCVo?=
 =?us-ascii?Q?AP4YX0NYj2MQkJM9X/1ZHX8OtgxB83w//mkjNunaKPzyamBgifSZseUMpYof?=
 =?us-ascii?Q?l6UApXpXwry46JJSgT8QE24FncVDPKFP+w9nbWCbJxvYhjL4A6bn1uALA0Qz?=
 =?us-ascii?Q?WBQJLKdaZe0oSqbc0yO6quTfIhuIQw9SzSffDVDvfN6YyfbL1/Sqaq0sOFoE?=
 =?us-ascii?Q?7QGYnGYxRPqTHPZQJtRc38bRXWLpVkiZZs0DHFl71cd7QSfVBFZdyMVYEkWv?=
 =?us-ascii?Q?/WKhAx4QGsre2XGgrU69X7H7TOblrabfjoWDCot24AOzvT1dXnVADNrnikGy?=
 =?us-ascii?Q?P+xuZXmSfBOjH+YSVSH6a1/VgpX3vkaD2xXMogjg7RJtmaO0P5dECSts2Igr?=
 =?us-ascii?Q?YVuZsjvx+PpOSLydTVRTosgd2teAJAfyZ1LaBerVOwpjz9w4We5OwlJLuVmX?=
 =?us-ascii?Q?rP96nfFYt0cZBMZAhOKuu3RLdPxgVg88RyiDOW5EKawYwETl30wHMurc6ssc?=
 =?us-ascii?Q?GcJbh4p2xBwFjy7GisB8Q6dQp4zwrLb0mo3G+Ubsp6NgEyRMPaQdnowkB9KX?=
 =?us-ascii?Q?GVtX8+kh8Wc68+ueQcVnlC44Rk0S0+NEzSH6BgK00IpZaXcZHraCjuAyLnr2?=
 =?us-ascii?Q?JkSPPRJGoZrvm4SoEPyy5036S6wsYKtj0tDoczGUw2EtYLZLzs03ThVt9ivA?=
 =?us-ascii?Q?rS1Jpw/F6oV27xdFrjn6LNyzjHl8idIr6KoTKvZ8kC0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3946b8-6bd2-4c01-0d07-08daedbea677
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:52.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCtTFH7vMUgnmsjRP03YgQ37ycFTm9KUbX4lujzgGnkEz3g2DHgWb26VKQsO1BvLl1KMWtBnasDi6GNf/KmVe+MxsRt8DwYpD9KIDq7SkOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030165
X-Proofpoint-GUID: 9MEElmUQz69Ond2Ika5OLrbEwv-YixEP
X-Proofpoint-ORIG-GUID: 9MEElmUQz69Ond2Ika5OLrbEwv-YixEP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hugetlb_cgroup_commit_charge{,_rsvd}(), dequeue_huge_page_vma()
and alloc_buddy_huge_page_with_mpol() to use folios so alloc_huge_page()
is cleaned by operating on folios until its return.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb_cgroup.h |  8 ++++----
 mm/hugetlb.c                   | 33 ++++++++++++++++-----------------
 mm/hugetlb_cgroup.c            |  8 ++------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index f706626a8063..3d82d91f49ac 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -141,10 +141,10 @@ extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
 					     struct hugetlb_cgroup **ptr);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
-					 struct page *page);
+					 struct folio *folio);
 extern void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 					      struct hugetlb_cgroup *h_cg,
-					      struct page *page);
+					      struct folio *folio);
 extern void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
 					 struct folio *folio);
 extern void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long nr_pages,
@@ -230,14 +230,14 @@ static inline int hugetlb_cgroup_charge_cgroup_rsvd(int idx,
 
 static inline void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 						struct hugetlb_cgroup *h_cg,
-						struct page *page)
+						struct folio *folio)
 {
 }
 
 static inline void
 hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+				  struct folio *folio)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0b8bab52bc7e..640ca4eaccf2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1209,7 +1209,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
-static struct page *dequeue_huge_page_vma(struct hstate *h,
+static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
 				unsigned long address, int avoid_reserve,
 				long chg)
@@ -1253,7 +1253,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	}
 
 	mpol_cond_put(mpol);
-	return &folio->page;
+	return folio;
 
 err:
 	return NULL;
@@ -2305,7 +2305,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
  * Use the VMA's mpolicy to allocate a huge page from the buddy.
  */
 static
-struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
+struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
 	struct folio *folio = NULL;
@@ -2328,7 +2328,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	if (!folio)
 		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
-	return &folio->page;
+	return folio;
 }
 
 /* page migration callback function */
@@ -2877,7 +2877,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
-	struct page *page;
 	struct folio *folio;
 	long map_chg, map_commit;
 	long gbl_chg;
@@ -2941,34 +2940,34 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
-	if (!page) {
+	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
-		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
-		if (!page)
+		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
+		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
-			SetHPageRestoreReserve(page);
+			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
-		list_add(&page->lru, &h->hugepage_activelist);
-		set_page_refcounted(page);
+		list_add(&folio->lru, &h->hugepage_activelist);
+		folio_ref_unfreeze(folio, 1);
 		/* Fall through */
 	}
-	folio = page_folio(page);
-	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
+
+	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
 	/* If allocation is not consuming a reservation, also store the
 	 * hugetlb_cgroup pointer on the page.
 	 */
 	if (deferred_reserve) {
 		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
-						  h_cg, page);
+						  h_cg, folio);
 	}
 
 	spin_unlock_irq(&hugetlb_lock);
 
-	hugetlb_set_page_subpool(page, spool);
+	hugetlb_set_folio_subpool(folio, spool);
 
 	map_commit = vma_commit_reservation(h, vma, addr);
 	if (unlikely(map_chg > map_commit)) {
@@ -2989,7 +2988,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
 	}
-	return page;
+	return &folio->page;
 
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index d9e4425d81ac..dedd2edb076e 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -331,19 +331,15 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 
 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+				  struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, false);
 }
 
 void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 				       struct hugetlb_cgroup *h_cg,
-				       struct page *page)
+				       struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, true);
 }
 
-- 
2.39.0

