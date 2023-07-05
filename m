Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD61C748E29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjGETon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjGETol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:44:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0511725
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:44:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365IdPXf005170;
        Wed, 5 Jul 2023 19:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WQEnffaP+1i+leegzaQJ8pj5MOjXtFFS0B58kv4ef+I=;
 b=sJiU/kNohchCAn66vJ4oux139locQsDQPTmm+rJVX9Sb5vmQM9OMTljJL5AgrujSYFCz
 VnO1ecY5dsUCGZtFxPmZ6cwpGBYeny9aKpizUN1A8iROhlcyTdE3vw588BOUfdRAUNsg
 EIiCgFmgCHRHnmdf1NOZ3jmL8gEECYTspphDq25JJl/JG+wGUAyrOPWWUCiRgF1qtW8p
 90Wrb0fZ3RM3XQOfg4lFhoNMxgu6aYsjRMmHBOLjukxWlhTQtxAO9QNuZEYv8IkYolzb
 Bkjy6tN9gsNuSk2jDYWFdWLVWBl4tYaS+N2kKAHOncBHbk0341JMCOVswe6dFN1Vu1S6 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnd8q86ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:44:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365IlhY2025202;
        Wed, 5 Jul 2023 19:44:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6hbcj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHQIqLqBP/JHz++MKOWoOFVMrGrIYajmC+3MKh4+Wq4jTuOIF5Jw+TINY8PTNVFoiwTNBUeF9tWDIsD/O30NnZUY3mfjEQIXiLzKUksNTCx/xv3bSZqNDkD7fMWfrg0hVNmLuyoRurBJbLVGkhQtCUv1PoxV9No0AfXemOXHON40wPQDZy3z4HDlOO1QGvdjGV2QXqwwx1ibaV0CX08Zkh5yr7DYDwje+gLy/9m5/fJHPRnBWk3+I89qeISnEv0bG8FezYI1qHJeCB0v5qoXzeBxpO6N9kchur9XwYXvmUqjZPKNHP+simf7tQISJqTO1rxh1/JOyciw0aKOPnNHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQEnffaP+1i+leegzaQJ8pj5MOjXtFFS0B58kv4ef+I=;
 b=j5wbAFhKgX1/r/JAH2qGPgioZCtWgSFilCgzv2q678nghWHFuucnUYimNBFCmEEVpKjYFMcjsI1qsq/rTA7AzMjTrKgcCpMjFB68fnZFNaf0kAGegbvREU4DUksOmYRyLdSP1M/B8wTai79IfJ+VEojCmlU6UZIC77e9QrQ45CE/IENejl2bB0zJ6ERfj9SNBMJWfwJzmmddVeinyL3rP7IdzSrVrVQE8rmYKyQ+IacAqXWZRJiSEYNi/jLxdrb1pL+1Q9+v7EOnQqibJVKaWEGeu3L/ZsOHHqp+cpXY2+V85ocdANFS3iHXFOPN46zeOs4KTRLknD2PDBdgJb1S9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQEnffaP+1i+leegzaQJ8pj5MOjXtFFS0B58kv4ef+I=;
 b=MYp475Qv6q5DtvYxZ2CRFdax/1Tt1I5fJsFx+h/AJ6ZIOS2U/jnsKFlB2VeeEpkqW0FS9V81PKH/ByXE4hWh8BXiWQyD2F6W7voVNF+wMeiJq1cUSqh6Kll0YBeIY7RPXIo2wBE3Z2vNknrSqbif2ovh+BTPXcNPjP4SQweg0t0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:44:00 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:44:00 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 4/4] mm/memory: convert do_read_fault() to use folios
Date:   Wed,  5 Jul 2023 12:43:35 -0700
Message-ID: <20230705194335.273790-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::6) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a52448e-ee75-42c6-dbda-08db7d902df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEOD+dFO1BUxep43/2bfv+1XNuNQ0YZwk0oSLRgO2c4rzsxT5lwTOzvBU8O5ulZpNYpyfuj5m8oyTBx1MIoUoDNTzzfVJVV5EyaMd856iN2oUX29GM+sD+BGs+0y73uj7hS9nRmntRQCvg3AdC2cHvW8YYtgwTfOAuMD9sMkEu31qAOPLMqTRL0lyZ2zYIrojmd/2++PUUHboRimDdUMfMczesx5WTz51SqOlAPi6cqtIkByCsOA3xTW31+0cFeBkyWbmq/RXPGhU0bvDN4fa5iF6lkYUiHbIwDEwTOfoU7tQMQQVoxfvE7NKNb5zez5i8MKB8zN07N9sgo/JF6sgPy3Y26zUOCfbkcmLPI/A04nYRvJ3xvYFWEkvIGQjZmC3TST/TaH2Msj/iHlgbpXlLHtD4f7GHIla3U6GSbgoD0G/GnKqAmbrJCS1KnxAFe19jHU/RW/NvSeMcjUmiQcE7r5gC48t/rbZn2PWf89x7F46W1rjRsj6tZDgVamuIRQkGi7CoRq6NxT9I6RkWqSFyb5rYQIDdIuyDwuFGLdhNSeqyj1CO6f/FFLs3dNvdWz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(41300700001)(2906002)(5660300002)(44832011)(8676002)(8936002)(36756003)(86362001)(2616005)(6666004)(478600001)(107886003)(6506007)(1076003)(6512007)(186003)(6486002)(66476007)(4326008)(66946007)(66556008)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79kM962sxqC3+DhR2JXf6iWBttD0BMv2oop6jdT12a2tqZF/5hi0XT+Llr9q?=
 =?us-ascii?Q?Rw3mWgMfhcdqq9Zc8R/3bloIowXp0ltguQGPmS4UWSPPBHKjYH6iclsI4zXa?=
 =?us-ascii?Q?l8R6DRMGfP4vJplNewndQfvu1JPcyum4HBS9221s0DdEHCsS5p3X2Xu8rbNb?=
 =?us-ascii?Q?I8ytELISkHBv0LjcGhiRtiONJZJgNQju9fIVZptw2VpG3rglBugQzeHxCpP+?=
 =?us-ascii?Q?3kUJEWLWLd/vRyCK3nC7MraG2AqFTdDcmsoESxXXrKZs5Z9PZcNG9sl6dNWP?=
 =?us-ascii?Q?C/6RRHR11wV3+vm7V2aXh4PFok3qryrRTS86YwancuEGcQvFKQ1bGeCt1n5Y?=
 =?us-ascii?Q?nxv++p9r7SizdyJsMrb448ctGOUjH1KLoyYdoVZaWjnt/zTLSfNF5FXRe588?=
 =?us-ascii?Q?vSLZyEC1aON7WDbSZ6/SsNSdpy/HIzSSeSQQws27oZjzHL3oGu5Av7iJwW8B?=
 =?us-ascii?Q?c2lEo5BKIVM1GoeGdefGFtN/fQ3OdKxaTtRy0xlZ1L3LH6Ixk/wqgv1iq5eJ?=
 =?us-ascii?Q?KdOtjhccouvvcaA76YT0i6IiSGxrkM+1s2/uuL/9vKxJtPcCVmhQ7xlc63ei?=
 =?us-ascii?Q?BFRgAxm5k/iNkWmymAreZTgBkeXtGwy+fc9p2wVmT180js+G9VnHdMHIUt5C?=
 =?us-ascii?Q?mZyiPd+l187AYKMWvWAlRehQNLhG3EED62pO7jWR2Wera3sTflrNxh3IK4DA?=
 =?us-ascii?Q?wHsz8E+XxYzbdgNd1/pjiIAIjrEbXh/fpou7qKn9bBp0BeV+HknoEHJJGLgD?=
 =?us-ascii?Q?0Lp/tDhZ8QpmAobJsrP277hWyGQzIUaXGylbfcH1D/xwEdw3CTj0mEBlBxwm?=
 =?us-ascii?Q?rE4kXs46hmbV0MgmMDoXA3x/ZlJQNfJtUEi6oTSPY+i3nsyRJP22ZkYMILue?=
 =?us-ascii?Q?LdaF2PiiauMwCtFgkM0x1Eh1XlvN+cNWpiHjZiZhibXj+4UuC4PnT7jBZUV9?=
 =?us-ascii?Q?qknJoDtNiwQZwsfQ8cUbsTMZ6EhODHo0CA1qwKqHnF3HoMX7YRXiSE5tvx8I?=
 =?us-ascii?Q?x3DY0JtGFO/SIzHlZoMLvtFLSq36Pd7eyI8e5wZjSMpCrq4vnVSph8AT3jMF?=
 =?us-ascii?Q?2UEpzRq8m0tFS1j/BlwUW1W9Y2iTy5sPbqUBchz+8Pz7oBnMR58XhSVuLtL+?=
 =?us-ascii?Q?uCOAyZivpJ7vw0fy/yCED5qqpj5pQ6SPTWSLbIGp780h+0LHxn9iEPmoXit/?=
 =?us-ascii?Q?Y4mryXaeZ02siZmeiWALH9gjiy56Rsfu9vXEeUa/KCbZXFneCb3yjvcRa6D3?=
 =?us-ascii?Q?QvTMQMX0KVqbyz/AtBYAbeoLQFqKjvy1jd1DlVfhv7YqUr1XYq8LgxWFl8fG?=
 =?us-ascii?Q?106lhhE7D375lw4wf5Cn7PXWqAttFA61Wul2AHVNgz7iENZz8DqFoYMzofVT?=
 =?us-ascii?Q?vcHalZ6++BTHtB6VKU9T9EjPe2BUfdy3jgPCStgkYXJbvU9x8gjM2Ux+4VwC?=
 =?us-ascii?Q?DfRQsoomy0IYG8KPHvy6C9hAVL4wB6Ng9TRkIYJ02zfDThp4V+4sg45wtiEF?=
 =?us-ascii?Q?2ayw07hrc5bQ1EMbE0Sb+MPv0K03NcR2OE5fS4WEN1inyIzvpYhodP759XPp?=
 =?us-ascii?Q?w2EBprZed9maEcYXqvNKdocJIdotBhSUcPH8XDGuQ1fZbxjWTQUjLzhFo9gT?=
 =?us-ascii?Q?5otQ35jyfESni3LyeszWW+0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0z/Lvmo2hdl8Ixsfs6bLCWcoQk9vFkJC0EsQAp7a2XmyH9alwqSRZmYqUNGqOveATQyCQe1MQe8ramWHsztNsV7zeBcPWP2f9XI8GRG93fJBo7v7DZcN37cuatnjlMV9Lt16F0tyKM4Ipgvw9S/rhqOszg80Yg3CZyNt2sF9s8zRoZefs6LIwbhqKFM4Y9KNT1GUGhjgCnFz+/yO2610H/YG9R9+FXPVn3hIR6Bxl8JkyF0COk6cNHwJ7nXiC/YGMYONk8rMfzRbB8cZQYx0MtP+F8ERGlDO8wBTWJHYL8g7oXlLGLk2sQXkjWGLp6eHElVm7piGo1iEJjyWpSzDRKqROaDsz6ISdb+R6Rulj6LIujZiidYurz8dbKbNRlaWSr16C/+r2XdOqIESKKjYA5BOZLUVq6foO6lrloRuPfiueh5a46sL5kctLhcZmDYZMlUpTaWsLM8Ac2AHXL/oryf5U+SgV4vgapQI6n+Yebg4uI1ngMwdDiYmgDDMIJ3+xzq0q21KTTomvTu8rQH/dByOe3yhqBt2Jr/1mq+flTN4pDEJvjMGyKiEupgEuS20gCUma3XbtJ6xlwAdrJYe8+J+036Rjlf444Wd7KvQRu7U5ne9g6QITU8/Tk6rmDoQKqBjMRBB+uMTbi0yOhwedu4qOKgUuv47/7GtLxmhkWyA0G34cQJ6mgu6zvQruMRYoVNnig6XdohEazSJ/sm8LCDF4Sz4tVBmycDA0yzRJLVsBor3KnmyANa8GsSThdfhaSJeXaGSOJuAjGtq5ibt1PtTDuN+jRjApBccvxFna051pO737b81o3l+B3l0VT4hAdM24ikTv+BHHKVyrX6iGISdukAbIx9wXy2sTcROY7glQ1skJJGEtbTiUgUaR9GT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a52448e-ee75-42c6-dbda-08db7d902df6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:44:00.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JU0PtL9WgMh1oRGPn4dGDPKFseA+nSRdp8jX4M1WLywGHjehbqr71/+PLiKn3NElXmyo0VJRYdW793LhRMuh6L3I7QZY7Ddt3HAOTzgQaNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050180
X-Proofpoint-ORIG-GUID: zACk8YPwMVg6eNxpn9tX93_ogJ2CbmAt
X-Proofpoint-GUID: zACk8YPwMVg6eNxpn9tX93_ogJ2CbmAt
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
---
v2
	 - move folio initialization after __do_fault()

 mm/memory.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ce7826d3f6200..e40a03e488ca2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4527,6 +4527,7 @@ static inline bool should_fault_around(struct vm_fault *vmf)
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
 	vm_fault_t ret = 0;
+	struct folio *folio;
 
 	/*
 	 * Let's call ->map_pages() first and use ->fault() as fallback
@@ -4543,10 +4544,12 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
 
+	folio = page_folio(vmf->page);
+
 	ret |= finish_fault(vmf);
-	unlock_page(vmf->page);
+	folio_unlock(folio);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
-		put_page(vmf->page);
+		folio_put(folio);
 	return ret;
 }
 
-- 
2.41.0

