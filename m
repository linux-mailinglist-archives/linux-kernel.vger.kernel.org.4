Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0F65D475
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbjADNi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbjADNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:37:39 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FEB1F4;
        Wed,  4 Jan 2023 05:37:37 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0A11B3200941;
        Wed,  4 Jan 2023 08:37:35 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 04 Jan 2023 08:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672839455; x=1672925855; bh=MM
        oZlIp+JoiIJk/UEaLUTv7UCEzL4Ujmrkawpnugpg0=; b=h9U7ClKt6BGG87T2mN
        HAxzz7UUiLGvBYhdVfOMZv2TmcMJfE4mr/0orYLQwZzrCIeaWGCptUAyWM3Hld1C
        RllUZcd9/LJsLPi7kFU1VChDdGiOMChprr5NkHcAGaKBggYJl6AAAznXlWjQzE7J
        mZ6cLF3dWIhKQrgigxUuUakzNhAc36qyInbQ+b4/Z9Ho8cpbx04ITL9qnS69RA8v
        OZzmSXJrX8PVGW0hpeO3Zx5BeFR4iY7g84pkfjDCvkOU0TUZZ8hXNFW7CQ8zFPdb
        lHL1ggVtSKyAgwORNs+/pbVUnE3gK9l/kPcNhZBiizjjyUZeQOil2sa9Iisfo4ms
        qO5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672839455; x=1672925855; bh=MMoZlIp+JoiIJk/UEaLUTv7UCEzL
        4Ujmrkawpnugpg0=; b=MMeBSOJk6Ec3RctY42ZZduemln/eefKGd6i2OGeDDUP/
        Ic1Jc+UpJvF+yJogDPkVe4bzRYJyQjiLjwW/R2NgBCU1dsAmV91m2OEylOaaZmyM
        IaRRNTTrhhQkDUDtHJgT32OWDVPUUGt94eiUn60Tox+oDUvIHq2W4Nkt05WfVWP1
        TauEcnU71WolJ7HvKBFz/jOuKp10O4WrVKyj2uC46ZfgiCKk2BdHDJiRsjYCeRR1
        DsLTNZV/ZXpmn6ESa7MZKBPJdu6cxblphXaPobNbJaxXFL8ijs1nMgBK9r++ZkxI
        GhFneCMO2mo7zKYQKBKjn0KEQk6yhFgxSC+H/3R/1g==
X-ME-Sender: <xms:H4G1Y09XW0U0ljekTAFKRheCdGx-_xMmy4l9PgaG3v_cFrnj_SWTLg>
    <xme:H4G1Y8tCH9_wbJ5N2bAdyDxowxsQw2DRf1Ka-3lQFrNauGLuP-m-1YUahQZnadaRL
    JAs6HF_BFtJXaPC6y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:H4G1Y6Aq1qpmw_4wh_UYfzbBUvku-d5WeS8atKXCV-m8kSzYQwA6EQ>
    <xmx:H4G1Y0dS33dnFOuj_cWJoLygXJmv6TJTXNTk0pZoY6XCqEOWw-53-w>
    <xmx:H4G1Y5OWuVWUXBgU7iaaqa2nL-EMcK5SsvRRK_y-oIjK-PPR6cgBgA>
    <xmx:H4G1Y6HzTiKmVJt1-URpgOlOgMEb2bScb-6bXP3XQsgMj8u9m4NpHA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5D4C9A6007C; Wed,  4 Jan 2023 08:37:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <71bffbd4-f8b0-4201-b2eb-7a15847ac2c6@app.fastmail.com>
In-Reply-To: <20230104110013.24738-4-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-4-marcan@marcan.st>
Date:   Wed, 04 Jan 2023 14:37:14 +0100
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
Subject: Re: [PATCH 3/7] iommu: dart: Support >64 stream IDs
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
> T8110 DARTs have up to 256 SIDs, so we need to switch to a bitmap to
> handle them properly.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/iommu/apple-dart.c | 114 +++++++++++++++++++++++--------------
>  1 file changed, 71 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 2458416122f8..48743bcd5b9d 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -34,11 +34,10 @@
> 
>  #include "dma-iommu.h"
> 
> -#define DART_MAX_STREAMS 16
> +#define DART_MAX_STREAMS 256

Feels a bit wasteful to allocate 256-wide sid2group and save_{tcr,ttbr}
arrays even for the M1 where 16 are enough. But then again, that's still <100 KiB
for all DARTs combined and these machine have >8 GiB of RAM so it probably won't
make a difference


>  #define DART_MAX_TTBR 4
>  #define MAX_DARTS_PER_DEVICE 2
> 
> -#define DART_STREAM_ALL 0xffff
> 
>  #define DART_PARAMS1 0x00
>  #define DART_PARAMS_PAGE_SHIFT GENMASK(27, 24)
> @@ -85,6 +84,8 @@
>  struct apple_dart_hw {
>  	u32 oas;
>  	enum io_pgtable_fmt fmt;
> +
> +	int max_sid_count;
>  };
> 
>  /*
> @@ -116,6 +117,7 @@ struct apple_dart {
>  	spinlock_t lock;
> 
>  	u32 pgsize;
> +	u32 num_streams;
>  	u32 supports_bypass : 1;
>  	u32 force_bypass : 1;
> 
> @@ -143,11 +145,11 @@ struct apple_dart {
>   */
>  struct apple_dart_stream_map {
>  	struct apple_dart *dart;
> -	unsigned long sidmap;
> +	DECLARE_BITMAP(sidmap, DART_MAX_STREAMS);
>  };
>  struct apple_dart_atomic_stream_map {
>  	struct apple_dart *dart;
> -	atomic64_t sidmap;
> +	atomic_long_t sidmap[BITS_TO_LONGS(DART_MAX_STREAMS)];
>  };
> 
>  /*
> @@ -205,50 +207,55 @@ static struct apple_dart_domain 
> *to_dart_domain(struct iommu_domain *dom)
>  static void
>  apple_dart_hw_enable_translation(struct apple_dart_stream_map 
> *stream_map)
>  {
> +	struct apple_dart *dart = stream_map->dart;
>  	int sid;
> 
> -	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
> +	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>  		writel(DART_TCR_TRANSLATE_ENABLE,
> -		       stream_map->dart->regs + DART_TCR(sid));
> +		       dart->regs + DART_TCR(sid));
>  }
> 
>  static void apple_dart_hw_disable_dma(struct apple_dart_stream_map *stream_map)
>  {
> +	struct apple_dart *dart = stream_map->dart;
>  	int sid;
> 
> -	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
> -		writel(0, stream_map->dart->regs + DART_TCR(sid));
> +	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
> +		writel(0, dart->regs + DART_TCR(sid));
>  }
> 
>  static void
>  apple_dart_hw_enable_bypass(struct apple_dart_stream_map *stream_map)
>  {
> +	struct apple_dart *dart = stream_map->dart;
>  	int sid;
> 
>  	WARN_ON(!stream_map->dart->supports_bypass);
> -	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
> +	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>  		writel(DART_TCR_BYPASS0_ENABLE | DART_TCR_BYPASS1_ENABLE,
> -		       stream_map->dart->regs + DART_TCR(sid));
> +		       dart->regs + DART_TCR(sid));
>  }
> 
>  static void apple_dart_hw_set_ttbr(struct apple_dart_stream_map *stream_map,
>  				   u8 idx, phys_addr_t paddr)
>  {
> +	struct apple_dart *dart = stream_map->dart;
>  	int sid;
> 
>  	WARN_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
> -	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
> +	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>  		writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
> -		       stream_map->dart->regs + DART_TTBR(sid, idx));
> +		       dart->regs + DART_TTBR(sid, idx));
>  }
> 
>  static void apple_dart_hw_clear_ttbr(struct apple_dart_stream_map *stream_map,
>  				     u8 idx)
>  {
> +	struct apple_dart *dart = stream_map->dart;
>  	int sid;
> 
> -	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
> -		writel(0, stream_map->dart->regs + DART_TTBR(sid, idx));
> +	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
> +		writel(0, dart->regs + DART_TTBR(sid, idx));
>  }
> 
>  static void
> @@ -270,7 +277,7 @@ apple_dart_hw_stream_command(struct 
> apple_dart_stream_map *stream_map,
> 
>  	spin_lock_irqsave(&stream_map->dart->lock, flags);
> 
> -	writel(stream_map->sidmap, stream_map->dart->regs + DART_STREAM_SELECT);
> +	writel(stream_map->sidmap[0], stream_map->dart->regs + DART_STREAM_SELECT);
>  	writel(command, stream_map->dart->regs + DART_STREAM_COMMAND);
> 
>  	ret = readl_poll_timeout_atomic(
> @@ -283,7 +290,7 @@ apple_dart_hw_stream_command(struct 
> apple_dart_stream_map *stream_map,
>  	if (ret) {
>  		dev_err(stream_map->dart->dev,
>  			"busy bit did not clear after command %x for streams %lx\n",
> -			command, stream_map->sidmap);
> +			command, stream_map->sidmap[0]);
>  		return ret;
>  	}
> 
> @@ -301,6 +308,7 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
>  {
>  	u32 config;
>  	struct apple_dart_stream_map stream_map;
> +	int i;
> 
>  	config = readl(dart->regs + DART_CONFIG);
>  	if (config & DART_CONFIG_LOCK) {
> @@ -310,12 +318,14 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
>  	}
> 
>  	stream_map.dart = dart;
> -	stream_map.sidmap = DART_STREAM_ALL;
> +	bitmap_zero(stream_map.sidmap, DART_MAX_STREAMS);
> +	bitmap_set(stream_map.sidmap, 0, dart->num_streams);
>  	apple_dart_hw_disable_dma(&stream_map);
>  	apple_dart_hw_clear_all_ttbrs(&stream_map);
> 
>  	/* enable all streams globally since TCR is used to control isolation */
> -	writel(DART_STREAM_ALL, dart->regs + DART_STREAMS_ENABLE);
> +	for (i = 0; i < BITS_TO_U32(dart->num_streams); i++)
> +		writel(U32_MAX, dart->regs + DART_STREAMS_ENABLE);

This seems weird: this code writes U32_MAX to the same register
again and again. 


> 
>  	/* clear any pending errors before the interrupt is unmasked */
>  	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
> @@ -325,13 +335,16 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
> 
>  static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
>  {
> -	int i;
> +	int i, j;
>  	struct apple_dart_atomic_stream_map *domain_stream_map;
>  	struct apple_dart_stream_map stream_map;
> 
>  	for_each_stream_map(i, domain, domain_stream_map) {
>  		stream_map.dart = domain_stream_map->dart;
> -		stream_map.sidmap = atomic64_read(&domain_stream_map->sidmap);
> +
> +		for (j = 0; j < BITS_TO_LONGS(stream_map.dart->num_streams); j++)
> +			stream_map.sidmap[j] = 
> atomic_long_read(&domain_stream_map->sidmap[j]);
> +
>  		apple_dart_hw_invalidate_tlb(&stream_map);
>  	}
>  }
> @@ -416,7 +429,7 @@ static int apple_dart_finalize_domain(struct 
> iommu_domain *domain,
>  	struct apple_dart *dart = cfg->stream_maps[0].dart;
>  	struct io_pgtable_cfg pgtbl_cfg;
>  	int ret = 0;
> -	int i;
> +	int i, j;
> 
>  	mutex_lock(&dart_domain->init_lock);
> 
> @@ -425,8 +438,9 @@ static int apple_dart_finalize_domain(struct 
> iommu_domain *domain,
> 
>  	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
>  		dart_domain->stream_maps[i].dart = cfg->stream_maps[i].dart;
> -		atomic64_set(&dart_domain->stream_maps[i].sidmap,
> -			     cfg->stream_maps[i].sidmap);
> +		for (j = 0; j < BITS_TO_LONGS(dart->num_streams); j++)
> +			atomic_long_set(&dart_domain->stream_maps[i].sidmap[j],
> +					cfg->stream_maps[i].sidmap[j]);
>  	}
> 
>  	pgtbl_cfg = (struct io_pgtable_cfg){
> @@ -461,7 +475,7 @@ apple_dart_mod_streams(struct 
> apple_dart_atomic_stream_map *domain_maps,
>  		       struct apple_dart_stream_map *master_maps,
>  		       bool add_streams)
>  {
> -	int i;
> +	int i, j;
> 
>  	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
>  		if (domain_maps[i].dart != master_maps[i].dart)
> @@ -471,12 +485,14 @@ apple_dart_mod_streams(struct 
> apple_dart_atomic_stream_map *domain_maps,
>  	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
>  		if (!domain_maps[i].dart)
>  			break;
> -		if (add_streams)
> -			atomic64_or(master_maps[i].sidmap,
> -				    &domain_maps[i].sidmap);
> -		else
> -			atomic64_and(~master_maps[i].sidmap,
> -				     &domain_maps[i].sidmap);
> +		for (j = 0; j < BITS_TO_LONGS(domain_maps[i].dart->num_streams); 
> j++) {
> +			if (add_streams)
> +				atomic_long_or(master_maps[i].sidmap[j],
> +					       &domain_maps[i].sidmap[j]);
> +			else
> +				atomic_long_and(~master_maps[i].sidmap[j],
> +						&domain_maps[i].sidmap[j]);
> +		}
>  	}
> 
>  	return 0;
> @@ -640,14 +656,14 @@ static int apple_dart_of_xlate(struct device 
> *dev, struct of_phandle_args *args)
> 
>  	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
>  		if (cfg->stream_maps[i].dart == dart) {
> -			cfg->stream_maps[i].sidmap |= 1 << sid;
> +			set_bit(sid, cfg->stream_maps[i].sidmap);
>  			return 0;
>  		}
>  	}
>  	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
>  		if (!cfg->stream_maps[i].dart) {
>  			cfg->stream_maps[i].dart = dart;
> -			cfg->stream_maps[i].sidmap = 1 << sid;
> +			set_bit(sid, cfg->stream_maps[i].sidmap);
>  			return 0;
>  		}
>  	}
> @@ -666,7 +682,7 @@ static void apple_dart_release_group(void *iommu_data)
>  	mutex_lock(&apple_dart_groups_lock);
> 
>  	for_each_stream_map(i, group_master_cfg, stream_map)
> -		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
> +		for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams)
>  			stream_map->dart->sid2group[sid] = NULL;
> 
>  	kfree(iommu_data);
> @@ -685,7 +701,7 @@ static struct iommu_group 
> *apple_dart_device_group(struct device *dev)
>  	mutex_lock(&apple_dart_groups_lock);
> 
>  	for_each_stream_map(i, cfg, stream_map) {
> -		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS) {
> +		for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams) {
>  			struct iommu_group *stream_group =
>  				stream_map->dart->sid2group[sid];
> 
> @@ -724,7 +740,7 @@ static struct iommu_group 
> *apple_dart_device_group(struct device *dev)
>  		apple_dart_release_group);
> 
>  	for_each_stream_map(i, cfg, stream_map)
> -		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
> +		for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams)
>  			stream_map->dart->sid2group[sid] = group;
> 
>  	res = group;
> @@ -869,16 +885,26 @@ static int apple_dart_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
> 
> -	ret = apple_dart_hw_reset(dart);
> -	if (ret)
> -		goto err_clk_disable;
> -
>  	dart_params[0] = readl(dart->regs + DART_PARAMS1);
>  	dart_params[1] = readl(dart->regs + DART_PARAMS2);
>  	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
>  	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
> +
> +	dart->num_streams = dart->hw->max_sid_count;
> +
> +	if (dart->num_streams > DART_MAX_STREAMS) {
> +		dev_err(&pdev->dev, "Too many streams (%d > %d)\n",
> +			dart->num_streams, DART_MAX_STREAMS);
> +		ret = -EINVAL;
> +		goto err_clk_disable;
> +	}
> +
>  	dart->force_bypass = dart->pgsize > PAGE_SIZE;
> 
> +	ret = apple_dart_hw_reset(dart);
> +	if (ret)
> +		goto err_clk_disable;
> +
>  	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
>  			  "apple-dart fault handler", dart);
>  	if (ret)
> @@ -897,8 +923,8 @@ static int apple_dart_probe(struct platform_device *pdev)
> 
>  	dev_info(
>  		&pdev->dev,
> -		"DART [pagesize %x, bypass support: %d, bypass forced: %d] 
> initialized\n",
> -		dart->pgsize, dart->supports_bypass, dart->force_bypass);
> +		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: 
> %d] initialized\n",
> +		dart->pgsize, dart->num_streams, dart->supports_bypass, 
> dart->force_bypass);
>  	return 0;
> 
>  err_sysfs_remove:
> @@ -929,10 +955,12 @@ static int apple_dart_remove(struct platform_device *pdev)
>  static const struct apple_dart_hw apple_dart_hw_t8103 = {
>  	.oas = 36,
>  	.fmt = APPLE_DART,
> +	.max_sid_count = 16,
>  };
>  static const struct apple_dart_hw apple_dart_hw_t6000 = {
>  	.oas = 42,
>  	.fmt = APPLE_DART2,
> +	.max_sid_count = 16,
>  };
> 
>  static __maybe_unused int apple_dart_suspend(struct device *dev)
> @@ -940,7 +968,7 @@ static __maybe_unused int apple_dart_suspend(struct 
> device *dev)
>  	struct apple_dart *dart = dev_get_drvdata(dev);
>  	unsigned int sid, idx;
> 
> -	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
> +	for (sid = 0; sid < dart->num_streams; sid++) {
>  		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
>  		for (idx = 0; idx < DART_MAX_TTBR; idx++)
>  			dart->save_ttbr[sid][idx] =
> @@ -962,7 +990,7 @@ static __maybe_unused int apple_dart_resume(struct 
> device *dev)
>  		return ret;
>  	}
> 
> -	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
> +	for (sid = 0; sid < dart->num_streams; sid++) {
>  		for (idx = 0; idx < DART_MAX_TTBR; idx++)
>  			writel(dart->save_ttbr[sid][idx],
>  			       dart->regs + DART_TTBR(sid, idx));
> -- 
> 2.35.1
