Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836965C2AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjACPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjACPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:03:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B182101C7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:03:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso21244678wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKYTQm49doq3QZeNRKUKNt+F+gYY9l1F+kH6s4sZsDY=;
        b=C5o5JgpATe056oWRrmwujioyJ7WOq8ChNKjqCpuzt09p8YeYqabBW9Rqa7FvThc3wY
         RPVUzi68gGgChAoLluP1TmZJZZ+mgi1f15GN73bg+VTfcaan+9Sw3T6N2I/S0ezF/G6L
         7egxW4wZ+ofHIzh4QEbuJvgktidl7Hn9BzwI2SkpFRDpFFvaxJTw1XCNE42+CBO3UfHE
         2wSQRkElfhazko9OzeCNkWr5bO1TWS0GOmVaI2JJxcqyB8N6tHLtt8ujsaxzHgZ7MFvm
         zW3cIlAIujGgLuPQC8EaRTMBp/k2Ka8FUJHNIe5aAIziUlg/GlyXG9gHbYbnk6zvMAuJ
         LDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKYTQm49doq3QZeNRKUKNt+F+gYY9l1F+kH6s4sZsDY=;
        b=HvY7LYw5nq9ol9vq6bzoyO7L5MNWHLATmjpErnbiEDIg36oXN1e9CdxPKSThknmbcl
         7SSST64fUXJ4597bVnZb9TwNXvEUdaRVyB3KKkL6xPAfGuuUvuwfIBrUZatiPVL475jv
         9UI54Fe8ItqV0VeL1Y5cnnQYaFd/MVNlpInBSKN4zTt+FDkqmcw7AOh+WU4+rrXEo5uA
         DuiHx1z/FOLIbhqsRoCtet/5/1SSCA1utDfJpqZPSCuTgzHaJIEH67LFUhV5BKD6onSp
         hGVKoVqp5iTiJsDZDk7Z6tSQ4kzoBk6NUQ6QhN8jdfKuQmV0Omlg5LAQ83cJ8VQxMr3A
         q0Cw==
X-Gm-Message-State: AFqh2kqZXVZHjh5UiNJFNdXIZYQS5GVK4VsxwnOFIwv9na62dk6+2QO+
        xOeZBGDOmU4NAK98LCs319sMUw==
X-Google-Smtp-Source: AMrXdXtyC5PDiiKBdsV8joYm1O+4/YLDTbRpzINJhFu1AUyEr1TV8WE7DYKR6Df4NvCC42QIBvacxw==
X-Received: by 2002:a05:600c:1d98:b0:3d3:48f4:7a69 with SMTP id p24-20020a05600c1d9800b003d348f47a69mr38782616wms.17.1672758234700;
        Tue, 03 Jan 2023 07:03:54 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf5ec79bf9sm41980076wmo.40.2023.01.03.07.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 07:03:54 -0800 (PST)
Message-ID: <ea02357d-c5c7-aeff-e045-d639315d87e9@isovalent.com>
Date:   Tue, 3 Jan 2023 15:03:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF"
 section
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
 <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
 <Y6GdofET0gHQzRX6@leoy-yangtze.lan>
 <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-12-20 16:13 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Tue, Dec 20, 2022 at 3:34 AM Leo Yan <leo.yan@linaro.org> wrote:
>>
>> On Tue, Dec 20, 2022 at 09:31:14AM +0800, Changbin Du wrote:
>>
>> [...]
>>
>>>>> Now will print below info:
>>>>> libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux
>>>>
>>>> Recently I encountered the same issue, it could be caused by:
>>>> either missing to install tool pahole or missing to enable kernel
>>>> configuration CONFIG_DEBUG_INFO_BTF.
>>>>
>>>> Could we give explict info for reasoning failure?  Like:
>>>>
>>>> "libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux,
>>>> please install pahole and enable CONFIG_DEBUG_INFO_BTF=y for kernel building".
>>>>
>>> This is vmlinux special information and similar tips are removed from
>>> patch V2. libbpf is common for all ELFs.
>>
>> Okay, I see.  Sorry for noise.
>>
>>>>> Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
>>>>
>>>> This log is confusing when we can find vmlinux file but without BTF
>>>> section.  Consider to use a separate patch to detect vmlinux not
>>>> found case and print out "No such file or directory"?
>>>>
>>> I think it's already there. If the file doesn't exist, open will fail.
>>
>> [...]
>>
>>>>> @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>>>>>   err = 0;
>>>>>
>>>>>   if (!btf_data) {
>>>>> +         pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
>>>>>           err = -ENOENT;
>>
>> btf_parse_elf() returns -ENOENT when ELF file doesn't contain BTF
>> section, therefore, bpftool dumps error string "No such file or
>> directory".  It's confused that actually vmlinux is existed.
>>
>> I am wondering if we can use error -LIBBPF_ERRNO__FORMAT (or any
>> better choice?) to replace -ENOENT at here, this can avoid bpftool to
>> outputs "No such file or directory" in this case.
> 
> The only really meaningful error code would be -ESRCH, which
> strerror() will translate to "No such process", which is also
> completely confusing.
> 
> In general, I always found these strerror() messages extremely
> unhelpful and confusing. I wonder if we should make an effort to
> actually emit symbolic names of errors instead (literally, "-ENOENT"
> in this case). This is all tooling for engineers, I find -ENOENT or
> -ESRCH much more meaningful as an error message, compared to "No such
> file" seemingly human-readable interpretation.
> 
> Quenting, what do you think about the above proposal for bpftool? We
> can have some libbpf helper internally and do it in libbpf error
> messages as well and just reuse the logic in bpftool, perhaps?

Apologies for the delay.
What you're proposing is to replace all messages currently looking like
this:

	$ bpftool prog
	Error: can't get next program: Operation not permitted

by:

	$ bpftool prog
	Error: can't get next program: -EPERM

Do I understand correctly?

I think the strerror() messages are helpful in some occasions (they
_are_ more human-friendly to many users), but it's also true that
they're not always precise. With bpftool, "Invalid argument" is a
classic when the program doesn't load, and may lead to confusion with
the args passed to bpftool on the command line. Then there are the other
corner cases like the one discussed in this thread. So, why not.

If we do change, yeah I'd rather have as much of this handling in libbpf
itself, and then adjust bpftool to handle the remaining cases, for
consistency.

Quentin
