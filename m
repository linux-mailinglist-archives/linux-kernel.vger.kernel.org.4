Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D730D6113B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJ1N47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJ1N4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:56:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6745D8A2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:56:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id q5so2951001ilt.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNmbf1DrFhGYblawzk2OE47DJTJRUcUrHVQAL/CfprY=;
        b=dG6ulbLayOltV06VckG15ZM5FJG6iiZzromr13Dxi9USxiXVkCtDGqYIAKXSbEjEsg
         6/4zFI9eNDP16ioOt8eBqfK8LLHx9YAtHYAYPLbwGmmU5UBbzmoybUtx16fyzkvhSzR3
         HPY9oV/7QoeTtkKuooaEE+gZnrMu+aqm39boPj7zzGFLLvQJ6VBcsZBBqut7VaIb/buj
         q895fmC/zzzcl+kzWfQ5az43Fi57FG/UVkb72MqRQqVdXSkkuM09YdFcOS8Tska1OEc5
         j3FPfxhv11zq8/5nlaYYCS0Zbo0fVkH/+r+h15pChOem9+8KkNlUI3gQ8khWOzAEmFqK
         kHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNmbf1DrFhGYblawzk2OE47DJTJRUcUrHVQAL/CfprY=;
        b=7lPv4BYgw9AbUzDbIRGNDxnmsvxPL9jSrj7E4VOpHloYzfXhtJwKkyCNC7aw+bAVWx
         aY9R2xBAiJd5YbFZnoPa78yLr4uyg24l7Uw6gQ47E1kejPY49npUWvvl4TqAHdXZe2di
         Pfg5S17A02fthJQUmMPWn6L7vQYWhl36O/M5QHJ5eFxcjD5ps+NqSqqYFme6xh+1FLv9
         kY9oiypnWDW6k4Nj/BxYH3dvoWMtf56yGqV5zdU6W1791enmcRINM41nzYk28cy+ksY6
         LPEDo9uvDuqKb5UGcfOSjhWl1c9C+f78EQnEx97FA78G0z6H7A414jF8Tn0AWyO86pES
         cCtg==
X-Gm-Message-State: ACrzQf0YhF+AIiyumLnw9UyvSLk5rSi5jTfAr9ttet8iv2yfA0w9H02p
        n309xt/nX/XvgPmSzZHXdu2Ecg==
X-Google-Smtp-Source: AMsMyM67Rc2FdwlFNx71PR911GhNj2eaxZcauUCfpYlVrbJm9CnlVNFcL7nioQrLtCwqwEdextZnag==
X-Received: by 2002:a05:6e02:1e02:b0:2fc:6288:e6e6 with SMTP id g2-20020a056e021e0200b002fc6288e6e6mr35376483ila.172.1666965412619;
        Fri, 28 Oct 2022 06:56:52 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k11-20020a0566022a4b00b006bba42f7822sm1704584iov.52.2022.10.28.06.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:56:51 -0700 (PDT)
Message-ID: <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
Date:   Fri, 28 Oct 2022 07:56:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC][PATCH v2 04/31] timers: block: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, drbd-dev@lists.linbit.com,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20221027150525.753064657@goodmis.org>
 <20221027150925.819019339@goodmis.org>
 <20221027111944.39b3a80c@gandalf.local.home> <Y1uSG/7VXWLNlxlt@infradead.org>
 <20221028062414.7859f787@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221028062414.7859f787@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 4:24 AM, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 01:26:03 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> This is just a single patch out of apparently 31, which claims that
>> something that doesn't even exist in mainline must be used without any
>> explanation.  How do you expect anyone to be able to review it?
> 
>   https://lore.kernel.org/all/20221027150525.753064657@goodmis.org/
> 
> Only the first patch is relevant to you. I guess the Cc list would have
> been too big to Cc everyone that was Cc'd in the series.

No it's not, because how on earth would anyone know what the change does
if you only see the simple s/name/newname change? The patch is useless
by itself.

-- 
Jens Axboe


