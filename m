Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428626337FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiKVJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiKVJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:08:42 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683813CEC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:08:41 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v184so1218836ybv.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kOWylR3pFDf7/iXRlM9MtBiVx3OCX5Q16RmYl/Duvpc=;
        b=m2uhLbeZ0IvOt+TJn8j6XJHO5vN1TSxjVNIzabIvnTdb6SyowH+kexPolXKdL2zU5g
         5UYfs+BV5XSWttveP/L/5B20wrefHf8yMpma5OVTOk5vNmKqZs5VNYGNOijmRWQAzVAL
         b9NHWH6iiUJZiStgkkuc9V6T8zmfM3DFOVbTnbado9gvOZoaXNcjY0m6PIawJyFm/Qqe
         iF2jyaqdzxu04pK8JUfpXA+ZhroZcEZlTmRI/7n+SORbm5oE3sNidqHjSjUvvf6EOR9M
         Lqw3gcc7qM3yrQFMOjkdQWDRR5NWqRRE8wpbG4YrODrVu9KpqIYTKIKgFSPMZaCN84RI
         mIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOWylR3pFDf7/iXRlM9MtBiVx3OCX5Q16RmYl/Duvpc=;
        b=npaS0MAlRmsZFB3IF4NYGRf4YnUqPd9VscCay0MoK7GBY58955sdCExUmLYiJsJthl
         4ZjqOQZBuRFllyEcbvCz7d1aZpDpok3So4ZMymmIwwYDbqjgXGEK/mxPxrp3eKbgujmT
         ZExqhT2eeqa1zjJCY8TB3zUpdeyoqeRUa84snT0Zt0vCA3R9tSt2IrvYZ9dq/CXB/fl3
         iaLz0X0zzLqNZAtrGrK8F2R9QfzpShnS2JxDunI90sB2E3VI/lz/yLQB4HGlH3r3G/c4
         Ni2umUyVCXFUrGTdgWAWVJ5SJ7smIAsBOGJph6Q6FCzr3ERmm6WTviNRLKwIin5p64/l
         0/TQ==
X-Gm-Message-State: ANoB5pkB1eEu2n/NR6UatvQTqCKSgvNKryvRikpI3rnXSuFOU7OUUtuK
        TqEKJBAoD3viii5deFIeFIAQqFViHX1l4MG8DTtOAprFt0iJFA==
X-Google-Smtp-Source: AA0mqf6GSa8pMJKCbBfaOwHcNLUDn2z/mEKkuoq4i2UxurDiU9eW1iF2AMMY9G/K7R3Gu53wMUF4iPxqWznv/Gn9P5o=
X-Received: by 2002:a25:9d8f:0:b0:6d0:155f:aa9e with SMTP id
 v15-20020a259d8f000000b006d0155faa9emr2687662ybp.448.1669108119939; Tue, 22
 Nov 2022 01:08:39 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Nov 2022 14:38:28 +0530
Message-ID: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
Subject: next-20221122: tinyconfig: ppc n s390: kernel/printk/printk.c:95:1:
 error: type specifier missing, defaults to 'int'; ISO C99 and later do not
 support implicit int [-Werror,-Wimplicit-int]
To:     open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        lkft-triage@lists.linaro.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today's Linux next 20221122 tag clang-15 tinyconfig builds fails on
powerpc and s390 architectures.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM_IAS=0 ARCH=s390
CROSS_COMPILE=s390x-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'

kernel/printk/printk.c:95:1: error: type specifier missing, defaults
to 'int'; ISO C99 and later do not support implicit int
[-Werror,-Wimplicit-int]
DEFINE_STATIC_SRCU(console_srcu);
^
int
kernel/printk/printk.c:95:20: error: a parameter list without types is
only allowed in a function definition
DEFINE_STATIC_SRCU(console_srcu);
                   ^
kernel/printk/printk.c:261:29: error: use of undeclared identifier
'console_srcu'
                     srcu_read_lock_held(&console_srcu));
                                          ^
kernel/printk/printk.c:288:33: error: use of undeclared identifier
'console_srcu'
        return srcu_read_lock_nmisafe(&console_srcu);
                                       ^
kernel/printk/printk.c:300:28: error: use of undeclared identifier
'console_srcu'
        srcu_read_unlock_nmisafe(&console_srcu, cookie);
                                  ^
kernel/printk/printk.c:3122:20: error: use of undeclared identifier
'console_srcu'
        synchronize_srcu(&console_srcu);
                          ^
kernel/printk/printk.c:3469:20: error: use of undeclared identifier
'console_srcu'
        synchronize_srcu(&console_srcu);
                          ^
kernel/printk/printk.c:3521:20: error: use of undeclared identifier
'console_srcu'
        synchronize_srcu(&console_srcu);
                          ^
8 errors generated.

log:
https://builds.tuxbuild.com/2HtTqOb2b83eGTzpS4bjLf59Agd/

Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221122/testrun/13121925/suite/build/test/clang-15-tinyconfig/history/

--
Linaro LKFT
https://lkft.linaro.org
