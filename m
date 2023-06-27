Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8AA73F54D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjF0HTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjF0HTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:19:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDC12130;
        Tue, 27 Jun 2023 00:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDOvUj9csUGXYGq/siKVCbDnsQaYjexXIlsq8+l8yoAudwwKsXjsZ56OgVSVqsVrFZ/ImkfiUftgWP4Mkgl2eMTQ+hLnEJfiMxmq5Imb+3vY0ygkoUwEyhKyvJ9dK5XlvNfNBJEe7aOADFxqufYBA5lCH/hm0VUaDpPXInuE4KbSCI0DKt1boOE8Ah7Ar6Rp0WWgfg69c4xE6gvSzscbGlaStY5FXtIHJ2Y1G+LpcEuj2NyW2CCCk3tPjl0D/A+pG3Yt+ERy4xp+xsKB5NkZJwyiQxouZtnB4F7t2qdeHBb2bkLZOJTIdwI6yGBeSqPFzmvBk8hCWSnG2b7ilsU6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SilFgsAMQbXdSQR30c4xs4aLOy8alWsnz6AffYE7ars=;
 b=Xth6uZ/qn8aTK/6iXyFxTHTvg4DOFGxrn6Ld0sSwU2Q+qyDG/9Lq5i/aRUCsGVZ9qw+DNozAjzwLR0DkoGgyuS+E6tVEUCx2UO7WS4ydAn0dfFbQF7Kcpyq/DkRFX7PUGxBzB1LT0PK+aihQ8p77f++JINdKIdmcNlZd9lx/ndZXndH9tpVjEKWYQm3Ne1qLkv3dl99gEv6v/sfJraQB/3YwYqWBOR5nwwnbcJZPRMCa4HAWfPqb9Ai1rmF/MZoUys6nX0IdKEBz757kcXqXjLOTCMy9KWq88wm5lhtq8tUuBNNtUpn51Et1hgMK592YQPwfSH9dfUmpHAQJu5R3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SilFgsAMQbXdSQR30c4xs4aLOy8alWsnz6AffYE7ars=;
 b=hdTv0pYOAfFO9EKU9kehyTAJ19cnOt9jUOo/WE/fhvL405+z9AqYODVl4nChR1bVDvRVM3m0ToT/Fj9pqaSXj9fl+om7JovDRyE6xmwyYJ/4qT94AP0UtGZVQndIVI1zDY9gXR5PCJUw1xQMtiaT8+tsaNnjYPVweH+ZRuB7vLJDbap91a7YB1ZjiPwr6gBbylmAXlREhnUphCWAGkeQk1g8dC2jYF5WAvRG8DxnloD9mt8/6kFqxM1erg1TNUvxOGShLVWhw/ymrjlVYTff7sIeZNZzmA353TP4hps5v1W9eqI0uF5UpBnd62bglJSfUVQL6U4CwguNOkRsRKLYhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4205.apcprd06.prod.outlook.com (2603:1096:400:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:19:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:19:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, frank.li@vivo.com,
        shangxiaojing@huawei.com, bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 07/15] thermal/drivers/qcom: remove redundant msg
Date:   Tue, 27 Jun 2023 15:16:58 +0800
Message-Id: <20230627071707.77659-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627071707.77659-1-frank.li@vivo.com>
References: <20230627071707.77659-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9ee0c7-c894-4e48-1a9f-08db76dec92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1v9RngV3a2KYo7Xj0vdyvuwxPpfRacfMIDsSKBgx731BvWrkosWiNpSVFqWzLdUnQCwIrHhYiBq+Be3W3s51p1mFQzTI8z6/Y92JsQ6dVst3Qrz/558zQhnMzvTuFI9l0elALT5KuHNuvGX4DoYW9ivSnauQa8wjfbMxS1C7e9Yso7vuXBeJP5ux5NcatWQvuCBwrbKpXTkVfC+J9Xboww0rfsul2rHEwPZf+RBe4gSZEMUUvSCDuCBhdgGUWngVpVMTUQsqq20zyj9c7zeM5l9g2VWXvzThBAaaRtNBC0UhzdZE3q0bfxFOoTwgnF4s7BtAkWYJGuDG9cZtaQij7O1msaJUW3nDIfUsvaVvZwxiUm/QWaLQdaudkyVLUSSFtgOTlyrQHeoDvALP/vW/6b6FAtVPX3fURX6CiA06VvLv1yJZ9N8aw3YHo8iS1Yzfs2Egs6qqXExmk7K6fohoe5Dk4ABldCbk2yjanO07ZUTQTQYOGpVNlzkwB7KVZalL3pnxl/lHCE0c2xPfNFD7dSRdkXQZIJQgFrGMbh0pBFT+1cVsJobOsuiqnJCTo0r4NyKU2Lb5zldLVIL2KV2jxeny4hTZSycr+0HIhhv+18p35jgRKFpPiZUwvncXlt3ZW+YejqfCVSMTo6OCkL3+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(451199021)(2906002)(2616005)(38350700002)(38100700002)(921005)(4744005)(83380400001)(86362001)(66476007)(6506007)(4326008)(316002)(1076003)(6512007)(66556008)(5660300002)(26005)(478600001)(66946007)(41300700001)(186003)(36756003)(52116002)(6486002)(6666004)(8936002)(8676002)(7406005)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?foFQkMXVLukeg7XChlUzsoYJzdky48QSPkzlcJE9Zf4JWXeBZB7Ypf5XaVe/?=
 =?us-ascii?Q?kCZ/MEOQghj7TN/J8xHjDBVVq+OwZnOql7uc7U5QkpmPDR1Yc6Pc/wknMwRI?=
 =?us-ascii?Q?sXhOp0u4p0YcJtfwQ8qU53pxUCEqVV2Jr2LW2tWJrQRmax0HGPSWA+58s0ZK?=
 =?us-ascii?Q?ZtlkyBSFxCBWbTJM9HiQ5XdsJn1TYK5/nOjwHFIDZx28lCTnJjJCZJO4gMSU?=
 =?us-ascii?Q?fAC5ICN7bcUjamVSIkBVayE4Bnp0o59ABoN69QIfBTndGbF49nJZpuqb3F8U?=
 =?us-ascii?Q?GhBmBSxRZUZyd04n8vlCp02Ur4QZC5MleOXwfu+xZ2cHJTSDdSKgJq5uFUcX?=
 =?us-ascii?Q?bNEKqBmQwIbyS1pwUtYIXMoQq0/2p3SrmuiJJlU/nbZftQMg0IsoKQ2ihyp0?=
 =?us-ascii?Q?orLi5KOX08eogeg8Szf1l+DCqIyQ+J8dUtDFda9JK7DuOzFsrsT5vmHW3uU5?=
 =?us-ascii?Q?zvPcqS0Ndt/gPASLGETO/PDjQR3mpoONu2ypPN2HCLVM3WPHMfIGFE2W/GLQ?=
 =?us-ascii?Q?FetUFHS1efYAJ4t+7fAult4zoK8NZtE968J7LMP6np9DDTI+7O4SIAuZfthv?=
 =?us-ascii?Q?016kNzgsD0Jie15wvXHmhnvhMByGECNtDXuNI1AxbA9mf0f0wvaevH4vROWa?=
 =?us-ascii?Q?+/9gds4Hv4SnRYanIl4nHE5tlAKnztDpJ/qSm8H3Z/HcwBJdscQEAmppCj8u?=
 =?us-ascii?Q?6zfr/+CvynAGfPFGBVrHzhHaS0AUPvEu3KYI6xmYjnJBoV9A/veJxXY1DvNo?=
 =?us-ascii?Q?MulQPiEq7uwQK6CJxy1vgf/kLcD0ttQxf1gXBuJX1LuM24oFmwPqLJzQrW8R?=
 =?us-ascii?Q?46UZUBRA9INkrvvhXOWaZJEetP5svfbZwlc4vjKUBF3Jd7/QcuRFeTZyN2sC?=
 =?us-ascii?Q?v0wfEhMZdGh7wuz/3BNx56ZYhLPYV/7UhkmrHHoP6mgoZ8+/w+bJ9aIFE+b2?=
 =?us-ascii?Q?MkUVSGyFFyIK0GLSfsu2HGWtwECfzrd6GFwbUwmLubxg3QBqO6kQ+M8lMCgb?=
 =?us-ascii?Q?k+DSIVKuD+e3WiJyyoi0K20lge9WSZnE13YqSxk32ejIoCrzEgEM5SH93oZN?=
 =?us-ascii?Q?1jh7cz5OoO+hG8hnMB7+lU2EVwYkC0MKeFtj74j4jmeNkukOkK/l5gzFBFgO?=
 =?us-ascii?Q?KpAL7tc5SyS9j/VwkqILOiqH7AjjOYXmsc5a8Y4pFJ2IQyiShDAOTovB4kW1?=
 =?us-ascii?Q?FXFvmXJXi2p/6GJLmiYBy7gR44emQcMb4x4/EuLHDf5qzf6VE51JQ/RhQLsC?=
 =?us-ascii?Q?dsDr2vBUj+4c6GoGE7t2tVAw2a931rEW72LujWxwWrjBeTQJB52DevtDPfHk?=
 =?us-ascii?Q?3/nVCry60dio0jt0vxAyBSjMtymHjQ6qFCry+p013FHT2AX0q2bQRivenrnj?=
 =?us-ascii?Q?MPkTccQRz0zptjWHu/1poo5QP7YYzKs1vOXBplUudcXxulZm6CsmYV8IJWDZ?=
 =?us-ascii?Q?8VmndHE7J4AQr38/vIMHe4IGRN5lG9sQQjobyaRpXws6nVRmL61QTULqvmeK?=
 =?us-ascii?Q?twNgNrb7Bb42EfsNTlKicf0ulknPzjj63fTO1Gw6NwYYXW6MVCq/ehm3UbnA?=
 =?us-ascii?Q?i46hPEhYg/cIQ8zTUT6Mr4Ykvvwvcu7jPqUeDJ6j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9ee0c7-c894-4e48-1a9f-08db76dec92e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:03.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8EBXvf+4Ogzj/UgufdztN/vNgGiiHOUfik56ItZW0qJiEVvdgSPsW4xvq1xow0cYcRByqECUJoCEO1mARDqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_request_threaded_irq() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/qcom/tsens.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..63a16d942b84 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1182,10 +1182,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 							dev_name(&pdev->dev),
 							priv);
 
-		if (ret)
-			dev_err(&pdev->dev, "%s: failed to get irq\n",
-				__func__);
-		else
+		if (!ret)
 			enable_irq_wake(irq);
 	}
 
-- 
2.39.0

