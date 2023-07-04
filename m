Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4307473D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGDOPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGDOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:14:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844FB10A;
        Tue,  4 Jul 2023 07:14:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-262dc1ced40so4083967a91.3;
        Tue, 04 Jul 2023 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688480097; x=1691072097;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QgB13psqQE1OFxtkdS1ynmu4A8Mhjw7KqOCcMbKwtU=;
        b=qqb1nMgoJRUWowosrnowD9I/gWNDsXSL5xuFJdTEuhzjP1MY7EvxcYu4VPMofcn9W7
         SsyzQyhFGHHiITsP9A6khw609oq2VI33cVx4p9PQcvow+PJ0NXKnIkxE7GrLnge6LLxF
         AivaK7CaW3jhAJeRabnEAmiTyHgvEMv8sQHVGNYcI9Iq5n4d4FziMA++N96n52qejePQ
         hYA5YMKJ69idd6Dhd5z7zF3ofTiTD5CAzoC8Mah6ZtZu9O/Cu43SNmc9ELU/IA8xyQCq
         qjLjnYOtW+ulokHzgdenWVxXnzvNQbNENFi7bXeI5i+mwEvCO3WcsnFpfaSdQ2zZJdoG
         S6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480097; x=1691072097;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QgB13psqQE1OFxtkdS1ynmu4A8Mhjw7KqOCcMbKwtU=;
        b=QUhKUQrSrb4MZgTigcmRyeW5MnbqU9wZdjS5sIAwUyy7S7WYYzRqp6leqwEf5tJKFO
         x9NnuwKzs9dA6LaWzV0lcnBnRkxYzQLPJjj/h9HJX31TkpgfJliHnZKRqbB11u6HQ18/
         z5hlrOOAC5zaxCzfX4ill0hw2wv73GxZbiVZJNWljpevSKJdaA1GoppjFhZxqrvQYEgq
         ygFE42iRS7Kx0YLjLDCdIlo0ZN9K7llG3AsFfDQm0UxBOJ1G1ix+nMS2ImR6JSpsLTx7
         +tW89QVgZtWHK06wisUOShvXX1lo0TkUeUzeWjkijcozKPAu5rgiSi0q1FQGGi7Y5GyT
         je3A==
X-Gm-Message-State: ABy/qLYm+GGqyvkEFdzcrH2kKlswYXtO0fKfOAjC9k8G4WzOnv1Dx1ir
        EtrytH3Ee64aUqzioMV11zY=
X-Google-Smtp-Source: APBJJlFqZ414v7vVxIF3UlrCepWUrzWpu+ThtZ8z42vrGD4rT0rLOQj6t+OxZoH4qj/MeTjIdx1/Lg==
X-Received: by 2002:a17:90a:c918:b0:263:27f5:d447 with SMTP id v24-20020a17090ac91800b0026327f5d447mr14114888pjt.9.1688480096618;
        Tue, 04 Jul 2023 07:14:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pj12-20020a17090b4f4c00b00262e76b2b76sm15312234pjb.37.2023.07.04.07.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 07:14:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cb71b00e-0225-ea24-b30e-4d615af026f0@roeck-us.net>
Date:   Tue, 4 Jul 2023 07:14:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-hwmon@vger.kernel.org, samsagax@gmail.com,
        linux-kernel@vger.kernel.org
References: <20230704131715.44454-5-gregkh@linuxfoundation.org>
 <20230704131715.44454-6-gregkh@linuxfoundation.org>
 <a9c6c44c-21fb-9d42-9a6d-6685e110015d@roeck-us.net>
 <2023070402-festive-rind-9274@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: (oxp-sensors): remove static board variable
In-Reply-To: <2023070402-festive-rind-9274@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 06:44, Greg Kroah-Hartman wrote:
> On Tue, Jul 04, 2023 at 06:39:07AM -0700, Guenter Roeck wrote:
>> On 7/4/23 06:17, Greg Kroah-Hartman wrote:
>>> Drivers should not have a single static variable for the type of device
>>> they are bound to.  While this driver is really going to only have one
>>> device at a time in the system, remove the static variable and instead,
>>> look up the device type when needed.
>>>
>>
>> This is expensive. I think it would be much better to just move
>> the board type detection into the init code and not instantiate
>> the driver in the fist place if the board type is unknown.
> 
> The board type detection is all over the place in the driver, it's not
> just for "unknown" types, so how about just saving the board type at
> probe time and using it then for all other places?
> 

I must be missing something. The current code detects the board type
only once, in the probe function. Otherwise the static variable is used.
You are replacing it with repeated calls to get_board_type().
The whole point of the static variable is to avoid the cost of repeated
calls to dmi_first_match().

>> We can handle the static variable separately if it really bothers
>> you that much.
> 
> I did this change to make patch 2/3 more "obvious" what is happening
> when the in_visible() callback happens, so that you don't have to worry
> about the saved value or not.  But this whole patch isn't really needed
> if you don't mind the lookup just happening in the in_visible() callback
> for the first time.
> 

That would at least be a minimal change, and just add one extra lookup
which is only called once (or zero, if it is used to save the board type).

As I said, my solution would be to move the board type detection
into the init function and not instantiate the driver in the first
place if the probe function would bail out anyway. Personally I'd keep
the static variable for simplicity, but if you really dislike it
that much, we could pass it around in platform and later driver data.
But it seems to me that this could (and should) be a separate patch
that doesn't have to be hurried in.

Thanks,
Guenter

