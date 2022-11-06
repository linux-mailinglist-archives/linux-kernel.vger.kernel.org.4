Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1639261E5A1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 20:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiKFTmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 14:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiKFTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 14:42:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541111146
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 11:42:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c1so12501977lfi.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 11:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soEmAuBjEszn8pf98ldLFRL5ujODoTGOCIahcsWuApw=;
        b=R2TvARUJtyz37zIy2kVi75Orec2ZOcXliptOV1B3feipOsEyycJ2SuXt1NmWRl8Qbw
         aiMMt4kIaF7uacIYnsjAyICuC0CJABfp4FySKRyqZsHPj6vd5oqakwtyU+Z9CB9jXQHS
         KRSV1S1YK0SIAI0hqqJ49ZYa55lxmKYsxPQxXzLQUd80eTm5NthjMv8DtykvWy5Whpb2
         7ZWLk67mysZljUDbocl2R4ZEFyBvrBRsJQmdf1I1ESXu/hfwS3C++lPXJcoF008zgc8T
         uCG33NBtrAZfJQ+k+8gYNUYAZP/00YtyYxIR7k+R6KBeFYVfIrM8zMnISCKoP6TDzdwQ
         IXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soEmAuBjEszn8pf98ldLFRL5ujODoTGOCIahcsWuApw=;
        b=qZhu8I37BuMjHRJUvWnE38hvpEnHZH/qsmuYL6G32LiDuQS4xhdgd1xkJB4rhsbVkY
         Mhdv9BVtF0TRaVYtosBmoZvoSKIf3ApC6DIyXqNOotTwfMxh/sr0GNVpxsfb7V5X2DQd
         MOR2Lhskr16Xp1YAiNW3KlHY298wVojcrdUEaN5zUoZs3LTWJujxpKisXRp6wQEGQqJX
         hFM6hqW5BbsiP7gW5nOvJPhJ6kREe4p91P1q4amO3jdcI9/U7fvdPHWl1v+khExRox9O
         Ncm3Ygzk0mQBtAQbrgfB9T+X5Re66H0EYvX1lT0VQSfXhKUatS5Yk3h6byimXfcUAU+4
         gm3Q==
X-Gm-Message-State: ACrzQf1JKFE0TfY6Yp9PXiOcnYPlAtIXHFH1ntwJbcHwF0bgAS6hGp/1
        rMmnUgw5UvGfgm210V0hgx+R+s0ZDno=
X-Google-Smtp-Source: AMsMyM6PGenF6suyM8Ji7VFmUmk8giB/Q9bvSv8DXeQQ8bDRyRB263uzSOoyeKxQx8aZ4VRTkMTHIQ==
X-Received: by 2002:a19:c503:0:b0:4a2:b966:37ec with SMTP id w3-20020a19c503000000b004a2b96637ecmr18303820lfe.319.1667763752323;
        Sun, 06 Nov 2022 11:42:32 -0800 (PST)
Received: from [192.168.1.12] (91-159-148-109.elisa-laajakaista.fi. [91.159.148.109])
        by smtp.gmail.com with ESMTPSA id u18-20020ac258d2000000b00497a32e2576sm839487lfo.32.2022.11.06.11.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 11:42:31 -0800 (PST)
Message-ID: <25bd279e-f429-3772-bbea-ad56a7a810e5@gmail.com>
Date:   Sun, 6 Nov 2022 21:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 0/2] mm: In-kernel support for
 memory-deny-write-execute (MDWE)
To:     Joey Gouly <joey.gouly@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
References: <20221026150457.36957-1-joey.gouly@arm.com>
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <20221026150457.36957-1-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2022 18.04, Joey Gouly wrote:
> Hi all,
> 
> This is a follow up to the RFC that Catalin posted:
>    https://lore.kernel.org/linux-arm-kernel/20220413134946.2732468-1-catalin.marinas@arm.com/
> 
> The background to this is that systemd has a configuration option called
> MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
> is to prevent a user task from inadvertently creating an executable
> mapping that is (or was) writeable. Since such BPF filter is stateless,
> it cannot detect mappings that were previously writeable but
> subsequently changed to read-only. Therefore the filter simply rejects
> any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
> support (Branch Target Identification), the dynamic loader cannot change
> an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
> For libraries, it can resort to unmapping and re-mapping but for the
> main executable it does not have a file descriptor. The original bug
> report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
> for libraries - [3].
> 
> This series adds in-kernel support for this feature as a prctl PR_SET_MDWE,
> that is inherited on fork(). The prctl denies PROT_WRITE | PROT_EXEC mappings.
> Like the systemd BPF filter it also denies adding PROT_EXEC to mappings.
> However unlike the BPF filter it only denies it if the mapping didn't previous
> have PROT_EXEC. This allows to PROT_EXEC -> PROT_EXEC | PROT_BTI with mprotect(),
> which is a problem with the BPF filter.

Draft PR for systemd: https://github.com/systemd/systemd/pull/25276

-Topi

> 
> Thanks,
> Joey
> 
> [1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#MemoryDenyWriteExecute=
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1888842
> [3] https://sourceware.org/bugzilla/show_bug.cgi?id=26831
> 
> Joey Gouly (2):
>    mm: Implement memory-deny-write-execute as a prctl
>    kselftest: vm: add tests for memory-deny-write-execute
> 
>   include/linux/mman.h                   |  15 ++
>   include/linux/sched/coredump.h         |   6 +-
>   include/uapi/linux/prctl.h             |   6 +
>   kernel/sys.c                           |  18 +++
>   mm/mmap.c                              |   3 +
>   mm/mprotect.c                          |   5 +
>   tools/testing/selftests/vm/mdwe_test.c | 194 +++++++++++++++++++++++++
>   7 files changed, 246 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/vm/mdwe_test.c
> 

