Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F98B60668C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJTQ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiJTQ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:59:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B189132D95
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:59:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFj1Ps013188;
        Thu, 20 Oct 2022 16:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=3Rd2dg8vQedxccKjxRiP5fN8lyUrRXRYxEnSHXQnl+w=;
 b=Z1p/LYQQFSVnL1CWwGt+TLOFP6oEoUZUa7xTcY/ctJFOLo1C9HsbFsUR8osuSPvGWwSR
 0pSPuGXxlkJRxUF5vr9aHV0DBn97MKmrcYJkGWv4le3iBg9qST5qzVnKQys1sblZprqk
 n2yiDuPbqgSlfdGtHsltkh7rXVN0CENYatg8j1VXa5oHhNREXZoMxCwuCA0AkzpTIB7C
 FHupBFdVylAjDr85YX/HRpmnbDuCa0C/acY8OGBaX8m9i2NipigpSCaqhQCtZ/dyTBg/
 r/myQhqhxVwDFC2aHHZSYFyVSvmdsF99nFBW061ZH7XMpAS9MG96KXklybohXH5tlELg Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww9bqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 16:59:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFSCtC027463;
        Thu, 20 Oct 2022 16:59:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htjruhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 16:59:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwBCNqopJ5GwqJFg4+LtATabx2Y68SJRX+fVHPMrkPLDYw48bMsjEo5YwxDf3VumDSoTgnMlssfGSqYMXcvwzL7vG4uu8RJCU1m1CI8VefAjC7vD45Vj9k571eA2Ei9ArJ26DyJRoBqtglYsMitNQ1JnyHjw1F/MUQrIuSBu6nJIM04W2Zg4ApuaEBngRHJJ4YDah+thpimnFr23gMpAWK2CLrZoHwwy0Q7O0HJaltmA6Eb7vuT4GkiUfJ6QGwGg6DTtUdRlZh1J8Ocmhh1CEjGXsmEAWiwPVr6PfJF3NhvUvtd2msCkn4AKg4RQunevqDOuOzTVQpdJ0zS/tNSTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Rd2dg8vQedxccKjxRiP5fN8lyUrRXRYxEnSHXQnl+w=;
 b=X6AjXCLLZnkhUDEy7Tbg/YOvFEADfqNuPxMBwbX0P+vsYv1z/a8jWdGNysspzp4GgIoPTLF/3ey2jiSUG/zS9bLDRqY9hbZBpCJestVR5uILwQLI6d7Cy3ijbihpzLb7yKLeuskgR80akDdvRe5k+TbvRzTUYPf4bQpv6sfwhSF7RXEizANIHuF1mrUoISg/RHeG5o0FmAkLEaE0IS53Ex/FhHcsTGzsT9lHO2PGHV1csncvc4oZHKF/UcpWsQf7rVW9GKJXo8aBSuIr/GdpKfC4CpTMEmwy5bXCX2EU5QLyAYzvOn6tm8UKuRrcQYcr6STCxW0IZoYleAhP8PxfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rd2dg8vQedxccKjxRiP5fN8lyUrRXRYxEnSHXQnl+w=;
 b=UMkYeObS+qoolimpwJabu0uVqWuwt0e/2a5bjaGZePSHYtfGzQ0eKJDSvc0KZ2BW4Aq7080nJIGRsEYNHTpSjAWBzHua8yTmFUyrll6vKhCtufyAWxp2/fu8EWVWCA457QS6d+je+tg6B6NofEXigXjpCYlL7b4sOSAnkiJvAs0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5761.namprd10.prod.outlook.com (2603:10b6:303:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 16:59:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 16:59:25 +0000
Date:   Thu, 20 Oct 2022 09:59:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, hughd@google.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in page_try_dup_anon_rmap
Message-ID: <Y1F+aRB0/ZhHIlE8@monkey>
References: <CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com>
 <8ef3a72d-8719-aeaf-1a03-9b7cb1a03cc4@suse.cz>
 <CAO4mrffHdnG7fEkxcoEXEhqYN8HkcY9d1-NxRvHsqf0mQN6T1w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO4mrffHdnG7fEkxcoEXEhqYN8HkcY9d1-NxRvHsqf0mQN6T1w@mail.gmail.com>
X-ClientProxiedBy: MW2PR2101CA0034.namprd21.prod.outlook.com
 (2603:10b6:302:1::47) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf9112a-17f4-4dc4-59db-08dab2bc7109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dVj8S9NjFgirijai2nz+P9cLxuZGoqS1dJ0y6uoJSG2cad2B8O6ODL1jBP2C6zXaxnEtWG7P5qllQFVa/7uT20QqVvdQQxZom16omp3C3IDHO67rf38ei2e30wA6iQRzSZStFiwhLCIaHaGwkvLv87uly40C2JXJDJ/2e1PPTFb9fuov56nPH+qvcSTmQuy2umT/hPSTGKxRAna/jeS5SSw4whNOgrAijMw5qSCSwcnCIwmILbIUQglMMMAzMniNurRhi9RlRPLofNv4N8S4sDZgAZnNTWjJxXgtg3LbSaRlxyLQRYBXw8jeGTGgI6A9sKFLvSk5eLhcnMFkXHm5VfKZuPwGqWQVbC6R+muiM9Xt5hqFkIgpBQWUgPjbWXEL3GWEqRKpQAVZ0WEEJHaAVMTP+2KAMpkW/V+fvm+M4bqXEO267azwFzCVvGtv1YX/xDDMC+rKmAmD0cAKVcwvcCqZ1G/aBiyKE1LV+gTqcClT7GHCtr5oIHGOKBiiVCwP+VmdtjBLfT8iF825WSynaT6zf0qyEPDd/+MTOhDISSw14IKkEpuvAxlGOjcU5UcZu6n+YUJGO39XmfgfwpgBDFsSNRefX+gane3p43FnAHpzcfb9aQQ1asIerDkx73vD4eDOpEickcUzUuL20/OcYmQIt0Qvb5rBsWXQWQh8MlcYAD8wapPpAE1H7xL7uwjhKajI+RajpwNws4DxU23oIMuxqHeryjAjTAhLjtVpxSPSr8whrhsOcDH2rdk5va3dMYx3aA42Mum8FszU/fAv7y/nxcBGZfAuVuX1G+eaPf1YXJvBg8OsMMMC9vbDkW0AdUjAlg5u4TkRr4FGPzQXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(4326008)(6486002)(86362001)(9686003)(8936002)(5660300002)(38100700002)(83380400001)(6512007)(45080400002)(966005)(66556008)(2906002)(66476007)(54906003)(44832011)(41300700001)(33716001)(5930299009)(6916009)(316002)(8676002)(26005)(6506007)(6666004)(66946007)(53546011)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hEH6y3y/rBbs3N7qgQp9x4YhBMG/uxmNoU872gm5n6rlFrMeg6IpjeVuessW?=
 =?us-ascii?Q?0P2rYfcUIZX1AjY1uE4eBA6IZ9qdeymBi3990TLHJqgiPbVyUsKHQSR7jHAG?=
 =?us-ascii?Q?DtL+Mm28/PBBK0lCjvMadL8r0xmYTjpAi8GCOII+tv95CXI7r938EhWRgcVz?=
 =?us-ascii?Q?mn5qWL1hO62MVkYbJHHLI8daNzPIuK7GxnoDgLqq3rxFHRuWHliEQdff53Ej?=
 =?us-ascii?Q?NWYQeu9SngayT6p1iiRrAabgkcE50MPZeg+D6/QWiJE48pSbOVWQ5qS7bvx5?=
 =?us-ascii?Q?KDeKtZxCg498x7JA6ufHsjsYBmD7526xObc0IQaLHH+UyRO3cZwhmpBcOlvj?=
 =?us-ascii?Q?xmxezl3LGG+0Ewjr8nUxxcRYCTBGfcFJ1vUtmK9FCEjjmx01JBEBAAKUeU4K?=
 =?us-ascii?Q?WH592aug3nseKZ9lPgWWtQwTtasvbuii760F8iGgY+zlJ0el9r1kQOmsN6y5?=
 =?us-ascii?Q?TED6apvpApOuRUk4mUAnu15iI7HCTthQxToYe6nS1+fY+87wzJsl5x4uJg4E?=
 =?us-ascii?Q?SlQQW+XzCuB0ucRBifsSSR/StL77/MAf5dfWrVCF7Rxayj9jERoZBiZkOyYB?=
 =?us-ascii?Q?M3TYZNSF1ZtTiqMbxNKFa4UgYfkebYticjxJuDrH0wBeIsMLSTPnPrHvpkeF?=
 =?us-ascii?Q?DBFjpWx0wUpxUKTyvOJVMEUB7z7hdbcyUqsSCazHR+bmQoaj9/FOUAmJDN9N?=
 =?us-ascii?Q?uRzax7TiJ/fDxymPMIJ6iHxYRi97b/G3ERoqOW42bA94f87M77WAU64pKq2N?=
 =?us-ascii?Q?Y/NpyQltJKcLF6GwZAXQgXRe0dP4ZaERVrKpeYqS37b4IAnXuTeHdHD+Jpec?=
 =?us-ascii?Q?0RvqL8m+YqevFfteJdPuT41orxhmuPyVpwg3/tn1vGcbAvRP4ozHwFtzLCHd?=
 =?us-ascii?Q?Mq3Q7EuZcDusKMM/VZ8r7HFVpyTXNDexhf3+6fLDW1NDb8r9tv6/y4Rsxvg0?=
 =?us-ascii?Q?s7+MjG3zTBuqfyaHCPo1Qqc4j9duuOLWdEtFykc5r17q8wQRIo+1yTeRMlkW?=
 =?us-ascii?Q?QOCcLXfGe4TxK8mcpGDI8oxLDD6vAiuylNuCdnxpBKnAdyWuUpJCwm8/G/WL?=
 =?us-ascii?Q?oZCl36V/rsYKo+dOc7Hrajw4pfZJI/AErJeHVvnqr5Q7Ht+iGnDJ6h4i/w9J?=
 =?us-ascii?Q?KkGSZXSqmGKdYm9s40HPRVEKZLZkfZsb0h865VyvAYgzG7ezeyOauttIA7l5?=
 =?us-ascii?Q?VALR2yhYDDE5OsUQ5PP2VrvkPhooMANbrtvaQjVdm/jxLKzbZgOY2FmUNP89?=
 =?us-ascii?Q?1fG2TERh+LGWVrY/bLJVFd9FnsPgJ4hVyyVhV+gKlnlEqSl1IKJvsjwqZEmV?=
 =?us-ascii?Q?cbtCkDceaLpneWMpE/fxSIzV2Rp3oAoxLze2BBT2HMI97vD9LySAINR+RIDX?=
 =?us-ascii?Q?yc2SeiEZ9wz9F6PxnogfOe10iLhOisY2RGqqyQZcuxJp4zt5nLqBbUv/yu9/?=
 =?us-ascii?Q?Yc4x/9ZKP8yAB/31WiHC92sRhqFSst2QxqTOaj8sYWLD4iHcYhrFrZR961Tq?=
 =?us-ascii?Q?QWt66fYRdvmk7au+O8zsyYN5WiFPKuKsHLwsed6fBX/NVR2w0k+SQNDrp/n3?=
 =?us-ascii?Q?xEs2XG53wZ3r1lZwGu2aDc7rfCarwtlpfyug5JMJ72Y6cmUH7iUnE7ufC45b?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf9112a-17f4-4dc4-59db-08dab2bc7109
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 16:59:25.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpHi4RIMWWYHmA/HdWSv534qc3TJ1tDilSIcg530UqhGeh32xV2cCwjSkfHyaxZa8uiM8okF7M2Zv4n1eZMrMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=672 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200101
X-Proofpoint-GUID: _7U5ne8GX2fDYJPYOhYNPGOCH2BVUG1x
X-Proofpoint-ORIG-GUID: _7U5ne8GX2fDYJPYOhYNPGOCH2BVUG1x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 00:21, Wei Chen wrote:
> Dear Vlastimil,
> 
> Thank you for the reply. The bug persists in v6.0. Here is the
> information. Luckily I got C reproducer this time.

Ooh.  Looks like the reproducer is doing a MADV_DONTNEED on a hugetlb mapping.
That support was added somewhat recently (5.18).  Not sure if it is related in
any way.  Have not looked at the code/implementation around write_protect_seq.
-- 
Mike Kravetz

> 
> HEAD commit: 4fe89d07 Linux v6.0
> git tree: upstream
> compiler: clang 12.0.0
> console output:
> https://drive.google.com/file/d/18oQROgRr2u8jzgV83i9xHmoCEXN7PQ8b/view?usp=sharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1g5DwpvjI_-I3bBkYrLeoQTFFcSBw2bvY/view?usp=sharing
> C reproducer: https://drive.google.com/file/d/1ZMiiTqx0Qh-7A9ucb-0kq0civg_sXB7X/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1ZHRxVTXHL9mENdAPmQYS1DtgbflZ9XsD/view?usp=sharing
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> 
> kernel BUG at include/linux/mm.h:1529!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 6605 Comm: syz-executor919 Not tainted 6.0.0 #35
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:page_needs_cow_for_dma include/linux/mm.h:1529 [inline]
> RIP: 0010:page_try_dup_anon_rmap+0x703/0xc40 include/linux/rmap.h:253
> Code: 31 ff e8 30 d6 b4 ff 4c 89 e0 48 25 ff 0f 00 00 0f 84 39 01 00
> 00 e8 6c d1 b4 ff 4c 8b 74 24 08 e9 b4 fa ff ff e8 5d d1 b4 ff <0f> 0b
> 4c 89 e7 be 08 00 00 00 e8 9e a0 05 00 4c 89 e0 48 c1 e8 03
> RSP: 0018:ffffc900051ef270 EFLAGS: 00010293
> RAX: ffffffff81d247c3 RBX: 0000000000000000 RCX: ffff888044b22440
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 1ffff11003f580ef R08: ffffffff81d243d0 R09: fffff940000fe001
> R10: fffff940000fe001 R11: 0000000000000000 R12: ffffea00007f0000
> R13: dffffc0000000000 R14: 1ffffd40000fe001 R15: ffff88801fac0778
> FS:  00005555564ba940(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200002c0 CR3: 0000000014ad2000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  copy_hugetlb_page_range+0xc86/0x1eb0 mm/hugetlb.c:4846
>  copy_page_range+0x424/0x1b40 mm/memory.c:1288
>  dup_mmap+0xa72/0xf80 kernel/fork.c:699
>  dup_mm+0x8c/0x310 kernel/fork.c:1525
>  copy_mm kernel/fork.c:1577 [inline]
>  copy_process+0x2b92/0x6130 kernel/fork.c:2254
>  kernel_clone+0x21a/0x7d0 kernel/fork.c:2671
>  __do_sys_clone3 kernel/fork.c:2963 [inline]
>  __se_sys_clone3+0x357/0x400 kernel/fork.c:2947
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7efee9f6102d
> Code: 28 c3 e8 66 2a 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 c4 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffff00b0558 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
> RAX: ffffffffffffffda RBX: 00007ffff00b0568 RCX: 00007efee9f6102d
> RDX: 00007efee9f6102d RSI: 0000000000000058 RDI: 00000000200002c0
> RBP: 00007ffff00b0560 R08: 00007ffff00b0560 R09: 00007efee9f19460
> R10: 00007ffff00b0560 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:page_needs_cow_for_dma include/linux/mm.h:1529 [inline]
> RIP: 0010:page_try_dup_anon_rmap+0x703/0xc40 include/linux/rmap.h:253
> Code: 31 ff e8 30 d6 b4 ff 4c 89 e0 48 25 ff 0f 00 00 0f 84 39 01 00
> 00 e8 6c d1 b4 ff 4c 8b 74 24 08 e9 b4 fa ff ff e8 5d d1 b4 ff <0f> 0b
> 4c 89 e7 be 08 00 00 00 e8 9e a0 05 00 4c 89 e0 48 c1 e8 03
> RSP: 0018:ffffc900051ef270 EFLAGS: 00010293
> RAX: ffffffff81d247c3 RBX: 0000000000000000 RCX: ffff888044b22440
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 1ffff11003f580ef R08: ffffffff81d243d0 R09: fffff940000fe001
> R10: fffff940000fe001 R11: 0000000000000000 R12: ffffea00007f0000
> R13: dffffc0000000000 R14: 1ffffd40000fe001 R15: ffff88801fac0778
> FS:  00005555564ba940(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200002c0 CR3: 0000000014ad2000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> 
> Best,
> Wei
> 
> On Fri, 14 Oct 2022 at 15:54, Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 10/10/22 14:25, Wei Chen wrote:
> > > Dear Linux Developer,
> > >
> > > Recently when using our tool to fuzz kernel, the following crash was triggered:
> > >
> > > HEAD commit: 03c765b0e3b4 Linux 5.19-rc4
> >
> > That's a rather odd version to report against, now that there's v6.0 final?
> > (not to mention 5.19 final, months ago) Or is v5.19-rc4 just the first
> > affected tag and the bug persists until v6.0?
> >
> > > git tree: upstream
> > > compiler: clang 12.0.0
> > > console output:
> > > https://drive.google.com/file/d/16ht-2pDp_nU_nXhobMfHaQraVt4qfzBK/view?usp=sharing
> > > kernel config: https://drive.google.com/file/d/1lNGU17X6Ui1NDLE4XCRu3I6f9lzhCBcH/view?usp=sharing
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: Wei Chen <harperchen1110@gmail.com>
> > >
> > > kernel BUG at include/linux/mm.h:1585!
> > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 0 PID: 20332 Comm: syz-executor Not tainted 5.19.0-rc4 #1
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > 1.13.0-1ubuntu1.1 04/01/2014
> > > RIP: 0010:page_try_dup_anon_rmap+0x927/0x1120
> > > Code: e6 ff 0f 00 00 31 ff e8 87 75 b2 ff 4c 89 e0 48 25 ff 0f 00 00
> > > 0f 84 0e 01 00 00 e8 c3 70 b2 ff e9 43 03 00 00 e8 b9 70 b2 ff <0f> 0b
> > > e8 b2 70 b2 ff 4c 89 e7 48 c7 c6 80 96 9e 8a e8 03 91 ee ff
> > > RSP: 0018:ffffc900088e7368 EFLAGS: 00010287
> > > RAX: ffffffff81d29967 RBX: 0000000000000000 RCX: 0000000000040000
> > > RDX: ffffc900084b9000 RSI: 00000000000023c4 RDI: 00000000000023c5
> > > RBP: ffff88802e3a0670 R08: ffffffff81d29420 R09: fffff9400011d001
> > > R10: fffff9400011d001 R11: 0000000000000000 R12: ffffea00008e8000
> > > R13: dffffc0000000000 R14: ffff88802e3a0670 R15: 1ffff11005c740ce
> > > FS:  00007fa374806700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007fa3737b8000 CR3: 000000002f26f000 CR4: 0000000000750ef0
> > > DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > >  copy_hugetlb_page_range+0xc9d/0x1cc0
> > >  copy_page_range+0x424/0x1b40
> > >  dup_mmap+0xa72/0xf80
> > >  dup_mm+0x8c/0x310
> > >  copy_process+0x2b3b/0x60d0
> > >  kernel_clone+0x21a/0x7d0
> > >  __do_sys_fork+0x9e/0xf0
> > >  do_syscall_64+0x3d/0x90
> > >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > RIP: 0033:0x7fa373695c4d
> > > Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> > > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > > 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007fa374805c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000039
> > > RAX: ffffffffffffffda RBX: 00007fa3737bc0a0 RCX: 00007fa373695c4d
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 00007fa37370ed80 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa3737bc0a0
> > > R13: 00007ffc0a3c127f R14: 00007ffc0a3c1420 R15: 00007fa374805dc0
> > >  </TASK>
> > > Modules linked in:
> > > Dumping ftrace buffer:
> > >    (ftrace buffer empty)
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:page_try_dup_anon_rmap+0x927/0x1120
> > > Code: e6 ff 0f 00 00 31 ff e8 87 75 b2 ff 4c 89 e0 48 25 ff 0f 00 00
> > > 0f 84 0e 01 00 00 e8 c3 70 b2 ff e9 43 03 00 00 e8 b9 70 b2 ff <0f> 0b
> > > e8 b2 70 b2 ff 4c 89 e7 48 c7 c6 80 96 9e 8a e8 03 91 ee ff
> > > RSP: 0018:ffffc900088e7368 EFLAGS: 00010287
> > > RAX: ffffffff81d29967 RBX: 0000000000000000 RCX: 0000000000040000
> > > RDX: ffffc900084b9000 RSI: 00000000000023c4 RDI: 00000000000023c5
> > > RBP: ffff88802e3a0670 R08: ffffffff81d29420 R09: fffff9400011d001
> > > R10: fffff9400011d001 R11: 0000000000000000 R12: ffffea00008e8000
> > > R13: dffffc0000000000 R14: ffff88802e3a0670 R15: 1ffff11005c740ce
> > > FS:  00007fa374806700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007fa3737b8000 CR3: 000000002f26f000 CR4: 0000000000750ef0
> > > DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > >
> > > Best,
> > > Wei
> >
