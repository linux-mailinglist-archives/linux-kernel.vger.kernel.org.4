Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4D6CC94D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjC1Rch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1Rcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:32:35 -0400
Received: from mail.unsolicited.net (mail.unsolicited.net [IPv6:2001:8b0:15df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D5AC15F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unsolicited.net; s=one; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kc456DPtUQD1rdek/W+RSgj2Goi0ZVlHnRSaIqKA6qk=; b=BuGG81BN9rrGtM/kJU7mkWGZcY
        h6sfqw4QVCSVZvCXHd7GYP4JMbl8uRAhg3Z6LwPDwSV5gCfOcZ26JoTENEWs4AtV/11JSbkvJ6vyo
        M8A5x9B2NxHLbvJFFFu5iCjrJExZarlAEBiWw2cjbGqgXK8oKarFljqFHM69I/FslyW4kpbR7FcBa
        E2ozfhyQNhBL3+oG4t0v+vI3DMoupleVe5TXYpCzBshWwI0K6nQV7/dxGjb+bS1AWFW5ofg4F28it
        IXKfzGjDi+PkOYR+l0ylJ6dYqGzhSZz8xXS7EWBR3eqoxtOh5WPq6ULN/SpX+BTBWNUNDjq3Vepml
        8KfvpHqA==;
Message-ID: <97f68715-0dd3-6037-7945-f1f724e210f4@unsolicited.net>
Date:   Tue, 28 Mar 2023 18:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
 <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
 <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
From:   David R <david@unsolicited.net>
In-Reply-To: <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 18:10, Borislav Petkov wrote:
> On Tue, Mar 28, 2023 at 04:06:41PM +0100, David R wrote:
>> Yes, that patch fixes it also. By all means add my tested by:
> Ok, thanks for checking. That issue is still weird, tho, and we don't have
> an idea why that happens.
>
> If you could test your original, failing kernel with "nointremap" on the
> command line, that would be cool.
>
> Thx.
>
I can't reboot now 'till Thursday. Will try then and report back.
