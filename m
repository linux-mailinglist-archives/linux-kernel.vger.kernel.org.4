Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526DF725BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbjFGKmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbjFGKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:42:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFD2122
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:42:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6ffc2b314so3474795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686134537; x=1688726537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7LrhNNEdA24khblC9g8MfKa4jeWvLQ+nAT4hRuOUJI=;
        b=XIPDoVV88MC7ohXtbTc2BCAz536FGMFDcu4rdZ5ndoe8/wbuZh2LJ8yFLgMkgqX5xS
         vuNtpp04rDMuXb+tEbdw9+7DjSfzqX0KNlkMYA4fpekCV4J/KMpN3DPo1C6Hv7TSNhMC
         GsiaGDA1rl0Tv2jzQ7g1Ndhrq/QALkjJP+drhZaztLD/jNveiLBziLAsCrH65+ufAN3A
         2jBNTl3WUaFnzfWdmTs2XxvEcl/tZgfYEWYbejMAJbZ3S4V6hf1xIJyZz5zSJPUoFpDv
         /08sr83xx/vF3wFWesTcnJ9+s60XwYIm+MESMCKWGv88MeIAFjuKC+ZUAJNBPZbKu2HY
         SCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134537; x=1688726537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7LrhNNEdA24khblC9g8MfKa4jeWvLQ+nAT4hRuOUJI=;
        b=Ve/qtWIO/GSFWnMI1tBkLa0d3URiuGgU890D5IiEzR89ZL7AUgQTUy3JQrBN4lawU1
         84cciuNmlBa1d3lBtuHONp6f7AFqeiO44l8eeG6zqGddVQ86yNBx5yiRgO0EnsNpkxs9
         tjZAYbTRRxMx2KtoaKPXrYuVXOTZlOz1b/uTmYHJur12RKA+4QyoRYb9Q7DO8irsReps
         yuGM0s8gUKhv2kGMhuMT6SK7Sv+dOolWioV4Gh6EYZzpVbcXLJ7GNyX15gkF4Oc8Qtay
         5ooHjPLAZwnRL5a/43fB372oblO1k0s9j5KZSPoAHNn+17MmUphLScH8Lr4fVNtgx1D4
         6MYg==
X-Gm-Message-State: AC+VfDwLLTeyrDvE5sa4mHBGOxWx8wiu8Mr7DJEml8Pfvj9CQjVW9ya6
        ToymxjOFhdDuVbuWgbSplHTK2g==
X-Google-Smtp-Source: ACHHUZ4OhWn4Tb9E2A5DqtcylYLUxU5x86bnN3MT2KWvOc7EJ3AmkwX8cONOFSmSpNVgN9Yoho/ljw==
X-Received: by 2002:a7b:c3d4:0:b0:3f4:1ce0:a606 with SMTP id t20-20020a7bc3d4000000b003f41ce0a606mr4065558wmj.1.1686134537631;
        Wed, 07 Jun 2023 03:42:17 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:3d52:65d8:7088:94e9? ([2a02:8011:e80c:0:3d52:65d8:7088:94e9])
        by smtp.gmail.com with ESMTPSA id h18-20020a1ccc12000000b003f74eb308fasm1648829wmb.48.2023.06.07.03.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 03:42:17 -0700 (PDT)
Message-ID: <a5d1512b-2c1b-1713-ae52-84fc148ecb5a@isovalent.com>
Date:   Wed, 7 Jun 2023 11:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 bpf 03/11] bpftool: use a local bpf_perf_event_value to
 fix accessing its fields
Content-Language: en-GB
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Lobakin <alobakin@pm.me>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tpgxyz@gmail.com,
        Jiri Olsa <olsajiri@gmail.com>
References: <20220421003152.339542-1-alobakin@pm.me>
 <20220421003152.339542-4-alobakin@pm.me> <ZH+e9IYk+DIZzUFL@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZH+e9IYk+DIZzUFL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-06 14:02 UTC-0700 ~ Nick Desaulniers <ndesaulniers@google.com>
> On Thu, Apr 21, 2022 at 12:39:04AM +0000, Alexander Lobakin wrote:
>> Fix the following error when building bpftool:
>>
>>   CLANG   profiler.bpf.o
>>   CLANG   pid_iter.bpf.o
>> skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
>>         __uint(value_size, sizeof(struct bpf_perf_event_value));
>>                            ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
>> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
>> struct bpf_perf_event_value;
>>        ^
>>
>> struct bpf_perf_event_value is being used in the kernel only when
>> CONFIG_BPF_EVENTS is enabled, so it misses a BTF entry then.
>> Define struct bpf_perf_event_value___local with the
>> `preserve_access_index` attribute inside the pid_iter BPF prog to
>> allow compiling on any configs. It is a full mirror of a UAPI
>> structure, so is compatible both with and w/o CO-RE.
>> bpf_perf_event_read_value() requires a pointer of the original type,
>> so a cast is needed.
>>
> 
> Hi Alexander,
> What's the status of this series? I wasn't able to find a v3 on lore.
> 
> We received a report that OpenMandriva is carrying around this patch.
> https://github.com/ClangBuiltLinux/linux/issues/1805.
> 
> + Tomasz
> 
> Tomasz, do you have more info which particular configs can reproduce
> this issue? Is this patch still necessary?
> 
>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")

Hi Nick,

This patch is still necessary if you attempt to compile bpftool with
skeletons support, on a host with a kernel version lower than 5.15.

I took over on the bpftool patches from this series, and sent a new
version last month. Given that it only contains the bpftool patches, the
series has a different title and is not tagged as v3, but you can find
it here:

https://lore.kernel.org/all/20230512103354.48374-1-quentin@isovalent.com/t/#u

Jiri (+Cc) found an issue with this set when CONFIG_BPF_EVENTS is
disabled. I need to replicate and investigate, but I've been short on
time to do that over the last few weeks.

Best,
Quentin
