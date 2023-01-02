Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABC765B51E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbjABQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjABQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:33:31 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900C1260A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:33:30 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 077A75C00E6;
        Mon,  2 Jan 2023 11:33:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Jan 2023 11:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672677210; x=
        1672763610; bh=lW9PYRq8hEEy7w1UqEtS4QDO9L0cWWs67YIW+dtEdaY=; b=B
        RkpY+kAF2QTi0ZgltGOQaeJDhKWQLffArckWBtJWTklXFYJnlUgij7zXdC1uJBQM
        0HEiAFbgIp/z/kXY2zmJEpAAg3rPsI9r3dGP/2qbKnYwPpYFkD9ph2auBcG++9BS
        ylm2QQWgW3SIZDapmFdP5ZV1PcBWfsh9i9tFh+ue3KaPVNOfSrbqGsxNb4b/wXuo
        FBSxQ+B0lgLLUcnSRAVZmU3M6h04YSFv1tHe1KAd1nv05N0scujtpPTkV521thN9
        7Q1inUaEHMN3LHQKstqg60FKGiPz0171z2/KmuK2bxVxEFkovAsg5refAv37dFDm
        wTWz9AiUH8oDszaLvWSig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672677210; x=
        1672763610; bh=lW9PYRq8hEEy7w1UqEtS4QDO9L0cWWs67YIW+dtEdaY=; b=M
        b+cqviA9jseC+d/2FEVkSsWh89W63Pkp7wcpou8Unkx+hYZc2nnvCLVz7d+CBAaS
        VXjNaEaJPZdsPILrLMmK7WE0GEYKn2PkQpM2OrWt2I/OwnwBRQg8rhoKWHyWO2ta
        cu+pn/X4vxps37j12qDnxp3+pL9IpGBSsc6LkLxOzd5HlufJ59bew7KNNTlCa3yG
        REBEq/Hw/xPsX9U0rDQe3cCOJ5z05wKpNerwh8dDG5dqaNKku4DZiJiZe11ruJbR
        Unw9lZtRBSfK31xMWsR25X8bNGKTXKbJRy39/BezIzcRfCWfTFdiCTiHuol9IcEP
        sgZ4wB+3ITjMCAaK2gWfg==
X-ME-Sender: <xms:WQezYweTvXtjB1-0bxZCC5gpgRsaVWE3fffpv2EiKs9jMaPpnbpZbg>
    <xme:WQezYyMAOubGvRpN_GUVt2-UZnVyl2ARTVJ8mFNsmIjr4SsS7z76iH96yV-XJMfvY
    qC-jROxzt0FMoac8A>
X-ME-Received: <xmr:WQezYxjZdZTjAQxdqVWPV2sFwGdOCbDMuSs1q0r1A04TjuJH_L16_RMX6DIQWreuDHCkOkYtmZuCNxakU9AlxGB9tT1oFW6PUVpeuX-dj7ftUiKRy2pyEQnMJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfdtgfelffekveelvdeuteetfefgleelhfejteeiuefhheetueef
    fefgheefveefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:WQezY19rPE58Eo6mreQdNkjbSxcaVE-723Z31FXgwISYRoUZWUckog>
    <xmx:WQezY8vVCDLqiier_tpnhHfq_TIKdUZb_biotPYRKIt7zV_zT95uaQ>
    <xmx:WQezY8EF4t9-v3rq5zv-sNNyA7BAgBTVh4-nkF9ChMcygEivskPAdg>
    <xmx:WgezY-IhT7pcbj65kUwLOaW4pnZmyxOvcoNFZE-li8kPKr_JwZwAww>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 11:33:29 -0500 (EST)
Message-ID: <91a7f7c0-9be3-9cac-c2d8-a34563bc4410@sholland.org>
Date:   Mon, 2 Jan 2023 10:33:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 7/7] mtd: rawnand: sunxi: Precompute the ECC_CTL register
 value
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20221229181526.53766-1-samuel@sholland.org>
 <20221229181526.53766-8-samuel@sholland.org> <20230102103009.00486aa3@xps-13>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230102103009.00486aa3@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

On 1/2/23 03:30, Miquel Raynal wrote:
> Hi Samuel,
> 
> samuel@sholland.org wrote on Thu, 29 Dec 2022 12:15:26 -0600:
> 
>> This removes an unnecessary memory allocation, and avoids recomputing
>> the same register value every time ECC is enabled.
> 
> I am fine with the "let's not recompute the register value each time"
> idea, but I like having a dedicated object reserved for the ECC
> engine, that is separated from the main controller structure (both
> are two different things, even though they are usually well
> integrated).
> 
> If it's actually useless you can still get rid of the allocation and in
> the structure you can save the ecc_ctrl reg value instead of mode.

OK, I will do this, and split it into two patches: one for replacing
mode with ecc_ctrl, and the second to keep the structure but get rid of
the allocation.

Regards,
Samuel

> The other patches in the series look good to me.
> 
> Thanks,
> Miquèl
> 
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/mtd/nand/raw/sunxi_nand.c | 75 ++++++-------------------------
>>  1 file changed, 13 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
>> index a3bc9f7f9e5a..5c5a567d8870 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>> @@ -169,22 +169,13 @@ struct sunxi_nand_chip_sel {
>>  	s8 rb;
>>  };
>>  
>> -/**
>> - * struct sunxi_nand_hw_ecc - stores information related to HW ECC support
>> - *
>> - * @mode: the sunxi ECC mode field deduced from ECC requirements
>> - */
>> -struct sunxi_nand_hw_ecc {
>> -	int mode;
>> -};
>> -
>>  /**
>>   * struct sunxi_nand_chip - stores NAND chip device related information
>>   *
>>   * @node: used to store NAND chips into a list
>>   * @nand: base NAND chip structure
>> - * @ecc: ECC controller structure
>>   * @clk_rate: clk_rate required for this NAND chip
>> + * @ecc_ctl: ECC_CTL register value for this NAND chip
>>   * @timing_cfg: TIMING_CFG register value for this NAND chip
>>   * @timing_ctl: TIMING_CTL register value for this NAND chip
>>   * @nsels: number of CS lines required by the NAND chip
>> @@ -193,8 +184,8 @@ struct sunxi_nand_hw_ecc {
>>  struct sunxi_nand_chip {
>>  	struct list_head node;
>>  	struct nand_chip nand;
>> -	struct sunxi_nand_hw_ecc *ecc;
>>  	unsigned long clk_rate;
>> +	u32 ecc_ctl;
>>  	u32 timing_cfg;
>>  	u32 timing_ctl;
>>  	int nsels;
>> @@ -689,26 +680,15 @@ static void sunxi_nfc_hw_ecc_enable(struct nand_chip *nand)
>>  {
>>  	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
>>  	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
>> -	u32 ecc_ctl;
>> -
>> -	ecc_ctl = readl(nfc->regs + NFC_REG_ECC_CTL);
>> -	ecc_ctl &= ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
>> -		     NFC_ECC_BLOCK_SIZE_MSK);
>> -	ecc_ctl |= NFC_ECC_EN | NFC_ECC_MODE(sunxi_nand->ecc->mode) |
>> -		   NFC_ECC_EXCEPTION | NFC_ECC_PIPELINE;
>> -
>> -	if (nand->ecc.size == 512)
>> -		ecc_ctl |= NFC_ECC_BLOCK_512;
>>  
>> -	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
>> +	writel(sunxi_nand->ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
>>  }
>>  
>>  static void sunxi_nfc_hw_ecc_disable(struct nand_chip *nand)
>>  {
>>  	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
>>  
>> -	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
>> -	       nfc->regs + NFC_REG_ECC_CTL);
>> +	writel(0, nfc->regs + NFC_REG_ECC_CTL);
>>  }
>>  
>>  static inline void sunxi_nfc_user_data_to_buf(u32 user_data, u8 *buf)
>> @@ -1626,11 +1606,6 @@ static const struct mtd_ooblayout_ops sunxi_nand_ooblayout_ops = {
>>  	.free = sunxi_nand_ooblayout_free,
>>  };
>>  
>> -static void sunxi_nand_hw_ecc_ctrl_cleanup(struct sunxi_nand_chip *sunxi_nand)
>> -{
>> -	kfree(sunxi_nand->ecc);
>> -}
>> -
>>  static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>  				       struct nand_ecc_ctrl *ecc,
>>  				       struct device_node *np)
>> @@ -1641,7 +1616,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>  	struct mtd_info *mtd = nand_to_mtd(nand);
>>  	struct nand_device *nanddev = mtd_to_nanddev(mtd);
>>  	int nsectors;
>> -	int ret;
>>  	int i;
>>  
>>  	if (nanddev->ecc.user_conf.flags & NAND_ECC_MAXIMIZE_STRENGTH) {
>> @@ -1675,10 +1649,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>  	if (ecc->size != 512 && ecc->size != 1024)
>>  		return -EINVAL;
>>  
>> -	sunxi_nand->ecc = kzalloc(sizeof(*sunxi_nand->ecc), GFP_KERNEL);
>> -	if (!sunxi_nand->ecc)
>> -		return -ENOMEM;
>> -
>>  	/* Prefer 1k ECC chunk over 512 ones */
>>  	if (ecc->size == 512 && mtd->writesize > 512) {
>>  		ecc->size = 1024;
>> @@ -1699,12 +1669,9 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>  
>>  	if (i >= ARRAY_SIZE(strengths)) {
>>  		dev_err(nfc->dev, "unsupported strength\n");
>> -		ret = -ENOTSUPP;
>> -		goto err;
>> +		return -ENOTSUPP;
>>  	}
>>  
>> -	sunxi_nand->ecc->mode = i;
>> -
>>  	/* HW ECC always request ECC bytes for 1024 bytes blocks */
>>  	ecc->bytes = DIV_ROUND_UP(ecc->strength * fls(8 * 1024), 8);
>>  
>> @@ -1713,10 +1680,14 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>  
>>  	nsectors = mtd->writesize / ecc->size;
>>  
>> -	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors)) {
>> -		ret = -EINVAL;
>> -		goto err;
>> -	}
>> +	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors))
>> +		return -EINVAL;
>> +
>> +	sunxi_nand->ecc_ctl = NFC_ECC_MODE(i) | NFC_ECC_EXCEPTION |
>> +			      NFC_ECC_PIPELINE | NFC_ECC_EN;
>> +
>> +	if (ecc->size == 512)
>> +		sunxi_nand->ecc_ctl |= NFC_ECC_BLOCK_512;
>>  
>>  	ecc->read_oob = sunxi_nfc_hw_ecc_read_oob;
>>  	ecc->write_oob = sunxi_nfc_hw_ecc_write_oob;
>> @@ -1739,25 +1710,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>  	ecc->write_oob_raw = nand_write_oob_std;
>>  
>>  	return 0;
>> -
>> -err:
>> -	kfree(sunxi_nand->ecc);
>> -
>> -	return ret;
>> -}
>> -
>> -static void sunxi_nand_ecc_cleanup(struct sunxi_nand_chip *sunxi_nand)
>> -{
>> -	struct nand_ecc_ctrl *ecc = &sunxi_nand->nand.ecc;
>> -
>> -	switch (ecc->engine_type) {
>> -	case NAND_ECC_ENGINE_TYPE_ON_HOST:
>> -		sunxi_nand_hw_ecc_ctrl_cleanup(sunxi_nand);
>> -		break;
>> -	case NAND_ECC_ENGINE_TYPE_NONE:
>> -	default:
>> -		break;
>> -	}
>>  }
>>  
>>  static int sunxi_nand_attach_chip(struct nand_chip *nand)
>> @@ -1970,7 +1922,6 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
>>  		ret = mtd_device_unregister(nand_to_mtd(chip));
>>  		WARN_ON(ret);
>>  		nand_cleanup(chip);
>> -		sunxi_nand_ecc_cleanup(sunxi_nand);
>>  		list_del(&sunxi_nand->node);
>>  	}
>>  }

