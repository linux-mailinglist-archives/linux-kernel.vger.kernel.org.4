Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B145E8F72
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 21:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiIXTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiIXTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 15:01:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE1853D1B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 12:01:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28OChV5B003336;
        Sat, 24 Sep 2022 19:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=TKUqX8u7iRf6liS1PnjjHXwxnwUvPRDACn41TV78aYI=;
 b=2Th7I9/bX9bQMSs+iaa+WZosR075MNg0K1qHLNSPWn8Z8oSvIB7nWqDh7sKs8Yn8kweb
 Qh1KyUU94teOdBEE8pY+4l3TqcMD53fIGcACAXCabYKLneN5TIyigsghT+DtPbYQMxBs
 K4Ir7sT3u0CDDmyIyhv1XvIVHRoj/R1ahS7P5sBWm/r4LXqLr8BBokIX5fQsuHbFzYU7
 lCpzlD7R+ab2oISZBnxAKjIONQ5Xe9OhkcUi6GLUIadX8TM1m5pThUi0W8ENN/AESH1T
 2bOjG4z0JH5/bhRZrPWxMJmBIZQgj+ZMH4hqCKhLShOEM+9wTKenaBpvfNWS2gnNJ2u/ Pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpgt2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Sep 2022 19:01:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ODfQcA035506;
        Sat, 24 Sep 2022 19:01:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jsrb84njr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Sep 2022 19:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGiC6RUT+dWjhYzH8acEc6K4Y4LdKFI/GXGxVZGahtz+e59s+nl4PkizsXouCv3Br5ta8o+ip1MYM4HbwtABBvYi3tfBbuTfsH39k9XrHUm164VqyLxyTDxq3sGTIj2vi82SGT9mofd7JRayVpMc+uqB7bCNexa2KlVOhILeb7yT7Pxa4t+jqP4WcNUeukImP3HvNBMaojY0IMd1zOywkV9hCjmsm2Jrw+EFd01CvNfM6v1LBo+LAa32omwoA6/If1N19nwNSvOIDLVhbDEWL4W5DkddJ0sZY7cRl91hXMA0ZGJR0qT8vzTDNvRT9xAM0O9uptGNwvgU9A+Wfh8HVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKUqX8u7iRf6liS1PnjjHXwxnwUvPRDACn41TV78aYI=;
 b=mZVE3i8Dua0C+vJRdPjwcu/9nZHKBxibhV4/36pDuRiEQzBlc0RRJLO/KfGUEd5O0DOtBQJk11Dhvpm0Ky7nP5HmQ/Q/+vGSec80cC7nS3oMObojfpFq2ZMjUhEUvZ6bczeIzR/5eXpQ+FCijUret4EH18fFay4HjtYSIXSMgC2S7xYkbMW1n5F6gJwF2yEFYuxaGXraiUr7o8A5e4eCZxB3WbCW98QWCJ+8zBtckH8q/SLh4g9l+CaS24gmt0neaJBTGRc09oXIT69eRo3mpbFEDHKcvTXhH1ATR/UspRGVhWM0thVyAk5tzsax+b1M6GbE4VnQQNVUehGw74l4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKUqX8u7iRf6liS1PnjjHXwxnwUvPRDACn41TV78aYI=;
 b=raSYB9J4201vHvDDkCeVA1W5gX2uW09lm5ih9R6UYFeHFRVPLYfwZLucCLQGgsMBPPebQfzpdKY49NJXdy9Z66q2mvORG+RDJZ0SapSWNjyX+XWKTkFYzX6parGWdxYHnUVXHzJudVNPJXexWMNyk8JieN0lUzxQankabNTQiFU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Sat, 24 Sep
 2022 19:01:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.023; Sat, 24 Sep 2022
 19:01:21 +0000
Date:   Sat, 24 Sep 2022 12:01:16 -0700
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
Message-ID: <Yy9T/JmVb4ymf6WM@monkey>
References: <0000000000006c300705e95a59db@google.com>
 <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
 <Yy5WHvioerD2Sev1@x1n>
 <Yy8dBrmvDmqlsRXE@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy8dBrmvDmqlsRXE@x1n>
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 516acc3f-4ee4-4469-b0f2-08da9e5f2b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62gW7E1GmlZgoJilgHyeZPb5/cJU2ZoVe1Lxncx9kFlkDSmSOcYD0oAcJyWKQYhkZ9XGHbLdn+ymeKMpuRaWZUnnTwnVyJ1icfBabpWq1ACflwcFGySqxVw28/lWyUBXZryKbhaHy7sbr0L/rI/cMV7xmSbCNuVOk5gDr5+5ckw0a1pXUlMi0szNyh/WIPHAD0fSfi48004Hmx2Q8el8jni+rPKK4Yq4NnJCMiPyN71HcL30IhBnMGQJGJDvzbvo8rYuB1sLunCrjHa/mK2IVvD/ymDFQyTHFZEqXAfkq1Q/cXQdAxS/FcVEegP1VDIbAMDSiATRljaLNpmCftdEI+U7qyriory5dk7Ex6dK1xwl7XIY9nLiVQ1y2Mg4GX3WMcZz9ghlvxcQXD+87aR1dYrXg/quImQ0mCcmXaDmBxsMAkG23K50CIo9SBXDAl502+y4AgvxKbRSnAoEo/5g1WEG5OhZxtX3v8xpmMqpJRJNCAGPn71rMxy3z9W0tQgnOEWJYC12JT99y/g/TCRaVQB/tQPXCt3dCVRSAnmXQ8FYaFOb/8S1voxf4yjxxZ4dqlGXNtzWzYHlvUdamXSAIxPb3GgtoWB4xwctHMUAtT9jSafxpxx/b7HZZgDAWDOeHCKH0SpHwVuvxlqWFaeJaEpNSS6eEso/XrJExrzeRWklV1id0RNhMzi9EphNppzUD+IoK9gxiqnOplVUnvq38FJTpK7Kfyfh4YWTGTxTUymPeSunG8EmpOzW0NKekrs9Lt74M9VGJiBkp9RXnH3DWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(41300700001)(6666004)(478600001)(6506007)(33716001)(6486002)(6512007)(966005)(53546011)(9686003)(2906002)(44832011)(38100700002)(26005)(186003)(66556008)(66476007)(316002)(8676002)(66946007)(4326008)(83380400001)(86362001)(8936002)(6916009)(7416002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WhQXcGeV8GPwwIbHdGWrq7BhdXl2JVhQZzeU7m4VpD2QYK7UDO3jmwzw2CUl?=
 =?us-ascii?Q?LYf2HsgdYMK/0j0KVulGXnkP9pxXvO4CYuPhv1LLdEhJPHfb1KxtmJVubqfe?=
 =?us-ascii?Q?yT3TUSTQA0D+GQMljR52aCe6Uj/YctN7ahHrdhg2/r3majZZGV+wwURQw/60?=
 =?us-ascii?Q?UnTDqMF/T5teOwnoWajzWsdora4viYe7Y1JKEz/snvT2Bo9GQ9ylUxawf5wR?=
 =?us-ascii?Q?Cukm3nhu8fW5PpWpH6PnFrXpFl24w8k6+vvbp3FSezfJNJFGrVmIBqJWWiJf?=
 =?us-ascii?Q?uskIDZI5jHGyhzygsUXOg5e9ed3B+OxvKYNLVBceZVbBWVQcE4iw0Ec7SiFD?=
 =?us-ascii?Q?Tw0Ng/zWXgMCyqcGnUP75VTxzsMf+40jt2UVB6KEp3+NGhLWTTD9C0ZTYK72?=
 =?us-ascii?Q?KPlrWy2b09pOSQBPlBeNlP0SqVfOAzJJ+vrbU8W+biiCDUNdbzzxiRvHovww?=
 =?us-ascii?Q?vgnBFjIEBOuZdZfgZleI1gamRfSWbQoYj+ky1STjTLRmXS00eunlSuTsx6jv?=
 =?us-ascii?Q?fTViYeAKi8ZnOUmf6dgbCRnhuBdaTH1I+E7wFLYANlzYHojFyzFoIJbnOEF4?=
 =?us-ascii?Q?gNlB76yLbFegamuVko+vGSd3gJCBhLN49ZVWj5PaNzw+6cyXyXR0Sj4N5o/I?=
 =?us-ascii?Q?Ib4zFvlPnjxFH/LkFsdlsy1eg+Ac/PeEBlYawTQD/oSjhRZp0eGx3qmI4jFB?=
 =?us-ascii?Q?pxEJT5S+NXZzZBbBYWCiXivJT5/aCGAo3aPTdY5V/zFqDsD4cO/NIdYdHsOQ?=
 =?us-ascii?Q?G4F+7Zo3XmCGwfCKbVR44gZA9IiTAP/RFHaAKJU2fuy2TK/dOofC/gbd2QLx?=
 =?us-ascii?Q?OX2RxtYFQnZVi9zy2hscSUCKXBCOimZ2zKmGGFyWrC7MuEt3NUQpYzbTiXrA?=
 =?us-ascii?Q?b8eULjriSC8c/CxmCous3vQCP1twIDXNlwaXS0NOD5fLBP7fqgNoSDduJiWV?=
 =?us-ascii?Q?7f2J6ERUCmK4PGNT1Z/gSw5WMkMWWOJEFHfLeUxl36MunKlTLOKTfnv259ok?=
 =?us-ascii?Q?LdK347cdxrF5YgWN6iSvSb1Rx2sVCD+QXcQEDTcz92r4QrWXdYZMh8p224ZI?=
 =?us-ascii?Q?py/GUeCFc+jd8xUJ6NJbhQlsicX7QfiidzfErKwG1+syZyXH6yRE5c0fn7Pr?=
 =?us-ascii?Q?bGQdo2HugR/O2eJtJDRWCOhaSnFM9DIYGUm+ZbEZ1cmXooTkxTqi2U9L3Fem?=
 =?us-ascii?Q?XK3bGt/9ZYazpVZsTU6xqjIW5W79c4OcMhCfBgTTzr2TA9b1AVdMN/LClzjy?=
 =?us-ascii?Q?P2y5AopHVAcgRxQYrdT31RzGdaPvX+qCwxBlisaIcc7XNPtxTc28tGFbWmkq?=
 =?us-ascii?Q?61cuRfOw+pwmbgqQrfUBfgu79lTzPwOdIAhRN8yo6rQvIJEtwFh2i2m6ePVg?=
 =?us-ascii?Q?7NKspOYMY9Cvvoo52Rq0/Lyzp7ttK2XV60T2phljmIkMvTMidHTtMti6wm6E?=
 =?us-ascii?Q?JGfinYRgLFE3UNHG8p4i5/NN4qd38m9C4vVxLTOPe6jvL5dK2h4tInV1uclk?=
 =?us-ascii?Q?2lx9zM+egSaNNEAs26HnZwZFZgkOzjBvTRQMa8BAdjBMJryzojrddeLxre4c?=
 =?us-ascii?Q?J7m4e17e90c8DMicfx5kWbQl0tEWTxo1WZrfVAEYfd0Ysa+Smxom7eoM5Zxc?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516acc3f-4ee4-4469-b0f2-08da9e5f2b29
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2022 19:01:21.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LBq1IQWs6Ng8cH0BdxbH731t2GPt2UyoW0KiNNA4exnN7m/cJNWGKI94QTu5vYRM4VYjC9ugazi1Wz2DvEhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-24_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209240142
X-Proofpoint-ORIG-GUID: u0SLtT0BQfEJvOxacXFa6slKkgoK1wIZ
X-Proofpoint-GUID: u0SLtT0BQfEJvOxacXFa6slKkgoK1wIZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/22 11:06, Peter Xu wrote:
> 
> Sorry I forgot to reply on this one.
> 
> I didn't try linux-next, but I can easily reproduce this with mm-unstable
> already, and I verified that Hugh's patch fixes the problem for shmem.
> 
> When I was testing I found hugetlb selftest is broken too but with some
> other errors:
> 
> $ sudo ./userfaultfd hugetlb 100 10  
> ...
> bounces: 6, mode: racing ver read, ERROR: unexpected write fault (errno=0, line=779)
> 
> The failing check was making sure all MISSING events are not triggered by
> writes, but frankly I don't really know why it's required, and that check
> existed since the 1st commit when test was introduced.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c47174fc362a089b1125174258e53ef4a69ce6b8
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/vm/userfaultfd.c?id=c47174fc362a089b1125174258e53ef4a69ce6b8#n291
> 
> And obviously some recent hugetlb-related change caused that to happen.
> 
> Dropping that check can definitely work, but I'll have a closer look soon
> too to make sure I didn't miss something.  Mike, please also let me know if
> you are aware of this problem.
> 

Peter, I am not aware of this problem.  I really should make running ALL
hugetlb tests part of my regular routine.

If you do not beat me to it, I will take a look in the next few days.
-- 
Mike Kravetz
