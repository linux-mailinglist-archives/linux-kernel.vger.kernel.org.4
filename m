Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3846C8010
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjCXOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjCXOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:40:07 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB826B8;
        Fri, 24 Mar 2023 07:40:06 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id o44so1744862qvo.4;
        Fri, 24 Mar 2023 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679668805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZ+FnuD6iDMKohenvupPcKcbCMvj6BGk7EGrdtydLi4=;
        b=DZxxrj+Stk5Uv8pzQwik0wx4XmDNcc00IpFxgDuhUSykaaaE26syTaLhbelMti6vaK
         1vFmhpGo2wsGPtPvH9OeQjCuy8QEJlQNMar3TsRxDloiwFNshL3iWN+mI4Ueb44Gu28X
         qsNJn5ngfdjOGkrHbFhnK3jspExVAiQlDs4NgNeD0oHPhnV/IbfQ0ng1qFUZsZPQJIV4
         7UTC/FhrQtvVFWyt6FtkyYHDs+1YPZ884IgAdg/DJePG9nIhYZohh4adJdcN43Erz4Bl
         XQh53tfh+ao4FoliWTRtTRp/idjojLAohcyprRf+Jz3Tzt1IsIH4ndwpC/OBN/rJqdWg
         sowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679668805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ+FnuD6iDMKohenvupPcKcbCMvj6BGk7EGrdtydLi4=;
        b=aLsodYLqZuzXX9+eKphZo4NWO5EPWALS2UNZuLNGkOvRDSpKVTBp1zEzwIhmyq+sep
         6BTZBby+PEripA5bgcENdBrWnSEN+ouW4ieWH+0hu6H9Bt/6bZqst50+Al/JdMNZLC7g
         oUzzWTqpNUBabURQXK7M5DTYIiki2XC9n806HsxTaUpbPYT4knJiExyb59AEZ82Ihq96
         J4AyE0L9erl3wY9usRX2tozGwwg6E9ap0bIX7bzNCkwbtTTFaG+ogxJmpPKO/mjQV9dA
         bnRIqcMOeBCXskCK44O6xreK45k6qK6qizRaUYSejipGO7bpob/nUGdJKlL5MYU0H9Ea
         riXw==
X-Gm-Message-State: AAQBX9fIFdw/evVswOqrgcFgRXzvwy4094oziBqrOlm2NufcXCYvA7zH
        slPVDyEHi9/YxF0i0p8HWBV3nUQv/wvvlw==
X-Google-Smtp-Source: AKy350bQ4AeHwopd9xS4Uj0ytYzVf5KD8M7bXNU5FPlZDmCMOI2BMivIJd7DM/o6vK3pC2JXBFz1Lg==
X-Received: by 2002:a05:6214:ac6:b0:5ac:208c:4e64 with SMTP id g6-20020a0562140ac600b005ac208c4e64mr5471900qvi.37.1679668805623;
        Fri, 24 Mar 2023 07:40:05 -0700 (PDT)
Received: from shaak (modemcable162.144-226-192.mc.videotron.ca. [192.226.144.162])
        by smtp.gmail.com with ESMTPSA id qh5-20020a0562144c0500b005dd8b93459bsm731722qvb.51.2023.03.24.07.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:40:05 -0700 (PDT)
Date:   Fri, 24 Mar 2023 10:40:03 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Wu XiangCheng <bobwxc@email.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation: core-api: update kernel-doc reference to
 kmod.c
Message-ID: <20230324144003.GA2456286@shaak>
References: <20230324085310.20571-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230324085310.20571-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 03:53:10PM +0700, Bagas Sanjaya wrote:
> Commit d6f819908f8aac ("module: fold usermode helper kmod into modules
> directory") moves kmod helper implementation (kmod.c) to kernel/module/
> directory but forgets to update its reference on kernel api doc, hence:
> 
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 2.4.4 -export ./kernel/kmod.c' failed with return code 2
> 
> Update the reference.
> 
> Fixes: d6f819908f8aac ("module: fold usermode helper kmod into modules directory")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/linux-next/20230324154413.19cc78be@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  Documentation/core-api/kernel-api.rst                    | 2 +-
>  Documentation/translations/zh_CN/core-api/kernel-api.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 62f961610773d6..e2772859600801 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -223,7 +223,7 @@ Module Support
>  Module Loading
>  --------------
>  
> -.. kernel-doc:: kernel/kmod.c
> +.. kernel-doc:: kernel/module/kmod.c
>     :export:
>  
>  Inter Module support
> diff --git a/Documentation/translations/zh_CN/core-api/kernel-api.rst b/Documentation/translations/zh_CN/core-api/kernel-api.rst
> index a4b373c48c0c9b..a1ea7081077cee 100644
> --- a/Documentation/translations/zh_CN/core-api/kernel-api.rst
> +++ b/Documentation/translations/zh_CN/core-api/kernel-api.rst
> @@ -226,7 +226,7 @@ kernel/relay.c
>  
>  该API在以下内核代码中:
>  
> -kernel/kmod.c
> +kernel/module/kmod.c
>  
>  模块接口支持
>  ------------
> 
> base-commit: 6e82310365bade624ff38dd11a8467739adab6cc
> -- 
> An old man doll... just what I always wanted! - Clara
> 
