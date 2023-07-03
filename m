Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085774549E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 06:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGCEqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 00:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCEq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 00:46:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDA81AB;
        Sun,  2 Jul 2023 21:46:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so2358609b3a.0;
        Sun, 02 Jul 2023 21:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688359588; x=1690951588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=l0VKzbBNLxqu3gGmHDDoW4LuIz7xzbrZcoUmfJuSOyk=;
        b=kV+xWXKfMNCEATcK+f32azw2YUhL1OWP6meKrLKeZiA/nz0Wa1m0EswI+7TdFTugnV
         fdrtpo0rM+AHG0Os54BQ8lvrQQBkhRPG+ZQsumehFmbMVKAfjxPE29yGNI7L07XEFB1Q
         IoaEMThzlYw0uR3Hyd8ffCPhPtMch+f73xkZL2Iw0ckqyJADbMDtNSRAmz5HTXxYL+22
         1D7zWJYjKIxbx9sThmuH6gmxgtplTtDF+i2WFjnLWpHO4q+MSjPJ27O3mi+sYKsYfrp7
         7ExJKqun4gtIc24KYbMHBU6+9oMGidocnObyNuPfFgnpNPKYl5mpBb41jp0pw4E9prt0
         V8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688359588; x=1690951588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0VKzbBNLxqu3gGmHDDoW4LuIz7xzbrZcoUmfJuSOyk=;
        b=f44FqjFddd2JQmthGY3CecOkp3RCxCoOU1n5fCwZkqBo33x3NqFmbI9m09tKRGlvpE
         RMLBrS79E/RAP9in/YTKbrUJR70w708+IDL3Y91FrQja0KYPIW3JoPEJWdmM/UnzTmT7
         pu4KMLr4jg2sj8moo1YqxtEY9iAVPg40DFQSzjM86snDdxaarN6yZCQMY0U9uhokPHr5
         pPVHKumHqLYR2/SPwpGUhRTWU2fE6M41Iu95k47L9mhmcDZ0VylL0eYbxBx6CDxsU4rV
         07U5tI58RxCHw3s9SlUBAd8+kmEeSF7rYgB1zfhENpk/jgRexpvrx3yqOgk/Z11g2hT5
         M+SQ==
X-Gm-Message-State: AC+VfDwTyLoZ9VUNAQZIV2wMpB6aOHL4cDJP/fRammB8CbcvjmfS8sUc
        Bb/qQ+bmMMHNqJhNUF8/6bC0lYp1EcU=
X-Google-Smtp-Source: ACHHUZ7FtksFdEFtlY6ZTNL0YXn2cYhuLJ3YtmwO3oCe3+4jqZKATSFCMFL34loOC2oNJEajkcq4uw==
X-Received: by 2002:a05:6a00:14d2:b0:67b:77e7:f467 with SMTP id w18-20020a056a0014d200b0067b77e7f467mr22181560pfu.16.1688359588134;
        Sun, 02 Jul 2023 21:46:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a8-20020aa780c8000000b00662610cf7a8sm13631578pfn.172.2023.07.02.21.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 21:46:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net>
Date:   Sun, 2 Jul 2023 21:46:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh>
 <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
 <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
 <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
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

On 7/2/23 21:22, Linus Torvalds wrote:
> On Sun, 2 Jul 2023 at 20:23, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> I can reproduce the problem in qemu. However, I do not see a warning
>> after applying your patch.
> 
> Funky, funky.
> 
> I'm assuming it's the
> 
>                                  page = get_arg_page(bprm, pos, 1);
>                                  if (!page) {
>                                          ret = -E2BIG;
>                                          goto out;
>                                  }
> 
> in copy_strings() that causes this. Or possibly, the version in
> copy_string_kernel().
> 
> Does *this* get that "pr_warn()" printout (and a stack trace once,
> just for good measure)?
> 

Sorry, you lost me. Isn't that the same patch as before ? Or
is it just time for me to go to bed ?

Guenter

