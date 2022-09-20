Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45BC5BE084
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiITIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiITInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:43:49 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48F1C4;
        Tue, 20 Sep 2022 01:43:47 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id u9so4428460ejy.5;
        Tue, 20 Sep 2022 01:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3Q48nRjfZmM0qXUdlJ9dbqaN2v4JDiUTzZSH3VhXCD8=;
        b=VUSIqT+zyO7QHXm4LWcwcAGdXnxpjdlsN8ivWFYJuBeuQ+PLsFdfQDuehwJQFZZBcA
         GrqgG37b1e5KAs4Tne+1wY4KuOvin6F2P1vjH83rhdmGmPVd/i1okm20yTYaeG/DOkgu
         YSX0viEGQxJF1oXJ+apiK6GsPA+iSicO2nmYEyS3bNjTORSS/3mm44sJpKEDBz0WC28M
         NVxgio+LpSSjxz57v6W6bQka35VW8O0rxUXdcO1hJKJcge4UtcM6ySzmbOvfVUrNJCOp
         RnP9dP2Pw/MkxoqOxFWuBKEpJtOv251N+QWJ/IxtgQL0prEfQDTDgI5vTqxmO/Snq3Js
         giqA==
X-Gm-Message-State: ACrzQf1arPpOuiQGwzpgwOIXFKLjq0Lz3TUpdeDdwH848Xk3FgGkEd5n
        AGVIuno1DxVDqMu9cdgtZQt0om3mXNo=
X-Google-Smtp-Source: AMsMyM7iVGE+zfhsUGwrcoGP8FsBBXRtjnTp/3Rf/0SVI23F3NvIDUG851o6pFv1L2YVMorQJ36BOg==
X-Received: by 2002:a17:907:7e93:b0:77c:1e21:a50b with SMTP id qb19-20020a1709077e9300b0077c1e21a50bmr16584346ejc.72.1663663425735;
        Tue, 20 Sep 2022 01:43:45 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id cz23-20020a0564021cb700b0044625884285sm852438edb.49.2022.09.20.01.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:43:44 -0700 (PDT)
Message-ID: <bb66653e-9a24-5faf-1b70-831556b6495b@kernel.org>
Date:   Tue, 20 Sep 2022 10:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
References: <20220616104541.16289-1-jslaby@suse.cz>
 <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
 <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
 <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com>
 <14c9839b-c015-69c1-84f0-a99d03877005@suse.cz>
 <CAK7LNAS46hrVh3FNiHHL8_Hqp85VgWnsHyjQ4t-TFH_H344NOg@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNAS46hrVh3FNiHHL8_Hqp85VgWnsHyjQ4t-TFH_H344NOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 06. 22, 10:41, Masahiro Yamada wrote:
> On Tue, Jun 21, 2022 at 4:30 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>
>> On 17. 06. 22, 18:32, Nick Desaulniers wrote:
>>> On Fri, Jun 17, 2022 at 3:35 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>
>>>> On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>
>>>>> On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>>>
>>>>>> On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>>>>>>
>>>>>>> Until the link-vmlinux.sh split (cf. the commit below), the linker was
>>>>>>> run with jobserver set in MAKEFLAGS. After the split, the command in
>>>>>>> Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
>>>>>>> is lost.
>>>>>>>
>>>>>>> Restore it as linkers working in parallel (esp. the LTO ones) make a use
>>>>>>> of it.
>>>
>>> TBH, I agree with Masahiro. I didn't understand this comment "esp. the
>>> LTO ones."  Jiri, can you clarify what you mean here?
>>
>> Sure. clang is not the only compiler/linker that can handle kernel ;).
>> So while rebasing gcc-LTO-kernel-patches to 5.19-rc (to upstream them
>> later), this broke. See:
>> https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/lto-wrapper.cc;h=26e06e77be4e0afb2bc3e913062a9c51cab5d205;hb=HEAD#l1336
>>
>> gcc really parses MAKEFLAGS and looks for "--jobserver-auth=" there, if
>> one passes specifies -flto=jobserver.
>>
>> thanks,
>> --
>> js
>> suse labs
> 
> 
> 
> Then, this patch should go together (or after) the GCC LTO upstreaming.

Hi,

OK, I will make it part of the gcc-lto series.

> I still do not understand why you are patching the pre-modpost linking, though.
> 
> In my understanding, Clang LTO and GCC LTO are implemented
> in different layers.
> 
> Clang LTO is implemented in the linker (i.e. lld).
> 
> In contrast,  GCC LTO is implemented in the compiler (i.e. gcc itself)
> The linker (i.e. BFD linker or Gold from GNU binutils project)
> is agnostic about LTO.

Right. First, gcc compiles the sources to an intermediate language. Then 
gcc-ld (LTO-)links the objects into a binary object. BFD ld/gold is 
invoked only from within gcc to actually link the binary.

> Your are patching the relocatable link ($(LD) -r),
> but I could not find the code parsing jobserver-auth
> in the binutils-gdb repository.

With gcc-lto patchset, gcc-ld is invoked in cmd_ld_vmlinux.o.

So you are right, making it part of the gcc-lto patchset makes perfect 
sense. First, to see the context. Second, upstream doesn't need the change.

thanks,
-- 
js
suse labs

