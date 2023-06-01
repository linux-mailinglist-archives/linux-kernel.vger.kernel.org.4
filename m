Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631BF719073
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjFACRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFACRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:17:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F218185
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKIEjf032508;
        Thu, 1 Jun 2023 02:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4TFsZxvWPLZuKl+HYTGeXJqxloynMHdkzDhHBBsiyww=;
 b=pM1A5ZxuvU7AaIqbTAMcAI0YUFgGI1A72gx/be9cuAQIui/y++G/OlvlqaClovGws4lu
 kaLtHrbMLpis1VUPukSVNYdwRzDI/DQPD5HYvvs2gR7AEXtHZfWXSDk1ZKMeByEP2JtL
 GhiAIZBhu23d9Ry3kuayfT1n60FpI9mnb0pjQAmdF17KShN0Cja4rOgk1r9829Jqq1DB
 bEBMYV0ItoteQX8s3VaSJtjOnouMYBX0IDo1IuI0fHFYkDf+WiI+2kHO1ZKo+2vu7I07
 WnNLH5LLml0J3AHsLN+R8sJ/d8vWj5trglutzmu/dVykhmzoIMLMyUZhUGxRIU+vOsqw zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb97hvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3510GXSa000395;
        Thu, 1 Jun 2023 02:16:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qb17gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3nAspeCc6KlGSdq1OS4jWcA/uRLUcE7Cj+fvGd7LAUGFlL65XQ03HKoEnzI6ua7JCUnVKKnf8zXKIixkZANeELszSYFg3Cc/j8c3JMYeFXcpF0xu7CaLbxKqIDenu39c52SGe+aem04yHlOUGXjxlPCbnECMdD/8xuVEru/sEnP2ht1MF7dKwEMOGRDqHqBvYKzBFx36DT69BP8AZY1XD9S0a3SwRxOChr4B2A3MqCqEyJ78qDDVkpaVbefTFQlze5w868WLshiqBExOf7UMb47X9ASKOfyLR2n3nKsexX4+MEePo/3XBUooBvZOawmVoSFS67pOJxYhWkW5wo12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TFsZxvWPLZuKl+HYTGeXJqxloynMHdkzDhHBBsiyww=;
 b=W196DDG5GaQBirKQRwbjYgxGB4vWc73Shv03BloxujnKAU/6rXnIP2x5a3Stsy8c5gOPxLCPIESWRbcPNHiyOEo1Hvm2GsH6gcrBnpduiY0MmYXrJ01zXcbfekbJWXu5IPbEqmqHRWv/giKIgXqjiRvtEn9RWqSH6wBVPqeHVCotdaK/7fqOcHdufTZQ4M7LyogV3iS7g2x2J3AKR1Uh70kLIHe1rRO8bXnjBhDKOFYKCsz8d29Nic8I7Ss7lbP+4iUuy95pQJn/krPv/Mx95ih4u+cYleoewXL4XsgT64D3ex9oWr0i5T8r5tMhuoIylcj61ku7WAIATUjx513+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TFsZxvWPLZuKl+HYTGeXJqxloynMHdkzDhHBBsiyww=;
 b=ATTp6VlmuB8ZHPalWJ6wdlV5Bt5OkBmRAXs7USAMyL6PC9/olD8dd94i77o1AytEJAQs9bmO52S/zhugdmHwyMcdHhAlx4FoYij/Rx+mpRngJ3F1aR17suZnNPk0IaKgXJre7X6H6anM+JWl7KRPRrWUgFGrCD7Sf7gcroMUU04=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:44 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 11/14] maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
Date:   Wed, 31 May 2023 22:16:02 -0400
Message-Id: <20230601021605.2823123-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 0823f243-7bec-4265-3f17-08db62463ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wElmbrN/2vBN3FK8K0/CaezvffvIb9tQ9InzW2OZhlwjm3ip3GW3v9Lsk/pypEnjRxvrLyD9yvwN+5JI6rnq1We7lQtjpxc+T6vmUxZhgkYImv0MABS30dWIPgNz6Uxze69qDhIvLxKErSRF454CB4fh37LnQW1Kck/ezn51SziJf/kphoeVdcTB9RXWaOr4y3UCkAoQXoe5/gvIa1lotuALgRdmB7UnK6quDhdqfaNDRwYpPjEJ/tqeMPOgnRQ/ThRVZwEbOR3alr3MAstiWHxZxoWfegcrBYk9sjWx1fWd4Lq2QAYcsNsYXyaqq3kEc65cR1pciOIeOjHlyC1pmDbZewTxO5gC7BWoFYlLhnDJnb693lOgUvNTXWQjbv1VwqqMhN3R78YGQYxHD2+PYAf6eMZeC/BY4YXLuu0Hb3QOEpE16Hnd8qN9E2vJI6coqrJGuS95w+Hvaaq2Q8bMwlc0G3AlQUJxIcHgzfbDSpaOfHxrrpLYlgKZi7QqSTpya/efsxV3RtHZoT2cv/3Z6SmP/9VPTNIBw0mQEmn3TMY1YDVh7kmM1kkARn4IJpnL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XotL4NPDDPjRxuvXlsapMIYZ/LHMQ2osz6DER3HshBxgOAYKqbwCXNkrWeb5?=
 =?us-ascii?Q?+kfog6gLmMIOfnrVAx9tzgJA7s8TNc59Eytp6PEi2t7iG2q994kjLUkoc2bY?=
 =?us-ascii?Q?fSgZ0TNX4mpB1haQDqtq069JDuWEfX/9Gj3g2I/16xQ4v2QjmyQUtAVvsYy7?=
 =?us-ascii?Q?U/aDwsoaAMBkqVNhVsT4OqJsOWevb5nxS6xoGIR+V+urDnLb3IsrjevVBMUl?=
 =?us-ascii?Q?nAV6p3ArnTKksY+JMyED4GQWqY9un1gm9k6NWWG3JO3w3sAJ1hq7W8fudb46?=
 =?us-ascii?Q?8GvkJtZxvbcXubtxnpaD8GJhDHx2Qp8gT8ic9PI6j196Z9kHJTkklKFhwkKV?=
 =?us-ascii?Q?xWyRDa7MIpfisuSgEudmfZflQsnVNHfZOlZJ3BMaPGuxq2BihKQtVlUAEV2/?=
 =?us-ascii?Q?Dm0RxW2M7GRg5N/+UzPd4LMteMtrjDpNULidfFcHog8r/hURm0VQ37GB3qFj?=
 =?us-ascii?Q?6Bnjv+vOiG2flWXF33ZC1gS/8KI72cQJmKK+mPOI8fviB9JNjU0QGu+7xh9E?=
 =?us-ascii?Q?I3V4zZygnOZGeXsGXgwIQ/Ne0LdNVKzzTPkyXnCG0LydmvspYDxflej+e8th?=
 =?us-ascii?Q?seV1+jTYYvIzUIcyaZvpRkXcl9HzPIeQ0qTYjObt/OcNspVDXWhsRulfE8V5?=
 =?us-ascii?Q?pDlCK8gkLwaHLn/PmhFEI9xU61F/80rVq54UMVcUOuUcqLs9tK7I/KyjpDeN?=
 =?us-ascii?Q?uSqS60a5w1F0cfMeNpPw2poDeRF/wa71fINUTDZPLqfhQrRTB6Dgu2hS9jqx?=
 =?us-ascii?Q?kpfMNsIAeHtZ+PtmJxD2tsvDhMh4BZL124fXVjSErtXuBxXFH/dMDm48O4pz?=
 =?us-ascii?Q?8+PE6aJrGgPttmAd3cXEYN7+T+OXZjHSgxFG2LDCmuYLj3atf1waR4nwdEHh?=
 =?us-ascii?Q?ol2xHY0RkU4GHFv0QeKDuuiR25yRCztSQMXSpS5wsWk2gWRvtAkccN9Csvcx?=
 =?us-ascii?Q?xJrwrlyvcMDNRb/VX3diqwVds8ztBIyAI6SZW1nvp54N0saytBcIB+2CMEyY?=
 =?us-ascii?Q?nhcOmb7qYpy6+wvewW/EXDImwLW8Nag4gb+eTbQiYe8z5sRGVsox/Gm2fWVk?=
 =?us-ascii?Q?NLA9k+ASIN3fTzLgk5naKhiCFb0k2veHQVsji1Tos77AjzxDyY4UtocQmugf?=
 =?us-ascii?Q?Pjvv86r4L4lkLgMgGGYDmnCpJTh1xY+qJnio9kb+cglXN9NuASitSZ7sa/8S?=
 =?us-ascii?Q?p+7rzh3RY95kio1bZ4xWaXcnlJfr5S+FuWmi8i9HH1swHyisrH6EnJhS1NND?=
 =?us-ascii?Q?gY+06gUD16dMNwkxFLblHyC4pRs5/Z2Uk2u3QqPsVMSEBnocMV6/8Vm8TtSt?=
 =?us-ascii?Q?bepqWR5qeEPdT/8gdl1eA1T+dsr5IRpfKGsQ20/vjUo6Q9yh6khuRsgtU4XP?=
 =?us-ascii?Q?dmxvDZSJu+o1ZsPRCCM2XK+2+OD4EoI5H+9Eukw3muedaqJuK/g2y6wE/NLj?=
 =?us-ascii?Q?5hsx8pTXKuF2AY3V5tifTDyiifrWzaELLnans/FeP1UBNlMiiyt3B/NSUZN3?=
 =?us-ascii?Q?kLzB6WY7vOP7qoaIZGkK5IPeMG5qOGdk9VxiuykKqVJfoM+kLL3TikVu24Te?=
 =?us-ascii?Q?f0H8ozXfgvuut/p2066GZoF3Cp9KF65sGIq1DTu9SH/BJ6BqjZcIgQXviRvC?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K422l7Od0trKM7ZtFKRkpuHFgq5FDnQAajLlp5Lqwr3/7bwC7+BXBwJAK/Mt44/sJ6d6wLm29D+NiGd4GT7mVzZ44NVk5XtLG9VTOuUsuNYg80ZJnA96UgCWDtys4Ztu44WHhBU/gkCTAhL1fwpIckBZKmfSPMmQx1Sbiy/5FX87UW2w8yjE4MpWVhdtgBsckT14HHPxIni4OS5bQ3JyuLQ9l2zTwWa8l0KYZ+iFgTfs7XM3r82qVvQT6zQ8dWe/9dy7qpsUnRrTxsk7qVrKl6NfbovqsCH+gimMasqn7r3Cuzt4Gb1E4Nm0afIKYrWGJhdQg9QO86GkDVBRAmCqswm7RpgPzyCiNCjCjNyJr+KCZyXeAO10RWglDMEy89bLMmVYWDYsP7XeY+TcAHEev4qskIcm+dlT3RDxBtAtE+jMMYG8eQRg8sHtOguyofa/0kG10IqrDDBwuIsGKzTzx9fpqKkv+Pvus6ke9ETsnEqR/+oWSYwDZ1ZiwvwOijYmmxMG/2cinE5ZMXzwAUksD6vWiPO8Vc/Yqzv6N7mOxAxNBFIbUXZ5gJdftZH8oXOcwGEXQlIxh6gQpf042KpC9DEpT4xxNbaOC50qVwXYHXxty9zELKtR7QEPnucdrCQZ/bTA3bzinRpF7rRfFSJvpung1IBEsHuxDZmYJSFMjcVYUf/APs3YPVOibBoqnJ9xExLyQA0+2QA32HTIl99uSMIDX+lNcp3VOJW0nTIzO56A0H/CY8chRkVtkSC6InkbvCGPtZrFZhbXIrHwtqOGd7FozaZgseuD3T0w2zFtVMXfZQNjCfaXzpSPQdQVmp3Bz0FqKxYvjua15q7h38s4BaaCUlRghNFq0i+SMeVS1Z7RDz8w2aKno1TZB51IheKoiEwtIoBd3b8bGwg4kCY+QQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0823f243-7bec-4265-3f17-08db62463ead
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:44.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6BJQ73z9Mrg8d5wP7VQgVXgbmbjWN9MzZ1B7nDjQN9MfAhh1fF5BGqNhweEkRe7h21F09NikHoIxJUpP1nkXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: _2xj_LCbJZY3wadi2aao3ZIQYNZjATUN
X-Proofpoint-ORIG-GUID: _2xj_LCbJZY3wadi2aao3ZIQYNZjATUN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate it and call mas_wr_extend_null() from within mas_wr_end_piv().
Extending the NULL may affect the end pivot value so call
mas_wr_endtend_null() from within mas_wr_end_piv() to keep it all
together.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 34eccddb0b47..adf662bc413e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4197,18 +4197,6 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 	return true;
 }
 
-static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
-{
-	while ((wr_mas->offset_end < wr_mas->node_end) &&
-	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
-		wr_mas->offset_end++;
-
-	if (wr_mas->offset_end < wr_mas->node_end)
-		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
-	else
-		wr_mas->end_piv = wr_mas->mas->max;
-}
-
 static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -4245,6 +4233,21 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 	}
 }
 
+static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
+{
+	while ((wr_mas->offset_end < wr_mas->node_end) &&
+	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
+		wr_mas->offset_end++;
+
+	if (wr_mas->offset_end < wr_mas->node_end)
+		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
+	else
+		wr_mas->end_piv = wr_mas->mas->max;
+
+	if (!wr_mas->entry)
+		mas_wr_extend_null(wr_mas);
+}
+
 static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -4377,10 +4380,6 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 
 	/* At this point, we are at the leaf node that needs to be altered. */
 	mas_wr_end_piv(wr_mas);
-
-	if (!wr_mas->entry)
-		mas_wr_extend_null(wr_mas);
-
 	/* New root for a single pointer */
 	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
 		mas_new_root(mas, wr_mas->entry);
-- 
2.39.2

