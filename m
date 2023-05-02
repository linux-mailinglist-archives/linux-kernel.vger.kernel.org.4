Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0DA6F44CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjEBNNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjEBNNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:13:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CDAE4D;
        Tue,  2 May 2023 06:13:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3063afa2372so334043f8f.0;
        Tue, 02 May 2023 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683033181; x=1685625181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZcW7jrDnKC9zCPrP6gmsLXf/LWgkWKa62M80P78wRk=;
        b=YfvFf2RMimcatujhspMXgRbTMWLWNEqGOBD+sRVLbkdNrULlEHTxyxNa+qiTJdH88o
         jgnKTvfml/t7VMIsWvUPC10KNIMqp9DYe1uHb9YX/vJz0yFAZ0iZRyn0lAoELvFLaJUi
         6EPSnuZ41QceUcDMvG3lQEZ80tm6k9adJEh83QljY5m4sd7AlWhPu40TMms0Gc59Wyub
         HCdX/tXkLtJWDMu5IJSlqMqbr5wuShzCQZw/zOYRUIFmM3UqMgu3XI8+PEC32DUHwhgF
         9qLeOpIN3Ws8RBZVet/tOFxArkUmkH41p8Pcii6h5jHfXzkyw75GEzjlV5fdX3PoqYtV
         seJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683033181; x=1685625181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZcW7jrDnKC9zCPrP6gmsLXf/LWgkWKa62M80P78wRk=;
        b=THjfWwt4uM5h92ijfXkRswuV1OyNyc3O5Cs2bxNYHz06p7BGp9buOVTC/1dj/jg5UB
         hRS2D3PSwiYjHdoxLIrCiXUvf2pRvt4pz14ljGLJN9pVIwVFhzKK00BfFVnzYc0YSYmU
         fYj3Q9SO0dmkGMiGgNNs5Zjf/Lwy05IZL762nhkK5EEsKzsMJxrwfvsw2bu8oGoYWDPx
         OjUf2wOBICOJ73T2znMJCFuhzBTmdfE/qF08hozKhdxoGKRqRGIq5iM6EOAP1Zs98m6k
         SsLYPLYQTWWoJBI6tXhAIYJEQJek96Dp+9s0TMAPuh1CJQW3iD8qMSNQ56WWMyTDmU6Z
         5w1Q==
X-Gm-Message-State: AC+VfDyPplrpMHd1p2X/abbJTl3TUSv82vRHz1jhCJ9EEnFY3Y84Hs+J
        ybR0W2iOvLidlSpGCOO2e5E=
X-Google-Smtp-Source: ACHHUZ5446mWo3My56TAv/HJSNT+pnZWvcmYHPKTRVAp/CrpHU3NQDvM192LBGNK4/V0Fv+dtUKc/w==
X-Received: by 2002:adf:e892:0:b0:304:a274:e17d with SMTP id d18-20020adfe892000000b00304a274e17dmr11891682wrm.63.1683033181304;
        Tue, 02 May 2023 06:13:01 -0700 (PDT)
Received: from [192.168.1.10] (95f1f744.skybroadband.com. [149.241.247.68])
        by smtp.googlemail.com with ESMTPSA id j5-20020a5d6045000000b0030626f69ee7sm7942188wrt.38.2023.05.02.06.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 06:13:00 -0700 (PDT)
Message-ID: <c7842e46-fc41-c989-b5e7-ec504cd0c8f2@googlemail.com>
Date:   Tue, 2 May 2023 14:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Linux 6.3.1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
References: <2023050123-resubmit-silica-ac32@gregkh>
 <c2ac55a4-aaf5-2f49-be08-d326fe0c17f8@googlemail.com>
 <2023050202-slouchy-princess-e7dd@gregkh>
 <2023050225-brutishly-enlarging-c54e@gregkh>
 <2023050201-bluish-habitable-474a@gregkh>
Content-Language: en-GB
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <2023050201-bluish-habitable-474a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On 02/05/2023 08:31, Greg Kroah-Hartman wrote:
> On Tue, May 02, 2023 at 08:43:47AM +0900, Greg Kroah-Hartman wrote:
>> On Tue, May 02, 2023 at 06:40:03AM +0900, Greg Kroah-Hartman wrote:
>>> On Mon, May 01, 2023 at 07:22:56AM +0100, Chris Clayton wrote:
>>>> 6.3.1 FTBFS thusly:
>>>
>>> What is "FTBFS"?
>>>
>>>> drivers/net/wireguard/timers.c: In function 'wg_expired_retransmit_handshake':
>>>> <command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
>>>> [-Werror=format=]
>>>> <command-line>: note: in expansion of macro 'KBUILD_MODNAME'
>>>> ./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
>>>>   223 |                 func(&id, ##__VA_ARGS__);                       \
>>>>       |                             ^~~~~~~~~~~
>>>
>>> <snip>
>>>
>>>> There's a patch to drivers/net/wireguard/timers.c that fixes these errors and you can find it at
>>>> 2d4ee16d969c97996e80e4c9cb6de0acaff22c9f in Linus' tree.
>>>
>>> Thanks for this report, we'll queue it up soon.
>>
>> Odd, that commit is in 6.2 already, so how are you applying this to
>> 6.3.y?
> 
> And this is only a gcc13 issue, right?  So it's not a regression, it's
> always been there, nothing new caused it in this release from what I can
> tell.
> 
> Actually I don't see how this is an issue in 6.3.1 anyway, as again, the
> proposed fix you gave is in 6.2, so what really is happening here?

You seem not to have seen the email I sent shortly after my original report. In that email I apologised for the noise
because, due to a caffeine deficiency, I had reported the problem against the wrong kernel version and that it actually
occurs 6.1.27. gcc13 spits it out as a warning, but kernel build system is setbup to treat warnings as errors, so the
build fails.

Chris
> 
> confused,
> 
> greg k-h
