Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C8964F12C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiLPSmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiLPSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:41:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94CDF96
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:41:39 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r18so2333653pgr.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcxFFXjYmc19fdjNo/0QqKOWh/kWtyWkgqLog48dCd0=;
        b=QS46Q4nWvZck9C84DqObwPr5Kwxg5TYWK1RqnkXeN726RiQhvGtBlMIZbANJIgA2/C
         u1uCOfOEYxoUx6sPy51ijdUIjwnm2LA8SVrhuQiryr4ms0U703onwaxyNt9ThFW3T37G
         Y6kQ9HnHXtVqaxnnN/VYVEaUzv7fOc2aK8FkAjX4a/xPsuBaWEI490yhD3whDbHlqKMP
         gixKU/JiYNaEHMhIHq29N3mggOTUZOxR/8Vz4Cyv+tKkk7BoI9HNAV7qcXyfM/DE10PZ
         iSJAB6WixpCcxGLoSMs7srhndSEil5t4UGZHoAFgn8k69bjOarnUau41/xCsXwb8SxBB
         LEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcxFFXjYmc19fdjNo/0QqKOWh/kWtyWkgqLog48dCd0=;
        b=6BcRO0rchvlEz3FAjbyHfzQdIGxIKUiwHeotpipuEGKuRV/PMdXEuqMd5+H7VqfDcr
         nrKQGr4MctHB1dC+tnh9yri/El4trBgFYcPkGGXHVwHTDUzLD/8PhrD5U5PYb6r4cuDo
         0VUo0GglL3MtK7j2txQTUcSpkPvQwh8SDNrRljz78M7cU8ITicAFDhl0y2BAsOipkvBV
         tzKHBtXM4RV3BdL2vO7UMAuBHRfOlwFPacWctzPtFuJ+TKnDbXe5nYTCPpP6rVXokPIw
         DueiVyF8zdYDSOQD/qhwnw6OevFzRAIMZdM/TL0pCZHQp7Y5UWztSQGtwH/elCF2AjX0
         06fg==
X-Gm-Message-State: ANoB5pmWA6jNb6e4NEDjOOE2+iqHuzDdwQrXjjrkQxyLcpIjWhSlQPVy
        lgqsJgohvDKUsLKEIidS2nKfVvqGF2Jfxsb2M/+WWYiM2m5KqMzwhLs=
X-Google-Smtp-Source: AA0mqf6k26/qeEiRU73qRpdDBw9Uo3IlwT0RttEXqvwaG39D9C+DGBBwR8pRMoVRXfT4KGPjaQ+aJPOgtr6MYcxqSmY=
X-Received: by 2002:a63:5823:0:b0:479:3a88:5e0 with SMTP id
 m35-20020a635823000000b004793a8805e0mr1076864pgb.466.1671216098286; Fri, 16
 Dec 2022 10:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20221216183314.169707-1-sj@kernel.org>
In-Reply-To: <20221216183314.169707-1-sj@kernel.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 16 Dec 2022 10:41:00 -0800
Message-ID: <CALmYWFvTrr+417E89tywHRqHP-TZnAuKgDa0SaV-7n7Ee2idwg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] kernel/pid_sysctl.h: Add missing definitions
 for specific config
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, dverkamp@chromium.org,
        keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae
Thank you for fixing this.
Do I need to send v9 of the original patch ?

On Fri, Dec 16, 2022 at 10:33 AM SeongJae Park <sj@kernel.org> wrote:
>
> Commit bdb6231e88a3 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC") on
> mm-unstable when CONFIG_SYSCTL or CONFIG_MEMFD_CRETE not defined, as
> below, because initialize_memfd_noexec_scope() and
> register_pid_ns_sysctl_table_vm(), which defined by the commit, is not
> defined for the config case.
>
>     ERROR:root:/kernel/pid_namespace.c: In function =E2=80=98create_pid_n=
amespace=E2=80=99:
>     /kernel/pid_namespace.c:114:2: error: implicit declaration of functio=
n =E2=80=98initialize_memfd_noexec_scope=E2=80=99; did you mean =E2=80=98se=
t_memfd_noexec_scope=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>       114 |  initialize_memfd_noexec_scope(ns);
>           |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |  set_memfd_noexec_scope
>     /kernel/pid_namespace.c: In function =E2=80=98pid_namespaces_init=E2=
=80=99:
>     /kernel/pid_namespace.c:462:2: error: implicit declaration of functio=
n =E2=80=98register_pid_ns_sysctl_table_vm=E2=80=99; did you mean =E2=80=98=
register_pid_ns_ctl_table_vm=E2=80=99? [-Werror=3Dimplicit-function-declara=
tion]
>       462 |  register_pid_ns_sysctl_table_vm();
>           |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |  register_pid_ns_ctl_table_vm
>     cc1: some warnings being treated as errors
>     make[3]: *** [/scripts/Makefile.build:250: kernel/pid_namespace.o] Er=
ror 1
>
> Fix the commit by defining the functions for the configuration.
>
> Fixes: bdb6231e88a3 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC") on mm-=
unstable
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  kernel/pid_sysctl.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
> index 90a93161a122..770c060a0d33 100644
> --- a/kernel/pid_sysctl.h
> +++ b/kernel/pid_sysctl.h
> @@ -52,8 +52,10 @@ static inline void register_pid_ns_sysctl_table_vm(voi=
d)
>         register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
>  }
>  #else
> +static inline void initialize_memfd_noexec_scope(struct pid_namespace *n=
s) {}
>  static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
>  static inline void register_pid_ns_ctl_table_vm(void) {}
register_pid_ns_ctl_table_vm can be removed.

Thanks
Jeff

+static inline void register_pid_ns_sysctl_table_vm(void) {}
>  #endif
>
>  #endif /* LINUX_PID_SYSCTL_H */
> --
> 2.25.1
>
