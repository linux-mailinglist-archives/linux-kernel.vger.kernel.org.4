Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43616F3CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjEBFHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjEBFHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:07:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEE30F3;
        Mon,  1 May 2023 22:07:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f18dacd392so18697845e9.0;
        Mon, 01 May 2023 22:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683004023; x=1685596023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAJMVIT/KHYFMrxlleemTF6g4qpV2R5xLi0xj6uNV8M=;
        b=k4GtJq2oDk2Kknrh8Vg/oGIRFE4n7FPwb8a3PgRwTISa7UR9v3wyXQwCWFkqTZvuB5
         9hOryxxKz4ScHPSSTxkTF6oapgCU9tA+tMMM7/U8LMnP6KOAoLGa2jj4G0yFwU63pRaw
         W2zsTwHwq1TgvBCs7KdhH65SEoG6bn1ZDH8TU2KMZQHskJ66LQ+EsaHBQpIHxh4dk9kb
         YY6/kkk9CSBIcIiYo8ZtnDQHKKThBG5VeJ0XfAJubYvlHV7F+DVmKWwFM/kk71F1KLY8
         IN7XZFsgLm9y+bLmCr5D/tpZixus2yJYRqggEmHyHidFwd8xZJxyZRozW9DJXG8aZlX+
         Uwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683004023; x=1685596023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAJMVIT/KHYFMrxlleemTF6g4qpV2R5xLi0xj6uNV8M=;
        b=YQ49sasyFfq2i1fy+caZVNH02jCx0o+0hjQL1HnPB1ZKPqfDHEp/AwYCIIhMRbpiVe
         AczCq7tmM7yxY/e6+EmDE1NeV1m+wCvZMB3Kmvtm3v1S6nBbimFcSEr5/7PxW/IZOvTi
         0Ig3VuvgciYL1gWK0HTZLyfWDCiws7HYB3cKIRFxacanXZdvPO72HXm5WUVQxG2uKzFA
         aLsUNspelbUXmFmFwvfFHvlzTyJE7SerH82owqsQnRC3vcv24LXpHRmFR7yF7DNeLNN8
         LTOCUwcwDgUU6yYa59m1W9G6hS6THLhoIn1XaCX05QWgucGBJkUiD3U7ZQltvZmHB1Ls
         J0lw==
X-Gm-Message-State: AC+VfDw8e1Hu1wpYhLVK2rrrvaUNYsWOxFWbX3bnzZt9YgOdk6pjZ5Lp
        UjkJKklFzAg6uWZbQyr9Sn4=
X-Google-Smtp-Source: ACHHUZ6p/Mo4FTEB1faetZlKlr+HXytds5dbqVKzhrYQRF3MlUvOXV7Pzc0/U7dTu1Yi4xRQUFQBHg==
X-Received: by 2002:a5d:610e:0:b0:306:2a1a:d265 with SMTP id v14-20020a5d610e000000b003062a1ad265mr4555819wrt.58.1683004022917;
        Mon, 01 May 2023 22:07:02 -0700 (PDT)
Received: from [192.168.1.10] (95f1f744.skybroadband.com. [149.241.247.68])
        by smtp.googlemail.com with ESMTPSA id m7-20020adfe0c7000000b003048477729asm19746994wri.81.2023.05.01.22.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 22:07:02 -0700 (PDT)
Message-ID: <8b59fa15-e027-ae40-1bcc-fdf7c4c21c56@googlemail.com>
Date:   Tue, 2 May 2023 06:07:00 +0100
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
Content-Language: en-GB
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <2023050225-brutishly-enlarging-c54e@gregkh>
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



On 02/05/2023 00:43, Greg Kroah-Hartman wrote:
> On Tue, May 02, 2023 at 06:40:03AM +0900, Greg Kroah-Hartman wrote:
>> On Mon, May 01, 2023 at 07:22:56AM +0100, Chris Clayton wrote:
>>> 6.3.1 FTBFS thusly:
>>
>> What is "FTBFS"?
>>

Fails to build from source

>>> drivers/net/wireguard/timers.c: In function 'wg_expired_retransmit_handshake':
>>> <command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
>>> [-Werror=format=]
>>> <command-line>: note: in expansion of macro 'KBUILD_MODNAME'
>>> ./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
>>>   223 |                 func(&id, ##__VA_ARGS__);                       \
>>>       |                             ^~~~~~~~~~~
>>
>> <snip>
>>
>>> There's a patch to drivers/net/wireguard/timers.c that fixes these errors and you can find it at
>>> 2d4ee16d969c97996e80e4c9cb6de0acaff22c9f in Linus' tree.
>>
>> Thanks for this report, we'll queue it up soon.
> 
> Odd, that commit is in 6.2 already, so how are you applying this to
> 6.3.y?
> 
> Confused,
> 
> greg k-h
