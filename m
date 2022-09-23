Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2310A5E84AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiIWVMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:12:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF82120BD6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:11:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NJEg3S023690;
        Fri, 23 Sep 2022 21:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0f5ll7nqXc7SD8+E1UwUgBJ+rl90tWz5TGK9gdu5+Qk=;
 b=OP91LUGKDLWSWjTzySokgAjvrheY2jJQPds3I69bmOVI6PfZSk2aQyjQ8siWFMob7yLZ
 UgmuvhaVuzNEt7Mq03y3CKgNzNXHo5PCqp/FEO9hgPh5Js17YilSMhe7fnjqxOwwiDZa
 0Zqe3rQRJF3YZdGSyHsuTq9/nVFwwp7YtyphGTXgucWy/E+5ypBgc5Y7uIpJFsLls0Sr
 fcqaVgiad8K+sM+rXghkLbk4kBPJVAROib1s5FN3p171INQiVdsjrZASegO1OqHv5GXl
 wQOHuwi8c1sn79c1keeS05nsZ6+pOtC85ueXOAjtsX0iU9yPCMndCuDTtmcN8f5iQ/eL Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rsknk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 21:11:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28NKMdDN031394;
        Fri, 23 Sep 2022 21:11:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39q41xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 21:11:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyJYenNxDV23Nqd1XoB8MTv7h4V1XX6roV8YIz4mQKJ2NO6cz9Qq/HsapM0ksHTUF4/z9maMPoAKUBonRTtpMbXYbmD0SuvpQTsa5MGaAp+/Mu7BJ12cPgzzacAUtfVwOb62U0PdC8x96gq18Gs2kVf+FdrusrJF+hPwOm/dWM6cpl2v764k6BDi3gVeVtKLturUWE+ylxFMfnJUsGicLDRx0O/M0waIWx495s3qu3qoQpKyavPjIc0GNx/ZtmNjS1v6Wv8et5EIkE38ilVUXzE+EivDYyQ/hrVeanhzACA9GgEP1AGKftB3MPCjJyo/9HbmM8LnMQy/3VqrSxAo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f5ll7nqXc7SD8+E1UwUgBJ+rl90tWz5TGK9gdu5+Qk=;
 b=U5vlAYzAOPoQBQEzM4SMpiCLFTNp+/ZONbQINUi/pghZKS5dGVDP5UDCFnXDZ3hddcbJn2guvAn3DrfNzskynnUPELmltvxzeeAVGfo8+5xTEDX62vPQX6ZPK3yzONeF0g8wH6DFZJjSVnPExLqOzmMjeIV4g4GNr6iOEkYjfBgAfW0atV5Tvs+LiCdbTZ2LIAhgjjBeeo/JPuPKJGmUMwlciBDY2SpnWvPu8n9COWJh7YpqTmYrKFq/Tu/eyZuR2ITV0xY43GXHeAgYeYXaVuy3Ph9EBpIi6+ZMKFKMZa4VsAgI//0xBFZO0UvvKhgURUSsZIABavzuD/uVlSvP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f5ll7nqXc7SD8+E1UwUgBJ+rl90tWz5TGK9gdu5+Qk=;
 b=Tiq1I6L4YQGW3A/rntlEYM+sYVPS+dfqGCw2TYKFcqq5vkoQAZWrqKgz8+jeP9rIE2J5oQ2nRWkpWG6g9IbiRxNgohtxajT0qxojbHieef2PVFNcnNxY9YLfAaei35tXaz/COuoU7o/bxQpTj9I2LYbWoXRZLYaFmkafSyXmMAE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5096.namprd10.prod.outlook.com (2603:10b6:408:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 21:11:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 21:11:27 +0000
Date:   Fri, 23 Sep 2022 14:11:24 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-ID: <Yy4g/BKpnJga1toG@monkey>
References: <0000000000006c300705e95a59db@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006c300705e95a59db@google.com>
X-ClientProxiedBy: MW4PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:303:b4::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e182a4-23b8-4efb-6ec4-08da9da82dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d78QvvOBtQg15CGpC9LKNb2G+7JmTZsKnLmwKngJo6A1slfmHDmfQZUBPmvKf7rI/pZLWHcervC2l3Ks+hX6bAhWBiKf+bw4NLYzFTuXEQt/lyLwYoqIBq8J3ZU4QzYnxePw1ZWrBDYw9JP8Y6KJGLS1J39Q7X/l56skMENNmKnZJPjTTy566kEhQhulh+5dyzL6/zZauKUL7JHn9ZBAqzg8aqGcMOm4iJZo5fNYrQTErm+mzrNs4pwvUtf2jW8+E2SCmlh0fKYcRanYaxkBu7WVt7lgdudl1dRYhgRdgqc6zRAkG7ykk/hiR08aJ02EKHi09uUSnTpcfuGmXZ+eVsl6XO1BWtqCKdi8Rusyt5jCd4ch1gwM1GGH54pnQ7dVuq8UrLNxykrrQG+p2XVFjy3waLQiE1QFtM28KJ1mEJNLQl7W1CdhdIzrRbNwx/uAOtffw2IvRuC+ooYyGPWEMBuCoGS0VOFVEoQgBMKcisv7deDW5bDnk37Vl3PBNPCVdU8BxgVSZjuRAbREBoWQmsJSciFsTeoMa6FVhp6+Qi1dZSeqYJnLgPRcIwGI/2Bdw47MH3tVXX4wAK8azMiZyvKqxKGkSIlwK7EOOrLLRrirskaaTsEwsuTrueB7Xfr2CQdAlAuOod0SVsy4KRRihhRzAN6s1Muvkxj7a6ERorSz7ijbE9Zg8iJBFENwlq+pUUkJ4uHPJWBUEV9ZQbFjNV6D9IitK1g9ZVbFQ4sIGIwv9jW+fIbg23cCKtEW2p1zE9dmfpZknuPMjW2JT6voq0XpohcA9aVPmkulZE68+SKS7HPqiBORcjtq8eC9awd/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(2906002)(6666004)(9686003)(6512007)(45080400002)(26005)(8676002)(83380400001)(4326008)(6506007)(44832011)(186003)(6486002)(966005)(33716001)(478600001)(41300700001)(38100700002)(5660300002)(110136005)(316002)(8936002)(7416002)(66946007)(53546011)(66556008)(66476007)(86362001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dM9eTMwpo3CzGrL6Bf8Q/AqoUhzH9eJ3ByMidx5E+E6IrgT8EUoQjXm8vSM6?=
 =?us-ascii?Q?mpySOxj6wz9l0eXWbE1fHEucXldeEXgaEu/i2+qYfQe4fB+mw6P+vpbU0sc/?=
 =?us-ascii?Q?Jz95Zyuyw+c6o2aHm6m36fzzvfHxyfaVoGu/cUVwY2lFE6UwqkDtcClpPA4g?=
 =?us-ascii?Q?LyhFlacuSGpg+R5vJ+OKq8liHcXcCS/Z64Di9iS1/t5Pmw14ywnX2loyJE7t?=
 =?us-ascii?Q?B769Pro1tvI2O8N6PIfGlhhWM4CcHrGRhGU1Cv+iBjIJAZqfYvYTaSXiMfSy?=
 =?us-ascii?Q?mn+qOxtHGqNkxbG4J2HoxcfIkPgYVGRY/O3yLI3gOymvFfMb6mhbXsIgfL0h?=
 =?us-ascii?Q?olhZbA1xD4KnP5ssaGMeL0uBtWgY5UMMG0CMT70Vq4ZV3Cd/2owjZdMNIQph?=
 =?us-ascii?Q?41qCSM6ByvOOxhslFYSMmHen4cAdoLMSDxFboPMpsdORKp0mtNes3XKAIN33?=
 =?us-ascii?Q?SlYyL5ZmdF0B5kERWwxYmGrdyysIctWncokgp3MqYUX4R6OwdvrzKrvDIYs9?=
 =?us-ascii?Q?CMOb1BRsWS/bjCnRBHDC0v55ARWvYWeHM5EUcArLJg3N2gaYqaO6QxOgcZKg?=
 =?us-ascii?Q?yj0TIHFcPoT1zGeLse0pPA9IYg846z0uu8E0oII5c/DZ8jd/fpgu6GIhI+hP?=
 =?us-ascii?Q?AyNmvzKQbUP8NXMDWCXUN0VQL2KXwd6RjpgLTfm+xNwcKCf2fLxMNAvMsome?=
 =?us-ascii?Q?cr+IAca409kZjA8VRY5ji+8Kf9Qf3EQG6/oTcdkBUZ6h6M1XV573dEglnqOX?=
 =?us-ascii?Q?o/vEdkvXs6MO2P81RqlTcEa5w9KzksV4s2a4LHS/0TAcLOTedKwh1bZJqy4D?=
 =?us-ascii?Q?3AvvdpT1xMhT+wxyMLmCZpYfxmWC6ds0zm2/oMf3bUa+SsuWQU+3+3AMtHqo?=
 =?us-ascii?Q?BIHA7oFNGBiQP4vlcxmGHM//BsPqlnWKclhzwSe9tAkPP21yr/3of64ckmjO?=
 =?us-ascii?Q?bgICX4sAD+nDz9AWLrItOHOii/ZCUWvA2f4ovjGnH0g/PFwF6HxCLfM6moWv?=
 =?us-ascii?Q?bdX7aLsGrt7Uk6/VRLVXpBCkALZ/VsL8x2bk8OEumSfSdB3z5h6qxeHqHvfE?=
 =?us-ascii?Q?GNQqItc/PuRtuSbjn9uohTeVwMEHwfxa5oIXYVRG3h3dHoGHZeRkGckeNhGO?=
 =?us-ascii?Q?P/OBGiBAhNJ2a4A75drWf6wgjIPrsZqVNRAUDs+RPsVLjf4jl787KEChsTxs?=
 =?us-ascii?Q?Ap3UKCcCZARYEyjD9CZePAEp7pIVDOLMirMaiUEgRe2yhH3PPoTDq9XQtBmz?=
 =?us-ascii?Q?xVWD9VvlkmQpYwx/ZMtgh6p2Kqy+ZqS6K6YR8icw44owkqhV5tkn1RQyApwu?=
 =?us-ascii?Q?7Wy2YG2RfIO/s4Lma3UyGz8IdggfiYVSvXnNaTShpUTZMynWSmyliK9tBuY0?=
 =?us-ascii?Q?KY/7RRX550TyEz+ko0HL53lH62DLYjG+vxC7dUfVeCeXtRVoWDbXuuPyCOdf?=
 =?us-ascii?Q?JxBYYW7BmI1AEi7yjFKyrsQehyo0/Tf0G8rifqxGzoL37+/iS2xDqJ1AKMwL?=
 =?us-ascii?Q?6nBIidonXJI1mNvkXqtoW8JFsnHIIxcY+nq0IeS87ovh0BxqAljyy8fRqV3V?=
 =?us-ascii?Q?c7Oco79qmFaWz1ISQy/I7qGBlppNmWgfbVtIKYdVjaT4FCl2l0qgJaIsWvDp?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e182a4-23b8-4efb-6ec4-08da9da82dca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 21:11:27.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHGnInmKABlB16DEyJ0fkl690ID1UMA+meoF+NlxOH3GAfcdizWL+w1bdnWMHtypN1Ja8a/ORb79khqf3w5pNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209230137
X-Proofpoint-GUID: hPW_CT7yt6ghMcQDm5qMTw0ZxtnuOOgJ
X-Proofpoint-ORIG-GUID: hPW_CT7yt6ghMcQDm5qMTw0ZxtnuOOgJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/23/22 09:05, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    483fed3b5dc8 Add linux-next specific files for 20220921
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f0a418880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=849cb9f70f15b1ba
> dashboard link: https://syzkaller.appspot.com/bug?extid=152d76c44ba142f8992b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b97b64880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fb9040880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1cb3f4618323/disk-483fed3b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cc02cb30b495/vmlinux-483fed3b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 3617 Comm: syz-executor722 Not tainted 6.0.0-rc6-next-20220921-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2022
> RIP: 0010:PagePoisoned include/linux/page-flags.h:304 [inline]
> RIP: 0010:PageHead include/linux/page-flags.h:787 [inline]
> RIP: 0010:PageHeadHuge+0x1d/0x200 mm/hugetlb.c:1892
> Code: ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 54 55 48 89 fd 53 e8 54 c9 b9 ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 a2 01 00 00 48 8b 5d 00 48 c7 c7 ff ff ff ff 48
> RSP: 0018:ffffc90003e7f5a0 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffc90003e7f788 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81c2cb2c RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90003e7f798
> R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000003f4
> FS:  00007f5642262700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000203f4ef0 CR3: 000000007adcc000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  folio_test_hugetlb include/linux/page-flags.h:831 [inline]
>  folio_file_page include/linux/pagemap.h:683 [inline]
>  shmem_fault+0x27c/0x8a0 mm/shmem.c:2130
>  __do_fault+0x107/0x600 mm/memory.c:4191
>  do_shared_fault mm/memory.c:4597 [inline]
>  do_fault mm/memory.c:4675 [inline]
>  handle_pte_fault mm/memory.c:4943 [inline]
>  __handle_mm_fault+0x2200/0x3a40 mm/memory.c:5085
>  handle_mm_fault+0x1c8/0x780 mm/memory.c:5206
>  do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1428
>  handle_page_fault arch/x86/mm/fault.c:1519 [inline]
>  exc_page_fault+0x94/0x170 arch/x86/mm/fault.c:1575
>  asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0010:__put_user_nocheck_4+0x3/0x11
> Code: 00 00 48 39 d9 73 54 0f 01 cb 66 89 01 31 c9 0f 01 ca c3 0f 1f 44 00 00 48 bb fd ef ff ff ff 7f 00 00 48 39 d9 73 34 0f 01 cb <89> 01 31 c9 0f 01 ca c3 66 0f 1f 44 00 00 48 bb f9 ef ff ff ff 7f
> RSP: 0018:ffffc90003e7fa00 EFLAGS: 00050293
> RAX: 0000000000000000 RBX: ffffc90003e7fdf4 RCX: 00000000203f4ef0
> RDX: ffff888020c51d40 RSI: ffffffff8726d52f RDI: 0000000000000005
> RBP: ffffc90003e7fdb0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000002 R14: 00000000203f4ef0 R15: 0000000000000000
>  ____sys_recvmsg+0x3ba/0x610 net/socket.c:2714
>  ___sys_recvmsg+0xf2/0x180 net/socket.c:2743
>  do_recvmmsg+0x25e/0x6e0 net/socket.c:2837
>  __sys_recvmmsg net/socket.c:2916 [inline]
>  __do_sys_recvmmsg net/socket.c:2939 [inline]
>  __se_sys_recvmmsg net/socket.c:2932 [inline]
>  __x64_sys_recvmmsg+0x20b/0x260 net/socket.c:2932
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f56422dabb9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5642262208 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 00007f564235c4b8 RCX: 00007f56422dabb9
> RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 00007f564235c4b0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000246 R12: 00007f564235c4bc
> R13: 00007fffbde3618f R14: 00007f5642262300 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---

While it is true that the addressing exception is happening in the hugetlb
routine PageHeadHuge(), the reason is because it is passed a NULL page
pointer.  This is via the call to folio_file_page() at the end of shmem_fault.

	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
				  gfp, vma, vmf, &ret);
	if (err)
		return vmf_error(err);

	vmf->page = folio_file_page(folio, vmf->pgoff);
	return ret;

The code assumes that if a non-zero value is returned from shmem_get_folio_gfp,
then folio pointer will be set to a folio.  However, it looks like there are
a few places in shmem_get_folio_gfp where it will return zero and not set
folio.

In this specific case, it is the code block:

        if (vma && userfaultfd_missing(vma)) {
                *fault_type = handle_userfault(vmf, VM_UFFD_MISSING);
                return 0;
        }

I could try to sort this out, but I believe Matthew has the most context as
he has been changing this code recently.
-- 
Mike Kravetz
