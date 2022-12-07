Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D3D645593
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiLGImS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLGImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:42:16 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C32608
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:42:15 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8FA38320084E;
        Wed,  7 Dec 2022 03:42:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 07 Dec 2022 03:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670402532; x=1670488932; bh=qDAKEMhFbf
        bLSg4M5W8LhG073HCO+eqC6S/I3gCoQFY=; b=MjDPUsAGAJkLr86rezdprbGhUs
        KrCv86seSzOWQ9GTlIJ5YIETTEiMKzWXwBcLu1I2J+Dqq/waDgTeSo6El5tr7o/1
        BE6353cCDkVgJP/dMJB5C3tbekExOZmH8QtmVJXJsdWJhLmD2WkFu83dEEE3nzs9
        WBBfnS7CPdnlKOkA1Zbs+4QLg8mNQJWG+2ftLTxsKeQ9qZLpsFmOBS2RBvb8VrYb
        8WUo2/s5cIPVlfnXvBZvqt4rsP6cADyey5DXUkpjZQEjuzCoK4K4OrW+B4EL0E5o
        BsBpqOVZ+Idt1at0MHpClZwIXhdZUxVb/+ieH724jymTOrtRonpDKKDHeVvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670402532; x=1670488932; bh=qDAKEMhFbfbLSg4M5W8LhG073HCO
        +eqC6S/I3gCoQFY=; b=DNnce72wmfpAe7YlqWL+9B5/lVd5+H1LpFiQgJbvivz0
        rAvGHKVA+5KOwRkD8RXDrF2iSlGsG9jXVd6M5nc7UmSQ4eFu9MtYYyJRATp5s3uA
        DVBgysAnUxJOa6W5mr6pOIypTqeCjCbIhoNBKW/i9wfSDfSmbulARMADGeaLp/Cc
        9rt644q857bTcJgB3rJjPzTyNw4/8copV1rjvbmeDDFVktwXbOI7W9myjmUjmoWf
        IFXkyOMnx+NWw9+dP4CybcTLw+nspauvz2L+jVD1Ss4dfN4/ff3D7hmtlP/z+P1R
        EBvmPIl80i+60gXGn595h1yIiN+vW+QNHoEYgffHZg==
X-ME-Sender: <xms:41GQY3HS9DmZEMuRJgMbbkLaXk51-TcWbte7Na63K1XkCT_1WrMgHw>
    <xme:41GQY0U8ceglAsgdzYsqVI9vk5a36kaI7ZDqBsMTBsL1QGgZihDjoRSyw0L9kyl5B
    pyqIpOjuW9q5g5Evyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:41GQY5L_WBF0HyzqL5GK6dxRabtr2fUMp0n2f4o4q_Lr_-aKRex3Ig>
    <xmx:41GQY1Fp_dNOf61tHF3PG-JZaxkHu5C74dMpn2KJqr3r3Byn-HKI7w>
    <xmx:41GQY9VhdICoGupXZewGmOwr49Y1PKEng5Nd2VaZ4ULmNnSfqYbpEQ>
    <xmx:5FGQYwQlIbz201vORft2FCZYaRLY4b3AoRn_tptV1oub1hN6IclqpQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 99FA3B60086; Wed,  7 Dec 2022 03:42:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <a546f2db-371e-4d2f-a0ee-c71fcae8c548@app.fastmail.com>
In-Reply-To: <053d7bf2-9bf3-a71c-5713-7cce19413c37@infradead.org>
References: <CA+55aFyJkpSa6rwZ-5xTihfGiNC_T0oL6txrodYBEo2-0O=p7g@mail.gmail.com>
 <1499156564-29458-1-git-send-email-peda@axentia.se>
 <053d7bf2-9bf3-a71c-5713-7cce19413c37@infradead.org>
Date:   Wed, 07 Dec 2022 09:41:50 +0100
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

On Tue, Dec 6, 2022, at 23:20, Randy Dunlap wrote:
> On 7/4/17 01:22, Peter Rosin wrote:
>> The MULTIPLEXER question in the Kconfig might be confusing and is
>> of dubious value. Remove it. This makes consumers responsible for
>> selecting MULTIPLEXER, which they already do.
>> 
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>
>
> How does a user enable any of the 4 drivers in drivers/mux/Kconfig unless
> some other totally unrelated driver has just happened to select MULTIPLEXER
> so that the mux driver menu is visible to them?

We have this mechanism for a few subsystems, LEDS_CLASS/NEW_LEDS and
CRYPTO being more common examples.

The idea clearly is that there is no need for the subsystem if no
drivers call into it. This works if every single driver calling
\(devm_\|\)mux_control_get also results in 'select MULTIPLEXER'
in Kconfig, and none of them ever uses 'depends on MULTIPLEXER'.
I think this is used correctly most of the time in mainline:
git grep '\<\(mux/consumer.h\|MULTIPLEXER\)\>' indicates that
PHY_J721E_WIZ and MTD_PHYSMAP_BT1_ROM may not actually need it,
but that is fairly harmless.

For the other subsystems I mentioned, there are occasionally 
problems with missing 'select' that tend to be a pain to find,
compared to subsystems consistently using 'depends on', which
show up as link failures in randconfig builds.

    Arnd
