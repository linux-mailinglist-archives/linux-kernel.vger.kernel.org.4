Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662906F8928
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjEES7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjEES7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:59:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1639020771
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:59:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhJ54028052;
        Fri, 5 May 2023 17:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+txu4aLGOrwMbxOMzM/5NFwUsTgankdKbz+bA1PibVU=;
 b=V8ZsqSE/xeFjFdKINWlWAgZhAQpS2i2R7NlUIH4ZKTJCtJCL0H4u3UBnhghbRwo87fZp
 WhAES5jev7Bc5j4Z2UBrxcpL0PsL13ODu4vlrGPkg2zWgZvnFpJ5dPJcHHfX/RaZJcR2
 Y62Y9zj8b28NWNBW6oUuU46VS02wgDUbc4QXCYy8olGPTp7IlQVxzEKT7nmcRRRAEcaJ
 hkfktcfn500JlQDQgXnQ3LuhB3wBHOl66+teas5FHvHf3areEtFZ1J2BtGEKWOkXg4CC
 /ir+qciX9oou2W/TdBqRmqre+ywDpZJthqGzNVFpLBlE/A6+MSyZ8VDgyD92wd0aF7eu yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t145jdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HHB3k010067;
        Fri, 5 May 2023 17:44:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spankgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+ubKNX57T+5BCzxeTvi7VgOHF+hx6HGerxOgOBGQ1H+AmMoa4Xw4IhR/Kbx/P966w9o5Xack2cfbeDbSGnNv+RRiS9Mr25DvrpLTRO0CY5L+sxM0A8qqq9vQo9DGhvc1K1Jw45LFSJY7ssaY53ZLj6oVscJ0L6WyVD9xkfa4Z+tOP87JavIfYFcLkg834fst3Pyd0eLTC6ge7vXtOFunbPsFPaNdlwisRn1Gx5fG1ot8NDDgh5uCfpNkdnd7EXKNylpCevyMNR7Q0/Mf5Oq233VLd+U92k6MMPD8Cf6QBpQv4OMvzZO27GjVVQL3aR69k0V23eJy6Kjmqe3piqhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+txu4aLGOrwMbxOMzM/5NFwUsTgankdKbz+bA1PibVU=;
 b=JB3oymGN1N+zobcYIxklVPingSM+4maGImCVAoSAP3q0B7XGfSBTqKpMvOl1sJVSRHqfKT7SyMOpZp+vU+HzR3j+id+oQR2GqUOzD951miSAfbND0wGW0NENE+PYvjSPhm2c649gk7tBuCR5h98adFKJiCyIFzR7xycBpolMvWTkc6befm72rgRg+rwfvsPzgPYmW7ERR6EVeCVgQP+3XEG/LwXAu/lNq65zisp27i3mnZtBLxcN172KL8tjgo5Wo6HBLCQ03bfOHpwsvJUjmcDnYoF4MBT26pqU8va2f7WGJ83KWclH5Vp9ICbaL1A8ctUBUazJzQRsr1drTMuwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+txu4aLGOrwMbxOMzM/5NFwUsTgankdKbz+bA1PibVU=;
 b=t7Aeeo54fCw58VnVfD3pRX4wPG4LE1BRhni0CCD8ezRnUmB1YVCkyrPejbjSOZ1xWpsLbt+gP6t+4oM3iuWghGibZGfg6kRf++uHnrbcV8s7rUMYDherRzOi+9/j5N7Xpv+XSFNJRma1oxGKcCboM19O0HoYpew/ym8WgXF+r1A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:45 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 27/36] maple_tree: Introduce mas_next_slot() interface
Date:   Fri,  5 May 2023 13:41:55 -0400
Message-Id: <20230505174204.2665599-28-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0015.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9f9224-8c17-4abe-2239-08db4d906a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLZ/9o76tPqKRvQWfy5JcPzI+QEV3ov6VPyNvLsl6+xpIJ0LfBn+pNEWDMquRvm2fp0BDguUSswgFO1Mqr92IFo2+RIUxJHNKXKB3emu/SFXmyRX9F6zKRsacMN0W5vuQ/0YmOBb2j6mhcABEKuab6tN4hnIcKVlE/X9CGNoDL6GcbSEJ6OFOZ+oVbDZdncCR7stSqmPD66mCPz8un6qULNnqnUAArHzmIV/cky/J1mEvnZIR9/API73zrZDuG1f7tF3gj6O2ipDTYJgpcD6bcp5RQ3n+QlvbGc539Yr7ysovxRjAaDRujiZ0Nbb+ErlJjrMqYlUqPx4QEyfJtV8omccx4hKlMfLUKi8sW/9bV6ZUgWTdnO391iNjlwUk0MOozzf04yAOWr4DnpchIvmmEKj9LXs1di+ks979FaCxUaLz0+yPNoLMMEElKryC5eBBJdHzzu0ea0NHMpTxQ9ZdfBxgqCglJnBH3ZwXqDt5ydWCyVfvkIwUp3uQjQmokft6KFZ9KOsaq3Ss7UQxMcJhrFPdXA1zEFbb7WDRbLwpQ+mbveQkrb6WepsB+IQf2S7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6666004)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GfuzXrrycQ5Nj279/3efyJr2J0JUtW/HH1DSZsK2K5s2fqPfhCOA4cyaEpC1?=
 =?us-ascii?Q?vkLOKtGNu7iFMVxzuX8SrGW5E2Jt+2C6k6vhOwUJ5WPxjLl+r4p/omLFGxCe?=
 =?us-ascii?Q?bbiaTvY891gAAbFQBpz+9A064jhU2hpaktk5BXzDR7ALMrl0JJ4rWucB7Iun?=
 =?us-ascii?Q?k6pW6EWTUL36Y+4R6/EXPvlfPb75YdmqAOKHUERXdYMD0ToKy/J6ulT3Y23p?=
 =?us-ascii?Q?hYMmYnMopnZd64OqT4rG3iPS55oAQWuShB+sO512nYhD8SKSybozkvoQ3/6t?=
 =?us-ascii?Q?RXFb8CS9IDkvfvJN1/OXCMyd0p/iGNMwmQLBKWoWvrHAh0fXmZCCTZH7wGbj?=
 =?us-ascii?Q?7oDHwfqv4hcGNF5A3FOIMLFKOnJua3fCDC3KM+TEOagOQtR1ZpTXoTiRcXG3?=
 =?us-ascii?Q?hLUL6R2AnZMojqWfuH2/qeVsVDaY5lbAx/qW9eyshfOpuOkVSy5fx5DrniRX?=
 =?us-ascii?Q?I2l0imhI4ImiKa//bKRPkKXfBznuh1lBGI1we1TFZG3FZ+99hDtTfvE74kvw?=
 =?us-ascii?Q?s1GQVtz+R4NpwRYtBXyZnDT33uV/m7X8drFn3Ld1sAmvUoV8zkVQ3t5BZhLY?=
 =?us-ascii?Q?1QypR66kTl0Tcdq6MTZgGTnDjCrx6eT63MGQ2ENLJdRfaUs2BMfH8hJ4e7BQ?=
 =?us-ascii?Q?tFUiEmVaHarZkENNqNJwHzlpJd27TgsgIBIJSKWScBLILbVV7sRYU7jGbgWr?=
 =?us-ascii?Q?izi1nQlVCQ2MQ3Tht5F3jHS+x2olqHxhfrXDgP5xzBZ/aRGae8QtLghH1FUO?=
 =?us-ascii?Q?HEit8lUr8JqDCkhk+4l1Q3DIvOWd9QHHM+b91noKyJTJHI+bvbjpYncElV2O?=
 =?us-ascii?Q?MWzXyPGApNK59kUdnl0BNnvw5f4o64BjdfAFz0Oh8Geb7iziTRdWUzeE7iIm?=
 =?us-ascii?Q?MjlVVMF00xmhDhvT2/cZRcAay8rAqbwZdXcDxGwxviTfxtQMFPdwpyQn/+V3?=
 =?us-ascii?Q?SSJCf9Suoq2mBFwI1DcyQjTqMuNq7GfgsEFPsymh6YqNLQmO0WZl3OEL66hO?=
 =?us-ascii?Q?Vq3mnpvJlPT+/gTKkiUaEDKepMOpbABYlL42ptqDpsMPkLunpNFVmrZhoIBO?=
 =?us-ascii?Q?pM+lOvlUW0IX2/ImOIIIxdn8LTSlu4kQorc5q7WzGOrdpIB2oVGgOdOZJBk+?=
 =?us-ascii?Q?ytV8im0MXuDjO5sU+EWXeiJR7UU3pLlcHnD7gvCeTKhFShEaR6QxbneMkgln?=
 =?us-ascii?Q?Mu9Qvdn9K20k/ZtgEgp/baKwBiOEue/+LJrI/q37CdMRAJynP0Bn+XUPVNcy?=
 =?us-ascii?Q?EWuWukxoEIBMd/DOcxkJ702kyuZDEHFM8j0kUf0oLJ5OO83GeRDFail91SAn?=
 =?us-ascii?Q?QXUwFwveCkMbxQs2ATdzUXMlxuLY1B4o0m5jApO1/JwAZE65QlkJlPEjyXky?=
 =?us-ascii?Q?MHiAbx5vmPbT8VUNaQERiXoYuuIhkksPlLCIoR1yjCvfpm2f4S1CcKCRCh9E?=
 =?us-ascii?Q?AbiiCgIdRQ208jbcU03Q5iBpT+XtPUAtV+lndLHg06w3WTiWmpU2U/2YeWQs?=
 =?us-ascii?Q?97Zjw6y8OozBjNvvTt9wtsRkrRj3sk1qFa8TfBkHMqHpV7zV9oU+Ja7S7KO3?=
 =?us-ascii?Q?xoYWcTHft14OqQX0v/uNBjp02sWNDKLX/y1C8T2jsu+Na03hBpq/o5VcAK1P?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: olMwoJo++1Zus+6lrD5oeh/WLyQ4Mi8DjR9OqVxMUu6NaIBUYtyPQ+yAeibQ47KO3BQQ+kGwLBLb7XELo0tQFJacoWxdu2py+630p6RFfzZuRg5ztkhvcg243XJH0q9PDeDiatUajmVkCWmec3UXGJnZs6NL0NwKXOLAsywRBmLvkeZgtcU+6b/ZcRA87ND83/NvRgIsZxgysOLqBixyHYRAMIj1kpL/DnJN/nWYrQKCBvS3kuf73ZwsOaszbLGLQHAueYpXSBoSvNqZu2CvwzAy3GY7Q9eFbd8w3WOw1x26EgbCQKN6ssdwzQosmig9/Rd9qwcHnYlglyVyIQfHx8xCaz/oVwiVfdHWl/pPSoU2xe+A1z7mEzEyughS7D9gj8UCmeKII0cg8kHxTz+k/rlA4XleAQGnQN1MyDjJdwQvd+7eTMgZMvgJONP28rBXf77ecWQ7dasmsuqya8P+iKgMi12OrbjLMv4Sty9gruvIMnxhUmk4puVgqizDoD++cBVF+YOqwoCR2XJVamkw5S+V8pYMS09nNm7Ysj7+pKDLFok+MqS42Q2vcWCBCsAAiJ07yPMZlMYjuE1obpMLfsfmatKQwXZHOnNyyI5O+5BapmKq7umlQh1aKpsZN87tDtarYo+hNrGeOovltupmae/20/hnZ3rYjuGMG611xN31pTj3sAZnkihybKS3yqQs76iie4CBF7y/jXkhXkZHCReRqqDu6BprtftBxRv2HmBTXIFvSdEXaj9J7fsbVCOZUjWj74FW4gCKVxTOlgcTllwaxegW2FkNESi3D1vT3DzZqwOWxWe6DWBw8yblGSuZ++q1skWbPSPgxh+AR4mAZWWBFsrsl8/D2xVVGnat7xH1ypElpqijU3+7q1bGwgz45h9PVSmJao4xQ/w6v5a+Hw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9f9224-8c17-4abe-2239-08db4d906a53
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:45.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMj97Mk6gPbZIcOl1Vmg9f+KX2OALH9hce/9j881fh+aVG8/y6wPVNUwZvLE1mIroZHLbijz5WFhrYUDrurlGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: blwy_-bJFhjaxedRoFC554zuFZlAzhPQ
X-Proofpoint-ORIG-GUID: blwy_-bJFhjaxedRoFC554zuFZlAzhPQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, during a tree walk, the user needs the next slot regardless
of if it is empty or not.  Add an interface to get the next slot.

Since there are no consecutive NULLs allowed in the tree, the mas_next()
function can only advance two slots at most.  So use the new
mas_next_slot() interface to align both implementations.  Use this
method for mas_find() as well.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 229 +++++++++++++++++++++--------------------------
 1 file changed, 104 insertions(+), 125 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 580310741d892..2865a987bc559 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4606,11 +4606,10 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 				unsigned long max)
 {
-	unsigned long min, pivot;
+	unsigned long min;
 	unsigned long *pivots;
 	struct maple_enode *enode;
 	int level = 0;
-	unsigned char offset;
 	unsigned char node_end;
 	enum maple_type mt;
 	void __rcu **slots;
@@ -4618,19 +4617,16 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	if (mas->max >= max)
 		goto no_entry;
 
+	min = mas->max + 1;
 	level = 0;
 	do {
 		if (ma_is_root(node))
 			goto no_entry;
 
-		min = mas->max + 1;
-		if (min > max)
-			goto no_entry;
-
+		/* Walk up. */
 		if (unlikely(mas_ascend(mas)))
 			return 1;
 
-		offset = mas->offset;
 		level++;
 		node = mas_mn(mas);
 		mt = mte_node_type(mas->node);
@@ -4639,36 +4635,37 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 		if (unlikely(ma_dead_node(node)))
 			return 1;
 
-	} while (unlikely(offset == node_end));
+	} while (unlikely(mas->offset == node_end));
 
 	slots = ma_slots(node, mt);
-	pivot = mas_safe_pivot(mas, pivots, ++offset, mt);
-	while (unlikely(level > 1)) {
-		/* Descend, if necessary */
-		enode = mas_slot(mas, slots, offset);
-		if (unlikely(ma_dead_node(node)))
-			return 1;
+	mas->offset++;
+	enode = mas_slot(mas, slots, mas->offset);
+	if (unlikely(ma_dead_node(node)))
+		return 1;
 
-		mas->node = enode;
+	if (level > 1)
+		mas->offset = 0;
+
+	while (unlikely(level > 1)) {
 		level--;
+		mas->node = enode;
 		node = mas_mn(mas);
 		mt = mte_node_type(mas->node);
 		slots = ma_slots(node, mt);
-		pivots = ma_pivots(node, mt);
+		enode = mas_slot(mas, slots, 0);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
-
-		offset = 0;
-		pivot = pivots[0];
 	}
 
-	enode = mas_slot(mas, slots, offset);
+	if (!mas->offset)
+		pivots = ma_pivots(node, mt);
+
+	mas->max = mas_safe_pivot(mas, pivots, mas->offset, mt);
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
 	mas->node = enode;
 	mas->min = min;
-	mas->max = pivot;
 	return 0;
 
 no_entry:
@@ -4679,83 +4676,106 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	return 0;
 }
 
+static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
+{
+retry:
+	mas_set(mas, index);
+	mas_state_walk(mas);
+	if (mas_is_start(mas))
+		goto retry;
+}
+
+static inline bool mas_rewalk_if_dead(struct ma_state *mas,
+		struct maple_node *node, const unsigned long index)
+{
+	if (unlikely(ma_dead_node(node))) {
+		mas_rewalk(mas, index);
+		return true;
+	}
+	return false;
+}
+
 /*
- * mas_next_nentry() - Get the next node entry
- * @mas: The maple state
- * @max: The maximum value to check
- * @*range_start: Pointer to store the start of the range.
+ * mas_next_slot() - Get the entry in the next slot
  *
- * Sets @mas->offset to the offset of the next node entry, @mas->last to the
- * pivot of the entry.
+ * @mas: The maple state
+ * @max: The maximum starting range
+ * @empty: Can be empty
  *
- * Return: The next entry, %NULL otherwise
+ * Return: The entry in the next slot which is possibly NULL
  */
-static inline void *mas_next_nentry(struct ma_state *mas,
-	    struct maple_node *node, unsigned long max, enum maple_type type)
+void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 {
-	unsigned char count;
-	unsigned long pivot;
-	unsigned long *pivots;
 	void __rcu **slots;
+	unsigned long *pivots;
+	unsigned long pivot;
+	enum maple_type type;
+	struct maple_node *node;
+	unsigned char data_end;
+	unsigned long save_point = mas->last;
 	void *entry;
 
-	if (mas->last == mas->max) {
-		mas->index = mas->max;
-		return NULL;
-	}
-
-	slots = ma_slots(node, type);
+retry:
+	node = mas_mn(mas);
+	type = mte_node_type(mas->node);
 	pivots = ma_pivots(node, type);
-	count = ma_data_end(node, type, pivots, mas->max);
-	if (unlikely(ma_dead_node(node)))
-		return NULL;
-
-	mas->index = mas_safe_min(mas, pivots, mas->offset);
-	if (unlikely(ma_dead_node(node)))
-		return NULL;
-
-	if (mas->index > max)
-		return NULL;
-
-	if (mas->offset > count)
-		return NULL;
+	data_end = ma_data_end(node, type, pivots, mas->max);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
 
-	while (mas->offset < count) {
-		pivot = pivots[mas->offset];
-		entry = mas_slot(mas, slots, mas->offset);
-		if (ma_dead_node(node))
-			return NULL;
+again:
+	if (mas->max >= max) {
+		if (likely(mas->offset < data_end))
+			pivot = pivots[mas->offset];
+		else
+			return NULL; /* must be mas->max */
 
-		mas->last = pivot;
-		if (entry)
-			return entry;
+		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+			goto retry;
 
 		if (pivot >= max)
 			return NULL;
+	}
 
-		if (pivot >= mas->max)
+	if (likely(mas->offset < data_end)) {
+		mas->index = pivots[mas->offset] + 1;
+		mas->offset++;
+		if (likely(mas->offset < data_end))
+			mas->last = pivots[mas->offset];
+		else
+			mas->last = mas->max;
+	} else  {
+		if (mas_next_node(mas, node, max)) {
+			mas_rewalk(mas, save_point);
+			goto retry;
+		}
+
+		if (mas_is_none(mas))
 			return NULL;
 
-		mas->index = pivot + 1;
-		mas->offset++;
+		mas->offset = 0;
+		mas->index = mas->min;
+		node = mas_mn(mas);
+		type = mte_node_type(mas->node);
+		pivots = ma_pivots(node, type);
+		mas->last = pivots[0];
 	}
 
-	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
-	entry = mas_slot(mas, slots, mas->offset);
-	if (ma_dead_node(node))
-		return NULL;
+	slots = ma_slots(node, type);
+	entry = mt_slot(mas->tree, slots, mas->offset);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
 
-	mas->last = pivot;
-	return entry;
-}
+	if (entry)
+		return entry;
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
-{
-retry:
-	mas_set(mas, index);
-	mas_state_walk(mas);
-	if (mas_is_start(mas))
-		goto retry;
+	if (!empty) {
+		if (!mas->offset)
+			data_end = 2;
+		goto again;
+	}
+
+	return entry;
 }
 
 /*
@@ -4773,47 +4793,12 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
 	void *entry = NULL;
-	struct maple_node *node;
-	unsigned long last;
-	enum maple_type mt;
 
 	if (mas->last >= limit)
 		return NULL;
 
-	last = mas->last;
-retry:
-	node = mas_mn(mas);
-	mt = mte_node_type(mas->node);
-	mas->offset++;
-	if (unlikely(mas->offset >= mt_slots[mt])) {
-		mas->offset = mt_slots[mt] - 1;
-		goto next_node;
-	}
-
-	while (!mas_is_none(mas)) {
-		entry = mas_next_nentry(mas, node, limit, mt);
-		if (unlikely(ma_dead_node(node))) {
-			mas_rewalk(mas, last);
-			goto retry;
-		}
-
-		if (likely(entry))
-			return entry;
-
-		if (unlikely((mas->last >= limit)))
-			return NULL;
-
-next_node:
-		if (unlikely(mas_next_node(mas, node, limit))) {
-			mas_rewalk(mas, last);
-			goto retry;
-		}
-		mas->offset = 0;
-		node = mas_mn(mas);
-		mt = mte_node_type(mas->node);
-	}
-
-	return NULL;
+	entry = mas_next_slot(mas, limit, false);
+	return entry;
 }
 
 /*
@@ -4844,10 +4829,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 	slots = ma_slots(mn, mt);
 	pivots = ma_pivots(mn, mt);
 	count = ma_data_end(mn, mt, pivots, mas->max);
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	offset = mas->offset - 1;
 	if (offset >= mt_slots[mt])
@@ -4860,10 +4843,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 		pivot = pivots[offset];
 	}
 
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	while (offset && !mas_slot(mas, slots, offset)) {
 		pivot = pivots[--offset];
@@ -4880,10 +4861,8 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 
 	min = mas_safe_min(mas, pivots, offset);
 	entry = mas_slot(mas, slots, offset);
-	if (unlikely(ma_dead_node(mn))) {
-		mas_rewalk(mas, index);
+	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
 		goto retry;
-	}
 
 	mas->offset = offset;
 	mas->last = pivot;
@@ -6108,8 +6087,8 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 	if (mas->index == max)
 		return NULL;
 
-	/* Retries on dead nodes handled by mas_next_entry */
-	return mas_next_entry(mas, max);
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max, false);
 
 ptr_out_of_range:
 	mas->node = MAS_NONE;
-- 
2.39.2

