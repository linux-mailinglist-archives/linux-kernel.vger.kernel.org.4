Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADAA680638
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjA3Gsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbjA3GsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:48:01 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3A618F;
        Sun, 29 Jan 2023 22:47:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5y9ig76OWnLnJyU7FVY5tcJ6IYV5dih7DQgpFsja0ocJBg7Rd7r6CtcE7cTEsqhM9v5bjtzJ+z7HQTpVhKS/P6+4i/vq87u+fq11enHTn3tLhHpS+I/Oh/XTCaXKGTAy3jcRkXUfyCvxRNFLj/0hnrPJ4J/f+2AcaB5EhlBUtBf9vBZM796v3TKwa1ARFalaMNIbxxKSSES3jYs7oX/WwN5JsOkr1FSHlzzqEBmXxDYUNypCNI1Icmb+4NAE9BM6uJJDd4fJCE2KRMu0BL4zlaKMRKIXafnVnj1rtLmYLp2VeK2MUyVvlEi6HdZ+IH84s32gMQfaTvg1zV+F2J3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd8qSDkGXGLDeeVTR1Yxe9HSdPF2fxL7p1mzjRIZLBg=;
 b=l2dKMCKe5a8AeWahiOuiwNMO/O77GfsjOpqnXsAsK0aFIaI7R2vexPhSjHAqhCbVYO3mFEOMb7JR6/xBkSQ56CfZmpCeJj+7YwR4OF5SLBOG49Nsas8CUJTiZps2gyXOqpy47DGWykmF0YZ2OlTnSHR7HV/nT4mvDI9VGGw5z40DCqDKGlc8ryc8TQs16wC+0r22YBei9oHSkYxmtXOCPl8PlRTkH83YRlhfkln1AV0LGDWtI53dBqF6/yA+Yr+XZbwNnW1ta56W91rz0OnIPp60PuXeP1F5KP6b2ccOmOnXsZtlpqd6E5SxVi6NDvqUSKqcNAvZgxQN/vzQIiMaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd8qSDkGXGLDeeVTR1Yxe9HSdPF2fxL7p1mzjRIZLBg=;
 b=CS1Ka1jWdN8tCNAWOeh8j8vxj6OQ6BKVa06IX5oXKjJ0/e2O+tG1DbR29ThoDQ9/UVFmzGMxYQAaUcIGkEP3YpADLbRPMTj6WXue4bTd2WoIDop5yyxAnayKBXKYj0JbrDiX+OQLWPU8s9V99zMLi4wagFun+jku6cUCoyLU588=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:47:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7f24:bc0a:acd4:b13f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:47:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 5/6] tty: serial: fsl_lpuart: set RTS watermark for lpuart
Date:   Mon, 30 Jan 2023 14:44:48 +0800
Message-Id: <20230130064449.9564-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130064449.9564-1-sherry.sun@nxp.com>
References: <20230130064449.9564-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 493897ac-9805-423e-7e72-08db028de716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGycUL7FJqvUnx2tHFJ6QtPqILeJEujov4oOjwJE7SDnLipJL8JzSBhpQLOz5JXQxoo1uGv/IqNYAQpT/9nANk/C1dOyMS9lLQtgmNA+be0NdnEcx5aX1DeVreWVeAd1eWyWtU7FADMwVngFE++0Nw5gRSaTW3pZmUNOgpiF6utmuaAZQ4upBNVty68HiSjLXyqhRuClo00/GpMW8b+AiGjhZWBxZMrFQmNOlrseKYX+FqhxQ/Avcfhj7+w566oo3eWq3JXMuAi9FW4+LZTMgD8Q4JqEILGSGSQ8KJgZn9lKxbc3fzRNWJhJgIXFbvM82tMpalMDFVtb3OsMDiAHOGWz5rr8VQaaqWsj3xMwG9VNSLxJKpi0hfAzCT0j9k2hUEXyCRM/FTXh8qHXDENs4sJrIMUY7bVwiG7vmfwKJ8C/v7yw5iNm1VAZd6lrKk3QLyrrwL/E1MIMOqEnYakYgf9iybkJErf/jmV4aqAN+5OdHHzGqNI74bwpUS+WiBEnndGvUIX3M5PeEUTyosjRQwC0Fv63qMrYPI91kz2LD7ZctUiW18ZlpW/eYM7FO1RK3GTRiHboGicAcdHCYAsQVmZ/9ezaOUpQGC3gt+T2Bxor43Ud0ZdoM+18eLDBouVp/4/Mt+cSazVbi6885ZzQFlbCKnqiKDCxlaFixn+leWsDKtlhkcCBeRuIsGuS0ngHkm8PTJXgjejC5IE2iUplzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(8936002)(41300700001)(44832011)(5660300002)(66556008)(83380400001)(38350700002)(38100700002)(86362001)(6486002)(36756003)(52116002)(316002)(4326008)(66946007)(66476007)(8676002)(478600001)(2616005)(186003)(6512007)(26005)(6506007)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+WvVCKV9XMkbqKZUoVODnp6I/SqRYhkSghGPtEaYUx+GG/2jzFh+fOwAeUn?=
 =?us-ascii?Q?qqxkOkoUHVi0GKFA6NSzOTi9C/RQBTMSx1uZ10sZ03dZSnc2B5jTh4/lYWgB?=
 =?us-ascii?Q?uMWfhhAH1pBhWeJVlU5dUMioTJPZxCnw8j420p36JQ290c+ms91ZGrKfuWtk?=
 =?us-ascii?Q?GN3PF1KAm+DtnTEgZ9NyyBSbBDLzopiSaFG+ikZBBJ+n4OD3gf5HQP0jHrkn?=
 =?us-ascii?Q?nCIeJk/qsXck8dexFzDqnrSYBGM5tmH1HXt6B6earGX2z3g/4IX6GV9AHoGJ?=
 =?us-ascii?Q?Bib9APrsiprJyKnZ7GDOpk+b4YLWl651EH7PquF85fMLHD6cyqrqBMKEcS8v?=
 =?us-ascii?Q?+Y3rgSuLM/SCducaOlwopoTVf2G7fIufZFvg3keG1W9NwX6be7700gALFirt?=
 =?us-ascii?Q?91SCVs8rFdunfKXXz0mbeRcXUYeyNh/IaFkRLLLjQVm82iyA7kqi9V3Gv6ts?=
 =?us-ascii?Q?ThjN2SEVqqFBDaQOjYrf38EXRAsduOBODPehn61NwR4LoEqBdnsvQnxxA0Cu?=
 =?us-ascii?Q?QXaDFaDpl1b6e2dC3yJZcg/CrmaimHGjF5hH46ClJNzhRFV6FJy/wXkQr7PZ?=
 =?us-ascii?Q?bjrq+jcFlacnfWnrCmjA1KHHV+gFvn1b0uU7oZ8kILZXWRgLT9BvZ5kfOF+Q?=
 =?us-ascii?Q?NIXXWCAEOrxYB6vR2q2zO2ml7Fyx2rdVTuYNge0PlpILVN2Bv8tWNjo9t6Cn?=
 =?us-ascii?Q?VdoFWK7lnc07WqRnHMeHTBylfhsSohudpF1LiExDPB3DQyjWCRfszsbWg6CV?=
 =?us-ascii?Q?6OeyFirjz9DfT9VnlQG/NqdtpiacNCooEIQdjtFm0MB21sUHMv8RgX0Q+RFX?=
 =?us-ascii?Q?qGdgIdndraAHuGNKrb9Ubx0IlKxEnLlVao26kybx0rDTJh5s9hnTqpZuHLuS?=
 =?us-ascii?Q?JYlYRdyN4ZwDa9QdxtWc3k7JOu9tDyv12XsJvroLjDOBK4msuluHu9cOCIAd?=
 =?us-ascii?Q?wECO48F2hJ6EpZM0FWMM24mjmZZUsJylT0N90KAg7tRz6DGcHPTKb5bowcGY?=
 =?us-ascii?Q?G/+xgHpbOvMwHvAx3jl5rSCKQIm9yU3QGfTKY+Wv4+KjxhsGDhRkkEe5s3Oq?=
 =?us-ascii?Q?Ey7895cYlll52TMqUh60XSI5tjbZ8AhPJefHotr7EjuhfXC/sTi09lkn2XZy?=
 =?us-ascii?Q?6/iksYWPzi5u3ae3CG+OCfgPexNLy5l9dgKAcGmm/82FxAlacedf88nSm5+f?=
 =?us-ascii?Q?BD7f546a+uKFE6pLBZ+KZJO+iuERn/4cZKMwiY/5QIGV7CR8X9KrjEIBk/D6?=
 =?us-ascii?Q?N9D02PPIrhMKJSTYZLOJBgu5Y9IQSj6C480PjG4D/Jb95j8usgZh2XDHzX5w?=
 =?us-ascii?Q?O96b2z2pl0PHQeWoaoxcAF81WeT9VVwZ9x3iE6+LcMqMbCJ+/FYhHH37rA5P?=
 =?us-ascii?Q?zp3grp65iN4JJvNN/B/44AxRL9bGMfJRmPCTdSAohV8P2PUYGIJQ467A8qns?=
 =?us-ascii?Q?82t4ifxHZvR+MBtWcYem5J9UNtEgJDmnO7Kot8qDaQAlegIikDJQ1WyUyJZc?=
 =?us-ascii?Q?PwaPJAdC2AToTQ4lmnhVgw5+vEhUu9i+yhqw2v7kGMdSIz8u3xbGwZfcF6a9?=
 =?us-ascii?Q?kBYcvm6dLtZmxKVvRPhXiHU0tXouqWo8mweoaA2D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493897ac-9805-423e-7e72-08db028de716
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:47:49.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YTGqv+wfeTZ2rd0YECL0ggg8F1PgJa0ibBvtmu7eafajxax5DsNY8aO45ys/YauS9oyaRVo5CT/XrZzFVEwaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RTS watermark support for LPUART. The RX RTS_B output negates when
the number of empty words in the receive FIFO is greater or equal to
RTSWATER. Here set the RTSWATER to half of the rxfifo_size.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 2789749d3d0d..c35e49a09bcc 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -201,6 +201,7 @@
 #define UARTDATA_MASK		0x3ff
 
 #define UARTMODIR_IREN		0x00020000
+#define UARTMODIR_RTSWATER	GENMASK(10, 8)
 #define UARTMODIR_TXCTSSRC	0x00000020
 #define UARTMODIR_TXCTSC	0x00000010
 #define UARTMODIR_RXRTSE	0x00000008
@@ -1573,6 +1574,13 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	      (0x0 << UARTWATER_TXWATER_OFF);
 	lpuart32_write(&sport->port, val, UARTWATER);
 
+	/* set RTS watermark */
+	if (!uart_console(&sport->port)) {
+		val = lpuart32_read(&sport->port, UARTMODIR);
+		val |= FIELD_PREP(UARTMODIR_RTSWATER, sport->rxfifo_size >> 1);
+		lpuart32_write(&sport->port, val, UARTMODIR);
+	}
+
 	/* Restore cr2 */
 	lpuart32_write(&sport->port, ctrl_saved, UARTCTRL);
 }
-- 
2.17.1

