Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC41709E21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjESRaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4510DD;
        Fri, 19 May 2023 10:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHo6tO7sexkKSAoaMEQ9d7BzY634g6+LOH6k0GZ2AkPPQWUAfPtnGsJ0eQmy22SdBJUWNy4yif5tgIaS2FiuhheY4Rq/8BI7SYYYNKQoSZHtAXpw9UjbGJzEtdGoYm8blP9TUobd5Ew6e+iH24s6NcMEuwMnrrzu8zHoRDHkyP0JrHAWRjtzD+5mO3psvu5zipSVJq7FznMKX/sTPXlGWuJ4Qjks59X61wV9ckAKkbc7Gy2fde567qIIET7K8gzZPGLYfuxxfaXbYGqSTK1YScsMqEILOZsl3pPQfhkq5HcCPvPUQ9HEn+5gM4RGAzq7hnbhtHZpNHpKFxKkjuYLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y65ySYxEZTxXTPx6XZLcx4EtwRy46OgHE/Wts/IgVII=;
 b=mmrPJzuxUC/0edSYG/0cG2JtJZv2upvm2ZoiXMw5mc8HpznvYJnm0cy0kuZPS+7YYBFF3kyGqzsa0DbXtpDb4uU2gdeN5FaaaCpd7g4wcjGNGTbqQzmphU4a30tXP+qXfhN+F5lNQ3YjxffgbpH9P6q6h26UR9oNL25gG8W526racPSc+ypBMuO/Fe1nfSXJRuwpHmKiG+LKeN0xCIWSJqUYrlnnsjMGm5JjXX4qYOFojj2f0u/DKBQg7la0C/q05gqP2YhBR7m8kC8+rkwHfMOTHd6qhYBYbfLlCWs5PSiwVsIL39hetoxP1Trvf/JLQdPDyjKlZ/8Yfnnj5x+Irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y65ySYxEZTxXTPx6XZLcx4EtwRy46OgHE/Wts/IgVII=;
 b=sAak2WYuqLGvXJ9SMA0P0SyOzxj9EsRgb13FSnrSdxdn1Hx1I5+/FJb3vMo/L0cdfQepN8e3S2zOdJYS1UrB/QirspDyVs0r8YYk/w1y35F+lVyHDTLKOEhvGeRVn9Z+Hj2RmiUefFgVVJVrx59MAa5coGdHmMHHyVE+SNz4jiI=
Received: from DS7PR05CA0030.namprd05.prod.outlook.com (2603:10b6:5:3b9::35)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 17:29:01 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::53) by DS7PR05CA0030.outlook.office365.com
 (2603:10b6:5:3b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.15 via Frontend
 Transport; Fri, 19 May 2023 17:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:28:59 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:28:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 00/10] Add dynamic boost control support
Date:   Thu, 18 May 2023 22:24:38 -0500
Message-ID: <20230519032448.94279-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: f425c73e-db26-4582-97c3-08db588e8865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbzkAb/uNqLEQ5ZswlN2+C8H57DR+3FBTU3CjO++7tKv8uYEDkpTXPDY6nsmV5ckCRWEBUQKCd+cT+B6Ceu4ZA7+RSUcmjlDxEtM8c5uC6gBmrJEISZyDATXjVx9nlQHX0Xi/dPdCENNaj14lySvGqH85OwAIeUVqRBpGgxdj6+2aiKbm6BzoN2c/BHE2HFAVaTttjozUblxd7m8tVvthc6GnYa0AT9sfWhFqsgQYtmosTdWhBgXhCxKEGhMkjYAHnRSBiQR+4xZiVilwIRPvbQrdEcH/Ffn1qU+kf40NP4+N3fYYR8AVxdwMNizugXUC3jmJQHTIM5yFyv82ABtrbMvYsftzSRpguXkuHxoq9eUDFh7c3P/WScRrFJC2LUXFxNjhWGj8XWND30guEVRMtTuGoAvJsDGAhr4LFhQX/0CwwYP2G7IrSeSYnqQm76rvmP+cIhuj46x2QUvEy/YCMXJlCXEyVLm+wgzrXjhmzeNHD/RzVDZDPaYbEkW/wF5Uq4BTr3mlWfXiSOIPfiUjcTxRut5CzkNHnSMUumYm+R9lYfne5jN+V4G0gQDzVZxcmZekhD4Enjdk2M2/RAO03HC+b/xWeCWQcP5vFgHUaEhye/0lXFczqaB35j2HavwQFcKiUeohIqPnharsRWYSgYZ5trehtD9UOUsf7k80bZDbyRNP1xdptjygs8fw5U4qpB397zhI28MbBdQHixly84xaKx5wQKW8l1zZbnQ0oQXF65bkFdjQSq7fWtTy8b2DJaRLFyJPDHfpbz7iIKN5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(316002)(86362001)(4326008)(41300700001)(8936002)(8676002)(5660300002)(356005)(82310400005)(54906003)(81166007)(110136005)(82740400003)(478600001)(2906002)(70586007)(70206006)(44832011)(336012)(426003)(6666004)(40480700001)(7696005)(36860700001)(1076003)(26005)(47076005)(186003)(36756003)(40460700003)(16526019)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:28:59.9235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f425c73e-db26-4582-97c3-08db588e8865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic boost control is a feature of some SoCs that allows
an authenticated entity to send commands to the security processor
to control certain SOC characteristics with the intention to improve
performance.

This is implemented via a mechanism that a userspace application would
authenticate using a nonce and key exchange over an IOCTL interface.

After authentication is complete an application can exchange signed
messages with the security processor and both ends can validate the
data transmitted.

This series includes a test suite that can be run on real hardware
to ensure that the communication works as expected.  This can also be
used for an application to model the communication path.

Two sysfs files are introduced for reading the PSP bootloader version
as well as TEE version which can be useful data points for debugging
communication problems.

v2->v3:
 * Pick up tags
 * Clean up master device if psp_init() failed

Mario Limonciello (10):
  crypto: ccp: Rename macro for security attributes
  crypto: ccp: Add support for displaying PSP firmware versions
  crypto: ccp: Add bootloader and TEE version offsets
  crypto: ccp: move setting PSP master to earlier in the init
  crypto: ccp: Add support for fetching a nonce for dynamic boost
    control
  crypto: ccp: Add support for setting user ID for dynamic boost control
  crypto: ccp: Add support for getting and setting DBC parameters
  crypto: ccp: Add a sample script for Dynamic Boost Control
  crypto: ccp: Add unit tests for dynamic boost control
  crypto: ccp: Add Mario to MAINTAINERS

 Documentation/ABI/testing/sysfs-driver-ccp |  18 ++
 MAINTAINERS                                |  11 +
 drivers/crypto/ccp/Makefile                |   3 +-
 drivers/crypto/ccp/dbc.c                   | 250 +++++++++++++++++++
 drivers/crypto/ccp/dbc.h                   |  56 +++++
 drivers/crypto/ccp/psp-dev.c               |  19 +-
 drivers/crypto/ccp/psp-dev.h               |   1 +
 drivers/crypto/ccp/sp-dev.h                |   7 +
 drivers/crypto/ccp/sp-pci.c                |  96 +++++++-
 include/linux/psp-platform-access.h        |   4 +
 include/uapi/linux/psp-dbc.h               | 147 ++++++++++++
 tools/crypto/ccp/.gitignore                |   1 +
 tools/crypto/ccp/dbc.py                    |  98 ++++++++
 tools/crypto/ccp/dbc_cli.py                | 123 ++++++++++
 tools/crypto/ccp/test_dbc.py               | 266 +++++++++++++++++++++
 15 files changed, 1083 insertions(+), 17 deletions(-)
 create mode 100644 drivers/crypto/ccp/dbc.c
 create mode 100644 drivers/crypto/ccp/dbc.h
 create mode 100644 include/uapi/linux/psp-dbc.h
 create mode 100644 tools/crypto/ccp/.gitignore
 create mode 100644 tools/crypto/ccp/dbc.py
 create mode 100755 tools/crypto/ccp/dbc_cli.py
 create mode 100755 tools/crypto/ccp/test_dbc.py


base-commit: f573db7aa528f11820dcc811bc7791b231d22b1c
-- 
2.34.1

