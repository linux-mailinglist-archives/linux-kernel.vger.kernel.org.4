Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA765D4A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbjADNoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjADNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:44:00 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512D192AF;
        Wed,  4 Jan 2023 05:43:59 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id F196632001BB;
        Wed,  4 Jan 2023 08:43:57 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 04 Jan 2023 08:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672839837; x=1672926237; bh=pD
        vOEKvDA2aVLi6cTwAPr1f0kf2me/Xigbu64uT+mYU=; b=UtJcZnk7shlgzV9UzI
        Ns+UtTityV1O1JdbKrHqg6DrefX01H3Ol5G4os1nkzW/dqTU1FSQ0vHS274/kzzs
        ZbHmJBiogiSEZxLV4sUaWVkif9CD05LKmrX0uGUfSoXtjmuwtau/y6fSeHiZYbGo
        4gZE/KCOYfF6djmWgLV5eD82dEpTuudnSltLh4afSu4oDolk1X3IXgPmPH5J+H65
        Z5O+zCdAD/K9ctGYH4d8WPW5bHHYx7FevSnT/H7XLReaSLrGTsOtxhWt/YtuZz4x
        j06dt4/fLgyEOFeKd+tsJwmXhi+aBB5Fc6cAPJGfdECMc3AuAlH6qRmFiHRJIPhx
        fDug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672839837; x=1672926237; bh=pDvOEKvDA2aVLi6cTwAPr1f0kf2m
        e/Xigbu64uT+mYU=; b=LPQ1vVEBBJ0P6WwGF8aqDJZO2z/ubvV2KL9heOOHu1kL
        5u4ZJSPqGYgUbrGmUM87QCtnYhszonBywwm4RvCth3rNQKfHEmaFNCRx3ctOnJvY
        aLAM/m6wsJN+E617hHVObQyTqN88fFJtll+Ck7QDjsncCxrn4TozsJv+FLInrTIy
        jZE2xj2VUcVWq2b9S1QJE+yRtXDpDYQRInDTDvTJtyBIDUoXow5VBTdt8VHsFrDl
        9M4s8RY8LRbWbneik1/IbE2ec3SEnt8vcX703eW3osFx17dQf5TLvNsngVjUZANo
        QLxghS/U0ntOvD1YptOu+R6vVUEB4Y4gOit7YAr36g==
X-ME-Sender: <xms:nIK1Y5Dd7m4KIDgT7eYRMXKBMAd-EUvyG5CktwATxjyxkQX6flXOmQ>
    <xme:nIK1Y3jSeT9XweTyEdQBM0Xg3_kygM2QoDf6Mi15-vMPDkTmx66aBxhPn8WgdQvw0
    9Sibq3CcUgMnqvS5gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:nYK1Y0nF9ofWlcv1rBxbcni71Fwk7I3sjc-DGAbitcVocm7VEQRtvA>
    <xmx:nYK1YzwCgQu-quTyVMg18WTqY56g4cuH6LHBXoVJHaOasX1C-7pX-g>
    <xmx:nYK1Y-SfgyGYL9OoTic2x9EJFwIsrXe76WXPNbmtHjOdo176qBEHXw>
    <xmx:nYK1YzLzYQ2NEXtmXo5if7qfuAaZ04IhuOpMiVvF2aGUJwILNgk2MQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F1AF7A6007C; Wed,  4 Jan 2023 08:43:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <228a80d4-752b-42ae-84b4-47197ec82c24@app.fastmail.com>
In-Reply-To: <20230104110013.24738-7-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-7-marcan@marcan.st>
Date:   Wed, 04 Jan 2023 14:43:30 +0100
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
Subject: Re: [PATCH 6/7] iommu: dart: Support different variants with different
 registers
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
> T8110 has a new register layout. To accommodate this, first move all the
> register offsets to the hw structure, and rename all the existing
> registers to DART_T8020_*.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>


>  drivers/iommu/apple-dart.c | 188 ++++++++++++++++++++++++-------------
>  1 file changed, 125 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 03a3cb5638ba..396da83f2f9e 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -38,6 +38,7 @@
>  #define DART_MAX_TTBR 4
>  #define MAX_DARTS_PER_DEVICE 2
> 
> +/* Common registers */
> 
>  #define DART_PARAMS1 0x00
>  #define DART_PARAMS1_PAGE_SHIFT GENMASK(27, 24)
> @@ -45,52 +46,79 @@
>  #define DART_PARAMS2 0x04
>  #define DART_PARAMS2_BYPASS_SUPPORT BIT(0)
> 
> -#define DART_STREAM_COMMAND 0x20
> -#define DART_STREAM_COMMAND_BUSY BIT(2)
> -#define DART_STREAM_COMMAND_INVALIDATE BIT(20)
> +/* T8020/T6000 registers */
> 
> -#define DART_STREAM_SELECT 0x34
> +#define DART_T8020_STREAM_COMMAND 0x20
> +#define DART_T8020_STREAM_COMMAND_BUSY BIT(2)
> +#define DART_T8020_STREAM_COMMAND_INVALIDATE BIT(20)
> 
> -#define DART_ERROR 0x40
> -#define DART_ERROR_STREAM GENMASK(27, 24)
> -#define DART_ERROR_CODE GENMASK(11, 0)
> -#define DART_ERROR_FLAG BIT(31)
> +#define DART_T8020_STREAM_SELECT 0x34
> 
> -#define DART_ERROR_READ_FAULT BIT(4)
> -#define DART_ERROR_WRITE_FAULT BIT(3)
> -#define DART_ERROR_NO_PTE BIT(2)
> -#define DART_ERROR_NO_PMD BIT(1)
> -#define DART_ERROR_NO_TTBR BIT(0)
> +#define DART_T8020_ERROR 0x40
> +#define DART_T8020_ERROR_STREAM GENMASK(27, 24)
> +#define DART_T8020_ERROR_CODE GENMASK(11, 0)
> +#define DART_T8020_ERROR_FLAG BIT(31)
> 
> -#define DART_CONFIG 0x60
> -#define DART_CONFIG_LOCK BIT(15)
> +#define DART_T8020_ERROR_READ_FAULT BIT(4)
> +#define DART_T8020_ERROR_WRITE_FAULT BIT(3)
> +#define DART_T8020_ERROR_NO_PTE BIT(2)
> +#define DART_T8020_ERROR_NO_PMD BIT(1)
> +#define DART_T8020_ERROR_NO_TTBR BIT(0)
> +
> +#define DART_T8020_CONFIG 0x60
> +#define DART_T8020_CONFIG_LOCK BIT(15)
> 
>  #define DART_STREAM_COMMAND_BUSY_TIMEOUT 100
> 
> -#define DART_ERROR_ADDR_HI 0x54
> -#define DART_ERROR_ADDR_LO 0x50
> +#define DART_T8020_ERROR_ADDR_HI 0x54
> +#define DART_T8020_ERROR_ADDR_LO 0x50
> +
> +#define DART_T8020_STREAMS_ENABLE 0xfc
> 
> -#define DART_STREAMS_ENABLE 0xfc
> +#define DART_T8020_TCR                  0x100
> +#define DART_T8020_TCR_TRANSLATE_ENABLE BIT(7)
> +#define DART_T8020_TCR_BYPASS_DART      BIT(8)
> +#define DART_T8020_TCR_BYPASS_DAPF      BIT(12)
> 
> -#define DART_TCR(sid) (0x100 + 4 * (sid))
> -#define DART_TCR_TRANSLATE_ENABLE BIT(7)
> -#define DART_TCR_BYPASS0_ENABLE BIT(8)
> -#define DART_TCR_BYPASS1_ENABLE BIT(12)
> +#define DART_T8020_TTBR       0x200
> +#define DART_T8020_TTBR_VALID BIT(31)
> +#define DART_T8020_TTBR_ADDR_OFF 0
> +#define DART_T8020_TTBR_SHIFT 12
> 
> -#define DART_TTBR_VALID BIT(31)
> -#define DART_TTBR_SHIFT 12
> +#define DART_TCR(dart, sid) ((dart)->hw->tcr + ((sid) << 2))
> 
> -#define DART_TTBR(dart, sid, idx) (0x200 + \
> +#define DART_TTBR(dart, sid, idx) ((dart)->hw->ttbr + \
>  				   (((dart)->hw->ttbr_count * (sid)) << 2) + \
>  				   ((idx) << 2))
> 
> +struct apple_dart_stream_map;
> 
>  struct apple_dart_hw {
> +	irqreturn_t (*irq_handler)(int irq, void *dev);
> +	int (*invalidate_tlb)(struct apple_dart_stream_map *stream_map);
> +
>  	u32 oas;
>  	enum io_pgtable_fmt fmt;
> 
>  	int max_sid_count;
> 
> +	u64 lock;
> +	u64 lock_bit;
> +
> +	u64 error;
> +
> +	u64 enable_streams;
> +	u64 disable_streams;
I don't think disable_streams is used anywhere. I assume you just left it in
here to document it?

> +
> +	u64 tcr;
> +	u64 tcr_enabled;
> +	u64 tcr_disabled;
> +	u64 tcr_bypass;
> +
> +	u64 ttbr;
> +	u64 ttbr_valid;
> +	u64 ttbr_addr_off;

This name confused me a bit since off sounds like offset to me while
this is actually another shift. Can't really think of a better name
right now though. I'd at least a comment here to describe it.

> +	u64 ttbr_shift;
>  	int ttbr_count;
>  };
> 
> @@ -217,8 +245,7 @@ apple_dart_hw_enable_translation(struct 
> apple_dart_stream_map *stream_map)
>  	int sid;
> 
>  	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
> -		writel(DART_TCR_TRANSLATE_ENABLE,
> -		       dart->regs + DART_TCR(sid));
> +		writel(dart->hw->tcr_enabled, dart->regs + DART_TCR(dart, sid));
>  }
> 
>  static void apple_dart_hw_disable_dma(struct apple_dart_stream_map 
> *stream_map)
> @@ -227,7 +254,7 @@ static void apple_dart_hw_disable_dma(struct 
> apple_dart_stream_map *stream_map)
>  	int sid;
> 
>  	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
> -		writel(0, dart->regs + DART_TCR(sid));
> +		writel(dart->hw->tcr_disabled, dart->regs + DART_TCR(dart, sid));
>  }
> 
>  static void
> @@ -238,8 +265,8 @@ apple_dart_hw_enable_bypass(struct 
> apple_dart_stream_map *stream_map)
> 
>  	WARN_ON(!stream_map->dart->supports_bypass);
>  	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
> -		writel(DART_TCR_BYPASS0_ENABLE | DART_TCR_BYPASS1_ENABLE,
> -		       dart->regs + DART_TCR(sid));
> +		writel(dart->hw->tcr_bypass,
> +		       dart->regs + DART_TCR(dart, sid));
>  }
> 
>  static void apple_dart_hw_set_ttbr(struct apple_dart_stream_map 
> *stream_map,
> @@ -248,9 +275,10 @@ static void apple_dart_hw_set_ttbr(struct 
> apple_dart_stream_map *stream_map,
>  	struct apple_dart *dart = stream_map->dart;
>  	int sid;
> 
> -	WARN_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
> +	WARN_ON(paddr & ((1 << dart->hw->ttbr_shift) - 1));
>  	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
> -		writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
> +		writel(dart->hw->ttbr_valid |
> +		       (paddr >> dart->hw->ttbr_shift) << dart->hw->ttbr_addr_off,
>  		       dart->regs + DART_TTBR(dart, sid, idx));
>  }
> 
> @@ -274,7 +302,7 @@ apple_dart_hw_clear_all_ttbrs(struct 
> apple_dart_stream_map *stream_map)
>  }
> 
>  static int
> -apple_dart_hw_stream_command(struct apple_dart_stream_map *stream_map,
> +apple_dart_t8020_hw_stream_command(struct apple_dart_stream_map 
> *stream_map,
>  			     u32 command)
>  {
>  	unsigned long flags;
> @@ -283,12 +311,12 @@ apple_dart_hw_stream_command(struct 
> apple_dart_stream_map *stream_map,
> 
>  	spin_lock_irqsave(&stream_map->dart->lock, flags);
> 
> -	writel(stream_map->sidmap[0], stream_map->dart->regs + 
> DART_STREAM_SELECT);
> -	writel(command, stream_map->dart->regs + DART_STREAM_COMMAND);
> +	writel(stream_map->sidmap[0], stream_map->dart->regs + 
> DART_T8020_STREAM_SELECT);
> +	writel(command, stream_map->dart->regs + DART_T8020_STREAM_COMMAND);
> 
>  	ret = readl_poll_timeout_atomic(
> -		stream_map->dart->regs + DART_STREAM_COMMAND, command_reg,
> -		!(command_reg & DART_STREAM_COMMAND_BUSY), 1,
> +		stream_map->dart->regs + DART_T8020_STREAM_COMMAND, command_reg,
> +		!(command_reg & DART_T8020_STREAM_COMMAND_BUSY), 1,
>  		DART_STREAM_COMMAND_BUSY_TIMEOUT);
> 
>  	spin_unlock_irqrestore(&stream_map->dart->lock, flags);
> @@ -304,10 +332,10 @@ apple_dart_hw_stream_command(struct 
> apple_dart_stream_map *stream_map,
>  }
> 
>  static int
> -apple_dart_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
> +apple_dart_t8020_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
>  {
> -	return apple_dart_hw_stream_command(stream_map,
> -					    DART_STREAM_COMMAND_INVALIDATE);
> +	return apple_dart_t8020_hw_stream_command(
> +		stream_map, DART_T8020_STREAM_COMMAND_INVALIDATE);
>  }
> 
>  static int apple_dart_hw_reset(struct apple_dart *dart)
> @@ -316,8 +344,8 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
>  	struct apple_dart_stream_map stream_map;
>  	int i;
> 
> -	config = readl(dart->regs + DART_CONFIG);
> -	if (config & DART_CONFIG_LOCK) {
> +	config = readl(dart->regs + dart->hw->lock);
> +	if (config & dart->hw->lock_bit) {
>  		dev_err(dart->dev, "DART is locked down until reboot: %08x\n",
>  			config);
>  		return -EINVAL;
> @@ -331,12 +359,12 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
> 
>  	/* enable all streams globally since TCR is used to control isolation */
>  	for (i = 0; i < BITS_TO_U32(dart->num_streams); i++)
> -		writel(U32_MAX, dart->regs + DART_STREAMS_ENABLE);
> +		writel(U32_MAX, dart->regs + dart->hw->enable_streams);
> 
>  	/* clear any pending errors before the interrupt is unmasked */
> -	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
> +	writel(readl(dart->regs + dart->hw->error), dart->regs + dart->hw->error);
> 
> -	return apple_dart_hw_invalidate_tlb(&stream_map);
> +	return dart->hw->invalidate_tlb(&stream_map);
>  }
> 
>  static void apple_dart_domain_flush_tlb(struct apple_dart_domain 
> *domain)
> @@ -351,7 +379,7 @@ static void apple_dart_domain_flush_tlb(struct 
> apple_dart_domain *domain)
>  		for (j = 0; j < BITS_TO_LONGS(stream_map.dart->num_streams); j++)
>  			stream_map.sidmap[j] = 
> atomic_long_read(&domain_stream_map->sidmap[j]);
> 
> -		apple_dart_hw_invalidate_tlb(&stream_map);
> +		stream_map.dart->hw->invalidate_tlb(&stream_map);
>  	}
>  }
> 
> @@ -425,7 +453,7 @@ apple_dart_setup_translation(struct 
> apple_dart_domain *domain,
>  		apple_dart_hw_clear_ttbr(stream_map, i);
> 
>  	apple_dart_hw_enable_translation(stream_map);
> -	apple_dart_hw_invalidate_tlb(stream_map);
> +	stream_map->dart->hw->invalidate_tlb(stream_map);
>  }
> 
>  static int apple_dart_finalize_domain(struct iommu_domain *domain,
> @@ -816,30 +844,30 @@ static const struct iommu_ops apple_dart_iommu_ops = {
>  	}
>  };
> 
> -static irqreturn_t apple_dart_irq(int irq, void *dev)
> +static irqreturn_t apple_dart_t8020_irq(int irq, void *dev)
>  {
>  	struct apple_dart *dart = dev;
>  	const char *fault_name = NULL;
> -	u32 error = readl(dart->regs + DART_ERROR);
> -	u32 error_code = FIELD_GET(DART_ERROR_CODE, error);
> -	u32 addr_lo = readl(dart->regs + DART_ERROR_ADDR_LO);
> -	u32 addr_hi = readl(dart->regs + DART_ERROR_ADDR_HI);
> +	u32 error = readl(dart->regs + DART_T8020_ERROR);
> +	u32 error_code = FIELD_GET(DART_T8020_ERROR_CODE, error);
> +	u32 addr_lo = readl(dart->regs + DART_T8020_ERROR_ADDR_LO);
> +	u32 addr_hi = readl(dart->regs + DART_T8020_ERROR_ADDR_HI);
>  	u64 addr = addr_lo | (((u64)addr_hi) << 32);
> -	u8 stream_idx = FIELD_GET(DART_ERROR_STREAM, error);
> +	u8 stream_idx = FIELD_GET(DART_T8020_ERROR_STREAM, error);
> 
> -	if (!(error & DART_ERROR_FLAG))
> +	if (!(error & DART_T8020_ERROR_FLAG))
>  		return IRQ_NONE;
> 
>  	/* there should only be a single bit set but let's use == to be sure */
> -	if (error_code == DART_ERROR_READ_FAULT)
> +	if (error_code == DART_T8020_ERROR_READ_FAULT)
>  		fault_name = "READ FAULT";
> -	else if (error_code == DART_ERROR_WRITE_FAULT)
> +	else if (error_code == DART_T8020_ERROR_WRITE_FAULT)
>  		fault_name = "WRITE FAULT";
> -	else if (error_code == DART_ERROR_NO_PTE)
> +	else if (error_code == DART_T8020_ERROR_NO_PTE)
>  		fault_name = "NO PTE FOR IOVA";
> -	else if (error_code == DART_ERROR_NO_PMD)
> +	else if (error_code == DART_T8020_ERROR_NO_PMD)
>  		fault_name = "NO PMD FOR IOVA";
> -	else if (error_code == DART_ERROR_NO_TTBR)
> +	else if (error_code == DART_T8020_ERROR_NO_TTBR)
>  		fault_name = "NO TTBR FOR IOVA";
>  	else
>  		fault_name = "unknown";
> @@ -849,7 +877,7 @@ static irqreturn_t apple_dart_irq(int irq, void *dev)
>  		"translation fault: status:0x%x stream:%d code:0x%x (%s) at 0x%llx",
>  		error, stream_idx, error_code, fault_name, addr);
> 
> -	writel(error, dart->regs + DART_ERROR);
> +	writel(error, dart->regs + DART_T8020_ERROR);
>  	return IRQ_HANDLED;
>  }
> 
> @@ -911,7 +939,7 @@ static int apple_dart_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_clk_disable;
> 
> -	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
> +	ret = request_irq(dart->irq, dart->hw->irq_handler, IRQF_SHARED,
>  			  "apple-dart fault handler", dart);
>  	if (ret)
>  		goto err_clk_disable;
> @@ -959,17 +987,51 @@ static int apple_dart_remove(struct platform_device *pdev)
>  }
> 
>  static const struct apple_dart_hw apple_dart_hw_t8103 = {
> +	.irq_handler = apple_dart_t8020_irq,
> +	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
>  	.oas = 36,
>  	.fmt = APPLE_DART,
>  	.max_sid_count = 16,
> 
> +	.enable_streams = DART_T8020_STREAMS_ENABLE,
> +	.lock = DART_T8020_CONFIG,
> +	.lock_bit = DART_T8020_CONFIG_LOCK,
> +
> +	.error = DART_T8020_ERROR,
> +
> +	.tcr = DART_T8020_TCR,
> +	.tcr_enabled = DART_T8020_TCR_TRANSLATE_ENABLE,
> +	.tcr_disabled = 0,
> +	.tcr_bypass = DART_T8020_TCR_BYPASS_DAPF | DART_T8020_TCR_BYPASS_DART,
> +
> +	.ttbr = DART_T8020_TTBR,
> +	.ttbr_valid = DART_T8020_TTBR_VALID,
> +	.ttbr_addr_off = DART_T8020_TTBR_ADDR_OFF,
> +	.ttbr_shift = DART_T8020_TTBR_SHIFT,
>  	.ttbr_count = 4,
>  };
>  static const struct apple_dart_hw apple_dart_hw_t6000 = {
> +	.irq_handler = apple_dart_t8020_irq,
> +	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
>  	.oas = 42,
>  	.fmt = APPLE_DART2,
>  	.max_sid_count = 16,
> 
> +	.enable_streams = DART_T8020_STREAMS_ENABLE,
> +	.lock = DART_T8020_CONFIG,
> +	.lock_bit = DART_T8020_CONFIG_LOCK,
> +
> +	.error = DART_T8020_ERROR,
> +
> +	.tcr = DART_T8020_TCR,
> +	.tcr_enabled = DART_T8020_TCR_TRANSLATE_ENABLE,
> +	.tcr_disabled = 0,
> +	.tcr_bypass = DART_T8020_TCR_BYPASS_DAPF | DART_T8020_TCR_BYPASS_DART,
> +
> +	.ttbr = DART_T8020_TTBR,
> +	.ttbr_valid = DART_T8020_TTBR_VALID,
> +	.ttbr_addr_off = DART_T8020_TTBR_ADDR_OFF,
> +	.ttbr_shift = DART_T8020_TTBR_SHIFT,
>  	.ttbr_count = 4,
>  };
> 
> @@ -979,7 +1041,7 @@ static __maybe_unused int 
> apple_dart_suspend(struct device *dev)
>  	unsigned int sid, idx;
> 
>  	for (sid = 0; sid < dart->num_streams; sid++) {
> -		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
> +		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(dart, 
> sid));
>  		for (idx = 0; idx < dart->hw->ttbr_count; idx++)
>  			dart->save_ttbr[sid][idx] =
>  				readl(dart->regs + DART_TTBR(dart, sid, idx));
> @@ -1004,7 +1066,7 @@ static __maybe_unused int 
> apple_dart_resume(struct device *dev)
>  		for (idx = 0; idx < DART_MAX_TTBR; idx++)
>  			writel(dart->save_ttbr[sid][idx],
>  			       dart->regs + DART_TTBR(dart, sid, idx));
> -		writel(dart->save_tcr[sid], dart->regs + DART_TCR(sid));
> +		writel(dart->save_tcr[sid], dart->regs + DART_TCR(dart, sid));
>  	}
> 
>  	return 0;
> -- 
> 2.35.1
