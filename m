Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760B464D4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLOA3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLOA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:29:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96B2F65F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:29:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEMwmod025815;
        Thu, 15 Dec 2022 00:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Kh/1Hz1uUR4wvQr/SUqxg+i0tiZCtgQmw8kq3Rba1C8=;
 b=LeTf9IsxhNO2j4JUpEIJg2MwuVxXCQ42qZdjxHDP0Dgdj/IcPlSwObi7JgzPDyY47AJF
 Y0KG1HgcRE0Sk4YGzRX++bHdKJ2Ygt9i/kS+BLw+kJtfYAWKVNbkbhK0NrutoKDf7w1a
 3phX+WBCbVpBdTecf2tZX/12JQwyQMzbQpXuRDOK7KOjDgbD1volTaRjkYSvxRWjgwau
 kpTYe2uVRldywAzQH7Nt39OSlWQ4YwEfFB2kSo87/+tZSTblzVAMR9l7bV0IGbpAnOjf
 P2wE/9hz0Wrj6jceFnziiA8A1SeKCQxLjuGmx81F3cwQPrYjkqakb8NKTjKp/A2s4mlJ 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewus4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 00:29:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BENEKl9031248;
        Thu, 15 Dec 2022 00:29:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyepuh52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 00:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC9xpImvnh6NwWLwFiNp6a1qgjWvJgiZ/9N0hfWA91ZQ3CzGuBPOzzbCbU1VQFFvjQLJ8CR0tbPkfP/dIzrijXRZzu2Tt8uxzAqRHSu2mqn8cXhvCr0BqD8t5HeFfOzulYyM0q88cKNX3XmoE9fnqVOaoMNXlHJsxwGz5Z+dZReTUkyfbJI9QB6/0YvU/JrKYeFi9BqzVo6avVk/5v1ksRC9IAz1bmU8SAw79DynaDpRaQTDsh88Bj2/SaiJSMkYSNrjqMIQXXwjsDQYh0ND3wW/aIaEwxUQVrFtYRt6Vl6mm2xBArzsgxGgju66G73EEvO5cqdUZ5XjUWvHouNvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh/1Hz1uUR4wvQr/SUqxg+i0tiZCtgQmw8kq3Rba1C8=;
 b=Bjr5sIJDGPiBF/ERzUwwxxHUjA1jHv/K2DgbzT7m3CWU5Lk4PfHWD/n/4zs9l6/NYr5bgb2SD/Ff0brbZUgNCEh0lvwH33vv0wZ+aYelioqCvcyEMCYtrSxepcYvikgGz6qigcTAW8xu+HD90wVVdhSzgDpLPzbLmIAml+oOAP9EI2M+Aec8XpyQ3kHWuH7hTi0VU05wczcFIVjq2Thmq6qh+kGPdRqHoFM/3H2k0487IL+bOs8hg+4pGcYTf+2qRvr4YQavJ126UeY5pyiHaIi61irPXTRKqjmPT1XBQr2+w/VFxDBV5mMvfEAkV/QBUruT1V32Q7LkyWm8d32Bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh/1Hz1uUR4wvQr/SUqxg+i0tiZCtgQmw8kq3Rba1C8=;
 b=jnmaKqD7Yhcc8FB3oBZdFOe9EEdCe6pLqesyZCXxJNsoONQ8q+VI25uvG0gf3QoatLEPw1S8RguToGqSd4IcqiE09lW1EmJCO4dS7UcTR0fLrnEAGB/b6bSpUYJOr6vPJyFTYJ7oJiXzO9hGw99E6ECD+tXMorO5OxBUAn59iAs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 00:29:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 00:29:00 +0000
Date:   Wed, 14 Dec 2022 16:28:56 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 16/47] hugetlb: make unmapping compatible with
 high-granularity mappings
Message-ID: <Y5pqSEObQwN93YQ5@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-17-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-17-jthoughton@google.com>
X-ClientProxiedBy: MWH0EPF00056D0F.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0d719f-6d42-47d7-59ed-08dade335c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rd/VvLvQDkM7Z0hySDfhLIjnRWgo/NpvfIOkQaibbodKy4iWi1RRFuCBcrduyjnNBFSA9gL/+pLWxd+8qyJbHrfYU/r797D8lDuNiQZ8/5CYQeME+EbBEFzwk6vB5QMH1+M5ZKkNaohqd7hyn4JX+ntvV9N1+vZXNbkVaCaQ7zBDqRRdtwAKSEeWyf1RY9FX5bXt4/Z3mHJye4/9lA7FzBwe9qhIib6PagHlC0axv1NzJzTAiwwUUxqbuZx2k5e98fOZpmwP3gN8Nx0+kShO9ZJtYy1V3Ppw8vdmupGNjHCj/Spj+xO4Mp2PQwz5j97s96BcDztKDU9HXrqCX9Pgfns4HtNrSqj4S55/OsL5UrUTQXOqjXh3q5h1OBPjMtpVpC85YIOCceWwqB3UFkcP2dKvvaU2OawcdBIzRiP7kcEgKlJbiGl5iGJb90OdU1pcTn64JBMSrS+tE6OrLTp9CWMDxRBdxcFq6D6VJEge/zC9TnFwfBLwlzexPWH4oqKMSyUpdH50RS1RW/JzSfUhsvmCxR2YfpDkGF9lXgGTFwfcBPWWzz++csROhX79cxjVhSBvL2N23bZ2tWYY/N9XyXZzhWlEe1r73y9LQliD3A8yY3LgY6fz4B8nZgDWmFbm4lZ5IsyAwDyfWPkhgryF1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(33716001)(83380400001)(86362001)(38100700002)(66899015)(44832011)(4744005)(2906002)(316002)(8936002)(41300700001)(66556008)(66946007)(5660300002)(66476007)(7416002)(8676002)(4326008)(6666004)(478600001)(6506007)(6916009)(9686003)(6512007)(26005)(53546011)(186003)(54906003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pbvl514xCCfSSTmnhSEavWhf0bFwwsjbYpytk+ZeQgzaaOa9nF3itHHvuKph?=
 =?us-ascii?Q?tD99xQFtybqsRbY3S15q05+KtGJPJhY28JwDWf0+u8CbcLrwCZflrIk/3Vvm?=
 =?us-ascii?Q?Mqv+UHnpEjF5NFUEQyDX4jP2QwM5bVegMz+2sMlSIA7Pq7ozTsBujDuzsdgc?=
 =?us-ascii?Q?K+/HotqMpWR2BB+FRnIdvPGcyNBcvDJljs7M4eh1W2zDWATFQIsiivtxax/I?=
 =?us-ascii?Q?zZcktRlJ8Bhi+ZirClDMVfUC+y4u6eKPfZ9T2T49dzQwKiCL3LdGxIYaREeD?=
 =?us-ascii?Q?X3tD8CtASqzI6cmwNLXhcCn/7gZgdSpGyXN2phB+qIt8D5qEejZK1ZEtlVEq?=
 =?us-ascii?Q?KpdPKl6nRZkNeN+VIWU8seBDaw5bjcRyOezkHxgiaUhteNhJkinpCMk/L1go?=
 =?us-ascii?Q?LHSgjnihX3xgZPz3+tUmv2xbuqkqEGfyVKw8n3h/RlST8jd6eKPh9vWu6TuE?=
 =?us-ascii?Q?7flL1mJah45DIpaMrrdGHBrC5XOumWOz7Oe45oKttUcGnDGdqdgYMwmAlemZ?=
 =?us-ascii?Q?IyBMACfNflhB4vRkuVzAUjFTnQVQlz4yVB7sMx7K5+IX3w+Zhr8M4p8Jq+ZP?=
 =?us-ascii?Q?9wnXfUR/gFq7xK0DJ24iV9EhEBTOSjlP7c6X1Hhdli5+va33/opIrf2UBzXz?=
 =?us-ascii?Q?mybRCEXWYVOf4dYa60G6t0Ii88xdks/wUf+I7lQJOoLUW2LYWL0qVReaQaMd?=
 =?us-ascii?Q?UYdOsZs77xrOCr8aNCBTNP4ODS6V4fBHN86CpPEnf6FQAIkhMN/1SQx/G1eJ?=
 =?us-ascii?Q?CdTciotZj/bscdOvK7/uEqDjMSp788hMrKE5wdoh8KpydBDbBn+ClGTTfrlk?=
 =?us-ascii?Q?YzWioYcbwGN6ueOp/HuGx7xTX7kGfjeldKDyl1DAIptId753Vht2jgTa4Asx?=
 =?us-ascii?Q?x0blXuH5Jhh5AJne5rr1mkjTjfhL2vpVGrk1rNJMzKxw8bqh5UsHs0Thiv5r?=
 =?us-ascii?Q?SUsX1TXVcLMO+u5FK4RdNmszG26plx1LOBABNok3wJKkBED46lIIPDDCDEH5?=
 =?us-ascii?Q?mXP9od8fVbNmfGzNE3SyFcS7XvHXXxnjo4wUxqItxC298TJ+4krbiHqgesmJ?=
 =?us-ascii?Q?mjCpRyergwtVH3obkkfC8K1KUllDVnstJp6HkiJZmjAE6n1D6yar/QfnUfJz?=
 =?us-ascii?Q?KsENlPf4PSIY6Erfs2WMWf0AAQEAv4AJKijrq5aLaMQdNZnwyFzbgAsDzhog?=
 =?us-ascii?Q?AbeuB9QjVOKYZZnpReibYR0VTpNqbfd7qrU7wTXps8zMm5qnweUNpOkI+UiB?=
 =?us-ascii?Q?8oJzbYznYf86gFpf2E+xeP9gfsgQZCXs72UsfZPBWFa5VzcjGzA1rjPxpRXA?=
 =?us-ascii?Q?cM6b0lr2AuZm4Q8T8h4XCACIUmCNS/eKJAhHRR1dd5vW35w9uTSSgArZHX9e?=
 =?us-ascii?Q?+GkUprOAqpS8Fuy/aD5quvYiqEYovuceYWCml845QobuWUsf92fHlAjEC3jq?=
 =?us-ascii?Q?ptXyT8Ku+HFjW2qdxNhCxxPDOzex50NEFtuMtlTwr+0Rryj97U2WYxr9rCUv?=
 =?us-ascii?Q?73v+4Q8y+sJhAEU7NAVp0oaM4+HEXQPJzv4nrGTOC3DXRhrIBBgQqOwJNEhP?=
 =?us-ascii?Q?81dlAXAFEOUj4nXAEy5gPc3KsoDmpOK0JtV59L63d5Sdd+aHCoDXtyT3W7PV?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0d719f-6d42-47d7-59ed-08dade335c7b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 00:29:00.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkozxgPClnTZXwGvjCq+OzkV8SDE0S/0kimHeasOXWVcNPQK8KFKIhPnAOtmY2dY8JirNMA2SUCgis1cNi9m5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_12,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=687 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150002
X-Proofpoint-ORIG-GUID: m6oRdumu-3YuxaS8k-Eq72oftrrDCYY6
X-Proofpoint-GUID: m6oRdumu-3YuxaS8k-Eq72oftrrDCYY6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> Enlighten __unmap_hugepage_range to deal with high-granularity mappings.
> This doesn't change its API; it still must be called with hugepage
> alignment, but it will correctly unmap hugepages that have been mapped
> at high granularity.
> 
> The rules for mapcount and refcount here are:
>  1. Refcount and mapcount are tracked on the head page.
>  2. Each page table mapping into some of an hpage will increase that
>     hpage's mapcount and refcount by 1.
> 
> Eventually, functionality here can be expanded to allow users to call
> MADV_DONTNEED on PAGE_SIZE-aligned sections of a hugepage, but that is
> not done here.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/asm-generic/tlb.h |  6 ++--
>  mm/hugetlb.c              | 76 +++++++++++++++++++++++++--------------
>  2 files changed, 52 insertions(+), 30 deletions(-)

All looks reasonable, nothing stands out.

-- 
Mike Kravetz
