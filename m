Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0692F720787
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjFBQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjFBQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:27:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C65B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:27:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565de4b5be5so34428957b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685723232; x=1688315232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FsXbgRShryNzdNSzJ5Am4umvREHFh47GmNJr7ouXBH8=;
        b=sJiyO4Bx4eCGjTlDq1xltia/tOAC6GVvGmrfcGk23+wGZI9WXBxWOs4Vr5sakfsLMk
         mt7svQHF5EoO1vLGOrG/aLsAVgwZc9UnrBSz/PrNcHPzVknHYHihoMsoYAo2UcBKvQIr
         kl+JrysCwGVOVL9t4BnGpOxJOpoklXqHhjc3jbf0rI/oH+UBt8OhXLxeg/58Dl3kDBl8
         IaCpH/GuvhWoWf/2OJLveKhYenJ4BjDT0dfCAP3pRap8h3QHnKTWMoKUp0ZOXI+iNhb4
         N+buqClWtLrTbzGftKym8S6s8m0II7pKKGIJz2EdhBZEBYHKhi+x9Nnnjm6BRGPOZYsA
         qCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723232; x=1688315232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsXbgRShryNzdNSzJ5Am4umvREHFh47GmNJr7ouXBH8=;
        b=UxYAlUM1riKB5i+3cnasCUsHiGoeFWla6Y+ksl5TVgnsKhdCt3Lrh+TuL8vQpT+Dki
         Xk+pOOQuC5H+SIg/OICMWC1321AX9GoUvXRtDezNs3tOGzUkkYk8VmYD8aWs6AZdvWcW
         CmWdI6wLwwDe/zCPVlF8xCrKGMrzHLYgwAHcCv7wQ+osUXVzQbnZA+x3NjATtxt7bcxN
         a5EXhFw8XNSLTZ+/EgL0JMuu6kzVxaJsA/RxbohTTejcclPTKQRe6O6xOeLR2dkbO9vt
         NInYoTpe2fRz84BC6wsfw0/XSP08q1dEAAeyKIF2odwrwjtzdbolT/zUde80bhz9RaYj
         jxeQ==
X-Gm-Message-State: AC+VfDwvEM/MrdeEYFFe+S3qFp6cghWibZnyFQF9d7jrquRJSHvRVjIV
        y1r+7HTKlXzAHhy2+/3ecxcJcNA=
X-Google-Smtp-Source: ACHHUZ6h+lEHKAumz7nimoB3/Jm68v6RapS4wpmVU/uLqN6k0m3nrVa/mx9Cps3PbMC/joCswtG0Rkc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:70d:b0:ba8:37f6:a586 with SMTP id
 k13-20020a056902070d00b00ba837f6a586mr2293200ybt.3.1685723232268; Fri, 02 Jun
 2023 09:27:12 -0700 (PDT)
Date:   Fri, 2 Jun 2023 09:27:10 -0700
In-Reply-To: <20230602140108.1177900-1-void@manifault.com>
Mime-Version: 1.0
References: <20230602140108.1177900-1-void@manifault.com>
Message-ID: <ZHoYXlofKUK9YWqv@google.com>
Subject: Re: [PATCH] selftests/bpf: Add missing selftests kconfig options
From:   Stanislav Fomichev <sdf@google.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02, David Vernet wrote:
> Our selftests of course rely on the kernel being built with
> CONFIG_DEBUG_INFO_BTF=y, though this (nor its dependencies of
> CONFIG_DEBUG_INFO=y and CONFIG_DEBUG_INFO_DWARF4=y) are not specified.
> This causes the wrong kernel to be built, and selftests to similarly
> fail to build.
> 
> Additionally, in the BPF selftests kconfig file,
> CONFIG_NF_CONNTRACK_MARK=y is specified, so that the 'u_int32_t mark'
> field will be present in the definition of struct nf_conn.  While a
> dependency of CONFIG_NF_CONNTRACK_MARK=y, CONFIG_NETFILTER_ADVANCED=y,
> should be enabled by default, I've run into instances of
> CONFIG_NF_CONNTRACK_MARK not being set because CONFIG_NETFILTER_ADVANCED
> isn't set, and have to manually enable them with make menuconfig.
> 
> Let's add these missing kconfig options to the file so that the
> necessary dependencies are in place to build vmlinux. Otherwise, we'll
> get errors like this when we try to compile selftests and generate
> vmlinux.h:
> 
> $ cd /path/to/bpf-next
> $ make mrproper; make defconfig
> $ cat tools/testing/selftests/config >> .config
> $ make -j
> ...
> $ cd tools/testing/selftests/bpf
> $ make clean
> $ make -j
> ...
>   LD [M]
>   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko
>   tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/bpftool
>   btf dump file vmlinux format c >
>   tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
>   libbpf: failed to find '.BTF' ELF section in
>   vmlinux
>   Error: failed to load BTF from bpf-next/vmlinux:
>   No data available
>   make[1]: *** [Makefile:208:
>   tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h]
>   Error 195
>   make[1]: *** Deleting file
>   'tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h'
>   make: *** [Makefile:261:
>   tools/testing/selftests/bpf/tools/sbin/bpftool]
>   Error 2
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

(I've been also setting these manually myself for local testing)

> ---
>  tools/testing/selftests/bpf/config | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 63cd4ab70171..3b350bc31343 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -13,6 +13,9 @@ CONFIG_CGROUP_BPF=y
>  CONFIG_CRYPTO_HMAC=y
>  CONFIG_CRYPTO_SHA256=y
>  CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_DEBUG_INFO=y
> +CONFIG_DEBUG_INFO_BTF=y
> +CONFIG_DEBUG_INFO_DWARF4=y
>  CONFIG_DYNAMIC_FTRACE=y
>  CONFIG_FPROBE=y
>  CONFIG_FTRACE_SYSCALLS=y
> @@ -60,6 +63,7 @@ CONFIG_NET_SCH_INGRESS=y
>  CONFIG_NET_SCHED=y
>  CONFIG_NETDEVSIM=y
>  CONFIG_NETFILTER=y
> +CONFIG_NETFILTER_ADVANCED=y
>  CONFIG_NETFILTER_SYNPROXY=y
>  CONFIG_NETFILTER_XT_CONNMARK=y
>  CONFIG_NETFILTER_XT_MATCH_STATE=y
> -- 
> 2.40.1
> 
