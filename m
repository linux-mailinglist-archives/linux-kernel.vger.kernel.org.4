Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48E16C9F29
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjC0JQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjC0JQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:16:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCADC4225;
        Mon, 27 Mar 2023 02:16:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7C972320084E;
        Mon, 27 Mar 2023 05:15:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 Mar 2023 05:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679908558; x=1679994958; bh=D6nNTX0D5vA8BTdg4fTxXWIrP7TJxRhrZG5
        DkHgHPUg=; b=xtrmlM7g2RJAHTuKggOp5ZHWRHpVyMfcrp51M5bzZsy/VHub+pQ
        6NelFxmwu8mtsa2Eu8ApG1q1zQFRz2NiDpwk6Myir+kwXjRRUJTudTTXtHWJBgtp
        aIOCFM9Xr787C9guxF5Nl+5LWyjwuiva9X1x5xBqDZlDOxRQomp2RbHE6HRmPaDH
        gJ++tJ7ecDEpakLxaNH5HSB3l91PaMl9i2VK4V9DasBOPk+ohUEDZGdGozeHjgG6
        Kr58jBv6EUNQJi3bLeCIKKSuaeztqfLXFt1zss1u3TdGSV3+398W2I5cfE1Mjsg5
        7Ow9WVpxacIXsjIfMq9rcVaVA0icOjptzBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679908558; x=1679994958; bh=D6nNTX0D5vA8BTdg4fTxXWIrP7TJxRhrZG5
        DkHgHPUg=; b=PrCIB5DaJ5Uk2W4j7BZy5R2DKTH2qEMbrxjWnBuybRd1664L6Sa
        23kddC4HZG7yS8WC4UiplJ8TmdwCrWi9k9vsUqygUliJ4tccNtVSAvIblrUH2GxP
        9lqZqRrQnMEFOqlja/V3oKSVOeJjAcLKZXJrV8hRxwrjqkZ3dKTwzaF9pVJJfHkG
        /2BR74WXrfNsKmTRSfQAsxjEqWmydeuubRR8+oSUHZG1onyUwmIAVSBxwG9wcGl0
        m6twyVF+66FSjBX574irZvLJnMbLUnyTCjU/4tGcpi6tG09aGSuPskdqCZ12p+3q
        TDkGAo0JfgIopXTFZaSpR3tkZRHjBCBTH2g==
X-ME-Sender: <xms:zV4hZIzXDzL8l2mpKbZ4ovrjVUvtwNT7xn9f2Mat2TlfS92DUgxplA>
    <xme:zV4hZMSqbPEknmMfyLntnJE5VT2_9acM6mLj6g0MVnqsFs6bc-DXkWf95gpSWVA1z
    3lprJ4VN2qvcMbK-CU>
X-ME-Received: <xmr:zV4hZKUlwchIbJy78drih0SQLDc4uR7znloBHrkoEvGzmUT2Rp1T7R48uo9w_0w4DW9q8F95blxHcScmzce0cyGgrysX8Q5mUTNJaVMtyjn0rf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflrghr
    rhgrhhcuoehkvghrnhgvlhesuhhnuggvfhdrthhoohhlsheqnecuggftrfgrthhtvghrnh
    epgefgjedtudfgueejfeegueeiieduleetueekfffhieekudduvedtvdfhtdejudehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesuhhnuggvfhdrthhoohhlsh
X-ME-Proxy: <xmx:zV4hZGixDhEOULIQDyZHTYzCpDp1qmdBa_Je3oIliNz5bE2xoLunow>
    <xmx:zV4hZKC9yG4LHpW1vq5q28f9m3pTAqBwdClCQRTkYE4vs49YGDEyiw>
    <xmx:zV4hZHIZPZYaU0wFfc8eNeFoWx_E3iRlPfXgxTQBatpElHXDmAiFEw>
    <xmx:zl4hZAQ6JOqRC8BOM_KivVUxpOH-UzQqfuZVZLsHNnOsTOVWBxTnqw>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 05:15:52 -0400 (EDT)
Message-ID: <40e61776-bcdd-25ac-286a-1ba0184dbd7e@undef.tools>
Date:   Mon, 27 Mar 2023 20:15:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal display
 support
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230327074136.1459212-1-javierm@redhat.com>
 <e4f82c1e-621e-7e94-497d-8c579264f996@undef.tools> <8197476.T7Z3S40VBb@diego>
From:   Jarrah <kernel@undef.tools>
In-Reply-To: <8197476.T7Z3S40VBb@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/23 20:11, Heiko Stübner wrote:
> Am Montag, 27. März 2023, 09:55:15 CEST schrieb Jarrah:
>> Hi Javier,
>>
>> On 3/27/23 18:41, Javier Martinez Canillas wrote:
>>> From: Ondrej Jirman <megi@xff.cz>
>>>
>>> The phone's display is using a Hannstar LCD panel. Support it by adding a
>>> panel DT node and all needed nodes (backlight, MIPI DSI, regulators, etc).
>>>
>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>> Co-developed-by: Martijn Braam <martijn@brixit.nl>
>>> Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Drop touchscreen node because used the wrong compatible (Ondrej Jirman).
>>
>> Any reason not to include this with the correct compatible string? It's
>> been available since
>> https://lore.kernel.org/all/20220813043821.9981-1-kernel@undef.tools/.
>> Swapping out gt917s for gt1158 in the node from your previous patch
>> should be enough.
> Just wondering if I'm blind, Javier's patch doesn't contain any touchscreen
> controller (haven't found neither gt9* or gt11* mentioned there), so
> I'm inclined to go with the "touchscreen can be added later" thing.


I was just commenting on the "Changes in v2" section. v1 had a 
touchscreen node in it (assuming I found the right v1).


All good, I can follow up with a patch for the touchscreen.

