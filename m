Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92955FF2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJNQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiJNQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:56:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543DA1AAE54
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:56:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EGO9GU021522;
        Fri, 14 Oct 2022 16:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jqVRa+uLAI8Kc5TkJGL/9vFvYtwPGw9KtHJjCrvZVXs=;
 b=a0sbmPn1Srz9sICvu0PaOlBC/GmMss7c4WOHTyn6LP4bT4aI7v+yWcRaF8wFuto+qQj2
 bUIILDVz339rJoWQY49qt4ZQTmXslRNQd52P0cuk5Y6ghZtdvpYBISJhHGs6R1aUTdJ5
 kKtUnuRxKD7DY4P/yaIyljBYJ96n81hRHkPiNioiOTEV2/I7neCh54iJuZjT6dcJN6mJ
 2EpmqFdumlzp+P1GWKb0HVp2SshRqTDpRdnu7qCkuK+goaz1DDWOZDUhL4nO0LdNNGyb
 f5ungVO+NVy7IqW9lZ/828d5tAShwkGTmo36J1uFqivkYYKPT2xqW/YxWR61Ea/87uhJ aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7acvg7rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 16:56:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29EGPJAG019380;
        Fri, 14 Oct 2022 16:56:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yne5y4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 16:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/chuvrvZ9CMM/RM5YgddZ25g+SpR1M0XoOTdZwGMteFEzD96sohVFyFtI+nd3rEf7mizPVTuHsBMMu5IqQ0E9LRq3rKtQRv+4td1EqT407lrgL5U428LG4QhwwHlZ8KNuekH/kiZDu/zwcFvSD6zaB+/PxG+JN4DKmcGuVP5giAJ46JA1qCHeKT/u4oQsq2TDUoFFcIAVc3bLaTJVZ5F6MlmWenYqkS7TE0DtFFlGUwWvmhfc4geDi+vtkoeIR8Gj3KOiIKJhkCd8kukxk1bNCTmz24awvu9CtCHoxIfnk/3ODYq2mjCHNApyeXTRoDpOhy5dzcAdwI49rznKvvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqVRa+uLAI8Kc5TkJGL/9vFvYtwPGw9KtHJjCrvZVXs=;
 b=Vbi8kIR42TUt5c2eHi6jSnG46W/YXIELe+4PaQk4bZSwDy32x0sJTNW3ebuVmTuSnkdKqEKTkMS8a8Hbo9SDP6JghHkxLKUKtLhL3RX+wtfEUYITvab+ygcmqTMo/4AWB3CGuUK0AnHU6p9NrgdUl4l1QZXGodwuhDo2Pc49uUg8QGIKp/Cq3ayUU8GT3HDjPxTCAABmYrEqdeJ2sAqaxIpFFldVTjqR0BeNZuCcuSKZTL2PM4spKOTXLfbe4eL3nVV4pvcQ/zM+G5s0o7cRMSjxJZFXJwXwX+vc789MksGlbfvaLAz8ibl+/uT/64IrwMt92/PkRbT1Tu7tdkO3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqVRa+uLAI8Kc5TkJGL/9vFvYtwPGw9KtHJjCrvZVXs=;
 b=Dgnv+623pv7oHdHfxkKo8ZqA5b10TStdckAvy5WYtEbwkyggy3xlYf2U4PuafxypEmHabuGq2dlcpnOYdIcjckGv7qYYwDr9ZNDw1IgMxDpaQLor80Q62drIAIW0YwEgx2mJrTyPB98lMPgzkgMBAca3iqxXwf8sguUt9UeZlQQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5205.namprd10.prod.outlook.com (2603:10b6:408:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 16:56:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ab25:cec1:78ba:4a8f]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ab25:cec1:78ba:4a8f%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 16:56:26 +0000
Date:   Fri, 14 Oct 2022 09:56:23 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
Message-ID: <Y0mUt84TctGP3BtT@monkey>
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
 <5f7ef6ee-6241-9912-f434-962be53272c@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7ef6ee-6241-9912-f434-962be53272c@google.com>
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 460872e3-2cfd-480b-b64b-08daae05083a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDDAFn58/ys+5FML2aY4qWUpXzVupltVhOEwmx2i09MYM5MtDQvMU2y7GGmp0CyiOPYjwL5L3ey/yGHDCAyS7H41pxphlU/u7Qvbl8ItSgW9h+MOZHDWs6A90AqFSIM0wZgSAQS7krYcrEcx9j4VjirhXn3zNB6nz8pp9ye7qY+L+DU/zaIZtzNIlEDbN1cRqg8276qeDCdlm4YlHOKB3DQScG/0GQ0WwizypkkQexa6LDwlZ4j3Dwjfh9lktc1bi9Z6ex7OlnEAluE2naM7gbt8fhcZPzh7CRxW/lceHjhRZA78isa9JH5lp8watKPUrN2ikkpKlG6PwbFytlv0iyIbhad+Zo/RevA+Cd1zLaqbDv+OxU8p8b1fhXYP62cAjUMoNIfxgQVKRiZ2sd9c/vgJGgno0I7CHQFKsxLcYVBAW4AJSXVZwCXxCAWa1K8kgpl0hWDaq53NK3gStEFs7vQxFkDlcpXWWcwk8g88BRmbbIC5cOWOQb8Ux4OZKkwkNf2rgXqndt2TyIQBcJPjFN3U9xzJoYwgdEo2wSJhBXasUyv54hoGKajXgTsqxXNJ1GZCSdOyab12YaPB5ndhd7KB8yRcNPC/CZ2OHRbhqC85B9rj2p2U9SgzJb053Fp5vOG0fttUWqZAnzyr19/8KS0c1aNYjJe/V6vUAt9gnmjw0vAx45WKIMbKCS2FOhqEG/yLvTuLPJIMfaJa6gEiIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(54906003)(6916009)(6486002)(38100700002)(478600001)(66476007)(8936002)(6666004)(316002)(86362001)(26005)(66946007)(66556008)(83380400001)(9686003)(6512007)(53546011)(33716001)(44832011)(186003)(4326008)(5660300002)(8676002)(6506007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKFnLpF+7q6HVvTj2JJhPc5n02xk+bRJ2+RNK7ADSA4AfGB3Z0Rxjoz3hxnn?=
 =?us-ascii?Q?m9m85Gd8EHUNs9im50yqbRM5c/wcVkQaFNr6hem/fen/X4kvRzsYzaQSNqiR?=
 =?us-ascii?Q?lXKwzlvLI13uqVXotqpK1kfKAad4I4ET7qc+YEWaCKhumh1Jzj9fZVrhCSZ8?=
 =?us-ascii?Q?6Q48woRW/pFndYdqN7h2TAXDIjNT3QaMoNbR/vK3xTz1/5Ouwclwsm0zuWeQ?=
 =?us-ascii?Q?jnp5yj1Mve1ylnlbBUQ8tm5MceloGfGjMRl7dEfmTaU9wFzWXd2M9Lp0toeI?=
 =?us-ascii?Q?WZOyBxjZN+lLyCr5zUnJO4jTNt+0l4LQ4sgcMjvS7hChgbreyslTSgkBfj9L?=
 =?us-ascii?Q?L5derk2OYY4zl3hiY6eLC6SJojrPpnqjVWs6MCnIEmvsHrHRStD8IrU+Z9dn?=
 =?us-ascii?Q?1NhilHWjFljRbioG+T1DvARCWNqs79NBuijUgYxgZAPI+mcEScgeI/WuYT3f?=
 =?us-ascii?Q?LtxhA+f+Oj+vxjn0y2j+0le0tajvLTslLgD8KdWDgXAd1DtYi7x5K8eA6M1E?=
 =?us-ascii?Q?UKiMRh5L1xrhxL6eWSPfnEAN2/h1nfJth7xqORssgCDSYriZaPd7HBB7Y7OF?=
 =?us-ascii?Q?2gPo3xlOovDimDRwihE0gLt1rRBuFsyYXSLhG9wLSn6xc8XkDpUM/yO4tLQ+?=
 =?us-ascii?Q?Hrz2CYr/Tt10W+kuULNlLxBr5NqoWDY10xVzWJoypxyfa+3oJ8oOeBQ4PMi5?=
 =?us-ascii?Q?lT+88L6AolAaoe3DcefnKt108ef0wV4T805OPfd2Z/c7Rfhv7Vp1JrJkNsMV?=
 =?us-ascii?Q?vJzC0jOvmYZ+RKfFzatT9aqoe8CNCvdr6kyCUgHv9G/Sg1MnaniAkRKEAJEd?=
 =?us-ascii?Q?r9ZTCa4bK2GrsGx2BwtANbeo396+CSErCpNj/T6uHgAtCVvUFf/lmmr+Rlag?=
 =?us-ascii?Q?V8BVmmutZtyOMWJksnm+KQZrnIuvItH7PYLJK1gZUZKzddyAGKzDJ2x30NWX?=
 =?us-ascii?Q?QHiHapBKoMzbMHJNK+QOmstnWIqo+cZuCUJ7zjieNAj2xdIElG0PhfaMCcRy?=
 =?us-ascii?Q?12MnAgU/Lq6gOxSUXe0bNz9UOE5G7jj2TtV5s+qLxjs4PB+P5QI8OQ2laoZj?=
 =?us-ascii?Q?4cMLHA7tVhFCTb06qlVflsMr9n8Hnl8ugySGQQJ4toIuRy8ng4QW4IQvHeWU?=
 =?us-ascii?Q?x0pM7UZkVEQCSh/fqTw6qW6GeCFPjReS3Wp7fOYapwBVIbLaQefhBQ4/4nFm?=
 =?us-ascii?Q?GoCMF7a31pH6tFYOyX/pVZmxRJCPRbVQe+W+T3hUJXAgKrzOkv814+k8IrQ1?=
 =?us-ascii?Q?ydby6Tu/A+sU+QXmpskVJnDfM+yPKo1BNAVNxl991Sa8zRnQMkZrD9bU5DBQ?=
 =?us-ascii?Q?nCYYFZj9hGKB1fePz+g++jSP7pF1aFZR98eQLAYaaiUd0J8r/PhQYzzeVeVS?=
 =?us-ascii?Q?I8k+GU6HXUuByNlV1mG8gIkD2a4PYU9SGFROUUnAVFNdbbBtb+HKUXtq8gip?=
 =?us-ascii?Q?gS0F4NVFMt9ISzNB6oh3piESq5N4Q1IJLM+ZoMWzqN8Lx6NVj7bBrdu4+rBM?=
 =?us-ascii?Q?OVG6bHkMbO4RGBhRiKDdlKW+mLXvfUjXR5zX/rFS0T3SS+Ha60mF1D41Q4lC?=
 =?us-ascii?Q?zoYcfpPWANaDRXnbaQypuRaIb0wPt4sC7tXFXz/gh3HliHDZnZR9Bgk3C4xw?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460872e3-2cfd-480b-b64b-08daae05083a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 16:56:26.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guF7aQfVfSIm7b4mTcnHzCdwiu1U6k/uG3ZUeGjcZYrAslEas4c2uP4RIGdcoyk/W22azFUvqOtwxVzc/yUgyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=661 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140094
X-Proofpoint-GUID: xAwdzgLGBWZZTHFYO5cBjUBOPg14pzm3
X-Proofpoint-ORIG-GUID: xAwdzgLGBWZZTHFYO5cBjUBOPg14pzm3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 12:45, Hugh Dickins wrote:
> On Wed, 12 Oct 2022, Albert Huang wrote:
> 
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > 
> > implement these two functions so that we can set the mempolicy to
> > the inode of the hugetlb file. This ensures that the mempolicy of
> > all processes sharing this huge page file is consistent.
> > 
> > In some scenarios where huge pages are shared:
> > if we need to limit the memory usage of vm within node0, so I set qemu's
> > mempilciy bind to node0, but if there is a process (such as virtiofsd)
> > shared memory with the vm, in this case. If the page fault is triggered
> > by virtiofsd, the allocated memory may go to node1 which  depends on
> > virtiofsd.
> > 
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>

Thanks for the patch Albert, and thank you Hugh for the comments!

> Aha!  Congratulations for noticing, after all this time.  hugetlbfs
> contains various little pieces of code that pretend to be supporting
> shared NUMA mempolicy, but in fact there was nothing connecting it up.

I actually had to look this up to verify it was not supported.  However, the
documentation is fairly clear.
From admin-guide/mm/numa_memory_policy.rst.

"As of 2.6.22, only shared memory segments, created by shmget() or
 mmap(MAP_ANONYMOUS|MAP_SHARED), support shared policy.  When shared
 policy support was added to Linux, the associated data structures were
 added to hugetlbfs shmem segments.  At the time, hugetlbfs did not
 support allocation at fault time--a.k.a lazy allocation--so hugetlbfs
 shmem segments were never "hooked up" to the shared policy support.
 Although hugetlbfs segments now support lazy allocation, their support
 for shared policy has not been completed."

It is somewhat embarrassing that this has been known for so long and
nothing has changed.

> It will be for Mike to decide, but personally I oppose adding
> shared NUMA mempolicy support to hugetlbfs, after eighteen years.
> 
> The thing is, it will change the behaviour of NUMA on hugetlbfs:
> in ways that would have been sensible way back then, yes; but surely
> those who have invested in NUMA and hugetlbfs have developed other
> ways of administering it successfully, without shared NUMA mempolicy.
> 
> At the least, I would expect some tests to break (I could easily be
> wrong), and there's a chance that some app or tool would break too.
> 
> I have carried the reverse of Albert's patch for a long time, stripping
> out the pretence of shared NUMA mempolicy support from hugetlbfs: I
> wanted that, so that I could work on modifying the tmpfs implementation,
> without having to worry about other users.
> 
> Mike, if you would prefer to see my patch stripping out the pretence,
> let us know: it has never been a priority to send in, but I can update
> it to 6.1-rc1 if you'd like to see it.  (Once upon a time, it removed
> all need for struct hugetlbfs_inode_info, but nowadays that's still
> required for the memfd seals.)
> 
> Whether Albert's patch is complete and correct, I haven't begun to think
> about: I am not saying it isn't, but shared NUMA mempolicy adds another
> dimension of complexity, and need for support, that I think hugetlbfs
> would be better off continuing to survive without.

To be honest, I have not looked into the complexities of shared NUMA
mempolicy and exactly what is required for it's support.  With my limited
knowledge, it appears that this patch adds some type of support for shared
policy, but it may not provide all support mentioned in the documentation.

At the very least, this patch should also update documentation to state
what type of support is provided.

Albert, can you look into what would be required for full support?  I can take
a look as well but have some other higher priority tasks to work first.

TBH, I like Hugh's idea of removing the 'pretence of shared policy support'.
We are currently wasting memory carrying around extra unused fields in
hugetlbfs_inode_info. :(
-- 
Mike Kravetz
