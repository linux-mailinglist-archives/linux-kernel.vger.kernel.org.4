Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A826A0010
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjBWA3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjBWA3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:29:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D7E14981;
        Wed, 22 Feb 2023 16:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=TiNRSj4+ZSGQutD518+MqWdMvhGuHDdDC01fM8azAzY=; b=iWCl64GZ5mut3hpbv5f5+rGK1y
        gV9YgHPEUbchM9n4rUVss1dWd7ttjDHzA1RjT7QKM+tpx9xYnb1Fnj2T8ITpjytmH3cgP0FM6loy1
        KPvOwap0HKYkxNDpXhccsJosGQ3SPaiIFOJhY02ONs/CguLrr1Xom1jIA3wke3bUQkJc9p6pYQxqG
        0SKy7teVaSTlbLT6Nof4CCmmEBeChL1X2/C6uECO4hkQNeIOOKy8LpLoG+7YFL/r3h9XCHAikXWbN
        ps0uhcS3aRdw+H4sJcBXxo2GRN29URENt3UR4zs113hSzKYbuUXSrz480f1xDnsPLqMQ5C2KjJ1UQ
        26y+m+1g==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUzUK-00EXgZ-Ce; Thu, 23 Feb 2023 00:29:32 +0000
Message-ID: <6dc4d3ce-005c-13be-971b-1c026e3272c1@infradead.org>
Date:   Wed, 22 Feb 2023 16:29:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: .config and "make" / turning off all debug
Content-Language: en-US
To:     Hanasaki Jiji <hanasaki@gmail.com>,
        LIST - Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <CAMr-kF1LxzoOShd7nkE1Pc0ZZgTusB42rDep5ROPirLK9xK55g@mail.gmail.com>
 <1c1c0a3b-10d0-ef9c-e96c-a415bbe0bf33@infradead.org>
 <CAMr-kF0rCQZ6OQkb5g5pAzWddFKDv4CGYLFzDQs=hYLjJMsuQw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMr-kF0rCQZ6OQkb5g5pAzWddFKDv4CGYLFzDQs=hYLjJMsuQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/22/23 16:21, Hanasaki Jiji wrote:
> Hello,
> 
> Thank you so much for helping out.
> 
> Might the below accomplish the task?
> 
> cat f | grep -v DEBUG| grep -v TRACE | grep -v TRACING > newConfigFileWithout

It will disable CONFIG_DEBUG_FS.  That's OK if that's what you want to do.

But this will just give you something to begin with. It will need more work.
There are lots of config options that use "select" to force another config
option to be set/enabled. Even if you disable an option and you have one of
these other options set/enabled, they will just enable the DEBUG/TRACE options
again for you.

When you find one of these, they pretty much have to be checked and tuned
one-by-one. It can take a lot of time to do that.


-- 
~Randy
https://people.kernel.org/tglx/notes-about-netiquette
