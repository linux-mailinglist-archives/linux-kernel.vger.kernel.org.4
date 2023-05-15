Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC27030E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbjEOPFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbjEOPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:04:36 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1B30C4;
        Mon, 15 May 2023 08:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGbn13aAh7g8HrcZMELf9/Lp6qi5IR6WYDzG+oWpsnqBfzbLSCVdTz8T++NAoC50kNT4rNupuCuvTmDWi5lMeBjKW3JCWQWmPNCM4LHaygBmi4BU9t24zcWNhf8W3Mgra8+bb4fl/kj2I+KFHfPPThGf7H5iHNSu2qz2WZhbsAz3aUyh+T7jDC8le1reYzYgYrFGIFTX3razlAsF6PK8/en+WaTcdjo/kxOqQRu0U0yD2XBgVduX3if9GynyzfrorbOmexhATdZKTRLcBQZpF4iG0IXfHMg455xm+XD84A+ZUtQCQdh2SPKtnEYBmTdl54PMfc96/6pGxerUxg0NAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDaGOO/ylPWkKFRIx28RqHzlzfNyVACnw53nXXviVPM=;
 b=BumUXydGFrGrJZ22mhmgfx0hesLpvCsHgU0d2s0k2RMuJtjYQ1V2S3++ru54cp3DDtDodQWmnCzGpRTyTCDsIAaAVrON8w8JJMbV4nMvdiwczDrE7pHpQlNt8aM7x/9SK/YnZL1Acw4UUnIDT6agT0I9HdZx8GC23WhAFgLAOlbRiYfoerHh1z10uAQGJKZqXzmJ3jmIP68A/wHAM5RcT+cX/6rlSa+L9ygq0gCOEXctMkPa3CClRb7TlNrcUAf32guKI0UdJ1lrg6SYwMifJjoQ5v407V/Am47HOYk0xwa/7LvE8fU2/kGF95ithkwnslhTpdidBJCcUqdX0X0DiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDaGOO/ylPWkKFRIx28RqHzlzfNyVACnw53nXXviVPM=;
 b=TzcKmo+duvvPAsiGSU3dVVhr1ZgPM20YRotoA2vZWU2n/GeYu7hmPuVJeS2RLRbqDEkOaBTxg4Q1JRPZk5hmOKarjnkVd0w8dZ7JhiQlst5xhIDnxO86N6n1o27GhZB7rmfQpGik6y0Ns/f4jENxMfXCsXzlHtOD8PYD8ma8nXsmXIbI0ySVavAWfz6kBWMUDS/xRpOBrms7aVlRHB9zifEla53UkV9+jEHvarWFFR76x1DRA/36vLsPOASVPodaVt9SnjXgnq2u0qm9G5I3uQwYNnNRSAAaE2EV4tQQjKO3ReKypmXVbPQF8imW0eGr8Fn0zAbx3OF1Oot26fB62Q==
Received: from FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1f::15)
 by PR3PR10MB3945.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:04:13 +0000
Received: from VE1EUR01FT084.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1f:cafe::f8) by FR3P281CA0080.outlook.office365.com
 (2603:10a6:d10:1f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Mon, 15 May 2023 15:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT084.mail.protection.outlook.com (10.152.3.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 15:04:12 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 15 May 2023 17:04:11 +0200
Received: from localhost.localdomain (167.87.0.30) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 15 May 2023 17:04:10 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 0/3] leds: simatic-ipc-leds-gpio: split up
Date:   Mon, 15 May 2023 17:03:49 +0200
Message-ID: <20230515150352.30925-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [167.87.0.30]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT084:EE_|PR3PR10MB3945:EE_
X-MS-Office365-Filtering-Correlation-Id: 28099cf9-2aac-46f7-8874-08db5555a4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awjPyKjBE5KGgfqS4vehI2pqKxUH/x+xDL20WI3GkXVi3uSvcME+VLFw9pe42JYXbpYI7wkfNI2dp7Nf+3nuXRT9JA331clUDQgxvcanEjme23Zfy4YWHjg9R/LwYDQeEINGREHZHgq2DRzqGM0wBL/yCpv7dB6jSzPea5mbMSlG9/0RirYosaWf20ePZVWFs6Pi0YU3hfambz9PpSCx/bdhsHIVXtA2cnWwx3BnXZTHdGrbrnjIRN6k7Aanpv2aJ5nQqWoq4YHAsKBbbITkdITtXmLDpnZi6EvLBXu7Pvhd4JIlNPI/GMzfy6jKrunXhQD6QSUXLh+Et9XHmsn82SOuu5Fvh4VlTR3qbtzgnh52lPHFDqYsjxcjA3OV7QR7Ojfwjd/BtjN2WB8AkZmDL4CuWg/Ry1hE+Qg6mJLVziFBxVdNa9thLG1REDPG8iDtRs5XFH3MGrzcOiagze3s+XBmU3RlwJRSUjb87P/Ao5+CtA9rm2fh52Ba/8w0xG357ZIdEX2fv3/q9cOBDEKQtXQqmPDPv3y5er4uPuw9dwHbroTLiQHwNAI/uBMVh7mXBMptJean72txmfp/7R3605xUoBBazKPmbdPmReqo0TuwERNhWYVtisl8hKuKOJ8A9MfCbeKyBSjdZDSAVh+wnR9dNoDbWK9u8KLu4KrinjPCEXWM0ryqkldeh2iAyPW+YY7Mli3XBv3HT/B48/qSdbG59SGccdAyLEhol9fJ3cU=
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(110136005)(316002)(4326008)(70206006)(70586007)(478600001)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(44832011)(7636003)(356005)(82960400001)(82740400003)(7596003)(41300700001)(16526019)(2616005)(956004)(1076003)(186003)(107886003)(26005)(336012)(36860700001)(83380400001)(47076005)(66899021)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:04:12.5783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28099cf9-2aac-46f7-8874-08db5555a4ac
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT084.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3945
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes sinve v2:
 - some more style changes from review

changes since v1:
 - move from header- to -core.c-based implementation
 - style changes from review

This series mainly splits the one GPIO driver into two. The split allows
to clearly model runtime and compile time dependencies on the GPIO chip
drivers.

p1 is kind of not too related to that split but also prepares for more
GPIO based drivers to come.

p2 takes the driver we had and puts some of its content into a -core,
to be used by the two drivers.

p3 deals with more fine-grained configuration posibilities and compile
time dependencies.

Henning Schild (3):
  leds: simatic-ipc-leds-gpio: move two extra gpio pins into another
    table
  leds: simatic-ipc-leds-gpio: split up into multiple drivers
  leds: simatic-ipc-leds-gpio: introduce more Kconfig switches

 drivers/leds/simple/Kconfig                   |  31 +++-
 drivers/leds/simple/Makefile                  |   5 +-
 .../simple/simatic-ipc-leds-gpio-apollolake.c |  64 ++++++++
 .../leds/simple/simatic-ipc-leds-gpio-core.c  | 104 +++++++++++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     |  64 ++++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 139 ------------------
 drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
 drivers/leds/simple/simatic-ipc-leds.c        |   1 -
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 9 files changed, 289 insertions(+), 148 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h

-- 
2.39.3

