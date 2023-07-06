Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B4F74A258
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjGFQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGFQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:40:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B929C1BFD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:39:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366FwvbX014223;
        Thu, 6 Jul 2023 16:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=AlepPsPN5ijLtdW0fpaVmyRQE1pVyexGYLHqAumPIOE=;
 b=eXxZ5D1l3WBlP4Dl5ds0s1Ze48perpl/Lnzlv2WefTBihD+qPloukkWK8g9DQ3pO3cgd
 yHvO2D/Pouxb7BTwrAJu5d/cn7ItGpU2WTmZB6Pl9GWB/lrqM6RRgnEFKvEC1gXJwiYM
 nG1szY3+bLD0GZh2Y9e/fQh7BX9RM7arfjkn0wdPoj9bdnZYrS+HOA2tDhQ6M54PicvZ
 VKR2xYp7+RH+mqGpAt24d7E8BZNDkcrjeTE3Ohi42dceyRCPAVCa7ZCKU+7eqD4cJEO5
 jQVylJeUvjc5pvXycAeH6kVgienPM9b2F9lz04AHLSFWGn2OKioVUTB/Iyj8n3DurVpq iQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp0nw03pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:39:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366GXnsM013569;
        Thu, 6 Jul 2023 16:39:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7av8n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:39:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRiRLsfcgNsP+kOPhJrNfgztBvqokBeqLK3aQpZCBMGlORdMc65gTwK3ESLSKepYcXBIR6d9++Lpwh0vhaU25Vwr8GJkeuDzkhnFhboI4Pj75INFQmVpMmXwqK/tH332ABN9J0A+2C3Q5We9mTD0s/6UArDQjAM+qvjjJ9c6sbL0/UWabRXb/g7nRauBNkaX+LPv5UQaSfl7OE0YYEX8pKwV1oF1mzSN4N9Ha4zijI+uNbX2jFAVWrni9y0IIqCWHVJFN9Q/vr9UGjYBtI6vxWNMQaR5zbCLuZ8573wHzeQyoYpWiruXINIVlDbMvFJZeu9hJF/tgSNTZ+hdK9jgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlepPsPN5ijLtdW0fpaVmyRQE1pVyexGYLHqAumPIOE=;
 b=Jm+UzkcUi09fuiD05EWcJ8PNoDTNG/r73OY1JkZ4hs85hQfiS9kQpts76KyRnq9VeK0K1n2YZkPD8lL01NQQEC2vAE4K96uypDdcOvEmMPWhQUNlW5aXRGDiVvCw4wpFb2beKc96SDH0Z13/7ycpqRROWb7kbR6temAwUvb3bXCyJeV+8XHT8B2b/2W1OoGV/C1R0QM3I2o+5kERW/e4cN9XvzMGonQPvQ61t6nhrbPjBUdYeytapy6FgfME9HmTfjf+YHo4P1fMuA97UhcB8LFeV1Jk/XNe9ZJ1HH4j5Fc7LCmm1t166VA3P0IuF5azR3veIy2Fj8anaGjOUZhjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlepPsPN5ijLtdW0fpaVmyRQE1pVyexGYLHqAumPIOE=;
 b=Ht+KNam4g8GigvDwFocpwmPfh1MqS8IjxFNgMQ1XBrnA7D3dmB5ippeDYi60uqpgqs2tihD7qU5Zy0AcgzLn9x6okhFoF9/WbadTNehc5zoCkNouZmHtxeJmcqc9tY3OvQtHwt1mJiMXC2MMqpCSCY0YSQ9ba47WyY6JZiHNFbA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 16:39:02 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 16:39:01 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        zhangpeng362@huawei.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 4/4] mm/memory: convert do_read_fault() to use folios
Date:   Thu,  6 Jul 2023 09:38:47 -0700
Message-ID: <20230706163847.403202-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
References: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:a03:100::47) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cee2d7-5b92-458a-39ed-08db7e3f810e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fr94jec+W3V9sy51ms8Jn0EydXjfCFtOse7ljYxIuQT/1lsqvHKTJKjfGnubnbqsD9bnvM9XkGUVBdeE4zjm8Lde3gWfvj5t/ASvIqe7Hs0DJKAjE2nlkanvGnDh5Fh+xn69L4fWn43NCUxDpfxEz3i9SghNjnrMUZxQfLdcGhs7wbVkxWJThmAdaWE3AFD5lJkCHQr2TTKn/Gb5CEL5/j25fP/cfRDAJZC/yiil176UB4OIWWvVu5w9++iKE0xwvq0/SGwSOyfaqJWNNUzuyIJInTi+cAvrxQWIFXkpI464jROUTrnqcSiGKmtzcfua9aB350WhUokdNLvUZhPG0B2AQ13LyAt/B1d3V7bPn+1K1/JPjPwnbCGO9sUMhSYSQj9TXn1rmL+SRvrDAuRyFGzSc61W1Yzin1VbEiJmgS5XAO39bH31mB9JCU0x7nmpeX4sL60d04fy5PG8c03JgiD75oyRxcrj4Jo9WguxskTVdswpAG9ODY/kNAntw3CKEmdYwZTLTJHXaXvztBkUNKnkdr+cBfd2eWbBCFh69MYto/pfU5r7620ZKx/VFC8Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(5660300002)(44832011)(66476007)(66556008)(66946007)(38100700002)(4326008)(41300700001)(8936002)(316002)(8676002)(86362001)(36756003)(2906002)(6666004)(6486002)(83380400001)(107886003)(6506007)(1076003)(186003)(6512007)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tS5tCeXh2zmHlqpRYebjo/+X42pRxi+ozHV1vkaaIv75AdDNtOScfv8SC3yB?=
 =?us-ascii?Q?sp9FJplzDNlwExdsFjCApOU2Fz0xJW64tyDFb1NY5/HZN3Rn6WtkIl1uJcvy?=
 =?us-ascii?Q?B9EsSOLxZRSzViY/3iUTWITv3ZSd/HvaJWHi02qh2I4rteNoMRVH/EnGUbX5?=
 =?us-ascii?Q?atcoY7T9VBVk8nGBkLLxLQaF8zKujRxNCYzWeBN7Ta76AkJtInuhCM1KhwkL?=
 =?us-ascii?Q?GJc3nxOFFGYFOTcM20esLtNCVXIV8+tj4xCN2NQHjtcluNIbqcYKVapgkPfe?=
 =?us-ascii?Q?n8A/gNupAddyqZU4LrxN9OMJHCYuOHhZHo8+Ei9IkmQ96Rik0vr65cBnPPBs?=
 =?us-ascii?Q?yjj963RtgkRQNtDfliOQTDz62rhFhbsduavMfxs+dVnRN7mhfNG3vWb4Wuyy?=
 =?us-ascii?Q?oQf11ZC3zPn0LyrYOIkKBiz1+qOvObB1r8gcGDVH5QQZwssQMNbDGbE3iPmE?=
 =?us-ascii?Q?AwFszV+xNJm6gPEWVeSjkIN+jpuGZE8Y9Hn3Iqm9Rwi+kAeo7wncBLE4P7nl?=
 =?us-ascii?Q?na5oKuK/UL86awVlRbWbTtAxUX70YkU1RhyUFT/ncGvTeJthUDbhJMahFeTD?=
 =?us-ascii?Q?gaSdbHg5nGxMADjKst0der3RCissffowinWWY91GXEeYa240kgdZTRU6kinf?=
 =?us-ascii?Q?a3yh+3OesBf1A2iEFEm+YbzIxfFWK45QXyb/cNouxpHE4gHChhik6fBzMVvJ?=
 =?us-ascii?Q?OWLaW/qFnEXjivTzULLewWEcXoteEUtCkqKqtGsax/SFgo/TPg4UMuMpOMZd?=
 =?us-ascii?Q?NpWEIFvyViSRj0bISi/Fe6BegTuiSPKREEoGShowdS1mnQb1dcPw8haGaYqt?=
 =?us-ascii?Q?uqcIbPls4ioMXMx7sGK6ZaGp8VRAxAZDYctWYhkGq9UlxLqQM3jTDtt97oQL?=
 =?us-ascii?Q?KXowlWs7atnS9JU2TbWRsgQ89sdvpeamZnKBEhkgTNAXt08kAbBtguOB63jq?=
 =?us-ascii?Q?Ed2O32rLXll447hcF2dp4J3qwwB/NJUpD7+qXYR1s2hDbp/xwGwYPFAVxLHx?=
 =?us-ascii?Q?DlAKLEx2Y4kljqvpAxC2N/wU8Y0xcnE2SYfctEa7gyRLFbs/yi41pIwBnGeE?=
 =?us-ascii?Q?MUbNwCUtNUBxXZZsd0AKIdsNj4ou++BmLIXcSyokmM4eN0mUnsTQqKrioHos?=
 =?us-ascii?Q?rQGN9osXgR61c/In6HgEAKojuFBlFXidWL8+GazOJR6X2iUA/lBe1wTtKETm?=
 =?us-ascii?Q?gbgAfWQiCTvhumVC3rAF25emjp6NUuDnWNeeYknBVZOmvHG6hrd+24+DJLWP?=
 =?us-ascii?Q?IMNuleTE5N8NgsdHDPSYwE0pyt+5rQK5Uk2MDFYcryAs78ajq+QrLPIAaJAS?=
 =?us-ascii?Q?YNlHbwUfYxtrm5eOjs58X3EDmpj9yNlv4Wmx8Z2+u1bS4Ae9/BXA8T6RqJEZ?=
 =?us-ascii?Q?b8F/Iv4kyBIkVp8788BIzLxOopWMqC5Ex+6/3NuGYxM6+8dslk7nIRtbnFol?=
 =?us-ascii?Q?N5W7dYZCwwCoFUkHuUrOjcGocSpQjj+rgsu6yl7FFS52wuwmk6SmUB9gPg+o?=
 =?us-ascii?Q?hzWLEAKPvhW/PI2osQec0Y7HQnOXG2nGbxcxTBvv0YYyTedSe5Uhga0A9f1J?=
 =?us-ascii?Q?iI6utLlYOfwGsA+x2o6zOQEdUsted0NCMloQKMktyQ8PBBtdlsTOFclx8UGM?=
 =?us-ascii?Q?TKB1WvYNjmGTkVEA8vk/fU0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gpSacCMJq7p7Ik121LRWehy5OIMzpgcvaCRqNLLwHiNXuNFOyhUNHFlBkfKKYjRJ3ovpMTzO61Ug50pCKTPkhUStMJf2caDaAa2T2p95J0ANTTEqQBR3eQTl42K/S177ANaGB0WQpfNpA5lDbvaP0F9vsJeWEYpjLklEynfVxv/ZofybB8lO0DXUK6LDn3e2Uv/yx8SfdcGKKB8IItSana5qKjGmbyTqG3+XictCtl58uYgqSQX8gsAwX2JWfA/nDLOPSJ8OFBqWlByueaK7CJVrREfmZ7J8a5whtzW8c3nGUVw1r71QbuaTDoFD/qhYsnRiLPOHBTCQEH49vDCsjbJ5RKoBm4ysACA0J6atfQISG0WvbZI1ifO03hZ5+SNrr/DbjLEAJJn799CmW5NnNONvULnnmL2oOqwldW4lafddI95NrJWk36A8MEJU7xA2dyNnYm9OwZp0pmzuGKQfhiwC+PhWPSe4Y/U4L9kHJTfQIlgLYFGJ1hfgaPNDKKqj0kotlc+zPmjKT9mW9ULCo8X8tpU94GNlukDtG8MpwaRnNnlwR+HlLNrJaI1jIKFrZadjjdfI25r8MTO0c/wl4YSFu7EPCCxPgL94jcgFS9h7O2PeTTuU//Nd18MqV4HGcDJjO/nAo1oJ4xhjivgQE4GN03KQD37f59Q71NBJ/AK4Ozz0xIpVpJckITh7Bb2PmpPTYrhI+noJgNPjDaR7xRquXf9RToDQys3UO2myRWbdEZDHdTlAZrtP4FkXjmPWTogvzGURiN/PwxjhwlQwISxkItSrroNXd2aNuPziF1MMhoo3SocU1ygFPI7eH6ZURgKmmdPqDL7yka0icEfd+6DdFJqEX4O/KOEB7NBtDhYYfCzfYEE29HitPHl3sGIljwjwEtopnPf+jzwKeAyIuA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cee2d7-5b92-458a-39ed-08db7e3f810e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:39:01.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uia3hf0jRoy6uv2pNR5UgpJl6oB3T0GgaUtJ1cqZR1SxifrgttnVMzStNGxM1xHFcPsX1pOhEhztDspNJtz7gZznvFGbFZmy7xYBdtIEaZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060150
X-Proofpoint-ORIG-GUID: v7EttGctZifglOwKhdnpVggBVL0lpqLG
X-Proofpoint-GUID: v7EttGctZifglOwKhdnpVggBVL0lpqLG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves one implicit call to compound_head()

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v3:
	- move folio initialization after finish_fault()
v2
	 - move folio initialization after __do_fault()
 mm/memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a59b10e534c07..64e1eb840dec7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4541,6 +4541,7 @@ static inline bool should_fault_around(struct vm_fault *vmf)
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
 	vm_fault_t ret = 0;
+	struct folio *folio;
 
 	/*
 	 * Let's call ->map_pages() first and use ->fault() as fallback
@@ -4558,9 +4559,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 		return ret;
 
 	ret |= finish_fault(vmf);
-	unlock_page(vmf->page);
+	folio = page_folio(vmf->page);
+	folio_unlock(folio);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
-		put_page(vmf->page);
+		folio_put(folio);
 	return ret;
 }
 
-- 
2.41.0

