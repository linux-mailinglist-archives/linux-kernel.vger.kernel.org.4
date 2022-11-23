Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49289634FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiKWFnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKWFnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:43:07 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA35A13CE3;
        Tue, 22 Nov 2022 21:43:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 223C35C010A;
        Wed, 23 Nov 2022 00:43:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Nov 2022 00:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669182186; x=
        1669268586; bh=tSVppnYkpeXnvHJUaWTsGY07NlSPhzPn1JiOoH5/HyE=; b=D
        3eSJv+20H8TXCSPTvFOo/bOny1fv8RxplvzQVkb2/Izev6Oy84wT9DlLyFcpK4Bu
        x8Yrdp4r3DK88kGRuI/O905Uh2jSscSAsvhWHQznWg0fHnepnrt0leigEByh6tlv
        EJ2tVOM5NPQmLVW0h+ycQtIedE76znn7KcmDABXIZjSqLZY5A+ggryv3HhUmIwHE
        M10OkSqEuB+cFZibEP/bhDgn1JBD82cDdpwnfK0wmIZZnxxPq3nJxdrf12FAtXPZ
        2/WmsT9Jtg7vwJfbKXr/EY8IX37ndvBzLBxFUUXLYYRjprAb0J8DVc3mjtgUq07f
        vUM5d18tsXeX5OTaMW6tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669182186; x=
        1669268586; bh=tSVppnYkpeXnvHJUaWTsGY07NlSPhzPn1JiOoH5/HyE=; b=c
        9vHnGChIlGMiLqQBwDo7DCJUOF9wunu4vWnKXpcn1UCPdGh8W0E+NgcDeYmlhNx9
        rkHX0arpD+C8hcik6BlSpth6Go3v1PZC/H0Nz1cQNivWaoZgPVaNZITtL6Y+F6U8
        j0tqFrDfWR+Kdwm7cz11nWrZEhAs4UbBmaJ8twbWWOTQhmjat+BcFPo0VBSb8FC1
        rR38kJh657AecYfVB/5Mk6ukMgi/meDvmvDvLEMQ2w1012Ncp+Uy+ofjTZE8W+KY
        laPQ+oqHvkP/0ZC9hVFp18e/GI2zntt+rxtkmvsvxWSP7cWbBtx+5t1CGlmFnME6
        KHhONFZY6oikTUfUqgSXg==
X-ME-Sender: <xms:6bJ9Y3m-XQyW_cW19EF0O7_qSgwYBs78gcIFkmZOEvtLFK-ybK7Mbg>
    <xme:6bJ9Y63rjEr4m1DW9F5hobFuuR7BWw4SXQx-ahVEkqlN5DrPFLBTxbGKKXf4A9tX9
    oGwA-ISkycPysVRww>
X-ME-Received: <xmr:6bJ9Y9oemprdq9BqkxXaBkmpK3H8lQuomL0oD6G39wfSDt1bQWVprKsTOo5cTENRaMvclgl8N7Q-Groz_h2aT64mh01_Ipcm72IHtQsMyJRKfOcqkT9OepogFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:6bJ9Y_lqMg3jiaGs7hy7HpZRfc5co6xof8uTYu8XKCLGZTLHMJ9kBg>
    <xmx:6bJ9Y10GY7LEHQ-c-r5q1s5_6nbAfmI-kg3zXJmNBOfY7jjMejfSlQ>
    <xmx:6bJ9Y-vfg_AHIULqTZmNT0_ucgTU-gEurRoRsnaY54BKr-Q_pzj7hA>
    <xmx:6rJ9Y001uFlYr4G8WozL5W2N2KX3RNkMAw0Vr4dYKx3UD3j-IqK3zw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 00:43:04 -0500 (EST)
Message-ID: <2b329306-9706-7156-ad18-b87e4da666d9@sholland.org>
Date:   Tue, 22 Nov 2022 23:43:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com>
 <372e37bf-ac90-c371-ad9e-b9c18e1cc059@linaro.org>
 <CAK9=C2WjU+2cD7UZbja3TT++KCdRyWroT=50dw=fzi5mX30rcw@mail.gmail.com>
 <7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org>
 <CAAhSdy20p5bkVanKGkGyArn94hWJhwncztnX7U+4WkN9-v7NsA@mail.gmail.com>
 <Y3zjQXqEHsaoVVvf@wendy>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property
 riscv,timer-can-wake-cpu
In-Reply-To: <Y3zjQXqEHsaoVVvf@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 11/22/22 08:57, Conor Dooley wrote:
>> If we add a timer DT node now
>> then we have to deal with compatibility for existing platforms.
> 
> In terms of what to encode in a DT, and given the spec never says that
> the timer interrupt must arrive during suspend, we must assume, by
> default, that no timer events arrive during suspend.
> 
> We have a bunch of existing platforms that may (do?) get timer events
> during suspend, the opposite of the proposed default behaviour.
> 
> I'm trying to follow the line of reasoning but I fail to see how taking
> either the property or node approach allows us to maintain behaviour for
> exiting platforms that that do see timer events during suspend without
> adding *something* to the DT. No matter what we add, we've got some sort
> of backwards compatibility issue, right?

In the absence of bugs/limitations in Linux timer code (like the ones
you are seeing on PolarFire), the backwards compatibility issue with
setting C3STOP by default is that non-retentive idle states will be
ignored unless:
 1) the DT property is added (i.e. firmware upgrade), or
 2) some other timer driver is available.
No other behavior should be affected.

On the other hand, if C3STOP defaults to off, then the backwards
compatibility issue concerns platforms that can currently boot Linux,
but which cannot use cpuidle because they need the flag. If they were to
upgrade their firmware, and Linux is provided a DTB that includes both
idle states and the property, these platforms would unexpectedly fail to
boot. (They would enter an idle state and never wake up.)

Assuming no such platforms exist, then it would actually be better to
default C3STOP to off.

Now, this says nothing about how the property should be named -- we can
set C3STOP based on the absence of a property, just as easily as we can
clear C3STOP based on the presence of a property.

> I noted the above:
> 
>> Since, there is no dedicated timer node, we use CPU compatible string
>> for probing the per-CPU timer.
> 
> If we could rely on the cpu compatible why would we need to add a
> dt-property anyway? Forgive my naivety here, but is the timer event in
> suspend behaviour not a "core complex" level attribute rather than a
> something that can be consistently determined by the cpu compatible?

I do not support using either the CPU compatible (not specific enough)
or the board compatible (too many to list, but still not specific
enough). Consider that not all CPUs in a system may need this property.

> Either way, we need to figure out why enabling C3STOP is causing other
> timer issues even when we are not in some sort of sleep state & do
> something about that - or figure out some different way to communicate
> the behavioural differences.
> I would expect timers to continue working "normally" with the flag set,
> even if how they work is subtly different?

Definitely agree here. My intention was not to affect anything other
than cpuidle behavior.

> On a D1, with the C3STOP "feature" flag set, and it's custom timer
> implementation unused, how do timers behave?

D1 is uniprocessor, so I build with CONFIG_SMP=n. In this case,
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=n, and thus
__tick_broadcast_oneshot_control() returns -EBUSY, forcing
cpuidle_enter_state() to choose a retentive idle state.

Regards,
Samuel

