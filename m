Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9916165B510
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjABQ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjABQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:26:51 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E12A18F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:26:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E37A5C0066;
        Mon,  2 Jan 2023 11:26:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 02 Jan 2023 11:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672676810; x=
        1672763210; bh=9SnjoCxG6lJy1Dd9d7mL56nMbg9UksLtOGhA65L1Kn0=; b=x
        KrbRR/ZdOi8eGOcYKwhsEjQVptwFPha0v/MoxmypCLM+LSfQUFxTUH6Cr2we/g6N
        IrCC71Dr0FbNtZP/uZTphJ2KAvS6euiV8S1Glfl0u5+zFiH+ak3dIhpDA3XBw9lU
        FCIRZpDRSAuIg4gTBxU9kT6Uc4nhaNEUpo2fGK4l684MQNBnqs1XsDoG+kfP4IFC
        hSFatowXm5ghgCMG5xEOdqpLEL3ZysR2e2qgQrZ6uWCBTxtOGpx17D5lPyAUQQiq
        4qnuVy7H4ptjfl5DTWlSF9L0mCQgAsPZA5QpdcTCNAK/D7A+/OWgynwOdp24FwcN
        HWejGwSsDwjmgXMSHC4MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672676810; x=
        1672763210; bh=9SnjoCxG6lJy1Dd9d7mL56nMbg9UksLtOGhA65L1Kn0=; b=c
        yrsp4gZcmHkoD8wOYxkCrQQ3cqqGJ8UI6NIIfsnngQNOhlgGxLmjzFruFeXvNK+L
        Ug49ZxUZGHAefZ4Wx9JSON3RgLxSVs3/xJo2W3BJsXlimC/0EoRTlArraaSNXFs1
        gP43NBla16mG//viKkkbNWs9MKt5ZiXCFYqhoHzq3x6FmSQs+yZlBK+FVFGHe42b
        8zpH2eVTk3gy2twCmwBwIplVdkFGvD2dS9hggdvtCnaMCIXmuvgaUwlZLZMWhv3E
        KObnJpnzsEGw0PILnm1xih6rSedpuXHugMFBRk+xwBHpjP86rMPhGN0bKLMpygYI
        UGNrVfU5xX/9899vhu0XQ==
X-ME-Sender: <xms:yQWzY7LqfHoQPy9Uga2nhdISMaseOUnCfPj5czN5vHks-VmyWD250Q>
    <xme:yQWzY_L1GWLESmwmONkKBkUCccwfpyoJZm8bzxVLnevLBMZoqXt0PAF0z5vvtHjAL
    XAN3vC3d8ypmHzyKA>
X-ME-Received: <xmr:yQWzYzt8faa2X2ClP23oFt2jsWZQUwhoU9owaqzw4INqNF56DN5iTlSIzP9gBwOgE6z4Pphu6YKafV3iOYANGgwiqD_TCWjIVa1imfcs_VNzAj10OCtkTV0pbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeffgfdv
    ffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:yQWzY0ZTUpYipH2Wc7Tt0TqsErPiKmeLbUsObUj6R03D1zUe_GQCEQ>
    <xmx:yQWzYyYdqqxXo98MrcGndfDopwVLohXCqTk1Zil9CZ01d3jdSuwFNQ>
    <xmx:yQWzY4Apja5s1FHpfCdAqG-XkIRPpMQlrusIG4nUklMERkgZLW3bLA>
    <xmx:ygWzY4nRWuhQ4U4VVcZOaCXZlsB6XDVfceKomJDPgmaWrtGamCAPiQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 11:26:49 -0500 (EST)
Message-ID: <e21aba9f-1afd-2615-fe00-3ee4176b9080@sholland.org>
Date:   Mon, 2 Jan 2023 10:26:48 -0600
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
 <20221229181526.53766-7-samuel@sholland.org> <20230102102123.511d337d@xps-13>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 6/7] mtd: rawnand: sunxi: Update OOB layout to match
 hardware
In-Reply-To: <20230102102123.511d337d@xps-13>
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

On 1/2/23 03:21, Miquel Raynal wrote:
> Hi Samuel,
> 
> samuel@sholland.org wrote on Thu, 29 Dec 2022 12:15:25 -0600:
> 
>> When using the hardware ECC engine, the OOB data is made available in
>> the NFC_REG_USER_DATA registers, one 32-bit word per ECC step. Any
>> additional bytes are only accessible through raw reads and software
>> descrambling. For efficiency, and to match the vendor driver, ignore
>> these extra bytes.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/mtd/nand/raw/sunxi_nand.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
>> index 8e873f4fec9a..a3bc9f7f9e5a 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>> @@ -1604,6 +1604,13 @@ static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
>>  		return 0;
>>  	}
>>  
>> +	/*
>> +	 * The controller does not provide access to OOB bytes
>> +	 * past the end of the ECC data.
>> +	 */
>> +	if (section == ecc->steps && ecc->engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
>> +		return -ERANGE;
> 
> Again, I am sorry but I cannot take this change, it would typically
> break jffs2 users (if any?) :(

Considering the bug I fixed in the previous patch, and the fact that
mtd_ooblayout_free() zeroes out the structure before calling the .free
callback, that region was being reported with a length of zero already.
So I don't think anyone could have been using those bytes anyway.

I am looking for a solution here because the ECC/scrambling engine
really provides no way to access these bytes. Reading them requires
turning off the ECC engine, performing another read command, and then
descrambling in software. So we are sort of lying when we claim those
bytes are available with hardware ECC enabled.

If this change cannot be made as-is, is there any way the user could opt
in to the new layout, to get the improved performance?

Regards,
Samuel

>>  	oobregion->offset = section * (ecc->bytes + 4);
>>  
>>  	if (section < ecc->steps)
> 
> 
> Thanks,
> Miquèl

