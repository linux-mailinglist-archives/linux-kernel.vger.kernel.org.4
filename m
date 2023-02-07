Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5CB68DD4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjBGPse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjBGPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:48:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EFA5FEF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:48:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u9so11770907plf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=344MbQ5Aogx4TbSHT23t8yYX3VVQUnb53jmXZ8Ta6+U=;
        b=D2nx2e6v0uOHYhJ/HCEsinnnMK+TtbG250AgmjRzeMNrzgdCYNJwualCwtmvNMBQMu
         TypvhDWgPwn4IkJ9xaZdfIWqFaZraTe6B1bn4pAGrTIZ34aH8sv1xQRJXTfX0mpm8qFa
         4z0T/tgzsj4rESnPSfxbyiGHxCireDk8j42G3FWSAlJixs21Esf+o9D6Ebd70z2mYVF4
         0SIu98uEPUYdpJhl57+Eb9vujiRntKckzNNS16PBEG0Z2Q2u1CeJqHHzPaJWcZTPfIzU
         iqEkXZKs5+pm+3EMK6F0WDFR+xnle+ATa7CFu1srK5CdT1ptiY46dgWqTGBFLAxx8Mqo
         TKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=344MbQ5Aogx4TbSHT23t8yYX3VVQUnb53jmXZ8Ta6+U=;
        b=WaqfENuNJzCjkGvbvExobQM/ROMHCjT5maRDmjkhfXHEKj2MuuKl2mhBKd4oG3grRn
         +W7yxIChX1BnrzKoer1dgQ2GgWu6hze2lI0KlPEp6Xzd4SKHIPd7Nd+YgNKH6Zjur3Pp
         luuVI8LyI90NDK0xL9vbUbEIebSH3IFNu3uDfaOqgCcbmZyJap7DrjNfHZcykMI1gvbg
         LNOVJVjGpSSe5839lIcm4D+BXZ/+7VWbTEr7nq9TEmiWkwHUnbUA/1FnbyFOV2RB1p/e
         dPFfzDeB1sLD1NK8rbfwiPOnl7jeXMTrrXU4+3hxGkCh1vP3pSfGeO9EEawON7zgR9Ym
         mRDg==
X-Gm-Message-State: AO0yUKVnd0lqqQn7vg7wzHBBk1Qm3SY8PB/EvGD1w29luM5xfHE1YVfx
        l5hVCO1G1DG7ZpS7PVGvaR9kL/IiYXBLxUZqUnq/Mxg8iHQ=
X-Google-Smtp-Source: AK7set/2ed2qey7Q7Ye3j2Cy7zIPmnAhR6m2DNLZk/aCKTvEekzuCIO211zE+Lr6hiFgotYZZumB8cJkspi1asjtKr4=
X-Received: by 2002:a17:90a:3d01:b0:22c:19cb:948a with SMTP id
 h1-20020a17090a3d0100b0022c19cb948amr1033130pjc.98.1675784911094; Tue, 07 Feb
 2023 07:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20230204090139.1789264-1-xiehuan09@gmail.com>
In-Reply-To: <20230204090139.1789264-1-xiehuan09@gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Tue, 7 Feb 2023 23:48:19 +0800
Message-ID: <CAEr6+EA7L68kGPW43YwDOhpBVMQhJ0WNbMEreNFpz=8Q=C_S+A@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: fix 'lx-current' for x86
To:     jan.kiszka@siemens.com, kbingham@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew was added.

Hi Andrew,

I found the patches for the ./scripts/gdb/*  were merged by you before,
but the "./scripts/get_maintainer.pl ./scripts/gdb/linux/cpus.py"
can't find your name,  so added you.

Can you review this patch ;-)

On Sat, Feb 4, 2023 at 5:02 PM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> When printing the name of the current process, it will report an error:
> (gdb) p $lx_current().comm
> Python Exception <class 'gdb.error'> No symbol "current_task" in current context.:
> Error occurred in Python: No symbol "current_task" in current context.
>
> Because the commit <e57ef2ed97c1> ("x86: Put hot per CPU variables into a struct")
> changed it.
>
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  scripts/gdb/linux/cpus.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..9ee99f9fae8d 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -163,7 +163,7 @@ def get_current_task(cpu):
>      task_ptr_type = task_type.get_type().pointer()
>
>      if utils.is_target_arch("x86"):
> -         var_ptr = gdb.parse_and_eval("&current_task")
> +         var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
>           return per_cpu(var_ptr, cpu).dereference()
>      elif utils.is_target_arch("aarch64"):
>           current_task_addr = gdb.parse_and_eval("$SP_EL0")
> --
> 2.25.1
>

-- 
Thanks,
JeffXie
