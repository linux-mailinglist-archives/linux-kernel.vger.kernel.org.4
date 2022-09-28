Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4FE5EE1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiI1QUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiI1QTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:19:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6913D25;
        Wed, 28 Sep 2022 09:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpvvRLzIVEAVNj9p+sBNHUP2hL9c/U6ZInFxZCo328hqr6wIFUMNkN0HujrMOam7PZaZ81CBJ+ZtGiQ2jchOk0mqNMiyOpP15+wn8I2snGYwj3WJ+64JILSFXkRFzwsx0D0CiLZyF3EU9cBMKDdhL+SkmTRoYpl99xRJGrj10CA5+PwckXCIo+PttGrsNNLT+LbcqjxSbIZelUqV32h9TCRcmj2OWfbo1Lsg7mIjqjTAdrtytbOdFuMBftc9KCgwjvFqeActZtaUX2rCHjdOlY+BomRjAWjw3glPm6Hx8P0p0scn8lBD8ILdXSIUEDqK9fvGRJGf1UjGmw8KH/QjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k+7E6HTHyze3ptNzYIyuqErFFhmoaB5GkIRRDiZH38=;
 b=lyphxIJfuZFhp5pn8tVC6uCCIbt+tWHKrZgMiNA+LU/1rphGzNVKd2GcozRp+5vcxtBIKT/8z0Cbb0Z6IKClalMAKtM8Np/tnle8qhVTVw3XLSNmDyJCewK8/tTrGUqiAK7qpEFAC3fKZ3dUywUVL5ozE4qUQzvOGt2tdt7IYgQzN081t8N0XspOldPJjjK87TQy96kEqCXoC6OU/ytG6uTaAocs86sy+XuPtxl3oCYHUiRTqnrpr8W/DlJET+Zn4yFKOOsXq5XwMtuoFGpMmSjlwO0MziXDzaRWJb0hfSHu3mxddttiirIr4/S5CMy8UW846t4/EGMlSuVH7qZjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k+7E6HTHyze3ptNzYIyuqErFFhmoaB5GkIRRDiZH38=;
 b=gHsrfHwdOO3zjDOqj1XWFXQTjbNBzXzz6rsJFEHcB+S9ClQ0myJl9D2dWGI1xx5fC/B0f9YYqt8+jW4cVUe7jgAoilA1Urj2aLAXYR+A/V+7qzgO8Buwi2k19HdunY8UgJPpQauxY8IRqn+U1cUUh3MiXDTqIwpqehXR2BMtGwE=
Received: from DS7PR03CA0206.namprd03.prod.outlook.com (2603:10b6:5:3b6::31)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 16:19:46 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::b8) by DS7PR03CA0206.outlook.office365.com
 (2603:10b6:5:3b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 16:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 16:19:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 11:19:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     <luke@ljones.dev>, <Shyam-sundar.S-k@amd.com>,
        Richard Gong <Richard.Gong@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ACPI: x86: s2idle: Fix a NULL pointer dereference
Date:   Wed, 28 Sep 2022 11:19:34 -0500
Message-ID: <20220928161935.31913-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b0ff76-a999-404c-6416-08daa16d422f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xoyCLcHwQo8POfaADsJAHSsiwzkZcsk86YuRI8Yg1ohOWnZaEpvBa5Z+bblZv5d1OudT4XIAweQBNJbxAiRKas+9WnVfRYhwnT9p+WMq7i1reERBsJHvQ9cjPZlSEIMGiKqVFroYk7wxc7cJ55lWMR4vTzjzZRTMOpNFlYF8oU9CToB3mXSAxS+J7vG4k3O5zXLML0W2oRtRzuPNlyk8Yt0LxG1jZlbmoqTXfwzwwh9R20k7Geq4WNPS9hN+dIdl/Fx3wuOxjWK+y4Af4lzNqoPgtoxC7y3yaH9LFkavG9uJHnYrRJHNXCuSjRYvp2AeBmxbq0uM2Tn/A5kXFeJtnmKTEZW9deQxs3oFqi7Od5CAQpGR2IWhQZ3zfpKKr14t4jEVsnEnzaty83LNb7rlRkp93zQEpq50ZEg/hNtQPMKgrVsqxkswAMzEAvv5SDbyIMrgIlskug99XTNCpzv5FaIcNonaZSjGRAlGGnJGTyDz7MmJSdOa3UqGqI34ibVbADYo8U/EK8mtdgL9ThbozwkLrA5DyP5QySqpizpK4O5yVO6Bg26VeEzxVSohgDuDoZDCFPP4pv2x9HZVNUaD3gaOVmlPMoKeQZ0E9+QU65qHpjDeLO3xdsH1/+b2RhAXwIQm+a2Zw7wbJuIYnCsiWYAsGCysJ2a60AqWgI3eUZjsgoqXy1bkIzg6dGx6mMsHsPIYdQDT+myjFy7YrBLtP34SgXRD9zma+BYYxmwbQzsuornbyE+cLB3wmzdj7Dh7ETuJgVfTkhlZaRqeaV8dV4ZCwiJUgL1YYMtzh+/SfzBDmUSmWdv+Xzm3SXmfNmY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(70586007)(83380400001)(2616005)(1076003)(426003)(186003)(16526019)(47076005)(36860700001)(81166007)(356005)(82740400003)(44832011)(8676002)(40480700001)(82310400005)(5660300002)(41300700001)(2906002)(8936002)(478600001)(7696005)(26005)(6666004)(70206006)(40460700003)(4326008)(54906003)(110136005)(336012)(36756003)(316002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 16:19:45.9318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b0ff76-a999-404c-6416-08daa16d422f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryzen 7000 (Raphael) introduced AMDI0008 for _HID.  This ID was added
in commit ed470febf837 ("ACPI: PM: s2idle: Add support for upcoming AMD
uPEP HID AMDI008"), but then removed in favor of aligning all new IDs
to Rembrandt support in commit fd894f05cf30 ("ACPI: x86: s2idle: If a
new AMD _HID is missing assume Rembrandt").

Unfortunately there was a mistake in commit 100a57379380 ("ACPI: x86:
s2idle: Move _HID handling for AMD systems into structures") that can
lead to a NULL pointer dereference accessing `dev_id->driver_data` in
the sentinel of `amd_hid_ids`.  Fix this dereference.

Reported-by: Richard Gong <Richard.Gong@amd.com>
Fixes: 100a57379380 ("ACPI: x86: s2idle: Move _HID handling for AMD systems into structures")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index eedd21d8a284..3ae2ba74de92 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -470,7 +470,7 @@ static int lps0_device_attach(struct acpi_device *adev,
 		for (dev_id = &amd_hid_ids[0]; dev_id->id[0]; dev_id++)
 			if (acpi_dev_hid_uid_match(adev, dev_id->id, NULL))
 				break;
-		if (dev_id)
+		if (dev_id->id[0])
 			data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;
 		else
 			data = &amd_rembrandt;
-- 
2.34.1

