Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC37664E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjAJVvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjAJVu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:50:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D41DF33
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:50:58 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 20so4523804pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmwA1TA46fJDMKzQ6yPSf40jLo6xYZV+jW12Z9cySpE=;
        b=EwWeJ1IU2g7unQu4NqNrdpHomO6xXJngzZZAHtKy0kXY5GNGwKUKgfXTz5T3RgPlfO
         QqeNILS/WAr4JJYpEfy6U4OwBHQJlLmLc98xNvZcUIJIG+505mVP1bKpCDmw6wxQIYBi
         E5jQP8w3FCP5LeEF3AMf5g3ZkpQvkA22lWT/0sZchjxRxN8X5/IQse4JMLWkEVq4jr3z
         eI/EFkCS2f3cssbAFrqTMrQM25UkPTJiLmgDNwnlSviQjv9ESthitfqeARC4X8aHTwg+
         TrB/K3oW7koS0N3j+/VbNpO6X09Ny7UjPrLixDekOzFHHTGyN41zTqVr/JHjjNQZ8jwv
         PfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmwA1TA46fJDMKzQ6yPSf40jLo6xYZV+jW12Z9cySpE=;
        b=L2aP2zDCvgUY4pbc//ersNnMdv1WGG6X1Pjud/BafbRW8EYbR8mqJ27bDlvKqLxGpX
         hOf6ZwowzLDO2WS+Y2d1T3vHr3rt1knxPuvRbl52AEf3WtQGVFX9TYDXxbEHrf2XmIza
         lup9piaeExjILCFhqr7P0qVBm7i+R2vrXcQdh1/OE+0k0Uf7DhNdMw3hZ3wYBJueW0mc
         PT/b8t9E6blex3VKsaVlJpCT/gpFgWPBym/8rG7NH7c7nJLbNtp+OnKdIvMSwsXTCknA
         1gGWPKYDxYy71qedHECDNbh3u0V92I1mCuwGLdCm8/F9nSZtsfm0DDmhJbAwO2rXyCrN
         sNmg==
X-Gm-Message-State: AFqh2krHs795ojAOGVeBNJ2AvUuXaKhs4tTA9b6L0Zg/nshC9UItj9la
        5qWMx1jtT2xesynkeEcEzCK0cA==
X-Google-Smtp-Source: AMrXdXuOLCiWRvxtD0NnhH1Khr0ICRsvt1VF+10sGucav75R/w2OdzmuAhXrc24bJe07VGDIB0bNqg==
X-Received: by 2002:a05:6a00:2ad:b0:589:5504:1508 with SMTP id q13-20020a056a0002ad00b0058955041508mr6575849pfs.19.1673387457785;
        Tue, 10 Jan 2023 13:50:57 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm4916126pfq.1.2023.01.10.13.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 13:50:57 -0800 (PST)
Message-ID: <6dcdd143-ff1c-41f7-9f46-0c4505575669@rivosinc.com>
Date:   Tue, 10 Jan 2023 13:50:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
Content-Language: en-US
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        palmer@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
 <01AF458D-1EDC-47D1-A902-A686E2DF26AF@jrtc27.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <01AF458D-1EDC-47D1-A902-A686E2DF26AF@jrtc27.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/23 12:48, Jessica Clarke wrote:
> On 10 Jan 2023, at 20:18, Vineet Gupta <vineetg@rivosinc.com> wrote:
>> This implements the elf loader hook to parse RV specific
>> .riscv.attributes section. This section is inserted by compilers
>> (gcc/llvm) with build related information such as -march organized as
>> tag/value attribute pairs.
>>
>> It identifies the various attribute tags (and corresponding values) as
>> currently specified in the psABI specification.
>>
>> This patch only implements the elf parsing mechanics, leaving out the
>> recording/usage of the attributes to subsequent patches.
>>
>> Reported-by: kernel test robot <lkp@intel.com>  # code under CONFIG_COMPAT
>> Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
> This code is full of buffer overruns and uninitialised reads in the
> presence of malicious files,

While the outer loop is bound, indeed the internal pointer increments 
could get oob.
I don't recall seeing existing explicit "safe" pointer, so thinking of 
cooking something up.
The conceptual idea is to replace

     p += 4

with

    PTR_INC(p, 4, p_max)

And similarly replace

     while (*p++ != '\0')

with

     while (*p != '\0')
           PTR_INC(p, 1, p_max)

Is that sufficient or you had something else in mind.


> and fails to check the version, vendor and sub-subsection tag.

That is now added.

> You also should handle more than one sub-subsection even if tools don’t
> emit it today.

Just to be on same page, a sub-section implies the following

       uint32:len, NTBS:vendor-name, uint8: Tag_file, uint32:data-len, 
<tag><value>....

If so, the code does support multiple of these

> You also have an unaligned access for reading the sub-subsection’s data
> length (maybe that’s ok in kernel land, but worth making sure).

True, I've added get_unaligned_le32 for those now

Thx,
-Vineet
