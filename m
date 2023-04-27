Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604EA6F0791
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbjD0OfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbjD0OfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:35:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2AB133;
        Thu, 27 Apr 2023 07:35:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24b9e5a9a68so3668319a91.3;
        Thu, 27 Apr 2023 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682606110; x=1685198110;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nhLUOg/O0ErdhjEBLThxBOr1HWHr6gY9gruopyLBAXY=;
        b=a+LN2y+Eccy1++eyl5EldZerqR7ygJorniBBeyL6EnKP6gSZaPQAscgd7gRE9DaIiN
         IF8EpTQszUjaWyy3JSzC4KnnqF+/Q1gmor+3R5CqXTS4fUXsfVvjyX7PaFg4LW3p36+l
         0aUTAl3pPXRIRwYfVLbsQDt6wnj1mteP0XUjiR/2oEgCyuYLVL+KURzwUmPdXtWyCq2K
         ei61aAEugueW2XzY/GlFTrO0hTkOa87m2bD0psyFpRyvotO2Y785zUljzvCwOX7Idi0Q
         40TFlN20wUoZCkLi7/jcUZq1KfDvNPyfBEI+DzhM6KABCIFZKHnWPXZTq1rwGmWlZTNs
         XUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682606110; x=1685198110;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhLUOg/O0ErdhjEBLThxBOr1HWHr6gY9gruopyLBAXY=;
        b=UJjlr8di+MiNWao+54JlLjqWe2zHwwJVj6jlY07SvFgDzlIo7vi0n8xl4gRs/v6hl6
         ZoC5O4dVYfUtx10FyTIkBEvWopQ1R64PiBuPoPDXdB5sU4XX2as7vii8fC4RPharVyFA
         XHbe5K5b4F/QwwKANygNpB7QU61wkwIc+sw36k0pDsi8K1UJamKByKDMe0o9aN78jKI9
         HK06naUWB38W6zFVXjZwL5CHA4fDsAjLlzpBauR+G+jA15/MWYApO1743j6HFZe/Y466
         gS/6Ax8BZlcMrtQftUAwwiCdwnu+uJuo2Zi0Ht3257sqLkZOMbTfjgyNxNd9nKPHyrf/
         K14Q==
X-Gm-Message-State: AC+VfDz08mqyVHWPhEnx0tLD/etWQ/V3xUvhZU3vD4p66VG5p9OsJaeO
        zpC5pXxZ/nTLTSQZ1WfQ8FLD+G7JzIE=
X-Google-Smtp-Source: ACHHUZ4bkFOW4nTAq8dOr8kuMNLc4Ejdgh+ck3hGHyRf4jbfV3DPjWOw7pUZ7hLAQhP5wXhtPQMF1w==
X-Received: by 2002:a17:90a:5d0e:b0:247:a68d:7f22 with SMTP id s14-20020a17090a5d0e00b00247a68d7f22mr2278984pji.4.1682606110033;
        Thu, 27 Apr 2023 07:35:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gd12-20020a17090b0fcc00b00246578736bbsm11501537pjb.8.2023.04.27.07.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 07:35:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <05d08707-520f-9b94-81cf-a6a8d4c5386c@roeck-us.net>
Date:   Thu, 27 Apr 2023 07:35:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: watchdog: pcwd driver updates (was: No subject)
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230427133350.31064-1-oneukum@suse.com>
 <a6dd47dd-6dfc-787b-43ed-edda0cc0e51f@roeck-us.net>
 <a0ce066a-fa24-1e56-ade9-22d7cde18c14@suse.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <a0ce066a-fa24-1e56-ade9-22d7cde18c14@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 07:19, Oliver Neukum wrote:
> 
> 
> On 27.04.23 16:12, Guenter Roeck wrote:
>> Oliver,
>>
>> On 4/27/23 06:33, Oliver Neukum wrote:
>>> This fixes some long standing deficiencies in error handling,
>>> several race conditions and disconnect handling.
>>> Finally a cleanup as we now can get the device easily
>>> from the interface.
>>>
>>
>> This series is a no-go. If you want to improve the driver, please
>> convert it to use the watchdog subsystem API.
>>
>> Please note that the subject of your patches should start with
>> "watchdog: pcwd:"
> 
> Hi,
> 
> this would be problematic, because I do not have the hardware
> and given its age I won't. I certainly will break the driver
> if I do this extensive a change without testing it.
> 
> However, as is the driver has obvious issues, which I can fix.
> We can either do the sensible fixes or let it quietly rot.
> 

Several of those issues would be solved by using the watchdog subsystem.

I am not going to review patches for watchdog drivers not using
the watchdog subsystem. I would suggest to refrain from making changes
to such drivers, even more so if you don't have the hardware to test
those changes.

Thanks,
Guenter

