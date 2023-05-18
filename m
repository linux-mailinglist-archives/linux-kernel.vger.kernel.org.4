Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9770846D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjERO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjERO61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1558F12C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IsjB012432;
        Thu, 18 May 2023 14:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vTkLRZV9sD6K+270TKH+xpnYAi6cmrgED7lowvnLyAM=;
 b=3D75iLbXEDC/I0T8BgBeiRFUEYBTHsLrp01OP6deVbuiy0Rb3zYZXue9adak29Hgzorx
 IadYAK8AweILb37UENG7mTS39aMJA5Hv5TzmIOmI9TISzoewh8kGsL1fzW21JRizKrIN
 h6DUiQwPC3H8JSpyEDVKu3MzVDg7BH2KK2gbD9UkY+6fZIWb4z482w22O9TR+Gd1pjvS
 CaZqSA7dIO7pN9Mf6HbpkpLpzruLt75iU0YTXfXcCouwgbgv6zC10gzXYKhbL76KtxyY
 /iG+lhgg+ceQtKv7Z9Jyp/Q8m990OJNeAly2TzoAdWKEb55AAN5RI5UgJlvfPV3lDXUq HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpjr8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:55:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IENu90036166;
        Thu, 18 May 2023 14:55:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm03w2e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdcJDpHhuZPEw1yn87Q8chI1iDR4FUUiF2UJs9KDUhWGSz3GTBAYXvQf/WI0LUthc/7qt8H6rWp37r5LQf4fKRag5+EXuR47iLabcCmLwidup6H+0k2FHGc+a4AQUlxiH/UfKF9bm4mzQ/4J3cjAbkXeFFQ/RB+FQIgjUXoPLdge1hyomhp88ciBPK+Im3dnw/vba3EgRa6pHaLbos9Euqz1urJImYx4zbw+9QrNc8sGBgCWkE4DTCDeBUeixL795epY/+So2ZwNfBjfXOF0hIIIP00fzgs3oM96/9hjPK3wHMoaJI4/Z7ep+xdV0Yc1zh97Zp/qc50/u+kfceCvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTkLRZV9sD6K+270TKH+xpnYAi6cmrgED7lowvnLyAM=;
 b=i9G1tk4adNVYdT0TK0cutnfFMh9r1tVPBVoQlgTa7iz6Rh4fibmpsU+MT6BieGtdndyX8uawJzMDE4tK+YccSqkjZ9WTrwPtg4bv/M9g9+MEtPk9XwtBNB1lXyM9AGxh118CGSUj0UKKKvWLgPk1HZgsM1zeJyGPiP1Q0w13opu/KHujUn8vZ3GkBZsfa2Af1G3V4kg0cClp/LBmHkBvsqYbIyGq+jHwmMzqo2U97mA2LWOA5tWBq5iRgCk3JCeyIwuds3PkJ/qdLZA2xZNj6DIYSWTwSc+PSguEpAiAXnHpKNPO5mdgYmsHCbOxwtRDA5aEKHC/0Lmiwb4uqlnfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTkLRZV9sD6K+270TKH+xpnYAi6cmrgED7lowvnLyAM=;
 b=Ez0keSAUyscVRbvqa40Djl/rjlRnpLEMDnAESDb6IgwrJG36NK+3EsuXgBNOghUlwPPdVo9Vtlys26z5q5wU/GWJBoFOkJajij8pMJ3oDjVuE+V1kFkiUSLBbKfrwNTvznJk/6aor56svqHvKdoFf+K7Cc/z/1UDYF4Bo5dllHY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:55:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:55:56 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 03/35] maple_tree: Avoid unnecessary ascending
Date:   Thu, 18 May 2023 10:55:12 -0400
Message-Id: <20230518145544.1722059-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0251.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d85856c-561c-4165-7c6c-08db57affc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3oPviggk0gJFgeNfgurLBDmqk0p89jWTxc2ITUD3B07ftD4ZgeQaMUZEtpEa/A9wYEJmDjP2jjJAlk0s8c4HdU0d4hJ+Ne9auDgOmXt04Hitn+SuVDCc4g+j/IM5kIJFANrb3R14nJpn1qIn2J++x30/hb6FXfTrtd+25d+glnfFPbCed3v/d8Pz0YpvJB3HNmX301Q4STXLQqgkT34o/ihIWaoJ9MnpyU5JTpM2kCvf653dhYBpJywTd1IT3OQu6aHKngsa0lYXIColWEknaelXic47ghWrjKr1AxpEn3pdjaCrNe8VTGrk/8l24mziHF+2BI5qzj3p/p5prBLTP56PI0Eu6bTOSd7yQ/WH1hvZEay87TKg6Otc1KJ16QkQgTpKIlxJX/pHVOohv2N8IjyWCFkRno7ftrBniLSyzbeywVQo+G41lCKzQaA5JbVG/UG9GJM990vlBNmYmVs3A6bWxG7JtwOb9oqMzoT6RiHrSdib5cNxgqQ6RlxSH1K7zYZd31AlKr9UkaBlwCuFH24CKQHLIqM5D45TDV4QUZwkvooPJXOuJscdahAAecN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(54906003)(2906002)(41300700001)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xsxNDx21mQChfAh0TwzV004f+Vwom76rf5ImhFg3YGRn88kpPDTlwRm/KEa?=
 =?us-ascii?Q?aKGjptTx5UoIJIFgx+Uc2erxPqOH2RrUENKoGakQL+2z6O37TG1o5Wu/PO4b?=
 =?us-ascii?Q?YBVSI7qPrlzB7SHzf90dxikfSKTrHPkXH3Oxb+7565hJqya29YoJYJUAmcDd?=
 =?us-ascii?Q?lqbFHI3x2grY3fIfdMs970PlP2KHMy3z2dneqH2Fnu9Llk01rIQLAA+SnIwa?=
 =?us-ascii?Q?eFcroMXsWN466xckahW0W7DO7prPR7rsfwkH0w37wlc+RbpVZybSwye5b52o?=
 =?us-ascii?Q?/0/faDyzjKjLMeESS4HbCUhZLzhNhzjsDV2QfxYvkqZNcaPfSDQz0AbsP+UY?=
 =?us-ascii?Q?lKpUJcQvxC/GWpDlz7Vdmn6uomGanqUNn/VTF99/sqnT9q6y1pY5CRBR65Gn?=
 =?us-ascii?Q?kGW6h0zbe42ljWHNnVIxFSz52mEp8Scgr7Bgw4b7CbFSEJtCJWFLv22EjpC4?=
 =?us-ascii?Q?LsZEJF0U54qC3PRrz5ccASgzuFvVNEd/uQNzuFCw7/2Oog2j67cU7qK9rewm?=
 =?us-ascii?Q?pxFyZMqOTgcS68XVd868HEfuU7cp3dejwFppL3JFHx1xp9trwp4rVym/Y6jJ?=
 =?us-ascii?Q?b6TYJyk55cwQTiQGvlSgA2D/F56G0B+UClcar1fzZP4TuEnsQUJMhB3KIJVo?=
 =?us-ascii?Q?XM1IMgf7RyfCDGWJr//93BdzZ9v38YZYvlTE14WqNLE/ZYIbiljhkZmbpVJz?=
 =?us-ascii?Q?fd3+3UO3OVPkX2fxQwlzACYm+xnDhbHF9++N131aHKGYEh6OGRurhkBwL28g?=
 =?us-ascii?Q?FNTCZvDSENSujKq6SoMDBZTtZYQ8ttHLFxv2mkJ5gqKvJyayHD9vxJ1CNDgJ?=
 =?us-ascii?Q?tlOdpWkxrtfyTfA9gu6XlHSVBNXwrGBmwAGHEIzgrcO8Niv0mhclYATBt7Mp?=
 =?us-ascii?Q?G5Odm7F5OvFGWf2+7rFAQ+iKIhRpJBSCzNdAeEMAao45697QglPT/btdQKqC?=
 =?us-ascii?Q?7O/uzahR7ZDv4svID1pvzI9I5UIpLfoaBm/iFJrSJSUx80D3b6mcmTm/ytoz?=
 =?us-ascii?Q?WO3NpdtAcmIy/UMGpge9cKZScYMjrRyAidYru3aAYav0HGzpllKAOdzyPxlT?=
 =?us-ascii?Q?/t/RjvgllfnLDN/1UQlg1LszNPeaAeeBUsUDW2hXfl8Ax+w/QMRGc5HJZH/e?=
 =?us-ascii?Q?dpZc5E6NyjWnWtRON2rwNfwybSoN7yFjtBOpaU2xWJAmpszCMsPlcziR7nDc?=
 =?us-ascii?Q?GD1pDVZ2BNw5MYSexEBAaLIOMHWFkjCXul0JJcMGPc910yTx3wjgaZB2K3/e?=
 =?us-ascii?Q?8Z+uU7DMJk831tMZpda2M+LsClTyx0UMye/4R0Dd6BAwk4/dxVAu8Il9y8PQ?=
 =?us-ascii?Q?5YoJBvd+UdK82zROwDpzi/IZD/rRxfXZGXvCpa4a2/DP0q7ccI6l0OF4Rvg4?=
 =?us-ascii?Q?ZZDj32c9WMlOe9NMg1TrTo4lHPeqT125AIG/kBTElPFlxD0B0/44AQJnUjEV?=
 =?us-ascii?Q?jXueHk8ify5BZiWXGp0isjtvZjiv3RxRTQawvFJdpfer0FZLl2PwtYcFOT4o?=
 =?us-ascii?Q?OsxYmXhGstOiVCJUmVMzSGx6Bn3jCDYPAC4IR9WzH5yJhDWoa+waj0XfPw6X?=
 =?us-ascii?Q?mCea2ZyyPP2kmueOFZLbk4Wfux2ulkr3orB6t5n/Q7wmwlI4/ZJYaJUZCN2T?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xxJwQYJGZBpIhm7PTUDXVFmF2EY4beea1zuykTTjR8EbnprvUjepjCqWUm4W?=
 =?us-ascii?Q?1j2RgIFBkiQV4e4LdHnV/HoJ4xoE2aPcBCSFMpGSpQUrS3DgOQsitpWZRryr?=
 =?us-ascii?Q?8M402vSHBxgCbGeazY71fV9QvYPHQL+aMW2ok8O+D6CRU3jE2tma3FzWMKl7?=
 =?us-ascii?Q?AA88ANO3qHRVEGaF2FqCim/CDVbZFzUsSQ6rBamlonc9lUsUZ3TlzH90WgMY?=
 =?us-ascii?Q?wDke4YJX0BS+pEpNTL+orfmQrahOLCI3onyvXZ6UnifFePxdRLc+FgPFMd3c?=
 =?us-ascii?Q?sdMDKNuxG2sASfrpj1rh5m8C5I6wYNjvI4GCzis85mB0/tdFVGDtZdwUvoe1?=
 =?us-ascii?Q?LfFE1V1GrcJ3nXBl3Q+81Um3PGBH+NTite9SYW/jSTj7DEUg4lFB7LFGD1zU?=
 =?us-ascii?Q?MOZAKZ3R8R9eluQ03Kj2dobwp/RiVC2j/z2pkOkDUlfUqUfkjyPXblrZzi7C?=
 =?us-ascii?Q?6yCckgJ0UHFAFEiC5Wl0URM+TzHg28fLCijlmic+JuX5cR4xMvVcKp430Z1+?=
 =?us-ascii?Q?eeM4QMzYa+2N5QqHQnMBjapivJG/9m6zXaLZPlOQC7W92vmQCv/zAbLkTSJV?=
 =?us-ascii?Q?uopVGAu+h1Ml24EPeVjETD19EXjOLOET6xR9bCfWFGAb3P6yoQSDUAiZNmVf?=
 =?us-ascii?Q?49Ic0wtsK732sj0Caf8wPF+u/J8aWT1CZxnujWuVQkaDfg98E3cqZfhAM5BK?=
 =?us-ascii?Q?NxQ3BTYM1IH2Pr8l1F7Riln6tFf9VbtKEnPtcF9y1rafTNsrfHNP6St3GQbJ?=
 =?us-ascii?Q?0WDiYmdy1fWntbN0j/amg9dwY4stWLS8BOgBVmm5hIbuxa4nVDH964qfHhvq?=
 =?us-ascii?Q?E+Eysw4ZGQLgccPRPxtjQoUsKEnPJg6AfPXeMy6nfCIYQrjpOy933B4xmk5r?=
 =?us-ascii?Q?YMfm+2+kzQyGCOfQrqs+zQIKzkk9EfLb8DV2J3CKmtEeHB4roHxxQwRVNeie?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d85856c-561c-4165-7c6c-08db57affc09
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:55:56.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsE602Tujvc6t/7rMxx0e+yKe8m8P0D3ys/uwcWnvxoQhQ91xLgQeN+CNnukBDBBEtEZOHLlvxRfoV7kYDV5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: 6tVROkeCYLwVLJeX6Y0Nc5EfrzMLcO_E
X-Proofpoint-ORIG-GUID: 6tVROkeCYLwVLJeX6Y0Nc5EfrzMLcO_E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree node limits are implied by the parent.  When walking up
the tree, the limit may not be known until a slot that does not have
implied limits are encountered.  However, if the node is the left-most
or right-most node, the walking up to find that limit can be skipped.

This commit also fixes the debug/testing code that was not setting the
limit on walking down the tree as that optimization is not compatible
with this change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c                 | 11 ++++++++---
 tools/testing/radix-tree/maple.c |  4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 555de3a8343e..5b29d5a916f2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1103,7 +1103,6 @@ static int mas_ascend(struct ma_state *mas)
 	enum maple_type a_type;
 	unsigned long min, max;
 	unsigned long *pivots;
-	unsigned char offset;
 	bool set_max = false, set_min = false;
 
 	a_node = mas_mn(mas);
@@ -1115,8 +1114,9 @@ static int mas_ascend(struct ma_state *mas)
 	p_node = mte_parent(mas->node);
 	if (unlikely(a_node == p_node))
 		return 1;
+
 	a_type = mas_parent_type(mas, mas->node);
-	offset = mte_parent_slot(mas->node);
+	mas->offset = mte_parent_slot(mas->node);
 	a_enode = mt_mk_node(p_node, a_type);
 
 	/* Check to make sure all parent information is still accurate */
@@ -1124,7 +1124,6 @@ static int mas_ascend(struct ma_state *mas)
 		return 1;
 
 	mas->node = a_enode;
-	mas->offset = offset;
 
 	if (mte_is_root(a_enode)) {
 		mas->max = ULONG_MAX;
@@ -1132,6 +1131,12 @@ static int mas_ascend(struct ma_state *mas)
 		return 0;
 	}
 
+	if (!mas->min)
+		set_min = true;
+
+	if (mas->max == ULONG_MAX)
+		set_max = true;
+
 	min = 0;
 	max = ULONG_MAX;
 	do {
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 9286d3baa12d..75df543e019c 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35259,6 +35259,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
 
 	struct maple_enode *prev;
 	unsigned char end, slot = 0;
+	unsigned long *pivots;
 
 	if (mas->node == MAS_START) {
 		mas_start(mas);
@@ -35291,6 +35292,9 @@ static void mas_dfs_preorder(struct ma_state *mas)
 		mas_ascend(mas);
 		goto walk_up;
 	}
+	pivots = ma_pivots(mte_to_node(prev), mte_node_type(prev));
+	mas->max = mas_safe_pivot(mas, pivots, slot, mte_node_type(prev));
+	mas->min = mas_safe_min(mas, pivots, slot);
 
 	return;
 done:
-- 
2.39.2

