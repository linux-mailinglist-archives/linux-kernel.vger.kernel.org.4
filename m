Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3E64889D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLISsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLISr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:47:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE93621800
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:47:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so495203wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/OvMNsAzsgvJI+DZSdj+rRXl8KhhsBZiWxKq1VinuU=;
        b=jKuZ2r1dZ9JWyv8xEkfsg1ahawfcwPcqDQoraXkbZWZ4QIJ++dVVmyX5gAU4P8Io6r
         9coPM6MsAWm4lQxNiw38VgBJZcwIGJAWBUMlk1+7gXNnM7m96lun8idFeh5suqj+uhoc
         HjRULtC/TJ+I5PchhXGQJaeoZh1cEqMvLO7Q6pBzsZYhJZ0FhRlQ/OSU8F+42Sw3VJuR
         zvVmQSr/ljRQc5kf6d8XW9XseoXr8QlHkBNxMrXDD9+5XYT2j9NWcIjGCu+qon4a82Yh
         zuq7K6JFlP3qcL9NJivzznEpiEd7O4J4D03rZ+AwNgKi+nTBbUVgg0sy0CmhmwJuD9B/
         BBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/OvMNsAzsgvJI+DZSdj+rRXl8KhhsBZiWxKq1VinuU=;
        b=zeFgL69caF/PlbPHp/h8H9VFcWv9M35sJh1+SAjN5AKx5L5aNDuInaLpOASMg/Vhn5
         k6LMVYi4z10pU6ZnjDutUPYiyMFBc2E2MBrGo3rkKTqrqnCX+AZpoUdVFK7Sdqzk8npb
         Eh3qoeGgnLPP3joyt0PCtQ+Jhd4zJKQisnM3/xqeZUOGRu0VgTLBrqFFUIDmgu7EYzgO
         wJQpCB5NIQE9uQodO9RiY9F6xejfvxETTVpiFio/TL9NMIJgL/P/+JPHGQ7IwEgC2MM7
         sODjIrsZwrBV8GF6Tgx06NSK9aBCt5nqJ7bNqV2Knd3+hy/c0SWxEnDyFYh+PYoDmtTf
         lGnA==
X-Gm-Message-State: ANoB5pmTPpw21y0GrvDiIf1er/VWO0q5YCuvsC855QcZUMOxRON+2NT4
        mdruFvwjqEiSk5Z3TmVLSe97jw==
X-Google-Smtp-Source: AA0mqf4UtXIeSfB9Qa5J05ZKIxiW/RlaRPZKaGNAZ49pGJH6Vt8aX5PWE/7qp5pgk18fXnOeuSAkrg==
X-Received: by 2002:a05:600c:5012:b0:3cf:6c16:2622 with SMTP id n18-20020a05600c501200b003cf6c162622mr5684378wmr.33.1670611675506;
        Fri, 09 Dec 2022 10:47:55 -0800 (PST)
Received: from ?IPV6:2003:d9:9703:3100:a3be:b12f:5235:421? (p200300d997033100a3beb12f52350421.dip0.t-ipconnect.de. [2003:d9:9703:3100:a3be:b12f:5235:421])
        by smtp.googlemail.com with ESMTPSA id bu26-20020a056000079a00b0024207ed4ce0sm2057346wrb.58.2022.12.09.10.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 10:47:55 -0800 (PST)
Message-ID: <be5a4c10-3b69-1c2d-d413-62f79ccc178b@colorfullife.com>
Date:   Fri, 9 Dec 2022 19:47:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Invalid locking pattern in
 Documentation/kernel-hacking/locking.rst?
To:     "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1vier1@web.de
References: <442ecdf402f8e726f2be4ab19c7299d272e27c0b.camel@siemens.com>
Content-Language: en-US
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <442ecdf402f8e726f2be4ab19c7299d272e27c0b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 12/9/22 13:23, Sverdlin, Alexander wrote:
> Dear documentation maintainers,
>
> the latest version of locking.rst contains the following (since 2005):
>
> "Manfred Spraul points out that you can still do this, even if the data
> is very occasionally accessed in user context or softirqs/tasklets. The
> irq handler doesn't use a lock, and all other accesses are done as so::
>
>          spin_lock(&lock);
>          disable_irq(irq);
> "
>
> Isn't it "sleeping in atomic" actually because of the sleeping
> disable_irq()?

Good catch!

The documentation of disable_irq() claims that the function is safe to 
be called from IRQ context (for careful callers)

But it calls synchronize_irq(). And synchronize_irq() claims that the 
function can be called only from preemptible code.

The change was in 2009:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.1-rc8&id=3aa551c9b4c40018f0e261a178e3d25478dc04a9 


@Thomas/@Ingo: What do we want?

Declare disable_irq()&synchronize_irq() as safe from irq context only if 
no threaded irq handlers are used?

Or declare both function as preemptible context only?


The update for locking.rst would be to switch from spin_lock() to 
mutex_lock().


https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L126

> /**
> * synchronize_irq - wait for pending IRQ handlers (on other CPUs)
> * @irq: interrupt number to wait for
> *
> * This function waits for any pending IRQ handlers for this interrupt
> * to complete before returning. If you use this function while
> * holding a resource the IRQ handler may need you will deadlock.
> *
> * Can only be called from preemptible code as it might sleep when
> * an interrupt thread is associated to @irq.
> *
> * It optionally makes sure (when the irq chip supports that method)
> * that the interrupt is not pending in any CPU and waiting for
> * service.
> */
> void  synchronize_irq 
> <https://elixir.bootlin.com/linux/latest/C/ident/synchronize_irq>(unsigned  int  irq)
> {
> 	struct  irq_desc <https://elixir.bootlin.com/linux/latest/C/ident/irq_desc>  *desc  =  irq_to_desc 
> <https://elixir.bootlin.com/linux/latest/C/ident/irq_to_desc>(irq);
>
> 	if  (desc)  {
> 		__synchronize_hardirq 
> <https://elixir.bootlin.com/linux/latest/C/ident/__synchronize_hardirq>(desc,  true <https://elixir.bootlin.com/linux/latest/C/ident/true>);
> 		/*
> * We made sure that no hardirq handler is
> * running. Now verify that no threaded handlers are
> * active.
> */
> 		wait_event 
> <https://elixir.bootlin.com/linux/latest/C/ident/wait_event>(desc->wait_for_threads 
> <https://elixir.bootlin.com/linux/latest/C/ident/wait_for_threads>,
> 			!atomic_read 
> <https://elixir.bootlin.com/linux/latest/C/ident/atomic_read>(&desc->threads_active 
> <https://elixir.bootlin.com/linux/latest/C/ident/threads_active>));
> 	}
> }
> EXPORT_SYMBOL 
> <https://elixir.bootlin.com/linux/latest/C/ident/EXPORT_SYMBOL>(synchronize_irq 
> <https://elixir.bootlin.com/linux/latest/C/ident/synchronize_irq>);

https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L716

> /**
> * disable_irq - disable an irq and wait for completion
> * @irq: Interrupt to disable
> *
> * Disable the selected interrupt line. Enables and Disables are
> * nested.
> * This function waits for any pending IRQ handlers for this interrupt
> * to complete before returning. If you use this function while
> * holding a resource the IRQ handler may need you will deadlock.
> *
> * This function may be called - with care - from IRQ context.
> */
> void  disable_irq 
> <https://elixir.bootlin.com/linux/latest/C/ident/disable_irq>(unsigned  int  irq)
> {
> 	if  (!__disable_irq_nosync 
> <https://elixir.bootlin.com/linux/latest/C/ident/__disable_irq_nosync>(irq))
> 		synchronize_irq 
> <https://elixir.bootlin.com/linux/latest/C/ident/synchronize_irq>(irq);
> }
>
--

     Manfred

