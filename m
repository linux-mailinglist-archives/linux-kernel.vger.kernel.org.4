Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7C5ED5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiI1HMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiI1HMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:12:47 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D3B68
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:12:46 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3454b0b1b6dso121957087b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JLSZ+e3730aTxSTQOi3+cCaphuLOQPfH96e2c1/cH8M=;
        b=EMgceXCzaQDvdTU8qyB3pmXe3XJjSaEZRookdv50oYQ16GXYzLQurk6I1r2pa/Iw/E
         fctj8RiZImlwy8WCySDitutm6T8dKm24xm4ujSxz42lov4JSN61ZEjJaMVJgnUk653Aw
         IsvBc2rK4Iwjk9Z8IdPefHdrdrgJRkby8kgUUjnZ7tNfa+UF9fkOkJ8BFc9nBNWsaYyz
         aiFySGXIC56u9RmK7HxJRJz8oTtLJtuNXn19voXllfg1MmKSe37U/sm8ha+vXgycsn2r
         B6Ck08Dhuxa4cysmdSqSUxFqtNJp0lKRk1nqQmN9/BQyoDfknbRU6q6m3qnAteC05X0M
         KtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JLSZ+e3730aTxSTQOi3+cCaphuLOQPfH96e2c1/cH8M=;
        b=4NLWZyPFBNSb0Qd226yqir88dUhW9DZbVT68CEZxpJ+To/VRd/YF/YQtSQ6glMaFCV
         I8cpawbWoG3w7aCMJYvKnRZM3W+1V4UNAgGj3gsKW7A4+PaP11pi6gKxp9iXAWjqvgSt
         a1Gu6Ztuq1ReWghVGzCatmAoe9u2EtFhbeiRzy8kcjDHPi8Z+6JRhRBOW/D5/lGS3kld
         5QAo72Rxco1JXvJy51CKH5/qca9hSEFjFWentenhtnPR10vJ4C+Nn3oMlxFvV59QZGAV
         BqhY/FEujf0GQsu4sLmHbAg8MjtSjrJAJfXbCDqyAHhyb7FuvMk2UehwHLAEjzVQnQed
         e3lg==
X-Gm-Message-State: ACrzQf0ztXc9HK6Jeyd+YhhOOgbLtgQ4n9onOp7RW4Ls5/l8nFntaQtX
        dHS0ez1sPLrcIxbK6NSq4MzU/rc8bMuy/YIa6yY=
X-Google-Smtp-Source: AMsMyM7xm3CSSzoJExPj63oKfZBn23heJc5PZ8Doxz/fePeExQhsS8e0uEX9izFeNN19mlwM7NXqUtgFzVwM13pJhSs=
X-Received: by 2002:a0d:c747:0:b0:34d:9bb3:94ec with SMTP id
 j68-20020a0dc747000000b0034d9bb394ecmr27375516ywd.464.1664349165611; Wed, 28
 Sep 2022 00:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220928064934.70867-1-renzhijie2@huawei.com>
In-Reply-To: <20220928064934.70867-1-renzhijie2@huawei.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 28 Sep 2022 09:12:34 +0200
Message-ID: <CAKXUXMzbwKRBR2kPLcU7zXwyd8Krm8zevFFzWenr2RBWHdOLtw@mail.gmail.com>
Subject: Re: [PATCH -next] init/Kconfig: fix unmet direct dependencies
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     akpm@linux-foundation.org, ndesaulniers@google.com,
        nathan@kernel.org, vbabka@suse.cz, masahiroy@kernel.org,
        arnd@arndb.de, bigeasy@linutronix.de, seanjc@google.com,
        hannes@cmpxchg.org, ojeda@kernel.org, mhiramat@kernel.org,
        dmitry.torokhov@gmail.com, atomlin@redhat.com, ddiss@suse.de,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 8:53 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
>
> Commit 3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on PROC_FS")
> make config PROC_CHILDREN depend on PROC_FS.
>
> When CONFIG_PROC_FS is not set and CONFIG_CHECKPOINT_RESTORE=y,
> make menuconfig screams like this:
>
> WARNING: unmet direct dependencies detected for PROC_CHILDREN
>   Depends on [n]: PROC_FS [=n]
>   Selected by [y]:
>   - CHECKPOINT_RESTORE [=y]
>
> So add PROC_FS to dependencies to fix this.
> Fixes: 3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on PROC_FS")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

This patch here makes sense.

Just some minor addition:

The commit  3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on
PROC_FS") is not really broken, but just made the implicit
dependencies much more explicit and hence now this warning from
menuconfig indicates that.

Before the commit 3c07bfce92a5 ("proc: make config PROC_CHILDREN
depend on PROC_FS"):

When CONFIG_PROC_FS is not set and CONFIG_CHECKPOINT_RESTORE=y, then
the feature of CONFIG_CHECKPOINT_RESTORE would just not worked (as
this would not be any proc fs, and no "proc children" functionality.)

After the commit 3c07bfce92a5 ("proc: make config PROC_CHILDREN depend
on PROC_FS"):

When CONFIG_PROC_FS is not set and CONFIG_CHECKPOINT_RESTORE=y, it
warns to add PROC_FS to assist in configuring something that makes the
feature of CONFIG_CHECKPOINT_RESTORE work.

So this patch is yet another improvement to what the commit
3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on PROC_FS")
already partially improved. However, feel free to keep the Fixes-tag
in this patch, as this patch certainly improves handling of what the
commit 3c07bfce92a5 started improving.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

The recipient list is a bit "random" (coincidental). You could have
probably just sent this patch to Andrew Morton, me and linux-kernel
mailing list.

Lukas

> ---
>  init/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index e11307310fc1..fc32b28fe93e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1273,6 +1273,7 @@ endif # NAMESPACES
>
>  config CHECKPOINT_RESTORE
>         bool "Checkpoint/restore support"
> +       select PROC_FS
>         select PROC_CHILDREN
>         select KCMP
>         default n
> --
> 2.17.1
>
