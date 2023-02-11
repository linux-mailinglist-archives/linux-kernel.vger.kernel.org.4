Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96A692FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBKJE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 04:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:04:24 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934C825E09
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 01:04:19 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 07BF43F0C3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676106258;
        bh=JTWhnPK3hGhmoS62vdcZPivga8RvP1/7sZ3MmJUomNY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=uWreLVPma6ogaVwmOjp0gwIUTga5/8dyLPzeURqTJ/DfaqmzQGO827HtveJklv6xc
         0GkdzwMg55srBnKkAv1s5+DbXrxvPs7UcEOvSqpBHbT3bzm7qpUmWst2MOGGhcSEUd
         3DjjMT00m8RleneuLKeqmTv745Or73FrIvRlKHGptP7211Ey9BcaOEG1EbVRF44FrG
         nVtDJmB7k7z6xSNrh6MuecpkoEyCr/qTznYLIfPhlwhKn0qNiaNoQtnFolxop/CfFn
         P2OrAqKmaRYEjwNYN5tKX9gOrN5T87VqaLZL0Ye7c6RO0AT7KUEjZTzgFF3xpPkZxV
         Z0Q1lQG70oGaw==
Received: by mail-ej1-f70.google.com with SMTP id ts7-20020a170907c5c700b008af2a9e7d70so5009640ejc.22
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 01:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTWhnPK3hGhmoS62vdcZPivga8RvP1/7sZ3MmJUomNY=;
        b=qY20pZragCjT7GDEkCns3oP0nP5ssQ0KHp27Ewxy2ZPWa33qvob8sUqB/D2hcew9/0
         OqXNmwnXpzoR1Pxb7TElbSqMh4SHpljbtxpQZrYX3ioYoEhTrVUutaInCu9zI+L0iZW5
         p5i7Rkf8UK4rZiw9gSx8AubUbhJyeDZ1NqcUvhFsID7xgk0Kz07S0nTyHLaDAHRpIRou
         ydmQ/GGwSolPy9/GriPlyKuI3mZz579/TxlJ6r3qAxRm5n/cpzZ3D2gTWka8ZpjlkcHQ
         rN+z6gCUlm6DbVE/67aKvccnek51bAsmW7SEUpQjgIa80VCJhTAgr1zwSUyPb2yTKJ0r
         bV+A==
X-Gm-Message-State: AO0yUKXkItnR6g2iSg/5xKOf7AZbOCZFqCH39ndGWZZdGMTZEEBW+KG6
        3R+dh0TbumlDBye0uX+/UA0jVKuGKKNQNOnmC9yBRajrj5SK9A4fxFSNpeNAKvDHz2B0WCWaTC1
        Dx3ftHkyogz5LPTyUYyLmcvnOg5oUclDr0YsKhQG88w==
X-Received: by 2002:a17:906:6547:b0:879:bff:55c with SMTP id u7-20020a170906654700b008790bff055cmr20543649ejn.1.1676106257746;
        Sat, 11 Feb 2023 01:04:17 -0800 (PST)
X-Google-Smtp-Source: AK7set/WAEyoXApGuZQIUyD22/STjnJ1o9SNWqDgtMLsa1cbL2rLSaY1LzQjuwF0wHg3xnrnbVqtqQ==
X-Received: by 2002:a17:906:6547:b0:879:bff:55c with SMTP id u7-20020a170906654700b008790bff055cmr20543637ejn.1.1676106257551;
        Sat, 11 Feb 2023 01:04:17 -0800 (PST)
Received: from localhost (host-87-7-128-191.retail.telecomitalia.it. [87.7.128.191])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm714911edb.83.2023.02.11.01.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 01:04:17 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:04:16 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Kees Cook <kees@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
Message-ID: <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
References: <20230210215141.108958-1-andrea.righi@canonical.com>
 <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 02:43:56PM -0800, Kees Cook wrote:
> On February 10, 2023 1:51:41 PM PST, Andrea Righi <andrea.righi@canonical.com> wrote:
> >With CONFIG_INIT_STACK_ALL_ZERO enabled, bindgen passes
> >-ftrivial-auto-var-init=zero to clang, that triggers the following
> >error:
> >
> > error: '-ftrivial-auto-var-init=zero' hasn't been enabled; enable it at your own peril for benchmarking purpose only with '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang'
> >
> >However, this additional option that is currently required by clang is
> >going to be removed in the future (as the name of the option suggests),
> >likely with clang-17.
> >
> >So, make sure bindgen is using this extra option if the major version of
> >the libclang used by bindgen is < 17.
> >
> >In this way we can enable CONFIG_INIT_STACK_ALL_ZERO with CONFIG_RUST
> >without triggering any build error.
> >
> >Link: https://github.com/llvm/llvm-project/issues/44842
> >Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> >---
> >
> >Changes in v2:
> > - check the version of libclang used by bindgen to determine if we need
> >   to pass the additional clang option
> >
> > rust/Makefile | 13 +++++++++++++
> > 1 file changed, 13 insertions(+)
> >
> >diff --git a/rust/Makefile b/rust/Makefile
> >index ff70c4c916f8..c77d7ce96a85 100644
> >--- a/rust/Makefile
> >+++ b/rust/Makefile
> >@@ -269,6 +269,19 @@ BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
> > # some configurations, with new GCC versions, etc.
> > bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET)
> > 
> >+# Auto variable zero-initialization requires an additional special option with
> >+# clang that is going to be removed sometimes in the future (likely in
> >+# clang-17), so make sure to pass this option only if clang supports it
> >+# (libclang major version < 17).
> >+#
> >+# https://github.com/llvm/llvm-project/issues/44842
> >+ifdef CONFIG_INIT_STACK_ALL_ZERO
> >+libclang_maj_ver=$(shell $(BINDGEN) $(srctree)/scripts/rust_is_available_bindgen_libclang.h 2>&1 | sed -ne 's/.*clang version \([0-9]*\).*/\1/p')
> >+ifeq ($(shell expr $(libclang_maj_ver) \< 17), 1)
> >+bindgen_extra_c_flags += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> >+endif
> >+endif
> 
> This logic already exists in the top-level Makefile. How does -ftrivial-auto-var-init=zero make it into bindgen_c_flags normally? (I.e. why does the legacy -enable... option not?)

If we're using gcc, the top-level Makefile doesn't set the clang
options, so in this case CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER is
undefined.  But then bindgen always relies on libclang to parse C, even
if gcc is used globally, therefore it needs the extra clang flag.

Ideally it'd be nice if bindgen would support a gcc backend, but until
then we need to do something special here, like this kind of duplicated
logic...

-Andrea

> 
> >+
> > bindgen_c_flags = $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
> > 	$(bindgen_extra_c_flags)
> > endif
> 
> 
> -- 
> Kees Cook
