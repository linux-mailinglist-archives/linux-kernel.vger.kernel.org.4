Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169B761A1D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKDUCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKDUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:01:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D34AF3F;
        Fri,  4 Nov 2022 13:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOscMAck0Sx2lzrEBhfUpbA1hTxmqP/64ZRPqMc/6dFOMEM4RhEIc6MLBbtZNO8rUkghhIycqWWmCFgi619hblSzSsQJyShoevrzVJPIfjekybelytWzbgXCcrpThs7YCfXOS4002Rd9SwcgL8tbOyNfFHO152jQyZlg3cTAoLA2BQ3cT4VOTnBWvKaDVIeKPjh537JPzODolh17hF7oBZse3Q+jenSODhQCRPrY49l4VPDtC+jW1CmbP2g09qKjiaY+iqddPsB8mo4eDWlIzTjM35yeHg7oHRisb7o21QZtHsYCHKYtkG+JbV9sfQ8LiVV3hEp2I/7g9v5HfbV5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+s4l4zkGjAI//GM6I9DveLbzsB6+BhZ4ms4R4KpxxNE=;
 b=VeR9OM+t9grn9NuXePRb/jat9m2hFJHGzWVDln05bJ/gLKIs3I+fDw7CKXt1rK6xaB0v1uFbw7HSV4U6TFm5LMay3NJ0PJDToID0SpoA/hozcMoufn1hv5Pe7D4cJS6Cy18NEYj8qiJlOCDFp9QqrZ1OOigk6z6xaDV+1S/NrsQG/i2bKtN4UcylRAqIn/RFuQVukpLAT8hxtJspnUw957DukWy8hsIId85v29/q0QE5/q0dPFN3kaaEb1HFuVlbXgndjNT66lW7bNRwgPxQFCTUb4nBdogQxp4Rd72hH0R403SBltFZkm7Dp7xO3mqd0P33DVdUTv4wI1a/SEG4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s4l4zkGjAI//GM6I9DveLbzsB6+BhZ4ms4R4KpxxNE=;
 b=wLnjMCtKLLY6nUdtj1QcMAqQj9s/LBWfdj5tWbBTIjR1Dwy6zxb/2wsmENN5P3mMrassz8hqjlhJNIZ8zR2ahwyhWBuvYwxyeE55+lmKPxfV1aEmEuT9Js8b0gcFCmAdire8bHEXaUFoArHasGVjtrhAgupV6i7WZGfpmDB2s1U=
Received: from DM6PR11CA0059.namprd11.prod.outlook.com (2603:10b6:5:14c::36)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 20:01:32 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::db) by DM6PR11CA0059.outlook.office365.com
 (2603:10b6:5:14c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 20:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:01:32 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:01:30 -0500
Subject: [PATCH v8 13/13] Documentation/x86: Update resctrl.rst for new
 features
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
Date:   Fri, 4 Nov 2022 15:01:29 -0500
Message-ID: <166759208987.3281208.3199784740546752454.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: c256ef78-ce43-4667-f48a-08dabe9f5ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NLPLuCUHvmPR8lPctqdDaVPWas8HS79j1dFqQ0cjh6xfz5qSsz3aDW9DngRxYX1vxi4WIf0jIY/vq6XChnjKhsdwfU3RZ+P1adUbFfHh+loL0HVreHUKy/s4eULmtUHL9voJCZjT7nsXhB9cl//FjrtY9UzCcCgY5mEVhYhvXUZOG8TSHBKAmyvRYf0FE+MSgoAdpZEvOBiR2Y7ALqM9VUbi94sWx6G/QJ5W7ZMv/5J8U3lSdMVJFE+dcHM70qqsJq7AMqDu5RkQznBIyLA/KPhaUozwqVTNXSBhLpp9VflPJ7fKjqe3hEm3i+Pke0fNp+7KEwb2DNyoPThrcigkSpXD3WCxtTwTUkiqbH6cwkR6B4Fs5rrpIDoySCvfw/XrQq8mJioM3Ycmy68YokmPf4O3bk54q6fVAgwhPvLkZW4KEKiKJGh1czx2eH5LihYx7xijH4ToGkpEIpY3rcxa4RUlbDsMIGDxsWy33ZjZdgbgy7+W6p3dhkbADXgeP86Hfl2KmGMF/TFi3XmKNWzZveM/ybv2CeWEz/OM04ai1VnvnY9EL914KR0uWHk+RbD4oGWlun6/Aui3eIWR2DKs2jE1x+hI92Vz3/hHyN4YVy5V5AcYUA5U9nOBkPpsSA++08BPoitxqBV8uCn1ksyTUzxfdUXK9jjxYuTzfpblKwW0a33AaL4fERVTJwjIuzoy1DloaEZb2W7dAGGsVhghpLu3rbAjnStZrLvi7Cd2VYhXwSBJuXrNCv2KdH9heguyshLmL0gB8XnkDJB97+lcCPD8dwo/v3mptKMB8Tb+ofT+MH1UO8PatvhWoE5C9C5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(33716001)(110136005)(26005)(86362001)(82310400005)(356005)(81166007)(103116003)(40480700001)(7416002)(36860700001)(41300700001)(9686003)(8676002)(4326008)(70586007)(70206006)(186003)(44832011)(336012)(8936002)(16526019)(478600001)(5660300002)(54906003)(15650500001)(40460700003)(316002)(16576012)(82740400003)(83380400001)(47076005)(426003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:01:32.2708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c256ef78-ce43-4667-f48a-08dabe9f5ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation for the new features:=0A=
1. Slow Memory Bandwidth allocation (SMBA).=0A=
   With this feature, the QOS  enforcement policies can be applied=0A=
   to the external slow memory connected to the host. QOS enforcement=0A=
   is accomplished by assigning a Class Of Service (COS) to a processor=0A=
   and specifying allocations or limits for that COS for each resource=0A=
   to be allocated.=0A=
=0A=
2. Bandwidth Monitoring Event Configuration (BMEC).=0A=
   The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes=0A=
   are set to count all the total and local reads/writes respectively.=0A=
   With the introduction of slow memory, the two counters are not=0A=
   enough to count all the different types of memory events. With the=0A=
   feature BMEC, the users have the option to configure mbm_total_bytes=0A=
   and mbm_local_bytes to count the specific type of events.=0A=
=0A=
Also add configuration instructions with examples.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst |  139 +++++++++++++++++++++++++++++++++++++=
+++-=0A=
 1 file changed, 137 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 71a531061e4e..12adba98afc5 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of S=
ervice(AMD QoS).=0A=
 This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cp=
uinfo=0A=
 flag bits:=0A=
 =0A=
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
 RDT (Resource Director Technology) Allocation	"rdt_a"=0A=
 CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"=0A=
 CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"=0A=
 CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"=0A=
 MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"=0A=
 MBA (Memory Bandwidth Allocation)		"mba"=0A=
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A=
+SMBA (Slow Memory Bandwidth Allocation)         "smba"=0A=
+BMEC (Bandwidth Monitoring Event Configuration) "bmec"=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
 =0A=
 To use the feature mount the file system::=0A=
 =0A=
@@ -161,6 +163,79 @@ with the following files:=0A=
 "mon_features":=0A=
 		Lists the monitoring events if=0A=
 		monitoring is enabled for the resource.=0A=
+                Example::=0A=
+=0A=
+                   # cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
+                   llc_occupancy=0A=
+                   mbm_total_bytes=0A=
+                   mbm_local_bytes=0A=
+=0A=
+                If the system supports Bandwidth Monitoring Event=0A=
+                Configuration (BMEC), then the bandwidth events will=0A=
+                be configurable. The output will be::=0A=
+=0A=
+                   # cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
+                   llc_occupancy=0A=
+                   mbm_total_bytes=0A=
+                   mbm_total_bytes_config=0A=
+                   mbm_local_bytes=0A=
+                   mbm_local_bytes_config=0A=
+=0A=
+"mbm_total_bytes_config", "mbm_local_bytes_config":=0A=
+        These files contain the current event configuration for the events=
=0A=
+        mbm_total_bytes and mbm_local_bytes, respectively, when the=0A=
+        Bandwidth Monitoring Event Configuration (BMEC) feature is support=
ed.=0A=
+        The event configuration settings are domain specific and will affe=
ct=0A=
+        all the CPUs in the domain.=0A=
+=0A=
+        Following are the types of events supported:=0A=
+=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+        Bits    Description=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+        6       Dirty Victims from the QOS domain to all types of memory=
=0A=
+        5       Reads to slow memory in the non-local NUMA domain=0A=
+        4       Reads to slow memory in the local NUMA domain=0A=
+        3       Non-temporal writes to non-local NUMA domain=0A=
+        2       Non-temporal writes to local NUMA domain=0A=
+        1       Reads to memory in the non-local NUMA domain=0A=
+        0       Reads to memory in the local NUMA domain=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+=0A=
+        By default, the mbm_total_bytes configuration is set to 0x7f to co=
unt=0A=
+        all the event types and the mbm_local_bytes configuration is set t=
o=0A=
+        0x15 to count all the local memory events.=0A=
+=0A=
+        Examples:=0A=
+=0A=
+        * To view the current configuration::=0A=
+          ::=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config=0A=
+            0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config=0A=
+            0=3D0x15;1=3D0x15;3=3D0x15;4=3D0x15=0A=
+=0A=
+        * To change the mbm_total_bytes to count only reads on domain 0,=
=0A=
+          the bits 0, 1, 4 and 5 needs to be set, which is 110011b in bina=
ry=0A=
+          (in hexadecimal 0x33):=0A=
+          ::=0A=
+=0A=
+            # echo  "0=3D0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_byt=
es_config=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config=0A=
+            0=3D0x33;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
+=0A=
+        * To change the mbm_local_bytes to count all the slow memory reads=
 on=0A=
+          domain 0 and 1, the bits 4 and 5 needs to be set, which is 11000=
0b=0A=
+          in binary (in hexadecimal 0x30):=0A=
+          ::=0A=
+=0A=
+            # echo  "0=3D0x30;1=3D0x30" > /sys/fs/resctrl/info/L3_MON/mbm_=
local_bytes_config=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config=0A=
+            0=3D0x30;1=3D0x30;3=3D0x15;4=3D0x15=0A=
 =0A=
 "max_threshold_occupancy":=0A=
 		Read/write file provides the largest value (in=0A=
@@ -464,6 +539,26 @@ Memory bandwidth domain is L3 cache.=0A=
 =0A=
 	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...=0A=
 =0A=
+Slow Memory Bandwidth Allocation (SMBA)=0A=
+---------------------------------------=0A=
+AMD hardware support Slow Memory Bandwidth Allocation (SMBA) feature.=0A=
+Currently, CXL.memory is the only supported "slow" memory device.=0A=
+With the support of SMBA, the hardware enables bandwidth allocation=0A=
+on the slow memory devices. If there are multiple such devices in the=0A=
+system, the throttling logic groups all the slow sources together=0A=
+and applies the limit on them as a whole.=0A=
+=0A=
+The presence of SMBA (with CXL.memory) is independent of slow memory=0A=
+devices presence. If there is no such devices on the system, then=0A=
+setting the configuring SMBA will have no impact on the performance=0A=
+of the system.=0A=
+=0A=
+The bandwidth domain for slow memory is L3 cache. Its schemata file=0A=
+is formatted as:=0A=
+::=0A=
+=0A=
+	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...=0A=
+=0A=
 Reading/writing the schemata file=0A=
 ---------------------------------=0A=
 Reading the schemata file will show the state of all resources=0A=
@@ -479,6 +574,46 @@ which you wish to change.  E.g.=0A=
   L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff=0A=
   L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff=0A=
 =0A=
+Reading/writing the schemata file (on AMD systems)=0A=
+--------------------------------------------------=0A=
+Reading the schemata file will show the current bandwidth limit on all=0A=
+domains. The allocated resources are in multiples of one eighth GB/s.=0A=
+When writing to the file, you need to specify what cache id you wish to=0A=
+configure the bandwidth limit.=0A=
+=0A=
+For example, to allocate 2GB/s limit on the first cache id:=0A=
+=0A=
+::=0A=
+=0A=
+  # cat schemata=0A=
+    MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+  # echo "MB:1=3D16" > schemata=0A=
+  # cat schemata=0A=
+    MB:0=3D2048;1=3D  16;2=3D2048;3=3D2048=0A=
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+Reading/writing the schemata file (on AMD systems) with SMBA feature=0A=
+--------------------------------------------------------------------=0A=
+Reading and writing the schemata file is the same as without SMBA in=0A=
+above section.=0A=
+=0A=
+For example, to allocate 8GB/s limit on the first cache id:=0A=
+=0A=
+::=0A=
+=0A=
+  # cat schemata=0A=
+    SMBA:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+  # echo "SMBA:1=3D64" > schemata=0A=
+  # cat schemata=0A=
+    SMBA:0=3D2048;1=3D  64;2=3D2048;3=3D2048=0A=
+      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
 Cache Pseudo-Locking=0A=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 CAT enables a user to specify the amount of cache space that an=0A=
=0A=

