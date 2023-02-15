Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B347697984
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjBOKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBOKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:08:11 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07232A6F2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:08:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 112D35C0109;
        Wed, 15 Feb 2023 05:08:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 05:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676455690; x=1676542090; bh=kWKcVh77gL
        JCUhZuCa+WynI5AAVboSYj3Oe09BQDl0U=; b=Bt7T6qqkwn8XU9cW/mlPPWH5BI
        ku+K9r4B/Q9RUBdJtYb9WSJ2Zpji5RI/dhywPv9+xz0uqIecENsAhstgvYe3ViAe
        dMtAcMmbzL4iNyN6KgR2bGGzHdtWxIwJ/an7o5Jsq3A6+OhRcOap1aS9Md087vx3
        AUeIlv4+myzNoMxLldlHo7rcgt1UVyDpf0o58VVEgcmC7y0ej3/7VCf5HzEIoB1f
        l7Ozxy9UC+93DV2+E0faHepS1e4gFWAFGRKH9rZFC8lVYK7ely4d1Pkm8T0+XRRQ
        2YVunY9xDqHdt2bg23VRHjQbPxHlZYz3+qUBuZPip17TTzUBvI5LmOk5a5Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676455690; x=1676542090; bh=kWKcVh77gLJCUhZuCa+WynI5AAVb
        oSYj3Oe09BQDl0U=; b=Je1/tWD05vqtWnSTtg3NLoPRKUx3oKEPByi19pFs92lp
        /5nyPHpQtzJd88KRqK1E2y+La+SvfE+dzUd5yi05fWeU6RT69jlEtAt4x1/s8/Lc
        AKSTwDBFhmzUGLPT3ZnhZfGzKWrT1tZQaZ+/qDgp2v2W62XsalDiPyEQkbibzh0P
        YWPrjq0Ek5nsvQjcW5jkUwnDhhVka5nrcoIphhGb8cL8wCUjPm54ztxzO/pKT2jj
        fcXD9cKi/dgY3QsWUFjWMIT5WjJsHBqcccinmSepzAYbX/LWNDvKYCB4hWLjnlq2
        EoCRlDyU0hW/DzRPmeC21UhD8+Qx4X2j+Ee2MWg7uA==
X-ME-Sender: <xms:Ca_sYwj6243aaaFewEIkV7j6oDonohgF3wArjnJZw79rONDJPNjjHw>
    <xme:Ca_sY5DBosDA5DvPLiAv00BIKZnS6ADCRW5FJMKQjm0O0xoZ0A-SoyK2Im-wVHHP9
    XfJOqogqq8nCyj_ips>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepleffheffveevkeegffefffdviefgffeghffhudevteevfefgtedujeefuefg
    gfejnecuffhomhgrihhnpehlihhnuhigrdhorhhgrdhukhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Ca_sY4EiVIfc_Fc8C7HCeMLhpDtHXpfcEkzZfYSZMd7aSG6d5f5Rrw>
    <xmx:Ca_sYxQDoifIb1cp4TMuxZKd0LN_xZVi9DugV2FnkqBWvlrmY-Tb1Q>
    <xmx:Ca_sY9wLc9mJxw8QhEduakiHsu3PjaIJBy30q4JoEhm63sCBzAWfVw>
    <xmx:Cq_sY9icOGg888G4FeLyVEIj4TX1fqCoM0id8lCphCeTo61Ycjokaw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 475F7B60086; Wed, 15 Feb 2023 05:08:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <6a5e9a2b-46df-4717-8f4c-aac14d06d773@app.fastmail.com>
In-Reply-To: <20230215023706.19453-1-zev@bewilderbeest.net>
References: <20230215023706.19453-1-zev@bewilderbeest.net>
Date:   Wed, 15 Feb 2023 11:07:51 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zev Weiss" <zev@bewilderbeest.net>,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com
Cc:     "Andrew Jeffery" <andrew@aj.id.au>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Stafford Horne" <shorne@gmail.com>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>
Subject: Re: [PATCH] ARM: uaccess: Fix KASAN false-positives
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

On Wed, Feb 15, 2023, at 03:37, Zev Weiss wrote:
> From: Andrew Jeffery <andrew@aj.id.au>
>
> __copy_to_user_memcpy() and __clear_user_memset() had been calling
> memcpy() and memset() respectively, leading to false-positive KASAN
> reports when starting userspace:
>
>     [   10.707901] Run /init as init process
>     [   10.731892] process '/bin/busybox' started with executable stack
>     [   10.745234] 
> ==================================================================
>     [   10.745796] BUG: KASAN: user-memory-access in 
> __clear_user_memset+0x258/0x3ac
>     [   10.747260] Write of size 2687 at addr 000de581 by task init/1
>
> Use __memcpy() and __memset() instead to allow userspace access, which
> is of course the intent of these functions.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Looks good to me. I've added it to my randconfig build tree to
see if there are any build time regressions in odd configurations.
If you don't hear back from me until tomorrow, please add this to
Russell's patch system at 

https://www.arm.linux.org.uk/developer/patches/info.php

with my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
