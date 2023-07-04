Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11AA746E18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGDJ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjGDJ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:58:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F4D8;
        Tue,  4 Jul 2023 02:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQEW+WGM9MwdR8oIWTNR7Y21O9vOz6/EDHO9Um2KQ2LdktOZtug+5L/eCKaTx/5nczAg4pjxiB6Q4ZcvulPPdx3Ev12MKkm2urbZQ14xDoZFOX8D/WYV7F03kQ2TNkjkKZl54QZWyso9QKt/DupZpRzvZKssB4LXnb/8RDDySjzUX2N5FwEup1IcTVCoTwSoiLFPzK+2H3jQBNBDST/eK0LxI8bbQN79ecYO+g+5zgeIgGPJhFOaGoV21btaWtJq6Od29RGh2zju4ko4ornKH4UaFmk+/Bpipz0r1kZdl85FHN4DtUHy4lmeeDa3SuaWTppzYnqS8rbMOH9BYIr1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBZzgY4ZLSk52/A2tFG4VXwsbPZwxMCFSqQiHZgy41E=;
 b=lWWqNXBYladuW3mxsM5wQNsW9mUwdQzUj+CCVyFy0XuoddmL4p569nNhNWXldfuVbKcUISMvZBlTrpZtMQU3GIF+zlZYYYUhvXjVvYZ9D9yg8DzyZIvpg2SAjPWAcIYex2Zmwaf03Vo6jgN7te0XQx32Wo/oi1mhUWfRXvskip/AcO2XK7ZLGkCl6Bebadjj3tN1vH8qZ5jKTWpm4G9Cobw8S8j+PbiiOsJwEPzUtbY/DQtkCO5X/71qM4SvisDeMNX23sbfx6+20GTpPch0cdn51ySmbEFh4WuvBszaXnug641D6ZJYQUEXljPwcaQn0rrPp0DyelDzAqDWX9tVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBZzgY4ZLSk52/A2tFG4VXwsbPZwxMCFSqQiHZgy41E=;
 b=ZnuLyhNG7tSE+ao/p4KAAVB0u/6fZ1NoSwYu7I6K0M0jreUefTUbt+Y3p/vTBn+65oKY1oYyYhYzPoDC+VnxDhx8yTiCDiVAx41RExTjb95qbmGftxeUZpDYdjaRTj7L0whSHOq/aVxIeU+G1rPGkdvft+rVJggdqrSq6S2s56R+ZxbKD70zcm9cxYjGqCM9XJY6O3ekHDF87vcQ2DnDmk9HBWJ/VSlRt9HUAfuISmKhzPqtl1kfnto1CTCWxMYNn29ZlBFZr8bJVQfzoWM8nDX8xk3UX4+KSW0aT0WzUxUYDk1Grx3Ag2/JDyMcDmaFaylhouNv7b74keHVE+ENkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5501.apcprd06.prod.outlook.com (2603:1096:101:a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:58:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:58:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: stm32-adc: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 17:58:08 +0800
Message-Id: <20230704095808.33780-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aefb0a6-c523-446c-6e88-08db7c7535b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ac7TBf4EJuLC7I15Zq9VjFXmQJB8+Gi1P0xNwvVakhTfDfgp7xlDAv8+onwFW8RyMbZS+Lp3SRQbhO/2elz4o4jmAXcOcDmwUZ+FtAD6xR4gu36J7AczN86uEG5rog+MOPqnfDH7CpAOgSEPt7rEy1QmENkmpqP1fM2N8jZIhbC9Orjq4AKUHLqGRhLlMWAJWYkueAlrIZmtOf8kR/hFq7vE3l/p+iqWX9IISK2m0uk6GlVrrLX1Zzg3to9tV3p87nbCVK9uAmxyieYMik0Spxvzh5GiJIPnod2pgW4EN+66YsPPmnrPs1tdnNbsQMOQ6alMiLoOicFKS88x8LIfmlp4zZYcEJNs32FW2DTizha5QYGjAD0g4qzpmnxdmYuHJcadDF/L8zOWlDYz5cueom6OTOp/WMrj+GLOLGMwO+pNWQHHuUrA6buB8evQzDQpf/xpO56ru514CX8S6ldEQyuDMour2ccXheasQU4yAFEG3uLoGI+3F4RFEdv3WUc5vYj+dwnniOZIFFEYVgG+qxXD8/SUwUuZalyIrYdoxeZZjTSKp5meoGQ4nN+hd+1ex8xoES3ex2Is14QrYaS7b0P337bUOpq7piB92zjwj35wmOPBUKvJffBRTl+V0BSp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(66556008)(66946007)(4326008)(36756003)(66476007)(478600001)(316002)(2906002)(8676002)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(4744005)(38100700002)(6666004)(1076003)(6506007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vXQesqVsfDY/J6EiK1YkyqRCougVdlcc7d9O0lKOA+STIFBJOOs6cLFPjkAD?=
 =?us-ascii?Q?kEjI7/oqJbYlWGpqxWvviA6V0cOb6Wt7Oyhg6fGZN/BNeN6X5mSC6fxmZGov?=
 =?us-ascii?Q?cwVNrsuHXjXujiZQEtXwWssN9Pt4dr/bLZS8XP/qMA3C8fkeSqBeG+9ZFzi1?=
 =?us-ascii?Q?3h47SL8PmMBR+/FHowuH5QpUXhcRm8jSzsAyo7wPZUkry9aHrnP10/jMtqx7?=
 =?us-ascii?Q?1A772iWtUH1nzSpM6Xi7+sBCOFD6r2ZWZ2c5pH+P47TZcUB5tLV7ZumzvNk4?=
 =?us-ascii?Q?jSdLDj/dYrzO22MBk44Cpn6w4ucvk3GnT0ePZ1uop+vjuWazLN4vUxrIjYhQ?=
 =?us-ascii?Q?MSs77muhgSPgdScNZICWPoKOqlWxA6rq9Le/rThUVhSl2r6dYJMYrpb/nyQa?=
 =?us-ascii?Q?qrqs1N2trvRbWJgK1f/uCLdY0o4F1C8ElV/tN3mD8roxBXfSLvyk13ubhnNZ?=
 =?us-ascii?Q?TFuhkLJlQ1BZ9/xwpqOmMghz+l7xU0Dy/2KX74X2Gc5m3vnM4Qr8jjlElmx1?=
 =?us-ascii?Q?i96o3xxVAB9tnCszfoFYnjuc4nOKZUyL0GjcDHKHGspeTLnLuNVu3mYwJJ4j?=
 =?us-ascii?Q?iCYXEftJcNbAlrleNerIP5z35CS9ArRAjZnzYSRxGjYVSl/BaaElTI5g/OXl?=
 =?us-ascii?Q?GaPXs5OjedXsleGV+zZi6aBx+o1foodSgh0imAMX4R+hz7BaYEivVwu/N2tJ?=
 =?us-ascii?Q?wRG4JXABhjecaAmBCqTX3ntmckzCs1RSi7WdFE5RbD8yRtRCClBNpSOlmVsW?=
 =?us-ascii?Q?/Gu1p2r9Bd1AMaYKbt38q6w3EVHKmu5nGhYSlrgwvYqoWOuJb3JzOJMxyuhe?=
 =?us-ascii?Q?5TuD4CUvPkow4SP0G32qhR5CwiFs4oUF1ibV0vFDcsFP1tNcP51s7JGJbcdO?=
 =?us-ascii?Q?wCwx9lS470cVr3HU23YHRmFCQUEOBETJFGOwxVEsBV9NPo+DVxO2U5wkB3qd?=
 =?us-ascii?Q?NInto6eKXAPOsPZs7dksif8maONzB6LzZaA/6qV2PJcxbID4iV/FpsHwEsLW?=
 =?us-ascii?Q?tzpDdmTWTLYJi7oRZ4j1r72hts+LnnUh6VMTnWas0ZzhJlcdRtjvQSiETB7b?=
 =?us-ascii?Q?pbsRsYXOc+mS7h5n+EvzpAVYMCXqS5o9q5/pBkVWrzWA8ecPn0Z+6lDyEaDA?=
 =?us-ascii?Q?TZEkObdNqXfV2rz95lshvexoyqvCu7s6CajWlONxpaGcrYgJ55KfWtURGkMr?=
 =?us-ascii?Q?CneENugnTBCekOewTG6UA0QR/FmdDD5QCPp+hae7ba/au0zclO99vVFLneGv?=
 =?us-ascii?Q?V9APdgp/kJQjeGjdRtR/7NxoK16W4i0SWHzET105Kc+zgrFV7BKwVqB6UFUk?=
 =?us-ascii?Q?Mmg+8pu80JPSIyo1DTmM3r1ffBfm9794HMxhW0LQjnGmLXe4QZ3V7ywZJQUU?=
 =?us-ascii?Q?Xq3+HxlIy+LyOuyI+AkGdnSfMHeQY3b5XbWo9UqoZ5aspVydAwzPtfNRO1Ic?=
 =?us-ascii?Q?GljmYIXsjjSHxOUYIbA0CX22GgPXwdnLlvcHfwMt59qwkqGo0wMmdknsCHjv?=
 =?us-ascii?Q?wS+GXfOANMjm8k07wtuJyBluFbj0x/+UKXRQ9iQKOL5BGZLhbEwoDP+8uMxe?=
 =?us-ascii?Q?uWjADAH97rJMFTY/SqaEVhVizdYALrvWhjOc/3ZK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aefb0a6-c523-446c-6e88-08db7c7535b3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:58:25.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixFlvSPJ2mj+lwpMA0NoDNTIFRuWgsrdNvJjI2TVezzlh89emnQVnvI7zrA1HklJrmNUDUO31LYFkYfW1tKc6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/iio/adc/stm32-adc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 48f02dcc81c1..99062a0ba1d9 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -723,8 +723,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	priv->nb_adc_max = priv->cfg->num_adcs;
 	spin_lock_init(&priv->common.lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->common.base = devm_ioremap_resource(&pdev->dev, res);
+	priv->common.base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->common.base))
 		return PTR_ERR(priv->common.base);
 	priv->common.phys_base = res->start;
-- 
2.39.0

