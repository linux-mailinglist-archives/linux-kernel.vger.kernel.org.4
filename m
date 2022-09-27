Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E9C5EC96C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiI0Q0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiI0QZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:25:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BBF17E01
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:25:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RG0bA6016719;
        Tue, 27 Sep 2022 16:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=qshxxYGDqaD/Bs6phAzd4sVoSVbn4cVL2NimfoMAr6U=;
 b=Pg2P0aretV/2+bSgvRDzWYnL48vg4pmT4xr2bjP9fjb/IlJmavhMbsqPif091nBCHPU/
 vNa+LHwJ6xiGiHLd74rfLGQDZee0vsF8F1PEPh8SITe1h06IDRZ1eGDtwLquAeJh28oJ
 LsGEJA/8k+Nx1Mk7yeo3jswPsJrR4dDz3rF+5i7DABxkttV2kR5kJkAKYHW5J87Fu7xc
 fnARCxijRsuXxCuzqoTKHtb2MT0iG0gAd3FL8MFmLV80rMMJaUvGjzy+PKP/uV+oQXWH
 lNqABBh2z2lgiTlh05hlApxookFAlwc2w4KwruIKoCWIf6c33ryU2avjQxB/G7GQJwwD dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst0kq3rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 16:24:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28RFKJBm019173;
        Tue, 27 Sep 2022 16:24:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvef65w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 16:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOYstKXv38e0s/kJ3wwlf4dwD742AtrVMyU4eBy7nPoqYIq+cyk/g+r+fZf7H0qmI+rIo2B7eVdffFkNaoSoHaC4/874h/5864v8WbebYS+19+mYQVww5kskIovwYhI7cYmKD5usqSaOAqH8Zoz7pQ7apBrwX6YEeni1Z+R9CvcS4a1OChf96Ip5Sgy79ryyuRxKfWRoaekOluLuGxKYj+MyYILMTKXEYSjKe5EhiJK8SBZEgtb9hd+g0hF9j8mPJ8HOwGEZzjrxN02zI08StjSFjJHOX/GiGZ4fXxIA0KfjOqzUyHZCAa8u9Zvhx5bZVUJDz9OlmwSAeDNgsda8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qshxxYGDqaD/Bs6phAzd4sVoSVbn4cVL2NimfoMAr6U=;
 b=JxFJym8iiZVi8p/veqG7AmKaB4XpA8CscxLgHd+IfwzBA7XSk1xQIwmBQD6ApjqYNsjl+8FZlv8yZzKlFIRZCIa5khc1B9Awa+9fWmj6mnUn5dckNQiw8Fz4hXVlOJmwyCaWOxnQ1GXgDkz/kuoc+jT17MWfrFqpcFRy7shjJDLzA3Z6RAJrI59+G3i2J2pGdeNDT9qpvX1jm+bmHH948TEP7eCGwLTwB9cF5zoNpSrMd80+mxgeABqNKQQVmSHwBayaWugTM3bl875ZdyoGhMf9BTnjgBBCZ5QMIN+addvbTzL/x739bjFpG8QsjOTCimBFcECJ94x7XHiEfxHDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qshxxYGDqaD/Bs6phAzd4sVoSVbn4cVL2NimfoMAr6U=;
 b=bpcahFjNSdDVTTSbje3jum9hXBGG1B6fOGs0/fETqcT9Ji9QVSsRcHMQvwsWZ5lSDFFaB/jGuBXscmjXtANI3z3BmrxlN8nICmZ/Hs6VRJ/oeU4e++ylKj3G/PIjksgXBbtQF3l7SH3mXF8HrIaZRpFs5vltf6ti0vGqLIz97Vk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Tue, 27 Sep
 2022 16:24:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 16:24:41 +0000
Date:   Tue, 27 Sep 2022 09:24:37 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-ID: <YzMjxY5O6Hf/IPTx@monkey>
References: <0000000000006c300705e95a59db@google.com>
 <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
 <Yy5WHvioerD2Sev1@x1n>
 <Yy8dBrmvDmqlsRXE@x1n>
 <Yy9T/JmVb4ymf6WM@monkey>
 <YzDuHbuo2x/b2Mbr@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzDuHbuo2x/b2Mbr@x1n>
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 45751545-0be5-4a53-f304-08daa0a4c747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5uFLAvImx/FcG/MJbX0za7imX75/G/gnkt+5/s61S1VnjFDSXoOEFRGN1lI/+rGIlpM/oNA9vXAmuI7DaVtLSjPmL2aVUamYQpQ0yqkjpkqazQGOM0NO2CRLhtNX7uMESENVf4fOtYPvKKutDef3G4yDm04oboHlb41cxIgzk8sTOn8dB/s0qJ/pJLejbp8twvrxbynooP2+3heERRghgmvtWoUNalmou173KC6uR99NU28clNMGb3/SIUNsSxsxS56FADbl1LsPoacDdJmD3HnoKO1NHctktEtNaaWh/mX35orH4BduaUc8a+NVe5mOvXuae8J+JNBTgePewIUeu/Fz/ZgMsUIfYKeQYFxmOZ+yxD9UAEnNqgdyJDMgKTOtq+pCHCa3+c2hF1wGI4wzFyESyOEzS8ceSx3TkwnHgwcOzZRYeT4Jy7Z+cOdEhlqt/r2vlwKfJp/Y2rKcX2tirg6Jf+lMipFo03Q2QBmkzT+S9V3jIV3mxyZbqC27NA+DWGrmly96XrtPeoDmAuyMNMidyn+fW7KXQT6xKIAPLyKgaHjHd3pbmLCIJ5vN92QCsZBLKDiEVmsmsF2OPG6yD5xDMz4QMC6/thdAGSkwjNjpFeKyNNxcq1Ih2uNpNwVjNhP2vyK2h4HSdoKpNQVVTvPmB/nrtva3ZUZEYST39Yx8mUj9V5jxS2/SymWpV+DsneETx15+3fpXlxVVSO64Ne0cuEwF3twyAPZtc7ThMPXcXHR6Ujtv/rHCLcuytDnYGyGKoT65CPwomwG0PSjVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199015)(38100700002)(33716001)(2906002)(6666004)(44832011)(8936002)(41300700001)(4326008)(8676002)(5660300002)(66556008)(7416002)(66476007)(66946007)(26005)(83380400001)(53546011)(186003)(478600001)(966005)(6486002)(6916009)(6512007)(86362001)(54906003)(9686003)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ObVMvXZpryYWJmwwFihViaH8Ky6usJcV0VSJgWf04KljaP2SH2W7JWgIZy7u?=
 =?us-ascii?Q?HkQu1MucEyR2z3xQHwfdVik/2zA1qOazxfgDX/Ck0DRRtgqnz6rPsdsLmI+T?=
 =?us-ascii?Q?HSgPN3TdBHYhFFDL6NeVjo5TiscOov42ktD2Alj7C0tSa9cg3Pienymgapho?=
 =?us-ascii?Q?ygASVy1yIiYErVztwTxW5bXmpwhRB4lofKDB1fJjCM5BxRMcdLyiSvJxI87b?=
 =?us-ascii?Q?qmxd481neq5nNh6VYNv1q60qcs7bRv4GpzvethlsaWgCZ+7nPwvfztpEERPm?=
 =?us-ascii?Q?SoXUbq2pUI/8BnTV4vT/I7M1IcMhEwiNVBhQPqT1AxC8STpW/Xqq3QeZiq72?=
 =?us-ascii?Q?/NUKMQkjDlou+t7KPW1e5+O6U65yjDyn2LowOCuedu0k5h9WJFPacP8mp569?=
 =?us-ascii?Q?5iDqkK9A4lYpu8w+oNuWiXu6H0WacSB8y74XpjWaPgeRkzI0ixjf2JPkzkA+?=
 =?us-ascii?Q?7N2spR+QQhJrQZUsZgvYJBoTljbeEacvyQSlslpQzkS74u8dl9KoW4NcF6qm?=
 =?us-ascii?Q?BrUTAKdKnFUQeVxN64Dn3UrR7krqrqSBuHsDE5FJDrtFK6hgaD0FxvegPUzy?=
 =?us-ascii?Q?cjGA+LJzeROp09aJI1dCezJ9l3Wrmo0JeHKtbpnUE1AsMU5+YK/Msl9uYvqF?=
 =?us-ascii?Q?/wDnnyGIzv+JzXgM9BUvnHGk1Z1mYdAkuoxfp0O5bemI3MEx7o+qIvl/pC2e?=
 =?us-ascii?Q?qmzi58B9pPsklgZ3wcAdnWiz7BsoU6E8u2QbKgOoYNzqrzQOb10v7qul/yFr?=
 =?us-ascii?Q?JSWgyXpNbdoQQurcL/7NF4cvLjzsww9ubIhWTsbMPS/fss3J6PpNkD8kgPxi?=
 =?us-ascii?Q?eB3wWIxsmjsixYwvCWtr9ozxerMzgzPHafC6nY0cMwFSyNcTGnBp5JhX5rzT?=
 =?us-ascii?Q?Z191O+ZHfcsE8Tp+kvim+DnDvDlHSlYDIdOEeeUW11v7kUsPrPILeiaqqNeN?=
 =?us-ascii?Q?sYWMy/WuqyC6BVBWrJTyQ7AvEIFEpdUsb1WKRINwxSk0kJ4mX8ii06u1hp6I?=
 =?us-ascii?Q?4DZqXEs87QcYRlQE7l7KH/z0YsKl3gxGMplgGKn2JPpTo7vTgYAPPeUVxAcz?=
 =?us-ascii?Q?SUOBDr4uLzKPkupM9dfhMlzMESacaLkwtsRz74YybizCYK4rOJsKWldvBOtU?=
 =?us-ascii?Q?M0exWz8S6n4SRta8M0OyodgdI1KPlfpALgonl0d7nXJiB0+aAB098H766n/h?=
 =?us-ascii?Q?P82rE/d2kmVF/BVoYN74d1SqhtgcvZ8Mko2IbjfJnn1wgCP/CWuXCvbqnYHA?=
 =?us-ascii?Q?afGjKf9v0Mq9QR23R2mLWYYgbdtjMNhlKjRo3jaavWyi++WFV6O48/VI74os?=
 =?us-ascii?Q?2IuNDsRBXKccxKPVxqs3CaJDinedEKGbhjqL3tMXomhfnWtxwckFAKFUkyyO?=
 =?us-ascii?Q?aHC4NGC3twkCssrQOrSG9S0IpOjRr/Y5ygwUKEFtpYo/S5PUJkyr25Rr+rQa?=
 =?us-ascii?Q?caPuuqN/ZU5knxiWItVbG+6x6z4b8c5rjbGlNn8FeAz93R/Ev/6hhPm3iyCb?=
 =?us-ascii?Q?vNUctphrvPqeiD4/z3fc39ehjkb6Uiru+rukjJMF/vJRhTmo+IAQ3cfxGf02?=
 =?us-ascii?Q?LyYDQIxus8xpUI0hCdXNscobGM1GHg1A0d1A6fe+HUzCYFgugye22GiXSlUO?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45751545-0be5-4a53-f304-08daa0a4c747
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:24:41.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40zeXaNs/UBrRmCKiqWSi+UfpM1ekHVWrMtA72xr+Hcn1y2oNaHs6Nh6hhNejOD9KVAsqCYlnoXzdzeweMbCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_07,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270101
X-Proofpoint-GUID: MsTgJPOCEHpfSWqdhFpXB6xznPEpCJ3f
X-Proofpoint-ORIG-GUID: MsTgJPOCEHpfSWqdhFpXB6xznPEpCJ3f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/22 20:11, Peter Xu wrote:
> On Sat, Sep 24, 2022 at 12:01:16PM -0700, Mike Kravetz wrote:
> > On 09/24/22 11:06, Peter Xu wrote:
> > > 
> > > Sorry I forgot to reply on this one.
> > > 
> > > I didn't try linux-next, but I can easily reproduce this with mm-unstable
> > > already, and I verified that Hugh's patch fixes the problem for shmem.
> > > 
> > > When I was testing I found hugetlb selftest is broken too but with some
> > > other errors:
> > > 
> > > $ sudo ./userfaultfd hugetlb 100 10  
> > > ...
> > > bounces: 6, mode: racing ver read, ERROR: unexpected write fault (errno=0, line=779)
> > > 
> > > The failing check was making sure all MISSING events are not triggered by
> > > writes, but frankly I don't really know why it's required, and that check
> > > existed since the 1st commit when test was introduced.
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c47174fc362a089b1125174258e53ef4a69ce6b8
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/vm/userfaultfd.c?id=c47174fc362a089b1125174258e53ef4a69ce6b8#n291
> > > 
> > > And obviously some recent hugetlb-related change caused that to happen.
> > > 
> > > Dropping that check can definitely work, but I'll have a closer look soon
> > > too to make sure I didn't miss something.  Mike, please also let me know if
> > > you are aware of this problem.
> > > 
> > 
> > Peter, I am not aware of this problem.  I really should make running ALL
> > hugetlb tests part of my regular routine.
> > 
> > If you do not beat me to it, I will take a look in the next few days.
> 
> Just to update - my bisection points to 00cdec99f3eb ("hugetlbfs: revert
> use i_mmap_rwsem to address page fault/truncate race", 2022-09-21).
> 
> I don't understand how they are related so far, though.  It should be a
> timing thing because the failure cannot be reproduced on a VM but only on
> the host, and it can also pass sometimes even on the host but rarely.

Thanks Peter!

After your analysis, I also started looking at this.
- I did reproduce a few times in a VM
- On BM (a laptop) I could reproduce but it would take several (10's of) runs

> Logically all the uffd messages in the stress test should be generated by
> the locking thread, upon:
> 
> 		pthread_mutex_lock(area_mutex(area_dst, page_nr));

I personally find that test program hard to understand/follow and it takes me 
a day or so to understand what it is doing, then I immediately loose context
when I stop looking at it. :(

So, as you mention below the program is depending on pthread_mutex_lock()
doing a read fault before a write.

> I thought a common scheme for lock() fast path should already be an
> userspace cmpxchg() and that should be a write fault already.
> 
> For example, I did some stupid hack on the test and I can trigger the write
> check fault with anonymous easily with an explicit cmpxchg on byte offset 128:
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 74babdbc02e5..a7d6938d4553 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -637,6 +637,10 @@ static void *locking_thread(void *arg)
>                 } else
>                         page_nr += 1;
>                 page_nr %= nr_pages;
> +               char *ptr = area_dst + (page_nr * page_size) + 128;
> +               char _old = 0, new = 1;
> +               (void)__atomic_compare_exchange_n(ptr, &_old, new, false,
> +                               __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);
>                 pthread_mutex_lock(area_mutex(area_dst, page_nr));
>                 count = *area_count(area_dst, page_nr);
>                 if (count != count_verify[page_nr])
> 
> I'll need some more time thinking about it before I send a patch to drop
> the write check..

I did another stupid hack, and duplicated the statement:
	count = *area_count(area_dst, page_nr);
before the,
	pthread_mutex_lock(area_mutex(area_dst, page_nr));

This should guarantee a read fault independent of what pthread_mutex_lock
does.  However, it still results in the occasional "ERROR: unexpected write
fault".  So, something else if happening.  I will continue to experiment
and think about this.
-- 
Mike Kravetz
