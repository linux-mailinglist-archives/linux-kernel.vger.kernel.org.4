Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381665EB759
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiI0CEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiI0CEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:04:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABB3192A4;
        Mon, 26 Sep 2022 19:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9pNLvK9xd4bc50P2ru1dBTI/qtaJdye5DCZhVjth/RRd+Lquo19FHIvHI72xHKRL7H8JsU0+ejhI6jCN0eVnQH4Ig3Nz8IjSlmCixsJpTyN/4Cb4pQCCZYDbhJYBhmyFDyIdth/ODEYiwQW8GAthfRpLN0+BpgoS78RAL+Lx2l12kHl0guX6OSsidzJLQ0UYwy3NL16Fmsv+3Nyo0efP7JxFzLz9Z2xC+p/e2yr/9kFzfFeaj6yr8Of+rdix3xI9MCzT2EIu5R2xt2eyX9kdW2L5uqmNtbAm9mYN4IduOwD0worubsXYJ3cxNKVHFRE7SX7s9rPPVhMHorZDOodKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgdjSBSr5KgI8JrdSOWfgzPiEFHXHP52KocBJ8BR3FY=;
 b=dXKEjB2Px/ykgXZehh0V+xctOei0wo6m8lCeQ/x8Gfk0yYgJLyKJ50yVOeGkiheS6ka+/BdETYt/IROL8LEsR9Et+kkJVmfV0qoGt14Nr75NAfZk6PwDVh0iyfqu2Lpe17slnl40y+iYw81v3uSfGBYGhFVWkHeKif2KCx6k9bwQpA5xZdzg1OCuyzL1BBoe04Ff/wPKTdtv2vOWEzLkwqZ9SUrLXhOM3f/nvivFdICmAw9LnomtR+0op7L3DMeefo2MkiPqRBwWr0uW4Vm7aaeBxUPeQ86GISQ5P56ueVo080p1I5rk5ErZrml10GxsLPIUj5XzQm6Q98vF+wdYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=linaro.org smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgdjSBSr5KgI8JrdSOWfgzPiEFHXHP52KocBJ8BR3FY=;
 b=BBxPn1RcIAGfG304yRKhnup1yxTLyl00v9pk9eTwYXw2hlb8oELNFec4nm+BwZKnb4vQawgxWjWMH/PUC85T++PgztZLZE6/vGLp2Fo7pCODYOhdrhoCSDEoXepNy7zwjgNlWXT2aLFgv8aTdeYeDGHqy5bVyTsVtwH/6QkIPwHpjtfpLdx4U6WZlr89wP3kz4gmt5O1qbdwN0kfRSYG3Ila8wExXaohzKyn+78kAcqY4z7NnRlY+PNzWyVbXup2IKgGfbgY2r3dzj7m3AOgNGWNWAQ/YDpQzSDeOLDXuACD3fht6CTj1eThPLjqD96BQ5WvJnPBWqYfgoXlQX6YFQ==
Received: from PS2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:300:5a::34)
 by TY0PR02MB5576.apcprd02.prod.outlook.com (2603:1096:400:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 02:04:34 +0000
Received: from PSAAPC01FT042.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:5a:cafe::83) by PS2PR02CA0070.outlook.office365.com
 (2603:1096:300:5a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 02:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 PSAAPC01FT042.mail.protection.outlook.com (10.13.38.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 02:04:33 +0000
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Tue, 27 Sep 2022 10:04:32 +0800
Received: from localhost.localdomain (10.123.154.19) by
 sh-exhtc1.internal.zeku.com (10.123.21.105) with Microsoft SMTP Server id
 15.1.2375.12 via Frontend Transport; Tue, 27 Sep 2022 10:04:32 +0800
From:   Weizhao Ouyang <ouyangweizhao@zeku.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        John Wang <wangdayu@zeku.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Matthew Ma <mahongwei@zeku.com>,
        "Weizhao Ouyang" <ouyangweizhao@zeku.com>,
        Pierre Ossman <drzeus@drzeus.cx>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: sdio: fix kernel panic when remove non-standard SDIO card
Date:   Tue, 27 Sep 2022 10:01:58 +0800
Message-ID: <20220927020158.1218469-1-ouyangweizhao@zeku.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT042:EE_|TY0PR02MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e47c2eb-8079-4c03-0d0d-08daa02c9f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27/ma2m3JcJ0kXyXUZR2J+6oQKzZWz90HCYhPDFilVQiQI7Li4cbIchmItD6Di8rzhg2XchmEW6V1JMCuS+Seuew5W5sb1Rk3DVQGmCVnmDSxfcIzQpzUDjYQyjt6ErHXbYcFW5Zxx66Vp/wOb6+A0/+KJyzXY/SkhMdvl2gCzajqeNtKYQN0EX8DU+zJ4hKXZWAghm9g0Sj9RE4eZWGnjoKADfE0hwbXStNaZ4W+4AQgmrcczSSMsQ7F4DbgT4DgX3cO3gZirKgTeQp25iFfpEtI5GzYQsyotoOvzmdAWX7V7irPP6gJOFcrrS91VHbdeWrDI/Zvszl4ufPFopgMBQhayF8CMeX8liFhmMbOCGTZVannj2X3c6FFlEBprfVIH49lMoh6Ly6NKj5xOas0opuWzO1iKSrZqansb26p0bS38kb7vpL2ge8uvBPwHp6fWJFJU2i5b9z+rO4GKNF4TUuQf0IOPlSEYwbnbuB6sT9STD1FgdyOHfNpk5BgjsHONaChSv2tICM/qv7vBoLtSzA1UC+tMvVGiLIUOX+ZKTU4/+xkrmrLInzR7Ea7OT5dy5ESOw2P5SRlfc6Sd3bh7Uo0WU4nvNP41qnQhSooZrg9i9zddPUqhNXD+CqEYRAZ1Kgj58TzZInqnARMZa6veb/T2Fi8Lx9Ep1EENR4YtW2Ws60Kp97ND6HOgjEWYThoulZchBc0M7PN1wnsdGH8DiL+hRmhYgKoQAg+CXh01TsdakHOHE3/aRwjtfoQIhHukNuZ4w0hH75r9yOYYhwmg==
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39850400004)(451199015)(36840700001)(46966006)(186003)(110136005)(70206006)(70586007)(81166007)(40480700001)(36756003)(356005)(8676002)(478600001)(4326008)(82310400005)(36860700001)(336012)(426003)(83380400001)(316002)(36906005)(8936002)(47076005)(1076003)(54906003)(26005)(86362001)(82740400003)(41300700001)(2616005)(2906002)(6666004)(5660300002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 02:04:33.5811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e47c2eb-8079-4c03-0d0d-08daa02c9f3f
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT042.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5576
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Ma <mahongwei@zeku.com>

SDIO tuple is only allocated for standard SDIO card, especially it
causes memory corruption issues when the non-standard SDIO card has
removed since the card device's reference counter does not increase for
it at sdio_init_func(), but all SDIO card device reference counter has
decreased at sdio_release_func().

Fixes: 1a632f8cdc33 ("sdio: split up common and function CIS parsing")
Signed-off-by: Matthew Ma <mahongwei@zeku.com>
Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
Reviewed-by: John Wang <wangdayu@zeku.com>
---
 drivers/mmc/core/sdio_bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index c6268c38c69e..babf21a0adeb 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -291,7 +291,8 @@ static void sdio_release_func(struct device *dev)
 {
	struct sdio_func *func = dev_to_sdio_func(dev);
 
-	sdio_free_func_cis(func);
+	if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
+		sdio_free_func_cis(func);
 
	kfree(func->info);
	kfree(func->tmpbuf);
-- 
2.25.1

