Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6B6759F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjATQad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjATQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:30:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739310253
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:29:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGE8A3024778;
        Fri, 20 Jan 2023 16:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=k+jcTWs0G4M5GnpPjWscF3JT325Zv8egxRDvpDVSKks=;
 b=CufxjEB0W+mEDwa2trBaug/on+akVNuvyyYGm/3DUrd4oDJZdOl3zCtlJUgSROf4vgAG
 /t25a3J1rX+mJ0zTWsZgPG7GR4i+c2olUtLcqiURzPh7IbRduc7X8jjkkWNiUVREURIK
 XFEGvAGp2S0V80bkgHzM+MWMQrme1HKlvzprtzNf7m1nuZWpaZ4pZSI1g0s+vl/JZhiS
 N8W0bz1f5dvHLwksVH6tG9akzKyKDISYT5htB9OBikYroWgp40FsmF7UtUDhL/k8FW3C
 x4kMunOcM6KHkimZx3PSiIeWtn6u5mL7X02VHaGY2byhJ2EL438OBAgYE//aW7ZlJaEN QQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k0154de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGIcFE000987;
        Fri, 20 Jan 2023 16:28:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2sw5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQ520c0n20lsEcUzIjf1+gMfaTEY4ZzhTBpgKByy5eQlHSCtg51nvplKB8Y1mfEaTu1sDIOO8h3hU2DaArEmiBdaho53W4V+BQO0vUu/OoZ2bp+oL5KseVd+84FCvjUuwU6SC6fXwajHJy/xMgsxV2ceFbv0aRESqx6VHFm5TFPnaC909Js1hgp/yqLbIdYYb0OTfJjUp3HNvSq2911hHZxO/YAtZyaxIytsrw8tvfxX6tpH0dgIXqzAvFVL3fBqKbj6fFuMTHY0SSPOWUrjY94Ve4fvWLpvPfB12SXFSJwDoxjr4T0DOfEiDXvbJ9ikYoG0gyoX728oIwqaINI6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+jcTWs0G4M5GnpPjWscF3JT325Zv8egxRDvpDVSKks=;
 b=i4enLoai54tV6Gn84ewwKAwkbtUK/3r+SdvGnGd8iLqdMSwHXCQwOJTZe7yjelYohGfy0oDrU6SoJzQnV3fnOcQf9kdPr0XG6VToRd7KXAG/nWrHC8DqXJ2iuaOawqC1ck60s9V2FaxCPt6+TlK0LXeXcmr/t+WCTBHkRuwkYDWRytjocy0HJJp1qkSyuljTlEoAemZnaLCEha3Xyt2BJNllHAoFDfktcd9ARHMYwronlivKWMAASDU/2+bzCa/23aXCtRq5fcbaeqSq99JQavwRUPLBsyrWh2FeJ+vEV1mT8HCnRZIDshqmpS1QhHlXUr4KXddZm5XB1uvojbdYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+jcTWs0G4M5GnpPjWscF3JT325Zv8egxRDvpDVSKks=;
 b=jh80Ixbqqv8y2+5pc1t6odjMdLuvreqkHSNUsPwcZZE2Xc8GIan6jP9oVn81GfVKbO6n4aevG+sYBfcZWNhhHgZECwxwuGwc/EM0FPYLoOAscd+TJVX3I2g1Iu1htWHrPCCP+HwBWgb+dqaOFP4cQuWI61F2SYzQ2UhJWPzcIWs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:26 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 29/49] mm: Switch vma_merge(), split_vma(), and __split_vma to vma iterator
Date:   Fri, 20 Jan 2023 11:26:30 -0500
Message-Id: <20230120162650.984577-30-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ff51d1-45ec-4361-a85c-08dafb035b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uwWkhqF7WMZ+hde0wborr7JI+oCb2Z1CdbeOw/TXWL07g7x+GT4Mgrprn933SETUw5odqQ9kDhf0P9BhFu/Tx3poFOubnqTZbKwQM3ME+v9Idb9V3FwFlud8Udn8+p5IPJq60GC66c3eCKoaZTcviZeMpOUenJC6u8C67dJLLcGGioVZZ0/aXYo5nfAvf7elXmFeakM++5n8iUh3GWjphu1j0jV6lo0+6PedF5KXxW3VXPm5M/NNfWFA94hIyjLtPWri/9slSxSNEpFv8IdfKAiTnSW4txqydFxKmEpjIJO1yeqhWqSUTK4XXk4TleZw5OZDp3PziJu3KccbnQdPvtEQsm+5pkryOP2oaHEqggHWq+9wqxUVUg212D3DjP584OTnPTiZ8YvjKVG1xVIwiGGI6hWwfOK5Y2ANnXUXSjmOJaad+6PHh7KAaji/3+DWiDTYV1UBLpUzhcjaelNdpLQ8Ufh0qKHf1iZBk+tOn1vOHEc/CjYkTAY5zlzXKsXNF8o0eJfT+5KPyc61zPWDrrt/WJu8u9n1ZXX/V+bikcInSHGevHuVbmqw+tCJLM4FvNcHQ80YG0f7T8vLYGs3APO2UzJoZZ9x7RV/RD119wDhWlFNW153QBIgU1POS+Dt/4VQTpU542SS620+rv3VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(54906003)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(6666004)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(30864003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KAxVfboG3zjWgsUOWbqHrsLqySFiSTTcm28VCHONHp+7K3oPVNO5237MWmG?=
 =?us-ascii?Q?zh4A6FF/lE1kxP/Z8oE0A77sSYZULu8wKSeA2zqWLWsB8RFB029zQ6fmRbV8?=
 =?us-ascii?Q?QLUeae7HlVajHK4t+lgbJFAeyPN/9lijWLOiE8tMrjhbDhFufehFkcpJJ717?=
 =?us-ascii?Q?D1flk4QlUYN5wt+n+C3baUfa3tEHfcLTmLvoZPUpxlX1vAOKru8p6MPIRsK6?=
 =?us-ascii?Q?XLzCyr1f2LVbIYcF65IZjwtCkc/8BNw31hZC5+ZMaYRmz+42RP30PD/nqu+X?=
 =?us-ascii?Q?tBj5b3pGXJy/vKPT2mGDjF9w6sfdxMZNQCuYXtgyxtmNHQitS+lJq/RNpSbx?=
 =?us-ascii?Q?WHXXp5Vu/C5n89MphdMeaaXPoxIjU3FTalpb9dZZopfrt20ZOWMtjdcJN3J6?=
 =?us-ascii?Q?YYndp+AcKfN9YIHpq+cf+nh3PSkSFEOCH+xKJPapuxsVn+c+mECpf0ZArcWk?=
 =?us-ascii?Q?r2gpXMech3OSWvATH6hEiPweUheamyAF8cKxs4k7O3tYUyqTmwHf4KTYO+tl?=
 =?us-ascii?Q?+7twcldyKO/wqKBZIq5h1zY1epbjmtMIgoA4A9Z8bmaaE/8thUPcKiJjTCEX?=
 =?us-ascii?Q?0fP49vA1Nah45BgJhT8mQlIzVshSe9/CNawM2fHznS2UM95R5zBjMTh60xlw?=
 =?us-ascii?Q?KffpY58ARN6GPGWEbHVe2pY73Gq1uGzKFK22fAxnCsh44haavcXeyy1/YvI7?=
 =?us-ascii?Q?qcRSytpjYfGJmxsLI7gmq9i0ROaP4h98KzS0lT54EZjp1DbO00e6E4ZtZfn2?=
 =?us-ascii?Q?N5TKA/CLmEYhcxKtj3q20xn2Q65Ajx2/C8FtY+f9xmSQjFaT18v4Ld/nHavU?=
 =?us-ascii?Q?gSDXtV5WyzaS0PgluFLwCsBeK+uG0QlFLpNajax/JgauqPwWgWxKs645fXYp?=
 =?us-ascii?Q?+YmvPU4LWPonx+bYF7h2OpIM9pSJgWuxB9VHqkQj5Wn4t1q3FvPagcPmN6Nw?=
 =?us-ascii?Q?qvLmGrQpSSp2JJOWqPvGuXGM/TcTX9fIOaHgDS1HbPq0ondvQ0mtc8YGcH3O?=
 =?us-ascii?Q?Q8I0bdTBNC44W//yshlcEu4xog9LFmkHuesqRL0mNzASCvWWjhp/rAmIaECc?=
 =?us-ascii?Q?/+tUU2w2IjzipUEj9YpLOCymyNBwH/HROq4qkD1NHsWDK+sb9MXFxQgVGnL/?=
 =?us-ascii?Q?JuJs0ThozIS6hxkGkhYapsZWO9xqeQ6X3ErhFB1j+GxIrdtksOhqsHxi/uTH?=
 =?us-ascii?Q?k6zQyr/da5onJGJl1m/DrlgYwGsebO6xpkas+aN4wykKQGS4yBAi5eS8jG22?=
 =?us-ascii?Q?2hZTa/6NjvWJoBS3KF0clffOqSa/4u1xHcg4kzlJVbGe+6yQmZ30kFzYARIQ?=
 =?us-ascii?Q?WRFEGK2hKOtpAeA5kE5lk2o0C9YmHLnSyuVVub1gYrHwd+uc1lNP/EozbDpV?=
 =?us-ascii?Q?B5SXfBD5cXdB+9MawzvhRQZxNQ9yFf6A04c2vfeg0hTv4atakBBSWls4oQSG?=
 =?us-ascii?Q?VtJr+5GBPeJ+C0a590w7K6pxuJCwqqGf4wl/sOKd8T5Csp0vLBUTpra6Q1ah?=
 =?us-ascii?Q?AoWrAJWjfTwYQ6FFy+rRMpCQ8OQGKaGWzjIrp1++u/P2IcW3+DTKCeZbjGE1?=
 =?us-ascii?Q?/iv4Ps7LXz/f4u94r1ce5P+DihaN+qvCPLWujy622/8wIPmfAizdlPCLQao0?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vlI2tSpefzGdbgPNcjlHKax5KbMYHMLMB4BUfyywtbW2yCuG2ZjrLYUMIaWqcz7eQ9J/8FpnxdhBv9fs4ji0lqXKB61gXzrZYTwO+RGyMQuXlvPj5ylbayz33Jwhfbo1UGK+axumuOcAQ4PVdRUazXxgEApv3Y0kAln1KspLxLnLJNCvpIbHrL755xAkHa6Hq11/9mZuBwYhabaOUQW5HqpW5IzimyczxSwMUJJ19m6n7TibvSHwYt+VqTYFZwZgWb9aMuEorYitYQX/e9r/9OfpWnwZBCy6pFqF7OsdpyhrYtmCgHICMQfUBiI3MTcJDxPEbjXFVu45FeQs0b/fYVZ610BQuUt2jCr9Fi68ERjtj4zQ9VPFPW7suRWe9IulOlsKW/xEwLh70jef8f/RwwmILK7lXOipSnoCgABoA9/6bmcU5ptGTtQL714+CHDI5AeXcCzy2MnvSsdhB6YQ3xgKxQlSMpEj2NtSDalFWjjTMX9pzj4xq7OoBoSqre/8/4UXHX92uARaLHcuo999YhBBoi6t+Jn1Yx/sucUkd7uTtf84Eo6bIALCQkowHEbJjZpKB10P8vVfJwxQhTRtZ1HGOxxYyoLYSaHVHdm66PfPiVVZwQZ+U4i2gkoJ0Jr7JqRzyrPnj52KraKe7jhu0GZz9+HZs3/cWvyG/p2p3tVnJOCHfUBAjzsZoYOMjc2/yKFLv1v2r3bBVm52VkGMPqbpPJqRwNkMWPh2vLl7KDst3CnRHADswo9SYxYRsVEVLqSESYRrzum0drglLzDSjs6g3XfNoY+sjaJrzmmFHLN/+oiLDT35FjrqVv56MMX93OCmA7fqENqFaw7mE0OFyXXTWUA+2sZt8Kot8n8OWFNLMjfg0Fjps9B5uXC4nQUa6ugOkYNMUP8IVi0qkAsvDA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ff51d1-45ec-4361-a85c-08dafb035b19
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:26.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6WQVnw4Dtak4JZZBDueOENmsJlywE7AioXahPBWDID7JJoh+BscIvoT7j8qRqWZxG4k3qE+KJwiJbGUREy3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: 86XGrhlzZVOTgcz9arIHe8k5AO10CDoa
X-Proofpoint-ORIG-GUID: 86XGrhlzZVOTgcz9arIHe8k5AO10CDoa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Drop the vmi_* functions and transition all users to use the vma
iterator directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c   | 14 ++++----
 include/linux/mm.h | 18 +++--------
 mm/madvise.c       |  6 ++--
 mm/mempolicy.c     |  6 ++--
 mm/mlock.c         |  6 ++--
 mm/mmap.c          | 79 +++++++++++++---------------------------------
 mm/mprotect.c      |  6 ++--
 mm/mremap.c        | 10 +++---
 mm/nommu.c         |  8 +++--
 9 files changed, 55 insertions(+), 98 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4334bd35984d..f3c75c6222de 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -909,7 +909,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			continue;
 		}
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev = vmi_vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
+		prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
@@ -1452,7 +1452,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma_end = min(end, vma->vm_end);
 
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev = vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
+		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
@@ -1463,12 +1463,12 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret = vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret = split_vma(&vmi, vma, start, 1);
 			if (ret)
 				break;
 		}
 		if (vma->vm_end > end) {
-			ret = vmi_split_vma(&vmi, mm, vma, end, 0);
+			ret = split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
 		}
@@ -1632,7 +1632,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			uffd_wp_range(mm, vma, start, vma_end - start, false);
 
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev = vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
+		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
@@ -1641,12 +1641,12 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret = vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret = split_vma(&vmi, vma, start, 1);
 			if (ret)
 				break;
 		}
 		if (vma->vm_end > end) {
-			ret = vmi_split_vma(&vmi, mm, vma, end, 0);
+			ret = split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
 		}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bd0017ab13f3..9f519c6ea006 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2839,24 +2839,16 @@ static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
 {
 	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
 }
-extern struct vm_area_struct *vma_merge(struct mm_struct *,
-	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
-	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
-	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
-extern struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
 	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
 	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
-extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
-			       unsigned long addr, int new_below);
-extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
-	struct vm_area_struct *, unsigned long addr, int new_below);
-extern int split_vma(struct mm_struct *, struct vm_area_struct *,
-	unsigned long addr, int new_below);
-extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
-		struct vm_area_struct *, unsigned long addr, int new_below);
+extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
+		       unsigned long addr, int new_below);
+extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
+			 unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4d4471916465..02b317726c9a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -150,7 +150,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	}
 
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vmi_vma_merge(&vmi, mm, *prev, start, end, new_flags,
+	*prev = vma_merge(&vmi, mm, *prev, start, end, new_flags,
 			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
@@ -163,7 +163,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	if (start != vma->vm_start) {
 		if (unlikely(mm->map_count >= sysctl_max_map_count))
 			return -ENOMEM;
-		error = vmi__split_vma(&vmi, mm, vma, start, 1);
+		error = __split_vma(&vmi, vma, start, 1);
 		if (error)
 			return error;
 	}
@@ -171,7 +171,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	if (end != vma->vm_end) {
 		if (unlikely(mm->map_count >= sysctl_max_map_count))
 			return -ENOMEM;
-		error = vmi__split_vma(&vmi, mm, vma, end, 0);
+		error = __split_vma(&vmi, vma, end, 0);
 		if (error)
 			return error;
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f5201285c628..195dcf83dc41 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -809,7 +809,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 
 		pgoff = vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
-		prev = vmi_vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
+		prev = vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
@@ -818,12 +818,12 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 			goto replace;
 		}
 		if (vma->vm_start != vmstart) {
-			err = vmi_split_vma(&vmi, vma->vm_mm, vma, vmstart, 1);
+			err = split_vma(&vmi, vma, vmstart, 1);
 			if (err)
 				goto out;
 		}
 		if (vma->vm_end != vmend) {
-			err = vmi_split_vma(&vmi, vma->vm_mm, vma, vmend, 0);
+			err = split_vma(&vmi, vma, vmend, 0);
 			if (err)
 				goto out;
 		}
diff --git a/mm/mlock.c b/mm/mlock.c
index 0d09b9070071..0336f52e03d7 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -418,7 +418,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto out;
 
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
+	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
 			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
@@ -427,13 +427,13 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	}
 
 	if (start != vma->vm_start) {
-		ret = vmi_split_vma(vmi, mm, vma, start, 1);
+		ret = split_vma(vmi, vma, start, 1);
 		if (ret)
 			goto out;
 	}
 
 	if (end != vma->vm_end) {
-		ret = vmi_split_vma(vmi, mm, vma, end, 0);
+		ret = split_vma(vmi, vma, end, 0);
 		if (ret)
 			goto out;
 	}
diff --git a/mm/mmap.c b/mm/mmap.c
index 0696bf9e1085..4a5d5c9a8dc6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1013,7 +1013,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  * parameter) may establish ptes with the wrong permissions of NNNN
  * instead of the right permissions of XXXX.
  */
-struct vm_area_struct *vma_merge(struct mm_struct *mm,
+struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			struct vm_area_struct *prev, unsigned long addr,
 			unsigned long end, unsigned long vm_flags,
 			struct anon_vma *anon_vma, struct file *file,
@@ -1022,7 +1022,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
-	struct vm_area_struct *mid, *next, *res;
+	struct vm_area_struct *mid, *next, *res = NULL;
 	int err = -1;
 	bool merge_prev = false;
 	bool merge_next = false;
@@ -1088,26 +1088,11 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	if (err)
 		return NULL;
 	khugepaged_enter_vma(res, vm_flags);
-	return res;
-}
 
-struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
-			struct mm_struct *mm,
-			struct vm_area_struct *prev, unsigned long addr,
-			unsigned long end, unsigned long vm_flags,
-			struct anon_vma *anon_vma, struct file *file,
-			pgoff_t pgoff, struct mempolicy *policy,
-			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-			struct anon_vma_name *anon_name)
-{
-	struct vm_area_struct *tmp;
-
-	tmp = vma_merge(mm, prev, addr, end, vm_flags, anon_vma, file, pgoff,
-			policy, vm_userfaultfd_ctx, anon_name);
-	if (tmp)
+	if (res)
 		vma_iter_set(vmi, end);
 
-	return tmp;
+	return res;
 }
 
 /*
@@ -2231,12 +2216,14 @@ static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
  */
-int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	int err;
-	validate_mm_mt(mm);
+	unsigned long end = vma->vm_end;
+
+	validate_mm_mt(vma->vm_mm);
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err = vma->vm_ops->may_split(vma, addr);
@@ -2276,8 +2263,10 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		err = vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
 
 	/* Success. */
-	if (!err)
+	if (!err) {
+		vma_iter_set(vmi, end);
 		return 0;
+	}
 
 	/* Avoid vm accounting in close() operation */
 	new->vm_start = new->vm_end;
@@ -2292,46 +2281,21 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(mm);
+	validate_mm_mt(vma->vm_mm);
 	return err;
 }
-int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		   struct vm_area_struct *vma, unsigned long addr, int new_below)
-{
-	int ret;
-	unsigned long end = vma->vm_end;
-
-	ret = __split_vma(mm, vma, addr, new_below);
-	if (!ret)
-		vma_iter_set(vmi, end);
-
-	return ret;
-}
 
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	      unsigned long addr, int new_below)
 {
-	if (mm->map_count >= sysctl_max_map_count)
+	if (vma->vm_mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
-	return __split_vma(mm, vma, addr, new_below);
-}
-
-int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		  struct vm_area_struct *vma, unsigned long addr, int new_below)
-{
-	int ret;
-	unsigned long end = vma->vm_end;
-
-	ret = split_vma(mm, vma, addr, new_below);
-	if (!ret)
-		vma_iter_set(vmi, end);
-
-	return ret;
+	return __split_vma(vmi, vma, addr, new_below);
 }
 
 static inline int munmap_sidetree(struct vm_area_struct *vma,
@@ -2391,7 +2355,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = vmi__split_vma(vmi, mm, vma, start, 0);
+		error = __split_vma(vmi, vma, start, 0);
 		if (error)
 			goto start_split_failed;
 
@@ -2412,7 +2376,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
 
-			error = vmi__split_vma(vmi, mm, next, end, 1);
+			error = __split_vma(vmi, next, end, 1);
 			if (error)
 				goto end_split_failed;
 
@@ -2693,9 +2657,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vmi_vma_merge(&vmi, mm, prev, vma->vm_start,
-				vma->vm_end, vma->vm_flags, NULL, vma->vm_file,
-				vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			merge = vma_merge(&vmi, mm, prev, vma->vm_start,
+				    vma->vm_end, vma->vm_flags, NULL,
+				    vma->vm_file, vma->vm_pgoff, NULL,
+				    NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3241,7 +3206,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vmi_vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
+	new_vma = vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 42ceb0548754..c417f7d5d0e3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -642,7 +642,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	 * First try to merge with previous and/or next vma.
 	 */
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev = vmi_vma_merge(vmi, mm, *pprev, start, end, newflags,
+	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
@@ -654,13 +654,13 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	*pprev = vma;
 
 	if (start != vma->vm_start) {
-		error = vmi_split_vma(vmi, mm, vma, start, 1);
+		error = split_vma(vmi, vma, start, 1);
 		if (error)
 			goto fail;
 	}
 
 	if (end != vma->vm_end) {
-		error = vmi_split_vma(vmi, mm, vma, end, 0);
+		error = split_vma(vmi, vma, end, 0);
 		if (error)
 			goto fail;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index f161516ab3c1..71ba8eddd836 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1043,12 +1043,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			 * when a vma would be actually removed due to a merge.
 			 */
 			if (!vma->vm_ops || !vma->vm_ops->close) {
-				vma = vmi_vma_merge(&vmi, mm, vma,
-				       extension_start, extension_end,
-				       vma->vm_flags, vma->anon_vma,
-				       vma->vm_file, extension_pgoff,
-				       vma_policy(vma), vma->vm_userfaultfd_ctx,
-				       anon_vma_name(vma));
+				vma = vma_merge(&vmi, mm, vma, extension_start,
+					extension_end, vma->vm_flags, vma->anon_vma,
+					vma->vm_file, extension_pgoff, vma_policy(vma),
+					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 			} else if (vma_adjust(vma, vma->vm_start, addr + new_len,
 				   vma->vm_pgoff, NULL)) {
 				vma = NULL;
diff --git a/mm/nommu.c b/mm/nommu.c
index 9ddeb92600d6..9a166738909e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1297,18 +1297,20 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
  * split a vma into two pieces at address 'addr', a new vma is allocated either
  * for the first part or the tail.
  */
-int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		  struct vm_area_struct *vma, unsigned long addr, int new_below)
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	struct vm_region *region;
 	unsigned long npages;
+	struct mm_struct *mm;
 
 	/* we're only permitted to split anonymous regions (these should have
 	 * only a single usage on the region) */
 	if (vma->vm_file)
 		return -ENOMEM;
 
+	mm = vma->vm_mm;
 	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
@@ -1465,7 +1467,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struct list
 		if (end != vma->vm_end && offset_in_page(end))
 			return -EINVAL;
 		if (start != vma->vm_start && end != vma->vm_end) {
-			ret = vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret = split_vma(&vmi, vma, start, 1);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.35.1

