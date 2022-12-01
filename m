Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F267263F42F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiLAPiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiLAPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:37:37 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E348B3919;
        Thu,  1 Dec 2022 07:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPbCAvCzFyedqyM0wxoC2J5yOXDtyCSHJT75d5d4WPRCvqIjC3ueoz5GBma2GXQUpLi5NCmX7I7XgQfiaLBvVpoMLshlnCOTltz0rl/Ki3AXHf/NV8+XHM/gXgQ80gmsUIq8F7eU76Aff6fSIFqOJTzXnb5GOgc8QdEURPGqvKlrxZzZPdmyErkh1IlmNvI+ydZ3YoU0G6zqp95eQw2/4qsihWsWwmIytzR/Sw4GszBf/ChhM0F+KoDNW98gv24fjSQjyamWBgaXfQ8VgSSUAsYgD8vGxfA9+gTdrRYHBZ+xhAGiJFi/eGzjNy5JyMTuq5BSFSiybmiwIGDj2R4mtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRZQAhGhSeJG4LxiSpy+gvcPr1skm6d2SwSKC8AJ1LA=;
 b=V99IZ8sgvTKPrD5KhI0QLR/fjmUBb04ASml21SeSGC1kRy27ytgixxj6f9li+X/s2lOF/veFg7RtvGJ4ldxmMXZDOsSTjN+JAzRe6QwW0rFClfmVv+064okSFp5kNrh0IBg0y0xDfFCGqpCibPCDN+GAefv8gYg+UfdiyLDbArqF4HwijWoSf7mK1++9AWjOOp4OKnR1OlEHbNA5UlU5OzjghlH2lGDhrFXyYxtOWsMXaQAabs/RVw8GKBxu+LfzgD/7HtA2a9HEqwpFpLz+/beIA2Run0sRrmsPdLkxtDljwXGMCjhDWJMAv0kQl7ugfa2msonqJT+k6+UF94/k1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRZQAhGhSeJG4LxiSpy+gvcPr1skm6d2SwSKC8AJ1LA=;
 b=FfDDZHler078NpUSCa4yMvG0u1zDpNIaJzqjUruZAn07MNlVnJF61WN3KbRdDMXSVyk1OcbaXNtnhPnnp+ckTC0tuWa2Uw3zKIyUw7ugo48YIRd9qbpwFx1juGmbGIFGBGUCFj/gmKkkgaJYHIg1gxmsh+MRjj2RlDbx9blq7aI=
Received: from MW3PR06CA0011.namprd06.prod.outlook.com (2603:10b6:303:2a::16)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 15:37:26 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::7b) by MW3PR06CA0011.outlook.office365.com
 (2603:10b6:303:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.22 via Frontend Transport; Thu, 1 Dec 2022 15:37:25 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:37:23 -0600
Subject: [PATCH v9 11/13] x86/resctrl: Add sysfs interface to write
 mbm_local_bytes_config
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
        <peternewman@google.com>
Date:   Thu, 1 Dec 2022 09:37:22 -0600
Message-ID: <166990904243.17806.8875872967137007418.stgit@bmoger-ubuntu>
In-Reply-To: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|MW3PR12MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8f576c-ccd0-4981-3eb3-08dad3b1f290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoHQGWxVPIMUfmNJZmFMSl3zxv//gDO/YUw22Doa5BHIbF0/oauNi6wHR1XUL4IteaiFLaqXxpBRjl9Roy/pBnBiqdWnyXQGGPWhJt88cZhjFdB3mTh1dTesTQWV552pb/WlTR9S3revbTnQ/wyYxKL/AEKE4iwnU1s0jWhaWEEjEV10hDNTbYepUxqjvPrXuOxRvR2+jiyaByLWGNnf9aBxsJYBZ7lGilHn6+dUhui4Jf7VPWDt5O2sD6jclyCodRY9/sFjTczls+gMwXFoewO7MJwyfE/QparHNCUohmuUcwgFcoXNna5hnMn6CDgRZtNQ6h72d3hvE/sb39rvbsz3EI73ADNa7/Bv//c/Wo87MMxhRexz5F2vX1F49KEObM1L2bOnZRrpYqkkKUqt/5bzD6PqO8DWcfPsLF/IzUNheXsrAZmuMWulHbGavCmGCT1f6+WdMMelfXV8gdn19wf4NOBXr2M0+PSK/64mEcr3FgfKkQ4hH1ynHnTZt/A+9Mez5dHkwCy3VYs30+/KTel9dd411y/f7LHezzPsOt0eU6itw2w+I7v0VaaCJvXdySNLQqj694J/V2d5/0eOvEbaZbjqV6/a82eYzTG9LUVQERU0G/45biIqNE6ZtXqCA/gSTD6RjQRijVOnnZ5Kb/hBb/0L9ipZ2Soz05z0clLyregySYGviEj6zBDunZQX7eyoJbCN4jHROh/62oDI3bCzDdlT+8pwGZ40WDGKWkArliGsxKS6pdKK/mXbj2qlHLzL258Zzj9hIcLPa6YSvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(81166007)(40480700001)(86362001)(356005)(103116003)(54906003)(40460700003)(110136005)(316002)(16576012)(5660300002)(33716001)(7406005)(44832011)(70586007)(8676002)(70206006)(7416002)(4326008)(478600001)(41300700001)(8936002)(36860700001)(83380400001)(82740400003)(9686003)(47076005)(2906002)(26005)(186003)(82310400005)(426003)(16526019)(336012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:37:25.6995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8f576c-ccd0-4981-3eb3-08dad3b1f290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration for mbm_local_bytes can be changed by=0A=
the user by writing to the configuration file=0A=
/sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.=0A=
=0A=
The event configuration settings are domain specific and will affect all=0A=
the CPUs in the domain.=0A=
=0A=
Following are the types of events supported:=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits   Description=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6      Dirty Victims from the QOS domain to all types of memory=0A=
5      Reads to slow memory in the non-local NUMA domain=0A=
4      Reads to slow memory in the local NUMA domain=0A=
3      Non-temporal writes to non-local NUMA domain=0A=
2      Non-temporal writes to local NUMA domain=0A=
1      Reads to memory in the non-local NUMA domain=0A=
0      Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
For example:=0A=
To change the mbm_local_bytes_config to count all the non-temporal writes=
=0A=
on domain 0, the bits 2 and 3 needs to be set which is 1100b (in hex 0xc).=
=0A=
Run the command.=0A=
    $echo  0=3D0xc > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config=0A=
=0A=
To change the mbm_local_bytes to count only reads to local NUMA domain 1,=
=0A=
the bit 0 needs to be set which 1b (in hex 0x1). Run the command.=0A=
    $echo  1=3D0x1 > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   29 ++++++++++++++++++++++++++++=
-=0A=
 1 file changed, 28 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 8a22a652a6e8..6897c480ae55 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1641,6 +1641,32 @@ static ssize_t mbm_total_bytes_config_write(struct k=
ernfs_open_file *of,=0A=
 	return ret ?: nbytes;=0A=
 }=0A=
 =0A=
+static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,=
=0A=
+					    char *buf, size_t nbytes,=0A=
+					    loff_t off)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+	int ret;=0A=
+=0A=
+	/* Valid input requires a trailing newline */=0A=
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')=0A=
+		return -EINVAL;=0A=
+=0A=
+	cpus_read_lock();=0A=
+	mutex_lock(&rdtgroup_mutex);=0A=
+=0A=
+	rdt_last_cmd_clear();=0A=
+=0A=
+	buf[nbytes - 1] =3D '\0';=0A=
+=0A=
+	ret =3D mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);=0A=
+=0A=
+	mutex_unlock(&rdtgroup_mutex);=0A=
+	cpus_read_unlock();=0A=
+=0A=
+	return ret ?: nbytes;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1748,9 +1774,10 @@ static struct rftype res_common_files[] =3D {=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mbm_local_bytes_config",=0A=
-		.mode		=3D 0444,=0A=
+		.mode		=3D 0644,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_local_bytes_config_show,=0A=
+		.write		=3D mbm_local_bytes_config_write,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
=0A=

