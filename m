Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9D6291B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiKOGIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiKOGIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:08:19 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C0212AFE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:08:17 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 91894320097F;
        Tue, 15 Nov 2022 01:08:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 15 Nov 2022 01:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668492494; x=
        1668578894; bh=Tz11Z6ia+x7otJutyj0Fpgmjg+xKNAD2uW5mwHgcofc=; b=w
        TM4QT5DSa6ere0AJXFkETu6m14FuqQm2BXlm1VfEymQ09Ez40eXYyue5LHUQYHYe
        OggqvWcmXbxWNvwz3TbJRWUuwHNZbwijDP1wfnMRuURl3EACHRSozVR8vD7h+ajz
        qk8XSZWVuRJkqSZFbjVlDdK2pxcwl24BJ+mlyFkammkUOm92oVG6idwz/eIHxInK
        5IvW6xKw8HmYEjpFCTjeJwXOfXzDmd4gyT/DCj53XZIc28QtMa505NAlQswMV0Hs
        miOq2/b3wEqIno/hrObfbjFyYC/J3e9MbF3KwHtTGHYj22fV8j0pvf6g8WQkSvfe
        gVmjghiw7Hqprq1P+WBfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668492494; x=
        1668578894; bh=Tz11Z6ia+x7otJutyj0Fpgmjg+xKNAD2uW5mwHgcofc=; b=D
        JRI/bY8OD9bqbjme4ttMemHL8q3cIwAxz0oC8837OnXyDt8EBotsDYA8hrLze5tL
        hd2NOjHuxtrRQsNjTrU2q9rZ9Gozlvrp2QXh/GdRtKm403frR70//BLQO3SFv1Vj
        CLsuPJOCzUzVQKbLglGMzWSOqtpZB8WBH/fW7satGp2CjUi6xwSxymlr+IhPXIvC
        BCopKi+wlRccGkL66nkdf5rqRpZxOFUieBnUoWZbiQ8nmtENp/9sHMxEsH+sjj9h
        P/Y6KNC3OcILO9OsKtbKnmVsgmJCXK7txU6x2+/08rQ+hGsqL3az0dgEkzDZ5keb
        0TiqLIjykjanWJrBdtuIg==
X-ME-Sender: <xms:zSxzY6AlJuEp-HQk-T6h-gsgWnc2NYBV-4l90KObPQ43Xd8sTKz6Kg>
    <xme:zSxzY0jhgdqLt54mZZDRd0kmI6Vj_u5rhxPXR3w25N9I1Ua6YT9ka-zl_fxug2aue
    8ceQ4p7vTZJ407dmA>
X-ME-Received: <xmr:zSxzY9nzc8_W0YD1cneNKSVYTAZHbMGCqqwnuMd_IeqXuR2dnKgcGtk5jVL5LNVisy-qoVIFuECM5n1BfyRtg6Vt_9URiwPLRd1Yq_fyAMFtXKeNkbToZ_dynA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeefgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeffgfdv
    ffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:zSxzY4w1Y8Bu6la8yKMvy2NmQNNsDM8Oe_JGJ_aBYytcsORa4o5EFw>
    <xmx:zSxzY_RYrQ3Y_jtX-5ZaFgiMuMWufa13Bd1QgBoKHFYInXuwovZLhw>
    <xmx:zSxzYza0kKovqTJQZlsuSjOUX0IsfDw8r-jVLD8VxEpzcUGprmAZ8w>
    <xmx:zixzYwJxtr436QxNdJu2gMOQneQnBj8GINNC_QrURKQLqel7ZwLxOA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 01:08:13 -0500 (EST)
Message-ID: <735349b0-6738-8ace-a7d3-aafae2a62501@sholland.org>
Date:   Tue, 15 Nov 2022 00:08:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>
References: <20221114015749.28490-1-samuel@sholland.org>
 <20221114015749.28490-4-samuel@sholland.org>
 <2170633.72vocr9iq0@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 3/3] bus: sunxi-rsb: Clear interrupt status before each
 transfer
In-Reply-To: <2170633.72vocr9iq0@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 15:00, Jernej Škrabec wrote:
> Hi Samuel,
> 
> Dne ponedeljek, 14. november 2022 ob 02:57:49 CET je Samuel Holland 
> napisal(a):
>> Currently, the driver clears the interrupt status bits after anything
>> could have set them. However, this requires duplicating the same logic
>> in several places.
>>
>> Instead of clearing the status flags in the interrupt handler, disable
>> all further interrupts by clearing the RSB_CTRL_GLOBAL_INT_ENB bit.
> 
> where is this bit cleared?

It is cleared by any write to RSB_CTRL that does not include it. I noted
it below with the "disable interrupts" comments.

>> Then we can delay the status register write until the start of the next
>> transfer, so it only has to be done in one place.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> Changes in v3:
>>  - Add a patch refactoring how the status bits are cleared
>>
>>  drivers/bus/sunxi-rsb.c | 20 +++++---------------
>>  1 file changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
>> index 3aa91aed3bf7..cb622e60897b 100644
>> --- a/drivers/bus/sunxi-rsb.c
>> +++ b/drivers/bus/sunxi-rsb.c
>> @@ -279,6 +279,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>>
>>  	int_mask = RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER;
>>  	writel(int_mask, rsb->regs + RSB_INTE);
>> +	writel(int_mask, rsb->regs + RSB_INTS);
> 
> Wouldn't be better to clear status before enabling interrupts? Unless global 
> interrupt flag is cleared beforehand, but I don't see that anywhere.

Indeed the intention was that the global interrupt flag is cleared
beforehand, and only enabled on the next line below. However, I realize
I missed disabling it for the new atomic case.

I'm not so sure anymore that this patch is an improvement. What do you
think? I can send a v4 with a fix, or I am fine with skipping this
patch. I would at least like the other two to be merged for -fixes.

Regards,
Samuel

>>  	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
>>  	       rsb->regs + RSB_CTRL);
>>
>> @@ -286,7 +287,6 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>>  		timeout = readl_poll_timeout_atomic(rsb->regs + RSB_INTS,
>>  						    status, (status & int_mask),
>>  						    10, 100000);
>> -		writel(status, rsb->regs + RSB_INTS);
>>  	} else {
>>  		timeout = !wait_for_completion_io_timeout(&rsb-
>> complete,
>>  							  msecs_to_jiffies(100));
>> @@ -296,12 +296,9 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>>  	if (timeout) {
>>  		dev_dbg(rsb->dev, "RSB timeout\n");
>>
>> -		/* abort the transfer */
>> +		/* abort the transfer and disable interrupts */
>>  		writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
>>
>> -		/* clear any interrupt flags */
>> -		writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
>> -
>>  		return -ETIMEDOUT;
>>  	}
>>
>> @@ -503,15 +500,11 @@ EXPORT_SYMBOL_GPL(__devm_regmap_init_sunxi_rsb);
>>  static irqreturn_t sunxi_rsb_irq(int irq, void *dev_id)
>>  {
>>  	struct sunxi_rsb *rsb = dev_id;
>> -	u32 status;
>>
>> -	status = readl(rsb->regs + RSB_INTS);
>> -	rsb->status = status;
>> +	/* disable interrupts */
>> +	writel(0, rsb->regs + RSB_CTRL);
>>
>> -	/* Clear interrupts */
>> -	status &= (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
>> -		   RSB_INTS_TRANS_OVER);
>> -	writel(status, rsb->regs + RSB_INTS);
>> +	rsb->status = readl(rsb->regs + RSB_INTS);
>>
>>  	complete(&rsb->complete);
>>
>> @@ -532,9 +525,6 @@ static int sunxi_rsb_init_device_mode(struct sunxi_rsb
>> *rsb) if (reg & RSB_DMCR_DEVICE_START)
>>  		ret = -ETIMEDOUT;
>>
>> -	/* clear interrupt status bits */
>> -	writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
>> -
>>  	return ret;
>>  }

