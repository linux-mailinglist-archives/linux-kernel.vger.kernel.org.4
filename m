Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3F6B660A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 13:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCLMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCLMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 08:53:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69201ADDD;
        Sun, 12 Mar 2023 05:53:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so1689334pjb.0;
        Sun, 12 Mar 2023 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678625606;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATgDgy1YTPU2yW43mYyw7dC0tKBfIzV3TlqnkOH7iBI=;
        b=U3A/FbdVQfj/Zb5NKClBsDRX8zHQWsQ01gYUJaP9pzjPr1kdFEWUuNyF6zGzFUljLO
         xfOQN8aIXzTmebRrcicoo0TLRvQzwbBaXehdq1uYsPla8fwwXc2Jc81P2Bbjw7Qrxb1W
         YJezBRm/Ao5fp4jDa8POoMkOjajgZ97OtJryeIGAn3rSvJlPOIRU2vppwSXfTzpBovAv
         ZWz4LTb1fGbLJ2XSnS2DKYZkCkis6hvh4VLQdKKw5o51r47eirehjNbOakQVysrn8NSq
         nDvlLWTLh0lszouxpBbiOFYKsuy/PHq681mq/mz4JD8rLKTMRC8MbYorSSv6ezqEp/1r
         iF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678625606;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATgDgy1YTPU2yW43mYyw7dC0tKBfIzV3TlqnkOH7iBI=;
        b=mxklZPv3kVQ7/YHKbVVnlWZncAeqEf+dk+GqQzhnUHIfsRr7zwzreZbsERJ+dTaJnW
         ehxCXTLkdSGY4ca3vtHxSybBC/mAmMIK6qmb6SDh8oW2shnhVoAGicqPbonTN7gJAmXv
         O38f4+0dmnnB6u0HVAYb9ZhbGW3Tj9AivB92GfjubCd35Lmww5/V3S9ub+QiJ5tZZp9G
         e/th7hPEL6/t7x2Lz5MJmqGaqNTc3oUWRqx+O2/83EH60Iy5IkJjizJDJrB/34Sg8nW2
         +CQ2HCnTVam8DFdF+GcyzKl4bnNVY/EjqrayIs4u9oIZNg2+x67jpTTw3Gqwkro2jZuD
         9qJw==
X-Gm-Message-State: AO0yUKUPIGzyyNHLRtuFC2nF6hYsUD4pImcm9UWvc804f6FtH6BdyA+h
        3h3WQiLjjgdC4G9KoUOFW1gAA4y/h9ZmaZ7B
X-Google-Smtp-Source: AK7set9kvWbjXtPP3Sg5OrWmtGV7gQVyFRpy/Txku4ZV68BJbbmIbZvyEYj2BRLUf4Zs0UC+jD62rw==
X-Received: by 2002:a05:6a20:1609:b0:cc:d44a:bec2 with SMTP id l9-20020a056a20160900b000ccd44abec2mr36996877pzj.1.1678625606091;
        Sun, 12 Mar 2023 05:53:26 -0700 (PDT)
Received: from [192.168.50.71] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b005ded4825201sm2716387pfu.112.2023.03.12.05.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 05:53:25 -0700 (PDT)
Message-ID: <09d44d74-f3c9-cf99-8d14-74499485e956@gmail.com>
Date:   Sun, 12 Mar 2023 21:53:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] perf tools riscv: Add support for riscv
 lookup_binutils_path
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
References: <20230311112122.28894-1-p4ranlee@gmail.com>
 <CAP-5=fWkAqX+Uy_XhXHjEx6sj-wpOJ+WQf=vMtRzRBS-0Kj32Q@mail.gmail.com>
From:   Paran Lee <p4ranlee@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
In-Reply-To: <CAP-5=fWkAqX+Uy_XhXHjEx6sj-wpOJ+WQf=vMtRzRBS-0Kj32Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



23. 3. 12. 15:27에 Ian Rogers 이(가) 쓴 글:
> On Sat, Mar 11, 2023 at 3:22 AM paranlee <p4ranlee@gmail.com> wrote:
>>
>> Add to know RISC-V binutils path.
>> Secondarily, edit the code block with alphabetical order.
>>
>> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
>> ---
>>  tools/perf/arch/common.c | 51 +++++++++++++++++++++++++++-------------
>>  1 file changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
>> index 59dd875fd5e4..058527ededdd 100644
>> --- a/tools/perf/arch/common.c
>> +++ b/tools/perf/arch/common.c
>> @@ -29,11 +29,23 @@ const char *const arm_triplets[] = {
>>  };
>>
>>  const char *const arm64_triplets[] = {
>> +       "aarch64-unknown-linux-",
> 
> Modifying ARM64 behavior should be a separate change.
> 
>>         "aarch64-linux-android-",
>>         "aarch64-linux-gnu-",
>>         NULL
>>  };
>>
>> +const char *const mips_triplets[] = {
>> +       "mips-unknown-linux-gnu-",
>> +       "mipsel-linux-android-",
>> +       "mips-linux-gnu-",
>> +       "mips64-linux-gnu-",
>> +       "mips64el-linux-gnuabi64-",
>> +       "mips64-linux-gnuabi64-",
>> +       "mipsel-linux-gnu-",
>> +       NULL
>> +};
>> +
> 
> This will affect the blame history. It should probably be its own change too.

Thank you for review! I agree. So I would split the patch.

>> -
>>  static bool lookup_path(char *name)
>>  {
>>         bool found = false;
>> @@ -164,18 +179,22 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
>>                 path_list = arm_triplets;
>>         else if (!strcmp(arch, "arm64"))
>>                 path_list = arm64_triplets;
>> +       else if (!strcmp(arch, "mips"))
>> +               path_list = mips_triplets;
>>         else if (!strcmp(arch, "powerpc"))
>>                 path_list = powerpc_triplets;
>> -       else if (!strcmp(arch, "sh"))
>> -               path_list = sh_triplets;
>> +       else if (!strcmp(arch, "riscv32"))
>> +               path_list = riscv32_triplets;
>> +       else if (!strcmp(arch, "riscv64"))
>> +               path_list = riscv64_triplets;
>>         else if (!strcmp(arch, "s390"))
>> -               path_list = s390_triplets;
>> +               path_list = s390_triplets;
> 
> whitespace issue?

I tried to correct the alphabetical order because it was vaguely sorted.
And I'll try to work on blame history on each arch code block as well.

>> +       else if (!strcmp(arch, "sh"))
>> +               path_list = sh_triplets;
>>         else if (!strcmp(arch, "sparc"))
>>                 path_list = sparc_triplets;
>>         else if (!strcmp(arch, "x86"))
>>                 path_list = x86_triplets;
>> -       else if (!strcmp(arch, "mips"))
>> -               path_list = mips_triplets;
>>         else {
>>                 ui__error("binutils for %s not supported.\n", arch);
>>                 goto out_error;
> 
> I think in general we need to revamp this code. Two things that I see
> that are missing are (1) support for perf config and (2) addr2line
> should be configurable, you may want llvm-addr2line. Adding RISC-V is
> of course important too :-)
> 
> Thanks,
> Ian

May I ask documentation or hint that I can help work with?

P.S.

I'm interested in the Google Summer Of code perf category this year,
especially the part about risc-v architecture, I recently purchased a
development board and would like to be able to test perf on a Sifive U74
CPU based environment.
But I've only used perf with command tool and don't know much about the
internals, so if there is a roadmap for perf development or
contribution, I have interest in perf internals both kernel and user side.
May I ask information to apply?
I am developing Linux Security Driver drivers for a security company.

BR
Paran Lee
