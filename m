Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133BA6FEB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbjEKFWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbjEKFWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:22:03 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2473448C;
        Wed, 10 May 2023 22:22:01 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B1GhEH028406;
        Wed, 10 May 2023 22:21:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=VRhBMDy/VXc3DvVqhsN3q5HlvQZweB84L1nP6EktwNQ=;
 b=DkI6LVxg+ME5e5jDVx7iWMCJLp974SFwnf6GbXhE8dLdRPyKrU3ALs0+V4SSyOxCQwZ5
 q0NEt/rpnEtwG5D26cn0QZXnKFqYglbVy7BPLb0nmz/ZXY1srmgL5lnH0QePuKq7jPE8
 PnHdQBC7IpqWqaASaSVXoKAsPoYx8T6Mms7dnm2fRJ+8mQ2X5BI78at1TX/6qJFkWb8S
 VO4/BVR5NyUqvnbDLtRacdd3NJUPeHj4Sk9iRRvoUYya3he00JkYjSmGxi7+KT1bo7/L
 c4Opix2SZttrjK+4WpKevbm0U10EP/OT+lKNuNKfIEtJKd6n3fC+YABsJqtiEPerOxlN jQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7jvdbvr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 22:21:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCrSLiv4B/2Gy7p+MGK4BEEFvZfxMiNqDttFgT8eAy6IsNj4qHszqwNmkew3MZX/6SdZdtTXeSZQG+IydlYI+AwNUbtqgvsd/EzCpfl/+OkcRRDqmfzh7zPjS4GoSA3lvzWcX4fXzS2QAjbCO1g2n4gPdP1WlTiDwLSyz8uCc4CThuILYfFBG3TZ8v0Wscq6nzHSCXqwpAkeg+u9jM2+9Xu4wIEeWRZ8uDWPD76FON7E3JDYdYnp8byt0bEINzei5RvZ0B89iGKilMlpjTOC9w8LJmEPVT42FePHWNGRInQ/oPFUFORoEknOtnLroTW6m3nGb0Qeqml4/HnIEZu+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRhBMDy/VXc3DvVqhsN3q5HlvQZweB84L1nP6EktwNQ=;
 b=KtVaUA+uZd6bzIV9JrUhFa9b82ny3ZRss9Yyt7u4uyYHN49dE0YGmGBlNMaKWhuU1w7liGhTyNqYbSgn8C0YcF26ejlNOs+5jqX4uZYONALD0TiUsWL//K+kFccjHr2nuThLEWfh1/C0YCppcY+f+QGgAqQfTidTyPYvepweWkU8IgILR2ZSMgScV2VUtb83+IGUObckZxd8+gss9ORSbMLPmvOfOugJnHx9ePzDw9XZB68z8FDZlysaJ6zFnjZZ/1FOKU4KnVZFRyIuYE4bSLK5UZZhKvkD/Ln+fy6HpjatL8ob1AMbRaEewS7IRNzha3C3tsmQ83472FQP9TnXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRhBMDy/VXc3DvVqhsN3q5HlvQZweB84L1nP6EktwNQ=;
 b=dkFYcYwyJQmNM73qH97Qbz/LVDJm0YmIC/AXc4cXFtgg2YFIHJdnbraLSlA/r0C7rwsZ53sPbEWl/WuJVDkvcCLMA4Rqau5f+8wzfIQgyt7JhBIgGRhBxhDa10kcegaXnFRdWw6u9bWdBYZ+HwzETyVY5J9zvyY21uUcLbmnBvUQJHQrbIjFr7JFPsOSiJMsyuJ7/2ywVpiicdBaGSpoL9JecdiVBvOGx5QrBJ8jQQhflKjsxICXJdCvCA3uXnOfVLbfc8jpcc/N3atUz7GCTMiy5NzO/kJ6Au/DdpU1t02X1pQ/YZEGagVpY1OJPdBckweOw2112f3Mjx1Vecrslw==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by LV3PR02MB10006.namprd02.prod.outlook.com (2603:10b6:408:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 05:21:33 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 05:21:33 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 4/5] audit: check if audit_queue is full after prepare_to_wait_exclusive()
Date:   Thu, 11 May 2023 05:21:15 +0000
Message-Id: <20230511052116.19452-5-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
References: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|LV3PR02MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: add1c49e-eefd-4d5e-ca57-08db51df9542
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Pv9aDHlqvsZUqpm7cRui8VsGtk2g+Sgm3EqEUtfZQLh7ZcvRoGV7UhjQ5PDAPA4l72qkgB7fhORNa/fQqLiccvza10o22M17x5JIakxQXMofi6JOqXNECeUCkADHCEW+1awTqNWSdc4DJPoCoImFv3GFC6PBa2EyxBsSj41dnYLD8BI/5jsKjWr1NF0khobKUSAiNSA+vnGRieGt2dWe5cBFYPSNym3SLzA/0lJj1v5Vj7N7izMtl5+MuzRuF2+vXWrZFztzDELf30g/+lisw7gIYvHCtVA0HuJuv7S0Uw93JMwBzgN3i04aIoKnxQ58A2Ctp6MWyzIeVf/H6g6raLZQ0NgRVGINRgtFPwCjrMHqu1WAvP5S15WWmEfuBeHfva/RF7Dlxb2WMsR2YDmkc7akkiUJouuElkTofDwGOm40+V3W3zhnykHDKRqTTmTNmRKsSFX1Zxlw3bHZvapKRLVt1ERVqKTag3aOAYncC5G8iP2DJnHFwdB6Q7Zb6eSKNzcKDJEsshEqTiN0PXZhbcjRQGvoOXa7WVIEsPdGnpHBxywN+VcXMSlHG0KD1fxRtQyCiZ+eAxX0yBgc8vdKVkquJq+E0xpDPEDkCJKeuj0MqUiZGRzxDZOOFQVCvkq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(478600001)(36756003)(86362001)(2906002)(44832011)(5660300002)(2616005)(38100700002)(4326008)(38350700002)(186003)(316002)(6666004)(6486002)(66946007)(66476007)(66556008)(8676002)(83380400001)(107886003)(1076003)(8936002)(26005)(41300700001)(6512007)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mIL9fJ8H/i8dHStcZ5OEcL8D4isQhIZjgv4cvDOVAE4be1/3ot4LSx4Z5wSr?=
 =?us-ascii?Q?K97q5IHoD6IwO67eVVpEwPvOst/aX/saKtK3vrFe7+NYI/mFrKKG62FLFIup?=
 =?us-ascii?Q?r8q0REaIFL24N/ttll4m1TSIv3Ew5uG1T7cDSHsYRnk/nIk/ZgtIO1wzn0YV?=
 =?us-ascii?Q?g9UZYgNQ+5MNW5NCo5NszRehrnrW2/3V5eD4MvIKn62wp3FlXb0fw9w1aDI0?=
 =?us-ascii?Q?A67pkGLGkbg1U1HFtvDAhKLX872rNLawmpVKuBzWF9VxW320cdpwuhImk92f?=
 =?us-ascii?Q?5eSji9J062y2vJP5geS/gOZO89NOKMSuYkr4hod4DrDfNM0pD1FU6xmQRA5/?=
 =?us-ascii?Q?9+heHo1hh92tKJAcIW9XcvsN2Df0IJgiIex13zYddy0ZMA/I/BQ4/iElIT4M?=
 =?us-ascii?Q?RKk3LNlQaGFDapRtgJeY8R1lvfYCEoH+oAKu+ln8dSMGpGkIzh94XZIWgSly?=
 =?us-ascii?Q?C2LAMmrceyoz7tp0TUwj+ifEXW0Dks2PCKQMxYcDjqoS26ezi1IjMGATTA/5?=
 =?us-ascii?Q?tlL8857iEBdTinCJ2mnPqwJKExVa0A/vTvRfKw+2FWFiBrx/S9jgEkhTDKX7?=
 =?us-ascii?Q?NVE9FBp5EokH1pDS6xbR09VmvwdHewKDNe3hsdXDWBLrb2T3Xv8mgA13mNpu?=
 =?us-ascii?Q?5ysH0vmmk65tvNtisudf5GfsaRbQamflwWh0Enrtn1RCWnhyNT7wXT2dhHL/?=
 =?us-ascii?Q?2jGT+KgLSLCsBMFFxVcf7rIvP4Vh9TJHYvh09kqV3YY/V5OeW5GbTeAJkBET?=
 =?us-ascii?Q?sHcpfSu/Gb6+C32CUv8hsdEYXPPSchW/fTAbdOXSZPqS2CAH2KVpKhgEXP7M?=
 =?us-ascii?Q?H2/q87wAO/755M3QkZROCf4oqNZbP3Qkox1R+qN38CqeHq13NljoEJ4X+ebp?=
 =?us-ascii?Q?bWI0fvTadBwswjNO0zHi4wzR95B1IwFsDndKVUl0aydo8nVzPQFqYzt5kF97?=
 =?us-ascii?Q?/eCdvU1TrRtBDPo58+41hdO+7b6wmFp3jVuCZ5/BEbUe4GSbabn/J9opirLm?=
 =?us-ascii?Q?xtTR33a8qMoA3MdBmS8tkWwM8Pv6FJVX0Ez3OQzzvIuRni0p0+V1Qt4Xf44p?=
 =?us-ascii?Q?17PBoWVzyrRGU+2k14dg3Eyaf3Doy5+9FacKr2Ju6IaIFMtFfDQ1MAeVIbgD?=
 =?us-ascii?Q?LHYDChL4GdLJPnZ0mUSw612b4W6xA1LHcqOqjnI2Xh3IpXr4EZAugFoI+nQO?=
 =?us-ascii?Q?eI8HQixDInyIcmLHf025zuG3OYE30eohIhbesWZcebyKPIv4u7iOJRVkue3a?=
 =?us-ascii?Q?9ZLPnMPbCF4iRhvwN+RDyQJE4qUlBEZ07QVZyODaGAvNOnuMI11ZbAUuyQUl?=
 =?us-ascii?Q?2RgDEr2zsGflK3C3H1eoWkEWsePBQhDCw/OIi8I2QS9Yq23UxhHlLMJgg/sR?=
 =?us-ascii?Q?SNiepsMhEmM4YY9wlPhsd2eQIFLJsWdhyRXVebdbca4CxsVRO1VR+x1KUtpk?=
 =?us-ascii?Q?XlTFvEeic1udcdP2IJrkuYKsnS71dKhgjEh0isFmu8bVGfPsuzbYvfoVlfOG?=
 =?us-ascii?Q?xmL4rKOO+qRa1WGs/jan07mUCcZqiGBhF3IQrPbshxMLov3Stmkkp1P45t6E?=
 =?us-ascii?Q?l6AQEwZehBQ/3ASZMoLa7wEN7yFnVqzEDgSUNEdp/JzI/xkW5ubFUTvkBtJq?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add1c49e-eefd-4d5e-ca57-08db51df9542
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 05:21:33.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOvuKFRb4AuJFMvp3mQc1C2fRpVVzYFcqLB6MGjLbsKzvvibIRzvZ7zp/XhY/UG+Wxgyp22pc7xfEu7BWWo8XSiz1BEOm9FKuvqn3wX4740=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10006
X-Proofpoint-GUID: -nyFYXnQwO9YPhJFLetDbNPUdXKw4I9z
X-Proofpoint-ORIG-GUID: -nyFYXnQwO9YPhJFLetDbNPUdXKw4I9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
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

Commit 7ffb8e317bae ("audit: we don't need to
__set_current_state(TASK_RUNNING)") accidentally moved queue full check
before add_wait_queue_exclusive() which introduced the following race:

    CPU1                           CPU2
  ========                       ========
  (in audit_log_start())         (in kauditd_thread())

  @audit_queue is full
                                 wake_up(&audit_backlog_wait)
                                 wait_event_freezable()
  add_wait_queue_exclusive()
  ...
  schedule_timeout()

Once this happens, both audit_log_start() and kauditd_thread() can cause
deadlock for up to backlog_wait_time waiting for each other. To prevent
the race, this patch adds @audit_queue full check after
prepare_to_wait_exclusive() and call schedule_timeout() only if the
queue is full.

Fixes: 7ffb8e317bae ("audit: we don't need to __set_current_state(TASK_RUNNING)")
Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index bcbb0ba33c84..6b0cc0459984 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -644,8 +644,16 @@ static long wait_for_kauditd(long stime)
 
 	prepare_to_wait_exclusive(&audit_backlog_wait, &wait,
 				  TASK_UNINTERRUPTIBLE);
-	rtime = schedule_timeout(stime);
-	atomic_add(stime - rtime, &audit_backlog_wait_time_actual);
+
+	/* need to check if the queue is full again because kauditd might have
+	 * flushed the queue and went to sleep after prepare_to_wait_exclusive()
+	 */
+	if (audit_queue_full(&audit_queue)) {
+		rtime = schedule_timeout(stime);
+		atomic_add(stime - rtime, &audit_backlog_wait_time_actual);
+	} else {
+		rtime = 0;
+	}
 	finish_wait(&audit_backlog_wait, &wait);
 
 	return rtime;
-- 
2.40.0

