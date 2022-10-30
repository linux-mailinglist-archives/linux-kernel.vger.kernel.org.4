Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B536126BA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 02:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3Afz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 20:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Afu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 20:35:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5EF17E00
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 17:35:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29TGxXmB022415;
        Sun, 30 Oct 2022 00:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=sQCr2Eefa1M7lhZERWSJrFgdC9el7DpsJVE890SIuns=;
 b=mPeGvjo3xesfjkH8H3HUztD5vchBrp1GO8kaRhnil1DxTQhR8SBIVQXnNkNYowTnujcA
 pzOUYhHmghJYP0iTd6keVfbZtkfVj9sS6u03QqjgG8B6/qneAKQJe5S1qax8KxQDUDzb
 IecpEmQAYBNJMKc3up0ELUJpO8ra/48TN68v/XPzLZ8SElU7LwBDEcMAf3FA4dpQQy5k
 QCycgZpY/txMpNDEWacEt9V/ddrqg8OehzX7Be2LNN18A+tFZbbrlaKasrKnIi2x4jHl
 rGn5TEHJ/TNdvJjJtQDOEVp1a3ZAQIQBTtLtS4TT9S9GrH36Q8rb6kqTiRCY6Ia4SzjI rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts10yef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 00:35:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29TMseRi035962;
        Sun, 30 Oct 2022 00:35:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm8bdst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 00:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXseq9MvhF+i7AH86++1fOpO5KC9qpoQ+2VoLr3rBSB7E5iW+jM5egiVkYEpz9fIQu4xhndWb0Xw4quRH47scxv2tvegMDPcMJyDWtCr5H/Xpi+ZVNT9IKlIaXZvlNeEZV+pbKWMS37lfXaTHkPfnZYU9fX4ps0toTQzPod8tLyQMOKwPuz323v1YlKOXk3DqXaaWdwCrIXmqE9u+vcni6oz7C09S1Sb+SaFROytYzKrG1F3usYz81rntjYcuVrQTApJA4f0TZPYHV/tbiqtcJGN+ORkoZJfv3XqnmGZ/fOgoiW3eUoVwi16OjjW6IWz7/87DQOltFgKv9WDGUevQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQCr2Eefa1M7lhZERWSJrFgdC9el7DpsJVE890SIuns=;
 b=H+rIOHKpdLcc/cPUXdzAGiPOM9X/9dGAR0u+T6BELKQFVIPK5PfXvFTAbnqZnPIAIfrCjz82afdkE7S58A6GNj5ogFMVJ7T7+dhukWegL6u0hQGaCfmhGVDgOritfRcfJ5YuBp/FeoLgSrXHOTr6CJYVymS9oOCBE91g1tI7tygG+FrQWiK0fljKJSpPu7klqg8BO1UY+oKKKNG5ZJS/NKyymQY8s5ARdvpA9cFBNxnTfOF+VqsKpZPvdYcj0kIBOd6OLIdW++5O6oIZGnCBfq0+BQOWdnxHoVV2Dq3RdDieKhEKw7z7fvEfQBZ4t7NQv/6NLlJMdLYbhtTCBRDEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQCr2Eefa1M7lhZERWSJrFgdC9el7DpsJVE890SIuns=;
 b=ZBakiP4KJk7Ub+QRAh42w1vSdaATArKAX7HLertB8Rb/t4cBIkotpkbfV8eITZYvT5rnYAndgUt2nkqdQjOh5HQZZnDAIHYvipuAdkjMvOUYxB7/HwFF87xd6dpurNWZNFKeQUNPl3rAUlwZLnwBzf4r6ZbGmHYvsL7vUS+puro=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB4951.namprd10.prod.outlook.com (2603:10b6:408:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Sun, 30 Oct
 2022 00:35:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 00:35:19 +0000
Date:   Sat, 29 Oct 2022 17:35:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] WARNING in hugetlb_wp
Message-ID: <Y13GwSF8e6vMyYyY@monkey>
References: <000000000000ed009f05ec257623@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ed009f05ec257623@google.com>
X-ClientProxiedBy: MW4PR04CA0319.namprd04.prod.outlook.com
 (2603:10b6:303:82::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4ef4cb-dc9f-4a33-45a7-08daba0e9f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdVYqPktKtWZvLYuyAe8idS9T8tykaFLUPwZlI/DDgkkteUubf/JcsCkz7wt0dehtzVm3LzaH8ECfV6dVrqjk2jGnunc+aCFIV8uxTqEudKUNlHOZ6ox6SStk3Oy2WeKH6dF4G4VJ750iGeGnupXO6UQ4MNmrLsookt8dKlawldnwQSpsnVsP5DjB2ljSXAGQrbbPzUa0xpidTg2uVDeN+tD/AI4YojNiU7qrT+gLYzu9Pv4iMmYTCRsK5D/Ne3DKKKJZ6JMTYOyCT1Si3K2Lxey5LMSq6z8GcdyYICnp2i2lSG7+pdtZyOIvFS+cCsez6vbAxgiHEgc/PPbuTO8pu2di6IxugGJt3qDQ+eamQT+Z+7MxBorQQBffWZQTynd26DigIMSf/MPqmLNCb7KjRRPerJ3yNXkmrt5Vyj6qfHTx6hVA6LxIhIZMQaNckHYPGINncxojBhriUuHE/8BKQ3AsvxaEZX7ZPMSPntOhQRAp5J5FSZHxSomtaCB/Vu61hYD8OoUt3k80plt2gdHAvNP6JBZ90YTOUGv+OV1pRdLSNV+LtEaNup7hwZowjsonIz7BcQwKXjkxhXgtO2Pz1hztzvvRxl263flG/tKoWdjV0CT66NxvlJ8ONHXAU3WLSCBpxCGwzxtLacG88VE2heEtgIXItXOq2Bv2IyQgO4ZoPNk3v15BSDnpVLteRgFZjuSX7mYQfwjE5b1Oam54+Tcbk5Tzung7K5hgavJo+I6W4SeeVFocszuZAnqQXgmsS32k5wmx9V6YTtuDDjsoEJWwRwaVIcf2A5/ACSzlA0ZvUfeTONQb/P4sPcCos2u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(41300700001)(6512007)(9686003)(83380400001)(33716001)(26005)(2906002)(186003)(8936002)(44832011)(7416002)(5660300002)(38100700002)(6486002)(966005)(478600001)(6666004)(86362001)(53546011)(6506007)(4326008)(66946007)(66556008)(66476007)(8676002)(316002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4R25jIaiSiSFIMEqudMhs45mPLsy3knXdB319zReFspHa5gCLwGVO9dDLtVy?=
 =?us-ascii?Q?wU4B4gzOw1OU4jkzWwxXpd9TP065FhF6UPTmgTqKTm0yhO3D1zTNGohdHcpa?=
 =?us-ascii?Q?WzXoZrgjRVwSd3EN/rsuWf8g94A60Exc3o0GifATKGKgaBY8H4/2LIBOAo7v?=
 =?us-ascii?Q?GeZhBwAk1ALH4eheR7Uq/nhxnVdqQ5E11gHMD4MKV/bfa1bxzzwQbBe+C57/?=
 =?us-ascii?Q?g5xIQzOQ1Hg3vjSKkIHlno4BgtgJvEiVuq8/RZAdwkMWCKW7rTqaaAhUzHbi?=
 =?us-ascii?Q?Jar9on1GJzImZZzLJ9QWRHZNtmx5iRf/RriIGJfmQXPcYDu0+clXaPG/kzJG?=
 =?us-ascii?Q?/IUI1bTRd+qkrTY8sbMH9gq+dOAlFTHJfQnH2IhsyTCBF+aDciyOQy9sWa3+?=
 =?us-ascii?Q?/BdufGQ9dKJSpZsL8/bQvxSAhmWatpm9eGK1tHEzyMnQatorsC4c0UtEMRFT?=
 =?us-ascii?Q?0/L2uFgckYuOPXS6X0EJvTQXgi2RtLNQwdzIKjSUYS3ZNabSI/R5hlOkvlK+?=
 =?us-ascii?Q?6tVrlwIcA1Ipsy0PNLra+6A6mgMfNMUCeEsRj8sJX3avbPlgO4ceOOimodPE?=
 =?us-ascii?Q?zZddz/34wGWZukjnM6iTNWOGp3Z5KTO73XsQkWnCyNCoc2Ugh+f1RSbj5XYk?=
 =?us-ascii?Q?48mABXV2G18qVgiiXkBtsExP6ZoIxjRiTmFAziXGKryxMVGNlIrpg40dWTpu?=
 =?us-ascii?Q?3yb2FqFtlJuWiHiMD+q0EbC5oaUk/1+Z/RE/3KAdyjO4N1qazPlbfDhF6gmx?=
 =?us-ascii?Q?nQlnKAyk8AxUcDxkmgMNqCRWePHKAxCWAv8Yi3UAGV9vL4+Z5AwfGwWfTNti?=
 =?us-ascii?Q?PDnavn++21TfOZG7lQe8HaMMjiSRu8LNa+f82RDGmxE2J97tHJvyzhuZv153?=
 =?us-ascii?Q?WOPGgTdXx8cq7uBAOWYeObiJ/3dROIdyQJox5unbotC1QsSClSJSAhpjwVJJ?=
 =?us-ascii?Q?68r/IdrWU0QPHbZLOqBoNCJZ0jiMhRg+6KfMEOR1QbFzsAINVH/Hb3Emk/Kl?=
 =?us-ascii?Q?aXsUBRkNUr3slEiR5sWLn3pFFUryms7rXLdCtTZp1+yMR9Ws4dzHpZFnT0S/?=
 =?us-ascii?Q?ojaucL/Ws0ZfEMbPCPSS2uPWe830rz7O/N+0wqUPTVHUR0G5xnFBpfPwFgHS?=
 =?us-ascii?Q?NXBdPdOCfNKcC22ncGgeIUE/rbIOY4+BCw3vS2szhC6CXa62u+PtLUdIklEJ?=
 =?us-ascii?Q?L/wUBk0IuHHt5+e3VnfomzT/GABEaD1BBAjGPzEIqrYiZ3bSenaW2nJOCzIo?=
 =?us-ascii?Q?rh27jXvbfaxqcKfC/g41VXXNET/7xW+WFpvbUhNYhoyqV1ff+YLuGXHssQoz?=
 =?us-ascii?Q?ws7tTVGMaDoR7xX8CYZW4CAs1gxmU8ak0+mOgK0lsBLxhub+vunbpQjNyIu5?=
 =?us-ascii?Q?b21kRaqD4WarLFBVnNSy7w8FdjNCEN2iecuuh8aaKMA5v9CzcDUYNmnx9t6a?=
 =?us-ascii?Q?7kHV+PCdwhfS5owG0gE+rpa3yci5ca/Vy08dSj3Nqw1Ui+6rUjrcB4cMXjQO?=
 =?us-ascii?Q?GA2nxg6uFaPQyYJ5bV78iRrYB63UGFbcrd5dHyAr2IjUVi9xH9xoYsrPmFqx?=
 =?us-ascii?Q?8MGiUTOlJg1Hok91b387ryyTiRAPXilq4eDZpXNqS0qKCjk0hHMJC50b/C1e?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4ef4cb-dc9f-4a33-45a7-08daba0e9f6b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 00:35:19.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6vrQhaEXjhHCY88i86xlEd4Pa61TSoB+0lfeJz5xnO7Yk7bKCpPBvTg+8q/EqH0Rx0Z1vtOVZ00bWcRJ+FKGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-29_15,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210300000
X-Proofpoint-GUID: dEjru3wwekwiHoyuk1gUtq4y2kVTt1nw
X-Proofpoint-ORIG-GUID: dEjru3wwekwiHoyuk1gUtq4y2kVTt1nw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 22:15, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    247f34f7b803 Linux 6.1-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a9efd2880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=f0b97304ef90f0d0b1dc
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112217b4880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105f4616880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/de212436b09b/disk-247f34f7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/63c4feda220f/vmlinux-247f34f7.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3612 at mm/hugetlb.c:5313 hugetlb_wp+0x20a/0x1af0 mm/hugetlb.c:5313

This warning was added with commit 1d8d14641fd94 ("mm/hugetlb: support write-faults
in shared mappings").  It is there 'by design' as this this specific
type of write fault is not supported.

	/*
	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
	 * PTE mapped R/O such as maybe_mkwrite() would do.
	 */
	if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
		return VM_FAULT_SIGSEGV;

If there is an actual use case for this support, we can look at adding it.
-- 
Mike Kravetz
