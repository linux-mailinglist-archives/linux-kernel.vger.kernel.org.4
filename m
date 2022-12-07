Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF94646126
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLGSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLGSdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:33:39 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2BB73F7B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:33:05 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so16077388ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 10:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VKwf7b34iwDJam10Xe4ksrS3pTY0DPZX7DaGHPXX4g0=;
        b=hl14LEOJb3n9VhrtnRCQqjs/pbqeIQf4yr8GkDySmLeVCwJITB8h7t6s0951cLgx8X
         jhtbg6XtYWLq3HNxRRwFVJioFFpL8Z8MnFL7bKNMFmgdOex6H31t6zCI85A2Nu6Nb+wD
         V0Wb+DuZ1ii/O53g/CCb6QzWceaUNsS/Pzc4tbdHGaqi/rtK2/nYLFDOjCs2Y7fhnilG
         zaQ4nM4KjZl9fhhfzHXzFJRNXYjUOPV3y6e1KlPAfhj/A/F1Z3mysjOFCPFKAMT0DmhA
         KoEsRIjHQpQ0x8u+1i11adkLRibULT+amAGDUtfo3W7hTbzb2KnW5R+ec19Y/VaUU+np
         UAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKwf7b34iwDJam10Xe4ksrS3pTY0DPZX7DaGHPXX4g0=;
        b=zQHUq6yrz6tssVL31qvH61OYO4LtVHlqbI/tSwSi8FYfid8vrlqEHpgxf+39kopifN
         8eUTvk3VQd58A41mzir21waFXOC0BLbfQQRl9aJRnxspexXgYj3TkATHAvCl3mO0y0FF
         pXGFXI9rKt8Ltix522byZQfuXWNlS3Ef4gSGHI/44xTE767ZNlQu1O+IX+uQOQ4/IPZR
         +2X0ABYQw6nTHtRowAaF4mJ5WUgsqgWT1jvSBmGZQ09xQL915TE71PesxZsXOM9WUuEL
         1aNL4IvaTGYVrphYUbXcI4FNEvxmXQSxXGrRHH6i3ksrMNdrxtmnD/G+fLSQPakmy2i+
         jXAg==
X-Gm-Message-State: ANoB5plUKLMjZvrwwd1QRiun/PzihCt2CJLKMkIvQbIAsE/lIfen+Os6
        MbEFNHcmPFmuSjwUNksqEOY=
X-Google-Smtp-Source: AA0mqf6MKl/KU4aaJNYUAwaa09mq7pM6V/KW+N1GCA1J8y+vF8WUfk5GPPAu0WLUVHf1TpusLUTZiw==
X-Received: by 2002:a17:906:a449:b0:7c1:ff2:d48e with SMTP id cb9-20020a170906a44900b007c10ff2d48emr6393375ejb.343.1670437984290;
        Wed, 07 Dec 2022 10:33:04 -0800 (PST)
Received: from [172.22.204.227] (ppp85-140-58-71.pppoe.mtu-net.ru. [85.140.58.71])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007ba46867e6asm8931415ejc.16.2022.12.07.10.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 10:33:03 -0800 (PST)
Message-ID: <4999a9ee-ba08-6e4c-a1d1-074687f82d5e@gmail.com>
Date:   Wed, 7 Dec 2022 21:32:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From:   Mikhail Zhilkin <csharper2005@gmail.com>
Subject: Re: ld.lld: error: undefined symbol: __udivdi3
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
References: <202212010140.pIueEBNb-lkp@intel.com>
 <20221201091610.524f7786@xps-13> <Y4jPubD53yN32OUL@dev-arch.thelio-3990X>
 <20221201171331.42f05097@xps-13>
 <CAC2txAZpGooRGSxh4x9T7Y9b4OvfePx5=YuJoyaSwk1M_EvwtQ@mail.gmail.com>
 <Y4913gH2tvIED61P@dev-arch.thelio-3990X>
Content-Language: en-US
In-Reply-To: <Y4913gH2tvIED61P@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 12/6/2022 8:03 PM, Nathan Chancellor wrote:

> Hi Mikhail,
>
> First and foremost, apologies for the delay in my response!
>
> On Thu, Dec 01, 2022 at 09:39:22PM +0300, Mikhail Zhilkin wrote:
>> Hi Miquèl, Nathan,
>>
>> On 12/1/2022 7:13 PM, Miquel Raynal wrote:
>>> Hi Nathan,
>>>
>>> nathan@kernel.org wrote on Thu, 1 Dec 2022 09:00:57 -0700:
>>>
>>>> On Thu, Dec 01, 2022 at 09:16:10AM +0100, Miquel Raynal wrote:
>>>>> Hi Mikhail, Hiroshi,
>>>>>
>>>>> lkp@intel.com wrote on Thu, 1 Dec 2022 01:46:36 +0800:
>>>>>
>>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>>>> head:   01f856ae6d0ca5ad0505b79bf2d22d7ca439b2a1
>>>>>> commit: 9b78ef0c7997052e9eaa0f7a4513d546fa17358c mtd: parsers: add support for Sercomm partitions
>>>>>> date:   6 months ago
>>>>>> config: mips-randconfig-r033-20221128
>>>>>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6e4cea55f0d1104408b26ac574566a0e4de48036)
>>>>>> reproduce (this is a W=1 build):
>>>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>>         chmod +x ~/bin/make.cross
>>>>>>         # install mips cross compiling tool for clang build
>>>>>>         # apt-get install binutils-mipsel-linux-gnu
>>>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b78ef0c7997052e9eaa0f7a4513d546fa17358c
>>>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>>         git fetch --no-tags linus master
>>>>>>         git checkout 9b78ef0c7997052e9eaa0f7a4513d546fa17358c
>>>>>>         # save the config file
>>>>>>         mkdir build_dir && cp config build_dir/.config
>>>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
>>>>>>
>>>>>> If you fix the issue, kindly add following tag where applicable
>>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> All errors (new ones prefixed by >>):
>>>>>>
>>>>>>>> ld.lld: error: undefined symbol: __udivdi3
>>>>>>    >>> referenced by scpart.c
>>>>>>    >>>               mtd/parsers/scpart.o:(scpart_parse) in archive drivers/built-in.a
>>>>>>
>>>>> Can you please try to reproduce this with a mips toolchain as advised
>>>>> and send a fix?
>>>> For what it's worth, this is likely our bug:
>>>>
>>>> https://github.com/ClangBuiltLinux/linux/issues/1635
>>>>
>>>> It sounds like there are some merged LLVM patches that should help but I
>>>> guess not based on this report...
>>> Ah, yeah, thanks a lot for the share.
>>>
>>> Cheers, Miquèl
>> I could reproduce the issue and found that reference to __udivdi3
>> appears in this function:
>>
>> static uint32_t scpart_desc_is_valid(struct sc_part_desc *pdesc)
>> {
>>         return ((pdesc->part_id != 0xffffffffUL) &&
>>                 (pdesc->part_offs != 0xffffffffUL) &&
>>                 (pdesc->part_bytes != 0xffffffffUL));
>> }
>>
>> There is no LLVM compiler error if:
>>
>> static uint32_t scpart_desc_is_valid(struct sc_part_desc *pdesc)
>> {
>>         return (0);
>> }
>>
>> Currently I have no ideas where does __udivdi3 come from, because
>> there's no division here. Should I try to rewrite somehow the function
>> to avoid the error?
>> I would greatly appreciate any ideas.
> I do not think it is that function that is causing the problem. Making
> it return zero just causes the code generation to change enough to avoid
> this issue.
>
> Based on the previous analysis and reduction [1], LLVM is transforming
> the for loop in scpart_scan_partmap() into division; you can verify this
> by commenting it out some way then rebuilding and running 'readelf -s'
> to look for __udivdi3.
>
> Arnd suggested working around this problem by making offs a 32-bit type,
> as it is already bounded by ->erasesize, which appears to be a 32-bit
> value from what I can tell. Making a change like so appears to resolve
> the issue for me but I am not sure if that has any other implications.
>
> diff --git a/drivers/mtd/parsers/scpart.c b/drivers/mtd/parsers/scpart.c
> index 02601bb33de4..6e5e11c37078 100644
> --- a/drivers/mtd/parsers/scpart.c
> +++ b/drivers/mtd/parsers/scpart.c
> @@ -50,7 +50,7 @@ static int scpart_scan_partmap(struct mtd_info *master, loff_t partmap_offs,
>  	int cnt = 0;
>  	int res = 0;
>  	int res2;
> -	loff_t offs;
> +	uint32_t offs;
>  	size_t retlen;
>  	struct sc_part_desc *pdesc = NULL;
>  	struct sc_part_desc *tmpdesc;
>
> [1]: https://github.com/ClangBuiltLinux/linux/issues/1635

Many thanks for your time and very clear explanation!

I've made compile and run tests. It seems that have the working
workaround and I'm going to send the patch. After analyzing the code, I
don't expect any other implications.

Who should I add to Suggested-by of the patch: You or maybe Arndt?

> Cheers,
> Nathan

-- 
Best regards,
Mikhail

