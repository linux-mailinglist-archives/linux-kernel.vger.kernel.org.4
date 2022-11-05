Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62C61DD1F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiKESNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKESNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:13:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB13D11F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 11:13:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B4A85C008B;
        Sat,  5 Nov 2022 14:13:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sat, 05 Nov 2022 14:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667671985; x=1667758385; bh=f2+D6Fd2MB
        rDAvM5rgGLYxZoJVv4Q2s4lizfG6wX8Rw=; b=aOj/eBmzmEgT3wUa5taBUlh6kT
        //WWPaDdzth9TWS5xirfLo0eH64IBY5KLuSP+iQ/lp+fzRrHcfknpdjugDvJ4QSc
        BUVEq7zkFvgHeXMKYbjOJXmCVm7eTVOOOJTxqWOWYG/EKpiFWO+0pOUaJ1excg0W
        OVAWRnrGOs9djiOGGyPO+ZtL8Mgg6oTHDJdvXnhDZEQpq6e4J2tgkzA/KUSLNTH/
        8jlJeFwZtqNvn7p1cUeZ72uPOmik0dBMwh2dt0hrbm40KVmC4dlMpWqZaSnMadkj
        gDWVtmqpFOrwZcIbKEEzVtWwxuPRe+BZzEr20r4mKorIXFnUodu+G1bP8HwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667671985; x=1667758385; bh=f2+D6Fd2MBrDAvM5rgGLYxZoJVv4
        Q2s4lizfG6wX8Rw=; b=q+ih9u08ckejnpHQ77tVzJORl/TgSlU1NRT5N7DuIFy9
        vmBOBWEPWmdZIYYnCJ55McNnkI/5S1MJNhZ8pm1hrTZo4ClFhhyy37atZJs56PX+
        WmydjB0vLhahDcU13G67elinca1WxstLUzQF9d2N7JRiP7l+vNTTGmp9fRKlgA2d
        CBWv6tIqYXP+1+3xa0USyQ/+0nNqVfrTQB221ObyKEa+44PRfOoeyCbfrKhFSjwc
        cL4bjW/jFypu0SA34+F7OQ4HJIfVbfFpSLL913xqGNSFhbcMgQt/67pdEoAIP203
        xZm7YqRS+FSUD7xGwrCYIuWbCexrI3g/UF8asObuvg==
X-ME-Sender: <xms:sadmY0C0WcosjXL8KeNr79SzEmoaBb_-KVoEj9Hh_N4us_Cgkm1MLw>
    <xme:sadmY2hbGbPh67dbuYRiMCho4Y7UXTVIOcbOXmm47AD7FAsAnWGAD2mXZHQNwOpVI
    pe5RTc4cyHihp2VnUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:sadmY3mzK3Vf5DvC-BPULmDzU7GHHvqhw9Q7KSZfyjNXg2YPrJQbng>
    <xmx:sadmY6yMSc0EqzYnb4x8hQkVY8v-HHC7s7WmVrAjYM2p6ExXthJLkg>
    <xmx:sadmY5Qxh4_MePxbUiuWx9RY92K0bA5EijUch-tJr8XJlBwuvFy09Q>
    <xmx:sadmY-JQLQcH9EBa8qJIAECfMb78IoHRF_-y-UWUSyxGQj8KDGpqig>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 003F3B603ED; Sat,  5 Nov 2022 14:13:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <b01b7fbf-7296-43e5-b751-4ceb7b4f84bd@app.fastmail.com>
In-Reply-To: <20221105060155.228348078@goodmis.org>
References: <20221105060024.598488967@goodmis.org>
 <20221105060155.228348078@goodmis.org>
Date:   Sat, 05 Nov 2022 19:12:48 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Steven Rostedt" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Viresh Kumar" <vireshk@kernel.org>,
        "Shiraz Hashim" <shiraz.linux.kernel@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4a 02/38] ARM: spear: Do not use timer namespace for
 timer_shutdown() function
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

On Sat, Nov 5, 2022, at 07:00, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> A new "shutdown" timer state is being added to the generic timer code. One
> of the functions to change the timer into the state is called
> "timer_shutdown()". This means that there can not be other functions
> called "timer_shutdown()" as the timer code owns the "timer_*" name space.
>
> Rename timer_shutdown() to evt_timer_shutdown() to avoid this conflict.
>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: soc@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

For arch/arm/mach-*

Acked-by: Arnd Bergmann <arnd@arndb.de>
