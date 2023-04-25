Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A926EE3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjDYOMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjDYOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:11:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0EC146DC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:11:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi9iF010199;
        Tue, 25 Apr 2023 14:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Aq7cOJYOEZDek1MKEt0M3X1mC65LkWTwAvUR2CCJKTo=;
 b=hcvXAqoSvHYwUqSMFTp8UWgNCvrTFL/0rZFjWx+3n4zG6LAHAA88bVWRW93RmfwcCdHi
 AzDZz0ev0KeR/HimqCFNlpc4NLQ1JX+lBxh2IfxFPwzLaDzyqWbWM40caf/qTfh31q3W
 KgXvbHGMCRn+5VqZ8+2eQOq/O5vcQAFo+JnG2QxahqHJiXscce+EAY2nFx71aw7zZAt+
 9MlCo0MUGTj1wAp5gx17KzLgQCJDlmYmMzegg/S2GqjXw6E+FAgTTYJEXBwqWKMKPI5m
 hiOH0jnjfUVU7QhKmDciR0TFL4tWWTc5HZB9dZYIFSXQE/nZtnuqlOurK+RymPUHxNUk hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476twdg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PD619K007429;
        Tue, 25 Apr 2023 14:10:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gdj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4yeBkz3Svhmnf+WmXBTeRv3tymTT2BwcVF7AZT95ox+XUHoX/7vtuWCaA5MQ8HWGPFwcfSkkKDbxIkWAHm5Hu2+rPPx9i5VE7BQmuonO6T1rb4k//FIQUF1cShZGw8bh0LKoaMu/dcNbgbhhAsMNJe0y5yLHKIs7cjNV2yzZd5o7+EZy4DzWR4D1CtcOc8QaWr96LQo20gVUhfe+qDbeRuZNbTc8m9JhyvRMlEQk/fzimRfKJZoN36J1SCIxT49vF/9vRXYwlJR3U1Rb5xQjpGoopfi4PbtI/2fbD2GTMdo3x4UMikrHRpg99DhTdbjJicDO0NgJTj8qDvAEJgQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq7cOJYOEZDek1MKEt0M3X1mC65LkWTwAvUR2CCJKTo=;
 b=CRGr5+ClLbKiB9oBFRjhdPL+KgifGvuySz+jKIW0bghzuBFZ//Uxy/G5maqKIsJighriraqjVKhJkMRjZxah6PWvgokYIzcuvo8R033D1vjm7It9ercyK/M8+sPplAirYtw2ZrWWdLdmRqE0vpi95wVPAJXyUPpF1pjATLMTM1JCRVjCsOjfihdbt9C5QFGB7J240Bj2S/VWn9zpBL2wnUeyHdDGgAseCJYmZz5Qkr4Tmw1RZ6Wk/HMefLVbJkczOyHwdoeFHneCc9P2Eowhsfaf2hhW43THIqHS7RksKo4SUV6v/hvHZ4idPGsh3OL1/qHj1vt6UJu7aO4VkQK8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq7cOJYOEZDek1MKEt0M3X1mC65LkWTwAvUR2CCJKTo=;
 b=FRoxXJSumon6F7I+Nw8dG/GWmcXnfnf7ozcpUZ+mkSXwM7PM38D9S26U4mDaLuy7qF4THdAphRJb3vLWYMpi/gFTIJH5nlCCHqKk7d8p0t4xiQiJS+DYMtg7ls/cyGpoO9K94ot/yxGH68XMaEcmaPlQsCGxWX1I/1b+XJBM/ec=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:10:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:55 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 15/34] maple_tree: Return error on mte_pivots() out of range
Date:   Tue, 25 Apr 2023 10:09:36 -0400
Message-Id: <20230425140955.3834476-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: a4385abd-aec8-41c7-db65-08db4596e268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/0TrPY4S4ia/9SpO525lh6BWPIFxOzHblePuj24VMKP47JAV7kv5C7EtlBR68jsTpX/nG+JUaOde3NZLrOkkoiMGbnHPnNjk7seARZnXIlcpvBui0MigPpdVmJatdX7EpbS57rbWtF9G7TlUGr8ld6nweOKaDUI3QfIjdofF+erkpOREmlc7UfiKZYNSH+J88VC+vgqi4v9Vnkocdb1kLq1avdIXeI7FnJXJ5DTZA5Wl0Owy3EdI6+C1bIV5sfwMck0UpDzY7TcUA0jqbi27evcgdn7+5QRozY7wQplkJQLWaJGYYKzxPY98B80ZtIvRl75h7G90vpqesqHFvoktUCeqBKiJ/ozWdnBFpRfcsrCynrzgrQPONXpAw5F5XRlIsFT01yaKAViaz6Q1dAxeGcUdVr2D3UVb18jk5JjmahaznbtujnCLtyy3sNuVvTr6Sl6QxLBoh1uiWnvQnWGA4fzVGgi0cOoIx4+uLTjC50lc6Vjb8tRXoRIv2F0Flc0wRki0vhNEFLQ5Lub3FL9g1dZKLBDPP7e1ACBvMvzMN4NETXgW03EMFJKLwWz3EYp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Wbi9j78pmU7kChc3u+U1S3Qmk+F1oASjQ57warXe2PhaZ/ccu3tLtaPMGRm?=
 =?us-ascii?Q?4fzc70/+DxgANuwo74UTYxBru8nawm0fQjL6rvJoWUzN8N82I8Gux6kZqpri?=
 =?us-ascii?Q?JqRZdwyT9KDrJJEr3DDlyo0vgS/BEfIFKYYtr4Udl2dKwiOTZ6O9SwUNSWOn?=
 =?us-ascii?Q?2gOguliiyhJHFZGOiEprdD6LomIGNDGclewcxA4W/K06bvnBT+En1Lnc5/+j?=
 =?us-ascii?Q?IlDnRKhQ/6Vxe5rlOwqsx4lBSeVDvExE0vcfPHfqSMjOKOsuC2z6FF3w9fpf?=
 =?us-ascii?Q?vfWJMJ/OeYq/yNKj/E6yb/SpTkgt+qJRLlXweKkKfw63QLTZIlEPu7roFQcB?=
 =?us-ascii?Q?5FxCo7Yx6Bh8vbgEUIOhLm8fyjn/O7SuW/2xpwjhrCXRxstxprIPJH05XWxO?=
 =?us-ascii?Q?lFRgMAVtxLFw1r27JjcLLQv7VvpnY+k6gpHcCJcFPX90HJ7NWJhfzEQk5Q0s?=
 =?us-ascii?Q?lh2iqyj1RcOc/ZlwwPoTkaw8EZrwt7OT5Vj2/nSP0tHO1jxcfruE/lCzEzAV?=
 =?us-ascii?Q?YKEZ3oBx3Hv7VWEVlF8O2FIgkEYscwxf5LFJw22n3f/FzWdlIbHoGyffwIuD?=
 =?us-ascii?Q?NSMe2XfmWTH7hm3rD3KlSXuA8CeRcw6eGf0arNPTo1l+x/DALKCyD38Nj+HH?=
 =?us-ascii?Q?atMIQfDq0+k3lMI/0ZsT9nv9v+wkHNGFJKTAvcG2PK3OJf8TYIX/2ZDT+/PS?=
 =?us-ascii?Q?JHPCzQ5U8hkDYwb4314m/9tB4UNCFx5JdYK2rHuTg2ySkGDMJnjzLKBgltQN?=
 =?us-ascii?Q?EZ05a5qC2InXiKpm1xsD2F71nnDVQJ/lpJHZ0Ii1VCWFjZulxiP2mZhCDrjT?=
 =?us-ascii?Q?SaFML6Q4R6bV4L7rpOe9Sb296+lquX2l3eBdlgpX1ozoaW4KFDh4LIdaV2F0?=
 =?us-ascii?Q?6lNB8ZYZNrGB7BQ5pLebe2bKhzwrAgtMgDgV2djnTuQJr5Gf09kdnta80mpj?=
 =?us-ascii?Q?UnIHGmWFQrVz4/JJCFd2pvv0nydwqjp1BRGrccfB2Yts4Zte6tvXePEwzE1F?=
 =?us-ascii?Q?8Li/sdkz+qutRHav2Kq20I//PdKklSVAMc63AZdcCoLZw+/bwRBIziqAgdsQ?=
 =?us-ascii?Q?Mi4bqLjfHR1SwWWjDB7ks3KvlWZYOdBYV3hUkh/PmTOkgyVRqF+plL6xssx9?=
 =?us-ascii?Q?AdJf/q+tSrKerz0G3f7sw5KH5R0ght9xaArPdoFuWl33qMYuDCFYfWN+9Lf5?=
 =?us-ascii?Q?YDaYQNG3TSR4r/qZ78Hw+92o9Nzkuj1K5q4SlamfAzNK6DhUi4/nwISdGx8s?=
 =?us-ascii?Q?hL2Uw2+vqU/lo/C4MKjbIm1Tsa5LeSadvVWh80rkB+9Ga9A8Oms+2TLyMz+X?=
 =?us-ascii?Q?Du9QmL7zV5PSitIeigJyrLX8J9FceUx41MncOD4yFzjDMGijm8pgWk6N5eok?=
 =?us-ascii?Q?klI20guenw8k/NZpiz/ZLGNORitniX45mzU3nL0XNEF3aXBgVW+8ZUUoGiQR?=
 =?us-ascii?Q?GnupxKygBh5SLJL3lsVQeB/25k6CqE/nt0dLGnrV4QACM/VgEmMn6JfXm/mM?=
 =?us-ascii?Q?vtbfSjwpiNjOI0zjWRRwDUUTi4rm05v9ZJvdpNX3bwzB328nOUMaDZ6DSybZ?=
 =?us-ascii?Q?78bvPpMhZm8qo4194JHCg+JETv5KSQp1OgIkB86K5iFAgd5mSDY+O92Kw7hl?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yIeYUt3zRoHLCKWcUCKcJoEUbsrlB6MaaJv0eq0FEBFymzc/7QgDMJKDhtXJ+JTqUiI6uONqpEtUVx4kw+E6Cigvai5qDUIdgFoYCg5NuXiryrFmhs1G6gzADHcZ9Jw2MSmQ46etjJUdlC2OsATUvhuHFFRYODqn2Kh8gUspRiEG54j12v/MV+jPKigV13I0A40f4gjm1VIkG4cW15Nfg7IDz6GfGPVerUUVvZvkUKOMw8W8sW8IAT3PAUvZ1Bm0bYWxWArET3SoouHugYhKsBHQ05r+vjSxc+fv4uePF2MUTCwd5/4vNs+NytNFdl8WhTRbxesak/wR6RnRT3Txc4AnkGHBJkJLYQxz/5isKlDXYLCaITs0vf4EoGXevMeFCiJNuzwaaYG1yEbuMHGlorkfgEg617DXUysWP7aOfCO95vPxqv8Y4PUEdowKpOWEpXRXYE+wiIMg2Ux3YbPaRX7KC3kpASS9giinGOswVp73cFL9HyHbhaoOUkfqfbL+ShVy+4qy3CyJPaKnfNHYrJKn3AU/oiQPGMmZSy6Q3hUTcZmRmfV1TlOFBpTw6wEnc6C2OirDSaqSYxwrZMfq0GPpkzV8zhBswHnynRf6Hkn5Y7AdUv7X5EQT8QS9l6m1I0Co+eCXvNLtu5HMEb/FgyuNNPI0yjEBg//pVeltBfH1yvnsCuQvfzlPzdnXtKvbVVcIMvg/EbtjKbP/QYhl9tYB4xn8cMhmEJjrc7JArP1Q6+H/uyQK867m87pndYgDrvR+bgNNcNQJMx+C9AyFVZ8qK5giIFb2w5Wgt6kogqyODHY/lPrKzxN6xFlLvXRo0ihrqGJ9O3B59Pt1PmmA2FqtzzfTnhwrZuXHhq2WOY8KE1CaminG4gO3fuY+WwV9uGiJFQQpHmPhQZywIW+Mgg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4385abd-aec8-41c7-db65-08db4596e268
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:54.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i6jh//QjStnlS4POgAajYLYiWojIJenShCs/yALIv0rDVSVo1vn7HiQiqDkFQ10j0gOwptjcX0WnhNL3Ti4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: FklFDom8mGTOD6g9MWzntqFDJ3R8RRwz
X-Proofpoint-ORIG-GUID: FklFDom8mGTOD6g9MWzntqFDJ3R8RRwz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename mte_pivots() to mas_pivots() and pass through the ma_state to set
the error code to -EIO when the offset is out of range for the node
type.  Change the WARN_ON() to MAS_WARN_ON() to log the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 41873d935cfa3..89e30462f8b62 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -663,22 +663,22 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
 }
 
 /*
- * mte_pivot() - Get the pivot at @piv of the maple encoded node.
- * @mn: The maple encoded node.
+ * mas_pivot() - Get the pivot at @piv of the maple encoded node.
+ * @mas: The maple state.
  * @piv: The pivot.
  *
  * Return: the pivot at @piv of @mn.
  */
-static inline unsigned long mte_pivot(const struct maple_enode *mn,
-				 unsigned char piv)
+static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
 {
-	struct maple_node *node = mte_to_node(mn);
-	enum maple_type type = mte_node_type(mn);
+	struct maple_node *node = mas_mn(mas);
+	enum maple_type type = mte_node_type(mas->node);
 
-	if (piv >= mt_pivots[type]) {
-		WARN_ON(1);
+	if (MAS_WARN_ON(mas, piv >= mt_pivots[type])) {
+		mas_set_err(mas, -EIO);
 		return 0;
 	}
+
 	switch (type) {
 	case maple_arange_64:
 		return node->ma64.pivot[piv];
@@ -5400,8 +5400,8 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
 			return xa_err(mas->node);
 
 		if (!mas->index)
-			return mte_pivot(mas->node, 0);
-		return mte_pivot(mas->node, 1);
+			return mas_pivot(mas, 0);
+		return mas_pivot(mas, 1);
 	}
 
 	/* Must be walking a tree. */
@@ -5418,7 +5418,10 @@ static inline int mas_alloc(struct ma_state *mas, void *entry,
 	 */
 	min = mas->min;
 	if (mas->offset)
-		min = mte_pivot(mas->node, mas->offset - 1) + 1;
+		min = mas_pivot(mas, mas->offset - 1) + 1;
+
+	if (mas_is_err(mas))
+		return xa_err(mas->node);
 
 	if (mas->index < min)
 		mas->index = min;
-- 
2.39.2

