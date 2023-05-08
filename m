Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5D6FA1BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjEHH7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjEHH6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:58:54 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD349032;
        Mon,  8 May 2023 00:58:53 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3487QqkJ011998;
        Mon, 8 May 2023 00:58:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=DmrSAZVuHCrey5O9Rq+tNpzQRHC2Zw3e+d3VCs5pbDo=;
 b=cLvvNuzg7jNEPwNenU3editDx5EgSk7G0FY6/WCgQCkGzMnP3jUOp9ShkHQJgJkVDWDi
 1WFfY3aHRJuUlgjwEpXq5KWqxM4ErDZ7uA+rDCk6uZfBZ8j1GE4J6SQAhYj63B5NY0Bn
 s45FgpWFCDezT5+8AnpMlcxUUc1cj4pD3cCKNJeQINL4ZhLbEIzv/1u76vz4Rq2Z5MxH
 g9PxXmudfM6hs4fsbpVtTHCvt91mI+t1JVo3IdR2VnVhb4gusEdDjQo+x1xxUiIWP7Y0
 cEx2IwG5b/N38a+KwY/RVa8kfIAndP9pXcQk2F5dzHh64IKCHL0v/K4vqF2E0B0m8J+o 2w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qdpe43n4a-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 00:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KejND6DM+9CfB7fzDLjvZFanYgtWCukipCy69HU9HubAcAFLKuSszzLONwqa+B2/Ldcv1it9feyGkxDyy1hUC1p+ca7c3NYmCtu54MpXQpy3AT3RDKbAkue/xM6jVxYoyVDc+ijy2l40GEHbcx6WZwecIOGTUpNVOySTDdX6WGkNtbzF02nFu90vDyq68DeQszRXy+GTJkJjPpQwDfU6G7tq6uwpHGWRFJtVhCp9lsI8rXaLuvFf+MPC+6N1FR3HPhzsKP+5p6O9czmEIRYQasjcJmL5Msvq5WEJThuq4fr6zz1RcDfNpltFMYo3TM8FX0h+H6h5DaljozZejqYKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmrSAZVuHCrey5O9Rq+tNpzQRHC2Zw3e+d3VCs5pbDo=;
 b=SiYM5ITnTPT7wDwZkuMSuc2yxkd5lwJFlH3vs8NC/MhehoB38QxTMQ/+nJPlPPDdEwGtNc4dqvi36jbcgKw+V56NPFo1a4Dx/jv86zViseQ/N8Mfn7G2TqNIpda7wUsvORkkLphqBEMiKnhf02dqZGsn2sQ/ZGXrANT0Th+cQs/jZKIIUE6ZiivhTSEntXCxWqxBObV72tjEDLGfUfUn7Yi/t5AJsrmXEfTIInCAl1MHm/k8KyNEBn5m2L4kxfgwyfpQoyvRnG73trRqsbktDVfR96CjUEht25I8YRoVwMZywykA1urYRpW1Yaz4GJxYnqTFygjlzNLVnoOvklmUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmrSAZVuHCrey5O9Rq+tNpzQRHC2Zw3e+d3VCs5pbDo=;
 b=KJ2DE0w/ZpVjazLgnLMYLygCrseNt7gbH5IdFLHHIC5lfgVsOkKFH+EdJ2XogipXhErZvv7yLoh8eLqc1i2oIBJToF62ryXEtzsV97K+rYxQDnR++umkV9tCa8/EmmEnOn/5VKttt72M4F+G/iBC/dEvpWPbyRZz1pM+TTt1GaJL5CF5/2+5JkuPo366d7s4npHlYAr9hOLa7Ym0CkHAmtv3C10SJUsH5795d4AHYKe1e255t1pi2r7uwZKh4uvvrv8OfzC506vQOKBMu6DoafKLd5H+3awyeF40FDZufj91RwocTrRE9PyEJijMEoTJ/Oy+CyDLlY1N3ZjRtGnkYg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SN4PR0201MB8821.namprd02.prod.outlook.com (2603:10b6:806:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:58:48 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:58:48 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH 3/4] audit: convert DECLARE_WAITQUEUE to DEFINE_WAIT
Date:   Mon,  8 May 2023 07:58:11 +0000
Message-Id: <20230508075812.76077-4-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|SN4PR0201MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e69b35-74e3-4ca7-316b-08db4f9a0ded
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zs0t/0FuCF40wN+wHd4Hpj6WJRO1jjJapxBIoNotUS/PXl+scB+DqKs9eciPFTURQWt0aaq+ZW87EmaUaLqCOYMM0Qa8EBinrP07UxnhQk90w6ixwPIfvRCHJXgCelL3iGeRr7kENdIVS0OioiVJcPL3WbFpjakoq6WhfvaXw+FY1uf+WU/afLlMUN3FxlRAtrv/rX5uIfgPfL+Q0g6Tx2qOE1/plllotDsHWMe/ZzV/+MjYHNSA0ZGYwn+EPtKcCRbFHJ8wyo/3T5Vs8UE/XMA3TBm0q4bm9dRgGDVVKrh/8Zcy0vqiIrOUW6DBa+TDVDD6QiSNnoTxcC27esfc3WgdRK7FPiOIJoZe0Bxd7OynXmoP68M45OUAyeXkOlwcuP+Tl//bWpGG8JcOuu0W6LPmASPIFeeqNEXMTQUyJjvLkjsnF6bGHzw5kgwWZNBXHrUusGJqway4G3yN4BtOxr19sdTY8dZ6uNI+HenwiaukenmJiuEfVLfl80+CNdibtBsTuQlCm50vBs3Z79+sn9hmwxT4Bn361GFvsOZ+jKTukqAdKcaXjdk7kKgDYO0HuESWzWFYgoJkNtICOh8I1D3mMkLKQiCjPQyHh0Ic/qmVrSM9gco/9HfC3tVJy+o1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(52116002)(66946007)(66476007)(4326008)(478600001)(316002)(6486002)(86362001)(36756003)(66556008)(83380400001)(107886003)(2616005)(6512007)(6506007)(1076003)(26005)(6666004)(8676002)(8936002)(5660300002)(44832011)(41300700001)(4744005)(2906002)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikb7DKkH/ItqWdIVAXVIJkF6ZybSo7DPP6bU1tUWdJJs5/Bd9o0QxhR40iut?=
 =?us-ascii?Q?uTtbAjvZ6FsBJ8O6fkgyqW19dTifqEmUcIbKJgZyUz0E4Ja79hfllFxRmyM1?=
 =?us-ascii?Q?3YC94TrQE2YJhA/2waXt21PT0BZHG+XuNM4/n/kJbrn+eyeOhl2IKubo6bEB?=
 =?us-ascii?Q?ZfPciwBOEy2uAICxEPzhXNrJ+//IbMXzpJqI2DB5FSZh4uilaDUaqCMJRWCX?=
 =?us-ascii?Q?G8JLFXBdPCWswPLbY7aqz3FI1Ak4CTFZh1D8ImkzPDaFMIypA6w7MyfzNybE?=
 =?us-ascii?Q?+kTfY9y1Q8vkt6gjXJhLSgH3+2QUYBgCJnKoOjX0b3+CQDsCgzaCaEoBrHkQ?=
 =?us-ascii?Q?ju4txECRhQg3etjGct8WHTW04wE14gvdUWlw+NQF6dbBG9HF/aav/o3o2PLe?=
 =?us-ascii?Q?aPZXLWtgzSnr2cEdl3CqTN2o4agb1WBHoigrz/zEi9uAmj7RO+uSQJRguNVT?=
 =?us-ascii?Q?/EQrgpGw2Z7qyb3UGPbsuZgLhplPgXVK0L0/ML9AyE46l5Q5ygF4c2ZeL8Jo?=
 =?us-ascii?Q?sXm2EGONgNKfsQEc9zahLCo+fb7mIwzR6JJP8FYx1YSyxr4qEJ2AMFP1GTvN?=
 =?us-ascii?Q?RfM+yOMZddRi7eg7zCrqJ1fd7KCqbEHyp8xmlDs36ouk5w2G8fbw/RtXdaDc?=
 =?us-ascii?Q?YdFKJpKhu+F7CkhDTv7OSIX6CO4u381uRO8msKmlhVRZFQw4LuRzTSQ8JGDL?=
 =?us-ascii?Q?gzuSZrzgNe748/aH4VFuhwhqymdnDEMfJ49+I1YkkVAlBPpfcBGP3mKpMdxg?=
 =?us-ascii?Q?uKhhUa34PQfhhdCa1tuf9E8dC/6FQJmL32lMR5MhzPKmoWHcBoDTiniu5jSy?=
 =?us-ascii?Q?AC+mKvAqN/o+fgdqwpTH8FMPMYfki8PpfkndqbvDFOCEWZ60858TQkxxlDSh?=
 =?us-ascii?Q?xwPTCFO0eo+vXdFfv4cLa/vnnjGmfqhGVpoqjFG4CXDtlFEE5bTJqeFp+4Yf?=
 =?us-ascii?Q?V9ciSfiAHjkzT0Rlu2YFYnvB0chFuqI2dk79U7QsyTHeeMXlaoYtGcx4opoF?=
 =?us-ascii?Q?cmDJK5y+d0I3BZHbdJEZQ/u+lM01axYbgfwqpB0an/pFOD5+R4zoCYUG9/1a?=
 =?us-ascii?Q?JTqkeh7/XgYoq3OVcRmtC7KlvbvPevlJ/JuF37AKm+pCYCRk/+i+TTdETUnL?=
 =?us-ascii?Q?tBvZrPr/HJz7GuPTDPFuVpwAWlWlMXwPrlz7HQBqJlQieInz4ICPLxGwHsJ0?=
 =?us-ascii?Q?CG75ZLOnzD6Uly83VgOr2TdhtkfsuL5Ey6431s/u6u4V97rGvRUzbNeYgdcy?=
 =?us-ascii?Q?k0rwHgVcbeLhaPOspJV1u2arSumPBY8J0QlCUp5h77ayeCpMsaOZezaHKY0J?=
 =?us-ascii?Q?gyTKs7vri6SKfMia3lDMjD6qetcG5iuQhW65Iujh9sp/iHqTqI9FLCcqfc0W?=
 =?us-ascii?Q?EzXNhG+UI2xqL/XqTLhoUF/4QRJoPxkDPojTI0ofwWYaa30T485GczbiN9+6?=
 =?us-ascii?Q?Hgyi1+p1SALblV22DXxKRE5Xbh4TC8jpPJjuwszyVtSSjJB2W7tNu8GOxTH1?=
 =?us-ascii?Q?giPpFgPXYF+cKOHPQE8CyeWxAEOwF8a9V6qIZ2aLNbLcv1JIF/YBo8Gi3Er5?=
 =?us-ascii?Q?hZLwxHQ6cqZxQFhJAn4RYbWs0PyEmq/Z9K84hV6DrfykF3Mv1XpHawjkuBL5?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e69b35-74e3-4ca7-316b-08db4f9a0ded
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 07:58:48.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lf+DZPSxpijO0SxjWVD+qmxvLwlbI9paViPNcRrNslPoFH+UUvZBOxRLYeVFzjSm9uibsbYQ3MH6fj9MSkBvpbWiyn4RXwpY29/7Ttj/JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8821
X-Proofpoint-GUID: 63nG7JlYBN1FXO4qNr2u5BhQ5uTdL_lN
X-Proofpoint-ORIG-GUID: 63nG7JlYBN1FXO4qNr2u5BhQ5uTdL_lN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no need to use DECLARE_WAITQUEUE, use simpler DEFINE_WAIT.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 89e119ccda76..bcbb0ba33c84 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -640,13 +640,13 @@ static void kauditd_retry_skb(struct sk_buff *skb, __always_unused int error)
 static long wait_for_kauditd(long stime)
 {
 	long rtime;
-	DECLARE_WAITQUEUE(wait, current);
+	DEFINE_WAIT(wait);
 
-	add_wait_queue_exclusive(&audit_backlog_wait, &wait);
-	set_current_state(TASK_UNINTERRUPTIBLE);
+	prepare_to_wait_exclusive(&audit_backlog_wait, &wait,
+				  TASK_UNINTERRUPTIBLE);
 	rtime = schedule_timeout(stime);
 	atomic_add(stime - rtime, &audit_backlog_wait_time_actual);
-	remove_wait_queue(&audit_backlog_wait, &wait);
+	finish_wait(&audit_backlog_wait, &wait);
 
 	return rtime;
 }
-- 
2.40.0

