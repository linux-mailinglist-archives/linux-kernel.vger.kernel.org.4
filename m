Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3E6FA1B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjEHH7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEHH6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:58:53 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35B9036;
        Mon,  8 May 2023 00:58:52 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3487QqkH011998;
        Mon, 8 May 2023 00:58:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=+5ZIFcAXGaOEr6fcSRGPnoy06NRtoIMGpCCS8rABMCY=;
 b=c8Z5x9+TFKK1HnH7g4bfDAG41bjVGVVVltgsthZaNT9+6GNDfiN/eeG84j/L80lGitAd
 gIA7f5ZiD3DBCh8TAlGjdBNm2JaiQZ0axM092kZWrqe4KyX+khugUT3TIF+rT1cDfEVt
 Vw+PphrtcZPRLv3Pwv8rhpqNrSz7E2HCgus4y9wT86PpT4eW4BrGcVU101rKDcWH38S+
 hWCsvrkbzFEIYjwkanqdDj1bucTFA/afMHZT7MWueYL/Dr49T1KuhcWdzeD8Kf2s9BzN
 y6462MqSFizuGNwrmfED4a3QE7F2h2SxR1IWx666KxGK3TPkldNYCy34ckwHLgfwFnGO sQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qdpe43n4a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 00:58:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANX1N8usmCIzUOlZpL5jCnNRX1n34900FjZEgy0tVA0GRJLw92W3Rsa0VjWZqBq+mQkxj/a2DWrAzrVK0OppPJvbqNY/6+pVCLD6Niz+hsCE9mw230qiIJ6IMInXmEhanNpdNyjB+VVc1PybwEiLZLYU94DmSqk5x5XXgxMosKhu/ZAHh5xKuOFZUqv5elayXeHKd/+2QPAb/JP2tc/OwH1cGsSfDo9JlODDGA3IpiMNzyWfmoG/+/Oo4yBJreZLcRvFPjlPRVLqlo/iH2xi1Galpa9Zc9gJsOOFSaH4s34GTJj+GkJW/wC4H6QBqCscvSBykfUCfvj0Dcn0/WiHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5ZIFcAXGaOEr6fcSRGPnoy06NRtoIMGpCCS8rABMCY=;
 b=aeB8elVbC3S/gWAjTAsjZ5AMm8hvI16kx+ajWjynI62J0nJbeoi6UnLmAY9TLR/wBfPbM6OSG9geyE5C1ZaI2br3PK7eSLXDVq6aqO8DgBkbjyF+YJ0sb5fKWzpy1lhaocXfZgW1GO9Oy4amcF2ffrwidWD8dTSdET6nYdpgfDtOh6bIPWDpPztYujL8U4xpsRaOGIE1GMxUdhAMVn33SjfDtr6v5sD7rQLiC+cyr/q08enSICfWJH+MPuu2XPqR0MhQCb0op4jd5uQ4kfExG9ext6vqKCLlHwv61IXQkSyIHQknLESYhTWlBXBJACbnTVI9O3P/wGYPf6YuEuZ+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5ZIFcAXGaOEr6fcSRGPnoy06NRtoIMGpCCS8rABMCY=;
 b=KJamil1AJFUaATJCaDLzjFwyZE8+kvlusv17OW39WtR/cNM/S7hQaPPWpR0PsF96LjqOt72m1dk5F9JCVWHoRY+s6E3ImbFCk3FPNlxYMWyqXZC3FFwTHg5JBvi1TNlGf7Wj01Vvji//eGwTR1eeCBUgQfaC8BR+OxEbz8lJFdulI6xd/Ex0kq9vCmuWKWFPqrT47OcSiemPCwkuqMuDmje4L27NGXznhaOTx3DSigqbzLtQDAbEtP3yVyIIkHm8RwB6/hpvJLf5EsTCoAKPkp+Qa4nbzeZf2ZSG5UsdaIhAba/lUBobgkV0qkdUnpve0zgzTMnaLWso5dsFDaqRtg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by SN4PR0201MB8821.namprd02.prod.outlook.com (2603:10b6:806:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:58:46 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:58:46 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH 1/4] audit: refactor queue full checks
Date:   Mon,  8 May 2023 07:58:09 +0000
Message-Id: <20230508075812.76077-2-eiichi.tsukata@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 73e9b20c-5ea1-4916-f7a2-08db4f9a0d05
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3XCBNnrheKatITZaBPX6jkuml0Xl2YRwbA/AjS/1ZI9e70TiXGmyjCcmUNAz/nu1WZnslYmc/cNexe1BnT7AsS+YUo+lmCieEkvnckdtROtZXVUY0TlUe6Yb94XR/IjW/4x5C1nJzmkLHQkky0SbyysLp5YtHLKVIDc7MMacUZwv6X1X36R8JYuAQVHXIhG1NcCs+xwy5mUgd0PCINuKj5TBmkBWCNqNd/QqYodkel7WnOyhf58/JPrMj3tR2qBJc8Z9+lOfp6FVIGCoY6A575qiJh3gtXYckot0+MvP/UiEAlxSEnEISLxuv16Xwd9eH/euYL8ehpRUDTwv0qJb3OWD4foz482HYv5VqlLOQw+heQ84SeynTwYmV70sZ3Y5nUhAz5OqeDH0K8tEy87x01yjynfgZ7gv11rQxs8QqIcdb4D/PW8pTHyjZYdN5jqzsjCxSNU6UeMPt38j03FpFr0Od2MO0qmMEZNjJp0MKv4dSyl8JDXz0EWS6Hz2HvthFFvLKkjTq8t2JSTCeGACP7Xw+S/tvSg/j+18MmdQnh+yJzOeYsuGYRaXoC11+i7WVtnEiKUZ8/89eQdp1H5hz2CplFlN3NFDtSklYGYoRPZv0riIDFEjqIIpU8Nm+4i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(52116002)(66946007)(66476007)(4326008)(478600001)(316002)(6486002)(86362001)(36756003)(66556008)(83380400001)(107886003)(2616005)(6512007)(6506007)(1076003)(26005)(6666004)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?meh14MsGagUsV/DL6yxsq91wtJK5UDbhCVHw9Ns+1DQHrGqVdzWCUBr76gyo?=
 =?us-ascii?Q?+MAscUl22XVcR4I2v6u1uCFeeYiP0uXXKMim/G57EoFwl9NOb5pC94R7dpOz?=
 =?us-ascii?Q?pja3vyRERgqOBe4A+S+/JRjq061C1bZ2llev7P8Q90nJO63Rl1rM0nkmhlwo?=
 =?us-ascii?Q?VcGnwji0y72w3uRAorl7xXKWeoyZjbw/5mEol9PNULzpk3GDS5//HZ9QxF9D?=
 =?us-ascii?Q?LjEZIL9A9Y0rI4bpqGuUmuayNxlcPqXXVj5au+6kTOC2VS/26MBsYffgej89?=
 =?us-ascii?Q?Yi9E5SxLEh8VBXv4lljGG2hrxMYdlxWQ/ck1dCLVZ4nFs+GEVXCjkIP/ls1k?=
 =?us-ascii?Q?vsF7vBaDuE+zGJxDvlczM6BV8w0HFKVaZzfQ9sgDnI7nY4Kk0m90+OH4oipU?=
 =?us-ascii?Q?vtkn+KCK8/K2UsjXQQDuyu8JYMri9l+0f3ZV0Vt+leoOgwF5K2cOCAQN3LZ4?=
 =?us-ascii?Q?Eiiu3wxr4lyVTZv3SXiaWnoviO7DsDo/k6lYhPwRFKTg7K2tHrNmvaSu/d+H?=
 =?us-ascii?Q?YdVGKFSQ5Ovml+1CPevp/wTnEiYSVvLv8Fdk3PoxvkPAHbNM3uACWutCdMIx?=
 =?us-ascii?Q?cVKklrNKOMwmCwaA4k24QX26/MTXtQwVZVLBGhpi4frpQfgSEAEOKnjvS+Ag?=
 =?us-ascii?Q?YK7+M9HZsdGHJDq/Al2HEcCZxklu932hf+33JLTEkyk2/MvV7p+rZh2wmlEY?=
 =?us-ascii?Q?fPPvgB50K6lnUDzxQBawsPETSmjZh1Np1CoA4jBErmtL02svqvgX3loaEKU+?=
 =?us-ascii?Q?m7OyyS5FiCF+Hjl0FtIEBgyhOuQXQOj1d6rbbFk6jTa4swkyMoqYRv8YRcXw?=
 =?us-ascii?Q?SmYM2M+uceFxaMYKoydgXU4NuCfwiKPvLEjgYYF17ljasscKyPzXtnelF+AL?=
 =?us-ascii?Q?j3VjWAWQAkV8qif5mvqmiP6SC1NrDMFXaUYrUEY5H48zGN4YEzCwloM7EDT3?=
 =?us-ascii?Q?vV915GHMoiza2XUCy/dDg8G5T/LoeUvDYir1Nu41vIp0BeMNo/ENuERUBAVn?=
 =?us-ascii?Q?tD5anO3GY//Cb6CTCzf1bY6MqfJFz0mG1X+zEpRHpOV3Z7dd3NVZ1DprtPN7?=
 =?us-ascii?Q?Ji/ONCLSxyzj0JbRHDPBwspnIp58ZsmfOFl/NJNsyaGsc0/KNtM/+3ZzhNaQ?=
 =?us-ascii?Q?7hfA5HbqhmUydIiSheuTJHhXOC4Fsrl9JOIWsaS+dO+3uIe3syywZ9KRzqcr?=
 =?us-ascii?Q?ocwd6A85qNNNvuhIuWTxmUNBlaYmcwsj0/Q9k7dmc4OZtMDjB1z2J1Jk2Bk/?=
 =?us-ascii?Q?jYCP0gXrbttuzrl9HXgLWAQ1Y38zRnjk+dekZL40We7sIUOy2zWE8ytvM8bg?=
 =?us-ascii?Q?b4zCtkx9kQ7BGGSeKGQa6LO0X0ArmF3WQE+0Rln7e4PvR/qfCFUXYcZ1Bt6C?=
 =?us-ascii?Q?M+DYdjCxybdGkZ87Le0GQFyO2StHZSyCChdnAM16x5avE9jsnpZwZ0QmSZ6C?=
 =?us-ascii?Q?B4+FU5bYY+dyOc907OH7FxeRmg+yjCM50pzr5YDXXJ++198uAf+yO+U0d2iI?=
 =?us-ascii?Q?EFhaOKGrE1QCgbqBFLlLhqGfK/QnKHFLE4pBfxp9y2A74tLzMiO2NfQtwOn1?=
 =?us-ascii?Q?+ynNLqSl3DU75hRnwYl8zTKROCxvQi9bwip6N3MggYwbPOFnGAiE0UwoGdma?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e9b20c-5ea1-4916-f7a2-08db4f9a0d05
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 07:58:46.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVdCVjdWAXl+mQx5KDGMBYOX02g/9vP6PCO4x3SGwpKYqc3ETbUYU/5DKZ7RFABJsrOWqTcOpvt8ywtrixt3ZXZ+RhINH5b5EQj2R1+0q24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8821
X-Proofpoint-GUID: ozbbm-1Dj_EPgrl8u8CWGgYQAzniaqRD
X-Proofpoint-ORIG-GUID: ozbbm-1Dj_EPgrl8u8CWGgYQAzniaqRD
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

Currently audit queue full checks are done in multiple places.
Consolidate them into one audit_queue_full().

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..c15694e1a76b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -341,6 +341,12 @@ static inline int audit_rate_check(void)
 	return retval;
 }
 
+static inline int audit_queue_full(const struct sk_buff_head *queue)
+{
+	return audit_backlog_limit &&
+	       (skb_queue_len(queue) > audit_backlog_limit);
+}
+
 /**
  * audit_log_lost - conditionally log lost audit message event
  * @message: the message stating reason for lost audit message
@@ -579,8 +585,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
 	 * record on the retry queue unless it's full, in which case drop it
 	 */
 	if (error == -EAGAIN) {
-		if (!audit_backlog_limit ||
-		    skb_queue_len(&audit_retry_queue) < audit_backlog_limit) {
+		if (!audit_queue_full(&audit_retry_queue)) {
 			skb_queue_tail(&audit_retry_queue, skb);
 			return;
 		}
@@ -589,8 +594,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
 	}
 
 	/* if we have room in the hold queue, queue the message */
-	if (!audit_backlog_limit ||
-	    skb_queue_len(&audit_hold_queue) < audit_backlog_limit) {
+	if (!audit_queue_full(&audit_hold_queue)) {
 		skb_queue_tail(&audit_hold_queue, skb);
 		return;
 	}
@@ -613,8 +617,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
  */
 static void kauditd_retry_skb(struct sk_buff *skb, __always_unused int error)
 {
-	if (!audit_backlog_limit ||
-	    skb_queue_len(&audit_retry_queue) < audit_backlog_limit) {
+	if (!audit_queue_full(&audit_retry_queue)) {
 		skb_queue_tail(&audit_retry_queue, skb);
 		return;
 	}
@@ -1564,8 +1567,7 @@ static void audit_receive(struct sk_buff  *skb)
 	audit_ctl_unlock();
 
 	/* can't block with the ctrl lock, so penalize the sender now */
-	if (audit_backlog_limit &&
-	    (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+	if (audit_queue_full(&audit_queue)) {
 		DECLARE_WAITQUEUE(wait, current);
 
 		/* wake kauditd to try and flush the queue */
@@ -1866,8 +1868,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	if (!(auditd_test_task(current) || audit_ctl_owner_current())) {
 		long stime = audit_backlog_wait_time;
 
-		while (audit_backlog_limit &&
-		       (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+		while (audit_queue_full(&audit_queue)) {
 			/* wake kauditd to try and flush the queue */
 			wake_up_interruptible(&kauditd_wait);
 
-- 
2.40.0

