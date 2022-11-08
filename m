Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7776205B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiKHBVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKHBVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:21:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8394213F69
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:21:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OUUf027229;
        Tue, 8 Nov 2022 01:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=gtqTEkPQzweWciD5nD8HDYHEGKXtt6eCVEthwucAffM=;
 b=skna7wABpxFOe14uY00kfqF/s15CI0y9vRZQuFlRXpDgJh15YpZQgzRpyV5chr5u/IAS
 KDzA3Cj10l286YuuRh//F33Eh3TMhzderO2XxhFAHP2XYiFpi4Ej3V1KLqNYIIeWVe/b
 59TbaVdUZvDscYYdKSDIKPi3oLy7tX0bB3On3UJjsmBAqHJTYBRNUo17ltANyEkQ+t0P
 AQPAlCTYXDtjr/ZmNUFZA3uvNKaB4Wv93lzEPyQ2Ml5MrlyFAFNLTggQKUQjw8pUa9hh
 p+W8tpdn/r8Los/CxpwVPKYTxdLMax3Zx7yLUanILlwPeARFFlnVxCwx+SOcnojZl4w9 Kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngrenpeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 01:19:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7NGKN6034512;
        Tue, 8 Nov 2022 01:19:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcscwm43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 01:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVpyY0mvjXD8g10h7X6QKRDQktQ3EYh8Z4T2hZ5PIVC/zj5J39OU1DkxVvEupgSD9yWy0vN41+ZdOZapESVh/1SkWVKGS9rTyH83PJI9Dxh86oKzbnxakSkoXbmLwGD4oS2Dk91mNIQkY8II3HtnUN8KIg7ioYkDcO4lc84XyFiLRTzxC2n4x9MzLg4G8zm/IIAfypxG2+rhE5adqtny1A9T/yYvKSee/zdN1JeqvqGUWOr1MwZEo1BglAiis5+FC8SopTHPw/vQTdHPrxywylf6S3NG+QHZemYPCr/sOKhjTgv+OaoghR99Px2XXlxmjNuTR4iorqzlL7qFtee0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtqTEkPQzweWciD5nD8HDYHEGKXtt6eCVEthwucAffM=;
 b=FPVTfU00zuHy4s5CxMTtAb1VqmwPs80ayBaT32OgDxBHkuvHpTZuhNxSrwys0WjffgdykLqU7Gc+ZBD+GHMIwt8QR9YDbNeWEAxJs+ZGZRRY1O1l7spHil+KqH+J6fiTlQ/zqSD07D9fYExIG2lvy13PktbGElam7fuPQDBrDNK0X/HA2sZxLiQDp+DsR4J5QQNDpLyNZk9wlRFNMN1A/0sfknKnJ+np5tgr7wr+UGvlI4CfIshUDL1b+JW9K0Pt5jDK7kw77mPCIUhn1E22LQH4V21KPDASb7XDGNhMvokEWzJjviB0RDno1QCcjkPuwsts3LO/77ux7m+KxseaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtqTEkPQzweWciD5nD8HDYHEGKXtt6eCVEthwucAffM=;
 b=EecG4nt8oD+GePKZ/XFZmVMgmxmwBBhM0QyENWXJDUhtStHb3P9Ac8wUOQZoZJDxxwZKjykSGTn1R/cil4C57ewQMWi4eea65peY08GWSUwwd7eOW15x5umwmq8SunFb8ebKqyt0x7l4PjPDDA/xkm7NaoYQqYg/kr7uUi/+2co=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5552.namprd10.prod.outlook.com (2603:10b6:a03:3da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 01:19:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 01:19:24 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v8 0/2] hugetlb MADV_DONTNEED fix and zap_page_range cleanup
Date:   Mon,  7 Nov 2022 17:19:08 -0800
Message-Id: <20221108011910.350887-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0276.namprd04.prod.outlook.com
 (2603:10b6:303:89::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: faa0d1f5-351c-46a0-3097-08dac1274570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azZlaIWzovCMjceEOr824hcXGXeCnlqluhv72BoGrSMD4y3y5901RveJl9O34yeIQ4gd1NgiqmGuuWp7JR5viNZohcj825fR9/5mOL6QN5Tst3S5GXJA1ePhtgA1py8KBVoCv1BuALl2cwexNbBayfBxO5BperKG9qDJ0SMKxLkh7LvGzV21VgTgWlvsHkOHqvBb1IhzxkCefpAoEWBdIOTZgzH3wCvZXPv0llp1haxuqViT9lS1/bsWLO8jdKLf70H5grWXQdG6d20L31YGhZIwtHXKBr6pUvOjElzFHdbUOMLdsHo/uRBDUKQvpY/MquprG23qYV1Xekdkf157A/pRqLw4G0VeqTXE3mhRsu4fLmgHFIkcugzuX6TS1mOw1vUGSmoIbLnjQzDKjhYzIiHmhlN2c587uhe7UimoyyzXfEDtKuVPz5nYf1JIrYt/RNAaD62wczW6VZTJ0gBQGKdZd0ZeoKGMZT0msHVA16qLs8i1eoMEQ7MgKODqjIazYiVNX60XYzw8pdhbsQUv7vV8oZtIORvTyLx45VO2NwpTsKiprX2M3tf5/O44YlUlbwrAe1ie/rTLP28iQOAWelYYRtHRV3PP/KNMdGX1mtaknVYx6JWil0fN8jRMit/8MIRhK5qa9cZUrpnsqHoSM0QwFjgIYZi1iiRBZj7WXusvOOj+UIi65ZAds6XZlwNtQnf9Je2vz0h1+5KQcSXiGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(4326008)(66556008)(8676002)(316002)(66476007)(66946007)(6486002)(54906003)(2906002)(38100700002)(8936002)(44832011)(41300700001)(6506007)(6666004)(107886003)(7416002)(186003)(1076003)(2616005)(6512007)(26005)(478600001)(83380400001)(5660300002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ja2cJ8bYdDEaamKCc+f6vBfso3z33jgE3X3Dokjes8ShyDktIWrKv4Tlsh/U?=
 =?us-ascii?Q?GKPUDO1/n1h/2X/inil5SP2SCaL/DLM3xXgCfyER1fA5+P0rFgyD071hJt6W?=
 =?us-ascii?Q?eqUR/aAr+CJs2J/EGyUkp59tz0lWVVnBCH7fu5zIjSvoc89dqQxcs6VS49lC?=
 =?us-ascii?Q?BWY4hSgW5OWxbgcz4zeW/9MSfJFtFinm572DIQ2vlROJX3m++Ck5BTJyk5jc?=
 =?us-ascii?Q?0o8Yrb1EXPePOBQeMQ8RKFKgjOYcdGNOhHPhFEgY5Nkmapd+Em4O6NGpr0Xy?=
 =?us-ascii?Q?zjZnO92PdAgJjYAA+UnbyQD4FJ6D2ZQYM74mSU7LVPxTYvepeoKke/zaBUkb?=
 =?us-ascii?Q?H73T8+y3MUNklN/bxsrjmxudD4feZ1yRQc4tvVm7aaIHBfVhTDZC6c3LV8ib?=
 =?us-ascii?Q?zp11gOxP+d0i40L61fJCI9sH5BRWLK3XPIV/kW34aupM4Mq3CFt6bh91EF8Z?=
 =?us-ascii?Q?30Zc+UNqRddfg5JQKTNcE7sq/0Rwj3mCvSuuGxNT9iM8Va3srFo8klvCJalu?=
 =?us-ascii?Q?f+3hS+bYvI9MFRARDhq6e0EdY8O5GvQtwOuEldc/hUjakFrQJ4TTMupflY00?=
 =?us-ascii?Q?aesiIa83bhr8EM1/J5fBYWekz5usZ1E/clU/oZM0lUMkfXuKnYGOxjxuwDv/?=
 =?us-ascii?Q?WgL1Wcc9KgoeKheHX5+JWInTeWvGXx5bc9CuM9PYC+2WWxa2lTp1vabfQKkI?=
 =?us-ascii?Q?oUelizrBolrtBKbpLE5H8X1IZlzuT7q5yOBawsdvjcAAy1Js6vDW67va+bzk?=
 =?us-ascii?Q?lxuaTQ7IfUKRtdaaa8vUuaSwU3ZMwIu7FESnczpaI4LpU2ggfM1QEtvjmJpK?=
 =?us-ascii?Q?O4bc4l9iFUUdGAyrPHiDhg49IBkEYXE+J6zGzgDxDSXcVtER8dJYFd3HTOM3?=
 =?us-ascii?Q?fnCZMcMFUAfZV1auD4ABg9+SVBBb7ZJFrP1smSKJjX5YDNp277KIvDBNFXt9?=
 =?us-ascii?Q?ZSsokvlFeJ4uD187RhTPnwOpTbjIWZHJHsqdj5aVt1zahcruJBr6MKXet2EA?=
 =?us-ascii?Q?nRYezuo3Oc17VWL3V21ldIprK3IYspKlKanxVjaRSekqnT7yMPzwuuJ/b5Xu?=
 =?us-ascii?Q?1KB5zuTugIt6Hy5h4TQy9pzXwzPkXp+sYHXtjEERF9mjc9xsZ0DI3aB0/w7K?=
 =?us-ascii?Q?YlTB2/rSoCh+sBBicMzjT70r957KbzvDFEGZj1DE48JXANQlx+6b5Gd7wOCU?=
 =?us-ascii?Q?dCda8fMhjwYeqrI71CA6cAM9T0PAmGQN90dsqprOppCk81W/iliCuLjd8SpF?=
 =?us-ascii?Q?lFmRonuKjLn+zRO2QsESVH1T+Je2LDAyXogyUkg8LpuBIky3VPPqg+Timx6s?=
 =?us-ascii?Q?egH2KPvDGocnpaqdA8JXkFMxYun0w5wp2P8uq0MYaXmioCL9NOIV0kDkIgdO?=
 =?us-ascii?Q?2s+R9V+3uI0TmBu0wlK2M6sdjRy1Qdi0EyKRrRrWTm/u/NKOii1DWjDGbAvP?=
 =?us-ascii?Q?HAR6edFhgCOppnTPUbo6E6zVnA5dNssSK9pC+7FA9imJByFgA/QTXl5Kofx+?=
 =?us-ascii?Q?lvkm7NmVDJaBGiBLu8ygkxpSyTWvrOxY3ijRW7kvLPepLnXOqF4ZYUboWOhq?=
 =?us-ascii?Q?coZWROUSOYCJZwwY/tTLNUDKGqBfx8VumWks7uLYzUvHYiaRTgJYvBmpeVab?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa0d1f5-351c-46a0-3097-08dac1274570
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 01:19:24.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV5vgXCvNGF6K5pUqrxG5zgE+WWKD/GPybhXkwptNj5KkSmX0nQqsLDESig7LV/HRtfGoJ4J9rlnFVSX3NS89A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=923 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080004
X-Proofpoint-ORIG-GUID: 9fhj6Mw_RPOGtTUNbCBrdxQKvpCqv2S9
X-Proofpoint-GUID: 9fhj6Mw_RPOGtTUNbCBrdxQKvpCqv2S9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending v8 as a two patch series.
Patch 1 addressed the huegtlb MADV_DONTNEED bug and should eventually go
to stable releases.
Patch 2 is cleanup which removes zap_page_range and changes as all callers
to use the new zap_vma_range routine as they only pass ranges within a
single vma.

These changes inspired by discussions with Nadav and Peter.

Andrew, I would suggest not replacing the patch currently in
mm-hotfixes-unstable branch until there is some feedback here.

Mike Kravetz (2):
  hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing
  mm: remove zap_page_range and change callers to use zap_vma_range

 arch/arm64/kernel/vdso.c                |  4 +--
 arch/powerpc/kernel/vdso.c              |  2 +-
 arch/powerpc/platforms/book3s/vas-api.c |  2 +-
 arch/powerpc/platforms/pseries/vas.c    |  2 +-
 arch/riscv/kernel/vdso.c                |  4 +--
 arch/s390/kernel/vdso.c                 |  2 +-
 arch/s390/mm/gmap.c                     |  2 +-
 arch/x86/entry/vdso/vma.c               |  2 +-
 drivers/android/binder_alloc.c          |  2 +-
 include/linux/mm.h                      |  5 ++-
 mm/hugetlb.c                            | 45 +++++++++++++----------
 mm/madvise.c                            |  4 +--
 mm/memory.c                             | 47 +++++++------------------
 mm/page-writeback.c                     |  2 +-
 net/ipv4/tcp.c                          |  6 ++--
 15 files changed, 61 insertions(+), 70 deletions(-)

-- 
2.37.3

