Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3386E17F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDMXPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDMXP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:15:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4848BE9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:15:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DKx5RC012833;
        Thu, 13 Apr 2023 23:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Pn/uyozvyYbUQ9JbCnKLeYMPmrjAiQHRp1hAqucWDsI=;
 b=0dvFtMF/fpryAsXldSwLoCOp18Z1Lyq4GG7YFBi5OOD9GFD9dmPWoZhZ8xM1JSx7L1SK
 eucmDj0bz0j/GwgndlPjy9NLDhn1dCueDVSgM2qaRibZ2dgUtevoHAb9kpj8LvOjETh3
 uT4Gf6UsdwQ6pGfkIuU8A9dWGtsJpnjNVGwNzRFHwe2n9aZWR4rsUxB0I4OaicBpnb9g
 dvjTSqypsIrSl9FhUcQ61DWxqzSFFCl1+sHPf8KsR1LbK3s6zIkTZuJQ9ybb0dgnJtdC
 tknwBgnLaONdblIjyx0QxZNfzzUXL4AaVWl4ZhhImiF5D/psRNLeTPeHkDrslSqi08TQ 5A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bwn0pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:15:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DM6C1k012738;
        Thu, 13 Apr 2023 23:15:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgrs6sx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpC8EINTOSjvKdPEXqqJ4dCdQTOGU+rpHjgjIjgZ+f7pL7QuaGEj7QvijeOspuic+yijS/Hum2LHfYNpR7KgRZa41gqmCddXKjF/+ZC9HJyQ+PVFQG4fpxy5g4wNsnf1vnIj+1+A+V7vQTE5Lu3gtQTZX5pNl8GTtmGT/AWu517Iwn5Q7oMcRgorDO7fX8uqZSsGXP5izzuuwFFMZWROXFcAD5znvfRSSkPViLA45f5hnTwTphjQaSaaQJW0kD34UzGijSltcHz9VeZCC2ufDcuZjurGQnskZaIPn0sRR2nnEVevZPOjyKKrzze7C4QZNhK3bTxlKmF+pn552+ml/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn/uyozvyYbUQ9JbCnKLeYMPmrjAiQHRp1hAqucWDsI=;
 b=odF2m/tGzJ7Xj6pDKN3HPt+ZBMO8zpVQO2rgcG8qi5rkU+UPgpi/mFuBDZZq9YHhxefhsnl4wK7aNys8akWaQs33FfsYzxAA0uExkqgmACQF1/+3piE84LkEnOwF1HtB3+Up9Jq+JmaC93Qo4DEOHM2eN26DM8rCfLQcqnCbQOfZi4DtzvTpUXFSAtKaw2G5wZFg50UTUYg96FNYaqFHbV5gFnGQDEKBm3Obn920PnRpWMWvQfaF2VKbwEm5vksD41YapALrFIF24H4xGQBQ1ePTkvZ9RGANfywz73WPl4J6GUpRbR9Ruf3CptbJ7rgLX1YZ2AFtKdbqQWacsEpHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn/uyozvyYbUQ9JbCnKLeYMPmrjAiQHRp1hAqucWDsI=;
 b=rFxE/ssf9PHxMr7IiXgHAnbcdxEubXqJat1r2Gs19VXWzr6/aoAw06BXj+60sss296D2E0clgrFduh1S9IRKvyd8WEcKDL+sHSawlOWnr4WO8TqnFuT4SYRnHY20yYRsR/ojOiK1MPnd24lP9YBGaUIDSfO87+aSPOHyP4gy0fQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ2PR10MB7058.namprd10.prod.outlook.com (2603:10b6:a03:4c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Thu, 13 Apr
 2023 23:15:06 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 23:15:06 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC PATCH 4/4] mm/hugetlb: add hpage_shift to alloc_hugetlb_folio
Date:   Thu, 13 Apr 2023 16:14:52 -0700
Message-Id: <20230413231452.84529-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
References: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:40::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ2PR10MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce97d5c-a0b2-46fd-2b85-08db3c74ea9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4/AiuRqqnVrhVz90TnGnmq8iYraqYbHQFN0ywLo01p+6Nkyxy+8APIkKnCCFF6NmncmBEr/T8MVygvqUz4VFRKo8inelt/eYNaTZwm/aGyZGjdxb3gyfuGDIRWUHZ7tLmKlJ1C1m/97jqgv9dSdY67VKWTyLurZAJl8uIXn6aJw/Vmw61BmlUkH9LgRu/axYCvwHLMONDALjQxAhH+13mMxYJc7GnzUTHeoq3tjnqzToPPOy49BNPPi640SCEBUB/tOA3ZJroQBgLhATkNKoeWahilbvv8xoYEFBi4NS5qdo/cyGy2DDYgZe4v+mn8Dro3Hd2ioa/GPiPupjaIGlfvWLMXki9KQ/e/9k1N9g3I5ptdlJKzb6t8l+Myay6rrNj92lgiQK0MPgd7NNQfi3muieRcVOiGkph4qo4p/6cQo7gLf3S/nW9qh+0JKAFMErcwax3CAf1cP3q9lF8/zDbCM935zGcslQ+yrx9vBrVbHqv4GDEB5Ps0eWOEDAVteTz0zb9RebLIck7H88GzvQpiwVn1xBDADCNxf+c5/v/9lb6w7eCt3SKr/wAGbbRGC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(83380400001)(2616005)(6512007)(6666004)(1076003)(478600001)(6506007)(107886003)(6486002)(186003)(44832011)(36756003)(38100700002)(5660300002)(4326008)(66556008)(66946007)(66476007)(8676002)(316002)(86362001)(41300700001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQ0cQwAyeZuO9ZaIsSmTn6mpukd5n+njao2oscvJ/uV23+2c8nrxDJfLn3w9?=
 =?us-ascii?Q?Yc3nNSKGUKaq4iWnx7lqn0/zFauUmyYY853tHFMIgU1XrLA+4n0+6sD0lXtu?=
 =?us-ascii?Q?L+K3M9kQeXryXZK74byFdA67ZAndzmNQRzXgQpG1YUuXdVmAZjVy4ZtCooAY?=
 =?us-ascii?Q?nxPR79582jHO4xg/tHoYEjfPUxQTKw3ayOjfyizUidat2Gg47EyURZOUvczd?=
 =?us-ascii?Q?xqd4CXqEq0Wc/rmYmxyLYvhWjGC7ouMcQ6Ck9LJH0EjxzvLZA8WpQn/kX679?=
 =?us-ascii?Q?x1WGtXn59lglJCUoVcQmCvl4S4SJxsXSYGmeZC6KfFRWxjZwJqzQW8zobBJg?=
 =?us-ascii?Q?r/xVyp/ALQZiP4/4DHHrEkJog1Y5Fqe2TN7bOTjEZM1NHHlGJNCazNb6h+Qd?=
 =?us-ascii?Q?h3Eoh0CyAu44WJw+lhLS+grmnji6igSOC0VNZusZKDGpbbElOk56e4l/yDrn?=
 =?us-ascii?Q?ULTDhpjPtpKiH96iJwjl/kd9o2ajCWnIUl+CIocHQM0KkgwAY1aJqQUI6cQu?=
 =?us-ascii?Q?/XP70mGpEYmrYYN3jJltg7daxiK+1sBh4oS0Ot+F3ZvPVTQUvh/pofvLuUTZ?=
 =?us-ascii?Q?buifO8JdOwhmVh9vDUo97Asp2E7sSaA9xy43+Ezym3SYGzKFeWs/FFoy2Uap?=
 =?us-ascii?Q?sFkWRszHIOJ+beJhCneStRCz+xxsgxSBPfueZQy8Hj6ME8VkhMGILyCYR7+x?=
 =?us-ascii?Q?JEM2dsYwBwP/m9iDebXxzPY1/5DW3z7w1W2X7/Ynpd9Y3gav6nE7iVdww006?=
 =?us-ascii?Q?0oAOsmTuqoCZIw7YYP7FzSxS2ge6claEqcXXGyqKlOHuDZTBO18xEN9zmJI9?=
 =?us-ascii?Q?W+OwCYkb2HCppmwMPnw1TragwQfnOBo4GYQHt1SVnhN89/C8eOh72KTDO57c?=
 =?us-ascii?Q?NMjDNvhGaCHDN6XwXD2quKk4Q85d1Mr3Rz/5q+R86JYwHQTJoL/nWpW2Z/6r?=
 =?us-ascii?Q?orszgMrSvH6+p9plDu2u8mvw+0RHpXa3/W689KxE5nsJKgal3IajYkd2KlQM?=
 =?us-ascii?Q?ER63Jg71m5K4C6ewvW8lEpqS10zdD7kaZnf6A9Oy3NfXk1Teuc5eJqkyLZDn?=
 =?us-ascii?Q?pA0/+k5U9CtbmXEE0wHUuU5QTlGftOAM5dJ7CXwH01/lZT7CEiv6c8vy3GUA?=
 =?us-ascii?Q?zcsfnJc42N2926HL5QInOTwfIC0GkTbysXswaeGcY0zcqFiAuQVpr0pQulwu?=
 =?us-ascii?Q?oNZgddu5seffF8ZjKGZZbAH3YCPbdL/zaDHmnVAbTiEvTSIK2MtMeZA7s218?=
 =?us-ascii?Q?GnAKMdik6lV7KCh4+6s2vSGUJ6hvvpu34i7Y4Mr3X4wK/bICh+/ItkGhK7cF?=
 =?us-ascii?Q?mw/r968lYYTKS4eOFF6kk4+mmoE1mErZI2Av0h3u7V3bkk9abCKK+cOM+UK6?=
 =?us-ascii?Q?Q3QeYfX6OOxRGXLWu6IOBIFEJ0UqdZD24hQS5qrjAvsfaIZXCtc4mOUcJk5i?=
 =?us-ascii?Q?SOnVVnh5kXYm1dqnln7HdWE5Ztwyb+MuUldTB87bdWi4xbkuD/Jg2GWAWWWJ?=
 =?us-ascii?Q?gs90b9NgQxiT/8eMeXvRAQPMthYQ9rK8G6po4gXYYvPdWyNQHaJ9/PM83V5r?=
 =?us-ascii?Q?UlvR9bjAW29vh/ix1KbGhvcN3I6C8qHLTBDVA1zg/s5l4I6fp1RBzuXKYOvj?=
 =?us-ascii?Q?jy/s7/WAbCC3O8r2BH7b2eg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3zEwby3LZ8OvMnyC1lSDD+KKAq0vX4CgJuPqEnd3R6fb0gfP9cUhSaRJhvTaNbtBiyXLAuPVFWKSuA9bg207qngbveIZKxPxzPDF0SHfxGpOl1JVlcOr+ct7gM5W6D+NS4UbK7hLcb3KdYdy3ZAKq/bQBavdiT5vKYtR8EVvmzkMXIj0vLx9gZZVYckwTUXrcfy/gdtb4CDd0n91EhO1WOuInxTq9IuTwasEEnS2fK4fGMHQngMgkq0ZhVumfeP6mHBty4nesu2IQEXEdzln3ioj84jrQePLrcLVD8nxAdsr/MxVisQ1wXODpImYR2gN1h+GBh8GcDeLZ3+gD3EKWIkdJLA2R/HKQ1Ovi0sGMJrv/ZiQJWrZNLyuYoFCe3zEHrwbPoSfB1deXXsnxuhfUR90wR3rJbOo0HvfDswXIQJ4QHVKeBs33qGP9wY6oX4xF4WqaJkKafb3EYs1rLRUPZj1b6vs22DoA6+C3gYKcc/lS0W/b6/2obMY579tzhiQ+LvjgjKfN88FEWCyWxNd86IRcFJHCrqiTaeGCF+BesjDkBEtdk3Mo9vlTW2aazFSicTYK/kaoHeg+43BYx0MzKu7pMB/fx7E3zqdfuq9A71OQldhQ9VWmIpxBUq2BS9f9lv781lyJVKVk0MBYMRghDBz1ER1cES7lz7uLw2FgWkIZDJu14ebbTWDYSje031r9nYPTOvBGjmZgEu9nu2N76UCS9sCCQrht37wRhwqoPPS6Q2Ru3z23j3vx0h68I+vQ+HYYnFfuHgIufHGbkbG5/h9F371LKl7JZtly0rNJ3Rgwne3OICbQKtG4mIeUmJFswpHmNyVPEGBJKx7kLtGxQpvSaWPJj3JEjYQSEzb+NLRmRYEv8AdNchM3w1J4narrZ0Atr+4wDgyqA7fpPHNzgLnhh8mT9qRnoC1Req7p0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce97d5c-a0b2-46fd-2b85-08db3c74ea9c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 23:15:05.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdEePQS+mOhZL7UIm+AP8kCmw+1+c6r9OJN8KAStDXoxMRRahulsj2xVVIi7v9fjKJmICLHNoIVmihkdzXKacavravfa3hWw2g9RzaLH0/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130207
X-Proofpoint-ORIG-GUID: n6gWasBagPD6C4GIBWJiFpEWZl7Uo6re
X-Proofpoint-GUID: n6gWasBagPD6C4GIBWJiFpEWZl7Uo6re
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adjust the return value of hugepage_subpool_{put,get}_pages() by
hpage_shift to be consistent with previous values.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a28fbdff886ff..258c211020c3a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2992,6 +2992,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
+	unsigned long hpage_shift = huge_page_shift(h);
 	struct folio *folio;
 	long map_chg, map_commit;
 	long gbl_chg;
@@ -3017,7 +3018,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * checked against any subpool limit.
 	 */
 	if (map_chg || avoid_reserve) {
-		gbl_chg = hugepage_subpool_get_pages(spool, 1);
+		gbl_chg = hugepage_subpool_get_pages(spool, 1) >> hpage_shift;
 		if (gbl_chg < 0) {
 			vma_end_reservation(h, vma, addr);
 			return ERR_PTR(-ENOSPC);
@@ -4778,6 +4779,7 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 {
 	struct hstate *h = hstate_vma(vma);
 	unsigned int order = huge_page_order(h);
+	unsigned long hpage_shift = huge_page_shift(h);
 	struct resv_map *resv;
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	unsigned long reserve, start, end;
@@ -4799,7 +4801,7 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		 * Decrement reserve counts.  The global reserve count may be
 		 * adjusted if the subpool has a minimum size.
 		 */
-		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
+		gbl_reserve = hugepage_subpool_put_pages(spool, reserve) >> hpage_shift;
 		hugetlb_acct_memory(h, -gbl_reserve);
 	}
 
@@ -6871,7 +6873,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 				(chg - add) * pages_per_huge_page(h), h_cg);
 
 			rsv_adjust = hugepage_subpool_put_pages(spool,
-								chg - add);
+								chg - add) >> hpage_shift;
 			hugetlb_acct_memory(h, -rsv_adjust);
 		} else if (h_cg) {
 			/*
@@ -6908,6 +6910,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 								long freed)
 {
 	struct hstate *h = hstate_inode(inode);
+	unsigned long hpage_shift = huge_page_shift(h);
 	struct resv_map *resv_map = inode_resv_map(inode);
 	long chg = 0;
 	struct hugepage_subpool *spool = subpool_inode(inode);
@@ -6939,7 +6942,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	 * Note that !resv_map implies freed == 0. So (chg - freed)
 	 * won't go negative.
 	 */
-	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
+	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed)) >> hpage_shift;
 	hugetlb_acct_memory(h, -gbl_reserve);
 
 	return 0;
-- 
2.39.2

