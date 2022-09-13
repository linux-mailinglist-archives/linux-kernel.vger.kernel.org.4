Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F45B7C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIMUfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIMUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:35:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF349B4C;
        Tue, 13 Sep 2022 13:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f35NFTxXZhRZySGVe6YnMfEpMYHuBYBryVXnzhn2bMCvEzjMFY4/R5x2/x/hEFNymgAR+fQScZ/MPSKLQawtjHugJP6K/UiqtZDcyt8HPT3vH8mkPVQy0+y0wd4Ch7gc+TQENUNr/Atq+Sr4YJE/BDx0usjHDpaM/EHheOK7W7KfPDZ0hnEx/t8d0hkc9PlVB7OuKAzUTuMFq/ypgAEyiKmeBzPqGjhaUHttftXvPEHXBdit50RP2FiUfMNDgxMby6BgYc8i6qvFwc4wQNmhtFGCtzyNvjn18YzDpTTAUmy6lHHVgCn6kculXUui7y8LY2YiT8C/a42iRN+9mXpB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w8AF9uYrfJOn3m9JlmpsEL2pD/0Yr0gU1UHpOTVdWw=;
 b=Xi+vTsa/nk9OOqWhYCKn4Bx7dxHI9KvE80mGz/3Kd+8wnkjOhCeDmO6WZ38SQYCRsNndxlHhgf+pmARW2SHJOQNL9dtAxTXZOPGZdysUT77maVmeJ0u8oxWjYfZq/2A5/pGdZoiRfT4uwGvDJj1w71IwfrznAIWxit+Og9DIoXJk06M6yJx9iRJrDTWXbky6qocES6eCrjUnmNeQXSzemAv2Lh5xUkDowgjgrWK2x80kTJr3A4Xw8Lw/6gGFbUNrWxqGUcI7qqubOxtYMA/rcL42aDQmriAg5UY2XwotXEDPH2c5yt402XPR9sAkHsKXvQ7pNlcO1kNd2g/NMdge9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w8AF9uYrfJOn3m9JlmpsEL2pD/0Yr0gU1UHpOTVdWw=;
 b=t8n84PCl0iP5kw38kwKYA5b8wEodm1pCBJ6qVpLvDhhHRftUFIAe0VkZgsTbZKR8DHQI7QeTIZpfNzrXqXIDxHYYyHkGjiYEnIKidnoUcnCuuUwWfTEUoiS5GAyJYQLcXu6qcz/vk5+WyJWh+Okw/an4ygzxuqRJ87J7sjPbxIM=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 20:35:11 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::c1) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Tue, 13 Sep 2022 20:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 20:35:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 15:35:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Puma Hsu <pumahsu@google.com>
CC:     "Artem S . Tashkinov" <aros@gmx.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] xhci: Don't show warning for reinit on known broken suspend
Date:   Tue, 13 Sep 2022 15:35:15 -0500
Message-ID: <20220913203515.451-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 510614bf-55ad-4936-de89-08da95c77463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2K1OCUoHJEsvd7wMbjojWzTdE14QDcTHGwiUinLftkWrURObI4dNT7tkdstnyDSNx+hq3wPS/3zalHMMaSOcYn+ztCYdieL6DIySGeEnvS2pIaLSpzE/TdaYr9+GHNG/l64fgGoi9v19EFTgF5HSARrwdCLHj8B5E9v/EgPR2CPfxfZi6+HORaqumLTgVbLssdYyipShzkDfJFCCRo1d+nDGWwqacghZ2k6dcAxQtkSM5ggDUV1EzdOvAxYAYMiEPilQUSAl2/c4EXSI0ghrd21/he6jwf6SXUDBayY4j4+7PpE9E1pOiuWwBvV/unEr5adqfJdTL9NNL1MkmXbSpzEu8zy9OW4N/+7s0N4YKsQwISmC34qFvANvUvJgMwwmMmry83H8llXmFpTHB4QC8cVjeirNi7vsIetHNy2LNVuBbxOu6naDWWXbAKLqLSWj9zN09shDxzCrmxJrAJntBNp3IDyazJ7NQG1RYglz0V/Qj02qkYdWTgnNk+yo4SiYL81D+c8yOk3IM1ljred5THcXhJybTaOPIIqGa/rSWE4I75BHgYrinWJnKUZdS1ppOr0JTP/F6oZQjpr9Tsd9VNIMn3t7c1i9M/wcelyNqLg2tzVyfqiBr9/CNoyjA7wjbgxC4YoaOy8Un0848jJr3fQvGJCBS3yHbVYcuT1c3wxXvl5Lfd+P+QODgDsasjSS6+CBC7NFJPnJG9XIa8/YiKpqPzLKGzSNkJn/UZb9qLWH1B0O/42h7Fuag9ZlbfNp+OrBVbQDEWFedHf504KS2Z8+qLD6YJszp1yn9pmd8LzFfSWO0eXuSxHnNtrApFjOsFhXCqTb5uLFQKkrywQtkand/cR27O983pfYZf0Bec=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(70206006)(15650500001)(41300700001)(40460700003)(1076003)(4326008)(36756003)(26005)(336012)(2616005)(83380400001)(5660300002)(2906002)(110136005)(316002)(40480700001)(16526019)(54906003)(82310400005)(478600001)(8936002)(6666004)(36860700001)(356005)(86362001)(426003)(186003)(44832011)(82740400003)(8676002)(70586007)(81166007)(7696005)(47076005)(966005)(518174003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 20:35:10.8204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510614bf-55ad-4936-de89-08da95c77463
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8b328f8002bc ("xhci: re-initialize the HC during resume if HCE was
set") introduced a new warning message when the host controller error
was set and re-initializing.

This is expected behavior on some designs which already set
`xhci->broken_suspend` so the new warning is alarming to some users.

Modify the code to only show the warning if this was a surprising behavior
to the XHCI driver.

Fixes: 8b328f8002bc ("xhci: re-initialize the HC during resume if HCE was set")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216470
Reported-by: Artem S. Tashkinov <aros@gmx.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 38649284ff88..a7ef675f00fd 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1183,7 +1183,8 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 	/* re-initialize the HC on Restore Error, or Host Controller Error */
 	if (temp & (STS_SRE | STS_HCE)) {
 		reinit_xhc = true;
-		xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
+		if (!xhci->broken_suspend)
+			xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
 	}
 
 	if (reinit_xhc) {
-- 
2.34.1

