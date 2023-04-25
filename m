Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3CE6EE4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjDYPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjDYPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:39:32 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076DDB454;
        Tue, 25 Apr 2023 08:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEugvU9dnHI7Qf0Uq6mjYTudDKpXqs0OhAQGMaKUXTeF6PrnlU509X+J3SwhYr22uyv77gslAuSrBORDYeS8dKN3FCz6Tb146YrKKDajpYOBGFS3UWtmeBnnPdw+iZaqj/PGUV+tOxOL5bAydnMfubBzN6ubyD0gTPtbmTOpwhB8teiqL30ewO+wC8ElVJcUP1kIPIemMr+heF8MYgtqAEiZ42j3VcHnkQp8HZH+wUt30gPJH9ViK/IchPdxQf0v/5lrNqdeCBRxqXzpF8nVIG55vST3wsgKgn3lnaNPZYGr10ZfX5puNw2J8Bdaku19uaB95fyaPWitzwudUwn9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcf0cniObv6/OcoZCucuTUoxfzFjwZYnkII49hbyYsM=;
 b=XTFmBNsByI2ijwik6PyemJvoAQoEOKV3uEmZs/kGK1sG+HxUlIzvzYTcQQt4PNvlgLhECEl24ohQX1NDWctJ0FMQQMxkisx8m9aDUwkDmBrAY+Yu/UBuhL5RFyrTeG4Lls3rjvD9i8fOySO/8rvxhWD/np/y+w2/iCujmWKoIUMsgFoDzlwrroV1zfOwsEKO3Ven8z6cbVmF4lJyWcCbmVGsJY22c9bgM62t4+aqLdzfQvOcvqe6CE+aPMFtOyF14xobx49Z8yTxZZSYedaNOrXZeRAtsexqYMh88xRk0Ms6aqtSr6BWZukAb7AZ1ccOzqHG4EhbaqeKRbPb7iVzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcf0cniObv6/OcoZCucuTUoxfzFjwZYnkII49hbyYsM=;
 b=er7xnhPOOo0tqTJSUVpHK+BPZb4PYthxdBjPQEJGWz8WIoxrO03+Uv/idIfLWZJmviwh3aivVjhmiuE3v0A+sd1CpQ+4WR8ZplnrDR+7wCIMEW/hHB+3I6JzDGnQWB4QOEp79OMzVVvnazqhSJJMa0z2HErEKpz8FvsEdYThDtGrGl0e5FOJ6QuCbp34Vy1WGCvsWK1uDcvhGilczZcTg5OCjUA608fpR38rWTzb0bTmKDeXmZeIX5stxDCIAe3+sjJguibYchuyyBGR517lNnyWIwwiYlH4G4A2ecLOvAlCq1HsOgRvC25VnmC6dLq+IctcuH5Cjud7NB79oBOMHg==
Received: from FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::12)
 by VI1PR10MB3229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:132::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Tue, 25 Apr
 2023 15:39:23 +0000
Received: from VE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1c:cafe::f3) by FR3P281CA0033.outlook.office365.com
 (2603:10a6:d10:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Tue, 25 Apr 2023 15:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT014.mail.protection.outlook.com (10.152.2.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 15:39:23 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 25 Apr 2023 17:39:23 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.115) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 25 Apr 2023 17:39:22 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/1] fix pin count in gpio bank
Date:   Tue, 25 Apr 2023 17:39:10 +0200
Message-ID: <20230425153911.32135-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.115]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT014:EE_|VI1PR10MB3229:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fefdad9-a5bd-4193-b196-08db45a33e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0t3ZhM4fT5YbequITGepAYX4rqp9OZqjojK5ZPJDxAqje9ApLJOi36OIiS6raNjFDGQ/YAETJw10uFbDfhzi5CXu/NnTxxN9tX4SQrZ5YOP1FufyfYM8JDkJhK2r/+CmN+983PAICOFKP7oMo/jnjW3OeFoEyzaZzKOcHQ3UsHHkNVWbYUhTn1Ngpw+r3FHainKRbaBZMMmChWZw0DzuZVqvx6THioZW6eBf22j+mlQ4+7zzGmwxUZ/inM/Ri5AEPyHXsP2qVttBfs/rcJSJyp+71BvNG1f47SPscqd+zchHHNoUkxM2klX7MWfJvMklqIjS4ymDZaZ9vTIu3SgPjtjJTtfLmScS53TMfoPI41dYt1wisUUEaiRDSx1JOn6LaRYZuW8vHt9wo/m1/FKBDYbfkdsaFVmYDX5ykXf+mSac5JDfRZJlCKt/CQTtq0VDUqi1ZatGTKdNNyRKaGzuh43IeuZ6ftLxTyPiC7U003Ej6JcZKx1R0IhLzXIsjzVNSs1q9kss1osX4ykc/I5dlKAqHXEOhZJCkNW7mxA9PO72g9Qi/5XCxzhYl7m0nlLTPqLRVR04Ilck0sq5TBxxpmZrXaJJ+KvzF2MIhDVRKAjdzxDe77jcCZ9doiDgWX0kGCD5vxffw/tdXwU/Xk64V5FSwsqJK/hoencyJOFyqY96kYtnT4lSXLBKv4z9rkr4eVlxow7UkGgHLDpEn567Jrejsgzz+cpeiibihSDi/qQ=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(107886003)(1076003)(26005)(40480700001)(336012)(2616005)(956004)(36756003)(83380400001)(36860700001)(47076005)(186003)(16526019)(40460700003)(82740400003)(82960400001)(356005)(81166007)(70206006)(86362001)(70586007)(478600001)(15650500001)(8676002)(8936002)(54906003)(44832011)(110136005)(5660300002)(41300700001)(2906002)(4744005)(82310400005)(4326008)(6666004)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:39:23.1204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fefdad9-a5bd-4193-b196-08db45a33e64
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3229
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

This is a rather trivial fix of a problem that happened because i looked
at the wrong spec file when implementing the code.

I added a "Fixes" in the hope that this can be backported as a bugfix.

Henning Schild (1):
  gpio-f7188x: fix pin count on nct6116d bank 7

 drivers/gpio/gpio-f7188x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.2

