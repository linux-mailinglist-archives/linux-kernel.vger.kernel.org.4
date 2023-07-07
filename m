Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD4674AE57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjGGJ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjGGJzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:43 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A3610E2;
        Fri,  7 Jul 2023 02:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGEDfdjJD4ne6rx5MiSnWxJ0dLY2nJA8WwijoFhfMu3UtJGfb3OElOD9+qgU9DON1HF9x+By0lwzFVU0V1OoMe/WTD8O9SxKCsuXKS52N5TPL+UFBOFXPd3Xy/hTyctIkhnbjctXdHaiOz12Tl3Ypgdg975y28id7HFS2WzI7cHu13YIQpLKofjXDgHFiOjdWjipA4Lg8Z6LHWiQigaDKIafGYRYOWQ49BqqIc7I2D9Pls8i232jBGDnKW5UtYQ5ZClXuYTCdXbkmy2MV9LrpkpyVBUEcb108vwkAVcnICZma68IhakS3WlrGIwMzW/6YgVSKs8MkPbFWmllyRjcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiGm67ePCX1xaCe+CiexNCc4ZDy2lzA9Mdjt6KyrAr8=;
 b=cVmlrWN6BPim4RDykg0OUX/0p+7CrFZK1Y2J9362WTnhm+SEd1mPXnpd2LxY6jqbZ9JBZbKzZxtx/KrGq0yrm5/SLXpuoLYyaOGihv/+tb+Z6U9jMYuIvGKcN4Oag2PnmThccrVCPW+U0oo0/dGD26VI56aGSGo3ukc+gHRxFf9zACMwKZDvNfi9hsoo4beXBpjNvfL3a7nAc2PXvZgMXh0JQCweS/8XGaPJT95OwJsSYfEp30YlANCzsEMSwA9XeU0f4YQBEf6SwWB9fcBUgalu5FEZUilj8b5HRsYqT+3kqeiwSad7OBEWr9KW5XkXA5ef/jz3+lJ3oT/7JA+K4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiGm67ePCX1xaCe+CiexNCc4ZDy2lzA9Mdjt6KyrAr8=;
 b=f0+C3iE5giLLYKoFsb6rW8nLn4Wfkb1Cs379uQkVTqW2Z+CPnU3Ol2E4ddrOWdvXjtNZx+37b2uMC8NiesXg6rlqraQnpf4zRKx6UxqshkNGIBfPX99IVXXlcgfh9ZPlHFGfTMT2gFeKeeTmJ4p7v7oO5zKGjI5IlObNjZxISwNsNmkDBTPfHL8/2V+Nhs9eyPBgS5a5e+GUkyyZic/aLwzFs99EenmMf8dlqrK9/RGJulvzDygauEtwkwrlo4CYrq/nVcC31tzmgIuFeIJZ723MfpT/vzjEsvlv8+HWuei4E6YhRW1Rsnd6C8D3IyF/USRNsZdYhkQNb1fWUZAJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 09:55:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] ata: sata_rcar: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 17:55:09 +0800
Message-Id: <20230707095513.64224-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5cac86-9d86-48d8-ecf8-08db7ed050b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jj1ptkEXdpiGyjYH0OmL6tPeNdK9qEyFPvdspRBy5pDeoLPQSa3wX44TPMrRbW5NW0N63puMEHjyCg21o08lLaRacKDOvo5rkcJtearBgzOub/s87k6p0Luv42HFcETF5lCCLVL+/rAK0UJzWj0pBlymiQodSFm9sitp9f6tAUZgbcJ5E4XaAAlhWEsuV+UG7kuTFHFVO7+zWWleI5r8PdyhnfESDQ3S+I96iGx6LTqnlDcijWL/qdcTD0X5bxBuX5LI8aWOwS5QK0yexSKF/mJSbTWuhcVA1+WxHzQibTDJIczIeJ63nplt2beGhhZWV50p1hDrbkkMYuwSSG6IKj8xQVtotH109Z2h2VEVGlykYowjYUiVilvmuXQHOIQBwaYsjGw9W0mVqLQJ2N5q9sZiF80whXBFDT4jHS1fUFIbeMpMfUg0Bi2T5JZZWhG096p5Ce+7OfmBmQ85v1HrrwqBgt3egKxFIXzDHwC1j6Uw21vmEt8cw5Gh8FHR5IgUTj2eZGBxXrMZ25QVrjhCIs4UBo7AUTRuZp41FhTPgSmNupdN+HhwAtZkPly7TNfgAR/dVobM0houIUic0BfKd+FTLsW6J2FL7MHixAKF8S55Xn350HAUgvJpy08hl6hF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66476007)(4326008)(2616005)(38100700002)(38350700002)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(36756003)(52116002)(478600001)(6512007)(6666004)(6486002)(110136005)(41300700001)(8936002)(8676002)(4744005)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JaZH0S67/h3wn3iw6Gr1lt6bvu2JArEhz8yh8vr6eVtyOxoZesDPUHFaJmw9?=
 =?us-ascii?Q?hxhLluVSlTpZQjzOOYAHHuM+z9KDr2dSkWzS1PcBZCxxWhL8IQxCT3IFnx28?=
 =?us-ascii?Q?I1Kw1FopAEmOIAzUHFjxvuQUlw/lBXhQFPDl37+/vkscK5TkESONbiH5OHfO?=
 =?us-ascii?Q?eTEg6iOZS31tXWjAl/WtRTqIOadX9gCs++8MhH6i+DHBiNnVOPABVW8ISKFh?=
 =?us-ascii?Q?hAnf1oMoBisJLWI7ZXV89egZ/uUE4kPxF2CB7uWef9jS5Eq7HpS7QrJByJKc?=
 =?us-ascii?Q?0CgKtffEheGsEYsyaDvlQaIMKjrxdZCMweLNnQydmN6za0F0OG+z0bs3avbK?=
 =?us-ascii?Q?ggwROXEoePKMzgmWjLj01+HoDz/l4bj46ZfD0OW+/mEgdkMz2e1fHWDTda6H?=
 =?us-ascii?Q?eMPfb+MQ+iHNxNAXbwkXk+M0U9AkN7IT9IRc1bfrhdDK/AG/NV2dD2Ftd1jo?=
 =?us-ascii?Q?8OZB6pmo/hcnrSZ+odJMorR1Stig2g9iSyO9KY2H2968jkRgm1CtIEsgsyPx?=
 =?us-ascii?Q?ZRRiwwBPpPCpRu5FJpG59Q3gpw7NKil7JuAEQFY6aMSBxEPmqYkYuIYPhZaR?=
 =?us-ascii?Q?Jev7SNsYn9T1PBgkyc62cCUVBkJnTpJEGW+fN39RusnGmOHFL3R1Qlu0NQv5?=
 =?us-ascii?Q?csH+nK7Oynw5KZ3ndMs6UI4LViT2s6zD7p4O2v/icl9WsepCYWKoLPgvZ01d?=
 =?us-ascii?Q?gxO7ETxAeUFLf8nqSblhsmiCUJ2RMug0d7dawq8IpE4gIETlBnW3613w0hFe?=
 =?us-ascii?Q?wyMUA4a1kyNK3OjLBbD+R9Tcrg3Gxrru0FJ+4/CAGWAbYL98XQR/dKE8c3Jw?=
 =?us-ascii?Q?ui7VIie9VdsoX6mddgPBGtU+RdE7CnzSv0/JtXf7K5/MngcmmYuvH2YziSZi?=
 =?us-ascii?Q?o1cJa0ruGi5X9AvFx4iSiaI+FDBl9NvDAPZTGFqUux9jQVufS6eMf6ecShhR?=
 =?us-ascii?Q?nmwKF0KoyOlqZa4y3KaF3moUNvTEhsemEWefO2G5QabBN7LSMH4ZaMsf1Ck0?=
 =?us-ascii?Q?WahqB/dBJRXaJrYKDv2HrvDBqBVtVid6/aN6GfgtpPqKrIdW+A7XDlO7OIPG?=
 =?us-ascii?Q?yaGqWuQTnpIYbRIhd8e0nrYEPtvHJ6Q2/YKaldBmrqy5jQOMVFAiMqtTxEQP?=
 =?us-ascii?Q?dmCqYc7+yYu0f0ozvUs3DNVyrCgjh4C3jj1xCqE2ERaJ6s/HjpSY64KYuQTF?=
 =?us-ascii?Q?RTdfzf1NRwPq9huW3Ru+X1lChi4ikVpTfVkoVA26FDpfs6C3imFuaB3KTeHa?=
 =?us-ascii?Q?f3EggMsObBeCaIeIG16sOVN3y4wJx+9JKBTABkoQuv7/nnIE2aeZJqzvew71?=
 =?us-ascii?Q?CNPqNGQZvUx+1VRsO06SiMIsLayYWafNnujkexeVTG/GdMSpQg8YOJWL0g2Q?=
 =?us-ascii?Q?GEhFWedAJ51W9LFvJ4BDSLy3hW9Zg5TS7mgfpJC02bmGaanV8+ZJ1Cb0XW9j?=
 =?us-ascii?Q?xGKbhsg1WTW+5D7COqQOKlj/LiZuU9129h0UmLkW+wpFZpruI8SLzTfmcW+i?=
 =?us-ascii?Q?zYJyzSWlDoRZgahGnNE+hl0bT0dEQLyB72YNSwlU3JAzUXURoWe7P7AM67x3?=
 =?us-ascii?Q?6cBuNsoSMfp0y4VfO82YidVXl0KIdvPtJZmoahsm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5cac86-9d86-48d8-ecf8-08db7ed050b8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:37.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1vvgthKqEeZs6i1OB4HYqX0QtiHok1kiLkE4bECteVE+Vz8ntTUhMIt5E73WjabcBuhxn8d4v+hPYwxT24aKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/sata_rcar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 43c55ac89daa..63f8337c2a98 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -861,7 +861,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
-	struct resource *mem;
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
@@ -887,8 +886,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 	host->private_data = priv;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, mem);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto err_pm_put;
-- 
2.39.0

