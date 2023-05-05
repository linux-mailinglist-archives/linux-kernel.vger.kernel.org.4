Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F406F87D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjEERoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjEERoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D018DC5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:09 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345Hh61m027900;
        Fri, 5 May 2023 17:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=A/hWRGZ+r+UMcw2/v9TIxTDIJ+JR1dErT7KveUbbwtw=;
 b=fbjDNS3N965hQg2Kn0hFv+NueLkt/Ov3sSK2Sx6jOv8mSi+7X/JLZeDENLLeuhNgAtPF
 Gnu0tBAXcgtBapAcHZfzBnN+AB6dxR71OKrSytuEIw3Y7Z4oAkmc+grrsJKIh2xUwr8x
 RbPuXTNCGow+gEmcuLUF39QbDFni5CYcPU5NGMnIlHxTBc4mIoWxG4OKtA7ll9C9k6LW
 IeYpfQLTCnpUb1hEkuY/dX7TjxGviRdAv4UlEWVQt6OE/d4cB5tShCo2Q9cV0okv/iap
 TdmsgevCi09FqlHZ2R1aoLWlYSB6mbXLpO9/n/LsJkXC3uHn3tuaA3M4ODx7/gykqlKF eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fwf3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GVNqv024864;
        Fri, 5 May 2023 17:44:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spacj05-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0M2adONDnlfZJrwppUx/es1al6o9KmhsqQKdtOpDR2+m/zZ5qFuXDEQf5DvtObPlGk4DGrEp2QvkJfXFmbw1ChqDCc5SWVdcyOgBXndeAgNs++1L+Q++LeQ8rC531H2JP6krSOXEzGInyH45B7vlI0WbQgSn8cr2vp1Q2rDsZaPbbHp9WuuWxREn+7ghpk+ws1u0Kr0lqLbMvIlDzx4tPyGJm6lay93FBlMmhmeXOQmt+oWAFgFyTOK7DddyvRHGMx32WqVNkh/v8ulSUJKftmsSYrKFy2ck3bWmq73m0Iv3h4XSkW6MI1TZQ1FfqXh7v2xr5td8N90zHzPpkQe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/hWRGZ+r+UMcw2/v9TIxTDIJ+JR1dErT7KveUbbwtw=;
 b=ShuPvrMwDJVqHE8NhmOvWq+6/jb+7rw2dgaH1VsWWrhMd+GiI/u1PTrhTHqf3UoY50NQ2NqUKj05DHzqNCQkCYUoMcpKzibCvogP1W8lg2eE8ipS74qUeX8jgU+g5qnvdvOxrdhO3sJgsxcyJLJUdyg9vYLxg7YDMPTRMopfOq1s6yhVNiHHyAd8Ym9j2mhTETP18K4PdjVAKamf6jfTYAyzlUVZoJcURRogjg47MoZaE9Imjc7dsTmpcrVzLeu7icaaUJnH8E6gfmIGc7dK1NTavvBU8V6XK3pf0kvYldecZrQ/3t5usibQVk0WOq4DBvCOKLdcubAa2khr0QKd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/hWRGZ+r+UMcw2/v9TIxTDIJ+JR1dErT7KveUbbwtw=;
 b=VhgVecnjvBmf7uVeGCCAIHMT7McMX118BTBpvi4RyDIBBhTNCLQdvyBYHh2F6AjdlmqwKupIKhuZI9d/zLC6zxdgTJMgv+BVlWqlUOD/ioIZILmmGVFdzF+kAbQbpyTIKhTYv9SLKP7oXC8Q6UElKMRD52W+D2t13K33JcV4PeM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:02 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 09/36] maple_tree: Convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
Date:   Fri,  5 May 2023 13:41:37 -0400
Message-Id: <20230505174204.2665599-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f39d8e-4e3b-4a05-efb4-08db4d905033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOMooxY1m+g4BZZvymxgXsr+/VkErSwfeWqE2CSCknuuHjQ9V5GKCcc2iwqVxVa8z0r4/EXb76zcZ/aBZKcTAOEwVh6tAJ3cF2ELsr9IaGszDn9laYrpvTkk2gf/NyncQsv52GGci+E8w3dF8hCNy4qWiEEGdYFgonY0EgHrc1DI26FjEHVuow0T8tWwhzae/DaJDzCs73GujWVYHV8G0euo0Xs9chqzeM/TiCgLxnWDb3Ry1LF7ACot+g68VRNU2jsMOjzikdrdOYI5GVNyQ8m5rUh7YUaK0rRtYUW39GKeuVmyaetcmc471Bn/qRWjEGfIA1bCiaFvXJw47RELjWxzerPKxjSpRRah676tm7LkLLU7HssZCIDMP0xisGM/usbkETrHi+mGBN2m34A7B3MkCGdK9Kb/CM62taonpThPhBwK3CjNsINVoS/90sneZq0r4En3Yu5HM9eo9LmH0epWcbJDbpFIEfz3mO5a45of347ar7+B5Xaq26kVV1j7XnTfLioj8nDx/Jk3m4Ew/GUwKaub+qPej8sUh1eUXiMUUKhCpfQHQb/P+y08IfEt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ko05ixTfypauaaWTgnwUi5zpRK3gIhZzTEEnPaSaGMrT5gLXH/bwNAmvKE9L?=
 =?us-ascii?Q?1w3fTxJi2sgPYYhyGya+eg7mg9w/8D1fIjlDAyAs2d4F6Kz4wlbNUIuxS72A?=
 =?us-ascii?Q?Gv3alGXrzQW4pJGkw17xSxMNOjj1GJXWmPPXQci11PJCFD2Dkj+cyG/e/6ej?=
 =?us-ascii?Q?AVsLj9sdOtG9qA4RmC8Xqve04NADHVxTMv/ckHTHH5M9f9PWMiueGoZ8mTf+?=
 =?us-ascii?Q?Ifzn51NLbGdQuSBxQIZ5Qo9nvBlP1Bf46jasbqnKsz7W/6SOIyFK2PxPjnv8?=
 =?us-ascii?Q?ccWV2bGR0dAsxTsjrYA+5968sCC5u0748ob7shZgTlWgp/HQTQii/SeOPJeB?=
 =?us-ascii?Q?YVGZPlEw63K7vbcSuOyYY0McxFuylD13O6snYseJYSoQ9VWVTYDAgEPiR38M?=
 =?us-ascii?Q?uNIg779CujIcgfj+xkT3rASkHH1+3J9gtbCHbJYaoGHgYlxPwlcH43zmCX3N?=
 =?us-ascii?Q?+HP6BaBMAWzdLRiESV0xD++jRUn5XcZjmgyZcqeGXZXZiFswl3ycO9A1MXWE?=
 =?us-ascii?Q?mdToeGdSRTviT2sPYd3zV1rzwb9G8/pLX9BomhO8aQsbuCL6hdVjED/PdArF?=
 =?us-ascii?Q?BHJ5+5ReaEnA1n3YHCqtKyW6LQmty8CWcF6yA9KADNitmmRS4ChLXkQxAv00?=
 =?us-ascii?Q?8TpIItOxTSZbSzwZfEZpIO1hoCLeBG0P+pYk8bwNzWSdpCOHjAfu0qXUeBj7?=
 =?us-ascii?Q?ZAEtPICC9fUnxbO/o8DG1KjZj1scCkLOvz4iYX8pKCJsso38GWkypG0ncv3f?=
 =?us-ascii?Q?aQ/MqsVze9QhitZ0fMQfw9nQLwv0LKRvA6aDwsfSx6Nq4t5RovxH7Hs2R3YY?=
 =?us-ascii?Q?GUFUK1BCEIn2ecOpxZ1H4rIFSKnVYd4CfyYbgzsYssBwT0zY8iVTUnroWagW?=
 =?us-ascii?Q?qjABTONDMLdrTHs93As62MIPCAQ1OQcPnmIVJO6YMr84YePvOTES/5X+e94k?=
 =?us-ascii?Q?OqYBzrkJzFR5btSsAcT9o9JvKHuAUGjltOy7BocSxbihCQpxhknbbfZ9KJ99?=
 =?us-ascii?Q?t0uwYgPEgbImEjiq1RGJyCI3Vd6TaPytqNbkeujsfV4vuxJphIxA1PtbiEhA?=
 =?us-ascii?Q?RdRven1WWP4XHiHt1n1ZJ7BgJKlAvo+WP8upDPJ533zqHLrKxcImZqV6Jlub?=
 =?us-ascii?Q?EloMl8kZodcS74BKXFXZpYRGD+WDbTBvahldkfFH1c1WNT4eSbS4sXD6bXBE?=
 =?us-ascii?Q?gSwgGGzAjm1Ezu3J5Ta/VnDk1RPlecpbBByDVW/ZEPvIL9F+4mhgRt88xg24?=
 =?us-ascii?Q?X4n1wGrsT6msR3KO4bavNECd/874+BINP/FwdL72CALA1CGdm00gfexdVQXD?=
 =?us-ascii?Q?TZ46JBro1KSEBHLXd7QgI8xyR5l8/58g6OWlIQOOB5jVVFO7NDOfNtv4juzb?=
 =?us-ascii?Q?oNzYZ5w+ZUjd9hOHu6cZeLraioAbADxqBXuuwjljsQEkeha9O3nYSA02zQ5y?=
 =?us-ascii?Q?C4TYavSamlB94pdd9LuDRhT4g8cY46KyLgCmY+AhKDg39GrtXTccVrxUOkuQ?=
 =?us-ascii?Q?SGRfgAbK90N/8OV5R94RzhfwTIsbfvj6OVn68KN82CKHMlM00Z5j/cfY4h0k?=
 =?us-ascii?Q?yFDVIsZZcWb0qp+DZGJ/G4pvfp46Hhdl2CpgP0Rhe3BzlyIf4ui4xzpDN0hS?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PpYkklic4YvYnnPmVSU31hHOwE+hDLpm6A1ulwaDansKdOXtV89dvrlBFxySdIFxmk+jcR5LWOGycTx7RPn3VTtHwHHPwtoXz3g3minBn2iJn5aYOGznsteP7sHoA+/elB1R46WipuGjcMBF1loPEHV5lZaKI9wYIfy90kQSjS5fRAuU+WKEgaGnkmD+5ElGYUGRuz1VicOrmFULPsMNpXv5IGucov0udJeZrmMvWdbYTrmhnlQLo/a6LNhLwxhgSHNQQIQMEanTPC3kxkMZtcm38g78Vpl9VWrGZkrJNwI/YDDuzeGsNyhw9Mx7MWmy9w4QskL12TWIMr57Bxd63K9IjrYZWo6kh2zB6JkTcDnKzFDoSm6GfVNdK7cH2Qamd9NdZk4IaJeydGzmkGb3eGcfflfd3VJ5pqqhPPitLshtZKB763o9ND0XHJtaB6wYtdcR6GUuCVcixmCZuIx7gHzj3GW5CsdoeZ3MnsTYivWfpE86CJHHvHSa9DGFx/r0DLdZIYkmSyRncJb+PibBOKHs21lB6Mswec4W4q+z5wbYqvPpcYyVtJUdYhICIEOih2Z0S9O5ASP0t3s2YOExViZ3ZHPI12homyjX+8u0NuFQFTq8MlOQPFlNDeL+QW8YmXtf6Mw3iY/u/eTwe0E0qIm7Kr8jjsgwpCvJE3Gy+TfTaZnvMQ884Qz9aVlJg+9POM9uQgux2G3kEMCnwS4Afb93J7fQafNhRWTl4MpfHRLwNTSPmv1KJP4TifZ4K/UhfDSLHhkhGlnG15XC3zFSSiPFhQBqNWz3fZT06vUjIptwYvxnNhL5iSLjGG9+hDJzClj0PRlMsAoVWfED+EQLj3GOECjPLiX+fOXIU0tsD624furHzc1avurAEbTQMIJcGdhOiI7t7joi0gXXxKsjdQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f39d8e-4e3b-4a05-efb4-08db4d905033
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:02.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R4t20kWAoG6qYbvd5b0mvgc7tG4gPCq40uadAiIciscnErK5bb1v+02APAIyZhtG01UuyZ8IbWH5uMMAFZ8Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: LeDJOY7V9-E8eBVSuQ_fulIGXj7q1wGa
X-Proofpoint-ORIG-GUID: LeDJOY7V9-E8eBVSuQ_fulIGXj7q1wGa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using MT_WARN_ON() allows for the removal of if statements before
logging.  Using MAS_WARN_ON() will provide more information when issues
are encountered.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c3ce2bc594123..8fd83f21caf00 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5698,9 +5698,9 @@ void *mas_store(struct ma_state *mas, void *entry)
 
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
-	if (mas->index > mas->last)
+	if (MAS_WARN_ON(mas, mas->index > mas->last))
 		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
-	MT_BUG_ON(mas->tree, mas->index > mas->last);
+
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
 		return NULL;
@@ -6529,10 +6529,9 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	if (likely(entry)) {
 		*index = mas.last + 1;
 #ifdef CONFIG_DEBUG_MAPLE_TREE
-		if ((*index) && (*index) <= copy)
+		if (MT_WARN_ON(mt, (*index) && ((*index) <= copy)))
 			pr_err("index not increased! %lx <= %lx\n",
 			       *index, copy);
-		MT_BUG_ON(mt, (*index) && ((*index) <= copy));
 #endif
 	}
 
@@ -6678,7 +6677,7 @@ static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
 	max = mas->max;
 	mas->offset = 0;
 	while (likely(!ma_is_leaf(mt))) {
-		MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
+		MAS_WARN_ON(mas, mte_dead_node(mas->node));
 		slots = ma_slots(mn, mt);
 		entry = mas_slot(mas, slots, 0);
 		pivots = ma_pivots(mn, mt);
@@ -6689,7 +6688,7 @@ static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
 		mn = mas_mn(mas);
 		mt = mte_node_type(mas->node);
 	}
-	MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
+	MAS_WARN_ON(mas, mte_dead_node(mas->node));
 
 	mas->max = max;
 	slots = ma_slots(mn, mt);
@@ -7133,18 +7132,18 @@ static void mas_validate_limits(struct ma_state *mas)
 		if (prev_piv > piv) {
 			pr_err("%p[%u] piv %lu < prev_piv %lu\n",
 				mas_mn(mas), i, piv, prev_piv);
-			MT_BUG_ON(mas->tree, piv < prev_piv);
+			MAS_WARN_ON(mas, piv < prev_piv);
 		}
 
 		if (piv < mas->min) {
 			pr_err("%p[%u] %lu < %lu\n", mas_mn(mas), i,
 				piv, mas->min);
-			MT_BUG_ON(mas->tree, piv < mas->min);
+			MAS_WARN_ON(mas, piv < mas->min);
 		}
 		if (piv > mas->max) {
 			pr_err("%p[%u] %lu > %lu\n", mas_mn(mas), i,
 				piv, mas->max);
-			MT_BUG_ON(mas->tree, piv > mas->max);
+			MAS_WARN_ON(mas, piv > mas->max);
 		}
 		prev_piv = piv;
 		if (piv == mas->max)
@@ -7167,7 +7166,7 @@ static void mas_validate_limits(struct ma_state *mas)
 
 			pr_err("%p[%u] should not have piv %lu\n",
 			       mas_mn(mas), i, piv);
-			MT_BUG_ON(mas->tree, i < mt_pivots[type] - 1);
+			MAS_WARN_ON(mas, i < mt_pivots[type] - 1);
 		}
 	}
 }
@@ -7226,16 +7225,15 @@ void mt_validate(struct maple_tree *mt)
 
 	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
 	while (!mas_is_none(&mas)) {
-		MT_BUG_ON(mas.tree, mte_dead_node(mas.node));
+		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
 		if (!mte_is_root(mas.node)) {
 			end = mas_data_end(&mas);
-			if ((end < mt_min_slot_count(mas.node)) &&
-			    (mas.max != ULONG_MAX)) {
+			if (MAS_WARN_ON(&mas,
+					(end < mt_min_slot_count(mas.node)) &&
+					(mas.max != ULONG_MAX))) {
 				pr_err("Invalid size %u of %p\n", end,
-				mas_mn(&mas));
-				MT_BUG_ON(mas.tree, 1);
+				       mas_mn(&mas));
 			}
-
 		}
 		mas_validate_parent_slot(&mas);
 		mas_validate_child_slot(&mas);
-- 
2.39.2

