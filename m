Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA06336DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiKVIRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiKVIRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:17:05 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3772529A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:17:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D9FB5C04C1;
        Tue, 22 Nov 2022 03:17:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 22 Nov 2022 03:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669105021; x=1669191421; bh=sX58BhzF/B
        woRfhVb+QWepoWCONfGRtnVWLLtl7e47s=; b=UCCdHElUeptnis8wjSNIQm47v3
        f/GD+6OmLuMEzpci4jJt0r5K+OF315OUhYpu3vUGqZ72830l9lJNoKCbYvmWn6tV
        7km57t1/ZSANhiptFdXEoWCjuJ1CIkNOB5xcW8Zwpv2fs0JAhgYQEpHsudgf/2O9
        Xtpmk0jlAXHEZb30cs/lqfHIVzV9TF0br/8mYkV0bZtJS8ERiz48p3z7WqIxX1U6
        CUbx5U4Jo4GluWTSGw7z1ofD1YXuOqRJjM2XDaxrA5/3F7pk9fi38dPtJfrsf6Ez
        IP0/bhqYFg8q7kK6KX4R6cVeU4xArgiKU6GeqsWegSgook1FrMN326ggEVag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669105021; x=1669191421; bh=sX58BhzF/BwoRfhVb+QWepoWCONf
        GRtnVWLLtl7e47s=; b=Fj5bsKc34BnVE1YFSNFYUIsTgF1bIz01p+XLQC/73irc
        whLV8uPxeEIO8qrQxxhSYeLtEKTqdRUSjFj2eHq7gupjMOYwKTQ6B8T29+SoJWo1
        hKXHo5b73sKHFbPEyG7956In7D7kUk3wHaWEraQAZ/cQTBsqjoUyJAO1djsMcvrQ
        dno5oDnsHHC75FCn87eTTVw8fCU1jN4WJxaUzbIL1mjiYMEQwP26CKxZK+kd9ZmC
        8OBv7o/xviRehqNmaR6fU0Gei+bYQpzFVZGeYY4GxlZI4Mpn3tw9ea38nMYB9wMH
        vhBki80TrSodj3yGqXqVGeL+p3CZbvSCzqER2+CMFg==
X-ME-Sender: <xms:fIV8YwMLfyXJk-jita7J9VQhaYHt5CFANCzg2-NpszqTwL0Z6qNhFw>
    <xme:fIV8Y29-tiPU4vfC_0jaTmEdCvQkrnc8PM03BtHjcRDxChGsAegn0q-qJsI8RqffJ
    kp06F9bwPGv9KSkRQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheejgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fIV8Y3Tn__E4Ok8T9Be8VnPYs-Uyb1I0VFwj_UTq7TQ6A1PwAHcM8Q>
    <xmx:fIV8Y4swuy_w3VPCDQM9brPJaHRx9dhY5ajBAQvnBTAl4dH5qdUDbw>
    <xmx:fIV8Y4dRuAZL2XVnsmTmEoGyZOiEFICxLWU1gemt_5oWVwZVCOO74w>
    <xmx:fYV8Y_yUBwoTv_kpKKMuKWh2-bs7W1rPuRjg0GwuQa-VaUx2L3q9Bg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 97EA9B60098; Tue, 22 Nov 2022 03:17:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <31eda70a-094c-472d-a3e8-55b155a5408a@app.fastmail.com>
In-Reply-To: <20221122035715.GA25470@T480>
References: <20221117105131.7059-1-cniedermaier@dh-electronics.com>
 <cf1c2f76-a724-4609-8263-a5cf997895be@app.fastmail.com>
 <20221122035715.GA25470@T480>
Date:   Tue, 22 Nov 2022 09:16:40 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Shawn Guo" <shawnguo@kernel.org>
Cc:     "Christoph Niedermaier" <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        "Marek Vasut" <marex@denx.de>, kernel@dh-electronics.com,
        linux-kernel@vger.kernel.org, "NXP Linux Team" <linux-imx@nxp.com>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add DHCOR to the DH electronic i.MX6 board support
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

On Tue, Nov 22, 2022, at 04:57, Shawn Guo wrote:
> On Mon, Nov 21, 2022 at 09:43:06PM +0100, Arnd Bergmann wrote:
>> On Thu, Nov 17, 2022, at 11:51, Christoph Niedermaier wrote:
>> > Add DHCOR to the DH electronic i.MX6 board support to cover the
>> > DHCOR i.MX6ULL SoM. It is a solderable SoM.
>>
>> Shawn, let me know if you want me to apply this directly,
>> otherwise I assume it will be part of you next pull request. 
>
> Feel free to pick it up, as I do not plan to send you another PR for
> 6.2 merge window, unless there are something really urgent coming.

Applied, thanks!

     Arnd
