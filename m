Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E859B627723
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiKNILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiKNIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:10:59 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4759611A12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:10:58 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id l8so12106274ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3H0LxXhpL76jfnhP8PQ1RHBeIChC4ZVpOi0Wx0bdW8E=;
        b=TkRLz+/gekpKO7S03tCmLxg4IKlHcjnVElTWA9QX1RVVKswKNfXp4+60Rl3D5+XVI4
         SzjaGBYtEuZJHqg3BRzS6OSbgjA9h3l75d5JTgRwrPxGf+17eYdYdC/D9cJwtxBvwmNC
         gBRp2X/yrXnF+GhrXvuZGKqpERZM/lsgSvdrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3H0LxXhpL76jfnhP8PQ1RHBeIChC4ZVpOi0Wx0bdW8E=;
        b=vG0MpIDvsyiR+z9xf8J0s4WS++3WPIYvRds+yJnLVg9aLfJeUcSKa8ca+5HI+r2kop
         c1pWbAN4oJV44Igys84H0t29zBK5+bQSi712aKCUyzf0awgQaHt/4X3PsIGy4TjK5RIa
         9yEvy0VWaw0wvEOWkEa4chTkUJRFE9oA32knfqFML5+QD+5oeG9OVN8qXad50xZhTEUY
         /CJXa1HalmJLa+t5JySgTHX5iaDtVH3ojhisdEUh1tyhBp/WDyQKrC6bWKjkpOWDwHjM
         kwxKoKUeQ7f5CENMwC2cqwQmEIFxr0hLklpWZSRYTZGGBiv952dps/wb31D7e4KXwxnW
         kgWg==
X-Gm-Message-State: ANoB5pkWui4Wq/E/vNBNyp/qbPxLbTFbSZ01JNf/EIhb4lOaJqTJnHtH
        DswHgsXQLs7PwQmj2HWBmtaKDA==
X-Google-Smtp-Source: AA0mqf5KtaHWmZmBx8dX/kqroR0rymfu6pyC/o70E1rrGmIGAUsbgDoZAZx9JhPVWx8avRTfMy8FTg==
X-Received: by 2002:a2e:8706:0:b0:26d:e3ae:886a with SMTP id m6-20020a2e8706000000b0026de3ae886amr4049310lji.531.1668413456613;
        Mon, 14 Nov 2022 00:10:56 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o22-20020ac25e36000000b0049fbf5facf4sm1720992lfg.75.2022.11.14.00.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:10:55 -0800 (PST)
Message-ID: <feafad6d-736d-27a5-380d-e8a531b4c46b@rasmusvillemoes.dk>
Date:   Mon, 14 Nov 2022 09:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/5] dt-bindings: iio: ad74413r: make refin-supply
 optional
Content-Language: en-US, da
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221111143921.742194-3-linux@rasmusvillemoes.dk>
 <20221112165448.17489ef1@jic23-huawei>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221112165448.17489ef1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 17.54, Jonathan Cameron wrote:
> On Fri, 11 Nov 2022 15:39:18 +0100
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> The ad74412r/ad74413r has an internal 2.5V reference output, which (by
>> tying the REFOUT pin to the REFIN pin) can be used in lieu of an
>> external 2.5V input reference. So stop marking refin-supply as
>> required.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> 
> Interesting corner case.  Given we have no way of knowing if the
> wiring has REFOUT connected to REFIN I see two ways we should fix this.
> 
> 1) Just have any DT doing this provide a fixed regulator.
> 2) Have the REFOUT supported as an actual regulator - in theory it might be
>    wired to other devices.  This might get a little interesting ordering
>    wise as we'll want to register the regulator before we try to consume
>    it in the same driver.  I'm also not 100% sure there are no other issues
>    in a driver providing and consuming the same regulator.

Hm, I don't like the idea of exposing REFOUT as a real regulator. As you
write, there's gonna be interesting chicken-and-egg problems, and I also
don't think it can actually deliver any meaningful current, i.e. it
can't really (and shouldn't) be used for supplying other peripherals.

A third option is to have a boolean property to explicitly indicate that
"yes, we're using refout as refin", and then make the requirement in the
schema be "refin-supply XOR refout-as-refin".

But I think the simplest is (1), I will just add a fixed-regulator with
a suitable comment in my .dts, and patches 2,3 can be ignored.

Thanks,
Rasmus

