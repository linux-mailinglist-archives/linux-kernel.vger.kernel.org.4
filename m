Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A61618D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKDAYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKDAYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:24:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B527DF52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 17:24:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3L5lCh007174;
        Fri, 4 Nov 2022 00:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=rCcCKwVIg9Ys2ewSTwLXuBPUP62+acKwwZoZD/7HJL8=;
 b=yTKoiZT7Gma1YG+3Zl5VgUbVH2fPZNPFy4KGk6SPcwAF8DYTv01SZoPd0g/waa/+zVOa
 /+S13sE3sdL/h7gPONLUaj7ms4Gu2fTKuMvDI7+lEUySuuxgHJlJvTN81y+wemqgMhAW
 Wj1aL9Zp2s/1ZqBfCBNVxRXudibrIH9Uah7EZv5hM1oJAOIGJ2RIkNMSQOh+9OHqWHKH
 +I9JG6hzIV1vxT77GQrxRxNnn8L965X0vZw0j3U2odcFno/6Kzkj+i9IeQgfi2dZ1GKB
 PetmlFTsLMf9XfmlS6o+Mt99SHj1FshVodngk4xZAbii8a50Tz+5AZIv3K0cz5+GyG5R MQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1equ3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 00:22:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3Mlu5h029964;
        Fri, 4 Nov 2022 00:22:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpr89r46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 00:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrkqInagwr5NrnffScQNg8W7PCDLZ6oe8UY2X70B/W6HMRCCp3HZ2bXO1qnMqQ0FrGbo5hCp/IkAoPNRDwpcLQ9/5a54BT9tin9KybCjuLOIHnHtU1mTL/I7HrdivYQD3rJzQTDd95urvnXg0o0+JRPU7S+iYMJBHJ91WqH+YWbO/beypxaZKUV8i5V1CnVel0uMAW4NdAL3x13wf6mWX+Z+yPH4LlXPZrPVPy/eArNcY951zBBou4hcl3tTEZCpiT4J4ZOzRkJtuFarbq/79Tw6OSDYzt4NLOWBgvDloiuHTD2duDAgv4OXWj+0WI0M3QxANfGzorOmJ47HesGxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCcCKwVIg9Ys2ewSTwLXuBPUP62+acKwwZoZD/7HJL8=;
 b=OCAo5vxwlvohfn5hKna2ZRf6Uyv42ghKB/pQuGURiclgRESau2QWiQ646rRIRBRm50YhXonCWO28ampsoY5Y5uElo9vXaJF6R1KRGmntbp6MKDVN3FbNXCy5iC0LoOxkxfXQkdfa5Ogo5B0vZyz+hlrwqgmd5BpAjLsDeZHSnBNM+2fwwezf+h1uT3LV4M19M1TiAhF9qJlGHTuqMqD4BcXwXsuDrHzqtwikw0x3cBr4qKeDfXsGO2KLU/GeBtvywVJiMrojYyVSyujEFUkCOgOpQOWsPHl0na6zzdbAOPHwjC/VJaQrdgUtjWVBy/mQiSlvp0d6nBvvQarxu0QxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCcCKwVIg9Ys2ewSTwLXuBPUP62+acKwwZoZD/7HJL8=;
 b=VwdogegqoQsdtP43JG5gwQdL0szTTiI5WlbDlCJ+Bf9CjbfdZVjLPyorXiiKXA3UHIieIQG5wxobMcRChIpdcpLnqg2LyBSCVYcw1cI654Nvz/4kUgzOtwYgRuV/+gnb32OI871+nvgnkByD7Z3ziFHwCc4kUWWLDSOuWfM0n48=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB5972.namprd10.prod.outlook.com (2603:10b6:208:3ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 00:21:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5791.021; Fri, 4 Nov 2022
 00:21:53 +0000
Date:   Thu, 3 Nov 2022 17:21:46 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe
 for pmd unshare
Message-ID: <Y2RbGpQooJRq/gCg@monkey>
References: <20221030212929.335473-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030212929.335473-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:303:83::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3f7995-a85b-40ff-5582-08dabdfa9238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANw4K5/RDe7Z4iHRBUqSIlWJYs1YweOimSPIzzHEhOYAQrtJOtKqXsWV95yEaoPdDxo1OEYRS+bDtkdDgFnzX/R4WDaB09G6ITUyQe9HjzoHkQvqUQG0ZlGOlH/FVNinfGNoAwsWx8RpvO/SWLaePUCOeISW+b0o1C1JLso1BPTsUUqUp9Q3FXOccbt3tEv3huJC+ygERFVSaBgxEFoeaoceojPWE5SJdNo1PtBY0ldcIlaRy2bn2T7Oqm4uvjdOjrUP/mGuQOVPVHZvlCGhNNPRst7Ea3ehat7PrFHavbFR4dw9rRQhoy1/PIJwac0p0VrcfTpAlzfFyjiNPHXe90eaZVG17WbYcEXL+JJAiSe9I0ZrbxsIkkDs77RZRwjOwzqd0T+iMQnOix6TnTombynxnTGqGb1RkkIQIvY+7A2LWVogWlVTVaiP3PNWeF6JUGYCkS5CwDS8Nsg+jd/pOqXnebsbl4ris4lpoEvBES7Ep0R0l2PDoIn7kDsRzwaNEJu7sXuZsayfg+Mu4UHIyGnWiGV/39Y7oANrZn6pkLst7gaods+jFE8H4IOe68m5etLchcbUUHQzzQSYM7dLrOrjv5P0vJy0T4owneGz61COUm8GxGTLQBHXlg8e/YHMmUE0hqbZA6fbtiaa6vB8BuCLFfRyY3/gTfwIdlJDJsgcBaezAafq5PCvlsxSjqVOHCYjI+Fbj1DRyZ4wznG62yV0SpCjyb2QmeuYidzt68J6s7oguy17Zid/1qpJLyKz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(86362001)(38100700002)(7416002)(2906002)(6666004)(316002)(33716001)(186003)(6916009)(54906003)(53546011)(44832011)(4326008)(8676002)(66946007)(6506007)(66476007)(66556008)(8936002)(478600001)(26005)(6486002)(6512007)(9686003)(41300700001)(5660300002)(83380400001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Acc7pNkiYqnBtgy7cTB3La5w6bkdxebhQcVdnxfOc+5UlpHU42P9Or7wHpls?=
 =?us-ascii?Q?LiwOGOjPHY0QuN7N/4sZpCiu6j/z0ISwfsnsI3J5v0I9lDIBsf61q/vxOHdo?=
 =?us-ascii?Q?5e04TX4wuCBdolD8tP6LmxIT1Djy9bPBBtioNdpbxhWylz47sIWvX6l9e4WB?=
 =?us-ascii?Q?IukBrsuL/ZTLt/vloTuQuz5TxJ5KcYMWN0lURM1NFvsGrpJhNXNjRNCpU4Ai?=
 =?us-ascii?Q?t05sDQPC+vIM5NCByaJij/kcY02PI1mToEIhEEVgg6T2698XqIysHPEyWaWA?=
 =?us-ascii?Q?UYJyQ+7eW5V7FHpd6xaJhbVJas6MC/vPuPucVqsS9j5ul5V4ncwOWcGn1/ej?=
 =?us-ascii?Q?AuOuMXoUbsyws6fq7ckyYNXQMwX87i1tOUtpYrItgHU0qDQoVAFaBvJ3i/xT?=
 =?us-ascii?Q?xa2asV8m1saelMQ3OrrcaxP8DW8gXqksNjsPKvnB9DsAlsCNnorPgIub1V2r?=
 =?us-ascii?Q?9789N11n+T7URYi9uyclT8D41s2YJtCdQJgihMTekDUektTV7gtYGQ9PV+dm?=
 =?us-ascii?Q?4/g4kHolS5OaWLv9izUnBrYQQdfJQMp8KoXhMipPIXWJRT8H+zj7S/ukZHY5?=
 =?us-ascii?Q?wj9fY8b/0TFLDugJZtLRlaywjPcGyuMJbgVLlC2gojkqcjFd8NtOPeEH/JoJ?=
 =?us-ascii?Q?4WGoMgugyRKKmwWXCj8MH9Lk4Hua7nNr7k2vTfh9M8+t1tgkBp0QWheabY5N?=
 =?us-ascii?Q?f/5VUdtCabGkysqX/ot5gRz1mgo87R4SD7cgADRFDlsuUYqOdduI+p1oHR4r?=
 =?us-ascii?Q?FAzeDYovL0m8Yt2Pd4v7LXId58iNi1o3evkLEY9AAysDxC0RMhVy7sqVA60K?=
 =?us-ascii?Q?+O4Wfa0R/bQNAHTihFm3e7Y3d1fsqRlkxa4UT14YrRgLE/1y0+v3OFb+3NiU?=
 =?us-ascii?Q?i7sDEBSZbqD5imREopt8cG+Z2dayK8u+CP9iHbweAfLjOX/zF3ZLpwhOxWzJ?=
 =?us-ascii?Q?xIC46QAIBjSd7qX5uxObXwtuzZJ9gl3RTXwG3n5D91KxZFa57urd3fb0+pS2?=
 =?us-ascii?Q?gjdnxjZ+Wv8dWTb23BRw9o5N0kz5lwfCd3t6THip0A0LJ4claTEak37fI6eH?=
 =?us-ascii?Q?hPgUu8Yz7pC7/eb38V0IIfDnjjlv9JJcNEIDdyPbNr5JJmutH0poI0pdxTas?=
 =?us-ascii?Q?4arE+jqp4XKFEVfb0Riv8I+dbXPvjOv/b4MstGzJ/a42/UIyDRBiS3Amn1M9?=
 =?us-ascii?Q?mzbFQrd6Jhb/KgxaiuLrFN/p6Sf/i0qgSHHrMCSFIPyDJj8TLWVDRUsY6Kof?=
 =?us-ascii?Q?e/ltTT9BjvMBtyoCwaf4PvpC3G6bduihTZm3v4080yen+LD+frSVlcl3d507?=
 =?us-ascii?Q?1v4W951AzclzEuqjUrlRYifd+oANaGDps96i3LOoL0d1SzaMW8LjdXHLPA1I?=
 =?us-ascii?Q?COATQVuYirQ8eAxb9xkvcl4un3HJRaYoknFigUW7vYnoFkeoBbd6xK9oYHRm?=
 =?us-ascii?Q?GkdCpefR3bv0iPwGqXGeqyTkapQUFOtNOwXGE0m+Px+IRBX9oziEkXhCv7yi?=
 =?us-ascii?Q?Ap9L6EYQK0EVhD8Ru5SNabGsmUFcUeAjkUCmUICwP3BF+8+d8Grc8R2ag1Hx?=
 =?us-ascii?Q?BZzd/p9nTmTvgENkAg9wFZhmeXUdPO4s335vA0DbKD3QglwxgIVhUVRO64V8?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3f7995-a85b-40ff-5582-08dabdfa9238
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 00:21:53.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cL10MsWos0kLZmi1EwB4iG5bcY0UmSnEuVlG2V5jdlZBIudHZSdxxO4q8S8PSX77urEW1aw6EMoECSmDrWX5Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040000
X-Proofpoint-GUID: M1BQs5pEO55cgZuafjmLzKvTLuo2UBU6
X-Proofpoint-ORIG-GUID: M1BQs5pEO55cgZuafjmLzKvTLuo2UBU6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 17:29, Peter Xu wrote:
> Resolution
> ==========
> 
> What this patch proposed is, besides using the vma lock, we can also use
> RCU to protect the pgtable page from being freed from under us when
> huge_pte_offset() is used.  The idea is kind of similar to RCU fast-gup.
> Note that fast-gup is very safe regarding pmd unsharing even before vma
> lock, because fast-gup relies on RCU to protect walking any pgtable page,
> including another mm's.
> 
> To apply the same idea to huge_pte_offset(), it means with proper RCU
> protection the pte_t* pointer returned from huge_pte_offset() can also be
> always safe to access and de-reference, along with the pgtable lock that
> was bound to the pgtable page.
> 
> Patch Layout
> ============
> 
> Patch 1 is a trivial cleanup that I noticed when working on this.  Please
> shoot if anyone think I should just post it separately, or hopefully I can
> still just carry it over.
> 
> Patch 2 is the gut of the patchset, describing how we should use the helper
> huge_pte_offset() correctly. Only a comment patch but should be the most
> important one, as the follow up patches are just trying to follow the rule
> it setup here.
> 
> The rest patches resolve all the call sites of huge_pte_offset() to make
> sure either it's with the vma lock (which is perfectly good enough for
> safety in this case; the last patch commented on all those callers to make
> sure we won't miss a single case, and why they're safe).  Besides, each of
> the patch will add rcu protection to one caller of huge_pte_offset().
> 
> Tests
> =====
> 
> Only lightly tested on hugetlb kselftests including uffd, no more errors
> triggered than current mm-unstable (hugetlb-madvise fails before/after
> here, with error "Unexpected number of free huge pages line 207"; haven't
> really got time to look into it).

Do not worry about the madvise test failure, that is caused by a recent
change.

Unless I am missing something, the basic strategy in this series is to
wrap calls to huge_pte_offset and subsequent ptep access with
rcu_read_lock/unlock calls.  I must embarrassingly admit that it has
been a loooong time since I had to look at rcu usage and may not know
what I am talking about.  However, I seem to recall that one needs to
somehow flag the data items being protected from update/freeing.  I
do not see anything like that in the huge_pmd_unshare routine where
pmd page pointer is updated.  Or, is it where the pmd page pointer is
referenced in huge_pte_offset?

Please ignore if you are certain of this rcu usage, otherwise I will
spend some time reeducating myself.
-- 
Mike Kravetz
