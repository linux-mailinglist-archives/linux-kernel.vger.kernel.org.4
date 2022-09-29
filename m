Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633E85F0173
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiI2Xev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI2Xer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:34:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7609FF7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:34:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TMiePX010320;
        Thu, 29 Sep 2022 23:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=zR93yQYl3RohDwjhzbF3AOlc6fZg/H8N3qAlxoBlg1I=;
 b=1JYofPgohUBzVVultJat1/9RK7Aua1nyqc3apm/aKbs4gksoz4DpkEsPd0t6MiWPHPCf
 UBLhGZnrqzxpjT2LcMNbkZkO9QZMIHruV0kH+eRq8tFli7FHxpEt37aDUuKj1SteP5Bu
 E/DISSokoN5eYM9OA3cMENGy6ymwUA9WdmyK1jCAWdsd+hlQK1vvFQ9SnAL0vbh/96qv
 p7zaTu7APpExL2zt1vH+WNJuOtqvzK1mb7ZNgqyibXQ1po1HBB5zQC9Vjlqz/M3QlRaL
 CmqrJqKpmWU8q272CsYvU1xYiNSSfnUk0Zhfkl3WFjNanWytQqg4zByHzbRQbRFABA2o cQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssubpe1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 23:33:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28TN0OdW033639;
        Thu, 29 Sep 2022 23:33:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv3ccxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 23:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEIYS1wJHkow+ScLD0dX3WIbMG0Hfr/8o0ObAGeMSAyhtePooi/9/ze0+sC1ASSgj4ciT/mEgM63S8wEFymPjN+D/VLHxEDGDk1V04T6ZMl5D7kOyouIYnRAHKE4QcI6GUVUy3DWkf2QiXpwYXMCQIIXG1Jp+YJ8mnUnzhS+8KbmLipWoB+3bOt5g7K/pqcKmP7/B901c7Fzd1QST0QRHsbDT24l7swwayuPPMDep+PBkTvfRQKSyM+cTXOwohoeAo94FMDcwExx4KAKxz4OEl7L+Tymx5PmjEy3zuQCpaf6r1HCOCueVpYBOIMBkaUhUbqYY5GKnQRd1G6x6Eae2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR93yQYl3RohDwjhzbF3AOlc6fZg/H8N3qAlxoBlg1I=;
 b=WG5kXkri+40SuxLYINac9iTlzj3bhYMpHFzpwkM34F4ddkVRjwg+g97Hy55pmZT/+QqMK1+h4N3jtgu2jd4npkyT3SJzB3wd1YZZUEH/yxGKJHpzZ2S9VhWM83cDFicBlAmCq+pkxX6hchiBSInT/v8NrdZpKIDGVG03+7UXkOKA26jbfeXblxhdK1oTGK4c3IimsNvDIb6Sw36UpSceHjUO0fnkFho0dokrIEt0Yc+aos/XZSQWMnrysNTvojnflE2EtyO/bfhaO0H3PzZAlEmnnEwzhRUn9XVJV76flickBG7uKnhuUZ59pXP1/zJLCVIAo9w7884CmqfsRrquKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR93yQYl3RohDwjhzbF3AOlc6fZg/H8N3qAlxoBlg1I=;
 b=dXQ3wE52TBKSdz//7unBOQVPQ6n7i1qDHM79cSGv+vdB8xICDpEXv12qBbnYUSGPeg1axlPRUkF5jX48bqR1vv/uZgr3h939bcLcsfBwVAQwbS0H0XcwPkWBOM29oWYdJFudQ1dUpe6mKxzVTMnlP/TBs2pUN+56kbzX1D2QM7A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6061.namprd10.prod.outlook.com (2603:10b6:8:b5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Thu, 29 Sep 2022 23:33:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 23:33:56 +0000
Date:   Thu, 29 Sep 2022 16:33:53 -0700
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
Message-ID: <YzYrYVeA0b9d5dos@monkey>
References: <0000000000006c300705e95a59db@google.com>
 <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
 <Yy5WHvioerD2Sev1@x1n>
 <Yy8dBrmvDmqlsRXE@x1n>
 <Yy9T/JmVb4ymf6WM@monkey>
 <YzDuHbuo2x/b2Mbr@x1n>
 <YzMjxY5O6Hf/IPTx@monkey>
 <YzMomT+OusJnLOPC@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMomT+OusJnLOPC@x1n>
X-ClientProxiedBy: MW4PR04CA0342.namprd04.prod.outlook.com
 (2603:10b6:303:8a::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e16251a-15ad-4caf-5870-08daa27313d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffCce9Mx8THWiRyIV3GfMNEpmOVVTcPLY+FjaGyGxACu8C8XMFzTVvU+1wXzsmFat8SWSTqNU2MqRCHNAyGpS6r3ULgE6izyi7DxIiuVlusuka4DUv8Tgz6nf9paVa9UDgFyDOQRoW2uraJ5kSvcydrmJMTnyD5x4ygRLF0/rGxpSkpVSXQSlP3oppwaR8PkRAYE6bXYCggDGuGm8D8pfd1giAQZAlMVW7utzE5xW6CA0BfZRPA+dzRyGq/x5GafBPXxaGaRsQSVgmyBu2OKixO7dYDeHuIMXBQoqMaJ1O8mDefak2TMk6no6yHRuOVwutGN6wfEu1dzl6JmSjPz/3RD3/mTCPJ1y4EBxKtTmz1jvGXHiODjrEKILXuNuAJqeKawFRXXAbybks6Ea7GAJpcWUeJ9fgZAKJ61AN/zoTAGFIcdpxqe0ixK/fpogBk3wZ+b3bMbfvh2k18fvdxSnpAId4+iKe6HBqrtatQmDEzHLd4AFLXO0fd3IQDcqX5q9f1wt64TM8ygWChl+3bj8WP4mAyssdB2ilCHm412dgcEmUUklo3MFxG1GAZPPUeUJk/ICEQDumgZ3cyUdpxEULA2XHLaQf7A5V+1Z4ZETwVIHlDaZ97Fp2qyzZ4h+gSjz4FAu6FbW7GVpwQ8ckGFSd8sIH7EKBOkwxLniHTL7EdNUi4trbYbEnTjuzHEpbRdcZPR5bKx01QXHCfZiPf54Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199015)(6486002)(478600001)(41300700001)(44832011)(6666004)(83380400001)(38100700002)(5660300002)(7416002)(4326008)(86362001)(66476007)(66946007)(66556008)(53546011)(6506007)(9686003)(6512007)(8676002)(26005)(33716001)(316002)(54906003)(6916009)(186003)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/dpWT7CS/RzxqUJ8x3p+WjO25CTulcxUTzaqU4VbgXTeS0ROj65ktoyGKnkl?=
 =?us-ascii?Q?hRpXou0exUF0w3iZnhXiVArFyPJrwJxWq9WAqG8qr82e3LOI82Xr4gf+f50o?=
 =?us-ascii?Q?HC3U6z1lq9aZTw7Dqc9Z7q4JaO5SDqeOZeMbTBNA2TQDARXmzf/ULbJ/g/3m?=
 =?us-ascii?Q?xJUamaAHm+jK7vnIUV4RUecLMma9ortHrC3Au0xLDecK1xrOI8jFG/ziKeXf?=
 =?us-ascii?Q?zw4gb+SeF9VCADKWmkmKLbkUrJdvqtfu77974rvMc6xx3w33pHTXcn7cEE7o?=
 =?us-ascii?Q?oatl8bLXMpaW3zM16VjnI4KN0xvs1jzt7phmBTJpQMjQl2m76MzQTuqC6QcS?=
 =?us-ascii?Q?yb6PHPueJ7J4+A+js2ETVFRawMXpwk0TtXN8uvdk/fajsEYtwd1PRd4qLBQ+?=
 =?us-ascii?Q?HXgKD5VzXqE8/28wavEctX8s9Yuzr0dl7nGcuwqG1YF7++FOULJ42R+mz4Ul?=
 =?us-ascii?Q?EZOmQcJwwM5qJGYXqjAeOtbtsij6+lfxRqMVX6rBglNMVn1D3at+h3DcolqR?=
 =?us-ascii?Q?1IWeEyLmUIaD88Cu9yh3hCb8wXlUJyLVatzYKsu6oWwI97c5nwEML2nIyohV?=
 =?us-ascii?Q?dej0xdPEGH2EecQnSbEQ12Gtvk8QUVw/xBeORtfL2V4Wt7eYlU8RHlZSOt0t?=
 =?us-ascii?Q?VQdJNYTeXMTuE/pPKN+V/kmN8TUrxsXeIGwJBWBPWl/XYvG1uJiMzS1As5gW?=
 =?us-ascii?Q?G0zUlnBLKJ2WA9dx51JAU0QZa0lDXjBGCj0GEfVsTcC55jAwMLppXZCdg/fh?=
 =?us-ascii?Q?4+s4PotlRf8/5p69HbhZLTmDWHP/qSgU3wItUff1mpv2ShKvk63YofJ93qYD?=
 =?us-ascii?Q?THpvEPhMUAqFUFhCP7mhSNbD8+HRy44jrq53/sJ6rBvLUPf/aFqZLQyxLvaR?=
 =?us-ascii?Q?zpPmARSxlohsuzG7mhU6Bte0VV0pttsYvbyN6YAwR/Kn3cMEUacrwFNwC/Ha?=
 =?us-ascii?Q?TV9GGj7A+h2G4PUtINqU0VMz1Cnj2h0ANx17k0ZwNe/UJxzwJeKbp5CFH3YZ?=
 =?us-ascii?Q?Jy1KaeqVVDDDJfWSCnsdWsSgqFC1PtwjnrQVj1d2yUgW0GirCGisDbWc0bDJ?=
 =?us-ascii?Q?EgrJ1PJoXnhVNqYg4lcQExn89S4kn2aewqKNH9lmpt4RsQY5g9336bfCod1b?=
 =?us-ascii?Q?1IsOM1qVhWoYuU5zmvSUITcuxSJpH/XPvFsMyBxeddOz5TyTCPfsuWGoaVku?=
 =?us-ascii?Q?nQiPv7Lg4h/PfICFSEiQMXQi8UdQFLcPcQ/1NcnLPHQ7k2toIq18PBG6LLsn?=
 =?us-ascii?Q?cQj918URgHPUQHT9WPMnLJuTfIpXDA4PL55GPugcE2irpgAs9+rTp0aElz2n?=
 =?us-ascii?Q?yfBW8oOKUug7MvwGNaYpyRVDIUjuFO66TFRqCoY5q6myRzm/JJXwkkyqoBd1?=
 =?us-ascii?Q?MpPzXb6qlMzx7+gKzXumk1jJAqwZo/p5Hd+Cx+Lb7GJQCX8TQTWJDnMXw3EH?=
 =?us-ascii?Q?0EkoWYmWRz7hF6bJLYR0eznKy+1ZWroXNsGDQA9a2E2Wt81ckndWReeakuFZ?=
 =?us-ascii?Q?j3csSqQkluSjdopsJbYW2hozCQFsdr1FHQgWwNsTS9orjasgu8RbvQuNG4bv?=
 =?us-ascii?Q?5jW0HNNy19nkCTd3fH8L/YiRTmbEZYQuXKxbzUq5WtpEo3pwLLts0b3eKA+x?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e16251a-15ad-4caf-5870-08daa27313d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 23:33:56.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOUo6zDSTvdzzMWh+UmVwngmpdnrQIvrK6tP1yd8sDvcIg3zsZWD0BGSPdw8mnasXBllG+CWVRcZZaaJLU7q3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_13,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290147
X-Proofpoint-GUID: CZQJvW3ygikdgIJHCkPO5B95hLxNR6hs
X-Proofpoint-ORIG-GUID: CZQJvW3ygikdgIJHCkPO5B95hLxNR6hs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/22 12:45, Peter Xu wrote:
> On Tue, Sep 27, 2022 at 09:24:37AM -0700, Mike Kravetz wrote:
> > This should guarantee a read fault independent of what pthread_mutex_lock
> > does.  However, it still results in the occasional "ERROR: unexpected write
> > fault".  So, something else if happening.  I will continue to experiment
> > and think about this.
> 
> Thanks for verifying this, Mike.  I didn't yet reply but I did have some
> update on my side too.  I plan to look deeper and wanted to reply until
> that, because I do think there's something special on hugetlb and I still
> don't know. I just keep getting distracted by other things.. but maybe I
> should still share out what I have already.
> 
> I think I already know what had guaranteed the read faults - the NPTL
> pthread lib implemented mutex in different types, and the 1st instruction
> of lock() is to fetch the mutex type (at offset 0x10) then we know how we
> should move on:
> 
> (gdb) disas pthread_mutex_lock
> Dump of assembler code for function ___pthread_mutex_lock:
>    0x00007ffff7e3b0d0 <+0>:     endbr64 
>    0x00007ffff7e3b0d4 <+4>:     mov    0x10(%rdi),%eax       <---- read 0x10 of &mutex
>    0x00007ffff7e3b0d7 <+7>:     mov    %eax,%edx
>    0x00007ffff7e3b0d9 <+9>:     and    $0x17f,%edx
> (gdb) ptype pthread_mutex_t
> type = union {
>     struct __pthread_mutex_s __data;
>     char __size[40];
>     long __align;
> }
> (gdb) ptype struct __pthread_mutex_s
> type = struct __pthread_mutex_s {
>     int __lock;
>     unsigned int __count;
>     int __owner;
>     unsigned int __nusers;
>     int __kind;                                              <--- 0x10 offset here
>     short __spins;
>     short __elision;
>     __pthread_list_t __list;
> }
> 
> I looked directly at asm dumped from the binary I tested to make sure it's
> accurate.  So it means with current uffd selftest logically there should
> never be a write missing fault (I still don't think it's good to have the
> write check though.. but that's separate question to ask).
> 
> It also means hugetlb does something special here.  It smells really like
> for some reason the hugetlb pgtable got evicted after UFFDIO_COPY during
> locking_thread running, then any further lock() (e.g. cmpxchg) or modifying
> the counter could trigger a write fault.
> 
> OTOH this also explained why futex code was never tested on userfaultfd
> selftest, simply because futex() will always to be after that "read the
> type of mutex" thing.. which is something I want to rework a bit, so as to
> have uffd selftest to cover gup as you used to rightfully suggest.  But
> that'll be nothing urgent, and be something after we know what's special
> with hugetlb new code.
> 

I was able to do a little more debugging:

As you know the hugetlb calling path to handle_userfault is something
like this,

hugetlb_fault
	mutex_lock(&hugetlb_fault_mutex_table[hash]);
	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
	if (huge_pte_none_mostly())
		hugetlb_no_page()
			page = find_lock_page(mapping, idx);
			if (!page) {
				if (userfaultfd_missing(vma))
					mutex_unlock(&hugetlb_fault_mutex_table[hash]);
					return handle_userfault()
			}

For anon mappings, find_lock_page() will never find a page, so as long
as huge_pte_none_mostly() is true we will call into handle_userfault().

Since your analysis shows the testcase should never call handle_userfault() for
a write fault, I simply added a 'if (flags & FAULT_FLAG_WRITE) printk' before
the call to handle_userfault().  Sure enough, I saw plenty of printk messages.

Then, before calling handle_userfault() I added code to take the page table
lock and test huge_pte_none_mostly() again.  In every FAULT_FLAG_WRITE case,
this second test of huge_pte_none_mostly() was false.  So, the condition
changed from the check in hugetlb_fault until the check (with page table
lock) in hugetlb_no_page.

IIUC, the only code that should be modifying the pte in this test is
hugetlb_mcopy_atomic_pte().  It also holds the hugetlb_fault_mutex while
updating the pte.

It 'appears' that hugetlb_fault is not seeing the updated pte and I can
only guess that it is due to some caching issues.

After writing the pte in hugetlb_mcopy_atomic_pte() there is this comment.

	/* No need to invalidate - it was non-present before */
	update_mmu_cache(dst_vma, dst_addr, dst_pte);

I suspect that is true.  However, it seems like this test depends on all
CPUs seeing the updated pte immediately?

I added some TLB flushing to hugetlb_mcopy_atomic_pte, but it did not make
any difference.  Suggestions would be appreciated as cache/tlb/???  flushing
issues take me a while to figure out.
-- 
Mike Kravetz
