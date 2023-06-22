Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7973A893
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFVStS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:49:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A25186;
        Thu, 22 Jun 2023 11:49:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so4297174a12.0;
        Thu, 22 Jun 2023 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687459755; x=1690051755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTWWr9tJnQHijM1+30APlf9i7SyoxuiakSSe3fQG1lg=;
        b=a00Rze6J/EIrwObhHeal9InuUPEitusy8avTtZGobT2sW9GbJK0plQ8IC4gJQXZHsO
         I2axBGrgsHYSkI1TJUUq5QVjb3n/u5W3t5UCQ8oSncPvJxXyRtl+wWk9WO1YElSm9Zm2
         oadFrfOaqWop5fuDU5PswUjjVMwBzfnyM5Z5M3c3feBIbEPykyL52tgqzzW9vfdZOAyu
         Il2F6YSSi+xIy5xECnCoj0WJuyEJeEq2JO1QJBs6a1DZkVTNj2OU6Cj3ykuZ9OhytGL1
         wHaFae8gtceYW2ttSz2U3wPg9p3+O+nLvNJp9wrtVYUHo39IwLTSmOoiQgauKFG//f+F
         fVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687459755; x=1690051755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTWWr9tJnQHijM1+30APlf9i7SyoxuiakSSe3fQG1lg=;
        b=UarN0AUkUm9BHGFNob7/5OB2Rb0/rczpSg/FalOzE4mBLrMvfyuPnWhOnMQ40YPZ9q
         g//Sp94Vq4FANuRSDs7sXHvYbzYHRqvAdqMt1ICAbiOWWyWZrX/NCsbskrrNQi4Mf3oG
         koBoXgYwAHWrduZPNCnqEEwbgXhUCQ8HMcCTYenLc4N7Eqq6cb6BLHcjyJWUwWm6qySw
         bCa4iO4FOLHLTAZ6dP36BVKJh2oP4MGNaN0jvhsP+0EpTNN0/+ORnI+bLtJ9hxiYw6xu
         ftj//e9cRNFVFkEXfKzgDJi81D+rAshmWmG0wrmBg6ObpiM9n255b4PSGHXyBGxLetQh
         f0Qw==
X-Gm-Message-State: AC+VfDzpxg6c2h4ErrTvPqRT6vFoY73oFf9dm5XDpFUPaJ1Ac3yWEZzj
        6BAxPODpmzzQMytSY3RwCnY=
X-Google-Smtp-Source: ACHHUZ5lNEt6Xn3glybW+6gOjKoTJmps4W+upXQiVfWNoIedyryCbGCGzIsOOvWSYFf60d8eyA+npA==
X-Received: by 2002:a05:6a20:7295:b0:11e:7ced:3391 with SMTP id o21-20020a056a20729500b0011e7ced3391mr17739760pzk.43.1687459755090;
        Thu, 22 Jun 2023 11:49:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001b03a7a40e7sm5739947plg.19.2023.06.22.11.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 11:49:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <76e66d6e-d1df-9114-2dc5-112c1d0999cd@roeck-us.net>
Date:   Thu, 22 Jun 2023 11:49:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] hwmon: corsair-psu: add support for reading PWM values
 and mode
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <ZJSASByXpzoZ0XyH@monster.localdomain>
 <0eeef6b2-9c9c-4b1a-8538-eb8ef5b1d628@roeck-us.net>
 <20230622195104.3f5b5351@posteo.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230622195104.3f5b5351@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 10:51, Wilken Gottwalt wrote:
> On Thu, 22 Jun 2023 10:42:31 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On Thu, Jun 22, 2023 at 05:09:28PM +0000, Wilken Gottwalt wrote:
>>> Also updates the documentation accordingly.
>>>
>>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>>> ---
>>> Changes in v2:
>>>    - removed cleanup and typo fixes, sticking to feature adding only
>>> ---
>>
>> Applied to hwmon-next.
>>
>> Note: The patch description should describe what the patch does,
>> which isn't just "Also updates the documentation accordingly."
>> I'll fix that up, but please keep in mind for later.
> 
> Thank you. So what is the best practice if the title tells it all? I'm
> always a bit uncertain what to add to the body if there is nothing more.
> Just repeat it?
> 

Pretty much yes. Plus added prosa if you like.

Guenter

