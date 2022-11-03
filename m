Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D56187C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKCSk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCSkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:40:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA5B18B0B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:40:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3Hwjrl029273;
        Thu, 3 Nov 2022 18:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0sV2KOgy6g6NiXOUj3SUT7h86UfP0gGqBaWtBYQWHwM=;
 b=eckHQrtpjU7pO57skujWqNMReN+KR//Jn3xx00gaUnO7vklFDUArHxA/8Utmn4Ng8kt2
 zv4+6X5k5o/p+lTAzQCQiwUVMKEK3WgbixfOJTCUrAbVM8cjf6S67VXrq/HD0AfPasDd
 7jbt1URjuvM1EaX567xmkP7bnj3i2LgO0WJJYiJXYdaOR462y3ER7hqdQ2jIf8CwxIxI
 fpzA8njDOprFbBEOqr8T/OIEofVnfEVUPtlEHFQjB1R5aita+5K0Mu1k2Iawl/k+hs5e
 0JKN8mgU8Sih94cef7r6QGj82Q5VNAGTUgSzlJwO45UCL3/rovO6qSmMnViTVKaOAnYF UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkdd77r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 18:38:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3GlU8M027195;
        Thu, 3 Nov 2022 18:38:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm6y17t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 18:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZmDwzo8tXadRPhm0dcFi81vYfk9Ivzme6YpvgIZo77pXoH3r+ojc6vFY1VwFLet92NVS1VKZKXji7zgTOcDsfoIB4OCD5gwFnIsQWy4KXtKfq1GQpLaL8rHqyTqwLnE/V9fNREwCiXAikIBqDXUDKgb4sFy9/+AfK7i9jXaBpf9utteigLOyrS4j0lxVkUU33H9A2klDmpjPZXx3hct81Y25vQzne1ZKSDrR9CnO5cbs7X7UeCDstU6eOWIcB+bayiI+20r16+wpubGMxutx2+mFjYxajAeM4ZDyB0RldladH0Fdt6cqh+l/Fk426AQS2i5JycRai3GIUEU+KsIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sV2KOgy6g6NiXOUj3SUT7h86UfP0gGqBaWtBYQWHwM=;
 b=Ae8gmFbPCbkSRn6YXN6UcgBJ0EzI5E4oJRDHpi78f2nygX1JO6qvG5+Tha9qQN/+FCm8ooGSwA3Gi+YkbjWBLPr4NsErHNob5lhxh7hZQ9VSUYSOoGgWTdBRUWDGwYMUh17LML0Og2fdllYO1fUBJIG4jhWq06GtIhFpjJ3se3ZV/DUgXQZqk2pmEfLgyQGIjflTMmf8jg3CRk7cKz42d+bTOOwUkVLw0t2epiAi9UfUuoFTM6gqxD2fTRGlOp1UnW9ead3oWI2xKOEkaxZ1q72q0VgXAPZ7jrH+FijmAwJZWU9woqnYNINWBuMBSrrLnxoX3BiiwMVhFNArSk78Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sV2KOgy6g6NiXOUj3SUT7h86UfP0gGqBaWtBYQWHwM=;
 b=tiVAP4c+asMGO+WEBlH6BJjGgBO7IVstd3kT/f8mMg+HewQJycZJviim6c8R4C4rSBUCcdEWp0Jm7aIWSa7QnKWKO/9S80nHwg/fgIEch1IxpeBPoi6YI6D+u/ES6CSleceymK/uYswEQr/ZZwToDhBf60TMrjoas6p9fNtHp30=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 3 Nov
 2022 18:38:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5791.021; Thu, 3 Nov 2022
 18:38:31 +0000
Date:   Thu, 3 Nov 2022 11:38:25 -0700
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
Subject: Re: [PATCH RFC 02/10] mm/hugetlb: Comment huge_pte_offset() for its
 locking requirements
Message-ID: <Y2QKoYtj9mthpHBk@monkey>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030212929.335473-3-peterx@redhat.com>
 <Y2PhSUnufjkoqSaH@monkey>
 <Y2QEU53BMDgEHXbG@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2QEU53BMDgEHXbG@x1n>
X-ClientProxiedBy: MW4PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:303:dc::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e0d9b9-ef8f-4b74-4a3f-08dabdca9b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDhv4tCrZz6/mGGTLZvTujrKvQc3QudZjfFzvm2iVfIWtLxc5ZQnyFJUGyxHJVgbU2cepwYEND4jfOeufnisZUUQDTlRq7fYc0wfDrn88ROn5pIM89bFQKABwYKeb6Wqr/CS6cZv2rtROQaWGXLy3ma49rxOywnZFXYyw3MxjCxSjSwfEMBhLW4cwLbezdPXZj/B6A2yPHQomW0cb2w1KatfSkRRMhuwhedyrcqcu67dmflTfhlQpVQyUGBJXUREIBp7jLSnj3ESd5CIn8OgCYjHK5QVyHoVJlvCUIPzo5vTFR3n9LfJFyaceAO+DrmTd8RSeKqml+P9A48+LGoaUvzzvQBgszr0LDLddZKh/EEXwBiPL5kQ4zrOrDZ5o9D0ydXhDIPOp/i3Y7d3+Bda6VnU6w60v/s0s8G3MJ8JUwo5VpNscPQO2I2lQMP5nPfqjRFP3PTyNNudQTRKc6izHhhHCjMIx3L0oS6Xqz7g0pLfunHEayesxQ4BiFohaNaJaRExQPTwZLSohwItX85lw8nZ03DOXCCH76927pv3NbkvdOVp5IJ+dPcvqw5BO75n3n44cKFO/3SXpybFFLfCMmqjEYtcaW1yx9byF9/u3SjOOtUHCBN8/862SNA+ICitk0VAw0LtKq5sSoSQtIJG6ARBGk8Q+eGWzZ57S/wLEY4qMwdAwHn535SXjSGT8jOpu1S7wcpISPnuTuziQw4HC2+173hjTUWt3jW7J9kdMx+kgRmcOFnWgUYeU0pj0SvO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(33716001)(6486002)(8936002)(54906003)(41300700001)(38100700002)(66476007)(8676002)(6916009)(44832011)(4326008)(66946007)(9686003)(6506007)(5660300002)(26005)(53546011)(2906002)(6666004)(86362001)(478600001)(83380400001)(6512007)(66556008)(7416002)(316002)(186003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ylqNGm4hw4DJ4BnsXH+3EBJ+ZVuGeDbChOrcVFprLcPEpPKtDtkR2Swj7VG?=
 =?us-ascii?Q?sTujESiog62h61b2boDj1fZiwwBrfkDtnVY2hWT2JUGLIdzc6roMQi5FdB1Z?=
 =?us-ascii?Q?A81Lm+8xfOSLPxS2S9IF1b7TyQDcpS4GyG69taEXOtQDTUwfPrWmRCxpsFyp?=
 =?us-ascii?Q?xF5u0UIuDEaNxSAvtxj0X35UVYYwuCojvzU8+sJKiUVmAq7GvY/xaBf1KYJ4?=
 =?us-ascii?Q?gIWc3Cb/UWLRGMQskVQLwyIRRcJ6eV2yO9OEWnwrO2SCq2aTgCNmXDJoFbqQ?=
 =?us-ascii?Q?4+USeKpOPFSliuFH+85pTYnnotWY2aZxC14M1Q4cmb/hVD/Vr43p/4XAhIuX?=
 =?us-ascii?Q?rqro2govTmz/xwJlH5mrEBrvb/uNnr9B12SZX7dc3s8LqloFfQADs26o2UFj?=
 =?us-ascii?Q?HJ3JVfckp+CNSR7pXaohaGa7InyLyK90Sm1pmxzY7MdfaTTWSiY6XpdrZ3ZF?=
 =?us-ascii?Q?jMHaCaPLxXiJirpw15PSDclihSgfv3EbiEGU0larhRy6vM8RA0eILyYv0JIP?=
 =?us-ascii?Q?OQtp5vweN3J50WJ3Y2MAqyAd6tY7Baf1P/2EDJLegBbZWGJI9NIeWVWEQPnv?=
 =?us-ascii?Q?DtAJFllNXaWwxuGyH8F0if72UiJNRPTOeBy/06+QtrhUiQY1GjIpR9sYYKSf?=
 =?us-ascii?Q?jyReihhkV+ikT3WjetUPVzt0Fhi+1nuDDHYEum4N5x+gn3ksOF8LWuUMkg0H?=
 =?us-ascii?Q?meX+G2tbvHhvoLSKV+5uU1GoZTaQF6ORMptTjI1LUnQRQUHfoWGjNYfg5B6o?=
 =?us-ascii?Q?tqA8t1GespThUjmfhaPAIRE9CmOVeDL0KqY/P1Qt0TtIxoLQzas0JIlhRKmU?=
 =?us-ascii?Q?vSnQRcSLEhMtT4ZaoRfcwVU6wLSNRfe9+Rp209q1I+nTiekQGSDTtGjUPAFj?=
 =?us-ascii?Q?GcsF82OvdQJ/J8KMDRzI2Eo3jdvrqXxwcrb0yHRAWH22Xsy030zPIug4GCSu?=
 =?us-ascii?Q?Bpx4cSeDXnLZbU5Cd+H/GwhzDfPIe1/MTH8jkvsumi1DxloGJpWwiDhj3k00?=
 =?us-ascii?Q?kwxZsp0GCKsh+7kYTNBtqTTlC+7s78Zz2lOsIPj4JHoxTbVjMlu0Q0WZV9uM?=
 =?us-ascii?Q?xU05JpUrz/S810m/CmEfQHsl2TMrrxcRE52WhE7omLUR0vJ3YIVv8HkLNF2W?=
 =?us-ascii?Q?hzvILyM9ZSwJNPbFZUX6zsAFjAlH9a2wp077G/2WnrONOl+64s5+ELohcf4b?=
 =?us-ascii?Q?OmiIDPZi4tUyOJg7A517kP8mYAipUVKr9gkKkRVUD782qv0lyOAjhStDVk8C?=
 =?us-ascii?Q?hHNbD07jiCSPJlds0ts9SGfPJFdNS06Q0aZV6M1xJijAdplc8eX9Ns+F+9j5?=
 =?us-ascii?Q?rM7VTbFXHeaADJ4+lfrEJAa94kVUTu1SHM52ipDvjUjmbQr3n60rIZdE5IiI?=
 =?us-ascii?Q?Cjqh2MjWUJaIvQyWk5dzz8BXIN2IRxAIdfRqbGYHUG11SDrQYjc4no/hNreu?=
 =?us-ascii?Q?XPKsoYiY3uxOEDNfXEChws00bEhJfUUw0aj7nbEuhzpN1xLadISTsRA+o7GC?=
 =?us-ascii?Q?3yUTXJBhkeRi3rgg1V9J8HXCTHqS5wzjL9k6ikgMyr8baF70oBNmHnInElvw?=
 =?us-ascii?Q?C/Ydj+LunnRasmNlUELhyiAvSt3QxUhbFJjwhSVAFPX1iVy8iSK+uPPfKKNA?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e0d9b9-ef8f-4b74-4a3f-08dabdca9b79
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 18:38:31.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50b+8n/Dvx5uY0amnt9viS1+WFbAU/a6wOuuyF3ZzXqUKKPTMlN7/5L5J33xgxIkz0nAu7oIGTd1c71ofDS2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=843 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030126
X-Proofpoint-ORIG-GUID: K56XZ482D4Sj9hY4xvOek2GtFfSxDIp9
X-Proofpoint-GUID: K56XZ482D4Sj9hY4xvOek2GtFfSxDIp9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/22 14:11, Peter Xu wrote:
> On Thu, Nov 03, 2022 at 08:42:01AM -0700, Mike Kravetz wrote:
> > On 10/30/22 17:29, Peter Xu wrote:
> > Not sure if it is worth calling out that we are safe if the process owning the
> > page table being walked is single threaded?  Although, a pmd can be 'unshared'
> > due to an operation in another process, the primary is when the pmd is cleared
> > which only happens when the unshare is initiated by a thread of the process
> > owning the page tables being walked.
> 
> Even if the process is single threaded, the pmd unshare can still trigger
> from other threads too, am I right?
> 
> Looking at huge_pmd_unshare() callers, the major ones that doesn't need
> current mm context are:
> 
>   - __unmap_hugepage_range() (e.g. hole punch from other process on file?)
>   - try_to_unmap_one()
>   - try_to_migrate_one()
> 
> So for example, even for a single thread process, if its pmd shared with
> another process, the other process can do (1) punch hole on pmd shared
> region, then (2) munmap() the pmd shared region, then it seems the single
> thread process can be still on risk of accessing freed pgtable.

Yes, you are correct.  I was not thinking about an unmap initiated by another
process doing something like hole punch or truncation.
-- 
Mike Kravetz
