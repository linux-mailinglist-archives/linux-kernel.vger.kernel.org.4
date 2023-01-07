Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4566105F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjAGRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:15:55 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4083327190;
        Sat,  7 Jan 2023 09:15:52 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B14895C00E7;
        Sat,  7 Jan 2023 12:15:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 07 Jan 2023 12:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1673111749; x=
        1673198149; bh=pVAVln8jiL3s0HnVxaXSDqHWt311rVoxDwijHRxLD+c=; b=V
        NsHgHX7lAmWWw/ST0jf+ZWstVsi6EIUwqO6T6R80Yrrhtqb7TQbmm4POeCrTqF+I
        SdKpNu0f6v6scNrXKQeBvm1XS5vcvy0LK8kaAj+q8oyEJjD8rPMJ13PFjuvQrE0H
        /oWshcIgmKH9LYxzqJo+hKQOp3Gxtby2pvqeQcbk2UIsxSBvU6O299D9aFDvFvzh
        rV6CDasSh0RJaAKedrWXgBZ6cCChmqJAohAP7N/boOT2jhkBa3cbnJKJK/iMiVgX
        gNuwYqf5U4nnm0E/JxRMkeDtwkQX1Mm9d5UrLlHW5ok3OpaZ9aOwiLRUKVXPx6q2
        Qr0HATYGJqeYHUI8K/2Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1673111749; x=
        1673198149; bh=pVAVln8jiL3s0HnVxaXSDqHWt311rVoxDwijHRxLD+c=; b=n
        1uZ8GPTCRKMlSsbD4Z493R9pXcNFUMbVNFeP1OxQ6WoRcVgtpoJM1edZl9Fx3jR5
        8Qa0zbpBBRfyMrXhmzOjBNBBLiUprZgtmVhhHDdyv40dqzGh/n3H6zCSDuoqcoXQ
        O0kpSEbv5uUI51+fnsdwMnItYrqt+mBfrwv1gCqxG4ZIdfmy8UVttm9OR734xAeh
        FTsIEGkE4T4mRmkN4Prj3sn9CNjQi0P2eOa8pe3ECQhM7Ovu9mt6kafPbI6ah6NC
        QAHZL7dVydOKvhG+KHAMgMyKjRcdACQW0Z9YaS5F+AygovwAX2LiMJq36edMl9lh
        q0oBYEwOANeiD0H4Mz2EA==
X-ME-Sender: <xms:xKi5YyDd05-IPJUEuhbV1RgmXwoucsGE8cccQSk7_l5EW3I1PkS7hg>
    <xme:xKi5Y8gCVkcTNXEEsIWY_xvdNrNxBV92eaDtctIj7zcRF1B1EhnRhAR_Tfd5ulmD9
    lpal3EJ_YSosKcmVQ>
X-ME-Received: <xmr:xKi5Y1k3351369-b5MN3DsFfRRrYjxqQX1m6FQC-co3XVc2zkTq-jzj_QeDjPef3_-yxbNQMIqZDnpVDNa5spXoPhGQYjxoYH3J6JSazOoz5hbYZ9Q9dxJUcKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkedvgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeffgfdv
    ffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:xai5Ywzzszzkbran3aMMuqeQ_AFD6dkkwkYd5mS0tMWqCAbxLmi44Q>
    <xmx:xai5Y3QITzhfxpdhMw1ZwveWkLFr2S9gcx_CQle8nfJzoUoPlRNKzA>
    <xmx:xai5Y7ZtFd9mRx5VsUidyajAZVV9-W3UdfgoO2M8K0gexk6v1c5CBw>
    <xmx:xai5Y2HKchong3Y_c8retkkTfYqkN_JaJbDyOeubSBlsLSks9fCXjA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Jan 2023 12:15:48 -0500 (EST)
Message-ID: <5c20af59-5fb5-8f7d-f6af-2b3984d79595@sholland.org>
Date:   Sat, 7 Jan 2023 11:15:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20221229184011.62925-1-samuel@sholland.org>
 <8201852.NyiUUSuA9g@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] rtc: sun6i: Prevent an out-of-bounds read
In-Reply-To: <8201852.NyiUUSuA9g@jernej-laptop>
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

Hi Jernej,

On 1/5/23 11:26, Jernej Škrabec wrote:
> Dne četrtek, 29. december 2022 ob 19:40:10 CET je Samuel Holland napisal(a):
>> If there is more than one parent clock in the devicetree, the
>> driver sets .num_parents to a larger value than the number of array
>> elements, which causes an out-of-bounds read in the clock framework.
> 
> Is there any DT with more than one parent? I think more fixes are needed if 
> this is the case.

H616 and newer expect more than one parent, to accurately represent the
RTC clock tree, but they use the CCU driver instead of this code.

This bug is preventing us from relaxing `maxItems` in the binding for H6
and older SoCs, even if Linux does not use the additional parent clocks.
I want to fix this bug now, to give us the option (if beneficial) of
relaxing the binding in the long-term future.

Regards,
Samuel

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
>> @@ -294,7 +294,7 @@ static void __init sun6i_rtc_clk_init(struct device_node
>> *node,
>>
>>  	init.parent_names = parents;
>>  	/* ... number of clock parents will be 1. */
>> -	init.num_parents = of_clk_get_parent_count(node) + 1;
>> +	init.num_parents = !!of_clk_get_parent_count(node) + 1;
>>  	of_property_read_string_index(node, "clock-output-names", 0,
>>  				      &init.name);
> 
> 
> 
> 

