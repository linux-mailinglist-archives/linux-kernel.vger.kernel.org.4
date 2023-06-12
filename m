Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3796072CBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbjFLQeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjFLQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:34:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D1EE54
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:34:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CGODpR028609;
        Mon, 12 Jun 2023 16:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=/aIHyRBwvJCRdCRnNitNtvkKIXozMebKKNf491Brs4M=;
 b=h2VCR1Ny9Ua7T809aXDUcASpL9HJRO5SNtKRRCm3VG+uZ14kkRXwX6d0+XJdAlfv1QdZ
 Jys2LnWLF+fRXbaJMQOUgpAyMNX9UhDA9plnN1Oi+e0pw7WOIjcf5P9f3k224zHMsUPo
 y8F9qbWnzG09hH929aZ1U+bwkNTfyZyYAFaA6dbMsT6urTClTXD1IVL1y8cfPq9H4h+9
 7eF5a2vb5MfQFUa8av+4gfU4gGB/ljmXEhdhlePBQw31MWmda+j7HikVNfub81BS2NVf
 rfULpZCH4BdmbbER3txq3NndHtO7YhT5YdiG5QV0wmAXQb/WV9ZMJHi5WTO++77xTYND bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3bc99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:34:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CGWYZI008291;
        Mon, 12 Jun 2023 16:34:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm98qs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAd1dT8P1+Pomw//Dm/BW5LZA6rwhSN6gKm0tPP8qSyeKARzplEjlRLrySsIfpYhG0IDAr6CpkFwD5AWbnt3VBBKJ92b0ozOsyXR2iXrln0C6Aa8mtjqRp7056xIQ55LkzQcGv0O5GuY9SNIkTdOg1W7Dppm1Shme85ZWsabayjbJXEPKAU3K8BEZv4rdlHkpw18B5QP6lRTlDrDr5T2UlKQxkynUttd1HHNldDa5GCtP0V2toxBIM12b3812tEkTdA8CrXs/h7HiLsGvjz1YTeir1KWHq01HDyqAaICpnah5hf4cmj5Q/s1B/6AV4yuuOMUf84wpUsSeTplDyBksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aIHyRBwvJCRdCRnNitNtvkKIXozMebKKNf491Brs4M=;
 b=W1mdylsh0pDUqPrP+kMCA9hsfn6n393vqaWOp6kTDs8ON/BAhuVGwr5/DQVYRCnPquSo8zxhFKH8KNxFXK034qf7pN6yYtNYzFnIw+0XWmlYu2Wa6WyrqUT4bcE6c1O+wKFpmWbm1TEc4NUgoygW6QtCsgDOIs8wtKspquYs1k8IFUqvAzXJwkMvwrur+6gHXIMTBqDmVU1PvPG/hZNnWAi08iJMlt89AjW6X/EpFKLtxztXM2lcNWvjLctonfqctXtlBzqurlJADZ2w0EWBrBAqfH2ujYNqyE3KeLZZMJaIk9qnJwK35RhkQndfqWXoaK7LkrGvqNdqK0l7aBvU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aIHyRBwvJCRdCRnNitNtvkKIXozMebKKNf491Brs4M=;
 b=wLMPwzDV9GDYBGPql1XhXow24lNE2fainMbiU3QgCPLnloFtVZRB0UtQqydUAHGmq4A6SJCrw0SPfJOomZmUhhsj0+vmhrDu5ZcWe00ey2hfVUc8cWq+STAW4kkqDFtiaYyB5X3Q5WjlVQvfXuyuDJp4xLa+eOkN7Isa7B/4Rh8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB5266.namprd10.prod.outlook.com (2603:10b6:208:331::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.31; Mon, 12 Jun
 2023 16:34:16 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 16:34:16 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        tsahu@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm: remove set_compound_page_dtor()
Date:   Mon, 12 Jun 2023 09:34:05 -0700
Message-Id: <20230612163405.99345-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 83436bd0-8ea6-4aff-4c08-08db6b62dd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMKSTvJyRXm/JRfvQssRAHbrltikplhyqFkGncXN+z5lsU8NfMHn50Fm/zKlC/xLGpKGiywcvfg7z6k48WQjkltCnwAbvHw8S7Tyrx1A4VG36Z3wUL7aiPJlSN9UkGBJsZ8Rj9fJHBTD32cphOzrBrEK9ZAG2N1epqIhcYYG9pvELgFK5cUWehzMkyBWgEGbwMoD8ryVobsGV63EktnubLOVDAoOnHdrGvs6EjSb823h6mmeiH9+9dpKaqF79HX9EpLo1NMbnnctIedXqyqzAto6ReALvbAGqSjWB/7eXWeBi5Elk9MaLBdIYrpewhnBfwuHIOJdFWSq5RMEOZzDe2DqucON+Mbs2wkjMPzwjJgFcDZA44ozsPYR5DOlS914rnhzoKmSjcDL0K/snZpojZj9SR+PiL0dX4jrfxNNrirUjr/+iqO3hoseh/Esa4nIaR1RW7WN4RsjsBb0xZU4Lj4MbSYflircMDBu1jmyFDMv0yzyWXBf7fEiC0MwAWOXbYwzlOR+LORDYSDdUmAyo8CqoMJEZZFXPOWKVoGKxmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(966005)(316002)(6486002)(41300700001)(83380400001)(2616005)(6512007)(6506007)(1076003)(186003)(107886003)(44832011)(2906002)(86362001)(38100700002)(8676002)(36756003)(5660300002)(8936002)(66946007)(66476007)(66556008)(478600001)(6666004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eSh+wMuyCniisE3FN66D0PlfDRvjEKsh2qJyUFwHkgNv7oD1gnDd2mESMn1s?=
 =?us-ascii?Q?zs4U5cpYg8vTDSKJIEIdaq1ciP/AFtb+/TjQiy800zJnjMOwrN0RzSbEElT0?=
 =?us-ascii?Q?x2Z1PooIMQifll+AaA1YJ9/ereYVbBFB0BBoXZieyo8Nr44D6qUkJTpa+MP3?=
 =?us-ascii?Q?2ZLv8Ykc6CpkVDBy9v8xcfcLCHTSpdG86ESt+tJ7Ooq0+8MfSAnlRfmnzi1U?=
 =?us-ascii?Q?sLKrWbZNxKYZYBRb+FOKRd7TD+t/B4L0/n8eF7t5q0DK2VvbveUlbQ8QVuAL?=
 =?us-ascii?Q?VaYQEkOKG2GCYlW7hHfToufzrBxos98/c5k8T98w5/DU3ndX5/LjF441/UIu?=
 =?us-ascii?Q?QjtTHPbQ2fDpsecleyMH/AJLlp/wo1FJ0b2X1uv7NVeIk3G8AcDB9Gq9s27U?=
 =?us-ascii?Q?A3CmMw7MTyMLYvGsjp253IUdzhTVB93m8xA/3ioqOD9qiEvTEF4T8rBWz6ie?=
 =?us-ascii?Q?wmXsbiBP/L1q7Wu1C7twZSOJ7CGawGuCyIZQsXsK1p9RvhNSptBX3sd5LjEi?=
 =?us-ascii?Q?EDR9MpDqqfcT2fitsK7MCP4X5c+jKEAWPta/xxwMQyi/OQ9LZhVKsCsUFbBC?=
 =?us-ascii?Q?EJs+HiK8n4UbilhzT9PJFCzqKpy7RosGsw11lvrP1vsmz7XVw+RGUeFcppu7?=
 =?us-ascii?Q?Po1hmgCJRh92x7/LZKa3O/pnYO8nv69U7fBiFbHQteJmCTjPqWUkX5ZGRmrc?=
 =?us-ascii?Q?UNYevo8M+9Yr9p0qczHF9jcCc2Tpjfy682U9X+0PyzX8kZAaasJTQ0uZPtt9?=
 =?us-ascii?Q?qlExbvbb+IzL4lBXqhI6dIiJxHRvT2DQTEqJEzL3Ph5NZ3yvMdUeLu4b02FQ?=
 =?us-ascii?Q?XnSclsgIIphE6ufyCtDGW6kR1SaVrY8aYFV4Fv1PSE8hMvQUmh8x1rmWo7o/?=
 =?us-ascii?Q?GKscrgBERnm540PKrwFBPXCegxQVsCfB2XJttxTAyRLxT6u3AQTFfI2Pez+R?=
 =?us-ascii?Q?37j9Xb6fZgGVGvxFvSis1ZD82/B4k2UMCuGia2mLEKooMxAevAsC3RNNXobp?=
 =?us-ascii?Q?qpUgpCQzJQ599R8IZJmMYu5BJMdb7jcuOZ6DadlUPy9Qi942IYDvd2Ct1dz0?=
 =?us-ascii?Q?hbGEaKQY9GUgxo1WwBN2qDodU432UnPf4IRVPUhgMdCss2Nom46Gpu0QFw8t?=
 =?us-ascii?Q?iyt0GTu/xHs3c542wIMjmYIJ2BptEIsNaRkjB1HwrT9yxXn9GEZjdrgY3Ovz?=
 =?us-ascii?Q?CSp/rxY95L1NeleouPATH7VrKXfeJf6E4V6gfU3V9gzlj/ZTss3Pj3MXbBaE?=
 =?us-ascii?Q?KcWQTAtAmXJZqP9RvZK2nZ2+fDo1hs/Y0LSm8i6TvRWcm+W5nTZ72C6i7fGr?=
 =?us-ascii?Q?dvPHPUTxk6XKyXXaNB7SP1c2fXG98fOvGvB3423oRdmZNs5182gI7MzS1X72?=
 =?us-ascii?Q?VuqVUTkYP4G7xnG6ApmaEezq5IIIRCUQqxNPdKylEf23CtgBU7zSNSi6ZLPB?=
 =?us-ascii?Q?jTdL/E1+lXrg2askFU7BTOJ5NXIiM1afWXIsBbmu+bnc+ciChlbT9Sv6LOz2?=
 =?us-ascii?Q?vOd5p97KoTxTbtaX1JGdH4v4oHGPsGHg1QIX6UKcDffzQ/QpNii79Vx1HGCj?=
 =?us-ascii?Q?vVoOJFIbfVlP7H09lNG3qWX8OLftMr2MMu+NaXvJpEQM+d/kE/BDLHJ5SM7t?=
 =?us-ascii?Q?xsJ/6iHpz3CXgO2PhymdRfI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: axJqr86s8s+KM2xZBlda/VvXKvm8lf0DASfVDb/eKfN9kbrCKuy2o819zht/hWcibx7CtQ+L2JOKSqzJ5a7m2LXRGcaL8g5mU6yc3ThZ7+rVugLiOBd0Y3bqojxJrzeNar22kiR2jOaKQg9VBl4sL35ec3xNr+5FbH9Jt4e0fsgVQh7AZc2rEEeJ+SUcJ0olF8E3uioV1xNrI6h5Td16HmF7v9Cq+AYzKAy7YpgfvS3rtVhusnpaUi+/2cLnmAtR0hQMlT6a2DfAT42NhpAY0mntMya8wWV6aTzU5rjHLB8MnSkFHmjiPHcwEf59Vh14ArY3oL0EX04HBZ/p7eXsSsmJAXclwE1eNGLX2AhQCPI9JU0PPJpejbPNCbDw69a+ib9QDV4iKsI3yaBPLniksXVPHx5BmO2uOIEXRZm57InvYmcFFYFgVaHxIqm5IBBXwa9+vN61USprHKfT9IXOjHLlC02IHLpGw2g++RrIqRWT/suxt/ao6Kp7/XYIYXBKCtJ0PcJFoyrXzkNRW0EgrSAlCZyj+wdPFEQCBameUP48VV7uaCB1TryyJebDFFa+qDlIu2uOAV3COFk61odVr97lNypaycgWhR4e+2RWICRCbXL2IRbn1RDMM2G7rTQ7Vjy2UkNWXJnfzIvBul3FS9IWhgjHxpTxmFWclL069umr/4hSpiUBZbMOuBhsJmlnLILd7InQvnhmILCfdICimeWT/leu3rLy2HIyEuMrtyZDzwkfDHJWietr1jeas5ltAyRpoR66vRegEHOGt6Duj3VG27bj9ZiVX125w3BKzD/9koaq5cFzPgcubccE8LX/19en2WDOyhF9etYZSrZ+XflXU9jUVf6qQdppiOOr1NGkQcyupyyFTBqtAGMbOaOU/YlOMXoimeaCFObF6BrcV/6TzxC0XnSrSW48GozB604=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83436bd0-8ea6-4aff-4c08-08db6b62dd51
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:34:16.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVprlAcKfb/nrClBdrzeMGcNiFzPff0DuQoY9im3C3AWGuF2fZ33lw9JkKo64VAE0cG4A7MT0W7aJ53Y5fs1OzBIL26CukMElmWeeSwu3Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120143
X-Proofpoint-GUID: Djz-w_1XhaWGM3vWfVYRdtEdJ3O36qe0
X-Proofpoint-ORIG-GUID: Djz-w_1XhaWGM3vWfVYRdtEdJ3O36qe0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users can use the folio equivalent so this function can be safely
removed.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

rebased on 06/12/23 mm-unstable + Tarun's patch[1]
[1]: https://lore.kernel.org/linux-mm/20230612093514.689846-1-tsahu@linux.ibm.com/

 include/linux/mm.h | 10 ----------
 mm/huge_memory.c   |  2 +-
 mm/internal.h      |  2 +-
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4a1aec5e4b83c..485224cd62ffb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1223,16 +1223,6 @@ enum compound_dtor_id {
 };
 extern compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS];
 
-static inline void set_compound_page_dtor(struct page *page,
-		enum compound_dtor_id compound_dtor)
-{
-	struct folio *folio = (struct folio *)page;
-
-	VM_BUG_ON_PAGE(compound_dtor >= NR_COMPOUND_DTORS, page);
-	VM_BUG_ON_PAGE(!PageHead(page), page);
-	folio->_folio_dtor = compound_dtor;
-}
-
 static inline void folio_set_compound_dtor(struct folio *folio,
 		enum compound_dtor_id compound_dtor)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31bc8fa768e3d..76f970aa5b4da 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -583,7 +583,7 @@ void prep_transhuge_page(struct page *page)
 
 	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
 	INIT_LIST_HEAD(&folio->_deferred_list);
-	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
+	folio_set_compound_dtor(folio, TRANSHUGE_PAGE_DTOR);
 }
 
 static inline bool is_transparent_hugepage(struct page *page)
diff --git a/mm/internal.h b/mm/internal.h
index 61acceface45f..a64967bfcd2ab 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -406,7 +406,7 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 {
 	struct folio *folio = (struct folio *)page;
 
-	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
+	folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
 	folio_set_order(folio, order);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
-- 
2.40.1

