Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E6563F9D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiLAV3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiLAV2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:28:31 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA4AD314
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:28:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7KDeaMkXGPs1lqXoL432ZKuI/lwjdYHQT50eDDjC3cKURTi3Wr9qD7lf+zcfb5n3ufQ+tn2LzCbWKX+N+kesX8caTlcq/Pb3ejql+j60bWq/L6RKPquJWOoKIzFImQNhoRpq5A7dwxoSRkL2b0HVZvmnuiNplN+Hk2Xzgx9pN1fQ3UqYYAo2GlUib1J/KEj3L3tn7axEJulBiAv6Q/G3yhDe1cWYj0uriFTjf4u6TpG/yg5sFwnAm+ORQl5SPLyJC0DKZdZCZYjZwfFlTUUTNVDxsoL0j77DqHVTfElgAjf5FOGqLEpWm+2Cb+5D995/ywSQNk+hHljWB/RFYrxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HksBDMgcloWtuciTMBvCJiopBlkVDGTvUNtWz2g2ui0=;
 b=lwRHlA6VJuwClUy7RbKv0orJbmWaMCzdi4u168D9z7Z2ZQySX99a9ZMrevreT1FCUVQ26TfHn7xxEB7ofAPbQHfg1Qqu+DGkFrQmXaWCoXpp2R2V+07DcJvbO+7QGGP1qVLXMFWMhvPKtuH8Kl8UUN3w99k2xp6YzAjRjNm4p2L4TB8lCVbb4YrJ/wClfm2TUU+0yyxluy71/SJnMS8rj/KbBEEvOppLzWR6KEp6eh3UAHpk02+gQKpOWxlwikq0Zt5JHoI6seFS6Gjq4bWgzc/mh1rO+yWJLG/kaLg5qvQGV0C5pg56jEeDkKbTDfQeHMeLXIoRQkASP7x8tM57gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HksBDMgcloWtuciTMBvCJiopBlkVDGTvUNtWz2g2ui0=;
 b=WImPuGsYRZbIUfg16qzkYyFNlFa+gQeNQkLVUXyWHgFPazArZjojJ39vOHv1TWpT1VmHYY3pFz8H+zsifFG0z+DxlFfmM5UJdTarrV/FenWg3BIGXWVvY62CiGxBbQdWfzFT+r6HjQFABr/dFWHNYQ0nAbrSRY443qLeHTG/HZFc38Nzqc1vhz/onSMz9R/JPx98BMMg4g6sbz581QkYdO7Qun1r4bzObgtwlvvvsCPbMvGxJ9RgYspVXsf2/XHxzXw0J5m4VlZkkMC0Q9aACrj9sVo0d/xOH/Dw90oyYfHEp5HfPSEnoFOrlrU1VgfuO9hXoggSAvLzkp30tFecSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB6819.eurprd03.prod.outlook.com (2603:10a6:20b:2d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 1 Dec
 2022 21:28:19 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 21:28:19 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] irqchip/ls-extirq: Fix endianness detection
Date:   Thu,  1 Dec 2022 16:28:07 -0500
Message-Id: <20221201212807.616191-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:208:236::10) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM9PR03MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbaa5d9-2ea9-4772-9775-08dad3e2f677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iqi36ehODGi3O1lZ5ZYVEyYSXy48R2nnzxjdmmDiO/bJYWSK1v+QYt1ruVZUMmcBozXKxdiEygWqSxeAA4ddZ8XeTdGT4qaopWiBhILPEwZFBeSN6oKFGpqaLLo+zFt0cxH7ysK/a5GP56es+zy9JHNIsGOsr5Eb16TDO0PV9lTsDwGeEqLkZGKG2mjmjYm+4TdIqWnNlfyXci4abpMIkO3G/Gx6lv4ijHnlCfVPnwSr4pMeCWwjhrwJ+8ORSGoz5uLV1B2/dHyQ0i79hu2ehevs0UQkeTlyPeHRMsjVdWaNrKGqpM/mdhAzAV6LMu2SvjZURgYoDT0qkMWrRWdmSAHtKyidtaHdkNKgmKBFYAVqs2i+DY8lpje2/EsyK2uiWwYS2g75ucnfDrhjGqMpFp7rXRY9n3h/6d5uHXWPfo9uWwgeERuNinbGrfXcxKlu5FCtbkYVt+DN4ermy71gLIa9btmHVmwxnX8g/h5H72N28/EjBIa69RIvQosm6cJOxindNj4mDiKVlFy4FGyaGv8WbqZp8GSIE0EZ4l7IQ7y/moW84v739BmvZrEFw+YjpRIiyFcHv3SO1N9qRX9bBR1xK66Sl96oKrxlKOZizgn7uqxLwBZ8zvgELhLUF8AIO/A6AcfqcrYl5ehEvwfTzOLeejFWT/mlA2orkFS3EaDzjtQXCdox8MnX9i4HaEHo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39850400004)(396003)(346002)(366004)(376002)(451199015)(6666004)(2906002)(36756003)(2616005)(107886003)(86362001)(52116002)(6486002)(478600001)(26005)(316002)(6506007)(44832011)(4744005)(66556008)(5660300002)(4326008)(41300700001)(8676002)(110136005)(54906003)(66476007)(66946007)(8936002)(38350700002)(38100700002)(6512007)(186003)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+8hUfHFJOPxvmE+g1FDePhgIjA0qiLi8szT/cOV22vOaoUC+1lGOf6CPSZx?=
 =?us-ascii?Q?Sf+X3OYTU7WhCx8Bbzj1a5Nr2KFcEk9AYt1NrKa02Zy1+gr4J+a88uIWCTxk?=
 =?us-ascii?Q?G27E7mJOpsrjcG/hTs0T2nP1YVlGahQXAbCEK2u3J+EcFLvg7Hujg9ppmwRO?=
 =?us-ascii?Q?L/AH4+eKeccedp62ITQZwQotuGdNwBpv3FHe3ngS80+dNpBB2HBhHAMyDA1p?=
 =?us-ascii?Q?oSV+5XDdk9cHr9nzBYzdPaRuKtcs1Ei2HBfQ3aes554tH0mrbvGCrED6zzMB?=
 =?us-ascii?Q?PGFfjINBnezNf5p57FSNB59MZH4wSRuLz26XmimbvUUbL/jfObzuDm3L1IFf?=
 =?us-ascii?Q?DZ/c+sIwZAg93cR33uFq3zWd7C7V9BMKwE8hhcAWvMtA1zODNqlHAij7NE79?=
 =?us-ascii?Q?LjXvt1dW83JpMEZZpNcpfFvLKyAqZtU76bZG/f9XFpZz2J0lQydj62DPdhtc?=
 =?us-ascii?Q?6ebcBXtyA0kZKCoYQuWrud8N31KpBnP2810ZWb+xsHq5a4aoP56/QHmZDlvK?=
 =?us-ascii?Q?uuvJz9IlErB1w8f44Qq7NLaZ8Tq/CG7Tkyv+UlHjklsHWw0iZKFaLxNQegxb?=
 =?us-ascii?Q?j8sDjazzWagClvLnjm43SPfp+MccCbDCtuaN/JB9oabo1WB2opMMeECYWYW6?=
 =?us-ascii?Q?xznE2NKUXFiSzwU9jxMEbEJ1CykmTu4golcSuFHCdlKdca5mlVISk6TGDzkC?=
 =?us-ascii?Q?n8Os51HyiDrnPjg5eNukeJAyp3TNHYVqByr1pJrovEMPmok+AjhXDwGGH7Ko?=
 =?us-ascii?Q?bOJwYEQI4ySDlegUWu2iZu9w8E5caIZ9Fg5W8EQvJlwvlIXCmFecPU78z/6D?=
 =?us-ascii?Q?r+12YUTu2exBU30xV6jK9Z4DJ05j4MT6NCxf5fyBn2aGPMfDiO7qJPVIuDoj?=
 =?us-ascii?Q?2oW6rCjKr/fYLu7KFsSzWxt+MZS/HARmbJgO3PxQsHiNHsfWiK9sV874+iS4?=
 =?us-ascii?Q?hQLCJ8JD6qyOCpZ5hgztZjZBlASWpst3cOPSDWvE0nYy0W3GBZQuTfcTc3KJ?=
 =?us-ascii?Q?uIH+cXBCi7Wt4h3B5tivleMp/mvSBhgpQzP1zPYtzwdptYev4eAPnGDiMP/L?=
 =?us-ascii?Q?uz4XXgG7iFIqbYTyKWuih5sUL9YrNAdJUUeK3Aqd1qxKT5Ugj8aJlPymF8zT?=
 =?us-ascii?Q?vwtwtcIxukV354JzAHOTPbrBa0M+8vAHO4WsOs/FC8jzAuGsjya5Xtt3PvJJ?=
 =?us-ascii?Q?607F//+bKp+N596zKW/4wdWrWelPHfvdvK3RLnYN9tr29PAyynHM5UDql8Fq?=
 =?us-ascii?Q?8mqzs6AKL8+dMb877nJTF+HiCqU5ZD4CwdId2GvbPtMHnDB49cHamJtxD9AI?=
 =?us-ascii?Q?PAb2skHPSi6vaHdJW7+UN7gHwEDz2tAvb7xXrUS5dAO6pZS4HEDDhblKuTK/?=
 =?us-ascii?Q?62LC6t2J78vfhySFswmUmPBHP+i1CYiaQkm94aQJJLkG2CHf6FmzcBv5qgFA?=
 =?us-ascii?Q?hF4OSR0chWR+X76j5TLtTYBRChXgO9Yw+dVUS1szxT3ZFCaYW3QMq2LOxjNa?=
 =?us-ascii?Q?xlaSY1/3ZfeWa6C97ZFcZLjcXqwJA2QuRqgfbAiuuM11GEPy0QRRldAZiSfy?=
 =?us-ascii?Q?EAUwI8jXavLZhmUvw9yQjaCIEtFvWMkGsW2SY0f0+Dd6rPvgh9oC5288AQx/?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbaa5d9-2ea9-4772-9775-08dad3e2f677
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 21:28:19.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wgm9EN12mCR1x1auwMVrW1VdiHukTzOERZFnIqsH0nHURoMwyKExk80jNR665H7tJRaQvVQI3272oQ0H2y99nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parent is the interrupt parent, not the parent of node. Use
node->parent. This fixes endianness detection on big-endian platforms.

Fixes: 1b00adce8afd ("irqchip/ls-extirq: Fix invalid wait context by avoiding to use regmap")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/irqchip/irq-ls-extirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index d8d48b1f7c29..139f26b0a6ef 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -203,7 +203,7 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 	if (ret)
 		goto err_parse_map;
 
-	priv->big_endian = of_device_is_big_endian(parent);
+	priv->big_endian = of_device_is_big_endian(node->parent);
 	priv->is_ls1021a_or_ls1043a = of_device_is_compatible(node, "fsl,ls1021a-extirq") ||
 				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
 	raw_spin_lock_init(&priv->lock);
-- 
2.35.1.1320.gc452695387.dirty

