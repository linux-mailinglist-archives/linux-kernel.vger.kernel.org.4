Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8A601C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJQW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJQW0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:26:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BE222A3;
        Mon, 17 Oct 2022 15:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et0BfOcT3WtHaq3SVoiPJwQIuVy/uPvTcvUgrei7JHVzZLgQ3D+WhwZDY98Oyvq0OagfjF/48/lKVbkYfANnk3WLuU4cVTYjcKlPXsPUwFbhWg9tnNeNepZNBvtfjhIaMuwmlZ6v1vtQjwfeCRujzUDPr9uOtykPsf2OKXsXD6GV2GcFcJaTnQQGzaHBkQTuo6RqD17YBHNBHVv3H0XMFCs2SeY9RDlCiHIQfHWtO0wWH87ViKgpjf6VVQRkuCCoLxnYekWE30200MZdqK4KIf5rLMubzHe7V0KwtgKr5ZUZpA9qUzz7obtrblMGqvKDL8e+Bnqdi3k1LoNWGAL+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNUJ5tAytxZchKfhPCwq0OtyD8BOQn2coGJIca5m4Z4=;
 b=MLUDQn3BIeYMoSVKseBx4OMj9T7F57aLHLfK/9bKlSZqfcyXFgdaSwqEv4/3X34PFmJ32HxPSQPalEqnjRM4QzTRHMkR1yi8Z51hTVQX56V7S4ShnecnB2mXtOMGm6Ouy3yoxqW6oZkVZIfrIUznEx4y0TAi7Rvt95OGARm+0z75Af6al+NeC0ZLRhSRg0osGVFE4SHMSE0SXhze50TXYWOHznCxwNvuVnuR7Qh/ZRC/CzMRPHXw+Jfil8h3mfxU/JpKKm/BCRlsH5GlzcfRxygS3Q9zc4I0v3Qs2z7BDq7R1c3ts4SyKIwDQyZxWU+wHm+yJireG2uG5yK5HRpmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNUJ5tAytxZchKfhPCwq0OtyD8BOQn2coGJIca5m4Z4=;
 b=VI1Ek9yDfwjRZb28JvnTDhMSPrbJtNUbAjbFC3DIsw4/BW559PV7cRkqXJdmaEn8RIw2zq8h9o3kiwgT3DLYVA6SHF5ZdJRvCgWLXJGEdaqNkXWha91T5oo8KW8tZbw6QfvaTX8W0ognFfrcg/e6aSSYctJx3IZnIlN/M02y4JQ=
Received: from BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::35)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 22:26:07 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::7f) by BN9P221CA0018.outlook.office365.com
 (2603:10b6:408:10a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 22:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:26:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:26:04 -0500
Subject: [PATCH v7 00/12] x86/resctrl: Support for AMD QoS new features
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
Date:   Mon, 17 Oct 2022 17:25:58 -0500
Message-ID: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d92a653-580f-4777-ebcf-08dab08e9556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9CtWe13pPwV2a2VjbvXF+f9I2xJAy4Q3B4FHVQOkuhEgNlI9PUgFqyQVGhrJjL+eHttWbSfF4959fYtCM+hCG4XQITCjdSHeH6hxr/4jBRf1cjIkichlp9H8huGFE/fZQrsp8N2IE+AkZDsc4gdxSpXfnP7LsEkkxtsdjg9X6AJBkbVFXZi8KFrQaBn4xRP4Z3TW9QK35NiK3tkpJMH/eoDC1vIsSylclAgL8RIBllN25lAA125xgVgNutAQtsoKc4V3Mhw/XU9qfIMQsPaeWvA8z+Ib44fGGHHo89T8gKVioFn+7QrbtrPA4w+5pSJ3ZLvWjagENpDcj1pvnMpue6XpPL3dCVkwsh4UjtylAj6IL2Q3e0/jCFVxDZB1sq/lIu4L8//idEIN0H3r9sLLo3wISHuCOjukKYkv+xD8rAbt8Yavypwymtyj+ov1j6IbOnvvRJeophs+1OPR3JdT4CZ+MNAkP5fKsbOAD7uCQObqmC/L+LPzshPocoDEzoNAHL2g42zb282oo0cbUKjr0CJKwGeK5RDwc4YZ/ArcxaZFVoqWnTiCffPjBRgx6GQOBCncnp2/ADBJ6pnC1Qz4/Vu0ecqcmqzAWe8FNqYdnUuNV4xLCVHOrcqTHX1xJfd4cqFVFdeAPx0XvyHvDsvZBvubDm91TGfMoHyNoxgHcTO8yeQPle/lrX2aMQfu+hS3bxQA5O+wN++8QP0PkGWnKF/NnLuwBYLl/GxvYrceALq1Z6FV27kxUd6GWTCb9+BywDUatM61mgoSEq8wKCF4MUTkZJQB+aqqHjgdIiL7nOsayBgUGu2ZYxGXvuEuLSv8AT94oNoY10hLZTrWYaBd/2mYbsXiASVYZtrZ+cUmqE2EtpC4i3RB0VWbOOKP8FLYwFZbRMO3ah7WFJqRz6elA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(82740400003)(6666004)(41300700001)(82310400005)(16576012)(316002)(26005)(5660300002)(54906003)(110136005)(40460700003)(8936002)(9686003)(40480700001)(356005)(81166007)(966005)(4326008)(33716001)(478600001)(44832011)(103116003)(70586007)(8676002)(7416002)(83380400001)(70206006)(47076005)(426003)(186003)(16526019)(2906002)(36860700001)(336012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:26:06.3224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d92a653-580f-4777-ebcf-08dab08e9556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New AMD processors can now support following QoS features.=0A=
=0A=
1. Slow Memory Bandwidth Allocation (SMBA)=0A=
   With this feature, the QOS enforcement policies can be applied=0A=
   to the external slow memory connected to the host. QOS enforcement=0A=
   is accomplished by assigning a Class Of Service (COS) to a processor=0A=
   and specifying allocations or limits for that COS for each resource=0A=
   to be allocated.=0A=
=0A=
   Currently, CXL.memory is the only supported "slow" memory device. With=
=0A=
   the support of SMBA feature the hardware enables bandwidth allocation=0A=
   on the slow memory devices.=0A=
=0A=
2. Bandwidth Monitoring Event Configuration (BMEC)=0A=
   The bandwidth monitoring events mbm_total_event and mbm_local_event =0A=
   are set to count all the total and local reads/writes respectively.=0A=
   With the introduction of slow memory, the two counters are not enough=0A=
   to count all the different types are memory events. With the feature=0A=
   BMEC, the users have the option to configure mbm_total_event and=0A=
   mbm_local_event to count the specific type of events.=0A=
=0A=
   Following are the bitmaps of events supported.=0A=
   Bits    Description=0A=
     6       Dirty Victims from the QOS domain to all types of memory=0A=
     5       Reads to slow memory in the non-local NUMA domain=0A=
     4       Reads to slow memory in the local NUMA domain=0A=
     3       Non-temporal writes to non-local NUMA domain=0A=
     2       Non-temporal writes to local NUMA domain=0A=
     1       Reads to memory in the non-local NUMA domain=0A=
     0       Reads to memory in the local NUMA domain=0A=
=0A=
This series adds support for these features.=0A=
=0A=
Feature description is available in the specification, "AMD64 Technology Pl=
atform Quality of Service Extensions, Revision: 1.03 Publication # 56375=0A=
Revision: 1.03 Issue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
---=0A=
v7:=0A=
 Changes:=0A=
 Not much of a change. Missed one comment from Reinette from v5. Corrected =
it now.=0A=
 Few format corrections from Sanjaya.=0A=
=0A=
v6:=0A=
 https://lore.kernel.org/lkml/166543345606.23830.3120625408601531368.stgit@=
bmoger-ubuntu/=0A=
 Summary of changes:=0A=
 1. Rebased on top of lastest tip tree. Fixed few minor conflicts.=0A=
 2. Fixed format issue with scattered.c.=0A=
 3. Removed config_name from the structure mon_evt. It is not required.=0A=
 4. The read/write format for mbm_total_config and mbm_local_config will be=
 same=0A=
    as schemata format "id0=3Dval0;id1=3Dval1;...". This is comment from Fe=
nghua.=0A=
 5. Added more comments MSR_IA32_EVT_CFG_BASE writng.=0A=
 5. Few text changes in resctrl.rst =0A=
 =0A=
v5:=0A=
  https://lore.kernel.org/lkml/166431016617.373387.1968875281081252467.stgi=
t@bmoger-ubuntu/=0A=
  Summary of changes.=0A=
  1. Split the series into two. The first two patches are bug fixes. So, se=
nt them separate.=0A=
  2. The config files mbm_total_config and mbm_local_config are now under=
=0A=
     /sys/fs/resctrl/info/L3_MON/. Removed these config files from mon grou=
ps.=0A=
  3. Ran "checkpatch --strict --codespell" on all the patches. Looks good w=
ith few known exceptions.=0A=
  4. Few minor text changes in resctrl.rst file. =0A=
=0A=
v4:=0A=
  https://lore.kernel.org/lkml/166257348081.1043018.11227924488792315932.st=
git@bmoger-ubuntu/=0A=
  Got numerios of comments from Reinette Chatre. Addressed most of them. =
=0A=
  Summary of changes.=0A=
  1. Removed mon_configurable under /sys/fs/resctrl/info/L3_MON/.  =0A=
  2. Updated mon_features texts if the BMEC is supported.=0A=
  3. Added more explanation about the slow memory support.=0A=
  4. Replaced smp_call_function_many with on_each_cpu_mask call.=0A=
  5. Removed arch_has_empty_bitmaps=0A=
  6. Few other text changes.=0A=
  7. Removed Reviewed-by if the patch is modified.=0A=
  8. Rebased the patches to latest tip.=0A=
=0A=
v3:=0A=
  https://lore.kernel.org/lkml/166117559756.6695.16047463526634290701.stgit=
@bmoger-ubuntu/=0A=
  a. Rebased the patches to latest tip. Resolved some conflicts.=0A=
     https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git=0A=
  b. Taken care of feedback from Bagas Sanjaya.=0A=
  c. Added Reviewed by from Mingo.=0A=
  Note: I am still looking for comments from Reinette or Fenghua.=0A=
=0A=
v2:=0A=
  https://lore.kernel.org/lkml/165938717220.724959.10931629283087443782.stg=
it@bmoger-ubuntu/=0A=
  a. Rebased the patches to latest stable tree (v5.18.15). Resolved some co=
nflicts.=0A=
  b. Added the patch to fix CBM issue on AMD. This was originally discussed=
=0A=
     https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.c=
om/=0A=
=0A=
v1:=0A=
  https://lore.kernel.org/lkml/165757543252.416408.13547339307237713464.stg=
it@bmoger-ubuntu/=0A=
=0A=
Babu Moger (12):=0A=
      x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag=0A=
      x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA=0A=
      x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature=
 flag=0A=
      x86/resctrl: Include new features in command line options=0A=
      x86/resctrl: Detect and configure Slow Memory Bandwidth allocation=0A=
      x86/resctrl: Introduce data structure to support monitor configuratio=
n=0A=
      x86/resctrl: Add sysfs interface to read mbm_total_bytes event config=
uration=0A=
      x86/resctrl: Add sysfs interface to read mbm_local_bytes event config=
uration=0A=
      x86/resctrl: Add sysfs interface to write mbm_total_bytes event confi=
guration=0A=
      x86/resctrl: Add sysfs interface to write mbm_local_bytes event confi=
guration=0A=
      x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()=
=0A=
      Documentation/x86: Update resctrl.rst for new features=0A=
=0A=
=0A=
 .../admin-guide/kernel-parameters.txt         |   2 +-=0A=
 Documentation/x86/resctrl.rst                 | 139 +++++++-=0A=
 arch/x86/include/asm/cpufeatures.h            |   2 +=0A=
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +=0A=
 arch/x86/kernel/cpu/resctrl/core.c            |  51 ++-=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h        |  31 +-=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c         |   7 +-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 313 ++++++++++++++++--=0A=
 arch/x86/kernel/cpu/scattered.c               |   2 +=0A=
 10 files changed, 513 insertions(+), 37 deletions(-)=0A=
=0A=
--=0A=

