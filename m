Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204E97186D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjEaPzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjEaPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:55:13 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC393;
        Wed, 31 May 2023 08:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/G23yFbxg2yjbCg0wKmhWolLGqZ8TPAjijH54SjKm2pbj4uL6nZSTVZdd2O1u40uVmm+38Ki/POysAXmJKz12bCv0VVpfWCr4MSYcqsr27OxQ/QERAW8qfaY5NSTmmh2s7Q7DEzv4X+oEQw7vWyRcZgE2iyaGsiWnwnnNM8CEEHZZFYtRksLd895oCuoXpelkC5JeA1bNn7ec4zLErZYfnelq9IscmQsAjgoaVA0j7gK4odGCUuInvqKulNJCAF/0DDhQGOtuJi/8iasaLM+oBxA1FOhypA2tMDKXm2hi6mOsIichZEZo5bKhwJAUaBjsucp/257MsaioZ492KzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFS6AKJV6ZySjl+UONLtE2T94jxUSimUgs+jwcplT4Q=;
 b=eaV8Py/pYlY7HDAOjPAkHZR5S9CbNVoUMe+u5ungGL9l522zxh20zYpyQzwmm4NA0B8PtyxmLgwZcDMkuaHRzdcZMa32YLMliOkBxtiS/plWfWZxBhOLVOvDBLvTScifIomWOaplp3GxbtYdqe0mbPkggP2IV9QQ9Zev9Q5D3DACPATHKn1+D+781169L1Vji/2jqF+5p5XDChImm+SOvc4RpTMCt0nchDoSZz3ZAKGgrjDYBrF3N2WhRZd6uMDiVX0Xn6ya8qZ1Pq+pVP9yerhHM3KA5LRwqchF4EpY99PEXSJPVk8h9yWrT7zyS3ruM5OWXFGqdYQkgp8VHYCNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFS6AKJV6ZySjl+UONLtE2T94jxUSimUgs+jwcplT4Q=;
 b=rQL/g9umobIACG3BNscmg0U1R5jbiOC2r3g/rVKbwKD/C4srdn+dFM6pLylInJJqjs8gmKTcqCX9ACcewbljdgaiynYZL5cTBQx4ctoqShxdAFFE5oY3Vv5nh16Npu4wOU2oipy/fGiL9nOUJ3q19BLSWeaQpErnVNsNnRgP7JK/UP8jA4TVCLnK7vfHuQ/z9C3kyXrr2CsM4wTZvittXMN9yIwmt+FLhmup2SN4Ou2WcACJo/bbZKllwIYTLFjtXjhTqPyMR499rRAi+/QPhANRbyt3pqYaMKHdrDyoa9bvNAHscY3L5GZv9wkgKcp5OrXFvNSb4SjC3bhtf1ss+A==
Received: from OS6P279CA0180.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::14)
 by AS2PR10MB6541.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 15:55:09 +0000
Received: from HE1EUR01FT084.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:38:cafe::f3) by OS6P279CA0180.outlook.office365.com
 (2603:10a6:e10:38::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 15:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT084.mail.protection.outlook.com (10.152.1.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 15:55:08 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 31 May 2023 17:55:08 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.56) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 31 May 2023 17:55:07 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/1] leds: simatic-ipc-leds-gpio: add new model BX-21A
Date:   Wed, 31 May 2023 17:54:56 +0200
Message-ID: <20230531155457.31632-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.56]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT084:EE_|AS2PR10MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d8030d-bc19-43e7-f1c0-08db61ef68d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpahIy+GZHDvhCX1b7dMwPtAuN+RIPFuyJH+tSmeTX79YTpmv9AMzCPuSF3ka4KIp9dtU9C8KTkgBiDONboaTX4VHnXBrq15eACrUjSjEpjEfsanOwBtX5WUqhQZCe+fFA1vSkQU00Y1gRErejm73CUJpfQAthqjoS5pU1AA5w4mVVYzCtXVOcWgHLIntmWf/75T2ZPvpidKMtwdIKN+wnA8WlQa1Ec431vMc1xpC1d3kmTgOORsvkcdXkXQAuGQ90m04k2qwoTj+lN1D3DvWyRoAmhIC9Nx7JbSPF05jBtIuMQlxJd5YwQY5zRrs5WfMRgM3R42/B2ETP1z3NazwVblCpqdUPtn3q3BQsT9kIw5Y3BOkMAch3wRJJljSQ62Lon7Xkh69klZT1orsqodtpHkYyqiRVbgHmU0LIiLwoLRSbMG+i+pf/JVWFROBRHpVH7+DUnxwEipS46E43LlJzNSEdqyQp5RrzwuNhXr3rswM2Y4nTrBkG5NYE7Yyv5p1rtIArtiAH3iodf4Uruv6VfvYlD3PZaG2nCH2t93+cXRNWCpNg6Cv3TJEx+YxqEWiSyTcaDIGG3BwsvVHXGwT2hQ9lVGfffBq1+/Ep85GV/3M4KxRllFrL3s50i8aF37spEkVY3/Zu5HGa9QLNu+kc9lxecIJWEVLorzTxb3m/BH86SBav6cYQfKNPf97qJpIujTdY5Y+7B4GJpJWjIHQuxlxwVJWewijykByOGveHoYNDtHOcTdvtMHvo6q4ChA
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(44832011)(4326008)(70206006)(8936002)(2906002)(4744005)(316002)(8676002)(41300700001)(70586007)(107886003)(110136005)(5660300002)(16526019)(186003)(2616005)(956004)(1076003)(336012)(26005)(83380400001)(47076005)(36860700001)(40480700001)(86362001)(40460700003)(6666004)(478600001)(36756003)(82740400003)(82960400001)(356005)(7596003)(82310400005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 15:55:08.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d8030d-bc19-43e7-f1c0-08db61ef68d5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT084.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rather simple patch adding LED support for yet another Simatic
IPC model.

Note that this is based on
 "[PATCH v4 0/4] leds: simatic-ipc-leds-gpio: split up"

Henning Schild (1):
  leds: simatic-ipc-leds-gpio: add new model BX-21A

 drivers/leds/simple/Kconfig                   | 13 +++++
 drivers/leds/simple/Makefile                  |  1 +
 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  4 ++
 .../simatic-ipc-leds-gpio-elkhartlake.c       | 57 +++++++++++++++++++
 drivers/platform/x86/simatic-ipc.c            |  3 +
 .../platform_data/x86/simatic-ipc-base.h      |  1 +
 include/linux/platform_data/x86/simatic-ipc.h |  3 +-
 7 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c

-- 
2.39.3

