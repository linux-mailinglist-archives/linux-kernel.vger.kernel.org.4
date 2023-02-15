Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEAD69794C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjBOJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjBOJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:48:42 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44E36FEF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:48:33 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 687A53200893;
        Wed, 15 Feb 2023 04:48:30 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 04:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676454509; x=1676540909; bh=jLXjSQkTOn
        +4ktIkp6EZtl+YKLL9/WnSJEkDg2a+TfI=; b=RxSH/xlkF3FiEBW3/RkM0mPVmg
        8M/DGumRbq9Uo0JuFEUi6FKil3p0qW2KG52n+EK/UJfEicbmA1M4oreBInWT4HFE
        EgqcXQhsx6YLRxuo7PUM/UTedOszgHnDtaArilRhPi+vawTDjFXnsnu6RQ67PXA5
        XM5DFz1kzdFieQAngjhfVf0OpiEQX5Wd3crH0r270EBuaPiAF7nnTNaNjUPqoBEL
        tD9BD0ySgrKVz0TjIU6vamtBI6J9Kxjh0NEb+LDkpoK6yywjL1RjCq9v1j9hX0yY
        NtJz4MvSaxd8nTkE03Opmoge4zCMQITMGv8D0lHLjTB/XkgEuQaQjSS7OXzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676454509; x=1676540909; bh=jLXjSQkTOn+4ktIkp6EZtl+YKLL9
        /WnSJEkDg2a+TfI=; b=PrEn79tzqBiwMpg80px2VL4XBQtSfVKofb+KosTC2Pcn
        P9QsUSI81yCaf5HYqBh/Cwr36yoX3t6Yt+BAOvazmG2XA4B2gLGhmBQqo8gJkxa0
        C6dzeYiab7MI9QecwQeDI9bGoId+FFpQS54+DfLqxEWxjAGYstyqkQ4gmeXnscuN
        qiFO3flHi2TxaLVWSibBW18g7v3w5gQmgzdz/+U2+ncsXOXkBqucncK06ajVqLfx
        qeX9KcKboSLAlypuAe0BUM1IgO57WW+i+TqGq5TbH2QB8umqMMiY2ONhPNXLcgYw
        bJ7SiHy9ct5Lwk4TkO/V5g/oT6HBIFh61t2EtW76iw==
X-ME-Sender: <xms:barsY7VDO506yJbtptQM4-5rQIhAOma5b98KwL-Lmoqj6ZJi9-83lQ>
    <xme:barsYzmO4tmgXsjf-9GTr5Zxo7vBAgdMl2Rx5haUdLAUIWMga9lWdGpRIBInuYTEC
    yPV6Y0oyWsjUd8jp7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:barsY3YcKtMWUVFhBuvX1BJA57eggeewaElBjWs_HQy1x5pHNnVExw>
    <xmx:barsY2WOK5T0ZciUgY7m7VKnN8gxoK1jaYmNflXUkqiFeAAIg45O0Q>
    <xmx:barsY1kj2k_uBe1ftJVqgrOTSgNHHhiCh3AHljEvkv2cbg3UqTgUZg>
    <xmx:barsY7UY4NuB2i8bxrs9t0wX6WhSKKQjmryrDn9SFBc1SaAMA8IS8w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 80C21B60086; Wed, 15 Feb 2023 04:48:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <78b2ed7d-2585-479f-98b1-ed2574a64cb8@app.fastmail.com>
In-Reply-To: <CANpmjNNz+zuV5LpWj5sqeR1quK4GcumgQjjDbNx2m+jzeg_C7w@mail.gmail.com>
References: <20230215091503.1490152-1-arnd@kernel.org>
 <CANpmjNNz+zuV5LpWj5sqeR1quK4GcumgQjjDbNx2m+jzeg_C7w@mail.gmail.com>
Date:   Wed, 15 Feb 2023 10:48:11 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marco Elver" <elver@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Kees Cook" <keescook@chromium.org>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Miroslav Benes" <mbenes@suse.cz>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] kcsan: select CONFIG_CONSTRUCTORS
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023, at 10:25, Marco Elver wrote:
> On Wed, 15 Feb 2023 at 10:15, Arnd Bergmann <arnd@kernel.org> wrote:

> Looks like KASAN does select CONSTRUCTORS already, so KCSAN should as well.
>
> Do you have a tree to take this through, or should it go through -rcu
> as usual for KCSAN patches?

I don't have a tree for taking these build fixes, so it would be good if you could forward it as appropriate.

Thanks,

     Arnd
