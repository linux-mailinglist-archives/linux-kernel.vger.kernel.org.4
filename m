Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379386D6014
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjDDMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjDDMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:25 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A6540CE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:15:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9965E5C01E3;
        Tue,  4 Apr 2023 08:15:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680610500; x=1680696900; bh=Wv
        8ql0abJxJ8xnDx5lNhrdAO5nFHGXeYUQxLiB9lAlc=; b=VZOtSINAo1a6pV9+Mg
        RHMH8wbrrb+hNskArarovQtm7H8HrTwT814596aRemvQiiDltlwkrxW5ZgNPFPEp
        E97vVn6hGO4wiY3iAw+2YatCb16kXrBPg6IZ3awdWghCuhUoeFK90zUqG6gWbxKv
        ydu5Gr6Imb33BtG2sB6/x/tmD6abUjnl9Gezk+DvmnvDs1tgBolm07JL57DSAlwa
        ot8iDjFzs5nUZIlV5gAPJsnSlL4xDAWqIrobxAKNkjA/wymlwYfTR06YUFAm6crb
        8SWpoT1/xzUqOeY6Auien3mceFek21SbT3/mXdhKxbsykpxhIAJVZ6Q10c0bLjKD
        v+Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680610500; x=1680696900; bh=Wv8ql0abJxJ8x
        nDx5lNhrdAO5nFHGXeYUQxLiB9lAlc=; b=Rg/rXIvoPf3VUhoUmlEEnsnRkLmXh
        MEUq2XKI4/tPW+GdOW7w26TATqc2YbZqRcfdb03vreP0RZg0c6Z6mMRtDrviPj9m
        MZRdZxqnrCl3DZy/3gdfyvgo9LInnmAi0LQu1FeryDcCAGtaPdB0CdH5hJvoiO7H
        DD1Bpc3jvWCTTPO1WZeHLZgd9PRaqju7yup/ihsZzK9jsN8JKSvt3OsOduM0/mSY
        T2Ti9wpmlhYJOb14p9gPGT8T7ZnngyyFTTjGmpLeC9jTfPrlx1c4qfo90sTiticZ
        VX9po1wQSqXsmImZKaadajIskyVhdZJUo5NyzHRP41gS0j2DctJav4R3g==
X-ME-Sender: <xms:xBQsZMUAMZlMm-ezA4c1yLvlIvI6OVkksbSuT9C47sMF5_XBh2vP5A>
    <xme:xBQsZAluIBTXb8NDEvtyuWTr33wjCD_VLmOfk9kVKLcdnw8sw_zMWfEPvYsWvWt2B
    pu92j36HMKYwmEqCIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xBQsZAZIV-roFBhEzXfNof7CPbhJgIMoBP1igwEauCAk_sVJ0OdKDA>
    <xmx:xBQsZLV6ShCIvLXXlD4y5RD9qBMm561mCUHtso1pqcby3WInB6VFQQ>
    <xmx:xBQsZGmhFCvb88q3kqX8bRPXIuafBoS9hpR0DesYdqGKbRZgq0fxSg>
    <xmx:xBQsZNv9Iwtly131HGI74x_T4BFLlFMJ-CPGKXbHZKU6-uT0mVQlzw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ED63DB60092; Tue,  4 Apr 2023 08:14:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <08b12571-5ca6-4e3d-8c56-5fc48827d17a@app.fastmail.com>
In-Reply-To: <076b5775-18eb-05b3-b803-c54420b3e5fe@kernel.org>
References: <20230404084259.13752-1-rogerq@kernel.org>
 <283f8f4c-9f8d-48b1-b161-3b712104583b@app.fastmail.com>
 <0ffa9690-9709-669c-b44d-dbb93446ec95@linaro.org>
 <076b5775-18eb-05b3-b803-c54420b3e5fe@kernel.org>
Date:   Tue, 04 Apr 2023 14:14:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Roger Quadros" <rogerq@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>,
        "Nishanth Menon" <nm@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: make USB_DWC3 as a module instead of
 built-in
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023, at 13:46, Roger Quadros wrote:
> On 04/04/2023 13:01, Krzysztof Kozlowski wrote:
>> On 04/04/2023 10:51, Arnd Bergmann wrote:
>>> On Tue, Apr 4, 2023, at 10:42, Roger Quadros wrote:
>>>> USB_DWC3 is not required for boot on most platforms make it
>>>> as a module instead of built-in.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>
>>> Does this save a significant amount of vmlinux size? Since this
>
> vmlinux size reduces by ~529KB

That seems really high, so I had a look at what's going on.

Testing this on multi_v7_defconfig with gcc-13, I only see
163KB difference in (uncompressed) vmlinux file size, or 140KB
in the output of 'size vmlinux'. This still seems high, and
looking more closely I find that a lot of that is for either
Gadget mode or debugfs, while the driver itself is not all
that big (most of the host logic is in the xhci driver).

Turning off gadget mode altogether would save 248KB
in 'size vmlinux' output, but would also prevent us
from enabling gadget driver modules, which is not great
either.

I tried setting CONFIG_USB_GADGET=m, but that makes
DWC3 and DWC2 host-only and turns CHIPIDEA into a loadable
module, so we probably don't want to do that either:

-CONFIG_USB_EHCI_HCD_OMAP=y
+CONFIG_USB_EHCI_HCD_OMAP=m
-CONFIG_USB_DWC3_DUAL_ROLE=y
+CONFIG_USB_DWC3_HOST=y
+CONFIG_USB_DWC2_HOST=y
-CONFIG_USB_DWC2_DUAL_ROLE=y
-CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA=m
-CONFIG_USB_ISP1761_UDC=y
-CONFIG_USB_ISP1760_DUAL_ROLE=y
+CONFIG_USB_ISP1760_HOST_ROLE=y

    Arnd
