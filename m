Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD71B693A28
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBLVKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 16:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBLVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:10:01 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD693599;
        Sun, 12 Feb 2023 13:09:59 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E06F5C00F3;
        Sun, 12 Feb 2023 16:09:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 12 Feb 2023 16:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676236197; x=
        1676322597; bh=wfIsoUZApr8e7Lrxv9tsDnhqLEAta34iw5p74J+0dro=; b=I
        pqaPo89o17h5ShCwFokV3KO3nbd/Tu0y5bZIXy1N97AxKJkzwtFctzHh7cDx7hgB
        dfrmgLfDWObv52rA9X7IG37LfadGotBk0SEBWeBWx7crrk2N9nTmaCDYIvNYGRyk
        mOAAzF49elyqsiHmT1ab8to81Nh3GqVI1cvGFuXKUIiXjU2ahHdQuX1jVHnMQXSC
        chLCJ8KN08vtTQiySKVfOtR9IjIEKokf3GTA/OGx1w/cVApy4YlrzfEYbtS7BBn1
        mX9inXXHUINK/P/3G2Mm5SoAKIh3XBXMU+z5TCKdOG51bNaMSa2RsC2h3GUXCY51
        TXF8eaXyDUnjRrUbUzM7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676236197; x=
        1676322597; bh=wfIsoUZApr8e7Lrxv9tsDnhqLEAta34iw5p74J+0dro=; b=A
        d/QSMIKMeTm6RthhYcbbHK89QWRauvEz+g+iLZU8ug7jb9xNWfECxQtH6G7JwBQ2
        fkWQjy5GkzmofcNS45vfRmtMpljng6AyLm/hdVX5/U6uObeU5qfjlReEg15HtDbg
        zu3JOk8SKrtMv2QJb2EMbdRLnNadgX5hz8vY8FB2eXLADRZHF8MjcTwXFakAdJ2M
        +UgF/fYvlWppio63ybf4Tl6YIKxqM4nYC0vdncc5CWjtPs8aly4ZJ7CXTYmnXtVf
        BqpMZLzNlVoyGcYVCOAKFJbsCSp68x06o2IYEvSBWBaDxICjp/hovDx9dzuJNeVY
        rkTgsSjSg7wzTisB+wGIw==
X-ME-Sender: <xms:pFXpY5aC0xQYHmvMjnOvLczqk4r0Omu_zzUy3sFz7a9kFTc46xzODQ>
    <xme:pFXpYwZ6n6MaLKJKzg37aTmUxVnhc98Nx_9CjFq-xrrTQzFF-pPy76RTQNtGu-URr
    Wbo8ps40kbGV9JMoQ>
X-ME-Received: <xmr:pFXpY7-wcJsB66SmW8ddFzW5iQSRuAm5b-1a7Ydu4ELIAdYiw28_ueobixo429rjCTWxC7YLwfOMhed21xUiVG258pAh3DlIVELqa6wCKg7iLVW133ZzDJW1Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeff
    gfdvffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:pFXpY3pHvkQI4KQG3B2GKBpzHU81GyEbOOaVZVk11OQHc9fdpJdnWg>
    <xmx:pFXpY0rP9yWWLZYVnt8JwMXGwCU1KGS-jB2fDYF--m-ObwT38w9HMQ>
    <xmx:pFXpY9Ra3pPSIw4Yrp85jwILx-Vuu-lWagciTlGtvd9SCMZHMiEUgg>
    <xmx:pVXpY1e5Hgiy9QI_JLQZQEBOvPpQPlcKO9r_tZ4vOo3fiTAVZBo0NQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Feb 2023 16:09:55 -0500 (EST)
Message-ID: <90760cb1-81b2-ad83-0c62-f1c8180b0c0f@sholland.org>
Date:   Sun, 12 Feb 2023 15:10:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20221229184011.62925-1-samuel@sholland.org>
 <8201852.NyiUUSuA9g@jernej-laptop>
 <5c20af59-5fb5-8f7d-f6af-2b3984d79595@sholland.org>
 <4834080.31r3eYUQgx@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] rtc: sun6i: Prevent an out-of-bounds read
In-Reply-To: <4834080.31r3eYUQgx@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On 1/8/23 13:39, Jernej Škrabec wrote:
> Dne sobota, 07. januar 2023 ob 18:15:47 CET je Samuel Holland napisal(a):
>> On 1/5/23 11:26, Jernej Škrabec wrote:
>>> Dne četrtek, 29. december 2022 ob 19:40:10 CET je Samuel Holland napisal(a):
>>>> If there is more than one parent clock in the devicetree, the
>>>> driver sets .num_parents to a larger value than the number of array
>>>> elements, which causes an out-of-bounds read in the clock framework.
>>>
>>> Is there any DT with more than one parent? I think more fixes are needed
>>> if
>>> this is the case.
>>
>> H616 and newer expect more than one parent, to accurately represent the
>> RTC clock tree, but they use the CCU driver instead of this code.
> 
> If I understand that correctly, second clock would be 24 MHz crystal? In any 

That is correct.

> case, if multiple parents are possible, check needs to be added to see if 
> parent clocks include 32 kHz clock or not.

Right, if we allow other clock inputs, we need to check specifically for
"ext-osc32k", or a single clock input without clock-names, not just the
presence of the clocks property. (A hypothetical new binding would have
to require clock-names even for a single clock to distinguish the old
binding with only "ext-osc32k" from the new binding with only "hosc".)

>> This bug is preventing us from relaxing `maxItems` in the binding for H6
>> and older SoCs, even if Linux does not use the additional parent clocks.
>> I want to fix this bug now, to give us the option (if beneficial) of
>> relaxing the binding in the long-term future.
> 
> I wouldn't call it a bug, since it works just fine for currently defined 
> binding. Do you have DT binding change in pipeline?

This would be a far future change, so as to not break the "old kernel +
new DT" scenario. Maybe it's not even worth doing. But I really don't
like the unbounded assignment to num_parents here.

Regards,
Samuel

>>>> Fix this by coercing the parent count to a Boolean value, like the
>>>> driver expects.
>>>>
>>>> Fixes: 3855c2c3e546 ("rtc: sun6i: Expose the 32kHz oscillator")
>>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>>> ---
>>>>
>>>>  drivers/rtc/rtc-sun6i.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
>>>> index ed5516089e9a..a22358a44e32 100644
>>>> --- a/drivers/rtc/rtc-sun6i.c
>>>> +++ b/drivers/rtc/rtc-sun6i.c
>>>> @@ -294,7 +294,7 @@ static void __init sun6i_rtc_clk_init(struct
>>>> device_node *node,
>>>>
>>>>  	init.parent_names = parents;
>>>>  	/* ... number of clock parents will be 1. */
>>>>
>>>> -	init.num_parents = of_clk_get_parent_count(node) + 1;
>>>> +	init.num_parents = !!of_clk_get_parent_count(node) + 1;
>>>>
>>>>  	of_property_read_string_index(node, "clock-output-names", 0,
>>>>  	
>>>>  				      &init.name);

