Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E9749642
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjGFHVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjGFHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:21:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA94DA;
        Thu,  6 Jul 2023 00:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je9YUIZ0/g8Q+a//gGHbAnnSmYP/uG8rLBHrS1sELCVELDuRRxcTcaDajQ4bXh2TgosP1Drna1pNT4QnRqnCUHqCFOnL23vYOhwEZdR4Qj2sFWwKQF3teZ2xC0bhipeEWEjJ4mwqU7/NPCPFFb40au85gp5ozqez5EIf4RlQrWPvm4qhWmKgTJsAP+Q/N1Vz+ZbVj+lCc2QLgwjNSv2Yt+t16i6rzOBjnfSzbZ3erG+qXIt0aKl5yxFqZAF78vufUFskC10KrU/vYAPwyGylrSLP9mv12K9G53PDVGC39VGKn7eLILpjJgjX8k1UPFE9CRhdY2LvJffk1NCR3GC0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3g3RwmgsSxadIrRmjCFZfjIaT8MX/+tAHqmEKpFboA=;
 b=J0rRqFS9ywyquOWktmDZHZquOGiugV/hU4YLJKR8+xNzNhDV1szwTEUl8x0ldJrr8/TCY2fW+Fk+PKD0lJ6xPUH3l9lopku4DlC2QLyBPqlpM0QkQmsrRIoKnVbMtd72nEXQK2kT6KIWPa7sHeOGHvHP/OxLHOI20wLlEc8TSJuevFoQavLJBxQZDRcwAjzweUfGDZTgZG3/k1x5+fsheqilMLlxZT/VtSSocJNNtsQd9uA/4+QHwbt3+m7REYa+IIABj1EcPOvdICNKT0pNWLw0YWb3gwkQB2UwxD7zC+lVRrTFatUhFM61GinhReF+iFPP+Epa5+HLaPkXrp9dVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3g3RwmgsSxadIrRmjCFZfjIaT8MX/+tAHqmEKpFboA=;
 b=nyMm/XM24ZTGzLeoSZZPrx1QtjqY6hF5wM5mA3/NQBAlwtb8G0JYEPWmqmC+2LNFTiucUfTRzKNmfNYepVcF00CISF1RvKhoIyA9FpHXIKnE5DziXR0itUwd06h1ixmR78hgK6QNg5TGaru/qtM+Zs9vg2uMAUZ9fhYSmp6x/2M3ga5vuKsE6j8LMBzLGS9PoLIHKEDVTrR04rfXSYlpag0rudk3NghhLbIObm2u+D7FMAwAfGMXuevIsE3vggCx3YsmZzo5w1VBTReKgQEBqEvjwzif19/iWZKRpTJOY+QTlqzBNMiD8OyjGKIdISyQkmFN8XoGngCDt/LYWDGVEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:20:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:20:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] bus: qcom-ebi2: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 15:20:39 +0800
Message-Id: <20230706072042.31296-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: ade49132-6427-437b-2b53-08db7df18bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttIAotpyeeHZzp8RqmNYITMY2jdGwlmHwlxpjdYiboxGC8Q87q96xBVVtgHZm+ImJ2It4HICOjmFhZzDNmbw476/s1sGWInFg28Me2aFVsTXPYlLfpeXRqI6xC9a59kObQN9DsdNXjcmdRwGgsWvhu1yqCXYDBPqSFNxtuSjGnYYr9VTsTTfzuC/ITSVEvTLbOxWt1Hmuj5CzGodltPDkrbT3QwBoQpMiRYULXrUnKbJZ8LuuMoCCXG3ZCo+sDjA6BHXMFyOzZiwbp61dFLDGxYZpsmbaedVGNvo8YY4EZbQs/vRcU1NsA4U1QvhZdRJ73MnGm8CVoGmZXyl6Sk9l/jrJ7zxuSTFKR/L/IqUmYkJoUSKu16GLqwKqZ+8W6NUFtuxyhG7XIWv06n0oNnNmL8C342G0mMYgyR0mbDnnoSRyPTscXLMAxwAIq6H3r4Mg3lwwTdJN1lKu8i42f3UAftWTBnpWl9v+ZQHScawwIwfam6RPzr7+lipYWuEFEFYHw04ZjKSHpUl6TnFFcbJZ0YB1qvLIWBRdelMT67JWPsu3AAgkewAPc7vsGy0IvY6EDy+Nkqcxd4Uv5yh0UeJ+jMVE+I4qFAlaMv5Gt2MdEX+2xmCu6QxmGZ5wlXPd+jh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(38100700002)(478600001)(66476007)(66946007)(110136005)(52116002)(6486002)(2616005)(6666004)(66556008)(41300700001)(8676002)(8936002)(38350700002)(316002)(4326008)(186003)(83380400001)(6512007)(6506007)(1076003)(26005)(86362001)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AaXW4+ZYaIdAgtqQAtg52gNTRbdG8SHii+PYOG/5FAlAmXOiEd2NOeKfuXr2?=
 =?us-ascii?Q?E7HOb9DTjdbT0sDoV6plnYYUYZ7vOy/Cgkqa11R2ZjkRHTZMuuWqhshUzH5+?=
 =?us-ascii?Q?eRMNNpcEmUzGnGv+GlGYEEiuZ8OvMuNoL0LzdJW8t+xUoi5YLdyIj6L1Tykt?=
 =?us-ascii?Q?59zo+ZZwJmBYQ5c3Vz/rqaZB+AIZOnkSHESuJswzk6CZoldxioYjSb1ITiTj?=
 =?us-ascii?Q?GLk3AiWhXLqrEnY/P8zH7uzhFqT5Le5NRfOVw+UIgxzB+jnIDZpZ6FVj7PO/?=
 =?us-ascii?Q?CitV8emC1b/6GPgfQMU1Kplff/Mpaxr8vWh3Cqaw/BSEMWyvcg2alSehiEgt?=
 =?us-ascii?Q?sBy0L2ccXCu3BBWtRXS4dIhAKI3kNe3vknegr0ID5HqLX4tef6gA7AphHxSY?=
 =?us-ascii?Q?EKM+axWshFMJCoE/2jJJs+nLndEHpPrudiEz29Lh0wzduz+de7EOTx5XKf/Q?=
 =?us-ascii?Q?QNjDh6kInQbTsOAUd7mQsSSGvlA9ra544ewx0MO1bx3xgX8RzlXGCpWkRS4M?=
 =?us-ascii?Q?bb5C1GixBnhTXAAaX+M3S0kxxThmbsygXYc52lGb5LEKZtK3cSgzOfy68m+s?=
 =?us-ascii?Q?d7p3lJbq2fgKR8gzoPSkJdHYCx9cmfVU/YaJJ39FgUyADHxDtiS1jWSxyl9q?=
 =?us-ascii?Q?HVRK+jP5Bt2QqjlFP4daU4/MZTaPzy6r+Hs9oHqOKT7lafGAf+qzYIH56u1z?=
 =?us-ascii?Q?zYnfSFs3I+Njk9CxGoi01Kj0tFyEYzK0YfFs5/gYQ103n7ecBL0Ecpsn62J3?=
 =?us-ascii?Q?eKtwh1kB5BqOx1dwFAbygVlJYQBhY+1Y7lHS22vjIsEjVXsICrnUgKewS3Yd?=
 =?us-ascii?Q?m3ISL7iZRHBkBfakbh/o/NJmeW8KkhiRgbvXsiX1ERP1sE+hu+dx6Y4ATY0V?=
 =?us-ascii?Q?xaC8V/kZPeo+4ZqlsDruSUeMx7n2t/4FW/pduhRAzdsKLQKNCCZVNAJmN7H8?=
 =?us-ascii?Q?PZ20kNRt6+Irsv+o0rK19F53S8xwU5sdBjCw2+5Y5MTG1axl5NGDg/J3M0Dq?=
 =?us-ascii?Q?pzh2/xWlBEmoeTAug6H2W3x1II2k14rezJQHJPoTfeOruipinC+ICzWdOzO+?=
 =?us-ascii?Q?SLN9x1+jlX4CcSirykYKk9fgbBReETg4Ye7G/6v0Rz7UqDqcm/jTCJxhIvkB?=
 =?us-ascii?Q?fDZUsrjGwLsBYCM4ADq19LiNjdb96UEysgigS66EOE16afvFovjFCuKTcJe6?=
 =?us-ascii?Q?2w5gZWHWDQ5DzZENXRV500I7nnbTGpymm+yoNA+UAcHCqDxPfhnqGvuuwGC2?=
 =?us-ascii?Q?83b8G5pO9G4WSNqOTVhbXIW16UFzOu7BG1913owM/ZtZPD8vliQMazHY/VnR?=
 =?us-ascii?Q?wor4aEp6mPV/Fm88YgvUuppYTdepjxYWJ/pLU/FEtcJQTz/jxiixZurJvIkT?=
 =?us-ascii?Q?WKI+yAkOojExCOnbFlcB9M32jFANDBN2Zq6gT6wgJeSgCvHmRUDJGXzs9X+G?=
 =?us-ascii?Q?JKQMo086q7t8s1bKV6nBqcPI66FnzaeDNym5smGvcbMElYZO3oh6O27l4LjP?=
 =?us-ascii?Q?aVKQD6FdtblY5z2Ob7AxO1tPlXSbcFqrpNPEqHqnJqV7T6zeXAcn8R1G0OsX?=
 =?us-ascii?Q?19FvccZ/RszoWQ1zKkvOuAlzc7J7Gkye777pTY17?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade49132-6427-437b-2b53-08db7df18bde
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:20:59.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUaJkMPIe/RSXbMzCIqVgmmD6nuf2rZPH0DakTv1RXPIvDXpwZxss0hvjAGZf6SQF+2xKfUBsKu++BPvs3PLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/bus/qcom-ebi2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
index c1fef1b4bd89..01e76bb05218 100644
--- a/drivers/bus/qcom-ebi2.c
+++ b/drivers/bus/qcom-ebi2.c
@@ -294,7 +294,6 @@ static int qcom_ebi2_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *child;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	void __iomem *ebi2_base;
 	void __iomem *ebi2_xmem;
 	struct clk *ebi2xclk;
@@ -325,15 +324,13 @@ static int qcom_ebi2_probe(struct platform_device *pdev)
 		goto err_disable_2x_clk;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ebi2_base = devm_ioremap_resource(dev, res);
+	ebi2_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ebi2_base)) {
 		ret = PTR_ERR(ebi2_base);
 		goto err_disable_clk;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ebi2_xmem = devm_ioremap_resource(dev, res);
+	ebi2_xmem = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ebi2_xmem)) {
 		ret = PTR_ERR(ebi2_xmem);
 		goto err_disable_clk;
-- 
2.39.0

