Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8F7369AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjFTKoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjFTKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:44:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2051.outbound.protection.outlook.com [40.92.99.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB610DC;
        Tue, 20 Jun 2023 03:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1aBqqpPjM7kVIzQ26/nIcbCBYzWMKKo2Jczpu4w+P37vgnxDJpVwzdd618BRikZQshmme5uuAJax1ysZAbWMBWq0y+LIWyinFe2SJx2sj5zxm0I85kqe90A+UIo0WKrAAR+7tOfHu1prVA4PwwRInw2fqBT8yF/0uHmI6kjhHqATby2X4Bovba5zLYGQg+snbbLTzU3aHFmtotJxZkhWqbHSpAWjiXAPelHOlruA3ISNQdaMuVaWew0IOBOsegLWYdANv2ojQPcwMUqD+bTVyZtUrVoYWi5ZK2M+7nQhz0X+OGvV1T5ieeeIYwFJpLCUaVr3KHMBno/hcIDeNAbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmp+l10mEGmUqx++0/Ab8xfA5655iXnQb5xbTLxbufQ=;
 b=Km+XI1OCDiE1ukyhCLjibWzecwHRWiwfZ+x66ORMq26RlyWir+VmV6b6CxnoxEICsTZRW8LSIISU0LXBTcmZbPNUocAvYGNi7A7uabpdkpzm81ukBSubdjlzGgJhlgzjcJ7SDjXNrWVoF5BBBQyKvfmWJyP8z43am+ksE3IK+5iGCYwr/hWlA4vNEwSQBD+946C+n7pbpH+IGUsibKklU3enejwmodQeMa76j9wdhtwTYWbKz3yUEnSXUWaltb5ccN9fmFV6QCDCT487RguiQMsJM8bb8fe1oiGJpe2sV2rBLrFBPuqI+NgQdG8PWpQI85HW5FcwLpE1y2RP9d0UNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmp+l10mEGmUqx++0/Ab8xfA5655iXnQb5xbTLxbufQ=;
 b=CgqOD5IqbqZcBKmViQoSpEx8VHw5lnAaYDpfst1Bou6qK+IDIGeZk1CcEQVy8opNjI8pu+rXSBFib4I6CIyzUO8+xEGtB5HZHiNxtxDsIlh/rWC/grqQvrxgS9zP4PgjHTxGbcUE/SYU6X2Ch3Eaot417nTV2NdWQmhhxoj8NwvOF7ZAEqYOFTMt2EWhRHnMgIFpg91wM+JdNxZQNM/PbzRqmyRb5k+kBR994VdXz0DMEPqbFWkpV+tW8Q93o73kqPxZ6vV8CQfWDGirpc28qBn/Lw/2W43m9wsaTCsJsWJuq+hizVgzNWoTA/zs8YG6coRRO01Jug1z24TAGx0gSA==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1546.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 10:44:07 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 10:44:07 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 2/2] mips: pci-mt7620: use dev_info() to log PCIe device detection result
Date:   Tue, 20 Jun 2023 18:43:23 +0800
Message-ID: <TYAP286MB0315EB69175E8B6189B69FB6BC5CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230620104323.1736-1-yangshiji66@outlook.com>
References: <20230620104323.1736-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [LUH//fxmpTtOP915Azf5tt70V5/q6Tkw]
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230620104323.1736-3-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1546:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d62fda8-dc5f-48c4-22a8-08db717b4620
X-MS-Exchange-SLBlob-MailProps: 02NmSoc12DcenbC5w/UaZkbuHE2qqzIU+ycbbO/upcpuaqeE7dpFuOkQKVFEGrfsGUcB61uBAMA6itXtHIqwj9/hGnCQJPqB1W2VCQWWTp1SgNcsH8ZleOG3UI+PAfM7Cmh8Fi26nuOpkrmz4f/Dbmei6Q9jvt9DTnb4lx39ftLHKvi/T6j8RbhVUQ9phAui6GpHovmoo4u/jJiOqYxsC86w392nKG/BSctXV+ijzMDCfRR5vFA4zXvm7wMLdghCxUYeDO40kShrcqZ9k0FgzaubZmQNoVKeazs1GkSNaTj6KPebzDreFHTbrghPH543KZAYi8Up0C/IIijE3vEBO1ValXQyHSVJG/5S/d/3QsjXsl1INMzFadIXWfbnIQiH4iwaSIPrgGVhV7ZSH8c0zgq5JnTMlOQBT9SV9wToNkpriNzs4ablfc7AQ9ZIexSV6MmNfeP/05iitrS3wNVIMqrVjJGG72hmHuRCGavI9QkKCAKn4dQM4IrzNQu23xsB967/Vkghd1BfZKKRvIKyj+jhOmZBWtmLr62cOP5DGjG3Y+YKYrMfuqEhbHUKpRgd5ZGvMwyhbrcWfcC5N1QJuqTuc5APfCKq7lCA1KsyOTWNAdDRigB2QR2A08kcpZnELQ4gkj1pzoDGcRpG44I/9LrQKfh3k0fva81rdej4Rr2siu6A0ckjJkCdz2LisV0TgjN3xxehvw/17dR2uyZNH/XkWIMLfXG2raaQAaNezUCppXKrC8VeY9mHoNQgGn/m
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzy0SxVyE1fzdTIIUGPPsD6ZcoR14p4y6flHxUM4q6WmH+sYatw/V4XNcGeHY95AOld4sf6YDXPpSPnKFpSDqHhCpNl5RUxeD+8m/AlhAAPhwiiuVgXQCrVa9vo7qyJZHutqAnurGdfrVtrL2SB6WnATmfKVyCfX8VNsBHB5AxBe8mmL8WvSdWJTLM3MQhphJrhJuSCD5zet9OYUIfvZInPvV7kAjDD/pGSa2qEPfJ9xYbehtggV2Dft20ChoOhN8ZUTpGNUkBioOM6Bms+YRjJH5TzrPBporY8g0q/sY+RSh30CSnJXzSMMi/Gf9e5wmkfTIT/ghJ5soOgcPpgkaBERAARgGKTSV1eaYiuaqXlN1BkaDDnbML8K3cOcQTpxpyWHtVM86hZOmde10IaXL5W48eKMoC7CGKPVZDJfzyWW57J9aQs7uYAxjrdIbLoqDQr7kL5Os4kdKVMIC2cRk/rqUZTFnn2xXABEWy5Qv7uloHnCMcM7wg2vE8LKWDWX3EUjcyruqPAvKqwVAco050hgDLQBL1BzCPTv72zlJ3VUMAdNXVeKybYkZ9mzvp1vh/xUmmrzBl+cgdYn0RMJ7hvI2feVXtEVtlBOsB/iKgjI/kyEJka/04aDGxBEIlQ4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?379+7t53UjQW46HXv+Ai6ln1z+c5WUYTiklJCONhkTgbbbTQq7pJgb+voi1b?=
 =?us-ascii?Q?y1RIRkiiiEge7DTeU527OMj/+uqDT7ZBTzdqgSfs1JLLlv4ALsCdiQd8uWmN?=
 =?us-ascii?Q?xSLBSI1DsBkTQUEs+zibkOlphU71IAnlTrvw4urEfAGEZlXj5putWCs60FZu?=
 =?us-ascii?Q?dneb2zwzNFfw6gPfMv67xOEraD5kHb42P5H0GQS1fP/B8TyAfRsCYngrpw/8?=
 =?us-ascii?Q?0ZCsecJ1iUmCvS+PWPREl2cH9Gzr3C5WdNWXcm1FwXjHtUpOwSpyDo2L0RDh?=
 =?us-ascii?Q?40o3BlSVsrwLtj09CRN8XxrqqmbJxVwTMzZ6rj+D10A1GWc+DlGcGkBaCpts?=
 =?us-ascii?Q?rJqmmFf4w+26LgVn/6fJ2UTVnGCOwucVcWxiR7iPftoh7x8GGxbjZWRX0uTH?=
 =?us-ascii?Q?Ubm/CfFe1HoTUIB6JGWBVlIybY4f83KG4cgRoRYFy2x9Qqd5qbjYtIT2qFZ7?=
 =?us-ascii?Q?8gYJJGEy+linVb9MuGMHdo0H4KvC1sDwnd9hKR7iYVDAc2lki0gB3A7/XgV4?=
 =?us-ascii?Q?QG7Hs6NovTBn/Nle6PE55xcqihUidV9ouJi/wPLdS4St9lKKvMgjSw39s9Zb?=
 =?us-ascii?Q?mVggRUKZtdEuW1KScHLS2veU9rGpf4aY1Qbn5V4I8sNTATV7Mln0x2Uud40J?=
 =?us-ascii?Q?NsrOVJQoAI8KKwgI48VLetgWTfMU2+El7R7Dc79KrqRwDWd8+0WsrAVaO8cJ?=
 =?us-ascii?Q?BXqeWofpWmkqpO1uiYyzE5BSxd4V+TO3iBydvHiRMoe1UnlrtEzgIeVkXiAH?=
 =?us-ascii?Q?pwgk84RpvwJpNmT1dmQ0jHVtIKZWnjbFV8pmjlYeYJva8AT9xbJ8oG9wKgyH?=
 =?us-ascii?Q?Y2WfqQJGmiNDpi/pUBX8GKOp7rBmqPAhz+5i/QoUCUmGv30B2l68xKS9n59n?=
 =?us-ascii?Q?0nGqAmWQ/fgcLyU9yqKB+0wmY/oQAWovrJOUv4NfMYKICjsFQlDgk/YVVOSd?=
 =?us-ascii?Q?YoysSzOZ9jhNfaCidaF8ftjFAaY2uQVWxpmYueyWclFhO/uu6dNx8iJh8oPs?=
 =?us-ascii?Q?+g6f8VK/gwmu/on2gyRqnag2udLvmtZ/KkLQgW4oLkjL7EQgNiWOhoFIzd+9?=
 =?us-ascii?Q?ld0snWL89lMgESfGeH4MGIIbUqFdMVasBPkJBZuOjZWq6c2QxC1QCAKMYX7C?=
 =?us-ascii?Q?m5Aw/5ikLYm0Hm/v0hSCTL1n+AF4FV1kWzG4cYHgvLqrGWsE7jkQ+VYLsdvE?=
 =?us-ascii?Q?lVoArXXfYVX8O11UAWQA6/bjL9/LSjyHDcQrnDdc2I+HjChmgGH1HG9TZ54?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d62fda8-dc5f-48c4-22a8-08db717b4620
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:44:07.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, We only need to print the error log when there is a PCIe card but
initialization fails. Whether the driver finds the PCIe card or not is the
expected behavior. So it's better to log these information with dev_info().

Tested on MT7628AN router Motorola MWR03.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/pci/pci-mt7620.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index df3347643..5c4bdf691 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -327,7 +327,7 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 		rt_sysc_m32(RALINK_PCIE0_CLK_EN, 0, RALINK_CLKCFG1);
 		if (ralink_soc == MT762X_SOC_MT7620A)
 			rt_sysc_m32(LC_CKDRVPD, PDRV_SW_SET, PPLL_DRV);
-		dev_err(&pdev->dev, "PCIE0 no card, disable it(RST&CLK)\n");
+		dev_info(&pdev->dev, "PCIE0 no card, disable it(RST&CLK)\n");
 		return -1;
 	}
 
@@ -370,7 +370,7 @@ int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 			dev->bus->number, slot);
 		return 0;
 	}
-	dev_err(&dev->dev, "card - bus=0x%x, slot = 0x%x irq=%d\n",
+	dev_info(&dev->dev, "card - bus=0x%x, slot = 0x%x irq=%d\n",
 		dev->bus->number, slot, irq);
 
 	/* configure the cache line size to 0x14 */
-- 
2.30.2

