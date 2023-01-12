Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DFD667A61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjALQLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjALQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:10:36 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E24C4FD7F;
        Thu, 12 Jan 2023 08:02:05 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 47D9932005C1;
        Thu, 12 Jan 2023 11:02:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 11:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673539323; x=1673625723; bh=pEfXWj7Hu9
        k28i5iZXZlWlRGQSSC88B7IqFY+vWRaj4=; b=a7U9YhqWwE+6Qdb0hFY5GwRwlY
        VDsudE3O3WkylT+2O87N0XbgdHchHtOMk62lC+TB1Nm9Zp3C+1mbJ1vauIZH1/J2
        mx2oNGb/+0rTIDENI9e/SbOaS6FqyTKQXCRtCfIX71w7O6DLjgPTfpSsOGrQm0eL
        RI33cPw3cWaTfmEgg9mZU7C1RVfXfSelyT/1/V7cDr2IOEEZwfzCscKEtnet+P/t
        UHsUDM8EwaibW4+33ZDzGxNkHtK/sOYVWrYQWO8htC8ZjfSjnUXmAO1cNklasx/0
        NmTCtckV5bGaKvUxBXLEpxe5rHz74fmzo2mSDqOarNwg1C1K8R4aAHbIRphg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673539323; x=1673625723; bh=pEfXWj7Hu9k28i5iZXZlWlRGQSSC
        88B7IqFY+vWRaj4=; b=RiNhHbz3B5Z+87FR6SiDXQ0VQF+omSLU2y0oui814ZRQ
        1MOW6Ryj4EZXXseMjLwEEIvRRzlXZuj4VnMe822LxVODTBU2yUr8JUpDUtFDZEAF
        +PxtDxgCEfKtWKpuVmeADW6LmWP3VOrzdcA6p8B/aUoNWwXv995yjWr9MotrNmvC
        tNKOYnE9MpqJqJVBOZ9u+NYTT+icUH2Mc5Jbgssx6VvtkpJmbS0p0+Mi0d4a7HdN
        3ziekxEuPMtJiNbm6tPNfRpZFgmCSV+rz0I7Z2AcTezMJjTdi4eU1gxWcG049nBj
        cawUgFc1VWUlT0zO9h3CeKoE5cE+ozce8yR0MoHOHA==
X-ME-Sender: <xms:-i7AYwjcH0b8JgIuQkkla8dOAS_ZXu3VtOZ8T3JEh4rTDcRxB61nFQ>
    <xme:-i7AY5D7lYoQhhRJSA2FbZIhtNDjYmkois15jfO4y4L4priJfqPaZPacPPobpAnRi
    B1Tacb5G-Xk4dXrSAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:-y7AY4HU_4EGMtzvXZArVkKSku1EJ2_ZHcend_YSubnmrs1J_5_21w>
    <xmx:-y7AYxTNqDzg7AI6GkN0vKDCiBkGNGmLZCYbjz6KG2MIaeY4pRH58w>
    <xmx:-y7AY9wN0x54F61K--9UBOWVixlkIduCt5vO7Y19Jj2YOnSrStEJRw>
    <xmx:-y7AYyrPyNGbG3GqJDvGMk4QXJsPCExmfFhVQLKfdpfpdBgdf5yzpg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EC407B60086; Thu, 12 Jan 2023 11:02:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <6bae68eb-866f-4b78-b4db-e3154feec28e@app.fastmail.com>
In-Reply-To: <E2B35D8A-B8A6-40C1-8AC9-46E6C2CAE656@hpe.com>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-4-nick.hawkins@hpe.com>
 <5ad677f3-2cbc-4ba0-bd48-2f832a72fb28@app.fastmail.com>
 <E2B35D8A-B8A6-40C1-8AC9-46E6C2CAE656@hpe.com>
Date:   Thu, 12 Jan 2023 17:00:52 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Jean Delvare" <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Russell King" <linux@armlinux.org.uk>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 3/5] ARM: dts: add GXP Support for fans and SPI
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023, at 16:40, Hawkins, Nick wrote:
>> > - ahb@c0000000 {
>> > + ahb@80000000 {
>> > compatible = "simple-bus";
>> > #address-cells = <1>;
>> > #size-cells = <1>;
>> > - ranges = <0x0 0xc0000000 0x30000000>;
>> > + ranges = <0x0 0x80000000 0xf000000>, /* 0x80000000 - 0x8f000000 */
>> > + <0x40000000 0xc0000000 0x7fffffff>; /* 0xc0000000 - 0xffffffff */
>
>
>> I'm a bit confused by the change in the mappings: are you
>> sure this all the same ahb bus and not two separate buses?
>
> Yes this is the same bus, however we are not including all of
> it as it maps some host registers that we do not want to access
> at this time. 

If the two ranges are actually translated separately on the
bus, you could also decide to enumerate the translations with
a 64-bit local address and make the upper word an enumeration,
such as

ranges = <0x1 0x0 0x80000000 0xf000000>,
         <0x2 0x0 0xc0000000 0x30000000>;

then you get small numbers again in the 'reg' properties
that are easier to read and ideally match the bus-local
numbers from the hardware manual.

>> The comment for the second range looks wrong to me, as
>> you define a 2GB (minus one byte) sized mapping but the
>> comment only lists a 1GB (including the last byte) mapping.
>
>
>> I would expect that the original 0x30000000 (including the
>> last byte) was correct here.
>
> Yes this was incorrect, I believe it should be:
>
> ranges = <0x0 0x80000000 0xf000000>, /* 0x80000000 - 0x8f000000 */
>                 <0x40000000 0xc0000000 0x3fffffff>; /* 0xc0000000 - 
> 0xffffffff */
>
> I will create a v5 version of this patchset with just this and the
> defconfig for your review.

Now it almost matches, except for the final byte, as the
range actually ends at 0xfffffffe not 0xffffffff if you make
the size one byte less than 1GB.

Is there a special register in the last byte?

>> > - vic1: interrupt-controller@80f00000 {
>> > + vic1: interrupt-controller@f00000 { /* 0x80f00000 */
>
>
>> This is not the same address as before. I'm also not sure the
>> comment is helpful here.
>
> My understanding was that the physical address would be the
> 0x80000000 from the first range plus the 0xf00000 to be
> 0x80f00000?

I suppose the physical address in the old mapping was actually
outside of the 0xc0000000-0xefffffff range, so it wasn't
even accessible. If the addresses are interpreted to wrap around
at the end of the mapping, that would have made the CPU visible
address 0xe0f00000 (0xc0000000 + (0x80f00000 % 0x30000000)).
If it just wrapped around as a 32-bit number, it would be
0x40f00000 ((0xc0000000 + 0x80f00000)% 0x100000000), but I
don't see you you'd get to 80f00000.

      Arnd
