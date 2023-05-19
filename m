Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7493E70A29E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjESWCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjESWCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:02:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A50121
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:02:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JJEaTx008746;
        Fri, 19 May 2023 22:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Njbwma2Ugex5vnmCgsQkoGChOZIzUiszaD9F/su4h4I=;
 b=w7BdMuOXTWvBSHc5D5PWVXD1jmK6aD8FmcN3pyZ3Nd0hK7eGVWfSYNLeykLJLJPEnxvB
 29CZ1J+clisMjtMkceqNgTF6/66SD6u4rydTMatNKcI+rwZ0KxC8bRTQybnx5QjkV93m
 l5t3LuzfqWNnkcL2dZSyH9d1QgeEgnJWTK+S5lKZAoYSm900YdjfYlwoL6Nk+VTnDHF2
 fX5QpE+WR9OA/W95DPynoVSleKW3a3ZX8qe9wlPbKxtxdYh6kFuAGqOUt25OxbU4rQ9t
 wwynzycokALj0GzWjsSk2yIa/bKByaoFaYt/dSPcuRngJ3oPLS+q8fEvP87nuz1tXP+S 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc5wdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:01:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JLmUf8036536;
        Fri, 19 May 2023 22:01:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm05mgxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX3C/H3nQrJaMLTnel2I7QooRvjVQvnoC3/MS00a2m7gcq/4/fXRw4eY4UbEZQayouWUtaaDkMsECe2w7KqhS+bM09+AktPwxOVvixkHu+mimf9fHHgFlkkcJpqbta0rasDRWuLj9gjp6PlX2imPT6kFupl6hDMeHQu40fDXcBVGS5XfEn0G2nijBKCrsgcA9wbgR4riVXsk6HLiS1V+6LwHs2DyC4a/Qo+B0bZWgDIbEzyjFR6npcLPjmeY1JjFewDcmkHwRVlgeUv8MQ79oBBy7Nkpq5NhQG2eqVtgOIVc9uhXcH7Ch6ArxFIZc1MaUuJggkCh7NZ75zuqUE6tPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njbwma2Ugex5vnmCgsQkoGChOZIzUiszaD9F/su4h4I=;
 b=h+wNpcTySl1eYGO3oBJ7z7zXLbtJ7t0Wx6e3OMRFXMvRAwexVW8GU1T/Hqb3zu3o6LKUuP0mw2qVvE+FeInmdsr2FSEUWU36NR8KZVIjEtgNKJB8tH/nGpM+Mg9cCtJgCC7keSxam92Cx1CJglQZ+dOBwrrMAHTJOR5H2mD5cdcpOnMGkpmvWJnnIl++zvmrhNcNgdpwSWSDpApr8yXE0jxdevUpyDtDV01p3Tfc4DvkEtqqH7dy8q2n8ef0aHFsOoRgC1sMkV/+PsFQUPsZgnguPQwaJXok5OKb0y6DHe3UsItGC+kpYQB4nr8Pe7/DY+oG0GtRJJ7RVPaSkSby1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njbwma2Ugex5vnmCgsQkoGChOZIzUiszaD9F/su4h4I=;
 b=CWQeke4rgL8Oxcl+jLXPB7HtiGxPVdmI5YUt0M3AlA9C7Ju+MBMN4yNIDi14wogpHoaWqEJPwMyCb7k80lyI/BlPgwPV6hG2VfFgxBgITWPU4PDxssX5g/iXMYnvFTWTxBhYaSttlwg4yxWojsHUoH1wnLTi/HA+u8Q679ksvl8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7862.namprd10.prod.outlook.com (2603:10b6:610:1ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 22:01:55 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 22:01:55 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, david@redhat.com,
        nphamcs@gmail.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC v2 2/2] mm/hugetlb: add wrapper functions for interactions with page cache
Date:   Fri, 19 May 2023 15:01:42 -0700
Message-Id: <20230519220142.212051-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519220142.212051-1-sidhartha.kumar@oracle.com>
References: <20230519220142.212051-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e4c0b8-54c9-4323-8e42-08db58b4a8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnPkATBSnVOny5fVvhfYBUp3s7ppFwjtAm2O8u0PzxBzQT68oHdZWWhxbS29XfXtvUTbPyzGN+DSTYiiZnvS1TosmqG5kC7xHWZ6KzCrRXKr9RgasWABDJMqcHbCoMRFHgJm53C31oEqcpT9BMbv/ObzLVj9VBtp8Tu4uoZhHZxFF+WDeUpl8aZTvQn9eb0c0f0ljzqrumOjap6yCW0qwFvahjq68UDPAN8eEIZ66TNz9tF1/MAgHlGkSbUDEJw6idxeCY2uu/jPzIPbLBpnrKl6boaLLnnzS8hpE42anlBEAMpnmD0d6ph2A48CSX7dFOCB45JQG/N7y00NZeBaKMXcPh7Xf4kR+56/R60tYC737bACp08Um8IzY1ihi/OKa9qGncnw9pHwl6ciyLc4zGDhgJtKiaeolFZxYA0NhHQhcB7zGvQJ1ghtIcwuxyq56Q4phmuw5ZW0lOOSjZY28/erMmePsh9XN+igf6htpfG2jtLqvE4ob9Q8OTtQgX56r3XUO3nchqFqAw20qu6lH8RWlqVHGKrtoM+Cwvbaus3iNeGlpaNv04Y7nUqgbPcR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(86362001)(36756003)(2906002)(66899021)(2616005)(6486002)(83380400001)(6506007)(6666004)(107886003)(6512007)(1076003)(4326008)(66476007)(186003)(66946007)(66556008)(316002)(41300700001)(38100700002)(8676002)(478600001)(5660300002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j240zm75oq3wf7I92zAl4GZuleCXz/ZUJJPq9QMbjmLEFeCtEab1lUqrV5kV?=
 =?us-ascii?Q?9AfX+G/WUMPDyTUNS4hMp3wxTDdC19U9XWtKrbLoBdOD5M3Ey/IB2bxHvkY/?=
 =?us-ascii?Q?1O3ZYdYtNxa9V31hOZYedpGmXIIC/vz2HRH+rwh8AZB7AmchsgQf30kjvzT8?=
 =?us-ascii?Q?7HoCsGIqWLB4tUNZ8obp9vHuJtdEb0qQzRGnkTOTk6hzxHGhjc44Ut/e0Dy7?=
 =?us-ascii?Q?15rndxfBfLEsb+WLIdyjBmEoNJEofJdc0vQAZigJe1c+Slj4YmFPOTMvS5an?=
 =?us-ascii?Q?SH36fu6ZpEWNiGaGg1pEv1CfRwurS7gUhp/ytJFK6lTMTHz+oSwlsCDa47TA?=
 =?us-ascii?Q?5SRXomjR3Eo84xzwW0buf/rTPnqMsT2mpQ0B/FvSEKlZcw9dX33gM99R/UEM?=
 =?us-ascii?Q?H7cc3KqQW9S2vBH0+pu+BEx4vx75oT5Zw/LaI8aVcZ2sXGrS7oEXQsdEysKo?=
 =?us-ascii?Q?7FLXlmHmyTnZn9S6jBGFd/I918Yk+9P/lZo7jcz/aYiib25MTpWmNyp8vwNF?=
 =?us-ascii?Q?0WOuuuOUiD3bNU8qrM+xVDrFG0ewIUeER12Sy2z0dt2ZOKJPMyREAB9T+Qaa?=
 =?us-ascii?Q?ZA1ww4itztMPwx3qUphOoHNVulxXxs8SSqyIoxZSS79PriAiEiE1kyqwBAIX?=
 =?us-ascii?Q?72wDNfwKL4Z7lGjdI/95IkoK+7xJKAapQsV1YPUvOo1VIaFTGqYex523gDPy?=
 =?us-ascii?Q?t2Ya807HBhj/6jtX9iS2n8vS18Oo0GK2pBlDOGXpYhGsuwUbPXRijt1G3VAm?=
 =?us-ascii?Q?jB+U6Ewmmif6YOtseuJZ5KHMi0IYAJHP2nWcGfUvxm/m5GMBJuCnMBlvpcb9?=
 =?us-ascii?Q?vQrCOdB0uoCF7uoEfetmiT/PMpkwiF/l+XIKoonABaz4QHBCKG8/DMdqVnnz?=
 =?us-ascii?Q?QB9Z9TCGkwPkiCuDrHAbaZUszyN+vwmQRbR5JtdMjGVySTNug9zvTAzQ5ha+?=
 =?us-ascii?Q?xN5b7ELMnwOAt3/P632on5vF/G79QOVVCpANLgoWjeZkNGbfw11hFTrqZO++?=
 =?us-ascii?Q?/kfWarp7b45bgFYKD0xsu+eBRAEdK1EwBI6lUp93Uhf2csbEtE7N31MCWqpU?=
 =?us-ascii?Q?XPZBCthowkirGXHNKwL6/aJ/n+K/Q1F4+lrIIKE9BFH5rg60iEuqhSieUQcN?=
 =?us-ascii?Q?/3ijSaSk4pJO9TLuAvnJky2n+Ej73chPFqD3kItHVdI0HeeADbk9UR/qyeU7?=
 =?us-ascii?Q?g+5hKH9caaAJUQg7IZMcTIMKT/VLxYzw01wMUAMmgn9vFhgzEWIBgaBhS2Lg?=
 =?us-ascii?Q?3ecQBHATKN1yqVj5LvpIIfNvV20zktih4a9aJqV4saBAA1u4gNWko2B059D/?=
 =?us-ascii?Q?YE4tAW+8oYhviKzzcpbECtw4eCwMpud6AmnHdBoj6z6HpP/WC1gcYdFrniRs?=
 =?us-ascii?Q?AD2bu1N/Fawj57DVEKRmgas8Qzgkza4zO763qdnJNU+5U4XPzNcguvtM2E92?=
 =?us-ascii?Q?BhKvDSEze7r7VqnNFE8xFh+qWZC6sbJj0yU5X//qw1HJZtFLyS1aaPQIMRsJ?=
 =?us-ascii?Q?nDq/equop7o5mG9UoLxLrje0gx8PnDcgrPKd+dmRQLWlrNsOpz0WBg8Q1rty?=
 =?us-ascii?Q?rOMwqC/KD+gf64wpHyxpm0BfPpRRH7qEIoHwaZ6gopGLCAEl5mRybRPUSG0X?=
 =?us-ascii?Q?uLbbLJQ/3vSoPq0EC5kIzv4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GajejaKKdUzEvJVf46C6TRt4/ylRHZixi65oGYqp3OfR2Hu83C51K3mrbpOw?=
 =?us-ascii?Q?QykECV5FN5ozsVbnZFE+TzdfJ3coN3gZBgHF+UXBgBo30MLYVUrmrA03dzYy?=
 =?us-ascii?Q?m+GRwwBtw7Jyb56wMU/AwOfyXkUlqJ7Akl4B4r2wv6FVvygNW6PiTUU5H8U8?=
 =?us-ascii?Q?huM/oxZf1wBPHWotM1t/gBEqn1/cH8jp67qd5DlYZ2ytsZ5fPZqc0mVLg1Gj?=
 =?us-ascii?Q?DousizOfPTuw0E3EoCvWyu/KG2L/dDLrio9+uGlqE6v1Kk/bwJ3u1pgLtupt?=
 =?us-ascii?Q?CRozuTTeLXgDCiGzHQ64rg4sGE33NW3GGckF3DqRFiWJFRwojaOEQy9bx8JO?=
 =?us-ascii?Q?7POXOVdWU9dMqi6H1JDQbDpsogXaosgqA3npaRRuiwYpL42PZiBI1vaq/njV?=
 =?us-ascii?Q?CBaQkfUlYIbSzIJupDjNK6GrGnZTOd2+xbMNVIx3Jgrk7fVmOapHkVxeYl1F?=
 =?us-ascii?Q?GMsG1Rq3AM11tqZOsesRE/2YKV0rtR2ZicTM70bmEZYwwe338zqk0jo3xnvN?=
 =?us-ascii?Q?FOe+Wrlu4B0MsKzdOnKluNgiQPusR+koGoPIzT+wdJ/izOl31vsRK6kYTeM/?=
 =?us-ascii?Q?lw/YvrNpy9haIt9EzA0t7j4a/SBJfEU8Of4LN4sAMvx2dEoy7nwFbLoa7NVI?=
 =?us-ascii?Q?kLY6QeZ9DPmmaTfYanfC2Mu4TKnC4+efhqdzzeh5cboDH5l8kX3Ye1Dlm68d?=
 =?us-ascii?Q?rGiBxpNjdf1yX0Pmh0O+rv+u1T4RUu/jEMbfvya0kMCOK8N563i8vrA1fS0d?=
 =?us-ascii?Q?vOX+FplQc8nEZLq485AUwhpLXzcMXyG7z6jTXhKJF85PyevylAAPqCiG3/7n?=
 =?us-ascii?Q?+b+CcprnQhUddqiO3ZsqMoI55N+CUOaRAqshJsj5GEzZLjQ8gOw20v49fxQx?=
 =?us-ascii?Q?Dx1nvYb8owNzEhWF4sfzl/YfG/B21hg7P9DWbJLyS+g2te6HMVNCFRoWn8Ak?=
 =?us-ascii?Q?g95msz7+cdS6d/GQG94PcUEmJ06IcO4O6TyZaDBfX4w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e4c0b8-54c9-4323-8e42-08db58b4a8a0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:01:55.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtUWkY5Qzgu2wmZ15z9uAYM1FzORBFxfWAjJF71uCocYVm5770AsXVNJ50itsu+7/yc+m1Hx7vilAY7xV+o/X0iWY/IFfdSkHOKZ5bGskXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190190
X-Proofpoint-GUID: TgcbY0MHEnD1NzpsRjjN8B9le0tibHYt
X-Proofpoint-ORIG-GUID: TgcbY0MHEnD1NzpsRjjN8B9le0tibHYt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add filemap_lock_hugetlb_folio() which is wraps __filemap_get_folio()
and passes in a linear page index. hugetlb_add_to_page_cache() is modified
to also compute a linear page index before calling into page cache code.

linear_page_index() is modified to perform the computation on hugetlb
so we can use it in the page cache wrappers.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 14 +++++++-------
 include/linux/hugetlb.h | 21 +++++++++++++++++++--
 include/linux/pagemap.h |  2 --
 mm/hugetlb.c            | 22 +++++++++++++---------
 4 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 90361a922cec7..204a9510510f1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -617,20 +617,19 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> huge_page_shift(h);
-	const pgoff_t end = lend >> huge_page_shift(h);
 	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
-	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
+	next = lstart;
+	while (filemap_get_folios(mapping, &next, lend - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
-			index = folio->index;
+			index = folio->index >> huge_page_shift(h);
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -693,10 +692,11 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 					loff_t start,
 					loff_t end)
 {
-	pgoff_t idx = start >> huge_page_shift(h);
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = find_vma(mm, start);
 	struct folio *folio;
 
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(vma, start);
 	if (IS_ERR(folio))
 		return;
 
@@ -868,7 +868,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
 		__folio_mark_uptodate(folio);
-		error = hugetlb_add_to_page_cache(folio, mapping, index);
+		error = hugetlb_add_to_page_cache(folio, &pseudo_vma, mapping, addr);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
 			folio_put(folio);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 21f942025fecd..55f90e051b7a2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -727,8 +727,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-			pgoff_t idx);
+int hugetlb_add_to_page_cache(struct folio *folio, struct vm_area_struct *vma,
+				struct address_space *mapping, unsigned long address);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct folio *folio);
 
@@ -755,6 +755,16 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return folio->_hugetlb_subpool;
 }
 
+/* Wrapper function for __filemap_get_folio*/
+static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
+						unsigned long address)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+
+	pgoff_t idx = linear_page_index(vma, address);
+	return __filemap_get_folio(mapping, idx, FGP_LOCK, 0);
+}
+
 static inline void hugetlb_set_folio_subpool(struct folio *folio,
 					struct hugepage_subpool *subpool)
 {
@@ -1021,6 +1031,13 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
+/* Wrapper function for __filemap_get_folio*/
+static inline struct folio *filemap_lock_hugetlb_folio(struct vm_area_struct *vma,
+						unsigned long address)
+{
+	return NULL;
+}
+
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7ca967849c2cc..86f7b180d2521 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -856,8 +856,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea24718db4aff..5abab61af0ca5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -951,7 +951,7 @@ static long region_count(struct resv_map *resv, long f, long t)
 
 /*
  * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
+ * the mapping, huge page units here.
  */
 static pgoff_t vma_hugecache_offset(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -5730,7 +5730,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	bool present;
 
 	rcu_read_lock();
@@ -5740,13 +5740,16 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return present;
 }
 
-int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
-			   pgoff_t idx)
+int hugetlb_add_to_page_cache(struct folio *folio,
+			struct vm_area_struct *vma,
+			struct address_space *mapping,
+			unsigned long address)
 {
 	struct inode *inode = mapping->host;
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	pgoff_t idx = linear_page_index(vma, address);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5854,7 +5857,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+
+	folio = filemap_lock_hugetlb_folio(vma, address);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -5913,7 +5917,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_folio = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(folio, mapping, idx);
+			int err = hugetlb_add_to_page_cache(folio, vma, mapping, address);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -6145,7 +6149,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(vma, address);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6258,7 +6262,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(dst_vma, dst_addr);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
@@ -6350,7 +6354,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = hugetlb_add_to_page_cache(folio, mapping, idx);
+		ret = hugetlb_add_to_page_cache(folio, dst_vma, mapping, dst_addr);
 		if (ret)
 			goto out_release_nounlock;
 		folio_in_pagecache = true;
-- 
2.40.1

