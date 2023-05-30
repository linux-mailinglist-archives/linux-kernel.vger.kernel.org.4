Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66C67163D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjE3OVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjE3OVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:21:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC761A2;
        Tue, 30 May 2023 07:20:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d18d772bdso5189454b3a.3;
        Tue, 30 May 2023 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456390; x=1688048390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+KFzTDLcAELo4/qAfwlsys8YbTJv+6TEu1EwszVUPXM=;
        b=K6sXzcPZ9u3sVm6s05HsH7s2jLM6pRqQ3bkJsL62EAPyiFL5931sc34uFQ1NH7lGeP
         5TBxzLPAp+giS79MiStXCSDGLFOV7yUajamStGzSwE/HmuP/xlPsPm3zp/5pURscHlqj
         Pv1gd51G2QAbrenlXZzss7T36t4ZhZWXDbKexqc0alZn/2SEllmLkNlhUvlfHPIY9LPe
         Krq5/pS06izA/JOGnzAzq2O4UCmNAThEoLN6smqPSGKVWtDuUGezZ++hX4oTNKQpiqHG
         PwdPEsGV6AYXcahBCjvozuv+Xlo93EQsi6PlVOUxYPiudfVsMw8HK+j97d4CBXnCXUhq
         TIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456390; x=1688048390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KFzTDLcAELo4/qAfwlsys8YbTJv+6TEu1EwszVUPXM=;
        b=aTwKGGOg4LvTRkrPgjWaxSOW5S/+Gc0Bafzsm0F4J9aucNrx3zHFQd4bU9ZZrbVNA0
         9ouHGRL4USZC+nit/2qidZ9BUb/3kkuHyfge0kMBatZ3kRppid5KGmHomfz8Dze6V5rs
         nxNfJYKUMC4ahp/lJr4LhgI5u0H6Di4jYlGeevsyK9tUsqRn7hiZXnOXK2rEoNykJH7j
         7UMrBlyfsTQzFAPfulfgQqfwLaKyD4lxOpRqB67zxWseC+bRyZLAw8J0qDo2dHZWPE4g
         b7HZWTBhnn5tsPtwyr99Lf7IozVmD8IcCzYWsR0TqL4xsveSIJ5SMXKuoyT2AKwmh1KP
         ktWw==
X-Gm-Message-State: AC+VfDwO05cpF8has+V7iUU0qzWGu7CN3J/r1zwoYFY8gFI2DxyZExhA
        OPGWHHCO3v/YIv1dCxe+j4IlHOJEeLE=
X-Google-Smtp-Source: ACHHUZ4Oh+YH8nEpx1yXhToEkvXAvMyIljOPyb2fwCnMrXEr6SqNrXocFPEUJwDIU0ZB3L6XFWcYOg==
X-Received: by 2002:a05:6a00:1389:b0:645:1081:98ec with SMTP id t9-20020a056a00138900b00645108198ecmr3286264pfg.13.1685456389855;
        Tue, 30 May 2023 07:19:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7880c000000b00646ebc77b1fsm1702962pfo.75.2023.05.30.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:19:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 May 2023 07:19:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] parisc: Enable LOCKDEP support
Message-ID: <1e406b76-77c2-4ffd-ba51-943f36416a6b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge,

On Tue, May 23, 2023 at 09:06:40AM +0200, Helge Deller wrote:
> Cc: <stable@vger.kernel.org> # v6.0+
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  arch/parisc/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 466a25525364..967bde65dd0e 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -130,6 +130,10 @@ config PM
>  config STACKTRACE_SUPPORT
>  	def_bool y
>  
> +config LOCKDEP_SUPPORT
> +	bool
> +	default y
> +
>  config ISA_DMA_API
>  	bool
>  

This patch results in a bunch of WARNING message with each parisc boot if
CONFIG_PROVE_LOCKING and CONFIG_DEBUG_LOCKDEP are enabled.

WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5545 check_flags+0x24c/0x274
Backtrace:
 [<1026d44c>] lock_acquire+0xdc/0x388
 [<10e8c66c>] _raw_spin_lock_irqsave+0x64/0x98
 [<10e922dc>] down_trylock+0x20/0x58
 [<102768c8>] __down_trylock_console_sem+0x44/0x114
 [<1027b768>] vprintk_emit+0xa8/0x3dc
 [<1027bac4>] vprintk_default+0x28/0x38
 [<1027c574>] vprintk+0xa4/0xb4
 [<10e6c62c>] _printk+0x30/0x40
 [<10e37700>] report_bug+0x338/0x35c
 [<101c19fc>] handle_interruption+0x654/0x768
 [<101bb070>] intr_check_sig+0x0/0x38

WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:367 ct_irq_enter+0x94/0xb0
Backtrace:
 [<101f0c1c>] irq_enter+0x18/0x30
 [<101c2dec>] do_cpu_irq_mask+0x7c/0x388
 [<101bb064>] intr_return+0x0/0xc

Is that going to be fixed, or should I disable CONFIG_PROVE_LOCKING
for parisc in my testing ?

Thanks,
Guenter
