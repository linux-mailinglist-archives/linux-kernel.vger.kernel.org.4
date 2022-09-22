Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B105E69D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiIVRnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIVRnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:43:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FDCF9601;
        Thu, 22 Sep 2022 10:43:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e5so10036033pfl.2;
        Thu, 22 Sep 2022 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=ordY5gRXnsxz2Grt9o3T/Ssy795W6cMK2+g6m4UINGc=;
        b=D/CowdKVlkdURR9jr5hiqBMx9qntg+Cd9XXshoDJu1IJBXx13segL/ggzkXfgyFPlH
         dxjAtvkwubANu5eqedOG5gPQKej4NqmZKn4E0mdvvukIhHr4xNw8ABIGrae6a8PLH4yQ
         wiJTMnkCaoQy13OGAhMe7mJE5bRHCt0RT4OHMQYbuenYsa0R4rssSAD5NX90vhTrW+5l
         rftaL/TVJvNMoGji9R/RCN0j11uCt6TxqyXlKJ3B1YqEci4AmHBCN42pCbvPw+h3S3kX
         HJ1H0G+J2S3Lr7NM36SW/F/363Jh4MyCIW1zMocc41idXYco5ndPfJNYJ5N0FKBqMlke
         ZESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=ordY5gRXnsxz2Grt9o3T/Ssy795W6cMK2+g6m4UINGc=;
        b=2obyph0vHC64ZVjwPz/G4e0qK2HQIzwaoAvhFRrDpEqERWDJsoLAG6z01W1hRhHQZR
         h5JzflhbLkSWuntHiID9s6B/BKmMOxQPtdnWZ/f1It4irLlwRPcXJeddjv2Go1qUvqhL
         xeTBRujKtXd32W0QC98R0rCMmuU/Yn+D8YoMtfyAWJmP7uYsGBtzl+Qjt5AyszXds8dQ
         lR/aJt5+nkBpeUcEvjSX4p3uXWmsYMkpkcDw6b8oy/lftzehs/KN5ceduK7NQajtZG91
         F66lI3yXxx4VrLYtw8yorIBypl5UMoaOrRsJcMppTqGFiU7lVhNyy6jjB0U5WUiVD+af
         /CXQ==
X-Gm-Message-State: ACrzQf2Y9Eafy0AvIwY64BhZd4JYAkdf9uvubFIKfdwKyCrtz15VnnMd
        Q6Xc3tevbmUmutDjow24+kIlBm78QcJZpQ==
X-Google-Smtp-Source: AMsMyM4nqKeK8kOGxKQtrGSq8shZRgTMJ68F1NQjNiCIRvh792Uhi6MbOONj9A/HYBqeMcDwltLsmQ==
X-Received: by 2002:a63:4243:0:b0:439:2031:be87 with SMTP id p64-20020a634243000000b004392031be87mr4039421pga.592.1663868623690;
        Thu, 22 Sep 2022 10:43:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g130-20020a625288000000b0053e2b61b714sm4734008pfb.114.2022.09.22.10.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:43:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <791dc5e2-4de3-1eb9-8de2-4f2904335756@roeck-us.net>
Date:   Thu, 22 Sep 2022 10:43:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] watchdog: sp5100_tco: Add "action" module parameter
Content-Language: en-US
To:     rwright@hpe.com, Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920092721.7686-1-git@vladimir.panteleev.md>
 <20220922173635.GJ18783@rfwz62>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220922173635.GJ18783@rfwz62>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 10:36, rwright@hpe.com wrote:
> On Tue, Sep 20, 2022 at 09:27:21AM +0000, Vladimir Panteleev wrote:
>> Allow configuring the "action" bit, as documented in [1].
>>
>> Previously, the only action supported by this module was to reset the
>> system (0).  It can now be configured to power off (1) instead.
>>
>> [1]: https://www.amd.com/system/files/TechDocs/44413.pdf
> 
> The referenced AMD document 44413 is over 10 years old, and I'm
> concerned when I try to line that document up against the newer versions
> that are implemented in AMD's EPYC processors, that the bit being
> manipulated as SP5100_WDT_ACTION_RESET is effectively reserved in the
> newer references, for example:
> 
>     https://www.amd.com/system/files/TechDocs/55772-A1-PUB.zip
> 
> Is Core::X86::Msr::CpuWdtCfg in the newer document is the same as
> WatchDogControl in the cited 44413.pdf? If so, then I would point out
> that bit 2 is now included in what is called, CpuWdtTimeBase where
> values 2-3H are reserved,  meaning bit 2 effectively must be zero.
> 

I think those may be different watchdogs. Chapter 9.2.6 ("Watchdog
Timer (WDT) Registers") in 55772-A1-PUB still lists bit 2 of the
control register as:

WatchdogAction. Read-write. Reset: 0. 0=System reset. 1=System power off. This bit determines the action to
be taken when the watchdog timer expires. The bit is only valid when the watchdog is enabled.

Guenter
