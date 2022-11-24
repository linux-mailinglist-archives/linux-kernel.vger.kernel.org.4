Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8A6379CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiKXNSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKXNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:18:28 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CFD654EA;
        Thu, 24 Nov 2022 05:18:27 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2DE6F32009C6;
        Thu, 24 Nov 2022 08:18:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 24 Nov 2022 08:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669295903; x=1669382303; bh=4sKDJSN01P
        eIAiXQHaFqrZQX8gqaur58q7xvYuCCrEw=; b=DY52+Je6rlB55h4gnvNU+KhxnG
        +fF14yFdZ9YMTXe5RWTtb96nPdiXE9b7ZuQdIIAIjm6lYLqDt9kPoRLIOehaNBSo
        uhqHJSd6MZkq3jxyzQe5d0cY8EgbXyc3ANDEmkwGlILJIdVXhjKEILq9eue1QYr+
        SmrZEjlJMQt2div+xHqZ1xkJsUafpE5v/PkUxFF5mkPVw9rdk53Yfjgg7GaptpdQ
        tDw0ppZyl7Sp6dcw0hrWsLHhWLcUSc4mg8Y55NLkUgmeY9aomx8hsYnS20YAcPus
        NrJ0NIdALlEANOQ6t11fJppwBnfPmhQboDsSVbSjSnyI4jNOX36rh9HmbVXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669295903; x=1669382303; bh=4sKDJSN01PeIAiXQHaFqrZQX8gqa
        ur58q7xvYuCCrEw=; b=cHUsDg9USKksVIE/uaaxz8YGUoQJXPIPFXFBdKtr+8UR
        F/M6SjrokoS65iGn6reMTGQxDxGUR0EuTTT8r+xwNZWpdXSGb27fy3FIfuJKhq1b
        nIacplD12qe56DgdU0LqprZz22yJlLhjnuLw+0RQbZ6LGbGFD4oco+aIVAj1ujDF
        KZGgYQsDcXVYdR83TXItpaY7vN5eh3UWLbAjZgv6CVUhUP6uC5HMwnfMJyZolwJ6
        KpqKODvNXLYJ0F0rYpnyVz8Uy+jFUzOhM+/hK4eagtjChnMaUwjgW5kv2KW0QBfU
        bdxfn2ii6N2So5jluJ3V9u4NXMGFZLCOeLcSjQNq+w==
X-ME-Sender: <xms:H29_Y0Qq5JD6yf7CFoVYBOkq4svdhXxXMheSgqdh9Kh2pHUcmw7n_A>
    <xme:H29_YxwzxeXEvIyaFxHj2_TaD74MHm40xVdSoHcCrlDTfeDAuq4zU-5b24e6j3aDx
    9u6lbOzo-JZcW5M9E8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieefgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:H29_Yx1DEl7KyReL2IQVQu5LvTUalRSn0otglnXihmI5wpkk7WVLgg>
    <xmx:H29_Y4ANsr_zanA5MrUDVh5-lLct3tt5kaUB-3CShYkujPQwbZTuVw>
    <xmx:H29_Y9iDNEUwoPSIyQ_DDFkOQha36lWb9DsYpFFkERE6Vv1Kny0rUQ>
    <xmx:H29_Y-Us_IcDqiJyWRqnUuTp1dXhECKWovVznjJfYrYntzt8ZzEM0A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A8E8B60086; Thu, 24 Nov 2022 08:18:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <7928bec7-4659-4b32-aad7-2300409ea670@app.fastmail.com>
In-Reply-To: <Y39oBtR8t+XNPS0d@zx2c4.com>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
 <20221121152909.3414096-2-Jason@zx2c4.com>
 <87v8n6lzh9.fsf@oldenburg.str.redhat.com> <Y37DDX5RtiGsV6MO@zx2c4.com>
 <87a64g7wks.fsf@oldenburg.str.redhat.com> <Y39djiBSmgXfgWJv@zx2c4.com>
 <87cz9c5z1f.fsf@oldenburg.str.redhat.com> <Y39iisTmUO2AaKNs@zx2c4.com>
 <Y39oBtR8t+XNPS0d@zx2c4.com>
Date:   Thu, 24 Nov 2022 14:18:03 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "Florian Weimer" <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 1/3] random: add vgetrandom_alloc() syscall
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022, at 13:48, Jason A. Donenfeld wrote:
> On Thu, Nov 24, 2022 at 01:24:42PM +0100, Jason A. Donenfeld wrote:

> Looks like set_mempolicy, get_mempoliy, and migrate_pages pass an
> unsigned long pointer and I don't see any compat stuff around it:
>
>     SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long 
> __user *, nmask,
>                     unsigned long, maxnode)
>    
>     SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
>                     unsigned long __user *, nmask, unsigned long, maxnode,
>                     unsigned long, addr, unsigned long, flags)
>
>     SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned long, maxnode,
>                     const unsigned long __user *, old_nodes,
>                     const unsigned long __user *, new_nodes)

Compat handling for these is done all the way down in the
pointer access:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/mempolicy.c#n1368

This works here because it's a special bitmap but is not the
best approach if you just have a pointer to a single value.

       Arnd
