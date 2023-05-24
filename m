Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5B70F6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjEXMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjEXMqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:46:46 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F012F;
        Wed, 24 May 2023 05:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYQJjE29Aq+Yw3U2ogQHvmG6h1SRGPVXjJfOCKlXnTTP1Ius78DK56CwWj9GrMCHiwGHg4vKdqxaLwxo46CDNt/ydigcbuEhd47JIk0LrL3+OCfXyvMA0pRmk+hOE6o2W+2V19T8INDv0sE3ZzH7ZIAR9UsfexARnBFDh+xol/cLqq9WZ2vNYblCzsZhk7/qi9e4HLfEFrVA8SYvFhH7bmgTPEkq8pKdpZjwjiNIdiM0i+2DSxdApBW1trjCMB5BN8CD7a/pOt+2cy+lB2J1WdAHVR5vx+g1ZB97FYrsKXzev4qdes59DXvw65taKGC7Wkk7ml5ysHRTnTwM0rIXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRxZG0wjqpJdFYaOzUsk4ho9pjKMROxBDe6+yzl9xvs=;
 b=kFOummxUgL/pl3368b9TSeMaETYfhXZuDXJW9oR8JJeOoE5ZackaO1vMH93IgMXEXw5DiI2ctiPa1XtgZfjSuXoCFZgSgFSkVgo9roxu5WTRGxoo09FqK88czSlVZysaLJQBnECi5Yy7c46kBju2YLXsbz1xbkuLIt5cXC7pj+iiGnS4VeIBjIi1qpljfOWNa3EiX/gCQ+LMza0QfWxgzEwv9sbzKFvOqRApLRac4/iVOAnkdr6InFGfNBT19+xomzMsQ1BbLxTNl26L1/8+cYonUakQlS31Orzeyh4LRD7ne+9TS23xxBeq7W8FD9L/wXgEsAuzioQ3Uy7Y1VRArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRxZG0wjqpJdFYaOzUsk4ho9pjKMROxBDe6+yzl9xvs=;
 b=HyX5rmF00KJVYar9so7MBiwTVS7i/fvqQ7alKqoHoItC2r3omj+POKrqJFfL/vd0THw9W6yA0KnA5EqIr/vPzZ4TrgHe6RHc7whmBesav/96i0zGXu4AyBULDJ3SrRBGxpOGtQ3HRQDSHVeYIXVC/61aqIOPE+yxjr7udZrYxzpySz3gZ2N3PtrFQE0xmIdfKV9yknC4d8eB0CSoc41JsNkYeQSHGxwzTWNzymc/+xtK22WBAF4QrGb7s5tAONIKV+pnFSvkgSxkfH2RzoKZk6bnRS0ZBkMmAwJ27QYeTiXX3aPvMlxivz+F1yR4xwJ/yN6EbWrnfoW5xAXwyFdqEg==
Received: from FR3P281CA0206.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a5::10)
 by DU0PR10MB7118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 12:46:41 +0000
Received: from VE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a5:cafe::21) by FR3P281CA0206.outlook.office365.com
 (2603:10a6:d10:a5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 12:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT089.mail.protection.outlook.com (10.152.3.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 12:46:40 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:40 +0200
Received: from localhost.localdomain (139.22.37.129) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 24 May 2023 14:46:39 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 0/4] leds: simatic-ipc-leds-gpio: split up
Date:   Wed, 24 May 2023 14:46:24 +0200
Message-ID: <20230524124628.32295-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.22.37.129]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT089:EE_|DU0PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bae83e-3353-4d12-fc6f-08db5c54ebd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prioT+yZhv5F1w/JU4mhzpuNlZ9tkRimAmlSV5/pqtDO40eAIipeuCchwL4p53mUFl2ms26SWImwRpzU2asycgnBqQeYPV0DZLZLcE8gElkFWfpZRrppHXQi7teiVBn/LSoNtuawQAM1s7uyRZ2WbBE37c6mnQoi6QzFqf0RF0T7mmXXed3VH4rIr4fg7dHB7d4sHQNGyDJkStO78Rd2xsv5JUEbQTre3tENE0nMpWpHX7jQR6uOVAWsQy+GLcpzwHiSp3Pd8sd432+j5hGJ5SQLr1oYXvoly3GGg+MUJPRSUkoG08ovKjQWiabGcttFHe3PFCLSl6oG6/VFTL9EGxDm0RVRhWW5Q7tCX02fUdRkCY3VXt7I3RRYY1zLR5x6EYYEp5bBBycdGyBzfYqXUzkjaLc9OUgABNK5qEUTJDvcm4tBPHxlTCug3iAfamvdFwuSVWWxiectWMvw2mHVHj9wOwsrGs0MmiQK9+atSnTxXaiS9Z3QMU6ZF/tYtZJ6cj3V/8yUrg87pPn1mLZW6iDYAlKmfCO6TpanGMZyafK9CBN0TTiMazbUnYlC9vO5Uy+BngyJ5n6FDtKdhhN9XcD4z0m8WdnzJvfFA7G2jbxUloO70vrosEmoPPYhGtD1TNVIbz4cfG/aYlk0aBGB9V94nPaVUIRsgsM0XXmhyOtWvVEpGriCfuPdViFTLdazaUjFQdlPZdjgdH+jBc4DLtADW4mFidcpUepEA+VS+z9/klHXSMZk4ZoMsSQJSuqQGlQVqSgWBfQSOws96paFpw==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(47076005)(86362001)(82740400003)(82960400001)(36860700001)(2906002)(2616005)(956004)(336012)(478600001)(8936002)(8676002)(316002)(36756003)(16526019)(1076003)(44832011)(4326008)(5660300002)(40480700001)(110136005)(107886003)(356005)(81166007)(6666004)(83380400001)(186003)(40460700003)(82310400005)(26005)(66899021)(70206006)(41300700001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:46:40.6135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bae83e-3353-4d12-fc6f-08db5c54ebd3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v3:
 - add terminator entries to all gpio lookup tables as new p1

changes since v2:
 - some more style changes from review

changes since v1:
 - move from header- to -core.c-based implementation
 - style changes from review

This series mainly splits the one GPIO driver into two. The split allows
to clearly model runtime and compile time dependencies on the GPIO chip
drivers.

p2 is kind of not too related to that split but also prepares for more
GPIO based drivers to come.

p3 takes the driver we had and puts some of its content into a -core,
to be used by the two drivers.

p4 deals with more fine-grained configuration posibilities and compile
time dependencies.

Henning Schild (4):
  leds: simatic-ipc-leds-gpio: add terminating entries to gpio tables
  leds: simatic-ipc-leds-gpio: move two extra gpio pins into another
    table
  leds: simatic-ipc-leds-gpio: split up into multiple drivers
  leds: simatic-ipc-leds-gpio: introduce more Kconfig switches

 drivers/leds/simple/Kconfig                   |  31 +++-
 drivers/leds/simple/Makefile                  |   5 +-
 .../simple/simatic-ipc-leds-gpio-apollolake.c |  66 +++++++++
 .../leds/simple/simatic-ipc-leds-gpio-core.c  | 104 +++++++++++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     |  66 +++++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 139 ------------------
 drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
 drivers/leds/simple/simatic-ipc-leds.c        |   1 -
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 9 files changed, 293 insertions(+), 148 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h

-- 
2.39.3

