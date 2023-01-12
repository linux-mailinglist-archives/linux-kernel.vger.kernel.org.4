Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A568E668667
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbjALWIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjALWH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:07:26 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37A167F6;
        Thu, 12 Jan 2023 13:57:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9D9BC320046F;
        Thu, 12 Jan 2023 16:57:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 16:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673560655; x=1673647055; bh=s7tq5Dt4vQ
        7KWmnlphnVVetcWhkbTgMUgBJi8a3V96c=; b=FH6VjcMHfmIaUgUjinAiyozgq8
        CuO4EN2FoQdMnf0Q5EWOYzUaiyrRSEYyG7eW/dY4OfmjlsNMfIlDJ///YxWBVAt8
        4lvsHRxNWPTvvcnFtw86rsh78eLG5wwreZzZUOrtxqKUnP6+JLHGhHHC+J41/GpY
        +pI7OKaf2wODzjjvvwBl3mqXq5JVtQFPLJuLHjJJNtd2ND9u/J6E2ThNKYRnnh0G
        sdIh5VxpF0MKNlBp+WvKpq9waN1HAZGrCYSeq/2CDgzziGkFo0pF075JN0H/0fMI
        Z7weZIAWaWdhVyr3ZYHSdpMUVpgoS40kkW+GnBSK3ucJyUj7cfoiOfizWr0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673560655; x=1673647055; bh=s7tq5Dt4vQ7KWmnlphnVVetcWhkb
        TgMUgBJi8a3V96c=; b=pgK/1suD/fOcIK9hUgjbK/lN103NpjOTTIAlUO7mr97V
        W7cdmlDu3tBreLzMVCuY2UnlnmpRw1qdawNFdwtK1IhYD3l2e8q85DwZaS6wNHBU
        VRZHXixN2lyT09ohcuECYWZpgF7Sb7TQNbMTs7STcKrS/KWOAxY+jG9sqWiktHwb
        BjuxPy9pwLTHFujXcO62FyFi/+t+gk1B1W0SYpQtke+194l/PjgkzxCfScl4yFkl
        84c5WVD0p9YA7bjZ9tifo0drq8RFyxGn00QTmegdKoEUJ/64bGJlWM7GKMttASNo
        wDFESfuC1d34YAi+69p6duDAZQdx1A08Nq3KTKsbnQ==
X-ME-Sender: <xms:ToLAYxtx37Ut_RzsJ0g9MwqnR0nad8zwCw8Q5RpVqVOjqkgqJeSUzg>
    <xme:ToLAY6eGmyYyM96mn7oYYGEB37mbzTDwdydauWs39Aj_NgYp3w1RYHQDBuHGIaxx1
    8v-8DUDie0AEDBBbAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ToLAY0y3hhaW1ftV0i3rRGGYWWAbLAPeLqPHnQFzpHMf3Gdn_QmazA>
    <xmx:ToLAY4O__cbsHDj-StOiBvhgX6i8Hd_QAjnlhcf9EmDKPIWkgvNx0g>
    <xmx:ToLAYx8BIhfcW-8c1FHPoxWnfgH6UXYBGdjnPo_vMibcwkcKPDnMxg>
    <xmx:T4LAYy0ZF9YYoaIct6NKe7XqSlK7_fR-wYyCGzAiSuZIdpiwGj8lVQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8C0F7B60086; Thu, 12 Jan 2023 16:57:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <83f5fc9f-4b46-4ac4-ba65-455d0aaaed88@app.fastmail.com>
In-Reply-To: <1E4BFECB-D29A-43CE-A521-F2A81939202F@hpe.com>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-4-nick.hawkins@hpe.com>
 <5ad677f3-2cbc-4ba0-bd48-2f832a72fb28@app.fastmail.com>
 <E2B35D8A-B8A6-40C1-8AC9-46E6C2CAE656@hpe.com>
 <6bae68eb-866f-4b78-b4db-e3154feec28e@app.fastmail.com>
 <1E4BFECB-D29A-43CE-A521-F2A81939202F@hpe.com>
Date:   Thu, 12 Jan 2023 22:57:13 +0100
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

On Thu, Jan 12, 2023, at 20:58, Hawkins, Nick wrote:

> The updated section of the device tree will be:
>
> ahb@80000000 {
>                         compatible = "simple-bus";
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges = <0x0 0x80000000 0xf000000>, /* 
> 0x80000000 - 0x8f000000 */
>                                  <0x40000000 0xc0000000 0x40000000>; /* 
> 0xc0000000 - 0xffffffff */
>                         dma-ranges;

Ok

>
>                       ...
>
>                        vic0: interrupt-controller@4eff0000 { /* 0xceff0000 */
>                                 compatible = "arm,pl192-vic";
>                                 reg = <0x4eff0000 0x1000>;
>                                 interrupt-controller;
>                                 #interrupt-cells = <1>;
>                         };
>
>                         vic1: interrupt-controller@f00000 { /* 0x80f00000 */
>                                 compatible = "arm,pl192-vic";
>                                 reg = <0xf00000 0x1000>;
>                                 interrupt-controller;
>                                 #interrupt-cells = <1>;
>                         };

I still don't see the value of the /* 0x80f00000 */ comments,
you should define the ranges to the most sensible mapping
based on the datasheet so you don't need the comments.

If the datasheet uses a bus-local address (0xf00000), then
just get rid of the comment, since that only adds confusion.
OTOH if the 0x80f00000 number is what is in the datasheet,
then adjust the ranges to do a 1:1 mapping of the registers
on the bus and use that address directly.

      Arnd
