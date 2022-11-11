Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03416265C0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKKX6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKKX6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:58:53 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A063FB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:58:52 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id e2so2479451vkd.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8JT9M13sckQglSYnz67/MNWb2IU6rTVr9QN4GzMX8A=;
        b=KPKerYFjBPH1VGbukvGHkYJOu29d46QpHerJau0XCCuhI6njFbTssvaZt3CfuaSe32
         XolT/a1CPngFAHqPMlzf6/VK+25cv9nt00C3cZ9d5Rbeu67Gs3RoLzzk4aSwWD1FeNud
         ujP4tlNpGBsQxwDvlVm1bHcJHjnM5YkYOX+OpaEXIXYHdbxGywMYdB8d+7xztrWiu6Qe
         W3eDUYTV2UDyqlpLUpv+oZqLyuLl2JPMBfR/HC4RdY9qrC/UY4sBTNbcrlxPqFUrVlQD
         8gXW8w7xEYm7FIyp84wSy+qi3ghHcEWdZ77ecFbFqDDQzTVxNnU2GOJuNevfL6RacsKy
         un2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8JT9M13sckQglSYnz67/MNWb2IU6rTVr9QN4GzMX8A=;
        b=uYRho4peeOMg/O8z7xBWaGwnFMufuXwZGRs3ah7E2BcVU1llAvXjUXOkCn+OsYRYcr
         2gBAklN/tpBFPV7u7ezS2kfYTW5zWJnFqKGJPXSGZ1Htj7z/0nfgKHxRW4RWArNOcY9o
         nBCqPgVgyVXjKdwgnXHG0f4uNhkcAv2IybIvIDwlzQcjms4PLJL8HiK2Xpkuzf6kjsyt
         pgCzm/pt6S6a0nfGog8TgXX/nqwFDu7+L/Kor1wOYdqv2AeqffYcGzOMXM6nZOVlIN4t
         7KkK/roHfr9WaKylq6qoUpIFa7dT5Pmw2U6M/4ROwW5rVvIRQWETbxglrE43onnmRpIZ
         3CQw==
X-Gm-Message-State: ANoB5pktBe/NqWCCmhhncyAS59AQqCOZm5D/Z7j4Pk8dsal0tPv2JkwS
        BVKy+rUmWjYs4TLW8q+dY8yHV4x68ocY3Dt+PudnCFhpYEE=
X-Google-Smtp-Source: AA0mqf42n1LyZ07fkDGmBEqTKeXHJ7RdjFEXcW4Ujh3PZWRwYIZwGo70MwTJA8LOScYdnCS7hEUoGw70p45S/t6RVvA=
X-Received: by 2002:a1f:ac58:0:b0:3b5:719e:d7fa with SMTP id
 v85-20020a1fac58000000b003b5719ed7famr2204478vke.15.1668211130888; Fri, 11
 Nov 2022 15:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20221111235341.567987-1-jim.cromie@gmail.com>
In-Reply-To: <20221111235341.567987-1-jim.cromie@gmail.com>
From:   jim.cromie@gmail.com
Date:   Fri, 11 Nov 2022 16:58:24 -0700
Message-ID: <CAJfuBxzNtSfZjesPMH4eaovAYKgrGN0NeAD1VtbWwFokRBEG3w@mail.gmail.com>
Subject: Re: [PATCH 1/1] vmlinux.lds.h: improve BOUNDED_SECTION macros
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
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

crap, missed something. lemme fix and resend.

On Fri, Nov 11, 2022 at 4:53 PM Jim Cromie <jim.cromie@gmail.com> wrote:
>
> 1- replace _s_ & _e_ with the more visibly obvious _BEGIN_ & _END_.
>
> 2- add a new _HDR_ linker symbol before the KEEP(*(.gnu.linkonce.##_sec_)).
>    This gives the optional header record an extern'd name/address,
>    which is "_hdr_", b4/after the _sec_/_label_.
>
> 3- move existing _BEGIN_ linker symbol after the KEEP.
>    This insures the extern'd name always points at the data,
>    independent of whether a header has been defined.
>
> NOTE: if (start - hdr) { /* section has a header record */ }
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index cfad4511cd68..c9b204b0364c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -199,20 +199,22 @@
>  # endif
>  #endif
>
> -#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _s_, _e_)            \
> -       _s_##_label_ = .;                                               \
> +#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> +       _HDR_##_label_ = .;                                             \
>         KEEP(*(.gnu.linkonce.##_sec_))                                  \
> +       _BEGIN_##_label_ = .;                                           \
>         KEEP(*(_sec_))                                                  \
> -       _e_##_label_ = .;
> +       _END_##_label_ = .;
>
> -#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _s_, _e_)           \
> -       _label_##_s_ = .;                                               \
> +#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> +       _label_##_HDR_ = .;                                             \
>         KEEP(*(.gnu.linkonce.##_sec_))                                  \
> +       _label_##_BEGIN_ = .;                                           \
>         KEEP(*(_sec_))                                                  \
> -       _label_##_e_ = .;
> +       _label_##_END_ = .;
>
>  #define BOUNDED_SECTION_BY(_sec_, _label_)                             \
> -       BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
> +       BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop, _hdr_)
>
>  #define BOUNDED_SECTION(_sec)   BOUNDED_SECTION_BY(_sec, _sec)
>
> --
> 2.38.1
>
