Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D602E61A1CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKDUCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiKDUB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:01:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251B4B996;
        Fri,  4 Nov 2022 13:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbAbuQoaYIYvbAVKw0sNu1IezEX2udmPokc8D0FVgK8eaz4J2e4Py3BFyzA0joQx+5arxwvuhWRubIuRe2CxL4tG6PMKNMSXbH6oIZSFIIOMWZY/mrHwGS5CmR8JlsKikIFiM9HV8kTsiHX8tMMj9fU0Lw21qR8vIfgmBJmIoOS43MsBFr7MgPidCziuCqI18b6o8NqPvADi2/ZzMzVD9n6rQiucN8H5njbXKO3eG2VJ0xovPQXzlDIqda6CAyEMHs93+XWhI5uk8HuWpKMJHBCF8lyUaCkpEFwFGFfDdX/RAzLnIFhyyYyMTt0TcUBQW6ILc6PO+MkGK67T9nzoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwWna5ohYvk6/hKT2RmHI9Xdzj9jtWfTFAzrIAfz3hI=;
 b=fr3iARF92gRpitQFYSaeev0BqD1prDK2V/KD30YhqB/6i75fguVeVkbQ5KHhWNK75EAvSnyhUoxn7cVKf30Fj+G/g0xpqEmVMxrPFEQTNZPI6kKjoluN3fYENRjQZjcdd3pOQ5mj3uMNyWdFTgX4uN3+8ieL+3Jww9jsP+q/xV2fvHqIG4JSj4Vec77iqp4xpfoCZWvrvJAoGYQKQJIWUoQcFOktKrW7t6s7SdWlUuc+Xqoh1ts5/DFvtL9FQZaxMgL4nbh5f/mf2w+SsGTsXjCn08lfaOqFup/noOnbvS6rJpfb3sFzxNeSEJdRMX+EsqYKMQ3LSG78G8Qq/Yjmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwWna5ohYvk6/hKT2RmHI9Xdzj9jtWfTFAzrIAfz3hI=;
 b=HBVrw3oc6lbK8U9OgSRhuQPKI4UwasYNTQK4RTWqb5PPzpUvo0pSfO7H5rlC3QXXAsxZiIxasKbuCJFTowDd8QltrjDi6CztKsoHHpJ/84/a6ph1xfciRStCZLQT69fk7KqWfn7GW0Y3cYOwUksYYHeQdqFf+Epy8nY/tFOhtiQ=
Received: from DM6PR02CA0136.namprd02.prod.outlook.com (2603:10b6:5:1b4::38)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 20:01:19 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::33) by DM6PR02CA0136.outlook.office365.com
 (2603:10b6:5:1b4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23 via Frontend
 Transport; Fri, 4 Nov 2022 20:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:01:18 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:01:16 -0500
Subject: [PATCH v8 11/13] x86/resctrl: Add sysfs interface to write
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
        <eranian@google.com>
Date:   Fri, 4 Nov 2022 15:01:16 -0500
Message-ID: <166759207601.3281208.770005576930282516.stgit@bmoger-ubuntu>
In-Reply-To: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 39dac42e-b12f-4585-e63c-08dabe9f5663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYb+W8AtB4KF0Y40ugVd3+JteoOjYSfgrzVJVmi2G96Ul5xV5brCzembHHppZ523hBZcuxu/1JQcMwM6bI4kNK0ArOWONI4ZhHYDL37Pyj/ldeW9xJT1c0Q7IZHQdrCj79JxVAKxl3puwfEEp8V8FpMF9Nj/fuIAuzdBpHwEfCSoOG/lISDmxf7zYantRHzORNIOlSBcX2XemJT0qCJiTNKwuaOQrTlid26bsATkiz2Q+9ogTvx2AobpC1CTTvd1eVEdZaOmn3Q4IEu7MgVL6Vuemi9Z555BeIJUcr0I57t+2eTmq3zDlJj1ELigv+D3n45L0gt1u1Z1Kj3ssaVC+Ji4UCY8CfkARcnmC4Dyu7PE4J65TlY7UO8noPSg2oLdV0ys9WcIZC9w0u7HUMmx9a/TEhUafCNySuF3rPecfq5veIX7o5rPcYoW4y0tWZvidAHbKxVPQRqTocbbXW7pp3gAlS6duz1EtwbLcP3W2psL0nV+UNC8tTYa4smCPV+5jvkpco/6SvwilSaC0gxMAy9Bho0mWz7yQ+xlY4PVN238g865Yp3bR8vdMq+1qfbzbXZ7RWolG9bYVja9f+dN2GsEQRfE922cC2ixIOUKXVAbh2ku/CE5ZpRDsQx5Q60rdbT9Zd7EknqvvR4rZj/xRM4j9eHDrjWb6iRZKiWf7R1gZQRnKhsOInmqcsPbVc2792T53FDxdIK4X4ptkNr+7LLGlsTyXlSBOzthTYAD4UbOYQPvL59zWM+49KUwiUkIHn50FDRFGtUgIBWNZI+VPuqsTCIkNjmzVjt1wmvrC7Oub2Dtdu08jlkt2yo8syPq06WirKNNy2igf6zo9J4veQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(44832011)(82740400003)(36860700001)(7416002)(2906002)(86362001)(356005)(47076005)(83380400001)(426003)(5660300002)(103116003)(81166007)(40460700003)(40480700001)(316002)(110136005)(478600001)(9686003)(16576012)(336012)(16526019)(186003)(54906003)(8936002)(41300700001)(4326008)(70586007)(8676002)(70206006)(82310400005)(26005)(33716001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:01:18.4030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dac42e-b12f-4585-e63c-08dabe9f5663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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
index 0cdccb69386e..f37ecc16b34b 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1632,6 +1632,32 @@ static ssize_t mbm_total_bytes_config_write(struct k=
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
+	ret =3D mon_config_parse(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);=0A=
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
@@ -1739,9 +1765,10 @@ static struct rftype res_common_files[] =3D {=0A=
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

