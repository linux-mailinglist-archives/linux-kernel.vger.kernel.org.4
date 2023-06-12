Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5E72D0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjFLUmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjFLUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89E01998
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNk8H016718;
        Mon, 12 Jun 2023 20:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Q022I5yTvzYmJXxqO7/WBlIwy5GdU306+IeJGS1jis4=;
 b=BFacnYjJeSgPODs2GxVJSgn137lZuOULhnO7nCoWxAL5FipMaep70jLuaCBf9TR5brhP
 rPUwrMuevppb8gFcqkxMlrRFbQFZWcB2hAbu0ozapNhGRc7jDrhLcDTKZUDRiz6eVA32
 ZHYWAl33SNocGRfn4UwABsoink+r4GIm7OrREZAPJGGqqtd+g8VHJDgwewviHwAn43Kf
 a7HH6D7vLdgVqHJ6dCxir/sk0gEf5dOSS4YUYfd3z80Y1kzthOx+oEefvp/yTlonAXGV
 c6wtpk7bpfJkx2oI8tojx44ZTtrSIPrf2blS7YkkZY/b13kRRMYQu5J/S66LoOsQz5ul fQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3busg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKWdkG016285;
        Mon, 12 Jun 2023 20:40:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm39act-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJkmYnM97KjX6tf5szi/uJ3Tveld42Y1TEvr2bqXVQIoobih+kkBmQql05wV2FlyYfOE39JSAkbUEzoa2dPzCJ1yHTDvZAkuawwyuYC94RfBrO6lzvKbmKF7f0OZISzrYOi6my7lz+HUuTqCZbtk+sm3DNCV7ahX9QzTg7+vVTqI/EkBcuUwNlfScOIjQ4j7kreKHPBjojXVxuIvh08cgzB3rYDeSHwcgVsJ5E3gXLv5BsSsunabYuzXmIiCEtAuyUfY5S6O9yGjJkXK6xlnRuu8b0s+93DALF6ykZH9hKQhVzc0S9ghOdS5IldqjgI9tuAPBiGCO+e0oVV+4hFFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q022I5yTvzYmJXxqO7/WBlIwy5GdU306+IeJGS1jis4=;
 b=BpFc9F0G7527iHl+wFlusB9KMlTUIKyWA4vBWOK753xhxq4mO439SOxmoWtd0EOYs7jLGSB3dWoH7r+KpSCW8x5g46axg1rzLedhqytd4HmHQ9JBc3dKu8tEQTmM3WYEQYxcACQBE+ykZyisnO7gWeDHqMShxpcsm2R+EslYbPjTKSnzHJMBo0K/6tHXegcH9r78FvC0Jpb8dq0XvGkQPbV8lsnZagVIR76c0z9F8sZgh/v/yDMClqrdIvVoSBi0BXbHYkJTBmXl7i41CqFwrnKEk+RM0/xinKq4YfU4X+Riffq+tDVYNSylGSmduLk2RbnKKoXVwKYfE4jdS9IUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q022I5yTvzYmJXxqO7/WBlIwy5GdU306+IeJGS1jis4=;
 b=SMnlvZ/zKV5Gz1gDJXyw4pbGXOtaNTjfzWnSHuoorYF31PbwlKX59kMre6bHIZ6gsmtSSI/WD2Y82taJ7FEaIgFTiv6GKQhxPdwPKC9tF40W5KB284yX8iQyj9EYjp5Lj8gomi4EoM9OltuWAQlTochfniPlTZbB/wsspE/0QE0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:35 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node calculations
Date:   Mon, 12 Jun 2023 16:39:51 -0400
Message-Id: <20230612203953.2093911-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: a45bbe5f-5396-4af5-f256-08db6b854657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6O66l1Ng+2YWPcjS+/NR1IKzjQjWNRbB1MgIN0Pt/8ZLDPLHtrVdoJxF9ulyW/RGnZcnnZhBysz273AFIoRQnOlwqZp1kV5WhDWNmf2LIDUuwwb5kPbffOEdg/Qn9mmBqu+/qZ3DA48TjgPBC9IbYq5zzYm/k8a/d6NW5sfoJuaIkB4P95D22ZCiCxg8S+iJ9pT0MBqifRr6vBAHudG/Le9K6IiCJEUbx6ruIFjoqIirScNymdoKtVfcmHakwRxfQALxccVlxmwM/7Xk87WPeaCMt2bzr92YZgwpf3Tekmey0NObIpgJhnm9Xy2pEGC0VTCeZmNEDd/t9USjD3mdb8Gv/hEMqEGuUsdMTyE2eUxP71mJJmIrqWkb2HXX9R1jaG/XgJE2TmKL0n4izCqn2L6YUyGlTt1DghAZ8J8p2oHYH2zHUXhzPZ4sWcCCgb15+2Tk9aUNsEgA2RwvSCf1Jb5af94Tb1gU68Y7AHRl4p/OzOp+aope67/vgYg+oCmuNvW8ElksCoGSRl1X8R1xHmGzAE1nQo6NzLV4qdD3pKrEKeJA8WXdH5zSuq8w7t71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sAqqN/m5Dfl434q16z9a9qsPtpgv5uCd5xAs7Asq2bMrJ82zP44iiQezbYmD?=
 =?us-ascii?Q?ToC0FS0U9a5Bax35JfYPWd1V/fm6rsKxUCrgKeD4m7jDbbLvdTKX+cL74zEN?=
 =?us-ascii?Q?AiKjHXau5G3CPFJnWT/DlKAV73lnxvU12YBR3822vio8lmp5pDmOk6mdxGqJ?=
 =?us-ascii?Q?o235POl9SZbY4eIaKrezN4lOTymAi2qtLhWF2WvDJMy86jkhLHoHrbLUeQ3C?=
 =?us-ascii?Q?j/upUXQ9kptY3MhtZtCVRIlSA9ttGGN5nS0dpQlU1nmqeoHzs5Po3JzXhgW3?=
 =?us-ascii?Q?bZOJqPktx5CUwSeFvO1kFMCDpP15HJwPTE0QTXf54NfKQaL2ItoIpmL5ndvf?=
 =?us-ascii?Q?BWsk5ZI8kaK70huotjrDcxWNmtfgjATghxxb1+/xok6ujgRQKDDwDZF/L9ds?=
 =?us-ascii?Q?L+Zcec/uLNkZ0VXFyPzlVzvXSFA7Dp4/vvra95+ktr88ZLetyJYNvdle4sma?=
 =?us-ascii?Q?mZqfxz9f5ofICsaCpBn34h+nI2qGH1f+AB3vRFHHB3N//xJWJWAtGZYBP3il?=
 =?us-ascii?Q?Jt6T6fWaaDqs05dnb/YfJcJ/s2TcdIUrzTrcERiylqwNy4n9TeoS6hcg7suA?=
 =?us-ascii?Q?gQAj+H/P6rmoJaT1SrfJSpzF9UyeLtjvCYxJibgd9LME5LUzpkXlUSi2kZYY?=
 =?us-ascii?Q?M86kEv7j8cGizecH4BueqoAQNYNOln5HrE45lTE+M+Vk6tsBrGF/H8Pr/LJ5?=
 =?us-ascii?Q?sZJDrhEeGLMiyhI4E/XP9ihcviJ0g72xpdmyUmVgj3KM2qrZOoasAMa6ng8I?=
 =?us-ascii?Q?LuvtdXv/uBgE1mJ7MO6V08dNTk4MWKlu802Q7cSu9zppju75ZVoy8dp/n8kt?=
 =?us-ascii?Q?NJzPRZrWMfnhfhLBZ21yeYAlXhIqZA/2s/aoIJ/L/BV9ISSq6pX0pyr6evSu?=
 =?us-ascii?Q?T6ZzRztza9LWgNqBSJKE2LMF1RK3wEsOMTilAOf8HI5XmvAl6m/egYT/kEv4?=
 =?us-ascii?Q?9dnwvI0+2YVDl4X2G4ILu7k8WrVGXPBCfPgFPhvxhoUgxIhGES6SgUIiIyAt?=
 =?us-ascii?Q?JCrEZI2qWt/JXP9d6H6M7rupXijS182WsmaPruD/z/Ut9CDbOVHtGlpRQmK1?=
 =?us-ascii?Q?zBOduso3Bje9GfCEeKK2t4KQj998kjCU37QB8gkTOgfrLcc+bZaKvuAgZpnO?=
 =?us-ascii?Q?bH4DP6f81+Oz/oksYjBKF7jT3JgvjbJeRrH9nVhfJgMikKst6//yu0QwshI3?=
 =?us-ascii?Q?af9oSDCSnKGnbZ9GZ896/4l2F5yxOIDZ5G11n96+UOt/CB91oRsNdu0AXO24?=
 =?us-ascii?Q?mnTt6Fiwh9U9d/LZTpMlOFC7xdG8yg4xVna554LdTxZeRHnuHXO5rT4+V8L8?=
 =?us-ascii?Q?Savbedwqh6gewACUY3ijjONiOqyb9+IdVolspChnEyQrg3/3RhKHs6y+k9Gh?=
 =?us-ascii?Q?gHMy3pFfkORotr+40nyTIopwnz7Ui48mnx0ZiqWw2hqcuGAugtGmam1wl5AK?=
 =?us-ascii?Q?wAekPNZuIPBv0YdiBZtJXRTzsT3fuglDzpx/w6LBDt9yuzJduEwI9xsTqOkQ?=
 =?us-ascii?Q?pFNldGKcw0qMXGiM8eNAM8rOmRkT9YpcWa6/I4dqDNH8hTxl5I9Mz8KyvQPe?=
 =?us-ascii?Q?+6tLq7rzTSSKlAPYTsg/+r3NQAFqcK4nv8uuHZ0mR8Bcqq80lmGDQMvVY93u?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5vbifZgLHqZezB10eFNCmOqma7kQtDu6wuaEkzLEc0vE/EQX3etV+UhwTg3y?=
 =?us-ascii?Q?7onr8DJqj+chrPgFKhUskS6fwBtu9hFd4d4poXJYs2V0/uO/GkgDf3BrUDa4?=
 =?us-ascii?Q?fU2IVph9Tr7dNaCrdnhKtHC5lVKg2jUXxHYU0c8E5ADF6chmlTSW+yIDZoWh?=
 =?us-ascii?Q?ZgE4MztMzQxj4v88xMAFrRmPMM84BIv8i/WzWZujRGrZA6JACaXEJd0XrviA?=
 =?us-ascii?Q?IIQPIvo4GpK2exI2aD/Se3oNFvrZY3ZmwgzICF2v9C0tzBmcwJ3GYMe80Cz+?=
 =?us-ascii?Q?JZ6TyRWbGiwYtdP/2dzXnhdJQGKFR2BOnT+22LYKxi2TGY+biuCTJGWNMoao?=
 =?us-ascii?Q?Q7upGaFza4N+BRbhvuWOloZjL66LpTUIXxK3KkhHFjOt2ncbA0DJSFLVODAu?=
 =?us-ascii?Q?TKQhqut8VgXJ3m7l7C3fky6G+h0moRkI5J3OXJEaSLJu3slwcBPs2SswZmSp?=
 =?us-ascii?Q?+uKrxXkY5uj4eE3wYzfDrzMvfDiZmoTWgJd1SCbVSn7hWQV8lpFA0J/uPqpx?=
 =?us-ascii?Q?ICSuEk3Tp3XHQ6Q14Bio75irY/40wdkIEJ5oQZOb/n/X52puecX29AJcm6Uj?=
 =?us-ascii?Q?Eqznue3Qf0i6agia+AmPOV0iqV5ta0GN6Me3gw7PgEJteCntBntphaX4qJmv?=
 =?us-ascii?Q?Ay7UoEWOJB+5fN2gOrh28YOYCb5Istw6M6xwn6AX3TB/eIOD7ys/3ZoB82yx?=
 =?us-ascii?Q?OCt3E86Hdp0oP6HF15VoEZCcdQk/SdFtReNbq1fGzbisvAYJbmnYOtMe/rjk?=
 =?us-ascii?Q?viXka+rOtXoGyqKDoHJgu8RClswfWxU/SCsFSSfDNtIA+ooCR1PeGC2CpjiR?=
 =?us-ascii?Q?rDCu3SyXpeQvzUmtE9a0F2Q4ryih3r/Dua8D9stWQH2XITmRyGULL68MQmmt?=
 =?us-ascii?Q?bbBeDOfLbEubJxLUDmniBTDSwIUkr02bA8TmJ51Ve96RsiXYAY1KMFuRiFHf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45bbe5f-5396-4af5-f256-08db6b854657
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:35.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swcic7+my1i/H/AP7kot2vF0i3RNC5eN7gRDobxHWcETL/xsmLvVHykX3vmDECqwHGmcxQ15qseGtrd5VagD6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-GUID: T7FUYL7xApYuMbVNCww0nSA1vPmRLPyb
X-Proofpoint-ORIG-GUID: T7FUYL7xApYuMbVNCww0nSA1vPmRLPyb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the number of nodes based on the pending write action instead
of assuming the worst case.

This addresses a performance regression introduced in platforms that
have longer allocation timing.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 048d6413a114..7ac5b5457603 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5541,9 +5541,55 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
  */
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
+	MA_WR_STATE(wr_mas, mas, entry);
+	unsigned char node_size;
+	int request = 1;
 	int ret;
 
-	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
+
+	if (unlikely(!mas->index && mas->last == ULONG_MAX))
+		goto ask_now;
+
+	mas_wr_store_setup(&wr_mas);
+	wr_mas.content = mas_start(mas);
+	/* Root expand */
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
+		goto ask_now;
+
+	if (unlikely(!mas_wr_walk(&wr_mas))) {
+		/* Spanning store, use worst case for now */
+		request = 1 + mas_mt_height(mas) * 3;
+		goto ask_now;
+	}
+
+	/* At this point, we are at the leaf node that needs to be altered. */
+	/* Exact fit, no nodes needed. */
+	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
+		return 0;
+
+	mas_wr_end_piv(&wr_mas);
+	node_size = mas_wr_new_end(&wr_mas);
+	/* Slot store can avoid using any nodes */
+	if (node_size == wr_mas.node_end && wr_mas.offset_end - mas->offset == 1)
+		return 0;
+
+	if (node_size >= mt_slots[wr_mas.type]) {
+		/* Split, worst case for now. */
+		request = 1 + mas_mt_height(mas) * 2;
+		goto ask_now;
+	}
+
+	/* Appending does not need any nodes */
+	if (node_size == wr_mas.node_end + 1 && mas->offset == wr_mas.node_end)
+		return 0;
+
+	/* Potential spanning rebalance collapsing a node, use worst-case */
+	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
+		request = mas_mt_height(mas) * 2 - 1;
+
+	/* node store needs one node */
+ask_now:
+	mas_node_count_gfp(mas, request, gfp);
 	mas->mas_flags |= MA_STATE_PREALLOC;
 	if (likely(!mas_is_err(mas)))
 		return 0;
-- 
2.39.2

