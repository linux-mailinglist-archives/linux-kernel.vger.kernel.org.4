Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94AF743EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjF3Pfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjF3PfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:35:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2BE5C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:35:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BE81F5C163D;
        Fri, 30 Jun 2023 11:31:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 11:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688139082; x=1688225482; bh=up
        LBwBc2dBmHKX9v2pXFENlWMqDWFCIobcQ0HEfLYik=; b=IoTcM+BNU5go7enV0u
        JT9XMkqfYa+qdnubg8XHBYF5i2NXlo1fPOir8T9gSOmYLYMpuFSxn3GNQB3AGn+s
        7BfpTods5F9J1kJLl4nO3S61LUPhcF8jfTyqwB04PFuykuZHbHQzPLLzIpKJwqsY
        hBBJpbeQ0+GTse6FIeoTtMMOYvX2Wdbp8itXv7Q4u85pghNbUCeLexA79b/yEXBa
        gChy7+PUrSV/UlYFI1hWbWMoYl0AebKqaEQfVHAu9u8HP12coHAnFnlB81WMvVJ/
        BnRLGVToZB8scM6QJXWLEuZAx2IuhvYExOJUo1NopgYSaDJ3rUFlOQNqx8jaCGD/
        Zhow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688139082; x=1688225482; bh=upLBwBc2dBmHK
        X9v2pXFENlWMqDWFCIobcQ0HEfLYik=; b=dSAPUWjPp1SYx2dhvpDc6kP0C4o9a
        W0kiwUjeRa6rut+EfGy3P42zbh922ribXMJL+v+gMBV6g7YIHyV0LR5X+kGe2kpQ
        eLw8A+ar9zyIpRgI/nin3JlfuNFLpnIwdaHIzSDeEV6uYXns8HDuKaBI2YMzjb+c
        xAYJcOcRvb6oDTMb5iCQCLsr0gcJz+reoQmMio5yGRO6pwKZlRnGdmOvOsHJr2l9
        ZLwm8DcOKLsDabMw5s35yyXcPo9puH1MadTBf4iTeXUK4PxWMt5X2P5Es/gle9gE
        JO3gxF2j0JogtIhvBO+/zMmbU/uZwuEUDbVEs4KGAHBfmmBpTKuM+TEyw==
X-ME-Sender: <xms:SvWeZPVlXpa0WqrDZq4956SnxDgJS3IHYuk4KACxRyH5xAX5-2r1Yw>
    <xme:SvWeZHmjnZGfiKsXuXrI2INfaRI33I7gLBBWnmgLdafkhpL9ECNZAsfGFg56f0qR1
    upnW0lWMmMgBty0170>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:SvWeZLao6TmHJFrx3m7a1abR0ScevQl2ysVKrgAb1r68RwqxrZmFTg>
    <xmx:SvWeZKXFuzaAkLRaTR5DnB52NF0n1dVGTQ6Hs3XNolHIJNO19SVE_A>
    <xmx:SvWeZJkp5Ye0ibJuLPmUOVfA4COMkNxHhKpMIlnUQQgRsP6oRB5A-w>
    <xmx:SvWeZPX9ipntvWfaN-beytqmFz_yGGpiAJksGvMbhcdHAp-hOL0gCw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2B7DAB60092; Fri, 30 Jun 2023 11:31:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <51b8b3c2-f4ac-454c-acde-e1d136139109@app.fastmail.com>
In-Reply-To: <20230630152439.GA2900969@aspen.lan>
References: <20230517125423.930967-1-arnd@kernel.org>
 <20230630152439.GA2900969@aspen.lan>
Date:   Fri, 30 Jun 2023 17:31:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Jason Wessel" <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        "Doug Anderson" <dianders@chromium.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: include header in signal handling code
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023, at 17:24, Daniel Thompson wrote:
> On Wed, May 17, 2023 at 02:54:09PM +0200, Arnd Bergmann wrote:
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 8f6330f0e9ca..d38df14f71ac 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -4780,6 +4780,8 @@ void __init signals_init(void)
>>
>>  #ifdef CONFIG_KGDB_KDB
>>  #include <linux/kdb.h>
>> +#include "debug/kdb/kdb_private.h"
>> +
>
> Isn't is better to move the prototype for kdb_send_sig() into
> linux/kdb.h instead?
>
> That's what other kdb helpers spread across the kernel do
> (kdb_walk_kallsyms() for example).

Right, that is probably better here. Not sure if it's worth
reworking the branch if you already merged it, the difference
seems rather minor.

       Arnd
