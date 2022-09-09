Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55175B3E84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiIISFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiIISFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:05:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F1C6E890;
        Fri,  9 Sep 2022 11:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ/zvXvIwpJr/eQU8oUnlIeSb25Pg63vJziQ74YOYUKFEv3Q5eAhxzghSlvJqm8eo+D1RVoKlOXHXjqzUNGE8wXNUwQwQS7IES9QScXWTA0UgG7sRCvO//TYOn5pOcgOTm4jupv+ZWG0kncazxf0MKr/OUXfRoXF1cIR/Csdg8OWg+bAdCOwRwfNrx8qJNL9LT6P4d9mDzJs+AingfDZtf5ib0NIrhmx6kyv9cWg5I4dxZGX4jWoGW373MXlEjGg3tfIn/Gamb1RGZ8knnNSa6ths3IjqCL/63vU/vCv237SPAUQrwLtRu68bSaiFMpygrTH7k6uSD7DFmwjDQcIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nQHF6cihPA7KZzNPRqdBCkFrOZ7QaWnoOMuPXT3MDw=;
 b=HIotHWNcZW/8dHJm5lsa+r1EcQDnA1vD4l5bwwEmc7PePT88B/FQf1D6mqvQMwRZgd2c5iTalNFBG64Y4KL31WrcYs6TTlw+WVfgM3LAER8uxzTa2XMcS8VYLcZIoSldvm/xStf5I0McDRI6g0ASN42FI81Ub4VIUiOUJPJVFTt+M4zSY5zrQh8TN37TxEiP9ej0s7r6/+VI5mPpwCTxvykqyjgPz8e2m4jDbkocwyYahjUkNg24D+Zzq2QNegMUNG4LKX8GI+gsuaxrBJ0dt98m9lnoJpPz/CTVaMN+IjeE/SGUrLv9Y1c6aLu6aL6DnikD/X466EqrUyXq/0+JpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nQHF6cihPA7KZzNPRqdBCkFrOZ7QaWnoOMuPXT3MDw=;
 b=SqoFjlc6YIHSbIWz+Xnek8V9vJbWPa4ep0YjPv++zTSe3/EEFMequzRwZ5ykyWGJqqlSblAFYqin1g283p+TrU5dVbKIE5Luj1++BGIkT5saiVUFSXhxNRVWgwcbRrcV+q8QEJwVEsCPXofi2gep6qfUFAH0z2HyA+QvD8wKvAs=
Received: from DM6PR11CA0045.namprd11.prod.outlook.com (2603:10b6:5:14c::22)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 18:05:26 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d3) by DM6PR11CA0045.outlook.office365.com
 (2603:10b6:5:14c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 18:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 18:05:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 13:05:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 2/4] acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
Date:   Fri, 9 Sep 2022 13:05:07 -0500
Message-ID: <20220909180509.638-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909180509.638-1-mario.limonciello@amd.com>
References: <20220909180509.638-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: efde9137-a3c9-436f-a9f6-08da928ddf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6XJ4OGSUCpo4wgFt+i9HzmnTyiIClUKGNOKkfNOtBG9L1nxFoKPywTkvYa4W4wqtXMNquxGkyQoT6YCzzbaqrsj7+NoXhyt33XDTZOAKvQmxGG7qrGE0+159CWOXhDXXNvO0hZXjo9zlh+sipwFEmCFwto5s+Wxxfx7AtgfmgZMuEK+w2jcqnXjsdiMB8E8uXYjTM6RxFWhcmtRchwYVU9oNOsYCqlhDv2fBwwiH06tXHqC/4NT+N4THAwBLt1E1xr75O+n0z2X9fiEtjm+bsJwVmw9EV3H3dfn2Yahh8Q7vYj/a8AI50fjgu/hC/hlirRxCyCbiWy6j1yLOLRPLwwIZOkY1o2l6oTxaGAL8115Z7Q7G4dMlQ5Dl3/kJwqyyao+IubBMVRkepKA63emcJOA0qUidW7QU/5bwbYiNXY6GHnygpCrPysV20jAlcSDZmjxRHYyNUAJgI5ilmMOk+WNo+9f86RXB7JLBe/tgc5i8J4xLkTbY+3O88F27TZUaqKoDRnzP4CLSWLWplXftvdDLGSmFoKOJI2y7iK98IefnS/maO2jwlJkThQjkpOnUF+Uc21Q8YCSkYvJtvEZejTfc1Rf/8fF6tX4LydnI5Ue9Hc9f8LnoyUVgLsEab6CQKn3vHWlCfM2TTfKhtCYdXKP+3xeewuCPJSVvbmvkVicXe2rFmBGc27b+TLoaJZMkKjSK7yQ5Wwml0LAqxd7pTWbs0rEQJ8ykexOOT3pYy527H+JMXGQYK9BE1RuVoSlo9RrY0AjPjmyrwohl+SJln4WFJUEgZfXmq1xlYvDY0Ui/EJmj6sCYbvzNihFy0Cn
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(36840700001)(46966006)(40470700004)(83380400001)(8936002)(36860700001)(426003)(1076003)(2616005)(336012)(186003)(16526019)(110136005)(41300700001)(6666004)(478600001)(26005)(316002)(47076005)(7696005)(54906003)(36756003)(4326008)(44832011)(4744005)(5660300002)(40460700003)(8676002)(82740400003)(2906002)(70586007)(70206006)(81166007)(356005)(82310400005)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:05:26.1434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efde9137-a3c9-436f-a9f6-08da928ddf65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mistake was made that only AMDI0007 was set to rev of "2", but
it should have been also set for AMDI008. If an ID is missing from
the _HID table, then assume it matches Rembrandt behavior.

This implicitly means that if any other behavior changes happen
in the future missing IDs must be added to that table.

Tested-by: catalin@antebit.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index a7757551f750..a8256e5a0e8a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -412,7 +412,7 @@ static int lps0_device_attach(struct acpi_device *adev,
 		if (dev_id != NULL)
 			data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;
 		else
-			return 0;
+			data = &amd_rembrandt;
 		rev_id = data->rev_id;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
-- 
2.34.1

