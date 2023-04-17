Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F456E54C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDQWuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDQWuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:50:02 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED4446A8;
        Mon, 17 Apr 2023 15:50:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BFAB83200949;
        Mon, 17 Apr 2023 18:49:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 18:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681771797; x=1681858197; bh=Uv
        1oc3npXKlB1WxLwiqApxeyeE+yNkaEVZoDDF0LLXU=; b=GYe9tZQN8GYHgiPkdP
        lWkvIiTgewMK5ToHiirxxofpi7Bs4mgEVppU//lBKkyYpZv6Rz3+A7GCpOB5J0zN
        S7bUtjxBmVTH6x3SCRXwY0u4WW7Vv6H8BGP9ZxlJpkeZmm4i+KlgKAZ10KBjfqq5
        F7ujmKZ0b/LO9RSgpWaUNq8AcpMBCYYau/cBay+/6NeCkpJlRRHQ4X7i7f/4gk+9
        HEwDOQE9NfuhPPHm85fliEdpvGKouapsPqeMhw85VnCADuYZwub+b92W/L2TFo1U
        Lw2WVHE/2lJPhepvLmMj4sPoJmEIWQhVz7aSDcgfQu0iMssxoURRz9lJURU9tDkY
        XPxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681771797; x=1681858197; bh=Uv1oc3npXKlB1
        WxLwiqApxeyeE+yNkaEVZoDDF0LLXU=; b=YpZYZm1mNPrHbxzvS2jV71YKVaRZl
        wwho1zUDeGuUVGoVnsKR1vt6dFjOhfcDOiFn5+h7chKrWys/nBNDHjmyLh0QwH7Y
        Zr4aIIirvK9OWVsK9Ivkl0QGMgt/TmU57CKgul8fpKir+9+0wyew9i05nkvZXXvl
        ZFazSGAiphEQqlwMWoceWk7UK13gGHrGBQhIaM3P6oJbIHOCEqY7m4YeMNAqrX17
        /axg4hehsxLAhRBOon+bc8q2UwLejAltCxNHfZY5QhdEcjifALV6thqtCG5xRs4H
        9neqIYAFnv5NFo9LJM1J7ntnwgNZkCY0t5eZkgkEk9l9jHFmRU3/5nlfA==
X-ME-Sender: <xms:Fc09ZEpOdaX0kw3zgt98nD7dbBdRMQZ3SXNo0qpdXcGE29C30ula4Q>
    <xme:Fc09ZKrtdne4yf8qTpk6JvCxB69cQ_PuUo966g4UHM4VsqBeWxXFjynRZvrM7FLph
    CH8G9sUhJBYPm6FOeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Fc09ZJNFQjNE3ociTCO6yIhiCXryYQ-kRLIRBnQxpDOU_hbc8GQmIw>
    <xmx:Fc09ZL4dIUBBRAv-6AnVUQ1knyJa_ES1BBTUJs0YEoctTzJRboCsig>
    <xmx:Fc09ZD4iPnpzpNOaDoccmtKQ_loPEZQYZzMa7a46uzWHMyRt3xxADA>
    <xmx:Fc09ZHiVv3Z4na2jw5oSblSGzcdiK3VcjWxx5tcNzMOTjWIOktj5Dg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0EA74B60086; Mon, 17 Apr 2023 18:49:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <cd9d08ea-ffa5-4932-b296-7a58203ef701@app.fastmail.com>
In-Reply-To: <ZD3E+AYPzq/EO2Gs@bombadil.infradead.org>
References: <20230417220254.3215576-1-arnd@kernel.org>
 <20230417220254.3215576-2-arnd@kernel.org>
 <ZD3E+AYPzq/EO2Gs@bombadil.infradead.org>
Date:   Tue, 18 Apr 2023 00:49:29 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Luis Chamberlain" <mcgrof@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Aaron Tomlin" <atomlin@redhat.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Viktor Malik" <vmalik@redhat.com>,
        "Jason Baron" <jbaron@akamai.com>, "Song Liu" <song@kernel.org>,
        "Jim Cromie" <jim.cromie@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] module: fix building stats for 32-bit targets
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023, at 00:15, Luis Chamberlain wrote:
> On Tue, Apr 18, 2023 at 12:02:47AM +0200, Arnd Bergmann wrote:
>> I have no idea if there is a risk of these variables actually
>> overflowing 'long' on 32-bit machines. If they provably can't, it
>> would be better to do the opposite patch.
>
> I had originally used atomic64_t and added a debugfs knob for it but
> Linus had advised against it because its not a stat we care too much
> on 32-bit and atomic64 is nasty on 32-bit [0].
>
> So I went with atomic_long and the cast becuase we're just reading.
> 
> Is there a way to fix this without doing the fully jump? If not oh well.

I've sent a v2 now that does it the other way round, which is
clearly much more efficient. Have only done minimal build testing
so far, but it passes the randconfigs that failed before.

     Arnd
