Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00E1693B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBMBBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBMBA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:00:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153EC1040D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:00:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CNGuKZ017520;
        Mon, 13 Feb 2023 01:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=B0gQwzsBqSfXfh+7u+zPPqMmnPqwvX+39I29dUBNXr8=;
 b=yQT1iqwCu7aAd1VFu+uZ10H5R629aS+q/bY85Ywlgvw2lEyJwjD7qIhDiMWifmGdlX7w
 D3suWCR6XyBVQMWsDxknekE10/fBfX8txTFFxcVhziDncngQVls5B95MAfdlDVURZu0k
 JOPjNtJhw/WAA1+szE2hGsitP0od1wNo9BS9K/zNBzCmLE+/11dlj9fpxJiuAf3JDiBL
 DN2yXAn+41SDE3ePXiSRqqTH6PC3XpHTCa6VRZ49CeHYWdTKdrNgXMu+Cl+cngyxeFgp
 RLpm9hDr3IbqA9XK/fywzlq1/AicLW695tYkNh/JgbMc7uOPweu+6egbWFzgryJGugJb DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mt9npw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CLUFJD028765;
        Mon, 13 Feb 2023 01:00:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3fncj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:00:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJpYNOIXmTng6Z5UqeUlp4bWGM/xmYhjSzGYZRCDHm/djp7q0m68HADuAFxi7nbmdyxMEc/50CRL6PSa0jq+rzf1MyMqUSAo/MKhgpLUT7bH/BihacuppypFy1XgtVlVDWCMy3pYTEp3u7FHJW067I7i8ZcW92H8X7yN5zVswxiMqBGM3yJr6y3qpmFffLxINU3fPcpGidY/FmFUnSzgHuGgxpwOcsfS4TVhqel93rhnL856xHQlAU9RKn2A2LxWs+q4dbCI49bjK/yxjnETswHUI+Ddo1PqwlrcCleIQqU7f+soul5jQeHRTFHnY2HKsWE3miM+LUtyd9czuPIoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0gQwzsBqSfXfh+7u+zPPqMmnPqwvX+39I29dUBNXr8=;
 b=daKqfZoTOHIO/dlXsrcSqdV/UjrlEhvE8pL+u82qYfDYkJBayozbtOD8zko3SyNqfsyJ2ZMi87wtmRGQpLwBoWmMbch91udHM/YOvIDaJjRTDP9sszllTGsOZcgztC6QCHjxh6YCmOWMxUwbfNoyGhLaoAGM7IpZeSurdb9qkWmAofP92c6IFMfL83aCCv46JHi+eFDhw4HqD5fBA+4KeiGuqPFRgyWpp1N1Ruz/avRmI3CrqpNOK5Z0PTmZj8CjVcbmKhhLTLDv/q7iXbF6zM8Gs6yPOrZf8O1JURoLdTdmPMnZ17Ynkpt4uZW82a/yj5a47gg81qNFHWhdt0sGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0gQwzsBqSfXfh+7u+zPPqMmnPqwvX+39I29dUBNXr8=;
 b=CPGpzDngZOv5gwLjz3X0xBdesbRRsotk9niksc2K2o3GRq13h4D3lGtPCXeIxOxtS5exAP8tjxWWylpe3rlZEmKYd/F8ff+1HVty8Cy8UgMO15YwYu+7H8tMrhuNFjxznjwGrljt646AJmpvVTGk1DZPPUXpouckmNT41qWFLiA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10; Mon, 13 Feb 2023 01:00:39 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 01:00:39 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 5/5] kernel: Convert kthread to use setup_thread_fn
Date:   Sun, 12 Feb 2023 19:00:20 -0600
Message-Id: <20230213010020.1813-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230213010020.1813-1-michael.christie@oracle.com>
References: <20230213010020.1813-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: c0410924-2526-46bb-ed26-08db0d5db95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYnBBaCk4Fvu2eiHDeZe5Dk1cSqVECD5b3owXhVMfqmLyvu7S66ouERt1ZETHso5gH665k1uGluZruIGcosHOGxpjFBNSSvu72w61jNaJvXlBF3RkF1u8VV7LwLGjPmi2Mxzi6gio8kcGjLxPy2qx7F7kBijAz2mJ8+iV16JQ1SzWxF/WpakPq26d+0Y1oo7dGwjpKKAoouac4VXw0vktok4sOaHDNhllIaSmdMQY3KXCJkCAK2XgEYmWSHbuoMY6Ma3dUThGIpSvF+8n5jFJmyxO0m+zoyoTTvzHuec4tMO+AbM5aYB3MaV5zk3jurC1fxPVnaXr4yvNEnlv16BuOI5n96FcEJ5wJ/VV0ghRbQz3NFMTL3xxegXQ8lDDOYOmvCq33N6Pkz9YHLmKLh7ZfRfSj6D+rVW2fOhwZAHU5cpRdrmVGJGkfkyZPyUw9rmpwkUPW7UFnC/YcSM7asbRXHb5lg0oDNM8FyqrO/v0UU26+JNcxAXq4joOKIbkguEmrG4L4fgWIdHNfDZDAQhSwTT8jE/M3iRktdxKNzBs+Wcs4ao/5cItnlvEILfhto2JAGl108yvK0yMXCau06n+tHIK10NQsCickNMQryEuHAYFfRJAT4xS/96sb7+oTgdAEqIg1Zksy/g+1vPb/xNjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199018)(8936002)(36756003)(2906002)(5660300002)(86362001)(2616005)(83380400001)(4326008)(316002)(107886003)(38100700002)(66556008)(66946007)(66476007)(8676002)(41300700001)(6486002)(478600001)(6666004)(1076003)(186003)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rKGjVcjVF4JP4uQ9J5L6rWF68qttmHs0J1KeiKfUL7x8gEwwywHY5cOSU8Qd?=
 =?us-ascii?Q?FXU1BPuWM/OqXBXtCW4Jv3bP8AW0hAbboXUD4osLVE0G6dMOPpbh70GhGR/O?=
 =?us-ascii?Q?KyIjlnl5D97bA0OqYMoLN3JBEa1Z/5pxzNa1xjMlHdMxXOcANWetWJ8qxvfP?=
 =?us-ascii?Q?uiZR3UNCaAPHDvUXOboMsAnOzzqXBClMVHQKLMYi80wLlRZ99pqElVP56S0f?=
 =?us-ascii?Q?cvC4CG8RRCYPsfZ3iV+mdjCcW7yfnAybxgyHMlIEjmNcBC8e10+xagPoU6P0?=
 =?us-ascii?Q?gXcJV7U51RowstohZoYGCklGPJGSmJa+w1vF1hTpaAmp/ZihB0k5xAFF/yTs?=
 =?us-ascii?Q?hgPfkAQDx6wiH/seHCtx84AClT024hMNmdiCxQTPut8BNKm/A6a1fW1qL9wv?=
 =?us-ascii?Q?0b5zvvhRFXv24vi4kJhO0XdWz5Pn8K4nJNwn536g/it29Zo4m45RS9ppw6Pi?=
 =?us-ascii?Q?FfCSl+cCoUnpiYooX4HHgLC8PxKeZJlSsk1xR5lQpd9+RVEJB2m7lmOoydyW?=
 =?us-ascii?Q?km8hblW1yPftCxj0zHZo0fTLGBrfR26b1iFxeageFyYWDnvZ5lApStKdgrHQ?=
 =?us-ascii?Q?TZvVWL1UQ6cMl4LjE8N5RyVILNqK6VdcTvieeb1rPWSamB3yBuZcYhKI5oxm?=
 =?us-ascii?Q?J77Huwq2vy58xszmA75LuIKAbP8CJGXpmn3afIq83K5YB54+H8Prj++AEufM?=
 =?us-ascii?Q?Mlmlts3HaS0Abplmeh+BdmqoP9c+hZ1EMg9wofT63zxpgBScHQuOnwVLqF2N?=
 =?us-ascii?Q?Dpw99/qnaobdNwgnPe6oR3JvmirEXlU7wqloDWQVtH8K4D/khsiZLe3Ed8jP?=
 =?us-ascii?Q?mIIK2tFVWvkkQsZigVwLXPZjwC0Zd5pZlzk07o7qcmTjBayKeNQTnmWhXKji?=
 =?us-ascii?Q?y5hSnmU02AR7ohceO24Ur5kNnZ7aqARMPA0T83qKZ2zPVsLO30Ss3t7DiR4Y?=
 =?us-ascii?Q?PMHKuuTIrAUbv6lAFTG3fTg2YycQCRj9LEv4a6nuZn25cu2Q8dcTi3M5HEMe?=
 =?us-ascii?Q?n0l+GVDWZ1DKI1N74+P+OC1Ldt5rcU+mWhMuYJ+35MAtNvSfa4yKtT/N4v2b?=
 =?us-ascii?Q?bAsEW5rP5YhrPoKu1E4tf6JcsrX1G7S39yPYIMPn/Rj4XiVO8dAfl8NWDW9H?=
 =?us-ascii?Q?6RhXyrgd4VfjyYzqnbeok5MoGqamG+PL4IZHz8bN6CjUpQ0IwCwpSvtTWrH2?=
 =?us-ascii?Q?sF7q/+FUO3IWv0r85Ha7SO63+pr/bJP7CuhBwsnX6/j0lVngmmW0mZYah0f3?=
 =?us-ascii?Q?zZlnBs+CAh6x1X8VBZBGRWBshWFRbcZ7s/mqg1pWLAkexalfLGRidxLGA8Fs?=
 =?us-ascii?Q?V6455sW9Vbon3rwcdJSFX69ZZ0B5p2tzIYFZwdvgMIXNyCb6ol3o5m62os8F?=
 =?us-ascii?Q?KswJSB3RuQCOrQN+CQH/paz3Ika+/fZr8zxcj2740t0Eq7EC18hktFeuEXe/?=
 =?us-ascii?Q?YHHSuh7ePeOCsk+qmJfs49q6mpCZGEbfq07e9j9prubTQWnSrEnaYTZ2DgDV?=
 =?us-ascii?Q?5MKaqDvTVpTDrNjfRNFxPRgUqYkjFDsnfozdPfKmXg9NzBtyccqrhqM6RrNK?=
 =?us-ascii?Q?oCLaFkp5PrW0VVh7AuQicfFBI3bqut0+dnPXscaMx/aiGht+9EtXPOfQpqG6?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6ybF7IugkYg4hTi8orUZRiG/fp9a9wGLWwjikHL7Efph5+CHjjZDgYVtE1xElh7FVN4Fix3telwIHQQfw3NP9DP19Ig9WYD0cmeDakDyTUk7ByNovw9eArcLdc1UVpJxfuPO9qhYUsTmKGLGBAmSDyYftVVHlmB8oA7HWFo52NCEuVznf5W2ph3csP7uYJsr/mv7GSc1mgpOG5DOsd8ZxSK/ZFEI669hcZi4WiMFOsdRZa+yjIwP6nlPZlBpyd3s77QCryC8GfRnTcXkiQJL5sRw1L5YsFnV4Qq0AOQ8761sKO0draT+JBZ7cfEI6icJSw2FwApDDVmTohPQlOTwe+Yr/ZhaDQa5qPRyMExzEjMeE8JoBlu7lJ3ptXV47aWTUPRY13clKpEf22GnYy143Z7hArN0VmsnNekStIorDPZp5l0tXeyUancvdObEUmmzuPhPlEsYactBk7tSjQ/bncH6qKpeCCBqVWmEFkRYf/X+5zf1VbxQIMkF7IqXyOdt4e7lMAa2pB0CaPNRbwfSvkyxnt6zryuyOiXTVjFcP3lNUtMiqhiWyrSveuPltVBBgptpkDyhOLUU0JjPsgcufKGK8+0fK2asCyjM+/ktuIjlTilMClkm7Bzy+SxDESFQGLKeUMofHh7BRpTGCS3qRV8wyMOUFywJhw2wXFM+7QqXslGlza3pLERb6m5v6o9slhoO0+hspU9b790vAjxRcQ5tSIB2+DVw/38ogdzSJUv2POSOZgOEFi76he3a+DhN8VnBs+KiZx9jRvdtwyITf5Ekgca9Fpb5rmM/7mTTzqg1ec7kpzj+MBAa3mfCMc9DBjcc8lqGfYCawPY3DJqErXtLISy+h4+iXfnAKTn8VlZJtSlLYg9bzI4VSiT6CE41
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0410924-2526-46bb-ed26-08db0d5db95f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 01:00:39.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qc1UgzpFjiZ+FqSAVC3tJu1uHh0B3CcnVpLMmY/RFKVrVVAj98R+oX1xdL2yOg4O2S+9WDBtDpIZNYy6rUPqfUA6qzX+ZBKmu+HbHQyrEaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130007
X-Proofpoint-GUID: Airdgt-bD4DuRjolji43sYD9ODEezn35
X-Proofpoint-ORIG-GUID: Airdgt-bD4DuRjolji43sYD9ODEezn35
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kthread_setup_struct can now setup the kthread struct and setup the
comm, so remove the call to kthread_setup_struct in copy_process and
have kthread.c set the setup_thread_fn callback, so it works like
io_uring.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/fork.c    | 5 +----
 kernel/kthread.c | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bd60ecc6b29c..7cdd85befa41 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2189,10 +2189,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
 	cgroup_fork(p);
-	if (args->kthread) {
-		if (kthread_setup_struct(p, args->fn_arg))
-			goto bad_fork_cleanup_delayacct;
-	}
 #ifdef CONFIG_NUMA
 	p->mempolicy = mpol_dup(p->mempolicy);
 	if (IS_ERR(p->mempolicy)) {
@@ -2598,6 +2594,7 @@ struct task_struct * __init fork_idle(int cpu)
 	struct task_struct *task;
 	struct kernel_clone_fns fns = {
 		.thread_fn	= &idle_dummy,
+		.setup_thread_fn = kthread_setup_struct,
 	};
 	struct kernel_clone_args args = {
 		.flags		= CLONE_VM,
diff --git a/kernel/kthread.c b/kernel/kthread.c
index b67c2caf2ccb..7776d19789f6 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -429,6 +429,7 @@ int tsk_fork_get_node(struct task_struct *tsk)
 
 static struct kernel_clone_fns thread_clone_fns = {
 	.thread_fn	= kthread,
+	.setup_thread_fn = kthread_setup_struct,
 };
 
 static void create_kthread(struct kthread_create_info *create)
-- 
2.25.1

