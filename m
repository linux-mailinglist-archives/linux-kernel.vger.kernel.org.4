Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1C6DFBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjDLQpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjDLQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:55 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44E8A4F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:14 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-328790455e2so603195ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1681317852;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mm8kbHYrCQNTaHWa60xBqhByQjBNLY1ech70JwtZAjg=;
        b=OkIpXosaPkxCs+UGD9cTMhSViJnjCbNl6JleEBijVM297QurYnyHGCtXvgQ/EeE6+e
         ScEsfB3A5F0ZJCZoyRCdZNe8zqHkOWUz9tjGbn4qsZtzdSkpgAO7pCI48UmcqbNRcgMO
         nwmbQHHC0tAGiCD3e9s4paAHirjoQXolQKBJfwgvHNxHkCFrz4NBA1gnfBWmMMgOUn1z
         HKeJ2AG35IweUPhZyEb+kKUo2a781EhaQ5s7kcLzRnDpU6zYLLh9s4gFXBSVt0BpvIry
         n2TlKj8D7ovBTgAJPVgfRG0oC0rcihFUTRAC+oaPKMC79K0EzIZ1RYD05NMFcfmQHz59
         QU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317852;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mm8kbHYrCQNTaHWa60xBqhByQjBNLY1ech70JwtZAjg=;
        b=hVMYhg5Fj6lQqzZGoTwRMHyXtJXBnZx49oUcZ+JBytDbGgHeda55lLIQw1N2PpZoG9
         Ep9u8vFeY26yDIW4mgtN8AeGw7aIxzNLtG9omVyBWf0eu6pHVc30/GuYZoJ6egFmMoHV
         av/58ZF2PUR2zTFAQTTzsj4wb7Zk28g+82Ov3YhMsiwy7JrNyUil2x4qjfDIIoNkeVXl
         +hqdwLQRT53sP+y2seZSBHJ542qmMQsDIuWIaJYeFWV6ILdJc3WW9rbiW1umxAnFy7+4
         3KS93vwK6SLDoJnB3kAw981eEUTi1m4XSfzw7QmuzdadF3LqdPq0ZFKzvmJj7MUCPJv5
         cqKg==
X-Gm-Message-State: AAQBX9eTVZVT1CupbCnwIMYT+/Rivl4nXt0jhSGnsH08Z58SS9UBzxeO
        H94k30LAPavX2gPJ41N0tdm/LN6UwDja3pCQvUc=
X-Google-Smtp-Source: AKy350aCbqXbJ8SMW18VYbeqLkyyNTlMJvvyW2NhW+zOqVuXlnrXOBq6fPYXFxDwuZ2dKJ7DayxDvw==
X-Received: by 2002:a05:6602:1652:b0:758:5653:353a with SMTP id y18-20020a056602165200b007585653353amr1908221iow.0.1681317852393;
        Wed, 12 Apr 2023 09:44:12 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a36-20020a029427000000b0040bda8fa34bsm1746214jai.120.2023.04.12.09.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:44:12 -0700 (PDT)
Message-ID: <c4d8e079-91bd-62e8-7725-b03802398c83@kernel.dk>
Date:   Wed, 12 Apr 2023 10:44:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: build warnings after merge of the block tree
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
 <20230412162517.gji52t34zlvcu5bh@treble>
 <6527c6fa-8908-1d8d-2f9e-bb7636a27874@kernel.dk>
In-Reply-To: <6527c6fa-8908-1d8d-2f9e-bb7636a27874@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 10:35 AM, Jens Axboe wrote:
> On 4/12/23 10:25?AM, Josh Poimboeuf wrote:
>> On Wed, Apr 12, 2023 at 01:44:00PM +0200, Peter Zijlstra wrote:
>>> On Tue, Apr 11, 2023 at 05:14:00PM -0700, Josh Poimboeuf wrote:
>>>
>>>> Peter, what do you think, should we make track uaccess state across
>>>> function boundaries?
>>>
>>> So IIRC the goal was to explicitly dis-allow that. You want minimal code
>>> executed with STAC and hence disallow calling stuff.
>>
>> I guess I was wondering if we could make an exception for calls to
>> static IPA-optimized functions, so we wouldn't have to scramble to "fix"
>> compiler optimizations.
>>
>> But for now, yeah let's just keep it simple.
>>
>> Jens, can you confirm this works?  I added __noclone instead of removing
>> static.
> 
> Yep, works for me.

Want me to slap that patch on top of the branch that has the commit
that causes it?

-- 
Jens Axboe


