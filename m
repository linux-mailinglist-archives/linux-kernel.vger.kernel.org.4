Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB664C281
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbiLNDHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiLNDH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:07:29 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2096.outbound.protection.outlook.com [40.107.20.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94123E98;
        Tue, 13 Dec 2022 19:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcfP8wtxDLDr/0nVTerbm3Rv5F+iweYDb5+cB4X0Fvspv75NMDwlPjBl2u0YpS9EKWaHdReuOk3aFjG4SNn/IOsjX721garRMaptyefrR7tA/ritbCp4STOlSGlk79uiuROFusjIlbPYAaMp56AZ6cyD71nHsUkt2ULbPuufMhgkqnvCdOtAF229PeuIqTlW6AaHrUP4lVd6+90vvud4xv2huK0AIhP86CJbBxKyQgtC3YYJrXVJRQ5W7VLD1m+71XuUj3BTyl/qovZpJL1tZNgWp+Np+7cZXLSg7bV9F1lSRu8ecGUU/92rZmSGfKYkBuRme+Pyfr3QjRUtWYWp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNhgg++7XYZCxDQ3exuoFAjdW8gkfiAkvkYfHpL0q7U=;
 b=kub6RHJxu497je3lcqLxUSCKfvdEHHs/LBxzHier/NuotZCRUqNCLL5j80tl0Pf/47dvBGfmFpBFQorS6ODAqxjjLhJ7YjCWSeLc6i/LRQ4khMWR7MtnSTnTmeDFOhWNu7cM4SDmOB+6Opw5jUfC8Srd4Uq+HAC09VV08frs5Wmq4LPqQSQAb3J+GEl0yxnHlTADDQRaLIinnFiW2Ysc8ZK5Y6QjmYjeHhbEzBVqDm8wQP7WeV2LgiPk9FG0AKranytVlHzxWQf6EhW+liJ663jvFlfzZKCpoQHxAltr6uS+CUsZIebbCG6evUI/5MKt/qtqGIcJIG8DiBz55HY2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNhgg++7XYZCxDQ3exuoFAjdW8gkfiAkvkYfHpL0q7U=;
 b=MxXKutgrx4yBHUsURBfcLLnGMAzHv3E62VE8K4N+742jiLFcIlzsx6we6cETN9SX1Xz2KLKxoZCd1GiTgDLtqWajM61pOuHPUa0azKATNh6OMSyTbTcPrPRJJuYxpU+t6fTDzfwUWSJIrvux/KKJaDBtuRSzAkN1sDLDrW0uUKg=
Received: from DB6PR1001CA0042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::28)
 by AM6PR0602MB3733.eurprd06.prod.outlook.com (2603:10a6:209:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 03:07:22 +0000
Received: from DB5EUR02FT062.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::be) by DB6PR1001CA0042.outlook.office365.com
 (2603:10a6:4:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Wed, 14 Dec 2022 03:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 DB5EUR02FT062.mail.protection.outlook.com (10.13.59.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Wed, 14 Dec 2022 03:07:21 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com,
        bsp-development.geo@leica-geosystems.com
Subject: [PATCH V4 0/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Wed, 14 Dec 2022 04:07:18 +0100
Message-Id: <20221214030719.4123889-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT062:EE_|AM6PR0602MB3733:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1df697b8-11d3-48ff-ad82-08dadd8051ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLKJ3Yt+XsXz2oYuZnCIZgsaR3zwcQV7aKkLt0uwbMlvkMdMwI50MmR9L6MGFvdV74dnz5SsvRgTNAOvWnhIutAoUcnnKICkglS7aQEPnZQupbcki7ECutiv2kIDhWFNEQQ7OId91RyJwzKEf8/x3lBwqydSVd70bQjTaobT+S8LvPzhKScQ5M02vNMKhO5R+dM7UDnEyoMv1RV3ARYWcK8CNJSvay20nWCetjCL6SJRJWL+9sPp8npSuhkxWteZXmJ+EeyqM2ucoZaDm3gF0CnyaKjGodmELooLaqVyQVrgqKcxn1VF9PdQmskhTkL0626PeGaVugS1Y/7eq5LKkfLxFZwJv923LGow35Un7j3QQUl9tcz2SIDTU/cCBiwg2ZqPxevai767l8nqsVHiYTXn6WeuZV5YAoBmhsE5KEEIhusy0VPAR1mz+bowlOfNO79mi4pB9uFm1Gq1bhC11K8m1lUNv+izDoCud01oecky+mJeSxKiwntbpNVQA4hYSStBcSQBi2nyy+0IX9WU3+G24+4ncmAcc9Q52/0UHgdPByXwVwu+ALVRajZRwV+6cJTAn2k1x/QpXTcZs1/wPXuH1IlXaGrc4U+pNC+KoL/N0bGeiCyzbAP7mvwdqwmlX5+/7AaOpINORaagswQoHbbXKnJBeS68lNSECrP6c60P3I4YF4ucrLvhhI2/58H/VRqwk+ZcDDrSD25kgbjamndVLLusDhiuYcwYm22wx59RiScB6XvgAIsajqjY19A6
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(356005)(82740400003)(6512007)(81166007)(82310400005)(558084003)(40460700003)(9316004)(6486002)(86362001)(921005)(316002)(36736006)(478600001)(118246002)(8936002)(7416002)(956004)(47076005)(2906002)(41300700001)(5660300002)(70206006)(4326008)(8676002)(336012)(36860700001)(70586007)(6506007)(40480700001)(107886003)(6666004)(186003)(26005)(2616005)(1076003)(36756003)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:07:21.6051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df697b8-11d3-48ff-ad82-08dadd8051ae
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT062.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V4:
  Remove the blank line.
  Add Reviewed-by: Marco Felsch.

LI Qingwu (1):
  clk: imx8mp: Alias M7 SRC/DIV to M7 CORE

 drivers/clk/imx/clk-imx8mp.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

