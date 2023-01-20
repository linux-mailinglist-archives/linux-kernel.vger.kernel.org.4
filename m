Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCDD67591D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjATPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjATPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:52:38 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F355210F;
        Fri, 20 Jan 2023 07:52:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2260F320046E;
        Fri, 20 Jan 2023 10:52:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 10:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674229955; x=1674316355; bh=DtS8Jq+YGT
        i7yWho9Vbrof/W6pjerVKNtmOz7aKe06M=; b=f9QLexsh11uF9/M6aGmdhI0kpB
        nRraiDm12gpr3t6SEDmgzAq6/AF4tVnhkWo0eIvW4nneSVHy6ktQ1qHDQzZ+Mo3Y
        rbxIkjPwy4jKk3kCAWARnHCKCxCDufVfxSPwkZCjMq0tEkvKmTrYq1LKej+wRYzF
        ZL35/6wLDAWSHvwPhMHFGr+WxskwTgtuAG6BAcJ+sGjdnLuXxFN81fv84KfcIin+
        WdTOvxd17WGCPyrnQJJ/mZ2rRtwTFBTNSK2LpTPQDLgDKpOoizR00T42Z9IIkyVC
        zftTzmLperGx4AaESwK9UhAhHyC4IxTP0gkMMjVfjqcOQnsuu8yg9K4SvYLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674229955; x=1674316355; bh=DtS8Jq+YGTi7yWho9Vbrof/W6pje
        rVKNtmOz7aKe06M=; b=UzU8ZWqTPmgqDpZs1evTS+43RxhGDhYR+SorIEftHO+0
        MCgXWJsaTaB5QikmF7ShLiJHaBDom66BgZBVLZ6YFl3pUcPBorF8yirKuHVtnpAL
        hR81fGcelNiOl08voW3pvjFRjQ+XWzIkyzqEZBIOXzpu8srxIKzyXVPxoxvdcwY9
        YBooj6aXBE+4hs3XSoJZQ2JypeycREXUXzYj00R7BHU4e2J7Y2OOjBk5bWQfDej9
        9CX+5E8kP2ECE+A5MqRR2v0tX4JOVvaiGtI+4yXyMNrWk/6Zpe+XYHQT9rSmVsvo
        M3Up3Cj4eJAA6X4zqFF/IF3rAPyaXx6WfK6cH3fLXw==
X-ME-Sender: <xms:w7jKY3mOZvfvkCkkr6TxND2vTQY_gMwTUI6D8BF0OiVjkufmsTPurA>
    <xme:w7jKY617LQjosI9Gr26lMzEYyVcaqFQWYr59CDfyLzWAbyCVfyYcqDK_Y9gAPehsD
    7lqWG3uzQd0fDNdluk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:w7jKY9puV1miYR_CcqRkbhP8MIL6BBpGcjqyST-zdLmphyGx36fyZA>
    <xmx:w7jKY_l6rRn739AkVf7pxeyU46G9c3kVybqesI6FYDcTYqqFpuxEkw>
    <xmx:w7jKY13WKFPdWf1iyVN7BLaolZeGVI8jMovIX6pMRmbHNwei5qPWJA>
    <xmx:w7jKYwTHf-s13xzhMyXHZa5SSfXjTuahwzPPtuSlmWKMAnRQK9njGA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3553DB60086; Fri, 20 Jan 2023 10:52:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <91b81295-868f-4272-ba16-25862346ddec@app.fastmail.com>
In-Reply-To: <20230113121308.5e86479f@canb.auug.org.au>
References: <20230113121308.5e86479f@canb.auug.org.au>
Date:   Fri, 20 Jan 2023 16:52:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Mark Brown" <broonie@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Olof Johansson" <olof@lixom.net>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the sound-asoc tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023, at 02:13, Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in the arm-soc tree as a different commit
> (but the same patch):
>
>   5eab9265759e ("ASoC: PXA: make SND_PXA2XX_SOC_AC97 user-selectable")
>
> (commit 350a6eb412d3 in the arm-soc tree)

I dropped it from my tree now, as I had to rebase this branch
for hopefully the last time.

     Arnd
