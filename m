Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65CD5E6893
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIVQiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiIVQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:38:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3563E9CEC;
        Thu, 22 Sep 2022 09:38:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 9so9805938pfz.12;
        Thu, 22 Sep 2022 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=GYVA9dhWLYw3cKT6ukVmQvAv0tAmMjYUmL351DKMTVk=;
        b=niDazrOiE+nYpoMrWICBy3Q36Bk6ofTWkgYwgJ+JLtiVhRQLrBUH1GJzG0o0MC4sl2
         7gv/az63fBDy2dMMhVswYB8fvf5p3EJKOaFjWietN2lvOpVUUMJ2Hvkw0bm8iAQShYnr
         CWZXLiuXUZaRm+IeKZ8uOPa34FayieIvMc/kVNmk+HTawm+Jh7FSDE52rFTI3d7xQ4y7
         Swcd2IUTfzEnKaSG5ThMMxVjj7vwlXtjRfpp1G0Ng7gRJTWII5l3heuGuyAOhn9vk8uM
         dLMYUKMyPcdnjo/jyPXuzMc5L1NrKzRBFJRA04TWHzDEQRWoNiSld73LX1rasLns8L6T
         vLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GYVA9dhWLYw3cKT6ukVmQvAv0tAmMjYUmL351DKMTVk=;
        b=m7gPmQVr3+Nf6GuVJDK82TPIFqPstXXQwfVgmiy16vEFqBh/IspuE2QghnxzdRTHHT
         HMEhwR1LWJyPUDO95/VhYQndo9/WF8hpsw5hozdLk1DuCcJxvN+9jzQ3BurziO4F0rA1
         fsTeGsFvG/3v9VK6NX44hkHlgyHYqHvYY2AIKeXjLxlRuho9qBSD6p4XABN9nbNW7qdz
         lhTBFhlLKbzwYepC02Bh48AMQwCFD21HFUD9dEE9w4Bf6y4YrAooYbtRZ/DaDixr5THv
         EgXOG5+Se0ycdm1pObm9XUcNSCtmSPPYDn8USS/3D8pKp3N6gY3OUpJqkRVdBDTN28Pm
         NgYw==
X-Gm-Message-State: ACrzQf2w0+02fvvJ5zQIWfg9dFST9JZWPeHPStnPpvaxNNCVzy/2WPWb
        alBRTbWGhr55b8LCc4ctrs4=
X-Google-Smtp-Source: AMsMyM7qElevn6mPLVmd2qjYk/rYax+/dQlnBYFRj2E8k3zHqMsQ+UW/W/P7OYIscwp2jlQshGu8bg==
X-Received: by 2002:a05:6a02:186:b0:431:25fb:f1fe with SMTP id bj6-20020a056a02018600b0043125fbf1femr3858533pgb.130.1663864692439;
        Thu, 22 Sep 2022 09:38:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i65-20020a628744000000b0053812f35a41sm4624244pfe.194.2022.09.22.09.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:38:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ec8b8775-7e87-a1c4-5cac-b593e0921e3a@roeck-us.net>
Date:   Thu, 22 Sep 2022 09:38:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        Sean Christopherson <seanjc@google.com>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
 <20220921200726.GA3094503@roeck-us.net>
 <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
 <1a6e7165-cdae-6c8c-f57d-159fdb68897b@roeck-us.net>
 <d8cd7c7e-24c1-7f70-24a9-91c77aa634af@roeck-us.net>
 <YywS0keUorHwJJPt@hirez.programming.kicks-ass.net>
 <44b4b20a-550c-6337-3f7d-8283498f76f2@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
In-Reply-To: <44b4b20a-550c-6337-3f7d-8283498f76f2@intel.com>
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

On 9/22/22 08:00, Dave Hansen wrote:
> On 9/22/22 00:46, Peter Zijlstra wrote:
>> On Wed, Sep 21, 2022 at 08:09:13PM -0700, Guenter Roeck wrote:
>>
>>> Oh well, that "helped" to hide one of the crashes. Here is another one.
>>> This is with PAE enabled and booting through efi32.
>>
>>> [    1.086592]  efi_runtime_update_mappings+0x36/0x42
>>> [    1.086717]  efi_enter_virtual_mode+0x351/0x36e
>>> [    1.086860]  start_kernel+0x57d/0x60f
>>> [    1.086956]  ? set_intr_gate+0x42/0x55
>>> [    1.087079]  i386_start_kernel+0x43/0x45
>>> [    1.087272]  startup_32_smp+0x161/0x164
>>
>> Does this help? Dave; perhaps we should just let i386 be i386 and let it
>> bitrot :/
> 
> How about we just turn off enforcement for now so that the poor i386
> folks can at least boot?  I have the feeling we're going to get bored
> with even the warnings if they persist for too long, though.
> 

Problem with unfixed warnings is that they hide other problems if persistent,
and they result in warnings to be seen just as useless noise.

Case in point: In ChromeOS, we get literally hundreds of thousands of warning
reports each day (most from drm and wireless drivers). Those originate from
upstream code. No one really cares, and none ever get fixed. Please don't add
more if you don't plan to fix them.

Thanks,
Guenter
