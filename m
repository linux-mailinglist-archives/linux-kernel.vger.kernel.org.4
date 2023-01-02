Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5023A65B488
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbjABP7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:59:32 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFC5A471
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:59:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 04F445C00EA;
        Mon,  2 Jan 2023 10:59:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 02 Jan 2023 10:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672675171; x=
        1672761571; bh=2+4+wGrW59MyWwPd3wsJUrFMY8syiAgC2hBl1Lb19qY=; b=C
        ZismstWwRLv9F0oVlb1eOYQ60+wnig+4Qw78XhLVH1rvv1Zs9mm1mEv+iVLx+6id
        Z0Yf4Sd5UrLNAgwwS0P18BW0uAgFmL99EiubaHoVlVjXrv8xrFDh3xnAYBFAmost
        RY4exPMUHgc8HOtWkmu6hAHO6HhnE1RWTqBN53EmqAIqPALN9Kr5GcqGOzVyNidf
        /RJU4t8nQ9BFmNhpOHa/OTAonarpbCFw4JPuxY0c2ut7Ba1BjO05PElc7MaubLum
        3naQy5RtatAFrQENwy6wA6eCfvVGirePh4L+OODbKORAS+nz+cz9m41QuMBgDBcS
        9/qrNg23tvjH92JoodejQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672675171; x=
        1672761571; bh=2+4+wGrW59MyWwPd3wsJUrFMY8syiAgC2hBl1Lb19qY=; b=s
        zq9xQqCibpSOx5F4kL3RuqG2RNBmOzS0RBkdh1stgqg5O6SetUezK9L9tdXBi2TM
        Zcp6pFi63a0ajV2V/lFpSqKHpN7qwHB5VmOPjl6Ua0+mrB5nIw5mjIiOSoLG5/1Y
        6gOpVXNNNjdieeTVvYC40SOBnQlKGrTpxKK9J2dhhmNXDZNwCJhk5I8AyvrOHt9o
        j3pW9UG02YN5IrfAmpCVl6olVeS5hGOfY3DTDybDvVcrjQ9gBGsDuJ5COQvnb5Xd
        vmuWyfk+5mTEVCPAc6jBUx9CqmM7Aj1XCGOehMXyx/pOfwSWnZ1Y0dRJ4urXaf1i
        LhJ09g5TMIJRi9UTl4jPw==
X-ME-Sender: <xms:Yv-yYxim3elaiYCmMEDu82bkco5R8wSsRJ71uE26qBwSdxCo9n-p_g>
    <xme:Yv-yY2Bkr-wk-lzHdIOCXobu5stoOpF9zjHkE83n59O_wqRc4ehxVamW-8jhDfjbi
    T39a2F4HjqCEeWz3g>
X-ME-Received: <xmr:Yv-yYxFVvBr6pijY8QL5Xys3xyNQrOkfwGR8m57eXtSgumk--nZI4MF8dhtDgjkUrDuq2ABvNrnRCHuj8F6iT3BIZXY8aWcugnZgg4B1hgEhszCFbF5g2sZe8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeffgfdv
    ffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Yv-yY2TqLAX0ls4f_kvNeKTeriAdL-PwHjxwTLyV4OxUKD-QYuIhjw>
    <xmx:Yv-yY-xoKZfGe7uNeaGAt8dhGuKC72OfRokq8LAn2JqRVE2bWkk2ww>
    <xmx:Yv-yY85QXHNwU1m4ZnVlYLQD11IDi2rKhzUkPZ_xOW5rpWO5IzdyWw>
    <xmx:Y_-yYydsoXweit5-V2XVEMDHNoLlSHDnV9nP4LAd7ggmgcDLxIZRzw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 10:59:29 -0500 (EST)
Message-ID: <4207d4eb-31d5-31c0-1a7f-67ec00b63f58@sholland.org>
Date:   Mon, 2 Jan 2023 09:59:29 -0600
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
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 4/7] mtd: rawnand: sunxi: Fix ECC strength maximization
In-Reply-To: <20230102101132.66aa1a1d@xps-13>
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

On 1/2/23 03:11, Miquel Raynal wrote:
> Hi Samuel,
> 
> samuel@sholland.org wrote on Thu, 29 Dec 2022 12:15:23 -0600:
> 
>> This is already accounted for in the subtraction for OOB, since the BBM
>> overlaps the first OOB dword. With this change, the driver picks the
>> same ECC strength as the vendor driver.
>>
>> Fixes: 4796d8655915 ("mtd: nand: sunxi: Support ECC maximization")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/mtd/nand/raw/sunxi_nand.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
>> index 1bddeb1be66f..1ecf2cee343b 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>> @@ -1643,8 +1643,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>  		ecc->size = 1024;
>>  		nsectors = mtd->writesize / ecc->size;
>>  
>> -		/* Reserve 2 bytes for the BBM */
>> -		bytes = (mtd->oobsize - 2) / nsectors;
>> +		bytes = mtd->oobsize / nsectors;
> 
> I'm sorry but I don't think we can make this work. This change would
> break all existing users...

OK, it is not too much of an issue because I can manually specify the
ECC parameters in the devicetree. Do you think it makes sense to fix
this when adding new hardware variants/compatible strings?

Regards,
Samuel

