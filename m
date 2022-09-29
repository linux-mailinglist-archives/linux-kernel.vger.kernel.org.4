Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF25EEB83
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiI2CPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiI2CPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:15:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E7C7A514
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:15:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d82so178795pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=s0liAjs+a8eOYAiNOjFlzgLvaceVmczbR+hir0D/D7Q=;
        b=fUQSougFfm7zW8E7lQFYXAlUMK8AE5v9xFczPs6MyMkrujFB3meMfgTpsQrEikiJCs
         WO8gFSEEG9VGNLvf9+Jo9yDZ4UflwiHsabgil2fY3v7yo4eDrc+Ari5/lRXDXa+SMcmz
         TjsoCDn9w7ns2dcAc30IEx5mQA+ztqET5Ed0e0eZwbX5xh4O/TjvfEixOh/iyclwALmo
         P6hR62hjzPxv+vOYk7pBewau3d78CpL75UTVkiZ2GBAYwYewi/NHbPUvTDHwi/qP9loL
         7DtuQqDnePYG4H1XPph5W29rWhDtYw7orcWy4dpMjCxVyoQ6HpItEgcnUGwPI/MdK2kw
         yDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=s0liAjs+a8eOYAiNOjFlzgLvaceVmczbR+hir0D/D7Q=;
        b=TpN9pG/VVl8VWHHoDJ140efBIXNT1kPgToMQyRbAzJEVB4Zh3ONBE8cRbFHISr8TAw
         dFajQXocd+L4fOEHEgsQ4i6cs21p5mjmMt7u/G5cByAoKb1lGsIKhJIE6c74LvlKTsiC
         0m7VmupRusaMJdXORCUou5UssmiHFbQF27ETxy3b4cwgFaniem9KcVVCxbK19Igf5IpL
         SWg912kfQKWoy8LsZhtlrFJ6iyAXkfFi3nUxXVRvdtpELJD4klH1VtEVv1TI3PEidd9p
         49BdvRnddb6uKnaDeO3ohZycWSbDAl9Z5e/ZyN/tpdVTF4wVQXfDu9Msiqd5N9Pkpego
         GF0g==
X-Gm-Message-State: ACrzQf1+ZDfudSZ3mujJh/Ehi81t3vNFKLHf8HYvvP3sH8ODgmn+jPXA
        IxkZ+qRosHyxIehchyuLuKMYHg==
X-Google-Smtp-Source: AMsMyM5iDVlHa7a6tPczgkEeCDZBOFXLIRvvNN57IFF4bHgxRjgZY9rdsyT0IWZcT7NNOMIVeRF0eQ==
X-Received: by 2002:a63:540b:0:b0:43c:8ce9:2800 with SMTP id i11-20020a63540b000000b0043c8ce92800mr753708pgb.481.1664417711572;
        Wed, 28 Sep 2022 19:15:11 -0700 (PDT)
Received: from [192.168.10.153] (ppp121-45-204-168.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.204.168])
        by smtp.gmail.com with ESMTPSA id e10-20020a65688a000000b0043cd6db9816sm4354771pgt.71.2022.09.28.19.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 19:15:10 -0700 (PDT)
Message-ID: <0a19759a-6819-6c99-5533-ce83536f900d@ozlabs.ru>
Date:   Thu, 29 Sep 2022 12:15:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220429053329.2278740-1-aik@ozlabs.ru>
 <YoLjpivvU7dRVTuL@dev-arch.thelio-3990X>
 <7d30583e-7e58-5184-be2d-773882dd9092@ozlabs.ru>
 <ba973bf8-fee6-ba17-244e-32c00d6a06e4@ozlabs.ru>
 <CAK7LNARNMhTn-+GcOHZrVj=viQxTMUS_7syat4icaPXUGtYkVw@mail.gmail.com>
 <CAK7LNARgfw7K+hKrsKVb9AEQHEQP308kp5dpiyFqzLg5URrcyQ@mail.gmail.com>
Content-Language: en-US
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <CAK7LNARgfw7K+hKrsKVb9AEQHEQP308kp5dpiyFqzLg5URrcyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2022 03:00, Masahiro Yamada wrote:
> On Mon, Sep 19, 2022 at 9:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> On Wed, Jun 22, 2022 at 3:56 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>
>>> Ping? It's about 2 months now :)
>>>
>>>
>>> On 6/6/22 15:12, Alexey Kardashevskiy wrote:
>>>> Ping?
>>>>
>>>>
>>
>>
>>
>>
>> Applied to linux-kbuild.
>> Thanks.
> 
> 
> I dropped the patch from my tree because
> I confirmed that the mainline + this patch
> breaks the build.
> 
> Please check the 0day report:
> 
> https://lore.kernel.org/lkml/202209221359.0J5ktdOy-lkp@intel.com/

Ouch, missed few exports, sorry. I've reproduced this with x86 config 
and posted v3. Thanks,


> 
> 
> 
> 

-- 
Alexey
