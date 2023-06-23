Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16C173B2EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjFWIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjFWIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:51:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA227170B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:51:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f973035d60so308515e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687510291; x=1690102291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBp/5we+F098cYxjClAH39IPPmeDVkhswEY+vCjkrLU=;
        b=Ldb53M44W8TbeL/H4zJekM/7x63/asS5bW6zXQ9hJOyWbKLNY7keLnKXhRj4QrC0l/
         DLXXI4bXuMJbOq8ckfyr5v1acn0wXTqUNlru42rjmYpwkXm+H96OgZgoI/kCnW2k7oxl
         5Da53GQIaNEpKCSkb9q0VDRLUTm8EeZ/Egqsr8ggJ3t+EiI4Mf3FiuOKj5/uk1Ro4Szo
         5fx2JdV1Gj8eUq+940HvdiGUJOJJoB464Of3kP4xSxRYeC/5T4GTYNjml1HW49/4/0Mg
         nTS0IoQC1ppNOJGvTDABxyXAPGh/iA1087WWe5v1Fr96c6G0LMb6JgKCuGj+56lCYl3C
         Jyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687510291; x=1690102291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBp/5we+F098cYxjClAH39IPPmeDVkhswEY+vCjkrLU=;
        b=KGH7MiajEyQ0qj1gE12KuWoQAa165sYtVDDJytYar8IYLVb9IXd/ac+2knNMci2JFt
         aawFQeEYqneUQZCzL33iMcd+kFBe8kO4TJCOUgAngL7R4Xlvn5Gs5Q/uA+D96W14JGeg
         +kKWhTPlcPr9ifGG/0BRn+GbZznOiI4FNOg1oP75BHbFzFbG+wO4lV0FIwo2NouOicwF
         XbEExv3DEyFJH32dTtn8OtEJ+gcb2+yYmmNjhI6VvqH6wbsaBrE6EFodIg4+K7Tndpz5
         LwjcNbT+lKySkDOz9G89lO29o7awBEv57zkzmIVcJnCcB818qBS1hkmFq9aCT9elW1Vs
         Ef+Q==
X-Gm-Message-State: AC+VfDxKykKOhkaD9XNaqSsONwB6AQnPJ//zLmg6G3YQ/KvAvgJovIYr
        VIg2yBGvJuN4XOAmmQlbjq52Ow==
X-Google-Smtp-Source: ACHHUZ4bJ8bVgtgP/IjbqRrFOwLkmmEY0vE1BaZUiA+/j8tie7A0E3PJlHa8tG/xQQi6uTLzNyUNhA==
X-Received: by 2002:a19:6544:0:b0:4f6:d7b:2f19 with SMTP id c4-20020a196544000000b004f60d7b2f19mr11832148lfj.24.1687510290980;
        Fri, 23 Jun 2023 01:51:30 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cb8:f81f:3342:3b44? ([2a02:8011:e80c:0:9cb8:f81f:3342:3b44])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003eddc6aa5fasm1671290wmc.39.2023.06.23.01.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 01:51:30 -0700 (PDT)
Message-ID: <a5d419e4-f2ea-27f6-9259-a7b6486ab616@isovalent.com>
Date:   Fri, 23 Jun 2023 09:51:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] bpf: Replace deprecated -target with --target= for Clang
Content-Language: en-GB
To:     Fangrui Song <maskray@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230623020908.1410959-1-maskray@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230623020908.1410959-1-maskray@google.com>
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

2023-06-23 02:09 UTC+0000 ~ Fangrui Song <maskray@google.com>
> -target has been deprecated since Clang 3.4 in 2013. Use the preferred
> --target=bpf form instead. This matches how we use --target= in
> scripts/Makefile.clang.

This seems to be the relevant commit, for reference:

https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de0a68135afc7f95def6277

> 
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  Documentation/bpf/bpf_devel_QA.rst              | 10 +++++-----
>  Documentation/bpf/btf.rst                       |  4 ++--
>  Documentation/bpf/llvm_reloc.rst                |  6 +++---
>  drivers/hid/bpf/entrypoints/Makefile            |  2 +-
>  kernel/bpf/preload/iterators/Makefile           |  2 +-
>  samples/bpf/Makefile                            |  6 +++---
>  samples/bpf/gnu/stubs.h                         |  3 ++-
>  samples/bpf/test_lwt_bpf.sh                     |  2 +-
>  samples/hid/Makefile                            |  6 +++---
>  tools/bpf/bpftool/Documentation/bpftool-gen.rst |  4 ++--
>  tools/bpf/bpftool/Makefile                      |  2 +-
>  tools/bpf/runqslower/Makefile                   |  2 +-
>  tools/build/feature/Makefile                    |  2 +-
>  tools/perf/Documentation/perf-config.txt        |  2 +-
>  tools/perf/Makefile.perf                        |  4 ++--
>  tools/perf/util/llvm-utils.c                    |  4 ++--
>  tools/testing/selftests/bpf/Makefile            |  6 +++---
>  tools/testing/selftests/bpf/gnu/stubs.h         |  3 ++-
>  tools/testing/selftests/hid/Makefile            |  6 +++---
>  tools/testing/selftests/net/Makefile            |  4 ++--
>  tools/testing/selftests/tc-testing/Makefile     |  2 +-
>  21 files changed, 42 insertions(+), 40 deletions(-)
> 

> diff --git a/samples/bpf/gnu/stubs.h b/samples/bpf/gnu/stubs.h
> index 719225b16626..cc37155fbfa5 100644
> --- a/samples/bpf/gnu/stubs.h
> +++ b/samples/bpf/gnu/stubs.h
> @@ -1 +1,2 @@
> -/* dummy .h to trick /usr/include/features.h to work with 'clang -target bpf' */
> +/* SPDX-License-Identifier: GPL-2.0 */

Are these necessary, seeing that the files only contain this single-line
comment?

> +/* dummy .h to trick /usr/include/features.h to work with 'clang --target=bpf' */

Other than this, the change looks good, thanks. Although it should
probably target bpf-next rather than bpf?

Acked-by: Quentin Monnet <quentin@isovalent.com>

