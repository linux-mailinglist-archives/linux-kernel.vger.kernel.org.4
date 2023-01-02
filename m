Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27165B586
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbjABRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbjABRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:06:27 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB8964DB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 09:06:26 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 207E45C0096;
        Mon,  2 Jan 2023 12:06:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 02 Jan 2023 12:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672679183; x=
        1672765583; bh=ubVMmek62b2FW/lrihLkt+k98Rt0VqU7QHx3G8jOQhs=; b=T
        DLBM0ZlpSQ5f13Md/yEmLhdRczLe83CukeKYPEHYQZQrHnwBes+mVchAGa9A6FfD
        1b7PAxouNYAjvWhwLFIXNIzZpa97wBI/6tYKcL592zM0kSINNNexh7qwNAE5VvEU
        dKEWL82+abmQFj8ysaXF98kBjCiL0sbM9DyYpQsQd8vShzzyTTIFaE7s0RuXhh+b
        BPWNwWW5yvqX9u/TmqFzFwfnbM4zMF7an1Y5zwI9UfkcJN5D/bNV6aJemREN8/7U
        WCQ648+RHHIR3kxmgPHs06AWRu9XKHSkmyRImL+s72wZggvzSpQydFoWVKPKJojv
        jcoyLieHnBpZbp1n5brFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672679183; x=
        1672765583; bh=ubVMmek62b2FW/lrihLkt+k98Rt0VqU7QHx3G8jOQhs=; b=S
        zUpkNhzIQneZi19EAmLimcWQzfkUj8LuN2QZQFec/YH2ig1DXjW7S6X51e+UgAhh
        XbCRfm4Ia7nb7PgBh95W+tHf1Y5wuIBGU7mcuVNBQjfxIhSLd7NUE6acdYgoYC3O
        OHk0NXSYPsFYY9SGfe1UVHRz0Wh2gHtIRp9VZcm7/ionYqQHCs9XtguuxAV4Sd8C
        Z5mM4jwUzuEFN9g/m5X8o8nfKFEFzLk5NbP0Fa6IK/HTVRKrJJLlV7cKBOMhkMMp
        q+zvYWcaSW2fivGJ9pU4z1uDhENbeQVwczqUE1KgVt+fU3dVASn3PE1gLrShW9j7
        uVCV/boYenu4dOHhayJlA==
X-ME-Sender: <xms:Dg-zY8MpW6yCKogrqcM9EEEsh3QWyf3DD1i6PPasguXY7SC9shvteg>
    <xme:Dg-zYy8WECzYL7C8jRwCYpoyBKVtXPqLFAmgvR9Vw0-xaKk2maJVHh-7CwS4pL6ZB
    _cLsInSBt-FMDe8Yg>
X-ME-Received: <xmr:Dg-zYzQEfGMAn7wHWugogLoxtPJa_7OxxgJl9jqw6X9UXpniZNYKd2JI5Dt1jf490olxJ5ozpUygbWylt_ajdTRCTyqv8LEHPWdBs3vshwMEcGkK3KwRNMGEWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeffgfdv
    ffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Dg-zY0vuZwSK3RZNsqLxyt6rnHVL7NF-ZI2lAButE5mG1jxY2i9T9w>
    <xmx:Dg-zY0ecvzM1g_7fY28XtzbsBJFFyLS9_sUyHjJOppGmqOKkCt8asw>
    <xmx:Dg-zY43wV1PVXa1Ow8CJf4DtXkQyVBnhl4dTX08m31gewxc7ZAghhw>
    <xmx:Dw-zY843USXsLuUw53gyd5fle5_8r8DnqnRKEUE1O3obbHO46GDs9w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 12:06:21 -0500 (EST)
Message-ID: <6940e60e-834d-9cc6-c3b8-657b100ea5db@sholland.org>
Date:   Mon, 2 Jan 2023 11:06:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
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
 <20221229181526.53766-5-samuel@sholland.org> <20230102101132.66aa1a1d@xps-13>
 <4207d4eb-31d5-31c0-1a7f-67ec00b63f58@sholland.org>
 <20230102174517.1ccb3654@xps-13>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 4/7] mtd: rawnand: sunxi: Fix ECC strength maximization
In-Reply-To: <20230102174517.1ccb3654@xps-13>
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

On 1/2/23 10:45, Miquel Raynal wrote:
>>>> This is already accounted for in the subtraction for OOB, since the BBM
>>>> overlaps the first OOB dword. With this change, the driver picks the
>>>> same ECC strength as the vendor driver.
>>>>
>>>> Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
>>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>>> ---
>>>>
>>>>  drivers/mtd/nand/raw/sunxi_nand.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
>>>> index 1bddeb1be66f..1ecf2cee343b 100644
>>>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>>>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>>>> @@ -1643,8 +1643,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>>>  		ecc->size = 1024;
>>>>  		nsectors = mtd->writesize / ecc->size;
>>>>  
>>>> -		/* Reserve 2 bytes for the BBM */
>>>> -		bytes = (mtd->oobsize - 2) / nsectors;
>>>> +		bytes = mtd->oobsize / nsectors;  
>>>
>>> I'm sorry but I don't think we can make this work. This change would
>>> break all existing users...  
>>
>> OK, it is not too much of an issue because I can manually specify the
>> ECC parameters in the devicetree. Do you think it makes sense to fix
>> this when adding new hardware variants/compatible strings?
> 
> Actually, looking at the code again, I don't get how the above diff
> could be valid. The "maximize strength" logic (in which this diff is)
> looks for the biggest region to store ECC bytes. These bytes cannot
> be stored on the BBM, which "mtd->oobsize - 2" tries to avoid, so we
> cannot get rid of this.

Right, we cannot overlap the BBM, but the BBM is accounted for in the
line below:

  /* 4 non-ECC bytes are added before each ECC bytes section */
  bytes -= 4;

Normally those 4 bytes are all free OOB, but for the first ECC step,
those are split into 2 free bytes and 2 BBM bytes:

  /*
   * The first 2 bytes are used for BB markers, hence we
   * only have 2 bytes available in the first user data
   * section.
   */
  if (!section && ecc->engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST) {
          oobregion->offset = 2;
          oobregion->length = 2;

          return 0;
  }

So if we subtract 4 bytes for the each free OOB area, including the
first one, and also subtract 2 bytes for the BBM, we are double-counting
the BBM. I should have made my commit message clearer. But I am going to
drop this patch anyway.

Regards,
Samuel

