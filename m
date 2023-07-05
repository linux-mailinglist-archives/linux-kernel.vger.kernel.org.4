Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B900748E26
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjGEToO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:44:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC48171E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:44:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365JU9NC014840;
        Wed, 5 Jul 2023 19:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=kw6BRq5S7nlCZ1N4MuCx5rTYDaTeRJQjFn2jRhBUINE=;
 b=FnAs+C/daCUDtRIOzSaz+1aF1aXr+T06lqo+4q1AmhOzQbQa1VmloZWNZ17sFqS1961h
 I4ZgJg0F1IWXHBPJAkOQmlwvTS5SkgBEOTvF8ISwUrJ8BIBlNIZyQGxGn9cAPrK7yZYC
 NjGb+zUnrDeoOVlpe3uiobZVEPiqSUDw54+l8wCF3EdBTcCkw7yt29+Sn06YPL6+Y432
 3IY60fbqWQ+i2Lut6iEVFhRbLcRG+YYfkWQS69oZuYz4OSjugK8GKtvBbK+UYD6hQpNP
 tORrVvKxJ3dxkln3QewxEmzQjuPsxidkPdmFttN+P8+kkCBQ7Aqw/0p+JU7TKIwRfM+i lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rneqqr11u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:43:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365Imt0k033353;
        Wed, 5 Jul 2023 19:43:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak69932-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 19:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCGVbWULdmiGagyAK5LS5SZ8yjnw5R0xjHQ6EFF1LFNC5arH0in90I5tA3fQK9oEZt+n/4jXsPtnaKfr/SmlP5RP+QIRNWA4M/Ots+Qb9OMph49zGBrJKKBlwDh4nFoI3FhdVzMNSLgXz1MtkV/bwVt8UJCB1ImwLtQFa/fBCrkw6WcKPHFISnNN0RVQXsMD6AhgdGwqn/fgGAEosAbayGcG3PGpMMjKBsqm4pGq0QBvd2/aH9pgH0aUH5A1SQiRZJv4ABFFoHupc1NnkCY92J0ska4RLWqBXLpw3o1uRaWe7xucOydr5+t/ucEW1N0ciojtd076rbakH2Nb+1yloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw6BRq5S7nlCZ1N4MuCx5rTYDaTeRJQjFn2jRhBUINE=;
 b=Ia/sF2Wr9mY/vNz5ES26ce7rKe4XGUSFdaq9n1QMjFTzFp+/Vd7I5SlkC7FY/cg8vNjfpv0y6mCpd4fRF6KRTBja/zkOE/7m41VCRtiS3t+mZZ6CUEuPzhymg4vxOF6Ja8oqphktQ04OimqUA9wz1j+krMwszTy4ADXsysch3Hjyxa72Oh2iGv3iu7xrZHIzCAXsJobB07PRAG389xiNdprI53ZUIqsu23eZuQ+dC9+36i6vNYn2l5J2e+VZQHJnAZOXUnwESrdDpZkB+r5quHKYrhCAOjtMda+zVbU2LMXkmeaNaK4+VxXr/YFPvMWbBoGhWkuYJu1lk4m0Kzjkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw6BRq5S7nlCZ1N4MuCx5rTYDaTeRJQjFn2jRhBUINE=;
 b=cS7Vf+G9bPQogDNT4BhkuqojsnaNZZKQh2O53Bb0JagXHkrMb/5BLrjJyFehxqmVQtLmU0jqdjsOnhsK4WGsCqCb/q3/sRluX5p0AIR2yz5BxZq3+KWiWGfCEc+WSYiuiPjucGPWy7BTyNAQ/WHNCwNspuUa9k7G9fA3SyUZYA0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:43:48 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:43:48 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/4] mm/memory: convert do_page_mkwrite() to use folios
Date:   Wed,  5 Jul 2023 12:43:32 -0700
Message-ID: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY5PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dceceec-79a3-4004-4ca7-08db7d9026d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T+ofY85lq4nzn9CRxUa95RcSdNLzSXAS6tPJCUFuL4kLd/zdKd2TODtovL/Fnb94oS/qw0V4C4GX2W6hisPQ/sx2nLLjfJ6KyoytlnMuT2rAZGU7FPSLwqsfIjXGqa5uz/pfe8hYEKBChC4Iva0A9D+xU+GYPLj8VDP97l+DQ3EYucpUKu86oL6/+vZ80ZU5BitlY94lrjSU8a3NuWwOgL9DndkSrrXKAjqWUEw/8DtfLBEsi+aCLpfyaeC+LxIfwISygkidtWpfWmfpX7WUVPBLuHGq3PUwBj9WNm+qydRPH+w/1Osdw3k/IY3B+sH9BcA+rrZO8QtCropTrLIKJlCmHrQ93SDd21Kb6TEQ5RfMfGVwC8Svl9TaSQ643sDyNNW/riU1pWa0yWdqUYUJxQHvU5y9sOB/ICpjV0DZALzuUcCFyfnVp5hlac3Jrkko0aCr7502vrJSa3pIqjzfViz4Qctq7Umkk+/T7YVErUvA/1WVYOaVQx3gjCNPH+MKQHpk9dSH/j5LFreH7yWd3Grg0YYVKIy4affAWGVImNgzPSlYVVLWDpVpCMKpyNL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(2616005)(2906002)(83380400001)(38100700002)(36756003)(86362001)(6666004)(107886003)(5660300002)(316002)(1076003)(6506007)(41300700001)(6486002)(4326008)(8936002)(8676002)(66556008)(66946007)(66476007)(6512007)(44832011)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ogDP0AlzEJVYBwBftW5EEh0X+wlWZk3XqopYQSTSm2+2tCP0lCLguRMdNUqK?=
 =?us-ascii?Q?TYLw8iADmBpBmOguNiTTIviORaBupbrVme98mLjh/T4F+UOqc2URQ/DEDtxV?=
 =?us-ascii?Q?kvUCw4Sl2OKIHVT1Z70Z73Mluh4n8mGxIf00In+FsyGfZwvj9ebeMct5DoTh?=
 =?us-ascii?Q?Q13un1WV4RYmRU2zq5MRp1ouro6pSmLk86zawVNF4daLDDHiBMWDRwNs3gRN?=
 =?us-ascii?Q?6I2A6VclfouZum/lxUMVDPnLUpkK0vwF1OBvaMOsI+orCiUfqIzfpXLea3Gu?=
 =?us-ascii?Q?WpxxqLrRhxGRd4+BzBKsQluvnbNm+bXLcOIT395l2+HcRrPrdSKTauQ3d1BJ?=
 =?us-ascii?Q?APMBkTwjfNcsa8Un+p8x3gZDGbBGWj3qyHWVyJYayGHFduTEae6uBn2NEZCG?=
 =?us-ascii?Q?LjRUHzoVrJYwfTZd+4xYVCNIkzFRpbMYAQU6i6p5lL/z4hOCCyC7U0lCJdYg?=
 =?us-ascii?Q?SM+JFJB7RUuTzbNWQcjtJY5Rg866Lxa3nD4rpn54sajWTmQu/oHid6YISXLT?=
 =?us-ascii?Q?tgULA04LuLXHjyRujW46Y3exqTrTGODAsq4B7snGZtuDY1rOAP0kz7vs0QQ7?=
 =?us-ascii?Q?GWV4i0ut7Eys0URTWUsgtFEdzziqGAJQwfoLqSDnKSEzTwdrAtUZ6QSMA1EE?=
 =?us-ascii?Q?yTyq75t8gFcgVAtXSGtn+akGAO1/JbhOKAQc7bH+rjs16PJ5nJ5R8rvrNTWj?=
 =?us-ascii?Q?bkzETBMFARrl3INctFHSJI35QH3IKGXHLEwCU+ld/9Lc8NuSqHkYi43y1B9e?=
 =?us-ascii?Q?Wd9BwRgabApKFVcdXudCPqBMSfa47AU+j0IuZmSrzRi+PGJFTCCTFOV+mum9?=
 =?us-ascii?Q?aZaVyjy+OVh3IMZaACKqcvangTB64uXY4tH0N+bv+9W3pvglIIrS45nVMZ12?=
 =?us-ascii?Q?vYL1bR5Y3aU9f1G5OZZSRJu28v75AWhlcbl4/7Mx6c2MRMsJlxU+3+b91Cnz?=
 =?us-ascii?Q?9UwWKmKCXzXzJFdWi3kISpREnFH1uFoYfP9E3l/rP8NOJXmqg9Lq+ecvfJ0g?=
 =?us-ascii?Q?rqG2gOUUikhHj5fbI85pN8EOVaODorIbu/vmh+QZqxt5xm8GJJFoXs7Cfab/?=
 =?us-ascii?Q?lfi4EaP+RLXhuz4mqRqmcGiws7yuTjyrh9hP/X5/TV2SH4pQZRT+a4GabPkZ?=
 =?us-ascii?Q?ubGMIhn4sQttylxgeJ764YHkgoibIzdFDdqSYVRuzbRdzzonZq3TMjJp83ux?=
 =?us-ascii?Q?Nz3LwDblgPLvpLYfwTd8Uf83mjcintedXc7DTrLVtUfoUNCmE83Vo0cvls7O?=
 =?us-ascii?Q?t0yu4RAYAJE+D8UCil59qV9QE0E60DvhBXtuD7ZKzmK7njC7gGATunJfBqXD?=
 =?us-ascii?Q?NicL6JqnIB5oLPNiSE4l6cWz1lJxktQmrknrk9/r0dAG8Js4PlaHROHzj76d?=
 =?us-ascii?Q?rDRGN8S/ksAdrB+rzfMZqRzwpMSOrH9YjRCiWojuS/CHMT+Ovd4cOBMdFDPQ?=
 =?us-ascii?Q?DpXTFpe7xFXXX+IhLFOxYTVbQ1Y9GKQJGUehwP8l0tHpuNgSv5aIEvb+9wMl?=
 =?us-ascii?Q?cN/5ynFYK2HsCQeZ3jC0Az8jF3vS32oQu3BmQ7tESFoqMdmI23/3hRwJKOVS?=
 =?us-ascii?Q?QyVc0N+uNeKazJa3eZN+RI0nqxndRDuoxWCFH6fmwvYTLWgu3FHhLL6en1JX?=
 =?us-ascii?Q?5NfH5o/HCGhjjxddulsJ9aM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EFSqoR/5kDPXBII9EgsJ5AI/hD9w7PAIP8R2PN30d4BXgaap65bGYiJAVWvnI6BJuyV5adyDj5YEbXSEbnAmpmvTj0Nho/89iSoeuBgSFl4BKO6Cx2ctH6VtVK47ojqqLeUW8jSXVWCsAvRMc76M9IeRCtz9c3pd+7vodVNEY1zEvK1BAfpHS1tYDsSdHRM1RGqbst6dMC2LwCn0ZeX9K5jkhI5YxBchOkMitUKV/HKkEaI+qEuIKRCJSaotOnEyj+GZlwujL4qA0es0U6pymMtAfa/UsUaN/tCNhz690rs6xLh2kIMI1R9Bs5mN/cBD5b9taIi31iL+yRyhrlMHXG5FEUtIUu5BBaB93P13IG3CrHyj1NFQRAvVl3zxq5NlMkEXsfzYJtskUbk5Tx4F5CUao8atYOVdcNKUSonmSGaXEBTkWVSoSKL3XeyI4ych3kDKqlrrDFVX6bWFa9ybtdno7eyNwmCT3n9wtlqrD8LfSwqMNC2aP6hmOfO+bJ2SV1vTd6Kj6ThanODyTuQy2KEKFM4YkI7uLTFEjv5nJuHxBsmVDwQeu+15gtBhOcNGSClgOlcx/148XvqH9JcCkp7Hqy+tRVuNRNnY626oykjJuyoqPj2TPtnHjuWFBckR2VAGo7xHNETfAgx28WHQmI9oUiVxO2KQq2uC+2BoIqBkmozTyH04S0WJ08E4wgHFg9jnazMOwaPAur5GcmY8RGlWN8/9LrsmAXW6WqGotrvmR1FIBpR/3XHgx5ZvKol64xEszchrD1d02DhNeDAarj4nzT9DEJk0Slf/nq7ykxMZ6NTLfCtVq0cubGiphE7cF+1u/A9VLcULU5dn8PujdTjwib3wIVUCMGwIeNGBy54Q5rGahy2Y2CxWEE3RxvBK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dceceec-79a3-4004-4ca7-08db7d9026d7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:43:48.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jb4KVrnhj49G36XmMfWGBsL+bxqwWvuU2SbCXKgDInj5gafsfJAD6YYBeFCKmy0SkwtrKKEEXaxobwAGyXOtPAF1JBsQ3ukIwTW74agRHZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_10,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050179
X-Proofpoint-GUID: mG3kDwMm1HkKk6TsnT2Lt3wO_x3aiWc0
X-Proofpoint-ORIG-GUID: mG3kDwMm1HkKk6TsnT2Lt3wO_x3aiWc0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves one implicit call to compound_head();

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

v2:
	change folio_mapping() to folio->mapping
	
 mm/memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 21fab27272092..e73245b791a7a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2932,7 +2932,7 @@ static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
 static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 {
 	vm_fault_t ret;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	unsigned int old_flags = vmf->flags;
 
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
@@ -2947,14 +2947,14 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
 		return ret;
 	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
-		lock_page(page);
-		if (!page->mapping) {
-			unlock_page(page);
+		folio_lock(folio);
+		if (!folio->mapping) {
+			folio_unlock(folio);
 			return 0; /* retry */
 		}
 		ret |= VM_FAULT_LOCKED;
 	} else
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	return ret;
 }
 
-- 
2.41.0

