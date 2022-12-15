Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2964E002
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLORwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLORwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:52:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210B220FF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:52:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEn3m1029711;
        Thu, 15 Dec 2022 17:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=qtK94KndOEzguF+wrWH2HelYen6QzYKm+8Dpd1fQkHQ=;
 b=0MfXy/1khd/1J6vb/6PozA6jqZMFtWCk5mJS+6tjkKM+AEqup/jX6ZUBnZ4WvUdn4ZPa
 t5hMpNhE/cdI2VFlqbgbMXJgF96evRa+jSl0g0OGPC1g/tZRK3dpKFX5Q7egnB7zzWx0
 cvsT6jRODGhjfYzkTX0uWDf5WI6CISmwdiEjLlqERkYZ3t01S+xZc0Q4wIrKLc8Up98h
 6MyMAe/bVpQ6nrjvAiM1ZtzAdGRoBOSUbHjLiuUes3iYIRHKRIa4T0Wc3lhBX+9dxhKh
 dLaEDhEf3TGY9EXZzi6HBg578oUxf+w8HrJnPVlTUrDCvX7CxHB6UgdUa94S+LNX2ZC0 GA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewwsa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 17:52:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFH6nwj000456;
        Thu, 15 Dec 2022 17:52:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyes3264-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 17:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCcLxIMvJQ/qqOMlxF5q0XtyxDNCHaYqxxQk2ebkOqo1FnKJPsfLAS+feknv43Y7eQNVUpLl1j4RxkOJsQYPjcPNPfeC0AHNwhu65wt35L3aYnmSESuTx5Of5OzlIcY/D/OeX/yqzB4j5rKz1HtMpoCTTKHeSp4fWmKRFa5kijWUMH/tjkPMlQA5PaDY+PRV4LdXaf6J9pYTwrpuIvkkcISWSjkiE5uVPIZCFg/INFhzSXr03HoHH/ibOWhLH95Iu6aoF5WV952EHnfgmliOJm7JMNcxROXjYD5O3Ky/xKuetJfU5PEal3I/z0hG/bMe5NU/dlfnb6CIa2UP8gVUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtK94KndOEzguF+wrWH2HelYen6QzYKm+8Dpd1fQkHQ=;
 b=LZklJLrB95eP4vXFKqxaYhhl+4QXK5lPORx5IZyDVS3GzrvmWnV51UwF24KSeIvfp9ySBSLZTTs4vnQ7pLJy1HB6O50fsuhZlj02wuN66OkD7TFKWkmY+tHFWGIVWAH1kdZU/OWziTrunvbcW5cc7h5kXA0VsvZhnogQrzp6vJkpSDw3WrKO+fNJtw8T7QJL7jbF+aTPSkmlS/T/X68k7VzIut9b3TW6KQgM8C6I6QXJZVxjFGUHMShKljKLw3d8ARDyMcb2MuBBi13+gc7xQerKCXbHSeQy/06rnuc+72Oj6ZfKL0F/eIqrg2hdKsFr8jxjJixg1T7XAGOvej+gwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtK94KndOEzguF+wrWH2HelYen6QzYKm+8Dpd1fQkHQ=;
 b=umJNjFVFRoxKu8h7nAFhLN0sEruHm5mYZxA1VdaJ4JU5y5yPa7mY18PyY+sGyxrFSZ+NXiqlw6dMjdh77NcipJhbe9hI2EAe/iS3lFVqLeiELfEO+DLhgMkpMcK7P0fysvMJPSr+x0Pc9t2NFsae97OUfQWW0O93stfMgD3GuiU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 17:51:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:51:57 +0000
Date:   Thu, 15 Dec 2022 09:51:54 -0800
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
Subject: Re: [RFC PATCH v2 08/47] hugetlb: add HGM enablement functions
Message-ID: <Y5teuidKlbKWbT/S@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-9-jthoughton@google.com>
 <Y5fDwH6XiM808oUM@monkey>
 <CADrL8HU9sQuh_W3Qx4dvGV44VLYNbt300cpWLU--BqLo3Xxgpw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HU9sQuh_W3Qx4dvGV44VLYNbt300cpWLU--BqLo3Xxgpw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 3079d202-4263-468f-e28e-08dadec50f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IkOS3m6PATzY2NqY5FR5cAnsz83Li+tpJbLUiQyNORkdi0R5nsgt5DsM41nSzAWecx9trowg33NqtnWBoJ6MatFWsVoFsEYZ2c4MTdY/u3zWENYoU5BsuGIMLDYhUKUbKEH+3MxgQeXtJQjk40DrmEX3268Gdnl00GqN3nZR7OvlMrYxQz3Z2lFMDOKurG0AHCv9NF7x5H9kjb7zArqO7LIEIv0PItJ29WJY8fEZWF7SMX6q6o0zSWSid9BYrgZBl1lWTGwUeeGpDu5o8FGSjYVYhHyKRq4H18ckn8nqhJkvvp3yFWtx2ckVPHOD/Tbmke/H0q1Hgein6Ic0lKZ5gXkb1uYIoDBL33WBfAVUtgOcjyAIC2E1YtYbV0TfgM3heJUnS1nsItBR1f7JJPJG7ms9pJl2C3WluhTpLSlyp+CpnC2GPFac8Xh3YkQ5SRqeA5mH6gCPm6riXKB5snAw6CxOZsndQ0CGuP2XbDGhb9MbRcffmBvlY4jpEyQNFbyx1zo8vl9I1dwKzlxUmQz0tLkvvs/vxkJK51TDFZZWva4M1K+4pupHuiMtsRD2A/PU1+gE90LCm8ai9iU4GvrH9FamnKgiFjh+P/iB7KO/tCpVe7XGbaCWMwHaPUlN2qAeINxisCCOXIP/Qx2VRUikw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(38100700002)(186003)(53546011)(6512007)(26005)(6506007)(9686003)(478600001)(6486002)(6666004)(83380400001)(33716001)(8936002)(41300700001)(54906003)(4326008)(6916009)(316002)(2906002)(66946007)(66556008)(86362001)(66476007)(5660300002)(7416002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6OigIaZRy7eRDWcUKioC4PP52MG5jU2N+Hfr4NAkZkD4XnkLWH+EDthD6xp?=
 =?us-ascii?Q?sroUcU4hSbukAWA2RTUwQn2IFflyLaSzxUANL16Ri8nvIs8XYqqiSom9tIiC?=
 =?us-ascii?Q?9v0SbD4BFgPTU8BSdR9xXz5ZXF0KxIT2g569kS6Kg/ubu/SorxgWnBp7P+D7?=
 =?us-ascii?Q?JYrkPW4NQJzJmDqhGmOEjMjMfyWxLj209YIYd747ZWVM+Mk6jVErjyvGePqK?=
 =?us-ascii?Q?ZQFqUOQRiBpUVePLD10nbKbS3vPXeOgss3DeTcRTYrYgre9N0yXQH/dww8UK?=
 =?us-ascii?Q?ySX8LLJ2xB+mJSNwgHlmCBDPEkEikhwCnlAiDQWNNE6fuubw7IzkmlFFJ9Xq?=
 =?us-ascii?Q?e7K2W+luYlgEMQGd9K/ko7EdSdIqyqAvbU9qeLGqlawrTtD++uh7rUi7mLH+?=
 =?us-ascii?Q?3J+gwUSIVLYL8luQkxgzMt9jtWzTLW0Y2JT4LXs8N9kWCytW28ZyP2qM0gIq?=
 =?us-ascii?Q?Nk1nFah9uR1nkJLcr8fYoWn2a7gM11A8IzcFEgS/HWGya9Y4cVIS/Shk8wat?=
 =?us-ascii?Q?ZxsLO3RSUc4JIUDQAgCVTtYaQAHCvyLQBn7NVbnlQ97KH6WSe3CjJEz+RCzL?=
 =?us-ascii?Q?svU4DCn4impsDM0rfD7PZHQn7eSufN1jWpDWzWG4nej4bp+GjPKJgLK6gHP6?=
 =?us-ascii?Q?pBdIynSChQ0PsY3ltaPy7XO9smeb+yS8TLtpVhs2G0gHOUi05CzBlreTnDK9?=
 =?us-ascii?Q?PejnBr8nAGgEF4cTx37a6A2A6x0sdRf9kQxCBxoe0fxeSj5kxVcbxZmkWLgr?=
 =?us-ascii?Q?9A+lPpkdpVpt+mVekQitamfufu79XFDPR/lZ6ZUm9VTi3EjQFJ+E2nq2PnUp?=
 =?us-ascii?Q?+KnXD3S1aRVACADrdY2cG9CkIzwNHGSYPRqQGJwOvp88KvHBUpGKPmIxdRoY?=
 =?us-ascii?Q?Wf+pwQ6CLDm8t9GW2ZDPlhrq0rVDLkK4sDG2bpiV/AeW46Y3nmf/z7OiKgDl?=
 =?us-ascii?Q?9HN6daYzafia0tQvOXSsJPdnyDXhKgH2EoKC5kkH0V5QzmOutQCcITvpIWL+?=
 =?us-ascii?Q?waIUEFUXraPwEdpeeJc/m1ms+saTzVA7vMsMCKIHrF0RGlRobzUawfnKA2ue?=
 =?us-ascii?Q?5BI71O9wOv0LVcTW5dkTlgx1RiPyiSYpKuhCmORw1rNAjFi35VSXQ4kktW65?=
 =?us-ascii?Q?bk2c0DhOJfYO5i3XFufUSWt+DOFfr/jMv3/0x5aOIMArWs88DYcyp7zSOkDY?=
 =?us-ascii?Q?bkV5gbkmR6rv8VOAhdbIlOnXHEkIV/PQCRyUPYtKFBT3ZRIrL/8OVJ9CSqTZ?=
 =?us-ascii?Q?ReR+WihaW0JYI/vFglnlSvRh/Jee8WRpgawqxWV2IJFVXKOWCEhUEuyCr9Zt?=
 =?us-ascii?Q?1bl64aIMgwESWXaMdgnq4oSaFvUXq+aAnm4Zm1qf6uC9IEc3scvkYfGfm4HV?=
 =?us-ascii?Q?xQjpEC0cpBYWitPNp771KR/yyDEu7aMtbhH/MTjLRtVEt0mdqPL/hJB5GUh/?=
 =?us-ascii?Q?D86ZIFhQX8LFjDFKcQd4fcls+D9msMk52ZfM+BtNDniiQ0B9YHybrUpwYLgx?=
 =?us-ascii?Q?YJgjxQqYLvOP4HNkpLGEgsT+WCmeMtLfDbf9yc40TObF3IlVFAlK05+9Ql2q?=
 =?us-ascii?Q?/pLmcJQ69LEG7w9d8/0x2QaYPGiEfVXSf0FKb/NpA0F8VG2A5T6zY/iALWbp?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3079d202-4263-468f-e28e-08dadec50f6b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:51:57.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMCHPB7p1jCbBcQrzZtZj0VbaZm4wNKOurUuRNtHT6q6KqgOF0YAyRjYWlkicO8gHTk/4YxlW+oZYacUL1MlaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_10,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150148
X-Proofpoint-GUID: fBm5qHc83QCyqU0DttEjgXOR42fserSq
X-Proofpoint-ORIG-GUID: fBm5qHc83QCyqU0DttEjgXOR42fserSq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 10:49, James Houghton wrote:
> On Mon, Dec 12, 2022 at 7:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 10/21/22 16:36, James Houghton wrote:
> > > Currently it is possible for all shared VMAs to use HGM, but it must be
> > > enabled first. This is because with HGM, we lose PMD sharing, and page
> > > table walks require additional synchronization (we need to take the VMA
> > > lock).
> >
> > Not sure yet, but I expect Peter's series will help with locking for
> > hugetlb specific page table walks.
> 
> It should make things a little bit cleaner in this series; I'll rebase
> HGM on top of those patches this week (and hopefully get a v1 out
> soon).
> 
> I don't think it's possible to implement MADV_COLLAPSE with RCU alone
> (as implemented in Peter's series anyway); we still need the VMA lock.

As I continue going through the series, I realize that I am not exactly
sure what synchronization by the vma lock is required by HGM.  As you are
aware, it was originally designed to protect against someone doing a
pmd_unshare and effectively removing part of the page table.  However,
since pmd sharing is disabled for vmas with HGM enabled (I think?), then
it might be a good idea to explicitly say somewhere the reason for using
the lock.
-- 
Mike Kravetz
