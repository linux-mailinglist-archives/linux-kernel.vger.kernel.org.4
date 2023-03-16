Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752CB6BD231
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCPOSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCPOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:18:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9992D5A55;
        Thu, 16 Mar 2023 07:17:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 642455C00E0;
        Thu, 16 Mar 2023 10:17:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 10:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678976248; x=1679062648; bh=8w
        xnkIWEzkhjMo7BKbmq74RrBygIPUH/mVfy06Uygmo=; b=ts/SLG4ImxnmdL6+o/
        aKc3AdM6jEjIA5ZhM59htl39G1imJQQghYOvbZrz2T8kQVj6gr82Mdnbcds9RqlS
        psYQZL/3vPO+sMCegy8Ndih0oAIlrUymHFgXRNffDL5ovZKD3S+hny8Gcm9L6+YZ
        1hCXwCaDv5QAQ7IKUeLbgGkDyxBNQ3H5Dlf7zH1szI6FUWQplqdUghXGWfLq7z7y
        dHtyXE2SRUUrUd1Iy7F3DMfEwiqGnAMfg0srcvQSpWLpDEiMX5KHxBZkZu8B5RVR
        XhKyuHhXKMqMZVdyRTbrafRbKwHiELSpRroiZPWxgVn2XHwHw1i0tZsC12uJYZf6
        P+5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678976248; x=1679062648; bh=8wxnkIWEzkhjM
        o7BKbmq74RrBygIPUH/mVfy06Uygmo=; b=eRmiEccPVtifJQgiiRpZTBTlBZBYG
        Sc9KGn5McagRonfU37jhoEZTz3KF7eeMxOC6hfIKBE22XNDrXGJXC+4uVmjLzcpL
        kylgp5kx2nLfLgrensOamXbLB7CrNcfT3IHNZY1e97g4OijJz+eKGk8rNf4ibL8V
        k0cUtu2W0B6qSI7xnFisHOAiYHJRjNOSp9QTuma1663ZjCGBzazKetCXOZ0s5/W+
        1L2y622d9qKEoO7PbqAWRnfiJ83wXx2AmUloRIFWfHyx9PuqlOfdsUyJW6fUof4u
        qTzCqvYpAIu14Lqtrm90cd84Py8RFWTNMBujSbn6j2TsAPb8ODaMhJf8w==
X-ME-Sender: <xms:9yQTZBmnLOlQtmUeVCuAlzMqV92BCcKX2NP3kSvIAB7CPV8j4ly8eQ>
    <xme:9yQTZM23JWdW9M9E1aIw-8dlzA06Reobk12iHlcCnLIlojDY9VTj4AzkHpyB5Xv6-
    9Hn_oR4FZLkYlvTZn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:9yQTZHrIjfzdnzH0sW1_ufHPE0MdYtyYO0HdheyLDdvyOYfU9R-l-Q>
    <xmx:9yQTZBlk18uvWK5GXyU0JKM6WKzwliYG3JVR5EhbxcAwdplN9_JRDw>
    <xmx:9yQTZP3Y838o8HUWNN_qIjfOqaxZZI4EEMf8OpY8N58z3L52ZEqakw>
    <xmx:-CQTZNOlrTA0zXCTBjIOmabhR6Sql852XrOaWN3joGJWqpQ2FIn4dQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7D1A8B60089; Thu, 16 Mar 2023 10:17:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <2063c6d1-85ed-43d9-b572-a762b6ce18c1@app.fastmail.com>
In-Reply-To: <20230315072902.9298-12-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-12-ychuang570808@gmail.com>
Date:   Thu, 16 Mar 2023 15:17:07 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
> +	mem: memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
> +	};
> +};

In most machines, the memory size is detected by the boot loader
and filled in the dtb in memory before starting the kernel, so
you should not need two separate files here for the two common
memory configurations.

Since the machine is called 'som', I would assume that this is a
module that is integrated on another board, so more commonly one
would have a dtsi file for the som in addition to the one for the
soc, and have all the components of the module listed in this
file, while the dts file that includes the som.dtsi lists the
devices on the carrier board and enables the on-chip devices
that are connected to the outside.

       Arnd
