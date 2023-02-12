Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7126A693A2E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBLVL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 16:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBLVL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:11:28 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490AC1115F;
        Sun, 12 Feb 2023 13:11:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B74E75C00C8;
        Sun, 12 Feb 2023 16:11:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 12 Feb 2023 16:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676236286; x=
        1676322686; bh=/BkqxOtXcZA548SCvbOvOHi/XeQIUpilhd0t/wMeQnw=; b=K
        uLKSf3DtAmqKfbtNpo3a5/dMq4CUYH5ZaBNBvGZA1tTwEKbZBMTD+h1i4s6Wi7Bq
        +YPYUjmGk7gHmHn+/GxrlwHlPUD6a6V0G5tC4Zgg0IelnvWWNqCcS1/5IoBroNGh
        l8vZyEp+XjPhsfOPflDUszUlzyCobhLnnoM34RMnsvIMfwgI0oI1X//wW/f0tXE+
        wUhIECoaOZ5jPe37BfMCEVrOg7IM77my2cL0sRp9g26m692yInvc6K+qzh2FXLF5
        qYkI6JnrjcOa+v1AlLYmqYTjPEi9sVosIgeltRRMl7NtC/mewJIgVQBYNMLOFxdi
        gnu68yDbaNXQ3lzFVeLSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676236286; x=
        1676322686; bh=/BkqxOtXcZA548SCvbOvOHi/XeQIUpilhd0t/wMeQnw=; b=t
        dyMqsPxMjdYBCd6+tf5abiJwml3YyRuaaTYNS8eaYPLB40W+Hfnxj0lsM+U0S1rP
        H+PG+VOtR2VVaCpwb4TJSNikPMorNEXjjQlndGrHhQie+wRCV2nDbbLtPwVpx5G0
        HNmiQnOpb924Bgu4WUrpnZP6YbABiDFQev0aXxomtQaWp+EpOzrL+KXjqnfsOrET
        HrYk/TcTQduUqhybRNzgKSF8W9JTAfh42c4tIpfYQ2mJau3/AKudxkS7BIhTmO2q
        3IzqDe6hLPATOuAG/6qKuRJwQa7HIGHvH2y0ccrX+YB+DiadsT3rl7HVy420337u
        audEIiyuJfqBauD1zcczw==
X-ME-Sender: <xms:_lXpYzo4W_Nusw_D-MqC7qm0oEifHbFeYQ9QhhZdud9xYteh2KqBnw>
    <xme:_lXpY9ooyfsqYfi-higT-B90WKZCIR5qd5-ETKFEh2kaWty9QP6nd475odrqqqm8Z
    pcmTk0uvjwbI_e3KA>
X-ME-Received: <xmr:_lXpYwOZspstzzVgcDwNBeb4cPeOqtxVQfs6oK_2PtfLswogagxArkhSw84yjaRQiO7vKYgwM1qkoMDLpvIiIThu5ZDWiXPpX1lcKk6O-EysGjAnX4P_5bnPAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeel
    leeftdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_lXpY25EK67y7TwH2JV97juE8-Xm2ORky6HYdO-MIKpRqb5BGSodHw>
    <xmx:_lXpYy67kr2yr-b7qlqTQonQyu_xm-iq1ipnUm2CB3M_MqDuTstdpQ>
    <xmx:_lXpY-ii837Mbw0K6D1bdwfkfl57GozFzzCncE7527-LBVTUlelg9Q>
    <xmx:_lXpY_sfT2ZU4WZiCZ8YiaUBpxnHDRFBniT5-X3QUGI9tad5o9p3Sg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Feb 2023 16:11:25 -0500 (EST)
Message-ID: <bfd6e869-dccf-bd00-d8fc-da2c33715c8d@sholland.org>
Date:   Sun, 12 Feb 2023 15:11:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] rtc: sun6i: Prevent an out-of-bounds read
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20221229184011.62925-1-samuel@sholland.org>
 <Y+V4iMaZ7WzCWzSc@mail.local>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <Y+V4iMaZ7WzCWzSc@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 16:49, Alexandre Belloni wrote:
> Hello,
> 
> What should I do with this series, I'm not sure you came to an
> agreement.
> Also, 2/2 doesn't apply so you'd have to rebase.

I will send v2 after the merge window, possibly including only patch 2.

Regards,
Samuel

> On 29/12/2022 12:40:10-0600, Samuel Holland wrote:
>> If there is more than one parent clock in the devicetree, the
>> driver sets .num_parents to a larger value than the number of array
>> elements, which causes an out-of-bounds read in the clock framework.
>>
>> Fix this by coercing the parent count to a Boolean value, like the
>> driver expects.
>>
>> Fixes: 3855c2c3e546 ("rtc: sun6i: Expose the 32kHz oscillator")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/rtc/rtc-sun6i.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
>> index ed5516089e9a..a22358a44e32 100644
>> --- a/drivers/rtc/rtc-sun6i.c
>> +++ b/drivers/rtc/rtc-sun6i.c
>> @@ -294,7 +294,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
>>  
>>  	init.parent_names = parents;
>>  	/* ... number of clock parents will be 1. */
>> -	init.num_parents = of_clk_get_parent_count(node) + 1;
>> +	init.num_parents = !!of_clk_get_parent_count(node) + 1;
>>  	of_property_read_string_index(node, "clock-output-names", 0,
>>  				      &init.name);
>>  
>> -- 
>> 2.37.4
>>
> 

