Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8866C3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjAPPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjAPPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:21:49 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C943F1EFE3;
        Mon, 16 Jan 2023 07:19:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B82B35C01D1;
        Mon, 16 Jan 2023 10:19:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 16 Jan 2023 10:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673882359; x=1673968759; bh=N2AaqpF3HW
        MCVXZ2qUPffZma9rjZbSafx8M41yLmuoE=; b=jHj/gDQGNBpfYh0yCyZRtlXclm
        ueThgrKdnuCdyJROmmqJVs6lW2kLgffXl6PYuqJfF1RBj70yqhA3tx4Ref9hc1PT
        DNVjtiQNkycJDb3OF4zN7AFfYtsOOAPI9lma+4vvaRzK7WegrNxshPqRgA8/Ulo5
        iOohCEiDC36NdhQk2xF+hrZjr0pTWvz8RJeQpaEWoYdr5gQiThcsfA6JYNBNQhMy
        SBt/gEIncnUX66ysNEYo4gQufb4lfXw+b0lkT2qk3/h2FtakuDtmVmn8ZDk79djx
        CRC8t+5Bk0DkjYs7swPM1kzJ8i4U9us/VwnmPpI9kUAdqI1Yu8Bzj4ELT/WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673882359; x=1673968759; bh=N2AaqpF3HWMCVXZ2qUPffZma9rjZ
        bSafx8M41yLmuoE=; b=I33uRZ+2TxBvz+HDJrERzoGN8v/hpeQGeyNS1upZxtwv
        70WFNq/uW4axz/MT2Ju0pIbR5XlYi9pC6JTVfNvfCFErCPiRRHGz2fuMa6tO9t69
        XAI6zTJd3FZLzRqSQgb3tAI/PLB7z8jDg2iZdTgdKQzrB89UK0JYOiFA9cpDtPgy
        ojbOthdU36Kgq5pYirKmzAWRjFQ6WnWPSgq5Hpr1trHyyAHl35L9Q6Gp21fzn9NP
        FAA7liEhYpBtQLkPft2TnziqOHNTS/pn2NoMEmwZHvJY25E1S5nxyXjxXxMxoypN
        71UNW09Svhu0UiZ+RjnbzpQ/unrmo2SHzaYy2G+sNg==
X-ME-Sender: <xms:92rFY7TluZs6vnNBIKbLoTITq3tq2hR8pqJ5462nvoQ-ecfbi0OEcA>
    <xme:92rFY8yhbHRzN9BxsZEc2kpLEEpZFa7y0avgxesLIhr9OLb6Nm8KV8pRCM4xXDOGQ
    htxkpM1Sf52YxytB14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:92rFYw2EDjNAvsui3DHBrxwwI0Q75Mq55C5T23TdaIeFEmUVpShsiw>
    <xmx:92rFY7BTsQ5ltipB4xnyQQG2OT6ezH6OE6FRuee4jr7-IpDhHmO2ig>
    <xmx:92rFY0iGNJVbwhwsthYjed7X2QBV0kNQZauKs64RgamefFW-mhoNJw>
    <xmx:92rFY3PAgibROA68VRHwy74SuX5MAVZMEc4r8WGDk1FBhV3FljmSOw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3BA93B60086; Mon, 16 Jan 2023 10:19:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1187-g678636ba0d-fm-20230113.001-g678636ba
Mime-Version: 1.0
Message-Id: <55f09599-b553-4429-aa79-ca99ccf95cda@app.fastmail.com>
In-Reply-To: <Y8VUOENIhe72sqMO@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-3-clayc@hpe.com>
 <110af65f-9c18-524d-a073-ef7be60d1f5a@linaro.org>
 <Y8AIHDizIqu9u9BR@enigma.ccjz.io>
 <48cd3e28-f1db-487d-8971-473dc8c12c09@app.fastmail.com>
 <Y8VUOENIhe72sqMO@enigma.ccjz.io>
Date:   Mon, 16 Jan 2023 16:18:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Clay Chang" <clayc@hpe.com>
Cc:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Russell King" <linux@armlinux.org.uk>,
        "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 2/5] dt-bindings: soc: hpe: hpe,gxp-srom.yaml
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023, at 14:42, Clay Chang wrote:
> On Thu, Jan 12, 2023 at 02:37:53PM +0100, Arnd Bergmann wrote:
>> On Thu, Jan 12, 2023, at 14:16, Clay Chang wrote:
>> For the user interface side, I don't really like the idea of
>> having a hardware register directly exposed as driver in
>> drivers/soc, this generally makes it impossible to have portable
>> userspace that works across implementations of multiple SoC
>> vendors, and it makes it too easy to come up with an ad-hoc
>> interface to make a chip work for a particular use case when
>> a more general solution would be better.
>> 
>
> I agree with you. I have one question though: if we create a 'hpe'
> directory under drivers/soc, and put all HPE BMC specific drivers there,
> do you think this proper?

It certainly wouldn't be right to put "all HPE BMC specific drivers"
in there. Most drivers will fit into some existing subsystem, and
should be moved there instead. drivers/soc is used primarily for
drivers using soc_device_register() to provide information about the
soc, and we also use it as a place for drivers that just export
soc-specific helper functions that can be used by other drivers.

>> Again, it's hard for me to tell why this even needs to be runtime
>> configurable, please try to describe what type of application
>> would access the sysfs interface here, and why this can't just
>> be set to a fixed value by bootloader or kernel without user
>> interaction.
>
> The register is used for communication and synchronization between the
> BMC and the host. During runtime, user-space daemons configures the
> value of the register for interactions.

That does not sound very specific. What is the subsystem on the
host that this communicates with? Can you put the driver into the
same subsystem?

    Arnd
