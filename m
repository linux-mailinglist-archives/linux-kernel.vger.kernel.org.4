Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9917165AB0F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 19:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjAAS73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 13:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAAS72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 13:59:28 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71834DF9;
        Sun,  1 Jan 2023 10:59:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4CD3E32005C1;
        Sun,  1 Jan 2023 13:59:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 01 Jan 2023 13:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672599565; x=
        1672685965; bh=6xps2dz/8EfJzpJII3Hvk8cATnfAwucww7KtEbTc8vw=; b=N
        ykvKjPfmMFAk0fIhCWLOJXFEVizdp8Sh7XaFVQKrPIP9hCGMd9lbykXg2jz6S5zJ
        iGAnZY2jxo2f67M8PoDnFUSw92Q3D/8/XbfIp1AgdKqWhGoSEyp4eOAuVR+qpWfo
        mMKjZdXKf2PnTAc4Qyn9K12Yutf8AtzotuLkNXXO+BEWJU8f5aQt0a96YrvQmBAu
        vTVQnoqTgVEsr3FEEIzcNzKMxjaONoGtCIU2zFtRSCYxFu3C9jxoKixt0JQSwSZQ
        7uYr/62cDAOt7pjdtHIEvNU29F44zF/VEnnXPSweIjNjVZTz/ZcV0XjabqsmLoi9
        P8op2Sj7+VefEstbvUW+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672599565; x=
        1672685965; bh=6xps2dz/8EfJzpJII3Hvk8cATnfAwucww7KtEbTc8vw=; b=h
        D50QNLjWRQorQLn+KTWrLMexPU0oKhD34gfZSOXLt1IUjd8VqXvhqSTe7rh87338
        ZOIszlwWOGNxmWayv4ODvBotxGZSrg3wxyvKUEGwKhvBXobA9nGQN6L3x2oicCsY
        wEA6M8xtQ9KN/+3YmAGGeL8zUbyDv7q3hth50CQqA6exDPJsgpdx3FdF3OzUbi3V
        WR8w62KwNkNdl3izKjRjcWb6bLoeioAnat+pK0f4tdtyR0m8//kuCSwtaMftsTVH
        mEh/yK+0iEbzszDzwJKiXL3U473/izIMhWwNVbqv0FSI7W/ON+64sVdP+bDC3G5x
        tGxgaJkUnROMU823ZOvbw==
X-ME-Sender: <xms:DdixY4QO8U90nMDEtjNe8fCKM4UB-I4Ft3MWqLQcsAsOR7JAOk69xA>
    <xme:DdixY1ziU76yM7GiMNoKyto7ndztsH2FxJydfthqMK7BFeICw577_2clFtS-jah_7
    e90pR7QTXgGmX0-UA>
X-ME-Received: <xmr:DdixY11hRtNMne-rxo0xCl9yZ1BZtGHYfKYW0DdOKWgHqdC1TCPj8WNty11vALBAZoCNnkxftl8LzVqx7Lgu3qqIfwGRycqddkl-jgc9y2pL3lfSTukKWe7ONQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedtgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffvvehfufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhhfeggeduheeihedtkedutdegleduudelhfekheekvdetudev
    ieejudfhveejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:DdixY8BuEN1LsGmv3Yf2x8nEWKTbP45x7W-Zw4ajQx0S13PpqBOgdA>
    <xmx:DdixYxhsw7imkMVR9FfSwGcTJnY-rBeUD7k3Suqo4iGwpixuG3hcYA>
    <xmx:DdixY4oyWTUpnbkr44Pr27tJtowaywcfL2v8JfZQpEvQQH4cljl8TA>
    <xmx:DdixYyVbdGcIWXgBKrIaZoldH39EPeErr4ugNFt0iUoLed95oVc7UA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jan 2023 13:59:24 -0500 (EST)
Message-ID: <30171937-dfb5-4bba-23c1-607271c9a791@sholland.org>
Date:   Sun, 1 Jan 2023 12:59:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220814173656.11856-1-samuel@sholland.org>
 <20220814173656.11856-4-samuel@sholland.org>
 <20220825210252.GA1671168-robh@kernel.org>
 <68274f65-48f0-fe37-cefc-876d18e327e6@sholland.org>
Subject: Re: [PATCH 3/4] dt-bindings: nvmem: Allow bit offsets greater than a
 byte
In-Reply-To: <68274f65-48f0-fe37-cefc-876d18e327e6@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 22:29, Samuel Holland wrote:
> On 8/25/22 4:02 PM, Rob Herring wrote:
>> On Sun, Aug 14, 2022 at 12:36:54PM -0500, Samuel Holland wrote:
>>> Some NVMEM devices contain cells which do not start at a multiple of the
>>> device's stride. However, the "reg" property of a cell must be aligned
>>> to its provider device's stride.
>>
>> How is a DT author supposed to know this? 
> 
> To know the stride? They know the compatible string of the NVMEM provider
> device, and the stride is a property of the hardware.
> 
> To know that alignment to the stride is required? That's not documented in the
> binding. I can add that to the "reg" description in this file.
> 
>> I would lean toward it's the OS's problem to deal with (your option 1 I 
>> guess). I worry that one client could expect it one way and another 
>> client the other. Or folks making DT changes to 'fix' things.
> 
> After this binding change, the meaning of
> 
> 	reg = <0x2a 1>;
> 	bits = <0 8>; // optional
> 
> and
> 
> 	reg = <0x28 4>;
> 	bits = <16 8>;
> 
> would be identical.
> 
> With option 1, only the first representation would be valid in the DT.
> 
> With this series (option 2), either representation would validate in the DT, but
> only the second representation would be accepted by Linux for the driver in
> question (sunxi-sid).
> 
> With option 3, either representation would work in the DT and Linux.
> 
> Note that there is no restriction on the bit length, so the following are
> already equivalent today:
> 
> 	reg = <0x28 1>;
> 	bits = <0 8>; // optional
> 
> and
> 
> 	reg = <0x28 2>;
> 	bits = <0 8>;
> 
> So there are already multiple possible representations. I don't really think
> that is a problem, since the meaning is still unambiguous.

Does anyone have further thoughts on this?

From Rob's comment on the alignment being "the OS's problem", it sounds
like I should implement option 3 -- have the NVMEM core transform the
cell to match the driver's alignment/size requirements. Before I start
implementing it, does that sound workable?

Regards,
Samuel

>>> These cells can be represented in the DT using the "bits" property if
>>> that property allows offsets up to the full stride. 63 is chosen
>>> assuming that NVMEM devices will not have strides larger than 8 bytes.
>>>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>>
>>>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>> index 3bb349c634cb..4f440ab6a13c 100644
>>> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>>> @@ -53,7 +53,7 @@ patternProperties:
>>>          $ref: /schemas/types.yaml#/definitions/uint32-array
>>>          items:
>>>            - minimum: 0
>>> -            maximum: 7
>>> +            maximum: 63
>>>              description:
>>>                Offset in bit within the address range specified by reg.
>>>            - minimum: 1
>>> -- 
>>> 2.35.1
>>>
>>>
> 
> 

