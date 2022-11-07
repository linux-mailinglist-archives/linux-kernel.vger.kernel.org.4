Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9F61F620
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKGOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiKGOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:33:52 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E286448
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:33:32 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 86B975C0176;
        Mon,  7 Nov 2022 09:33:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Nov 2022 09:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1667831610; x=
        1667918010; bh=BjJnberaFPu4tZv9skyQ3hu0t7GFddFpNxu474a2Huk=; b=e
        rlcKb7LuKGtVk7EOLWHf2CSMjy/mo5HYXjY2eyvC3KWafvHsEoyuwI6I0DP8rBq+
        ccqmtLctcUbqR09xJUeAQfojmTy4QJkjiymlboPiS3aBSBEGwrd/kloNkgHhHTOP
        O1sBBuYPgur4eYwfnYN1INwoDlMy/FplF50Yj2cvWXzti5l89gXp73OtJEUPUTZh
        ji7VypB667afJrnTcThRiW1El6wysDU7crsV6R79VLzs3ekksZRaCsQaE8awiAwM
        I1hRh8BIE4t3LJhvl6CrZqkPvKstHwuPp1EyT57aZHiPCi8MUt9zxnCHEFAPysDm
        XUZ39hSLv3t4AKF7K1D/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1667831610; x=
        1667918010; bh=BjJnberaFPu4tZv9skyQ3hu0t7GFddFpNxu474a2Huk=; b=f
        DIw4Kj9pJCHEsqbZDT5gjrT4rPnVMyT40y3XXRHe/0VlqxJPMvn8WpZGmylp/Ggs
        e/DeJVs2mrU/My2wH/GXqFIr8r4lumoJnJoocizqBQEyqOAYZtKUHPGfakXFHdHJ
        lvHFFK6357FIT7xA5Qu/rkTvnXnKsKhJkxoRl7imnd2Qo+8I/LppNliPT/o2TAhy
        7LStb3KXth9bAbXxFRX1gx+mpnCNG/rYVV6QVP6VW/0pNqg9wFg30TXGWnujX2lF
        nzk118vXWW93UQm/3uA+U+PAClCgtQ/wLuMUosioBOpcErfT4A+VS4ZA775vWhic
        LcDSpwsH02LX132pRFxrQ==
X-ME-Sender: <xms:ORdpY8KIty8crBmCcjBFGSZNne55ZaBK1KmxH37zPOoD_7X8lWbuTg>
    <xme:ORdpY8Ki0cx9pZ_XBCU5NdFH8kKhdvTfed4wVmaWH3SL8qWM3R87mK3xjom5D9glU
    Qdr1k1Y0x3PtFTSAQ>
X-ME-Received: <xmr:ORdpY8vwtMsuir4Wgx7nejUuTCZ7x1HrG_iEo_VkDikQBad7_ZP2yQlH8oGrzL4lkdghIj9jNEEUordyBkJ-ZH-hRt6SEff035CDFsh9DAzajGFwi7plqkSAqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ORdpY5ZUaJZ07-rfMmNRyNTmcA4OHd-lzi_4dWP-Y7v1UIRt3X2nEQ>
    <xmx:ORdpYzaM9hB17RmoSn8tyvgS-F6ZmLoN8NGkqSVQ2EoTYQvGvuEN5A>
    <xmx:ORdpY1DToFG2c9c1TuZaxvGRLbuljr44qpJQu8Mx90EabNNBGHP74w>
    <xmx:OhdpY-yBGdmeBY34Ymc_aXbcK6G_cqaKqcvRfLZdyMf7Yr0WyiQdAw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 09:33:28 -0500 (EST)
Message-ID: <0fe5680d-a41b-3c03-72a4-1a505788a9cc@sholland.org>
Date:   Mon, 7 Nov 2022 08:33:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] mfd: axp20x: Do not sleep in the power off handler
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20221105212909.6526-1-samuel@sholland.org>
 <a3488b0c-dbc7-0109-8ba7-9f319f018e22@collabora.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <a3488b0c-dbc7-0109-8ba7-9f319f018e22@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 16:40, Dmitry Osipenko wrote:
> On 11/6/22 00:29, Samuel Holland wrote:
>> Since commit 856c288b0039 ("ARM: Use do_kernel_power_off()"), the
>> function axp20x_power_off() now runs inside a RCU read-side critical
>> section, so it is not allowed to call msleep(). Use mdelay() instead.
>>
>> Fixes: 856c288b0039 ("ARM: Use do_kernel_power_off()")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/mfd/axp20x.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 88a212a8168c..880c41fa7021 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -842,7 +842,7 @@ static void axp20x_power_off(void)
>>  		     AXP20X_OFF);
>>  
>>  	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
>> -	msleep(500);
>> +	mdelay(500);
>>  }
>>  
>>  int axp20x_match_device(struct axp20x_dev *axp20x)
> 
> ARM was doing local_irq_disable() on power-off before
> do_kernel_power_off() was introduced, so this should've been incorrect
> for a couple years at least. If I'm not missing anything.

Yes, you're right. Then the correct tag is

Fixes: 179dc63d06c5 ("mfd: axp20x: Add a 500ms delay at the end of
axp20x_power_off")

Regards,
Samuel

