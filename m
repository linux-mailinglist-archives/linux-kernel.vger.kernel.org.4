Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C910646155
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLGS6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLGS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:57:59 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BA71A839
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:57:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6840E32006F2;
        Wed,  7 Dec 2022 13:57:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 07 Dec 2022 13:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670439472; x=1670525872; bh=IYyFVXq4uP
        LEhfNx5cFnxsu3093usNvyCS91OgsAon4=; b=SMIN2njeTfwiE019ekb1g6bijV
        NKHv0vYTHXtMT+UINLaSRtX1NpXVxCIDBRcnMDpbRrbF8A46/sxNlk1nX7wVZR0W
        BHYJZf8dO/czk+33+Zjmn5IPtmqT2VhUFWLtFd0a52CXZqHz3w6C8kvHrHLFVKUi
        MAwWNNzoIe049XNoDE4HPMlfu0UAblDb+N2krIotQQpGWCuZG1wRwtYZYNrMOqTx
        WETqRdVZ2o49/wPGdDkBg/1h+pPGVBCuz/ATjDB98H+HxB1EJvrZUZMBJ5fK1zZB
        js2iQyL839A2tE7ExtJyv37uOSTB1DIO8T2isSL5o6sHbk9wd4LlKLzBSriQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670439472; x=1670525872; bh=IYyFVXq4uPLEhfNx5cFnxsu3093u
        sNvyCS91OgsAon4=; b=DBSZj6QcexkjNBaxNJTyJo3URZLeUZT5VkAy78Vn/oCZ
        Sqo1TTvs9gTDN2lK+xZalLMzu9bZrZw+/sDCxBfHUKD5OTJEe8u/yv6ieWntDSIT
        m7TMEfg3SrokXNCVuoE+40+0oOYxjTbJISEpO3EO2hBYdzi9F0+OJ48TNQnGgCSV
        CczUKFxwW7aAZyBrTFxYFyEsnvm1EYHEBb+z+s9Z7NaRWj5igfgHnFlWVLGN7R1Y
        p1sxVYCr+Kuaq2rX8b8mFm5Dcsv6o6JmzMC1hpYVVnD+N0h/k5Qm0kqRICT9qs/N
        4g1e+QdSDZ+B0rHduklu4CY7+51tihP8/BnY/y65jQ==
X-ME-Sender: <xms:MOKQY595cdVAeyRxDx7a39Qsj4hW3bNov3SN_BdPsWFLWYN9CrLQFA>
    <xme:MOKQY9u-Hx2D387zPssewjvndRGX4jxEO9wQTjTANkvyCIBe8WQK1H2Xk0mbfq9P_
    eothuQRcl64AH5drgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MOKQY3BdQb_tvKSlP52pmMGrnJeYKbmJz9Sv8W0fnuJJYbC9DfaVgQ>
    <xmx:MOKQY9fU6rDQrBqjE1aaIJgqstlUUpnoLLnxDeX5B94Kz4RJJXQA_Q>
    <xmx:MOKQY-ONrTN3eLSbvqMBidOX272KLRX0IbvbMG29v1CoEj2u2ZG02Q>
    <xmx:MOKQY7oDcvzpd7B0sitpjJXj3JXVmH9t0RbFktG7LOCc5Fwzse8z8Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7394AB60086; Wed,  7 Dec 2022 13:57:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <efaf326b-3cd9-40a4-8424-b5f60270beae@app.fastmail.com>
In-Reply-To: <41a5931e-3543-6a3d-ca85-2dd8ad581f2e@infradead.org>
References: <CA+55aFyJkpSa6rwZ-5xTihfGiNC_T0oL6txrodYBEo2-0O=p7g@mail.gmail.com>
 <1499156564-29458-1-git-send-email-peda@axentia.se>
 <053d7bf2-9bf3-a71c-5713-7cce19413c37@infradead.org>
 <a546f2db-371e-4d2f-a0ee-c71fcae8c548@app.fastmail.com>
 <41a5931e-3543-6a3d-ca85-2dd8ad581f2e@infradead.org>
Date:   Wed, 07 Dec 2022 19:57:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        "Peter Rosin" <peda@axentia.se>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mux: remove the Kconfig question for the subsystem
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022, at 18:19, Randy Dunlap wrote:
> On 12/7/22 00:41, Arnd Bergmann wrote:
>> For the other subsystems I mentioned, there are occasionally 
>> problems with missing 'select' that tend to be a pain to find,
>> compared to subsystems consistently using 'depends on', which
>> show up as link failures in randconfig builds.
>
> I find that various drivers mixing the use of "select" and
> "depends on" is problematic.

Agreed. Even just mixing 'select' with user-visible symbols
is very confusing. The two sensible ways are either using
user-visible options with 'depends on' or hidden options with
'select'.

> However, there was no answer for the original question:
> How does a user enable the 4 Kconfig symbols in drivers/mux/Kconfig
> if some other random driver has not selected MULTIPLEXER?

There is no need to enable any of them in this case, because
the mux drivers are not usable by themselves.

> I.e.:
>
> config MUX_ADG792A
> 	tristate "Analog Devices ADG792A/ADG792G Multiplexers"
>
> config MUX_ADGS1408
> 	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
>
> config MUX_GPIO
> 	tristate "GPIO-controlled Multiplexer"
>
> config MUX_MMIO
> 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>
> OK, MUX_MMIO is selected from some other drivers, but if that is not done,
> how can the first 3 be enabled by a user?

They cannot, that is the entire point of hiding the subsystem
when it is not used.

      Arnd
