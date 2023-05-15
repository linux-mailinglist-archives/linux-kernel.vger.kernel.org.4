Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E4703DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbjEOT2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbjEOT2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:28:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4BC16083
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:27:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGnqES011049;
        Mon, 15 May 2023 19:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=NcrlKNKzdH83UtgmrHybf5/dolfUXMik7XH1G7/zbSA=;
 b=j6fqmHVF7HwBX1E0XwqjWcGGQ62XXSoKhV0Hm0CfJGUWjKyDmViI8JTua2Z2/N64td8C
 7ZLAISprhDTT/UjYRQv285E2AzLv+GO5QTkIsH6ThllqVYMTjGaiQjNmOdfqIYynMvoi
 00MXTW/izTzgxhaxz43h8V9o1GL6kX27JC4pGop4UN3Ozy+ZfneCTrkhunGXotS+L/EQ
 GdL+Gb1d4vBA+I6quRcA8vHNQas1uIoibHIlb0/ICkQt/Zk9H2Ks6Lv+XjKzwSwIobWD
 TR01ENhFckh+ZkodJ55qH2vGH2D1gHGhLwyncBN4BxdhmF66eY9Tsyhqe1lk5DlKlkBl 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc111a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 19:27:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FIZJaW017940;
        Mon, 15 May 2023 19:27:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj103k2r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 19:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQoa64fIt4FtZANXzMYPyVs0Ehg+hwPPKmdWcN1pBbVmVvc2DgIY4jJyhsu5/0bDz1nKym5jSqozUGpADzqvRCWbsNaeB3G31xDQMGhKZ65jA5TOCKvT7aN6b/iaETVEm5P8W0h/gFQAvGzD3ULpUL+yunr5k4FMZPnvnfUj7emHsYpMF/QTurT2y44AAzcEpobvHMtHCn4ZJfyfkGfbVOEVNWncT2Tt/yLhwYFpUPtXBYZ3GFbZFK0OhHeDRrcWElNBWNQtFdoSgWXW9l7caAf8GJt0GEyLbVH3mLtcIKhN8ekTPgO2uhz+YSNJuSxKm6xkQkY0zbqKRYlCKhRpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcrlKNKzdH83UtgmrHybf5/dolfUXMik7XH1G7/zbSA=;
 b=lE0aeoTBowVO1/w+FEUp5Q5BKX9qbrR1y0JOpkUp6jgYDcyfvTcItGHjItGsax2fQMf602aQDKJPhbZ9PrRhvc6JLKc1RSh/lzvxgtbkfCmxR84cYQsPxgHeBixti4WImFrzifdgOnC27nnFSkn8G5R4k/R9Xhccz3EB1Whyqu4RsAJyHet6HPMGHWuWzyVGlqI2xMsg+gUZvIxnHKIyVXeOCijDDUod9sxIfsVHeWMgjkpcKwfL+xbu8k+8Dz3yMG4jd1uC8dY0uWeSQbqpMi+XU7xLV36lmtmuq1oncJIxI1FJj4tS1qzWav4q8ARXmmlw6ZWpE5WUmRhndCZbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcrlKNKzdH83UtgmrHybf5/dolfUXMik7XH1G7/zbSA=;
 b=jISjfBBJR8znDIR2XVcO1hzuk1riP6/QmMhPcs4KCRm1eG3ApuruVVZxdtshmJ+jmXAGDhANosPkKmjz7KK5nDom3/4uxSHxoF+xFrRMigHpzPcipyD6yTmIFGxsZu9dIXZbJdpfrPQ3ACBawI45nnSRZrvUBCR1ukaNyhYwriA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB4968.namprd10.prod.outlook.com (2603:10b6:408:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 19:27:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 19:27:10 +0000
Date:   Mon, 15 May 2023 15:27:08 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: your mail
Message-ID: <20230515192708.sypitem5hzycdois@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <87mt2cxb7y.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt2cxb7y.ffs@tglx>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0240.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 529b5513-758d-4319-0ca1-08db557a60e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTd8IUd+uH9f20XISW5xpBoJ/MZwXuC1TsibC+ekf1CZeYeC0GRDKW1ZvcPXT5YYVUNGEECWhukSe+k24tqYGtxXHLX0mkFFnb1fZ95GM+ik9wxn0cMMn/XNJw8svBYlDx4uKn1KI1wzbX+a3TAxIqEVzclGDjyal7sN+MbwxU6L4DYHx1t9NV9BMn1bd8MhLbZk/rTt1V3KMnEneb2/rMv1uyKI7NAJb2srXpSeZmZ8z+HJLbHI9fZAHpmAhcalHD+nYKVo19fxqBvXX/BPQxgQQ6hifaRRVMKppStVrP44mb+S240hNNMhNbkUb4LLr3/SPU/59emJNiPGOTHap01g2hXwZY9WTaB96HYFchMbq4jfD4KTAJ2U8aNw3D6+5WrWkq+YS3lcOOOTs1WM0W3b18R9e73N672VcBcErApXPyDrIxg5eFxj6ydtcd+4PpxFqX9mPTUBSwrNTeJwTz+76tT424lUcAO4sGFlNyaHsdHPG+palNl6VERPo6+Vit8WOarDHsQiQrugcevrLzdzyZt2j/EDNHcGZeF8Y2iygWv2XJ/4t4XIWPOrma5H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(186003)(38100700002)(6506007)(1076003)(6512007)(26005)(5660300002)(9686003)(83380400001)(3480700007)(8676002)(41300700001)(8936002)(7116003)(2906002)(478600001)(6486002)(66556008)(66476007)(66946007)(316002)(4326008)(6916009)(86362001)(54906003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31t1kAf55YJGLG4DDGjHEwaTzCult80UVpTtLoQGeqtQUIn/jh4JQAx1Nz9G?=
 =?us-ascii?Q?JbZJeDb67r1KygLvySRG0VYjQ4apU36Od0Ef4UHWhqE8RBQ9wQMiqvKaLs66?=
 =?us-ascii?Q?8ChTGUAj1sF+74VswK2H7B2BJIqDzggdF43ABveWPM9zle+eAahOvaXYzv5B?=
 =?us-ascii?Q?ZuHCEQbDsV2ysKqPhV+Xa1/rvWQn7neduUr3br6+3GujN6dYq5BNmMPVIERU?=
 =?us-ascii?Q?up3Am96ljfmskwejJm5KXfhARC3iJhv+z81Jt5n5GevSOI1KSxFyyNRGtCnu?=
 =?us-ascii?Q?UbGdWxH3FrhvTVfdueqwynIQ7VSMHNdPWBEpmXsE9VWMmTF3hvoX1T7Jnv0f?=
 =?us-ascii?Q?ynOW1DKC8DDOXVQCIhFQNKxGA5bGMlw11OKA/J664NRZEgtHV1M7q4JWgixc?=
 =?us-ascii?Q?/iBHe50N7en+QZmgJPCQSREFqs9xmJyP/0mpA+Sj5kdYgtUCT1GbWKc+SCo9?=
 =?us-ascii?Q?llSJZBizx/ODIqxoBjJ4gdFDZ8f/h16zaLT9icOvTOLQxsNVMqMrTRkaOFnP?=
 =?us-ascii?Q?YD+kYLgd+S6vCcATE5IOrNha7em4yzF7+q4mSSecHMqkF6o0EVniSwM8Gtfc?=
 =?us-ascii?Q?0AIejIR2mjOlNqws45HKrvJRMMVT9ZCFqvUQQ4oLG9qPk8vE94RFLoW/QQPE?=
 =?us-ascii?Q?fK+0r6XQMl7eqDdrCHwLv3hgcch5llwG0r2w2pU43xWw3rWqo3T56SryMWW0?=
 =?us-ascii?Q?P183EaAeMIRMaTBo8jjW78G4/nST8wq2gFEku3uRR9GP+8XkK5PnD2G3Qss7?=
 =?us-ascii?Q?nHemxc9IvrNSpCHHf/UTdfjPhobCYiYXlshtDENHAT3wguXc2wOVW8oYyyBm?=
 =?us-ascii?Q?axOhzRYohK53mfHyhTcZvE7bRC+myEvTV9zk91IBmBUFPTxeXDcIeXelfvTp?=
 =?us-ascii?Q?SCL+1XCGrwY5prK2zKnOXM2jPjXD1g2ZKab+Y3bB3B/zyA9mTkF6eMKeEJLG?=
 =?us-ascii?Q?wdBaDvWzT9qCJdkZ2EMsaHBpidEMaca/374ZwlVmDsaQb+x3GK4Asu9UTxts?=
 =?us-ascii?Q?u/2e4eQ1vOkLIBPrI8mwlvn7bu4/Pwf7pOhTQOnw4c94V4pgVIxAZvawrLuZ?=
 =?us-ascii?Q?KGXMGtexxKZhxVvmos2/O+6ndSu95V3Q9m9wu7SkXDqzuF8y+1vfbW+WNQ6v?=
 =?us-ascii?Q?clM2eP+163EJNKbBpcuJFcyuQotX6zZa83RNKkAUSvhiEUM/C6KoSzJWJ2cA?=
 =?us-ascii?Q?YuZddFSa9Qx4WoRYHymMb7FKAmSogQngIe9Ad99c5ZdWXDU6FV5nLQliy7Vw?=
 =?us-ascii?Q?njLMN0kyficrvd/4519Qh02Xiq2XXgyLNBGdGL0hSnBs72d5xrDK7xuAGdhd?=
 =?us-ascii?Q?um1NvetIbny2bDwrmYYLK3ezlf8k5cE2UEmQA2wgMxSUl1wgsogiDOmglWNH?=
 =?us-ascii?Q?bpbviZasb46f1TWnzfrlATltZHWn6KEdnfneeRZEPyrNpRic095x6o8pZsJL?=
 =?us-ascii?Q?qNK3tkeeg7BhCxgXgr3ytkwjMLIj+rfR9own0DT9vWUApDGdYK1BOk7p8AeO?=
 =?us-ascii?Q?b390tl+4dDK4gDGhFPTG+UryZtJVjr/uoys85eVzHjlDvm5afpORAnLmYRSm?=
 =?us-ascii?Q?y7VGtiQVK+YG/f5qAcvBwwd9105PLaiD6IvcTlQE6pvWmlKa/wchVC0WrSkO?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J/2LBuGBQIDcxz4wnij+GEbnEHTNju5nweMxOJ9j5wQxvZzTNv4gVKEMVlxBInsKBm9HmTQlP8wWUQo8G7b4Rj8IwYIutimdRIz8eFPzMlcbFAvoCCsymI3R1HCumJXqqysawkFgpw7JkoP/K2CXQc11wT8Kc/KDSBbnEvgzBtj2rbqL+dn2F2jObWmcli8ociL1P8Deb7TXGY9T5Ba7fz41jqWLJ+TOAclrPIMf+erm79TwOsKUBc+zx0xyDu9xJ8uXnViGRGfy0kkcVF8tvKY7YJ9KYisesMST+w36tRf99t57RUnDIrI6T8KHH8FjkwDDodsUptV12Uj1piThdpuJLufa6Ko/CYhM6d3VWVigBrZLL4oncJT3Y/IhFNLHy2x+jog80J7XJiGpYZMTWQFkYKUNTWWpKC1/luSXlb7w99UNe1T6MKNHChIU4K8WQTVQKRDbMKAUnw2+x71hOGW6BGZE1q9hQ8Bu92FPb5p/B8ZC6OmcWtxPk0tfFd93ZCmhLMg+PCXQmYau77v5bGYBiWHVUwzjV5jhLJRGeRBiAKZSYmYeJiq9IXySH5uWxUWiKnn5x8lfY9Xx/rgLnhlr0LvVyXjpKci3cZBaGbyaDkrziqN+V0dqoOT0yhz/TcxGqED6mNY//fzjQe2+zv79JpYjKT1JOHkc55ySWd+grCQBkd7eMteFsoPgS7GSbAfjSqRNmWcPHjDRToA8tQtG2NAKV6z1+9Jmn3ac2lBJyJbPNgpSgNwy7N1CjSlL4+mwYKD++hZyHwbdvjrbBgn7ckrNJ/vBPodmXj25c/Eq1EVY5fZvgznAuLdrwWupnJ0eDlOUHK0C7yjbEiUyKsoOMHGyaacy/kZwx5JZwa6a1NybqiKobbtQbSXZT5PEJhYDQiQLkGzMv8Flv6sCEA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529b5513-758d-4319-0ca1-08db557a60e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 19:27:10.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jASSNHvDdBUEb7yUM7Fp4jyAgUIC5SB/Om/8Q8upD22kSgqqaiLshV14jkUKNsvtGbh31t2ODWmMcMpo8yY0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=767 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150163
X-Proofpoint-ORIG-GUID: ZLEoSx4hA9qiU1hhgMd9qRYQ437AckVx
X-Proofpoint-GUID: ZLEoSx4hA9qiU1hhgMd9qRYQ437AckVx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [230510 15:01]:
> The documentation of mt_next() claims that it starts the search at the
> provided index. That's incorrect as it starts the search after the provided
> index.
> 
> The documentation of mt_find() is slightly confusing. "Handles locking" is
> not really helpful as it does not explain how the "locking" works.

More locking notes can be found in Documentation/core-api/maple_tree.rst
which lists mt_find() under the "Takes RCU read lock" list.  I'm okay
with duplicating the comment of taking the RCU read lock in here.

>Also the
> documentation of index talks about a range, while in reality the index
> is updated on a succesful search to the index of the found entry plus one.

This is a range based tree, so the index is incremented beyond the last
entry which would return the entry.  That is, if you search for 5 and
there is an entry at 4-100, the index would be 101 after the search -
or, one beyond the range.  If you have single entries at a specific
index, then index would be equal to last and it would be one beyond the
index you found - but only because index == last in this case.

> 
> Fix similar issues for mt_find_after() and mt_prev().
> 
> Remove the completely confusing and pointless "Note: Will not return the
> zero entry." comment from mt_for_each() and document @__index correctly.

The zero entry concept is an advanced API concept which allows you to
store something that cannot be seen by the mt_* family of users, so it
will not be returned and, instead, it will return NULL.  Think of it as
a reservation for an entry that isn't fully initialized.  Perhaps it
should read "Will not return the XA_ZERO_ENTRY" ?

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/maple_tree.h |    4 +---
>  lib/maple_tree.c           |   23 ++++++++++++++++++-----
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -659,10 +659,8 @@ void *mt_next(struct maple_tree *mt, uns
>   * mt_for_each - Iterate over each entry starting at index until max.
>   * @__tree: The Maple Tree
>   * @__entry: The current entry
> - * @__index: The index to update to track the location in the tree
> + * @__index: The index to start the search from. Subsequently used as iterator.
>   * @__max: The maximum limit for @index
> - *
> - * Note: Will not return the zero entry.

This function "will not return the zero entry", meaning it will return
NULL if xa_is_zero(entry).

>   */
>  #define mt_for_each(__tree, __entry, __index, __max) \
>  	for (__entry = mt_find(__tree, &(__index), __max); \
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5947,7 +5947,10 @@ EXPORT_SYMBOL_GPL(mas_next);
>   * @index: The start index
>   * @max: The maximum index to check
>   *
> - * Return: The entry at @index or higher, or %NULL if nothing is found.
> + * Takes RCU read lock internally to protect the search, which does not
> + * protect the returned pointer after dropping RCU read lock.
> + *
> + * Return: The entry higher than @index or %NULL if nothing is found.
>   */
>  void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
>  {
> @@ -6012,7 +6015,10 @@ EXPORT_SYMBOL_GPL(mas_prev);
>   * @index: The start index
>   * @min: The minimum index to check
>   *
> - * Return: The entry at @index or lower, or %NULL if nothing is found.
> + * Takes RCU read lock internally to protect the search, which does not
> + * protect the returned pointer after dropping RCU read lock.
> + *
> + * Return: The entry before @index or %NULL if nothing is found.
>   */
>  void *mt_prev(struct maple_tree *mt, unsigned long index, unsigned long min)
>  {
> @@ -6487,9 +6493,14 @@ EXPORT_SYMBOL(mtree_destroy);
>   * mt_find() - Search from the start up until an entry is found.
>   * @mt: The maple tree
>   * @index: Pointer which contains the start location of the search
> - * @max: The maximum value to check
> + * @max: The maximum value of the search range
> + *
> + * Takes RCU read lock internally to protect the search, which does not
> + * protect the returned pointer after dropping RCU read lock.
>   *
> - * Handles locking.  @index will be incremented to one beyond the range.
> + * In case that an entry is found @index contains the index of the found
> + * entry plus one, so it can be used as iterator index to find the next
> + * entry.

What about:
"In case that an entry is found @index contains the last index of the
found entry plus one"

>   *
>   * Return: The entry at or after the @index or %NULL
>   */
> @@ -6548,7 +6559,9 @@ EXPORT_SYMBOL(mt_find);
>   * @index: Pointer which contains the start location of the search
>   * @max: The maximum value to check
>   *
> - * Handles locking, detects wrapping on index == 0
> + * Same as mt_find() except that it checks @index for 0 before
> + * searching. If @index == 0, the search is aborted. This covers a wrap
> + * around of @index to 0 in an iterator loop.
>   *
>   * Return: The entry at or after the @index or %NULL
>   */
