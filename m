Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620126E5545
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDQXeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjDQXeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:34:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A1E76;
        Mon, 17 Apr 2023 16:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/gVAb2UKZF30AgDr7AeeBrzHCQAkCvZJHdeXidoEXkBG7zv4SkqXTVRFrHqwthwRG9Df0v+goj7PADmZ6RDZ50bFtIx9Ztc8B0u8ngWZNwObvK+ThrcWp/f/5/BwM4JKk9DGuPfw6elZfi23APhZEZjzQo49gJdD8NxRFM+TVMVk2mK2UURFl1ql1mNiLkJTJz/8b4yoRIqwRXxb8xM7pktgFe3t5ePWfKaOkFBr8XqVlTFUEDu8wnMlHm0DJTMZl9L6ewLNeY1kY1lFephqyJifc/iCTDzHhO1iLDXlHecubDh/vCBtXj9FiXMEMhbNd/Cd3BudX1Mw0sdTHgj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcErqOAyciZV5H4WhJpBgNzP/FAuWfbxjPa096tf19A=;
 b=JXq0pjItgqc1TtpFJv/I4SVqf6P+gZwHm4UW78CzGEN+gKbVDUBBez1sTbDYiM2T65MXLNEC93TQ99EeOqX/7NZ0hKIKez9HsQNSbu6IKD5FWIUf/Gc8iqf9cXKQ0bxTQRQtuqjAxjtcg1OLwnrWEibDRjPV/+fgKQZyx6CiWAaMVi+PXPDy8l2j7hZgzw+MXNvdx59J5jHHVzPDGEGv2zdZQRyAVDIH48UBahfUQyrnwtr9WIi3Sni3bIh3gTMNgWJ/8OLxfCDh2IMraR6vUOSFEzSw5FfAIZsHRQvrKMlB8sJS+02OEGI898iGXvDiTM4uybIhd0/0vTbuWGA0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcErqOAyciZV5H4WhJpBgNzP/FAuWfbxjPa096tf19A=;
 b=OGi9xZ+esO/BaSCvo1xJXUj81OW1rspuLV50z9gU5MFyAS2RcKrTWCDYXm8O6AvUmq2fUFCx98EKQUurrewgbch/1EG4Pmu+JgRCRh6ut25RHrAVdy+OPExkLAtIT2SHIIA2pqX0D9dMnn3z9bG5gxgENSIQyYYlCUs7r/AAZGc=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 23:34:11 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::a9) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 23:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.19 via Frontend Transport; Mon, 17 Apr 2023 23:34:11 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 18:34:08 -0500
Subject: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl group
 at once
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Mon, 17 Apr 2023 18:34:06 -0500
Message-ID: <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
In-Reply-To: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 744f4389-94a2-4ed0-0bae-08db3f9c3f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCO4TfKFDlE9UGurbnK2abE9teeoWSExm/a3c+HGZEP3UwB3EsFXU5AjZQD7F/UHYiwPKcUe94b+kCg6fAhahuPMG6nekwCDGZ5esr0F9eepxsS54KtLXCWJSiDFP3brqAspiKufT3edAwKo0JCCNU+7cDB/xjfwuE9xP7ZAM2Le9ci42D/dYCcfT6UdrxtisRmPd05841bVDdD0+3bBrzvPJMhk6gMjKNUEwcM+ukujDl+JgyfDxnkSimIEu77BNFVVmvcE7h3pci+wvMC0szcLreKKJJuoBxz6GTnK3yrTawlDsSobKIdw763hDV4ueLzUh56I9XEj0r/FDJdmPU63PARUqfbDuzUUXqDFVF4sWWpqk8HQqm++PdKtN75M+l1eQp5dUSzitXQXVvUjLSB68NwgsQnq+LlHdMw9AHYAO2bwDAmSDD31bKlTRmJ7+KqiYxQnx6VPwSp9r9kNkcWr00q/V+qzniAcXmDKVIB9c3oy9HRpZ31WVByzzwkYzafB+olRhJ2Y8i5MMZebN1Ek/YlN/lSIYCg46+GBfRh79php0FE36LOlxDUXhlxLTKL5wWp7/+OreqYgCGa0NxiskRmrqxDqo7mhQp9cPWGpRj9l7h89uxD7Lq8Yec/y66bYYlmPILyhEEK/M1sDOo9OhwKNYs9cV+Yt7KPB/A8eK8yZRSUPYjaNPAr62uGxKMnfkojlCOSRPo0p4ZWn+SGBrYCYu8tPyRV4yGnOqdiNcl7qNKCdljIQNZADh3bN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(82740400003)(316002)(4326008)(36860700001)(83380400001)(426003)(336012)(70206006)(47076005)(70586007)(478600001)(54906003)(8676002)(16576012)(41300700001)(8936002)(81166007)(356005)(110136005)(5660300002)(2906002)(86362001)(44832011)(7406005)(7416002)(26005)(186003)(9686003)(33716001)(66899021)(103116003)(82310400005)(40460700003)(40480700001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:34:11.2327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744f4389-94a2-4ed0-0bae-08db3f9c3f56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl task assignment for MONITOR or CONTROL group needs to be=0A=
done one at a time. For example:=0A=
=0A=
  $mount -t resctrl resctrl /sys/fs/resctrl/=0A=
  $mkdir /sys/fs/resctrl/clos1=0A=
  $echo 123 > /sys/fs/resctrl/clos1/tasks=0A=
  $echo 456 > /sys/fs/resctrl/clos1/tasks=0A=
  $echo 789 > /sys/fs/resctrl/clos1/tasks=0A=
=0A=
This is not user-friendly when dealing with hundreds of tasks.=0A=
=0A=
It can be improved by supporting the multiple task id assignment in=0A=
one command with the tasks separated by commas. For example:=0A=
=0A=
  $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst          |    9 ++++++++-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   31 ++++++++++++++++++++++++++++=
++-=0A=
 2 files changed, 38 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 387ccbcb558f..f28ed1443a6a 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -292,7 +292,14 @@ All groups contain the following files:=0A=
 "tasks":=0A=
 	Reading this file shows the list of all tasks that belong to=0A=
 	this group. Writing a task id to the file will add a task to the=0A=
-	group. If the group is a CTRL_MON group the task is removed from=0A=
+	group. Multiple tasks can be added by separating the task ids=0A=
+	with commas. Tasks will be assigned sequentially in the order it=0A=
+	is entered. Failures while assigning the tasks will be aborted=0A=
+	immediately and tasks next in the sequence will not be assigned.=0A=
+	Users may need to retry them again. Failure details possibly with=0A=
+	pid will be logged in /sys/fs/resctrl/info/last_cmd_status file.=0A=
+=0A=
+	If the group is a CTRL_MON group the task is removed from=0A=
 	whichever previous CTRL_MON group owned the task and also from=0A=
 	any MON group that owned the task. If the group is a MON group,=0A=
 	then the task must already belong to the CTRL_MON parent of this=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 6ad33f355861..df5bd13440b0 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -696,18 +696,41 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_ope=
n_file *of,=0A=
 				    char *buf, size_t nbytes, loff_t off)=0A=
 {=0A=
 	struct rdtgroup *rdtgrp;=0A=
+	char *pid_str;=0A=
 	int ret =3D 0;=0A=
 	pid_t pid;=0A=
 =0A=
-	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)=0A=
+	if (nbytes =3D=3D 0)=0A=
 		return -EINVAL;=0A=
+=0A=
+	buf[nbytes - 1] =3D '\0';=0A=
+=0A=
 	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
 	if (!rdtgrp) {=0A=
 		rdtgroup_kn_unlock(of->kn);=0A=
 		return -ENOENT;=0A=
 	}=0A=
+=0A=
+next:=0A=
+	if (!buf || buf[0] =3D=3D '\0')=0A=
+		goto unlock;=0A=
+=0A=
 	rdt_last_cmd_clear();=0A=
 =0A=
+	pid_str =3D strim(strsep(&buf, ","));=0A=
+=0A=
+	if (kstrtoint(pid_str, 0, &pid)) {=0A=
+		rdt_last_cmd_printf("Task list parsing error\n");=0A=
+		ret =3D -EINVAL;=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
+	if (pid < 0) {=0A=
+		rdt_last_cmd_printf("Invalid pid %d value\n", pid);=0A=
+		ret =3D -EINVAL;=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||=0A=
 	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {=0A=
 		ret =3D -EINVAL;=0A=
@@ -716,6 +739,12 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open=
_file *of,=0A=
 	}=0A=
 =0A=
 	ret =3D rdtgroup_move_task(pid, rdtgrp, of);=0A=
+	if (ret) {=0A=
+		rdt_last_cmd_printf("Error while processing task %d\n", pid);=0A=
+		goto unlock;=0A=
+	} else {=0A=
+		goto next;=0A=
+	}=0A=
 =0A=
 unlock:=0A=
 	rdtgroup_kn_unlock(of->kn);=0A=
=0A=

