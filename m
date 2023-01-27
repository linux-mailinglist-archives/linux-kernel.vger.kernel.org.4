Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3E67EFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjA0Ukl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjA0UkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:40:18 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8037B7A5;
        Fri, 27 Jan 2023 12:40:14 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-15085b8a2f7so8081387fac.2;
        Fri, 27 Jan 2023 12:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADNmefQ5ddv9lexJLXvjJOWsX20ypccARIkMWrCDsdU=;
        b=gnY44xHkFPfQOlfYC48dS7wi533nwZkFFXvIBNI13+J8gG36zBpp3Orb1M9C9Jv1yY
         WF2vw45dvnkh1E4usbJ1S+kt6fzgrbOlEgZMKVj2OIj23ZgmZ6LntMfH7Cd2F3YTUDAA
         rCHEyjPT+05UwcnwpNQhSrVTDn8A0bsLFPWdWkdyw6RHYHOwtXGFPQVuAWu7sSys6u5V
         HgjRn/Zo1Z586bTc/IJrUjtaXJbRvk2+tR66mPwZjGVgrLeDPOZPg2qAxmPh4GQRiyZX
         mK8vSCKq2Y36vbuD7PbZjO4Mcx1tGF/23lD6ryo9F0OqymCsTQjW3lHjNQeCxtfxZqxg
         UonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADNmefQ5ddv9lexJLXvjJOWsX20ypccARIkMWrCDsdU=;
        b=BqLuGijxaiYTxCROmWvbmUrjnHVL0b4E6qzIE5ThpLfVj1BiDvaEBUmPGSHiTKw1sb
         9CmrW3Y+MUHP3f07HHDJiBygOAKKWp6q9VSjs26ZgY0iF0dCCqo/4WvIiet9WQyUNNVP
         GRFUljbILnsho7oqa2YdkitTG+YU94ORBRJXLL33ppDICIYmCkXA7NTYjBQp1eR8J45t
         8liXleFYI7YRYJyMWS5iR8HdfB0GgR14TdKa+nOAyIvkCxHK8vplRZAl93nkET0ltAmp
         k7bZVBE7vxbkIuyIEsjTYIaoInlet1e8ydSbW39AlRDGyXdRd2B/9NBhJiqpITClWj8I
         M7jA==
X-Gm-Message-State: AFqh2kqBy5xcmvgb0aDuUmXhHJTQiZVC7fr8bioHMhfUmOeElfembr+Q
        3qkhN3UkQ2l18Tru0cd3piY=
X-Google-Smtp-Source: AMrXdXtIR8tlLDSqPWcZrNvMujYjxJX6tDev+59gX4IU+JfFmw+PqKDqxQTYJSnPyG4tWWP+UevnYw==
X-Received: by 2002:a05:6871:4497:b0:144:7065:30cf with SMTP id ne23-20020a056871449700b00144706530cfmr21084349oab.24.1674852013436;
        Fri, 27 Jan 2023 12:40:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870820100b00163482967e1sm2342635oae.6.2023.01.27.12.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:40:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Jan 2023 12:40:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] module: replace module_layout with module_memory
Message-ID: <20230127204011.GA45594@roeck-us.net>
References: <20230126233606.1317794-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126233606.1317794-1-song@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:36:06PM -0800, Song Liu wrote:
> module_layout manages different types of memory (text, data, rodata, etc.)
> in one allocation, which is problematic for some reasons:
> 
> 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> 2. It is hard to use huge pages in modules (and not break strict rwx).
> 3. Many archs uses module_layout for arch-specific data, but it is not
>    obvious how these data are used (are they RO, RX, or RW?)
> 
> Improve the scenario by replacing 2 (or 3) module_layout per module with
> up to 7 module_memory per module:
> 
>         MOD_MEM_TYPE_TEXT,
>         MOD_MEM_TYPE_DATA,
>         MOD_MEM_TYPE_RODATA,
>         MOD_MEM_TYPE_RO_AFTER_INIT,
>         MOD_MEM_TYPE_INIT_TEXT,
>         MOD_MEM_TYPE_INIT_DATA,
>         MOD_MEM_TYPE_INIT_RODATA,
> 
> and allocating them separately. This adds slightly more entries to
> mod_tree (from up to 3 entries per module, to up to 7 entries per
> module). However, this at most adds a small constant overhead to
> __module_address(), which is expected to be fast.
> 
> Various archs use module_layout for different data. These data are put
> into different module_memory based on their location in module_layout.
> IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
> data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.
> 
> module_memory simplifies quite some of the module code. For example,
> ARCH_WANTS_MODULES_DATA_IN_VMALLOC is a lot cleaner, as it just uses a
> different allocator for the data. kernel/module/strict_rwx.c is also
> much cleaner with module_memory.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> 
> ---

Build reference: v6.2-rc5-52-gc96fb00
Compiler version: powerpc64-linux-gcc (GCC) 11.3.0
Assembler version: GNU assembler (GNU Binutils) 2.39

Building powerpc:defconfig ... passed
Building powerpc:allmodconfig ... passed
Building powerpc:ppc32_allmodconfig ... failed
--------------
Error log:
kernel/module/main.c: In function 'show_coresize':
kernel/module/main.c:938:22: error: unused variable 'size' [-Werror=unused-variable]
  938 |         unsigned int size = 0;

That is the only failure reported by my test system.

Guenter
