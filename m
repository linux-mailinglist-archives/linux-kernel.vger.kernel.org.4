Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664767054FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEPR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEPR3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:29:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81745FC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:29:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96ab81aa68dso930681466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684258170; x=1686850170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSAwujdb6ZD1BWpdXf+Ik7CenrdNfZlSo0AIchZVf0M=;
        b=AqTMB6aqQ6C2RMcsj55sPBjAuOrB27skqyEto7o3plpppZw4eAytoBztXPdyDj6RVc
         QB7g1NoVeHIk1tmYr3vEeeeY0bWvRiV8vg1wyzjIu8P51bKS1nHB4Fq6lCXzbwU74o9z
         bfG5TRJ9N+OKXVM3T7rI6dvBHnYNsXhUFBJjBlHAN9lVTbXimvkeTUWVsPwFjwTjCXYP
         7WDOPLQYG4/e+I9w4AI278gsLKo8MjBaNWkJFtI8rGNNjjnIHLeXb0EzxAgPXB9yTW9a
         hRkxIn86e+foW3mpivw1xlXi4api82kznHjD57zv+m/iJUp7koIlKbjsB/TeR6gcqh15
         etiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684258170; x=1686850170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSAwujdb6ZD1BWpdXf+Ik7CenrdNfZlSo0AIchZVf0M=;
        b=dLYZVepxRE0AhgUnL8r95Kmw94N0NnVMCAAId6HTVCAmbU8rkFX55OCw5ECh0IcmVH
         +01PACYLbuwIrhF0Y2iZ12Hot/vGvmbrdPkKyR1laKQYWs2x+OqixFDTs3USGYNsny2q
         suSa64yAJED9Yl61afthgY/uHmg12QK9DkaywQ7xv2jUsCeliLhZm6Yr+WzHtTr3uTpp
         powbRNVK6b0l8E4Xd6WBNUv/MeyWriZoR4Q/YuV5udR8TFiXQAhz0+nuTFctN39v/34i
         UCVBwVICrfbJzJyj7ByJM7pPaHiP2ICpWmTxrIkL8kkLdYtECYyiWGKreK2fNc05DXMs
         xcrQ==
X-Gm-Message-State: AC+VfDxGYXTjRZdOvkUqDN2Yz9jDPdJ2sBRWQMrnKTnte00fJ1EvZlba
        Sts7Wi/FlBeDPPjMn+oFVF/J0Jugx2CRNMDNjwg=
X-Google-Smtp-Source: ACHHUZ6HdRMraWOnF0yvuNpYSQArV65PARmVgqkjCw5wjyfGgy5RVeaZxETL186zEUnLlKaeqgSuZjXH3gOnt9BsKbM=
X-Received: by 2002:a17:906:d54b:b0:94f:3980:bf91 with SMTP id
 cr11-20020a170906d54b00b0094f3980bf91mr40467887ejc.19.1684258169761; Tue, 16
 May 2023 10:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <202305161058.hUHyPIjv-lkp@intel.com>
In-Reply-To: <202305161058.hUHyPIjv-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 May 2023 10:29:18 -0700
Message-ID: <CAEf4BzZ5CrQvOE-RwR1UuPMxuPaMzpQ_3z1Fnx3m_K0iLTE2RA@mail.gmail.com>
Subject: Re: Error: failed to load BTF from vmlinux: No data available
To:     kernel test robot <lkp@intel.com>
Cc:     Changbin Du <changbin.du@gmail.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 7:43=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Changbin,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> commit: acd3b7768048fe338248cdf43ccfbf8c084a6bc1 libbpf: Return -ENODATA =
for missing btf section
> date:   4 months ago
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Dacd3b7768048fe338248cdf43ccfbf8c084a6bc1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout acd3b7768048fe338248cdf43ccfbf8c084a6bc1
>         make O=3D/tmp/kselftest headers
>         make O=3D/tmp/kselftest -C tools/testing/selftests
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305161058.hUHyPIjv-lkp@i=
ntel.com/
>
> All errors (new ones prefixed by >>):
>
>    libbpf: failed to find '.BTF' ELF section in vmlinux
> >> Error: failed to load BTF from vmlinux: No data available
> --
>    libbpf: failed to find '.BTF' ELF section in vmlinux
> >> Error: failed to load BTF from vmlinux: No data available
>    make[3]: *** [Makefile:204: tools/bpf/bpftool/vmlinux.h] Error 195
>    make[3]: *** Deleting file 'tools/bpf/bpftool/vmlinux.h'
>    make[2]: *** [Makefile:113: bpftool] Error 2
>    make[2]: *** Waiting for unfinished jobs....
>    libbpf: failed to find '.BTF' ELF section in vmlinux
> >> Error: failed to load BTF from vmlinux: No data available
>    make[3]: *** [Makefile:76: tools/bpf/runqslower//vmlinux.h] Error 195
>    make[3]: *** Deleting file 'tools/bpf/runqslower//vmlinux.h'
>    make[2]: *** [Makefile:122: runqslower] Error 2
>

Do you enable CONFIG_DEBUG_INFO_BTF=3Dy for this test? retsnoop's
Makefile expects to find .BTF section in vmlinux image to be able to
compiler everything correctly.

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
