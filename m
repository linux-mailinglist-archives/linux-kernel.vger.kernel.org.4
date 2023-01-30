Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4546A68076D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjA3IbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjA3IbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:31:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C517CE1;
        Mon, 30 Jan 2023 00:31:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB8chxrKxNh9riR23od1OPX6bK/4QNPqBMTkeAsn86FphfFVwiOZBBYCO5ygwCZVDHd59qT+ba5DJDCK41e0WiDau4WXHMM5Asjh5nlbhxC2qYktBbB9a+zFzKzCjOXVSubkKkgNHY/F2vvZdVXmJ/JsdsW3orSYZzlJe5CBhkObt+bDaXSQfCAiioqBafOgK6zZ9mJa0FEtinuXfaTMYJZtNYfKyso8dOL5jPvhPyyxCi/S3k4zjqi3mQuc8YWoXXZ5lmh1DR2rHu8Bex3PUp6MroLBWEYZHyodup1TSux6626rnO1nn8mUuzSTYlV6n5D0LW1WtnX+0pFvOn4znA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GfLNabcNxx+HiwLwOum+SwtfXT4FlpjamLF3tJlPyw=;
 b=Ni+I6uBSUo1K6KJplMeOkFN/xUD6Sn6L14dWDGFEu664LYvTwpW6oYaUkr+DfZhifnVNE33jPrf9b9nH10l8eFLrrlFbntfzUszlZ/iWdVHse8RXPxcq6yDtzkDbE0n2N2dS4WMIsxifRZ72x5WEqy7UdWkssT6D/u8dxJnDp5djJMDrTfIS1sgM/ktMarHfMD7dsBTUquW1XCPQg7RFJR8YS7GWuTDEBe1bUuGSwqG/YIA0cNNOBaOOknZLbBhNTODP6fONZ/O3zXxy3pcUzOGB01hmD1SyNHB5ERyYGpfEVmj+EFU7zQKqi71/BtGjNrEmRnjuvxETiFH1PawaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=allwinnertech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GfLNabcNxx+HiwLwOum+SwtfXT4FlpjamLF3tJlPyw=;
 b=kxHnsDJJCcm4rqGSaipnmnp0eQ70ZQ/KNRjOaRdhyEOOt/RRp/T1z3Fu8wGlIC6sZYN1jWnXh6uGK9tpgkKe2xcg3lEhYYjRzS8CipYsGQmFm1r8BzfCbCOWpi8u1nOa9q3DVx7pDtLEm1ZXRpohZojwX44Iqc3/bWTJ3bZp/CQ=
Received: from DS7PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:3b8::35)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 08:31:09 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::f8) by DS7PR03CA0030.outlook.office365.com
 (2603:10b6:5:3b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33 via Frontend
 Transport; Mon, 30 Jan 2023 08:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 08:31:09 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 02:31:01 -0600
Message-ID: <eb63383d-89f4-064b-5dfd-e87ab09c0724@amd.com>
Date:   Mon, 30 Jan 2023 09:30:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mmc:mmc-cqhci:support interrupt coalescing
Content-Language: en-US
To:     Michael Wu <michael@allwinnertech.com>, <adrian.hunter@intel.com>,
        <riteshh@codeaurora.org>, <asutoshd@codeaurora.org>,
        <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
        <matthias.bgg@gmail.com>, <kdasu.kdev@gmail.com>,
        <alcooperx@gmail.com>, <f.fainelli@gmail.com>,
        <haibo.chen@nxp.com>, <shawnguo@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <michal.simek@xilinx.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <konrad.dybcio@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20230130064656.106793-1-michael@allwinnertech.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230130064656.106793-1-michael@allwinnertech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb37b3b-add3-41c0-5c72-08db029c56c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IihD/WVnke68PMjVAIZCaSAFL8ZBlFyAd9zhqY5ZRI7MYUHn3utWmT5Bjzt+xxsstBWL6pnsPCOkJMbyv8uMZbY0Gh+jrl5VFjgDTlRTvcIAR4Gx6scIbvbdpcoiurAHk/x4OnWikgpv063JZGmTczTbbpXkX+7J1H7mXTPwWHUZLzfWnY44t1+vAeS4jyYT0RWGyaj40C1Yt6t5GKLBxiY69o+u5DkBta6uy5WpVAdCpkAjw/8WT8EYNeADLKkjKDZnHo4DrgBbi6iYljQjR85P76kHh1VV83Kh7sl4y9J8OO1EQurOZkzAArFMRNkfulCwv8eM29Wnbd/I/d0rJ+2bVOALrbxbkdj23nOdrh/wrrxiSmoGdp24WJLl3c3AxVnQYmMJrnMkmM907M1w7q8yCgr2XlvCSiMvC6lQhfNucgeWJCIK6k4+1kyRTqtUMTPpa9XalwufuybXPILZKZfAQGdx+gkAHqejBeC7opbwU0Ydvc1RaKR9/0s+uPEeG+OjtBnC6MehRfTxo/AiPDR+/5/6UK38c+cEvNDY8atqt+JAZ4Q57hKQJdYElID2j+OcUuYz4vscvVap0f3tW1rTEsmVcXuyA9NsK5xXAO5vrA9lzMNR/KX55qz7aygDFZHgoaqWA5j9NXg6CYVMEd4AQiFy6/JSbaFRZvvqVX7veE6+OCyxb32SEO3JSbw67KfcRVk4qwoPFLGeCeTP37vm4Ic7pM3YxuzmyoQqwHoVtb1dSTsGrqMcy+WLDmEqOWIL9dfxYM74seQL/qlmKhbTB/Li32l//cRxIXywe0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(31686004)(82310400005)(81166007)(2906002)(6666004)(7416002)(478600001)(110136005)(54906003)(41300700001)(86362001)(31696002)(36756003)(921005)(356005)(2616005)(336012)(53546011)(47076005)(426003)(8676002)(4326008)(70206006)(70586007)(16576012)(316002)(40460700003)(44832011)(36860700001)(8936002)(5660300002)(40480700001)(82740400003)(26005)(16526019)(186003)(83380400001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 08:31:09.6073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb37b3b-add3-41c0-5c72-08db029c56c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If you look at commits on drivers/mmc/host/cqhci-core.c you will see that 
subject style is
mmc: cqhci:<space>

Also some tools are checking this style. Please fix it.



On 1/30/23 07:46, Michael Wu wrote:
> 
> Support interrupt coalescing to reduce the frequency of mmc interrupts

Missing dot at the end of sentence. I expect that you are doing it for a reason.
I would guess that it increase performance but without any details.
Should I enable it to get for example 20% better performance?

Commit message should be IMHO much bigger with more details and some information 
about how coaleascing works would be also worth.

> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>   drivers/mmc/host/cqhci-core.c      | 20 +++++++++++++++-----
>   drivers/mmc/host/cqhci.h           |  5 ++++-
>   drivers/mmc/host/mtk-sd.c          |  2 +-
>   drivers/mmc/host/sdhci-brcmstb.c   |  2 +-
>   drivers/mmc/host/sdhci-esdhc-imx.c |  2 +-
>   drivers/mmc/host/sdhci-msm.c       |  2 +-
>   drivers/mmc/host/sdhci-of-arasan.c |  2 +-
>   drivers/mmc/host/sdhci-pci-core.c  |  2 +-
>   drivers/mmc/host/sdhci-pci-gli.c   |  2 +-
>   drivers/mmc/host/sdhci-tegra.c     |  2 +-
>   drivers/mmc/host/sdhci_am654.c     |  2 +-
>   11 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index b3d7d6d8d654..f9cdf9f04bfc 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -420,7 +420,7 @@ static void cqhci_disable(struct mmc_host *mmc)
>   }
> 
>   static void cqhci_prep_task_desc(struct mmc_request *mrq,
> -                                struct cqhci_host *cq_host, int tag)
> +                                struct cqhci_host *cq_host, int tag, int intr)
>   {
>          __le64 *task_desc = (__le64 __force *)get_desc(cq_host, tag);
>          u32 req_flags = mrq->data->flags;
> @@ -428,7 +428,7 @@ static void cqhci_prep_task_desc(struct mmc_request *mrq,
> 
>          desc0 = CQHCI_VALID(1) |
>                  CQHCI_END(1) |
> -               CQHCI_INT(1) |
> +               CQHCI_INT(intr) |
>                  CQHCI_ACT(0x5) |
>                  CQHCI_FORCED_PROG(!!(req_flags & MMC_DATA_FORCED_PRG)) |
>                  CQHCI_DATA_TAG(!!(req_flags & MMC_DATA_DAT_TAG)) |
> @@ -621,7 +621,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>          }
> 
>          if (mrq->data) {
> -               cqhci_prep_task_desc(mrq, cq_host, tag);
> +               cqhci_prep_task_desc(mrq, cq_host, tag, (cq_host->intr_clsc ? 0 : 1));
> 
>                  err = cqhci_prep_tran_desc(mrq, cq_host, tag);
>                  if (err) {
> @@ -812,7 +812,7 @@ static void cqhci_finish_mrq(struct mmc_host *mmc, unsigned int tag)
>   irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>                        int data_error)
>   {
> -       u32 status;
> +       u32 status, rval;
>          unsigned long tag = 0, comp_status;
>          struct cqhci_host *cq_host = mmc->cqe_private;
> 
> @@ -856,6 +856,15 @@ irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>                  spin_unlock(&cq_host->lock);
>          }
> 
> +       if (cq_host->intr_clsc) {
> +               rval = cqhci_readl(cq_host, CQHCI_IC);
> +               rval |= CQHCI_IC_RESET;
> +               cqhci_writel(cq_host, rval, CQHCI_IC);
> +               rval = cqhci_readl(cq_host, CQHCI_IC);
> +               rval &= (~CQHCI_IC_RESET);
> +               cqhci_writel(cq_host, rval, CQHCI_IC);
> +       }
> +
>          if (status & CQHCI_IS_TCL)
>                  wake_up(&cq_host->wait_queue);
> 
> @@ -1172,11 +1181,12 @@ static unsigned int cqhci_ver_minor(struct cqhci_host *cq_host)
>   }
> 
>   int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
> -             bool dma64)
> +             bool dma64, bool intr_clsc)
>   {
>          int err;
> 
>          cq_host->dma64 = dma64;
> +       cq_host->intr_clsc = intr_clsc;
>          cq_host->mmc = mmc;
>          cq_host->mmc->cqe_private = cq_host;
> 
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ba9387ed90eb..acf90773c30a 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -227,6 +227,9 @@ struct cqhci_host {
> 
>          /* 64 bit DMA */
>          bool dma64;
> +
> +       /* interrupt coalescing*/

missing space.

> +       bool intr_clsc;
>          int num_slots;
>          int qcnt;
> 
> @@ -312,7 +315,7 @@ struct platform_device;
> 
>   irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>                        int data_error);
> -int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
> +int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64, bool intr_clsc);
>   struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
>   int cqhci_deactivate(struct mmc_host *mmc);
>   static inline int cqhci_suspend(struct mmc_host *mmc)
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index edade0e54a0c..2c18f954d4b8 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2796,7 +2796,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                  host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
>                  host->cq_host->mmio = host->base + 0x800;
>                  host->cq_host->ops = &msdc_cmdq_ops;
> -               ret = cqhci_init(host->cq_host, mmc, true);
> +               ret = cqhci_init(host->cq_host, mmc, true, false);
>                  if (ret)
>                          goto host_free;
>                  mmc->max_segs = 128;
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index f2cf3d70db79..4aeaeddbbf25 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -231,7 +231,7 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
>                  cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
>          }
> 
> -       ret = cqhci_init(cq_host, host->mmc, dma64);
> +       ret = cqhci_init(cq_host, host->mmc, dma64, false);
>          if (ret)
>                  goto cleanup;
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 9e73c34b6401..7aef7abe71f1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1712,7 +1712,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                  cq_host->mmio = host->ioaddr + ESDHC_CQHCI_ADDR_OFFSET;
>                  cq_host->ops = &esdhc_cqhci_ops;
> 
> -               err = cqhci_init(cq_host, host->mmc, false);
> +               err = cqhci_init(cq_host, host->mmc, false, false);
>                  if (err)
>                          goto disable_ahb_clk;
>          }
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4ac8651d0b29..b6549d1e43ec 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2153,7 +2153,7 @@ static int sdhci_msm_cqe_add_host(struct sdhci_host *host,
>          if (ret)
>                  goto cleanup;
> 
> -       ret = cqhci_init(cq_host, host->mmc, dma64);
> +       ret = cqhci_init(cq_host, host->mmc, dma64, false);
>          if (ret) {
>                  dev_err(&pdev->dev, "%s: CQE init: failed (%d)\n",
>                                  mmc_hostname(host->mmc), ret);
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 89c431a34c43..811f8686532d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1610,7 +1610,7 @@ static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>          if (dma64)
>                  cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> 
> -       ret = cqhci_init(cq_host, host->mmc, dma64);
> +       ret = cqhci_init(cq_host, host->mmc, dma64, false);
>          if (ret)
>                  goto cleanup;
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index c359f867df0a..6f6cae6355a7 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -964,7 +964,7 @@ static int glk_emmc_add_host(struct sdhci_pci_slot *slot)
>          if (dma64)
>                  cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> 
> -       ret = cqhci_init(cq_host, host->mmc, dma64);
> +       ret = cqhci_init(cq_host, host->mmc, dma64, false);
>          if (ret)
>                  goto cleanup;
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 633a8ee8f8c5..6917ba339aa9 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -908,7 +908,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
>          if (dma64)
>                  cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> 
> -       ret = cqhci_init(cq_host, host->mmc, dma64);
> +       ret = cqhci_init(cq_host, host->mmc, dma64, false);
>          if (ret)
>                  goto cleanup;
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index bff084f178c9..f98a468e8f43 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1620,7 +1620,7 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
>          if (dma64)
>                  cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> 
> -       ret = cqhci_init(cq_host, host->mmc, dma64);
> +       ret = cqhci_init(cq_host, host->mmc, dma64, false);
>          if (ret)
>                  goto cleanup;
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 7ef828942df3..8e7fbee70e16 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -568,7 +568,7 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
> 
>          host->mmc->caps2 |= MMC_CAP2_CQE;
> 
> -       return cqhci_init(cq_host, host->mmc, 1);
> +       return cqhci_init(cq_host, host->mmc, 1, false);
>   }
> 
>   static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
> --
> 2.29.0
> 

M
