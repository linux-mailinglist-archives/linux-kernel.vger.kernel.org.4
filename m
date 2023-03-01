Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252F76A71BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCARCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCARCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:02:31 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58443475;
        Wed,  1 Mar 2023 09:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADkC6sQYqJC8t2qa6pZp2SMSYg6YAm/6VFvb3JDbBz7YcMh+K2hF08/4Hgdtiou1GIqs0rtFDivi9CJwGPXVha+orhJkmB2ZNeV1dOTQRr5yoQjLkZ2YLU+9lrHbt6tRtN6+5FT3sILkaPaRRKjzMiTafWimphKM81iNbw0CULAMdsK6lFeMYFbcpT02852bVRBnmoFKysLT7JszkyThCs6oQ6VwZM8PyscqGv/SiXY7WmOnaF5yTiRgYBE0xE/+b5MRDGWeP3Ch5c0sYMwrazsSqSrPndAFp1n6j15LzoOKTQ1gqfwjhkJE50wj1Baw6GHhGSWS36jQoYIfM3xGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZLt8ZpBAr6pucUnfNdW/90kw8QBzpHIM1LAHwNDSNk=;
 b=Lg+WymewhrRZxkrgbACcKVhxCDIOP9lGoL2a2g3xPw+w5lkgDIPFgQl6tqCcSl5kpxRD92p93PwqMotwQtCyOWfKBoDaGlbig1ernxxDMlAnga86R7CXVHnpgIXXYkXA2DhI1UaG0el472E+ammy4rB46cE28ux9u98uQQCauu9qTpguLDYC6fDuCuXKKxTM5yfYF36Xb/ST9YamT2zzEO2aWqJE3+BBoJmBHLDkaOAx/x/K04kgglV806W2CK2/ElNuehog65hSQLDxaZvXCTBLzXYiiXsmat0sxjYVgh7TFkzLZieX6VenvliiXsK/g5AZeHWPedO8Si6h7wD38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZLt8ZpBAr6pucUnfNdW/90kw8QBzpHIM1LAHwNDSNk=;
 b=OCekZSniyVc2C1Q8pp3GJt97MzY3+vBtepm1cUuzEwDrVYP8srdd5g9k24PBY2HfW4Z/9QlUxtkggBLJaBJlR0EZh2ckqD0X4mUKP/jYRPjUZR/7YVbZz0NPBwFzarAqRqUJ3LushTYhEFFOro4GQonHU0ceh0KMbfH0r9fYTQu6W5gqNXOJRUKZhb2yNLifkrdcg0hSI2uxMTESpOWM8fmhQXu9yBmiAFuPvD/uK7Lqc+LW+Q+s3vci3D3Bd99nfYxEHzlVbwX+ViKijki025D3g7b+ISVndv2Sc0myWOmMTf4fyOoDSKz62ptWNOpk6VkTQZGwc0lEDcdg/G1kXQ==
Received: from DUZPR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::11) by AS8PR10MB6795.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 17:02:26 +0000
Received: from DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:468:cafe::b2) by DUZPR01CA0032.outlook.office365.com
 (2603:10a6:10:468::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT009.mail.protection.outlook.com (10.152.4.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 17:02:26 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 18:02:25 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.0.120) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Wed, 1 Mar 2023 18:02:25 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 0/3] leds: simatic-ipc-leds-gpio: split up
Date:   Wed, 1 Mar 2023 18:02:12 +0100
Message-ID: <20230301170215.23382-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.120]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT009:EE_|AS8PR10MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 6668f82b-427f-495f-fca3-08db1a76bbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQM1tMAOLRrQEKS1lmMlIFRDDK8o7S59ypCYdpEmsJUlkGl1sWJKtzB0PR7w9gSKTN/ZMir3EVh+HUugLqiVO53YM6Z9djIB1Pf728uKHSajQKItLC0IvI2eMWJuxJnaf7a87bH8gIH3ZW8tFeygqoZFFrZB6piqUYwOFikKSJkqNJvLGyVpE2aG0hSPWfas+EH0toKrSgFNXl4bBVvchPh5nFR0INY1P71V8rv6xSwgkYstx4CBgnlIOkE65RxyRXQnVaQgvBoLwhsRMfMT1rrolscQvV2q71lCX9GPg6if1bdfIwdAFavYHU4XRJgOKnThsG8cAErjwjPNTF8O8jzepXZVbMB8PAXGEfZ3qpgjQTBEYfx2GGiEQjHRN+xH504saYHNw6D+YEE4JrGYaVpSRDqOU8H7b1a5WVUeOa758Q32LjpVxF+pgDPz0GleGUadzjqBukb7bH6EIp1F3d+LUz0WxnP7pr3++NLMxLZXJSZ/miY4tV545gS9wWqPHp7G4IcZvW7VYkhjSL5TDxR9MDTBD0JC9GsZjj2hZNabhlsSXF72Vxt5lZo9dNRJPb6+/nptIvcOKfhoINjZR2k1olFpcZ7aTEA9FumdsjQMxw3A/n5feGYvs+3hrfBZARkp3mlrpaeA4a6BpKAKBj6ggP5J+NEIUkiXYU0IRw6AZU/8K8MKZHvjrdvmAmq6fOMW1j5UBSy9QUYqK5mq2xTKeqT9YYwUUUY81AfzePE=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(316002)(86362001)(41300700001)(40460700003)(70586007)(107886003)(6666004)(70206006)(2616005)(8676002)(4326008)(336012)(82740400003)(82960400001)(956004)(47076005)(81166007)(5660300002)(36860700001)(186003)(16526019)(478600001)(36756003)(44832011)(2906002)(82310400005)(66899018)(110136005)(1076003)(26005)(356005)(8936002)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:02:26.3501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6668f82b-427f-495f-fca3-08db1a76bbea
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6795
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

It is based on
[PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the GPIO providing driver

Henning Schild (3):
  leds: simatic-ipc-leds-gpio: move two extra gpio pins into another
    table
  leds: simatic-ipc-leds-gpio: split up into multiple drivers
  leds: simatic-ipc-leds-gpio: introduce more Kconfig switches

 drivers/leds/simple/Kconfig                   |  31 +++-
 drivers/leds/simple/Makefile                  |   5 +-
 .../simple/simatic-ipc-leds-gpio-apollolake.c |  64 ++++++++
 .../leds/simple/simatic-ipc-leds-gpio-core.c  | 103 +++++++++++++
 .../simple/simatic-ipc-leds-gpio-f7188x.c     |  64 ++++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 139 ------------------
 drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 8 files changed, 288 insertions(+), 147 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h

-- 
2.39.2

