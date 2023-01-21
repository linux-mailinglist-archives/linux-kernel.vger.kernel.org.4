Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D34676786
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjAUQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:58:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF602940C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 08:58:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 814F6B80885
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 16:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC48DC433D2;
        Sat, 21 Jan 2023 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674320303;
        bh=Rc60u3nQD8vjB9hfAtNH19XQTM3JZUxJHCTagm0Ww8w=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=rHQqUJWCTcUU6AhaSEYYkuYUhqUWdQSGyd2wvrH314T4AetbgXREWVTYUaFm8XOJ8
         oP/cezx9s/4pCce0YMhp4T2ezQ4GFNKt3dYJ5iv3rc2tk9e6YHXTm4ZzXWh4/CGI1q
         WgwEL/MEOGchAhbho3YREROj+Hbdmj9cOuh0R2ERYySY5KooxC3nFe6fRqbyyc3ZSW
         xlmMWrKHsamshuEzbZnlrnvnOZNpxlHtVYeyg7AZON2AIoVOnhhboFTYS7JxhRzY6+
         y1ujN/6oI2aEE5EKloh58YGdDm1/paDf+9BziUtBB1lWmBHWT/pVF5L30vvJqMhj8f
         3PM8axc7mBsbA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 955BB27C0054;
        Sat, 21 Jan 2023 11:58:21 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Sat, 21 Jan 2023 11:58:21 -0500
X-ME-Sender: <xms:rBnMY3xs8CKfHZTWiTPvmFqdovIhH86r-nU_ReHS8_xuzBmUzFPmDQ>
    <xme:rBnMY_S0G7T1XAtFRgs2mrX0cWk6Ox4RRuS3IfKy8HmG63Yv6FEEkX6SEgLaqtmS5
    3gV9pN6vu-qg58OXCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddugedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:rBnMYxWcr_StY-Je2QwqxKK1dbhMVCkQYrCnb9RmFXhUDRM05-Qhdw>
    <xmx:rBnMYxi_P1OkYINtWYQpUpy24A33gZmlwWJ71bzXi0nBDCToADHKUQ>
    <xmx:rBnMY5CxN-5-kQF7RdR5Lf3vMZQi7WPnH70detc7b1t1Jl7R21Hoig>
    <xmx:rRnMY73ogRNB9CTAUFW9AJ7a9ndlOBjr1SzBz4VIgUCSNJTv1veRKg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B8B7231A0063; Sat, 21 Jan 2023 11:58:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <6bf667ca-da46-4759-b1b0-5aa56dd2eb28@app.fastmail.com>
In-Reply-To: <87v8l26ww7.fsf@meer.lwn.net>
References: <20230111193211.1987047-1-sohil.mehta@intel.com>
 <87v8l26ww7.fsf@meer.lwn.net>
Date:   Sat, 21 Jan 2023 08:58:00 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        "Sohil Mehta" <sohil.mehta@intel.com>, linux-doc@vger.kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Kees Cook" <keescook@chromium.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH] x86/vsyscall: Fix documentation to reflect the default mode
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Jan 19, 2023, at 1:24 PM, Jonathan Corbet wrote:
> Sohil Mehta <sohil.mehta@intel.com> writes:
>
>> The default vsyscall mode has been updated from emulate to xonly for a
>> while. Update the kernel-parameters doc to reflect that.
>>
>> Fixes: 625b7b7f79c6 ("x86/vsyscall: Change the default vsyscall mode to xonly")
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>> Do documentation fixes typically get backported to stable? I haven't included
>> a stable cc assuming they do not.
>>
>>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Applied, thanks.

Belated ack!  Sohil, thanks for the fix.

>
> jon
