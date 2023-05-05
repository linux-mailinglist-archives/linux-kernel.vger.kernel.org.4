Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DE6F89FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjEEUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjEEUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:07:53 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C7C10B;
        Fri,  5 May 2023 13:07:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8D06460195;
        Fri,  5 May 2023 22:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1683317268; bh=N2frngXGwrOsBgDp4weegB8fb4Qq8uDShefpmSs/2rk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ox5x4i/UJ8Z3q9BJyyjKHgqeCavQRBkSVxSbGqWo+HDs4MjZTZDuxjIfKzie8zKb8
         fT74WtYoSOL59i61dVGJlRHkG7udDxugFY2ww+e91JBfPVpydoDTQW19UKpM6+U0wj
         IJIBwJfHccfwnZzr7VrGKwK9P1ZFh0I9vQBdVn+eoP9H4Dg5c5iccimHATfbOnguBE
         uRMTmPhmYWj8u9a/kLZSbT9mfIdH7tHWCLmgwYnfOVw4R6U6cg4/us+wNsIap5G7wy
         +fyVrr9lhYccVDsDYbgprZxKaMBhk9Di8qhux97sQ+UOj622M8RqdEw9j/BjxNYEEN
         wtg14JcsA3imA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k9UxgHmNaevl; Fri,  5 May 2023 22:07:46 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 839C660133;
        Fri,  5 May 2023 22:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683317266; bh=N2frngXGwrOsBgDp4weegB8fb4Qq8uDShefpmSs/2rk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ToBkSidbaTcQuZ02WJKZ8qF97kf/VDnWjmVENCqsAXQmxJaeY6at6Y24HztuBJvp0
         uVH7zDNUkFuMa1zDpoVmR0s4pLo85Tlu5OBOKOxko/+OuOFRaalS3SpjxcQRJnxhgh
         k+8KXeoxGx10Bp+fphHVnvA86s0o7PgYjyllLYhq2DjJddQPuCkJisYbkPTr8z2APG
         BQufarTYr2oPkX92PqwZQA+ogD+CYBxj2j7NUDbmVwxjSb1MN5Lk7xO2un77GiCV/s
         J8csAJQHMzaChyMzt9L2pvBWSUmGHyWoxMMVgxevNqeaYmSVO2AMog7VkrFJrBWOMk
         6kxWLapi4qlrw==
Message-ID: <54f2186f-41ac-cdd4-9ea0-85441b63665b@alu.unizg.hr>
Date:   Fri, 5 May 2023 22:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [BUILD] Unable to sign drivers on Ubuntu 22.04 LTS desktop
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux x86 Architecture <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux perf users <linux-perf-users@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <bb89a720-b1b2-18fc-7f89-44267885700d@alu.unizg.hr>
 <ZFUIuW58QjfTaRxt@debian.me>
From:   Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
In-Reply-To: <ZFUIuW58QjfTaRxt@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 05. 2023. 15:46, Bagas Sanjaya wrote:

> On Thu, May 04, 2023 at 07:02:57PM +0200, Mirsad Goran Todorovac wrote:
>> Hi Bagas,
>>
>> I seem to have run into a dead end with this.
>>
>> OpenSSL 3.0.2 refuses to cooperate, despite enabling legacy ciphers:
>>
>>    BTF [M] net/nsh/nsh.ko
>>    BTF [M] net/hsr/hsr.ko
>> make -f ./Makefile ARCH=x86     KERNELRELEASE=6.3.0+ intdeb-pkg
>> sh ./scripts/package/builddeb
>>    INSTALL debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko
>>    SIGN debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko
>> At main.c:170:
>> - SSL error:1E08010C:DECODER routines::unsupported:
>> ../crypto/encode_decode/decoder_lib.c:101
> I didn't find any errors using self-compiled OpenSSL 3.1.0. I installed the
> library to `/tmp/openssl` and specify
> `KCFLAGS=-L/tmp/openssl/lib -I/tmp/openssl/include` when building bindeb-pkgs.
> Am I missing something?

Dear Mr. Bagas,

I have mistakenly deleted the

CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"

to

CONFIG_MODULE_SIG_KEY=""

so I got these strange errors, which made me believe that OpenSSL 3.0.1 
disabled some encryptions and hashes.

I suspected it was the problem with the FIPS mode not installed in the 
stock Ubuntu 22.04 LTS library, but I have to admit before so many 
people that it was this stupid mistake which I found out by looking up 
Debian config.

IOW, false alarm.

Ubuntu config with FIPS mode OpenSSL 3.1.0 works, however, I have 
rebuilt with the default OpenSSL 3.0.1 and the error was bisected to the 
missing .PEM.

Best regards,
Mirsad


