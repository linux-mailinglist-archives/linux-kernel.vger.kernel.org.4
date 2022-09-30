Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052995F1506
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiI3Vim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI3Vic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:38:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A3E106F4D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:38:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UKnP6X019630;
        Fri, 30 Sep 2022 21:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=xb5Zcq/sXu52EkJakmnk22Y7yC5VAB+5ZoKeyzsQMdM=;
 b=t0eYs6YZuB1gj6qb7ZmXZeOe+cUpSNetzSPEXomehTFPFvIdpZy0olWzTKxPliz3YBxL
 8YGYfxPyKxtkded8J1EiG0fzjjx0tqg13O9/ycc4aHkHpYGKFnQ2IJvJAzvjUs0v8beA
 3SAqhT2CgtYuBLZdzzufU0/rlRC3L64YaBsP9iv7jo20Bi0pTXNtW5egk+ziXgVppt1d
 uUwcQqTBQEFNp82FaSirQ379h7wxkst1iCC2xGrMDoWzMm4rK8voqdswtxn138u+6pnS
 rK89TvGzzqYJjI0csw4CQFbG5cwtxVpSXNPBLeI99C+YQXDwLVkirbjNhJsZKx+mjfun xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst13rvnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 21:38:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UJIpxs034103;
        Fri, 30 Sep 2022 21:38:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpqc2t1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 21:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDJ1Zga86m9x5OePbmcOnVZTjz+O2xuoGWDDbKfcml9IomLamvBLeK0U4HtQ1GK92KZLzxXFN23thia/B5EuS7Jwc8E2+YUWJ8Ir9Wjj8pociSP0DOSxYAsHAdp1uOLKpdjk3U+W+aV9MlvsX2L7F0ABrQhrJlVPGLMauUOrYaGHJq/v8q/3jI+Ya16OOmeYnGS2hjPFJ+SfFsjkdTVxqfRrplfUnY84qkQYmVzf8+fo3ingUpaGvmXvZzJYHI15VjawBkFdMvdZhbpOA9oQSWNZSWmy17YS+7UzXCBPFT5qUO81FUQd13YLlXFbHAG2ZA0sKy8byEf2hzrGFIG6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb5Zcq/sXu52EkJakmnk22Y7yC5VAB+5ZoKeyzsQMdM=;
 b=M8kDf1P7JMmnMNMzMO47sPJCWcKSzSpJvWBfZ4feDfAJTnkXBxHvL7nb1/0gE6Nz4YnwTAjfGE9+FsgFlwjlp40cPNPCqzBrMH80KaDHI5nBVoc5bbskwBwJ/WKSu5GeEXWrKZlRKHSgn8O4AsImtBRM92SkwkhkexMUZ4+cl+hIAwt+j/9e9dpPfZ/t9wPItHIDsR+Rh+X5o7dxs6H2lxrbDi9WwjneazU1CTbcOGMkkIeKFDEvN2L0/v2ZxXLcWBb7Hxylw5HNvW5qgzsbPYzuYBuu8yOQTbmBXfRBbUzJGPHsMgF5QOzUE+WtZ3smiwjFdVdXLhLA6NcHbgbXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb5Zcq/sXu52EkJakmnk22Y7yC5VAB+5ZoKeyzsQMdM=;
 b=IkwUJFBCI1HuchfmSoAR4RF8oEj1RO57M2MI5dKxs0Txpc5F0a+9Lpqor349YqXIZ+00IM6y7Eh2nlhkbW9Cdsgv6FvPeVwDGW6qdIyy34Ilj3zI+1OJxtBoVb6jaaXDz02aJhpkK0moPUC90P/rJCcl1FIfS8xQ5pFXW0RwmNE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Fri, 30 Sep
 2022 21:38:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 21:38:04 +0000
Date:   Fri, 30 Sep 2022 14:38:01 -0700
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
Message-ID: <YzdhuZmfQCjLFEMO@monkey>
References: <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
 <Yy5WHvioerD2Sev1@x1n>
 <Yy8dBrmvDmqlsRXE@x1n>
 <Yy9T/JmVb4ymf6WM@monkey>
 <YzDuHbuo2x/b2Mbr@x1n>
 <YzMjxY5O6Hf/IPTx@monkey>
 <YzMomT+OusJnLOPC@x1n>
 <YzYrYVeA0b9d5dos@monkey>
 <YzcTt3P3ofvbGQmi@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcTt3P3ofvbGQmi@x1n>
X-ClientProxiedBy: MW4PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:303:83::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 45768b40-e608-43e1-88fb-08daa32c0e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PlHhV9OFul2qkw6a5NBpvvwbYudPu83BwNcA4I+PS1K9hDFV3ecFvYXtQZ4lCNK29ZTJ+2gw8u7KLSL0SGMcJyXKRPa5GC0cFDhxam0kbsjY9msoMquu0Q64vw8wJeI+WmQHcICJic8rFLs81V77i77z2WXZKmIzWaKgmAc5YA86UuWLyjcS+Qkh7soGwpMS4QZiLKqoBFUsW1KnBTys+Iy91yH4n+p/hJesYdiqf7LmYTbYFMUPkqMYi0s1AsC4+5MHd11SdW4iInoIOig3nIgR6Ey2ULd4TH6LB6vw7CMt81xxSN36WEVmyHFGiy3I1hjxTAaqEqX/Sqh0vBIRDUBnRin5SCzwWqNFL3nmx668w7LEgO6ZU8PKbJv8m7XT07TLyvhAnBVvLsQ93Fz2sSs2mq1ZMWi2nv5iRJqAfVcRrxqWjg6tb1lwQpZGga/Y26BSSlg+6naTT8ZR2X1YqITY7+qFtk+GASnnXqPoVkGl+MBtUyOYjlENZVn+PHFM0dKOL6xBUjYGSpOJiR5IQoYMwycGzdfKqPmi7CTWK8ZvWEyLZuvbYoEs9o5Hnt3+WOcY/b/UAPYwHv3YLP3+hsZNvVNgBaQtli7/3DcZ1Ow62lM4kR5uAp/SPDesrkCgGewG2FSD8XMzsI6VNi4a2fKUYx6hxlV5UrEhnQWEODkmzdm8rpUKpY2SWycPbCswhM9sda1/056bFeCf8iy0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(8676002)(4326008)(44832011)(66556008)(26005)(33716001)(66476007)(6506007)(83380400001)(66946007)(6512007)(53546011)(9686003)(478600001)(5660300002)(38100700002)(2906002)(6916009)(7416002)(316002)(6486002)(54906003)(8936002)(6666004)(86362001)(186003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yEF4qDvnaq8g0rj1xjinRw38mqf1loPNzHzssUT3bsfC2qSZJBNgodbmdWBm?=
 =?us-ascii?Q?Bi7Lpl5Hgjn61B9wqksN89F3bZ5ZPtPewlrtkhcSDThAWqO+p1vxTpZodcU/?=
 =?us-ascii?Q?avCMA+2MBcBAAhxzbtdVbUK99HbC8HCS5SG7kLjPRlBiSZ4SBedgLhWmZdFD?=
 =?us-ascii?Q?x4VAhf4NhnyiIjzzw1eEm4qPYsMuQSlB3U+gY3p5RUE0LK+nwGTvLKEPd7QY?=
 =?us-ascii?Q?8scuBQqhciPvSxQprt5/g3jocXcdmoyLvQDKZAmPHvksfwE0c9J03RfjvxLq?=
 =?us-ascii?Q?wE1MeFPOg/QAy+30YbwQo1zrCbX5biJf8cWTpVPCJHtTcLkvbw/4AIICikES?=
 =?us-ascii?Q?jnRfoCTxJ7sHqVgMiLKA3+a/43D57mDvotjeSZjDmVtJz2+UU6+ERJXicZIn?=
 =?us-ascii?Q?2SUOQwzhWqXjBFLTYw5mMXdg7gdrh7AcB4miVF/HfzLds5ctk7x7D254oTSU?=
 =?us-ascii?Q?hSBAX3xnHbrsySzQBJa5Y2kokA0hsybW8PEdK25CGTf6ICSlpx9r+kIjymja?=
 =?us-ascii?Q?S0vfwmZH8xSjYygfsGf9JCtiFwyr7r/Lz41JlNCr0SDe35HEN1R6etU8Qng0?=
 =?us-ascii?Q?nZc86mU2tfeeuUZEJu0abk6H5gg2YN3XDD9IT0BP84eP2Rb09KJITbYs6ePP?=
 =?us-ascii?Q?ObEoUYF3vYZLxslLqKfAmEFRtec42VGPcWMH8dmkbk/zjOjYd9s7duA8Efv1?=
 =?us-ascii?Q?lF+lx0a9G8kLPAp9dtfmeHXjAsQEIMyH9bqvgaAod15CXRVgJR/sE0+vm3ZK?=
 =?us-ascii?Q?eTfg1bdCCgkfIp/thcMp0LeAhxAnkZSqmV2cV2cEYob6/TtX8dLn0LpZ3K5n?=
 =?us-ascii?Q?XW3ZrKObEKIEZ1blOWzl8VvkzFt8Xswo77v80jpd1FecnVDpOfg+GPDwp7Be?=
 =?us-ascii?Q?/VtTNluTLjxZZU4DnCFLwDuKOMLM0X88K4jH7RGexCKSE/3DJ1tOly+ksqVT?=
 =?us-ascii?Q?/xeqV4lj/prdwD5bvkCb0qv5hWZ/d0f9FXBpa+W5CLv+QzCL3p3RBKdBMPCy?=
 =?us-ascii?Q?wFCAEhSJw7FqLQD/1Iy/5IamEroe3owg+5LaY8NPkevqAa0T/u8RGzZaOo81?=
 =?us-ascii?Q?yu8U68Hriz9GuQPmBzIymzgQ6UAsKGPMlFsHnPQmgdSjzXu1VfnwlJX6iRDP?=
 =?us-ascii?Q?5KoRz30UYgAHX/l4DhXZbOQ5/0DX8bGho48CeEX2NHmHOm4OLPLjxU9VQ7Bf?=
 =?us-ascii?Q?woIgJ/woxOIMro7N+ba8SMNhDO/cbPY81UgzdhMBhu4QPZgY12ZH0dyamz2d?=
 =?us-ascii?Q?2CM8J5q9Fb/tUhOfNMym7ySUVk/CTckjIoMsM7pN5/opBxIze6o74e7mCMAR?=
 =?us-ascii?Q?fBljhDq07+eyiUk2zYUdb4n+d1tyvT2gl8oOvpo6VHN57ZXfnZQWpC2LZCpP?=
 =?us-ascii?Q?muZzUPVt2557Rl+O1I9ji+5L3dLZBwcotsC8bx23rllpnNKX+hb4I22OCWD0?=
 =?us-ascii?Q?7J7DfufWl4it+CUHQn+oi8dhNeGEpJzHhJaAyGEEQ7/XnDhPnNkPEIVxmbQ+?=
 =?us-ascii?Q?MJYPZj70eW4XVKs9InS6pSdkJzh6q7io0VP/EN6pDb9IPc7hTcHbLV5j8ldy?=
 =?us-ascii?Q?kd7y/6RLCi3gXIjyy0jUA8GXT4VNCUh6FZSrE3jscwovSq8oSyVopAE0IUMG?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45768b40-e608-43e1-88fb-08daa32c0e89
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 21:38:04.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GWiqSslPGmYgRnytC7P/d50RX5O2WPluobkYmFWXZtLZ9ibsY3Cv7TpXnyPhBULqSQpD3VYQvKugAkVzxhKXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300135
X-Proofpoint-ORIG-GUID: AtR68U-kBqOYTZLGRit8oaYciFr8Jfp3
X-Proofpoint-GUID: AtR68U-kBqOYTZLGRit8oaYciFr8Jfp3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/22 12:05, Peter Xu wrote:
> On Thu, Sep 29, 2022 at 04:33:53PM -0700, Mike Kravetz wrote:
> > I was able to do a little more debugging:
> > 
> > As you know the hugetlb calling path to handle_userfault is something
> > like this,
> > 
> > hugetlb_fault
> > 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> > 	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> > 	if (huge_pte_none_mostly())
> > 		hugetlb_no_page()
> > 			page = find_lock_page(mapping, idx);
> > 			if (!page) {
> > 				if (userfaultfd_missing(vma))
> > 					mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > 					return handle_userfault()
> > 			}
> > 
> > For anon mappings, find_lock_page() will never find a page, so as long
> > as huge_pte_none_mostly() is true we will call into handle_userfault().
> > 
> > Since your analysis shows the testcase should never call handle_userfault() for
> > a write fault, I simply added a 'if (flags & FAULT_FLAG_WRITE) printk' before
> > the call to handle_userfault().  Sure enough, I saw plenty of printk messages.
> > 
> > Then, before calling handle_userfault() I added code to take the page table
> > lock and test huge_pte_none_mostly() again.  In every FAULT_FLAG_WRITE case,
> > this second test of huge_pte_none_mostly() was false.  So, the condition
> > changed from the check in hugetlb_fault until the check (with page table
> > lock) in hugetlb_no_page.
> > 
> > IIUC, the only code that should be modifying the pte in this test is
> > hugetlb_mcopy_atomic_pte().  It also holds the hugetlb_fault_mutex while
> > updating the pte.
> > 
> > It 'appears' that hugetlb_fault is not seeing the updated pte and I can
> > only guess that it is due to some caching issues.
> > 
> > After writing the pte in hugetlb_mcopy_atomic_pte() there is this comment.
> > 
> > 	/* No need to invalidate - it was non-present before */
> > 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> > 
> > I suspect that is true.  However, it seems like this test depends on all
> > CPUs seeing the updated pte immediately?
> > 
> > I added some TLB flushing to hugetlb_mcopy_atomic_pte, but it did not make
> > any difference.  Suggestions would be appreciated as cache/tlb/???  flushing
> > issues take me a while to figure out.
> 
> This morning when I went back and rethink the matter, I just found that the
> common hugetlb path handles private anonymous mappings with all empty page
> cache as you explained above.  In that sense the two patches I posted may
> not really make sense even if they can pass the tests.. and maybe that's
> also the reason why the reservations got messed up.  This is also something
> I found after I read more on the reservation code e.g. no matter private or
> shared hugetlb mappings we only reserve that only number of pages when mmap().
> 
> Indeed if with that in mind the UFFDIO_COPY should also work because
> hugetlb fault handler checks pte first before page cache, so uffd missing
> should still work as expected.
> 
> It makes sense especially for hugetlb to do that otherwise there can be
> plenty of zero huge pages cached in the page cache.  I'm not sure whether
> this is the reason hugetlb does it differently (e.g. comparing to shmem?),
> it'll be great if I can get a confirmation.  If it's true please ignore the
> two patches I posted.
> 
> I think what you analyzed is correct in that the pte shouldn't go away
> after being armed once.  One more thing I tried (actually yesterday) was
> SIGBUS the process when the write missing event was generated, and I can
> see the user stack points to the cmpxchg() of the pthread_mutex_lock().  It
> means indeed it moved forward and passed the mutex type check, it also
> means it should have seen a !none pte already with at least reading
> permission, in that sense it matches with "missing TLB" possibility
> experiment mentioned above, because for a missing TLB it should keep
> stucking at the read not write.  It's still uncertain why the pte can go
> away somehow from under us and why it quickly re-appears according to your
> experiment.
> 

I 'think' it is more of a race with all cpus seeing the pte update.  To be
honest, I can not wrap my head around how that can happen.

I did not really like your idea of adding anon (or private) pages to the
page cache.  As you discovered, there is code like reservations which depend
on current behavior.

It seems to me that for 'missing' hugetlb faults there are two specific cases:
1) Shared or file backed mappings.  In this case, the page cache is the
   'source of truth'.  If there is not a page in the page cache, then we
   hand off to userfault with VM_UFFD_MISSING.
2) anon or private mappings.  In this case, pages are not in the page cache.
   The page table is the 'source of truth'.  Early in hugetlb fault processing
   we check the page table (huge_pte_none_mostly).  However, as my debug code
   has shown, checking the page table again with lock held will reveal that
   the pte has in fact been updated.

My thought was that regular anon pages would have the same issue.  So, I looked
at the calling code there.  In do_anonymous_page() there is this block:

	/* Use the zero-page for reads */
	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
			!mm_forbids_zeropage(vma->vm_mm)) {
		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
						vma->vm_page_prot));
		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
				vmf->address, &vmf->ptl);
		if (!pte_none(*vmf->pte)) {
			update_mmu_tlb(vma, vmf->address, vmf->pte);
			goto unlock;
		}
		ret = check_stable_address_space(vma->vm_mm);
		if (ret)
			goto unlock;
		/* Deliver the page fault to userland, check inside PT lock */
		if (userfaultfd_missing(vma)) {
			pte_unmap_unlock(vmf->pte, vmf->ptl);
			return handle_userfault(vmf, VM_UFFD_MISSING);
		}
		goto setpte;
	}

Notice that here the pte is checked while holding the page table lock while
to make the decision to call handle_userfault().

In my testing, if we check huge_pte_none_mostly() while holding the page table
lock before calling handle_userfault we will not experience the failure.  Can
you see if this also resolves the issue in your environment?  I do not love
this solution as I still can not explain how this code is missing the pte
update.

From f910e7155d6831514165af35e0d75574124a4477 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 30 Sep 2022 13:45:08 -0700
Subject: [PATCH] hugetlb: check pte with page table lock before handing to
 userfault

In hugetlb_no_page we decide a page is missing if not present in the
page cache.  This is perfectly valid for shared/file mappings where
pages must exist in the page cache.  For anon/private mappings, the page
table must be checked.  This is done early in hugetlb_fault processing
and is the reason we enter hugetlb_no_page.  However, the early check is
made without holding the page table lock.  There could be racing updates
to the pte entry, so check again with page table lock held before
deciding to call handle_userfault.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 60e077ce6ca7..4cb44a4629b8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5560,10 +5560,29 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (idx >= size)
 			goto out;
 		/* Check for page in userfault range */
-		if (userfaultfd_missing(vma))
+		if (userfaultfd_missing(vma)) {
+			/*
+			 * For missing pages, the page cache (checked above) is
+			 * the 'source of truth' for shared mappings.  For anon
+			 * mappings, the source of truth is the page table.  We
+			 * already checked huge_pte_none_mostly() in
+			 * hugetlb_fault.  However, there could be racing
+			 * updates.  Check again while holding page table lock
+			 * before handing off to userfault.
+			 */
+			if (!(vma->vm_flags & VM_MAYSHARE)) {
+				ptl = huge_pte_lock(h, mm, ptep);
+				if (!huge_pte_none_mostly(huge_ptep_get(ptep))) {
+					spin_unlock(ptl);
+					ret = 0;
+					goto out;
+				}
+				spin_unlock(ptl);
+			}
 			return hugetlb_handle_userfault(vma, mapping, idx,
 						       flags, haddr, address,
 						       VM_UFFD_MISSING);
+		}
 
 		page = alloc_huge_page(vma, haddr, 0);
 		if (IS_ERR(page)) {
-- 
2.37.3

