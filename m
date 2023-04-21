Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399F16EAC22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjDUN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjDUN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:56:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83E5C17D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:56:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCYa7w020032;
        Fri, 21 Apr 2023 13:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4dop6dLB8MYyf4g70fGvheMGvbOaLIxIGFq/jpCiG4o=;
 b=gNR78VCFUDTX0OeN69aV7mcYIYoQaRbwqP88Vz/EJr3t0qY1EmhE5uFiXm81YCHd7SKA
 hzVgkSXa4V3MRZcBz67ITiYic1z5GjhrQLkZ8jBdWe4CMsRA49noOtCSvJ5g9DNqOy5N
 bEwDhyvPEUe4VZYzy2PKaT8OIJlWdtdLUywWawXSpRJ3fLdbOzCrJxQMcRhUOzccG6a5
 q7i50neae2P4TAs3qb37YpWdPRlESRZxkVceFv1hyGLX8oJvTbF8nwy4+TOFzzdCZrjg
 x29Djglga+LdZzSYlIbIFZLmVMuObNquo7NkfL4Y6ld3hUDyO3evIaKd2MoBIA7OaCV6 Zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q07694b6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33LD1gQR011183;
        Fri, 21 Apr 2023 13:56:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc95yyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHIQYEKdDQnxPTYruqI1J/WOUwJZhG6iKvD91W3Cblwvpkxi04UTQKFxtaJ2mKL9fd1hTNzdRfHYovl4lbfCkYGr8oBinrwqyPeraFv3qWCFOTLiYPqwcpPacl8E1mEb7rMu/SPX/n3ge0lMUw2/FHPaEwS3crw22IB2zHsNMxJq78M1eCR56SBlPZ/tTbfXLRmixYUhxlgHGOjyQK8dzeWRDCjEmjCE9L1RhAZDPPaECZHOZ8wC1mE1tVPvM6veA+/Lf7+w8x+qju2spK77Cs+z56Ba4HWj+aGcdRVBUE+BTJJaFEgLFk1nE1P9UyqIRdgGK6QmiDOuINNNeDNWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dop6dLB8MYyf4g70fGvheMGvbOaLIxIGFq/jpCiG4o=;
 b=EII0hIeePQQnbPWXwf9MZbE0eHMc12nBfffAtTJH/2edsUZ0Ijxsvn97b27bJWJ8JlDdzbe4yqC2uEq2mSU4y7xxWriYpMMv/xGEnY0vRI4ObYksluUNDpUBg02JhJ/CX/leURY1SwzPhe25QUbSmXvmqThfk88Mesy9VCsFfAyisAgYGZIZg/lVMNAGJ9h7cnh8M//mQ4f8x/ytmNDlqOxn1p374CwVxrKgdEu6jMelgrcB4D6egjY0P8vGabVxIu3lrRiRXaX64UAjNZXGkUhIzlVByajXL2s4wj76+4p83zvy+pV9zI8nXumKvX7IyX7bUZFtGzGn4aS95sobfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dop6dLB8MYyf4g70fGvheMGvbOaLIxIGFq/jpCiG4o=;
 b=uGsxpXlyYASWhEySlxJPe276DbWwNG9OB684MPohBRtUPk4zrzjr2oXMSMpFftn+WIY/2jm73edY8B38581D0nIhWWhhbYxZWzIQi9sbIRTr5gCzNEv+d8O3sI4xn84E/sHXNekUXxb+U4+xfnqGjVURBocjbogbPo/eviRGXss=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:56:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:56:29 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 4/4] mm/mmap: Regression fix for unmapped_area{_topdown}
Date:   Fri, 21 Apr 2023 09:55:59 -0400
Message-Id: <20230421135559.2163923-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
References: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d41b251-c89b-4664-8e3f-08db427034bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbelP2/xAScKNfyCJL/cTEHLD/j6FeLCPHZ1Vt5NOwnK6vgR8JK5DDXpjmj2yxrDm3tGMG2OQpvairm7ksUihCs/fyFYYz17iimbPEhdU9V80qrNXUkG46D/+jCdMFRJgYTnXShtv5y8gZ0ad/Uf/rK9oWMTf5JlHaYJqkKzg3H1eH0zOFYVcMvXoPAVnjWF/hNYHm3I/gepmL2MKSVBr7x45ltZ5rg1Fp5ix4uPDdqRTt/Ug4EkGqP1UOm1t3xisSyFEM3zgj2IJA5XRGI7aGjxMm+hSmPuJXP+aqem9AU41XYL3eQkoSDXmbY2qe/LLL4UxmuzLf804I7F5bzQ9kdHnt0ubOWGkraPPrFqksnwnIfsbWhfbTfeYYJ9m+uDJap/Nhg2R9aF0QAFQsLAj0rzhyzkfWrKI1FYjEHO+By+vStLFKq3W2xFJViuKf9kGj9vLz0ZGryYy5g7FZt4Mc0GT7UhfkoB2PhgsAoUphhGvrZQRM6PSYEJKOv+iop7NuaDGyY8ZZMOycdKVavlNhVoup5v6lkgEOtzId/J2APJZI6NLjYKJNdzvzRzIzfT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(8676002)(8936002)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(41300700001)(316002)(2906002)(5660300002)(186003)(107886003)(86362001)(1076003)(6506007)(26005)(6512007)(36756003)(83380400001)(2616005)(54906003)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xf2EEHAKkKcyFL6VvhCvXu3LIygxsivqawq/cpR9YL8kXWIDCNh4k3i7TT8?=
 =?us-ascii?Q?oYc8jyneOYlVUkQhWvnr09CjCY34Q5KV2A54Z6/NQ1bT6jt7EU/sXVCegAz9?=
 =?us-ascii?Q?cxNawGb7J85tHOI6yKhnqq0h1CGDllQNa7aWb5SW7WKTxQb24dhQwJZjIK4U?=
 =?us-ascii?Q?ZZWnaxnxTaucJvca9ULFEYt30OVMdLNeQ1iPlF1n+5xzwGwe9Pr5Wpzu8jxP?=
 =?us-ascii?Q?r7n6wqXLuhzCReUwOKWrfvx/y4i4lAP//v+a67ov95DMl6LQR5DQedPsmERN?=
 =?us-ascii?Q?dmMLmNEwKGX/bDTLQU+A+hL9R6vB5Q4mJm3Bgiv4GCLVXDqpakZyYAyeftFJ?=
 =?us-ascii?Q?vaxPt/HtapwsbOPtlIR3Y1XNFO8hSay1MTAUojrjXmulIeTcOYx0qcC2gDk1?=
 =?us-ascii?Q?2tH9H5uRWuURLRHNDzv2CwGG5XVv4v3y6Iebj3J60FJb60FFXH4bO894fJcv?=
 =?us-ascii?Q?gUbAvlnQCSda0b1+mlpL9RNfeq7OUM829y4HYY/E4Dw/nEkM66RpXcQrIsQy?=
 =?us-ascii?Q?5XYfmdHkbdDzz7k8QHpjTNS7aYPlYCnzi48Yijzm4UpCtKnXpEeNeVr61Ud5?=
 =?us-ascii?Q?He3YIS96FCPzis1e6/kE4IhUW8d7IkJryc5fYD6yWL2LByzP7ebthw+aDe5Z?=
 =?us-ascii?Q?8iXtALEAEtIqcborzIckmbM7PAj4281cQJK5NrHpUvj0l6nuqaADT4VZpaNQ?=
 =?us-ascii?Q?H7KpMblmMKdkAZVD8QpYbjQ7TQgMt5vZVJUxe13/b9IXhYcxBz0d1xv+tY8P?=
 =?us-ascii?Q?Pe8DVPoCy3WChTSqY7l+KngZ6GukxoNBPfZEc0rxPPHFGiDKUXL0IJ5WiAAd?=
 =?us-ascii?Q?wc0w/D0QhYCqpLVr4wxOf8da0AXsraNCspyqQmPAUNrFFV/ulPJ5QjaHA0De?=
 =?us-ascii?Q?TYPADLRCQyuJ2DUhzJ73rnGMO9yxYoToJxKNtht2HZ34p7K1DEr46sb4CuIj?=
 =?us-ascii?Q?Avp48cTjn5ocsR1GhYn6QggN4Z2pFwLIhZkXPVUUGMzA9r41Q1ODOf1Q7ayt?=
 =?us-ascii?Q?vknzDzKOoRH3ZrRSvRLr4z05Udv1TIIMgi4j3nKkeLLWDRU/xUQZyDQ1pYeb?=
 =?us-ascii?Q?vib5PR4/0pCaPa2CPO74BjN30aRsdJRdqFBSw3zRXZjwtP+Uck5TguDmF8Cm?=
 =?us-ascii?Q?twh5rGZCFwSKVBTmL6U/0CnzGPA9ByQHLjAh91MliZpbri1X6zLFnrwY1Ji4?=
 =?us-ascii?Q?dRtLwph/izcOz8aLF2INyF1t49p9/aXxOIpyjgBHnErd5wvkatZg8BFA3WYL?=
 =?us-ascii?Q?EjSU0jQaJ/G9N2kLrJg3Dmmo5smQOBnkR15hGghOruGuMdA9/GkbaPf7uYcI?=
 =?us-ascii?Q?aqPJiKrCHWaz4c4+Vva+O/jaVNoFvcVs/nxLITInWC2PBDQfOQ46tSeUTlDD?=
 =?us-ascii?Q?tEGQx1dwFYh46jYjstaDB9581kXTLrj7IJjSzFr+RvJzjW1zvH9D6qbuMuY9?=
 =?us-ascii?Q?FqvcP+m2jr53Y5Ybydh5Clv7RpMWvH+Pu5yIX1/RVGhtpNO7MQ9+zdIsVCIZ?=
 =?us-ascii?Q?QRabMjPK0vBaIEF0WbBB3PEUfj/OT0RZyuU+K0lBT6Bg5TGubBhRhDARG6RF?=
 =?us-ascii?Q?TLwd01N2B3wZyl8+FHTdsxiaaIqYS1HTfabFwQyz97coH22CZz7PCwzYw+KZ?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Zh1FYSJKgItUH5VtdAHgGCRp5eeFpdnkrOCUI55GF7rv8/OBxgJiaF98KKht?=
 =?us-ascii?Q?+4TJ4xW6mhohRFI7Kvnn3lO4g71MOJOud27VOZnsz9fn8y1XgT4MS97gfJ7U?=
 =?us-ascii?Q?Sk8ke0xxWF9YZXd0VVD05ApIEqSCBE4djezsj4wXeeb4OhDi8fhI3olbxjCD?=
 =?us-ascii?Q?P9UeGrP50LVRx2E1QF4a7vcU/WO8/Dlsm61gvUaFsX0beonYpHnnwRLpKiFu?=
 =?us-ascii?Q?ZUNoaYKPmsnNQDi1JBJ72Qh+Wkdf9N4Ui8xz00upfO5DV3EecoQr0mS5QdBu?=
 =?us-ascii?Q?9HRWdPVM5B+cxSQZwjYYAvxZWc22jWqmC9rpv9BWucstU7emtVDIvCksuS02?=
 =?us-ascii?Q?JMr+HiKFnHyT0KsZZbi1C1ao0GxBD0waQAlPYx9c3XoEcp+nMNV7AcDLnZYQ?=
 =?us-ascii?Q?WRvqJXLT0GJ3x9IwUTzAFis92gSO50AGvN3uithWsv4oFoAgs6Kp88Vi+xNU?=
 =?us-ascii?Q?2dmK0gQNcwIPilQL7/h32B20+1qSEzDUsuBw5LgP9941OPsl6IKNxkdjokL2?=
 =?us-ascii?Q?vMh0Dv4lpPfcHuhw/efwX0JvZ/dVswmJbDNfrNSgLvXg1GIKhQObSxUjxqUP?=
 =?us-ascii?Q?0gQ0j8GFw9Q5Js1s+dJ5CN154XhPYTAInt8Bmnat4oKfB+LwVbJHPDBWz1K9?=
 =?us-ascii?Q?KCR2nBftLXSuVLuN75KwFLjO7BVkQW9D0JfIPHKDZMk85W7dh5G5VjU9Mccg?=
 =?us-ascii?Q?XcreNXaVnLgG2gIOBHhmM/sSPDuTIm/87hslduk0Z16oFqY8EerNN8/VAOw0?=
 =?us-ascii?Q?AWiqh3a5pF5dbVAvNfyyTMLuteks+UhQLKQtD5mTwi56XA57N7MRT3qwz+7u?=
 =?us-ascii?Q?BQsoHpcW5A2228ZgUQLhamqCS/fmL8ml5S3UDy+ILaCrMsCbhB1vVZIW7Y8T?=
 =?us-ascii?Q?nYfqoaMqtOQaMh2bnFJFOd/4bpdVjJHH0oWgZlq0Z6B+uGkEvQEpihguc0D0?=
 =?us-ascii?Q?zwUgRDGglIOx2+6cBGRgUQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d41b251-c89b-4664-8e3f-08db427034bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 13:56:29.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccnuV/UOcaj9DJwG6WZn4YbFHka1OQWFmsU6UgeSXyQH3mjBvxDm0PHxR6WjXzVXDRjSz4akjjEIh8O4+XS5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210121
X-Proofpoint-ORIG-GUID: IjrZg72Bv0EJyEfyIsajhwMHlzOWjOZj
X-Proofpoint-GUID: IjrZg72Bv0EJyEfyIsajhwMHlzOWjOZj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree limits the gap returned to a window that specifically
fits what was asked.  This may not be optimal in the case of switching
search directions or a gap that does not satisfy the requested space for
other reasons.  Fix the search by retrying the operation and limiting
the search window in the rare occasion that a conflict occurs.

Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Fixes: 3499a13168da ("mm/mmap: use maple tree for unmapped_area{_topdown}")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 055fbd5ed762f..6b9116f1c3049 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1548,7 +1548,8 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
  */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap;
+	unsigned long length, gap, low_limit;
+	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
@@ -1557,12 +1558,29 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
-	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-				  length))
+	low_limit = info->low_limit;
+retry:
+	if (mas_empty_area(&mas, low_limit, info->high_limit - 1, length))
 		return -ENOMEM;
 
 	gap = mas.index;
 	gap += (info->align_offset - gap) & info->align_mask;
+	tmp = mas_next(&mas, ULONG_MAX);
+	if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) { /* Avoid prev check if possible */
+		if (vm_start_gap(tmp) < gap + length - 1) {
+			low_limit = tmp->vm_end;
+			mas_reset(&mas);
+			goto retry;
+		}
+	} else {
+		tmp = mas_prev(&mas, 0);
+		if (tmp && vm_end_gap(tmp) > gap) {
+			low_limit = vm_end_gap(tmp);
+			mas_reset(&mas);
+			goto retry;
+		}
+	}
+
 	return gap;
 }
 
@@ -1578,7 +1596,8 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
  */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap;
+	unsigned long length, gap, high_limit, gap_end;
+	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
@@ -1586,12 +1605,31 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
-	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+	high_limit = info->high_limit;
+retry:
+	if (mas_empty_area_rev(&mas, info->low_limit, high_limit - 1,
 				length))
 		return -ENOMEM;
 
 	gap = mas.last + 1 - info->length;
 	gap -= (gap - info->align_offset) & info->align_mask;
+	gap_end = mas.last;
+	tmp = mas_next(&mas, ULONG_MAX);
+	if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) { /* Avoid prev check if possible */
+		if (vm_start_gap(tmp) <= gap_end) {
+			high_limit = vm_start_gap(tmp);
+			mas_reset(&mas);
+			goto retry;
+		}
+	} else {
+		tmp = mas_prev(&mas, 0);
+		if (tmp && vm_end_gap(tmp) > gap) {
+			high_limit = tmp->vm_start;
+			mas_reset(&mas);
+			goto retry;
+		}
+	}
+
 	return gap;
 }
 
-- 
2.39.2

