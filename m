Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0867EF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjA0UaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA0UaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:30:10 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A52206A5;
        Fri, 27 Jan 2023 12:30:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5ED415C01A8;
        Fri, 27 Jan 2023 15:30:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 27 Jan 2023 15:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674851408; x=1674937808; bh=nsKMujgHaL
        Y06Z60XDpE/49QHk0wefW3Lo/F1Xp7zUM=; b=HYmH0QcR3/psxkBhw/EvTML6hq
        0Pd/OBAtd8I19c/COnq5q+qaLRSSB1T1IpY0ChCtx5uMrN+ORzFynxWf2CrioiKC
        ITaJWEPjNs9lrnGrN/66KSqrVlBjbnAXQl1TFIRaqjljM9SWhh5Fwcest3HMZwCL
        l/PxWiKD3oUQAXk/vcJQXe8qjV1AGgXX7hzsgzgusJSN6yQ8735ZugCC7Xt8jqwa
        zik/nhOUACV2FCT9CqbLAaKWWPxf/NprfbVX4sdvLqJhuI4O5PYGMO5cXSF/ip0P
        1TJuwA9yKi1AeqkbVw5YjeqFe8Pq96a/MjB1dAim9w9UTT0DumbxEvGWdH3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674851408; x=1674937808; bh=nsKMujgHaLY06Z60XDpE/49QHk0w
        efW3Lo/F1Xp7zUM=; b=YMo8npnV8lH5He9UCVqTG4ts1Mfe7ZkfgOOYZ8NTxhkA
        FBIGM7ncQeToyt8tRxwBYTy2Tam83W6RY/v9TSx1sDxBvy1BaV9HDxBuTsrs4SV/
        jkpmq+FnyXo01fD4DDAiUUprCTDaE364HyslOTvZgdsmKVIUxmWsthCs9FKRcvY8
        b0j81RMWpMwR4QqjKRmlUyDazvhVoRlR7qevhjXSPs+DtLKZ12eS+r1FS/ZTbCPV
        MkyOYqKYgvz6eUEYrrvYBIAS/SLr4n6JABW0iAz2z67uv9q9OjoqRqGSMeuxsCww
        7IdirA2qTAYj5h+1dGcY8u5I6Hz+bCVw6xKG/Tneiw==
X-ME-Sender: <xms:TzTUY7a5he62X8_DiACFANlDWvI_mZnN3XJZRjEycIROxv3UCw9buw>
    <xme:TzTUY6ayhwNOzWWsPriSpWoAZUcPMZag95wP4eRgm4jWFzsajY0lAcxOIV080FiL0
    PblneE9lHlQdkrpjvE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtse
    httdertderredtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgu
    segrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhepffehueegteeihfegtefhjefgtd
    eugfegjeelheejueethfefgeeghfektdekteffnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TzTUY9-MsAfMXPAywJB44obE0aKvvX7qPe9kd_8anLBQ8SpOIAaZaA>
    <xmx:TzTUYxrBM2kWzENul7yOifAcobq9u8OWXvMOxtv4tee_NGGjIQuhrA>
    <xmx:TzTUY2pYwhZ8MNGUD2PAVbkJr4BkuhKVmfqfWSATBrgoM7FnDsIlxw>
    <xmx:UDTUY3f4TK20d-Kx9TwBMk1Zf2Wl07FObxn4C_PxaXtkjwelTvTNBg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE676B60086; Fri, 27 Jan 2023 15:30:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <12e9afc8-cec4-4fce-ad81-09790cbe3938@app.fastmail.com>
In-Reply-To: <Y9QqFJUFo1RAbIqP@cmpxchg.org>
References: <20230126175356.1582123-1-nphamcs@gmail.com>
 <20230126175356.1582123-3-nphamcs@gmail.com>
 <54c8ecbd-1d6e-40f1-af30-7efd04c63a7e@app.fastmail.com>
 <Y9QqFJUFo1RAbIqP@cmpxchg.org>
Date:   Fri, 27 Jan 2023 21:29:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Johannes Weiner" <hannes@cmpxchg.org>
Cc:     "Nhat Pham" <nphamcs@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        "Matthew Wilcox" <willy@infradead.org>, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v8 2/3] cachestat: implement cachestat syscall
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

On Fri, Jan 27, 2023, at 20:46, Johannes Weiner wrote:
> On Fri, Jan 27, 2023 at 04:46:38PM +0100, Arnd Bergmann wrote:
>> 
>> - if you make it a 32-bit type, this breaks calling it from
>>   normal userspace that defines off_t as a 64-bit type
>> 
>> - if you change it to a 64-bit loff_t, there are three
>>   separate calling conventions for 64-bit, 32-bit with
>>   aligned register pairs and other 32-bit, plus you
>>   exceed the usual limit of six system call arguments
>
> That's a good point, thanks for raising it, Arnd.
>
>> A separate problem may be the cstat_version argument, usually
>> we don't use interface versions but instead use a new
>> system call number if something changes in an incompatible
>> way.
>
> I suppose from a userspace POV, a version argument vs calling a
> separate syscall doesn't make much of a difference. So going with
> loff_t and dropping cstat_version seems like a sensible way forward.
>
> As an added bonus, versioning the syscall itself means the signature
> can change in v2. This allows dropping the unused flags arg for now.
>
> That would leave it at:
>
>   int cachestat(unsigned int, loff_t, size_t len, struct cachestat *cstat);

There is still a problem of incompatible calling conventions:
on architectures that require even/odd register pairs, this would
end up like

int cachestat(unsigned int, long unused, u32 off_low, u32 off_high,
              size_t len, struct cachestat *cstat);

A more portable way to do this would be to pass the offset by
reference, but that makes it a bit awkward in userspace.

Or the arguments could be rearranged to put the low/high argument
pair first/second, third/fourth or fifth/sixth argument, at least
on the kernel ABI to avoid having another situation like
sys_arm_fadvise64_64.

> and should we ever require extensions - new fields, flags - they would
> come through a new cachestat2().
>
> Would anybody have objections to that?

If there is room for another argument, I would keep the 'flags'
as a way for extending in a compatible way, that is pretty standard
now, just not flags plus version.

      Arnd
