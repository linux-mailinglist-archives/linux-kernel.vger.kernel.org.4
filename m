Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB265D4B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjADNuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjADNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:50:37 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3319C15;
        Wed,  4 Jan 2023 05:50:35 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 31F60320090D;
        Wed,  4 Jan 2023 08:50:34 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 04 Jan 2023 08:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672840233; x=1672926633; bh=Qt
        g0MOHgi6seiuHK1iiy3zhwcnkqZAht7543FYU1Zhg=; b=rRBeZNT6lHBhV/Mk04
        o1ubEL1+r4dtrFspiC0fS4jgPl3pVolvEOGrCQS2AmOwjqpYEA3iNvKGyxeeLupr
        429YYOYGTXS8oh9VUH6DoJQSuRABbJnsJHJ4aqdG3fWFuh4VW+eh2vS87XGVQ2bZ
        Hpaaf5PxKRPuqAQ9pYDm3AjJIflc6nMGp3IJg4ngh1hk8TzlcDXiekD/SlDjbMjY
        oPy+GA2TBqt4vKil9TAd1rxP+UyK+aTBorr8pIlnCZkDRAL5hAuL8hT1DcEeFolJ
        iD1+UqThFnXrWaqbLPuxGFpX59wRDSZPwRo0SwtoHC9VisMISFFxvAKzqcAWagGE
        e+vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672840233; x=1672926633; bh=Qtg0MOHgi6seiuHK1iiy3zhwcnkq
        ZAht7543FYU1Zhg=; b=U3Q7/qamlPcHNMEien4RW5OP2k8iASjzwdWenqRAyl1L
        /BHTlQHQwId2jWivWMxbH9+O9d/qcpMjsGstr9wAdbDRk6Yacd7Eotf9rfQjvEe0
        MXD+bVZISOZQW2ghtcm0f6HfMsHpNDmMnBzJnwwiw084IVMwS63tKHqd/a9Czuuq
        OyDsg9mBjQ1IXXO0vuZO3Z8KgbngHqwlIPLXfqVo3MktZFThYcrKlbGov3C6VDsy
        9FLYhwpBNn1eDLYjZuIteeNPkR7do9Qkqqy+tKcYHuW7bu6HEZOgofweuPjonxxK
        Qbsr5TJVgFH6oRDNceJ8/p2VKYbWx3Xtr9D659Hh0A==
X-ME-Sender: <xms:KYS1Yz1DGeXrKCfmfqpyQdH3bJdMhRmRNh-9UModOWEF0LhKEPcsdQ>
    <xme:KYS1YyGLXGh2-1ctpmtvF5RU2wxz6Zrv92Rnx7FC4tcsohyKXq4Sv6lR3yidR4wIn
    UBRxr87xPTPOsZc170>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:KYS1Yz47M2ylRWv33VUIv-jM5LrUvWrSwig2k5Bgcd7IPBezlyNrRQ>
    <xmx:KYS1Y41ZFb_RqDmxhwjlGrhYve6Op_1bskc9Ph5cG0Q6FDirSs3PWA>
    <xmx:KYS1Y2GTy5qA9Bp5bpRt1YCDeoKf41Y_x2mLnIeyah1YvbooVFC4HQ>
    <xmx:KYS1Y--_MZ0uPwfjmPUDY3L0BRrQbbFgn0as0c7Nw4FU8htB8fSTQA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D882A60082; Wed,  4 Jan 2023 08:50:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <bebc741d-bcbe-4449-9379-be70fd65b0f0@app.fastmail.com>
In-Reply-To: <20230104110013.24738-8-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-8-marcan@marcan.st>
Date:   Wed, 04 Jan 2023 14:50:07 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Janne Grunau" <j@jannau.net>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu: dart: Add t8110 DART support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023, at 12:00, Hector Martin wrote:
> Now that we have the driver properly parameterized, we can add support
> for T8110 DARTs. These DARTs drop the multiple TTBRs (which only make
> sense with legacy 4K page platforms) and instead add support for new
> features and more stream IDs. The register layout is different, but the
> pagetable format is the same as T6000.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---

One minor nit below, otherwise

Reviewed-by: Sven Peter <sven@svenpeter.dev>


>  drivers/iommu/apple-dart.c | 206 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 201 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 396da83f2f9e..e9cbdb45448c 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -85,6 +85,62 @@
>  #define DART_T8020_TTBR_ADDR_OFF 0
>  #define DART_T8020_TTBR_SHIFT 12
> 
> +/* T8110 registers */
> +
> +#define DART_T8110_PARAMS3 0x08
> +#define DART_T8110_PARAMS3_PA_WIDTH GENMASK(29, 24)
> +#define DART_T8110_PARAMS3_VA_WIDTH GENMASK(21, 16)
> +#define DART_T8110_PARAMS3_VER_MAJ GENMASK(15, 8)
> +#define DART_T8110_PARAMS3_VER_MIN GENMASK(7, 0)
> +
> +#define DART_T8110_PARAMS4 0x0c
> +#define DART_T8110_PARAMS4_NUM_CLIENTS GENMASK(24, 16)
> +#define DART_T8110_PARAMS4_NUM_SIDS GENMASK(8, 0)
> +
> +#define DART_T8110_TLB_CMD              0x80
> +#define DART_T8110_TLB_CMD_BUSY         BIT(31)
> +#define DART_T8110_TLB_CMD_OP           GENMASK(10, 8)
> +#define DART_T8110_TLB_CMD_OP_FLUSH_ALL 0
> +#define DART_T8110_TLB_CMD_OP_FLUSH_SID 1
> +#define DART_T8110_TLB_CMD_STREAM       GENMASK(7, 0)
> +
> +#define DART_T8110_ERROR 0x100
> +#define DART_T8110_ERROR_STREAM GENMASK(27, 20)
> +#define DART_T8110_ERROR_CODE GENMASK(14, 0)
> +#define DART_T8110_ERROR_FLAG BIT(31)
> +
> +#define DART_T8110_ERROR_MASK 0x104
> +
> +#define DART_T8110_ERROR_READ_FAULT BIT(4)
> +#define DART_T8110_ERROR_WRITE_FAULT BIT(3)
> +#define DART_T8110_ERROR_NO_PTE BIT(3)
> +#define DART_T8110_ERROR_NO_PMD BIT(2)
> +#define DART_T8110_ERROR_NO_PGD BIT(1)
> +#define DART_T8110_ERROR_NO_TTBR BIT(0)
> +
> +#define DART_T8110_ERROR_ADDR_LO 0x170
> +#define DART_T8110_ERROR_ADDR_HI 0x174
> +
> +#define DART_T8110_PROTECT 0x200
> +#define DART_T8110_UNPROTECT 0x204
> +#define DART_T8110_PROTECT_LOCK 0x208
> +#define DART_T8110_PROTECT_TTBR_TCR BIT(0)

Do you have any more details on this registers? For the 8103 DART
we called it _CONFIG but I assume for the t8110 DART it can
actually lock different parts of the HW instead of just a global lock?

> +
> +#define DART_T8110_ENABLE_STREAMS  0xc00
> +#define DART_T8110_DISABLE_STREAMS 0xc20
> +
> +#define DART_T8110_TCR                  0x1000
> +#define DART_T8110_TCR_REMAP            GENMASK(11, 8)
> +#define DART_T8110_TCR_REMAP_EN         BIT(7)
> +#define DART_T8110_TCR_BYPASS_DAPF      BIT(2)
> +#define DART_T8110_TCR_BYPASS_DART      BIT(1)
> +#define DART_T8110_TCR_TRANSLATE_ENABLE BIT(0)
> +
> +#define DART_T8110_TTBR       0x1400
> +#define DART_T8110_TTBR_VALID BIT(0)
> +#define DART_T8110_TTBR_ADDR_OFF 2
> +#define DART_T8110_TTBR_SHIFT 14
> +
>  #define DART_TCR(dart, sid) ((dart)->hw->tcr + ((sid) << 2))
> 
>  #define DART_TTBR(dart, sid, idx) ((dart)->hw->ttbr + \
> @@ -93,7 +149,14 @@
> 
>  struct apple_dart_stream_map;
> 
> +enum dart_type {

Minor nit: enum apple_dart_type to be consistent with the rest of the driver.

> +	DART_T8020,
> +	DART_T6000,
> +	DART_T8110,
> +};
> +
>  struct apple_dart_hw {
> +	enum dart_type type;
>  	irqreturn_t (*irq_handler)(int irq, void *dev);
>  	int (*invalidate_tlb)(struct apple_dart_stream_map *stream_map);
> 
> @@ -150,6 +213,8 @@ struct apple_dart {
> 
>  	spinlock_t lock;
> 
> +	u32 ias;
> +	u32 oas;
>  	u32 pgsize;
>  	u32 num_streams;
>  	u32 supports_bypass : 1;
> @@ -331,6 +396,44 @@ apple_dart_t8020_hw_stream_command(struct 
> apple_dart_stream_map *stream_map,
>  	return 0;
>  }
> 
> +static int
> +apple_dart_t8110_hw_tlb_command(struct apple_dart_stream_map 
> *stream_map,
> +				u32 command)
> +{
> +	struct apple_dart *dart = stream_map->dart;
> +	unsigned long flags;
> +	int ret = 0;
> +	int sid;
> +
> +	spin_lock_irqsave(&dart->lock, flags);
> +
> +	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams) {
> +		u32 val = FIELD_PREP(DART_T8110_TLB_CMD_OP, command) |
> +			FIELD_PREP(DART_T8110_TLB_CMD_STREAM, sid);
> +		writel(val, dart->regs + DART_T8110_TLB_CMD);
> +
> +		ret = readl_poll_timeout_atomic(
> +			dart->regs + DART_T8110_TLB_CMD, val,
> +			!(val & DART_T8110_TLB_CMD_BUSY), 1,
> +			DART_STREAM_COMMAND_BUSY_TIMEOUT);
> +
> +		if (ret)
> +			break;
> +
> +	}
> +
> +	spin_unlock_irqrestore(&dart->lock, flags);
> +
> +	if (ret) {
> +		dev_err(stream_map->dart->dev,
> +			"busy bit did not clear after command %x for stream %d\n",
> +			command, sid);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  apple_dart_t8020_hw_invalidate_tlb(struct apple_dart_stream_map 
> *stream_map)
>  {
> @@ -338,6 +441,13 @@ apple_dart_t8020_hw_invalidate_tlb(struct 
> apple_dart_stream_map *stream_map)
>  		stream_map, DART_T8020_STREAM_COMMAND_INVALIDATE);
>  }
> 
> +static int
> +apple_dart_t8110_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
> +{
> +	return apple_dart_t8110_hw_tlb_command(
> +		stream_map, DART_T8110_TLB_CMD_OP_FLUSH_SID);
> +}
> +
>  static int apple_dart_hw_reset(struct apple_dart *dart)
>  {
>  	u32 config;
> @@ -364,6 +474,9 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
>  	/* clear any pending errors before the interrupt is unmasked */
>  	writel(readl(dart->regs + dart->hw->error), dart->regs + dart->hw->error);
> 
> +	if (dart->hw->type == DART_T8110)
> +		writel(0,  dart->regs + DART_T8110_ERROR_MASK);
> +
>  	return dart->hw->invalidate_tlb(&stream_map);
>  }
> 
> @@ -479,8 +592,8 @@ static int apple_dart_finalize_domain(struct 
> iommu_domain *domain,
> 
>  	pgtbl_cfg = (struct io_pgtable_cfg){
>  		.pgsize_bitmap = dart->pgsize,
> -		.ias = 32,
> -		.oas = dart->hw->oas,
> +		.ias = dart->ias,
> +		.oas = dart->oas,
>  		.coherent_walk = 1,
>  		.iommu_dev = dart->dev,
>  	};
> @@ -494,7 +607,7 @@ static int apple_dart_finalize_domain(struct 
> iommu_domain *domain,
> 
>  	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>  	domain->geometry.aperture_start = 0;
> -	domain->geometry.aperture_end = DMA_BIT_MASK(32);
> +	domain->geometry.aperture_end = DMA_BIT_MASK(dart->ias);
>  	domain->geometry.force_aperture = true;
> 
>  	dart_domain->finalized = true;
> @@ -881,10 +994,49 @@ static irqreturn_t apple_dart_t8020_irq(int irq, 
> void *dev)
>  	return IRQ_HANDLED;
>  }
> 
> +static irqreturn_t apple_dart_t8110_irq(int irq, void *dev)
> +{
> +	struct apple_dart *dart = dev;
> +	const char *fault_name = NULL;
> +	u32 error = readl(dart->regs + DART_T8110_ERROR);
> +	u32 error_code = FIELD_GET(DART_T8110_ERROR_CODE, error);
> +	u32 addr_lo = readl(dart->regs + DART_T8110_ERROR_ADDR_LO);
> +	u32 addr_hi = readl(dart->regs + DART_T8110_ERROR_ADDR_HI);
> +	u64 addr = addr_lo | (((u64)addr_hi) << 32);
> +	u8 stream_idx = FIELD_GET(DART_T8110_ERROR_STREAM, error);
> +
> +	if (!(error & DART_T8110_ERROR_FLAG))
> +		return IRQ_NONE;
> +
> +	/* there should only be a single bit set but let's use == to be sure */
> +	if (error_code == DART_T8110_ERROR_READ_FAULT)
> +		fault_name = "READ FAULT";
> +	else if (error_code == DART_T8110_ERROR_WRITE_FAULT)
> +		fault_name = "WRITE FAULT";
> +	else if (error_code == DART_T8110_ERROR_NO_PTE)
> +		fault_name = "NO PTE FOR IOVA";
> +	else if (error_code == DART_T8110_ERROR_NO_PMD)
> +		fault_name = "NO PMD FOR IOVA";
> +	else if (error_code == DART_T8110_ERROR_NO_PGD)
> +		fault_name = "NO PGD FOR IOVA";
> +	else if (error_code == DART_T8110_ERROR_NO_TTBR)
> +		fault_name = "NO TTBR FOR IOVA";
> +	else
> +		fault_name = "unknown";
> +
> +	dev_err_ratelimited(
> +		dart->dev,
> +		"translation fault: status:0x%x stream:%d code:0x%x (%s) at 0x%llx",
> +		error, stream_idx, error_code, fault_name, addr);
> +
> +	writel(error, dart->regs + DART_T8110_ERROR);
> +	return IRQ_HANDLED;
> +}
> +
>  static int apple_dart_probe(struct platform_device *pdev)
>  {
>  	int ret;
> -	u32 dart_params[2];
> +	u32 dart_params[4];
>  	struct resource *res;
>  	struct apple_dart *dart;
>  	struct device *dev = &pdev->dev;
> @@ -924,7 +1076,22 @@ static int apple_dart_probe(struct platform_device *pdev)
>  	dart->pgsize = 1 << FIELD_GET(DART_PARAMS1_PAGE_SHIFT, dart_params[0]);
>  	dart->supports_bypass = dart_params[1] & DART_PARAMS2_BYPASS_SUPPORT;
> 
> -	dart->num_streams = dart->hw->max_sid_count;
> +	switch (dart->hw->type) {
> +	case DART_T8020:
> +	case DART_T6000:
> +		dart->ias = 32;
> +		dart->oas = dart->hw->oas;
> +		dart->num_streams = dart->hw->max_sid_count;
> +		break;
> +
> +	case DART_T8110:
> +		dart_params[2] = readl(dart->regs + DART_T8110_PARAMS3);
> +		dart_params[3] = readl(dart->regs + DART_T8110_PARAMS4);
> +		dart->ias = FIELD_GET(DART_T8110_PARAMS3_VA_WIDTH, dart_params[2]);
> +		dart->oas = FIELD_GET(DART_T8110_PARAMS3_PA_WIDTH, dart_params[2]);
> +		dart->num_streams = FIELD_GET(DART_T8110_PARAMS4_NUM_SIDS, dart_params[3]);
> +		break;
> +	}
> 
>  	if (dart->num_streams > DART_MAX_STREAMS) {
>  		dev_err(&pdev->dev, "Too many streams (%d > %d)\n",
> @@ -987,6 +1154,7 @@ static int apple_dart_remove(struct platform_device *pdev)
>  }
> 
>  static const struct apple_dart_hw apple_dart_hw_t8103 = {
> +	.type = DART_T8020,
>  	.irq_handler = apple_dart_t8020_irq,
>  	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
>  	.oas = 36,
> @@ -1011,6 +1179,7 @@ static const struct apple_dart_hw apple_dart_hw_t8103 = {
>  	.ttbr_count = 4,
>  };
>  static const struct apple_dart_hw apple_dart_hw_t6000 = {
> +	.type = DART_T6000,
>  	.irq_handler = apple_dart_t8020_irq,
>  	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
>  	.oas = 42,
> @@ -1035,6 +1204,32 @@ static const struct apple_dart_hw apple_dart_hw_t6000 = {
>  	.ttbr_count = 4,
>  };
> 
> +static const struct apple_dart_hw apple_dart_hw_t8110 = {
> +	.type = DART_T8110,
> +	.irq_handler = apple_dart_t8110_irq,
> +	.invalidate_tlb = apple_dart_t8110_hw_invalidate_tlb,
> +	.fmt = APPLE_DART2,
> +	.max_sid_count = 256,
> +
> +	.enable_streams = DART_T8110_ENABLE_STREAMS,
> +	.disable_streams = DART_T8110_DISABLE_STREAMS,
> +	.lock = DART_T8110_PROTECT,
> +	.lock_bit = DART_T8110_PROTECT_TTBR_TCR,
> +
> +	.error = DART_T8110_ERROR,
> +
> +	.tcr = DART_T8110_TCR,
> +	.tcr_enabled = DART_T8110_TCR_TRANSLATE_ENABLE,
> +	.tcr_disabled = 0,
> +	.tcr_bypass = DART_T8110_TCR_BYPASS_DAPF | DART_T8110_TCR_BYPASS_DART,
> +
> +	.ttbr = DART_T8110_TTBR,
> +	.ttbr_valid = DART_T8110_TTBR_VALID,
> +	.ttbr_addr_off = DART_T8110_TTBR_ADDR_OFF,
> +	.ttbr_shift = DART_T8110_TTBR_SHIFT,
> +	.ttbr_count = 1,
> +};
> +
>  static __maybe_unused int apple_dart_suspend(struct device *dev)
>  {
>  	struct apple_dart *dart = dev_get_drvdata(dev);
> @@ -1076,6 +1271,7 @@ DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, 
> apple_dart_suspend, apple_dart_resum
> 
>  static const struct of_device_id apple_dart_of_match[] = {
>  	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
> +	{ .compatible = "apple,t8110-dart", .data = &apple_dart_hw_t8110 },
>  	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
>  	{},
>  };
> -- 
> 2.35.1
