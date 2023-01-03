Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E41365C781
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbjACT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjACT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:26:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6131274C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:25:10 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JENlj029395;
        Tue, 3 Jan 2023 19:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=sf5wmtWj4PEDdggWTBTOQXRWpGJnVplrOh69E/0Yj+g=;
 b=uUwE9FV9J6jCPXK3Q3P7YPAj2FX75DQUJvb8hFTykPeFWcYRw3SLPAo7ceqfpserxx5s
 UCjbIgxF00EmNnGUG9ODzYroyFkKJOJ4nuRoAIwp3qEFFdi6LxWP2Zy7FQU4dLC3O5AF
 DELZRXGYhc0gNz7DeJsrhdVNyZyK/dBC3mz65kbB7ZWs3J0Y/P6XI2o4NqXGP8wmKEbi
 MZULRwhkCgGZ/JJcLqpiceQ7MNhhfgH5UH2fkgtPsRrLDqFHf7ISMKvUhjIDAOina3LS
 U1ow2Q8Q/i46yXr7+s+qCGR1GpVI3Jhft+MtKdeh42ZgwaTWT4YVXfz0IHW93gZZFeMM xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya4uhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:24:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IOQn2014591;
        Tue, 3 Jan 2023 19:24:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbhbj8f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9zSAFCLLscQLT7WAi9N//MkI1CG097Owj5MQoffbg4f2dFSp7/iuWj0I5OlCcYFpvultvUHNaDBdQMAxILN+uu7NQnVChq6mEv5u+BLSqBuQRSvXxZAYhA/cZd5BUBuLf+RT5C5edtuBmoaRSb+ngjnXQXzn56+cSutwg/5ac6pYRpgtIhVFBYzrBEKs7o/DpF9wB35tfKlrdIu7vAdV/MQrKg5jKj/00DwBKl0Ibhkzs62i5K/yXbNCIwZkOdpidXPN6QyjpKXQYL0pPOL3a+oTGQF0ViLuN3fjMf/LnvT9C7fMifjHr/8bLc5Vkj6x1P33oUyhvAzkCw90YO1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf5wmtWj4PEDdggWTBTOQXRWpGJnVplrOh69E/0Yj+g=;
 b=bkEth8YNvbDB8SWs8H/p1wYRyBNTX58GB8XRbfZbLFQ6KQsYr6TNF2abkBH5GyVPKcHXj5YY1fradBCW7euk7+5HPneZEItNScUuIudguoLchrygClxnIMRH0GxjRJlAugGniJVv9qhh+s7cqg7gLjI35UrIMz8nM83JKZlEHatmp+sO4ift7Xt0UrbYP/74BEAXkMbXlRfuYs7RVL2gA8DH2KBw1zsd18g3axBhrT7TJ58wS1qQczFP1KDSmDdWTLtjH9+o1UX7vXpWUmir2Ovfnz2lpjm8FuPyHh4WkWHP7DrrwJINppzT1pLgPfYLkWm73dJ0HilebG/TBFG42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf5wmtWj4PEDdggWTBTOQXRWpGJnVplrOh69E/0Yj+g=;
 b=iLrQF10f+mFYgNcOOssnY9Yq7Ney41kx8emm+X0eYJwMqYVE7ECu0coufRw380yANk+1OHEOnVEXaYOo1wzJhmaacdg2EasRET85VNf4BvZzgWPXE4vccbetyw0SHw6a2vn3g96dME0ODmWRiunC1b9NocLmFu7Kn5aZ/Q1Hj9M=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4739.namprd10.prod.outlook.com (2603:10b6:303:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:24:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:24:37 +0000
Date:   Tue, 3 Jan 2023 11:24:35 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
Message-ID: <Y7SA839SDcpf+Ll0@monkey>
References: <20230101230042.244286-1-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101230042.244286-1-jthoughton@google.com>
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4739:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7e7b13-79a7-415a-54fc-08daedc02726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+eDizPPUCOHVdCsu8LNZR3uXjbaLCm1ntVXtxMF/7JvgHtvx+0BOUJgBcc7z5Yt7cB2y8b7jPn2uZlssK1+bDGRM1/YJyTn8G+A9+6V8NgKVsZsRl/YFm9tRNoMnwktnwKsifs0LSzVagU4ovJr38HWMd+cbbgJMqS4fxY2s4F874ySeuNgLdnt1QYX8XJKiI49uKL2/SvdAmghnozBH2EJu4lGko6u8AEpMtFVMXfXzN8HLaKrEknxVPhlqZdqzxS26d2lyEFAbzepy5chMM1rwqKbABNtxOmLYGd0Bhqoh3a2qG+vAvTt8vbrmhEJQx2sojtmHqg6CdyzD8ECT1irxrBNnrZc/dsi3YIzLjP5O5LRiUZ8GdatRoTcuhxNr8H81XBltL8koBF8V4bkffdg7OT+fiGS2IygzIXmfSKLFE9/afgq0RRsg1dcA2riUqyCW2fpKERRNb87x+luqQLGPIAMD4Z2L8Hb5KPoP4MzPTj9S+l5lz+LO3O/bcBHnzX4igz0++88LPj7FmCUlHuJTz+T2R3uZSEPXV2C9LMzx7ENDilAxTx94UBOsHr9EiF+ivzTbB+oPhCILCpLEg366mXaxHiYiQL1AnbabyYNzi5VjokwdiXtwUzDZ5E/EItkxIsMaTh5aEPfMUb9eg267SeBcMV0oDhQXA9Vw8JWD+5mCSF9dkgYhk/ji0XDwuc0subLjv/1hEMYcqtZKda8fpxj2xBKF8IcxSa7O0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(83380400001)(9686003)(6512007)(186003)(26005)(53546011)(33716001)(6506007)(86362001)(38100700002)(4326008)(8676002)(41300700001)(66899015)(2906002)(5660300002)(8936002)(44832011)(6486002)(66556008)(316002)(478600001)(66946007)(6916009)(66476007)(54906003)(22166006)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5x25IKO3bB+sZpXNaubY/3SiRZB9SiUZeUcKLvXaiRACo6OF/Otl41Wx//zq?=
 =?us-ascii?Q?RveFMYObQLhCjtDXdmO+/Ak7zyL7FdeYfNxrJG5kKXTAp6cgKFdXahVcASuU?=
 =?us-ascii?Q?PVVna6D77rtopdhmQ4vsDnyOYxzxChTeib6S9gb89yXlhyBL7U4VdAY4qP1N?=
 =?us-ascii?Q?ZULldBY2O4qxVIzLmw3HpHOpEKr/KR/AOCu5EPxOz4e/SxeTk+fDpm3qX3Kw?=
 =?us-ascii?Q?TDmrjJZSRz4L+Ne/5R+Ekft6LxAK+1hu/Ckbcmck8okk6Fpyj0xMsHCX5ipZ?=
 =?us-ascii?Q?zjvWNakA3wkzOOCAtjHq9r7OqgnkdJ77p+Ap8/YN93yDXClj9drD5P10rOug?=
 =?us-ascii?Q?dxgs3uGIKPHBW+c+TbNDpKI60VwwKsxczRvIPGhq4jSkeJk6VMGefTrJAzqe?=
 =?us-ascii?Q?FQuQvzYiXXiNgK+0IXuxgFqpv2hoP12iw6R/iiyAHBXeURh+gI9wlXML/Qsd?=
 =?us-ascii?Q?Dr3/Kwar0YqJDEutQH/E1Ic9cdk6gHRWGV5CVn3i0qP+V0rZqXTl1t4goxrD?=
 =?us-ascii?Q?bS87VfjV37Y24onhCYGaEgsSVr2GgxD4g9bdGi+HKzuiFoxCgjMpc2dllato?=
 =?us-ascii?Q?45nKwF4H4rsfF9yWfEjkOT+6DxAzgHId0J4ENcRR5h1Ao5Ao7whnpdyTbp4F?=
 =?us-ascii?Q?/JXS3JcZkfBDIQnPLuaO9P8649DwRHY45iqTB0kPHtzHla5ZxuYfYmLG/DeD?=
 =?us-ascii?Q?EBF6gWChLqNtrWiiqfp2kYkP26g9IQTYpM4unuN7GTnq3UsDQ6uok9p8Z47f?=
 =?us-ascii?Q?xYm+tJku6QSRHN8ByW7pk63l1f2SbbvL/qJADVLzMKLK/68cDzPy825U9XDZ?=
 =?us-ascii?Q?v4Do6hC8hqoGQUwOh9Z2upN3MvpG+fWksp9gK6VRsMhRtCVGKS9+nfCysE1z?=
 =?us-ascii?Q?CfLCRkkecrejYkZmdV3S5/KAX4kLYvjjpQoJBuaAZbEPzrZrVc2ebu1O0SsU?=
 =?us-ascii?Q?WlxAZ8wlPcBZxJW0seufUBIyySHADcaGIei5vJLHKb6cha2ZLeBwhDcy5qaH?=
 =?us-ascii?Q?pQI+oWsrdoUYIXBSmPzRn+eN/ycLqJhNuQwIjK021zCZg4MYHBNM7Ek9D5sU?=
 =?us-ascii?Q?0jDI4amv/DioO3VRZLrtQCrPA2USQOKsJ+N4IJH1Bl+TFMOm3sfinMApS9Ms?=
 =?us-ascii?Q?BciV550Z3lvy2YUqYem47GRu60/xOmB6q8Y93mhpUDYKhvzNZ1XDmQarQX3B?=
 =?us-ascii?Q?LV7x/Q+BWAIV4m/QYHXsxq8OHWACATQhGDuYfI8NW0aeLsdUUrosOXvHE7Ot?=
 =?us-ascii?Q?ZOBDWymxlF1oXB4X7q0P5VT9vYZGcv43Nq9B1eDGE9OZNlqnFWcuhvQfaqr/?=
 =?us-ascii?Q?FUfBmJhW8Eq2v1fIOeLMsin9n+WlfgAW8bWGCyKk+7s5U+uvLIyOVoCvVDty?=
 =?us-ascii?Q?KZTnrGgZLMvz9+oeu6vnAECsWw71Pb6F536SVsFFGGuaqpnFpEtx8H6o00SU?=
 =?us-ascii?Q?vdElXw/KlFUCHd+2mzPvW4Da/6TTnN1JEjzlTo5bid/xlEJ4gjjc+BX6kKHg?=
 =?us-ascii?Q?bADoLVRX3wRZ+/LOfiIp/kIZqv/BU8KplqjF8sgEAT0qO8sK5bDAEJbOiJGh?=
 =?us-ascii?Q?pz8FvRjsK97ZrO8wzTLYL1zEsOhbLndAv7J7Gy4NSUmlvdmJjBHXtsV5FEYU?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nH7KfxdFcfa1/W2uWzYr9Op30KzyZyv9OGhFdSZeN46ZKND+9o6FTZxBjPXL?=
 =?us-ascii?Q?MPhfdLbqpOhrAm0TOAcnjcu2MrmKF533bpAp/YebPS9GBNdg3Kr2+kTn/o8i?=
 =?us-ascii?Q?qljVssJuBPMK9YMw4BfmLPMe9t9gQS5Pt2p/AIG3c0ZRWtlUWbqp7Fdzynmy?=
 =?us-ascii?Q?VVJBus0oJRKo3BjMZGIOYkLB+2VXbDfSPgkecrYWXxQbXhA3ud/VZCWkC+Kk?=
 =?us-ascii?Q?Y16I+clkkmhkWw1x8jE8HbPqU1zI0UJiQBXIiIVhZReSzvZka859JTT54lOA?=
 =?us-ascii?Q?EdlcmzZ998muAe0pmKhb00yGMIvkxt1lzxgJDaq+kCwamGxXDYAshvRp55/j?=
 =?us-ascii?Q?JrSM/eyWI8ixUr40ugLpO52EaoaDbqdj3EGdTOK6Y9wAc7wJD2yUNXnL9KOJ?=
 =?us-ascii?Q?bzzAcF8fsThAuo56Vo8OvjVf24GweCgZZ4QVzyDTSzPXThS6smZsDLBrsHBV?=
 =?us-ascii?Q?IkuHArfyw65KMYjiboAZ91n6TopWcsHlZEhzvu7M9yPqxMrqZ5ww0fkUreAg?=
 =?us-ascii?Q?xd8hs0aC61IoD1RfGzXLJhJTKeDQPk2EmpaokLYLdUZjfZYdDZKqwmzrIHrC?=
 =?us-ascii?Q?0ULGhwin/mQTvvJODk8MSKG2daymzTdkM1FbHkdqf5YKGcxbNB3Koez3pCL4?=
 =?us-ascii?Q?7cSYq6ebexY70HB4cBwaaFD3BWQAoEpxQJ35xR9/5oGKEZsaS39RFKp86Pdy?=
 =?us-ascii?Q?Wmoy7x0pM57bzbbeFcRYBud9QsuU6fKSi/UGSsFHbmI525CgAZ0Qitrh4j1k?=
 =?us-ascii?Q?IAH1VMf9RG+iFTpIVAwisF8EoWw3ZgEq6utt2EWTlDKIm5P/gj8f4GUBzLxm?=
 =?us-ascii?Q?+2pa6u3CFamTpRi5FpBHTb6J58psmmygz6mxO5ndAGd6rP2WIfCfQZoz1rg5?=
 =?us-ascii?Q?J1ADh8mq7V/B/gCwwI+lYxm33mIdMz3U+U21RrpWq2eg9QDqZxUTBE3AS0SU?=
 =?us-ascii?Q?nKrAeEBctqdcDY+eTNcuhw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7e7b13-79a7-415a-54fc-08daedc02726
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:24:37.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlfD7nF2fsDykgNXnY6eFAggiVxf+boQL7Ty0hh9Kk+d3gRE5OpUjt1Wl+RoZME5J1sQxTp3adyUlLgr+OmHhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030166
X-Proofpoint-ORIG-GUID: 9Zv0CiPqftR5wyNQaqJij6samIajF7gK
X-Proofpoint-GUID: 9Zv0CiPqftR5wyNQaqJij6samIajF7gK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/01/23 23:00, James Houghton wrote:
> PMD sharing can only be done in PUD_SIZE-aligned pieces of VMAs;
> however, it is possible that HugeTLB VMAs are split without unsharing
> the PMDs first.
> 
> In some (most?) cases, this is a non-issue, like userfaultfd_register
> and mprotect, where PMDs are unshared before anything is done. However,
> mbind() and madvise() (like MADV_DONTDUMP) can cause a split without
> unsharing first.

Thanks James.  I am just trying to determine if we may have any issues/bugs/
undesired behavior based on this today.  Consider the cases mentioned above:
mbind - I do not think this would cause any user visible issues.  mbind is
	only dealing with newly allocated pages.  We do not unshare as the
	result of a mbind call today.
madvise(MADV_DONTDUMP) - It looks like this results in a flag (VM_DONTDUMP)
	being set on the vma.  So, I do not believe sharing page tables
	would cause any user visible issue.

One somewhat strange things about two vmas after split sharing a PMD is
that operations on one VMA can impact the other.  For example, suppose
A VMA split via mbind happens.  Then later, mprotect is done on one of
the VMAs in the range that is shared.  That would result in the area being
unshared in both VMAs.  So, the 'other' vma could see minor faults after
the mprotect.

Just curious if you (or anyone) knows of a user visible issue caused by this
today.  Trying to determine if we need a Fixes: tag.

Code changes look fine to me.
-- 
Mike Kravetz

> 
> It might seem ideal to unshare in hugetlb_vm_op_open, but that would
> only unshare PMDs in the new VMA.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b39b74e0591a..bf7a1f628357 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -94,6 +94,8 @@ static int hugetlb_acct_memory(struct hstate *h, long delta);
>  static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
>  static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
>  static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
> +static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end);
>  
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
> @@ -4828,6 +4830,23 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	if (addr & ~(huge_page_mask(hstate_vma(vma))))
>  		return -EINVAL;
> +
> +	/* We require PUD_SIZE VMA alignment for PMD sharing. */
> +	if (addr & ~PUD_MASK) {
> +		/*
> +		 * hugetlb_vm_op_split is called right before we attempt to
> +		 * split the VMA. We will need to unshare PMDs in the old and
> +		 * new VMAs, so let's unshare before we split.
> +		 */
> +		unsigned long floor = addr & PUD_MASK;
> +		unsigned long ceil = floor + PUD_SIZE;
> +
> +		if (floor < vma->vm_start || ceil >= vma->vm_end)
> +			/* PMD sharing is already impossible. */
> +			return 0;
> +		hugetlb_unshare_pmds(vma, floor, ceil);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -7313,26 +7332,21 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
>  	}
>  }
>  
> -/*
> - * This function will unconditionally remove all the shared pmd pgtable entries
> - * within the specific vma for a hugetlbfs memory range.
> - */
> -void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> +static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> +				   unsigned long start,
> +				   unsigned long end)
>  {
>  	struct hstate *h = hstate_vma(vma);
>  	unsigned long sz = huge_page_size(h);
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_notifier_range range;
> -	unsigned long address, start, end;
> +	unsigned long address;
>  	spinlock_t *ptl;
>  	pte_t *ptep;
>  
>  	if (!(vma->vm_flags & VM_MAYSHARE))
>  		return;
>  
> -	start = ALIGN(vma->vm_start, PUD_SIZE);
> -	end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
> -
>  	if (start >= end)
>  		return;
>  
> @@ -7364,6 +7378,16 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>  
> +/*
> + * This function will unconditionally remove all the shared pmd pgtable entries
> + * within the specific vma for a hugetlbfs memory range.
> + */
> +void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> +{
> +	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
> +			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
> +}
> +
>  #ifdef CONFIG_CMA
>  static bool cma_reserve_called __initdata;
>  
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
