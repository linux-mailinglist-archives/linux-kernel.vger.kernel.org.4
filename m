Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1E643D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiLFGsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiLFGsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:48:41 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78C1F00A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:48:40 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id a16so18924084edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 22:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV4BRkcw7J2X95dDZsQQ3oLBuX11q5eUftbrluM0Dh0=;
        b=UCYj+J6vNMejYyu5GL5Vwr1CItxelqAJ2FIVwxYukksMh/VFZh+1u3XZYE8CCvT3l/
         wc9QjEpOksQnL7A5AkbTISOWo2buj52geY982eNonhLM32K+r6K81oNsCtPSDwSJPoL7
         rCNcrSEWh/7M5ZtEVxWmteWjXUXypezhkmgNdviw5ScSCFiVfH207t/tSf7fDqfnwfJ8
         Ftmd2o5sVtk5NlK/QV/7uaRzhJnLO0idzx3mTQkVodUcJvQMy2FgVh2OEJwTiIB5FGXW
         024ESBIx/c8w+1+VE7O8DWJ+TuZ45OUp5F9+aLnQYPSPNPAPuKYarTg6r1IF3PFK/43f
         x5RQ==
X-Gm-Message-State: ANoB5pm/Ryqp4dlbHqwvrLZtdTdm0GiGdmIYpfWxOiSDGcrfd297vIXk
        45jlTDjYf8QLkmkflQeD2y4=
X-Google-Smtp-Source: AA0mqf4d4dBaMsLlYCr5A7hjQB4AHXV7Mgl/bM4ChBIFIJeXuKLvPppdkNZh7idDsmJVUnZmfUjHLg==
X-Received: by 2002:a05:6402:2912:b0:46a:c132:8a25 with SMTP id ee18-20020a056402291200b0046ac1328a25mr44300824edb.205.1670309319238;
        Mon, 05 Dec 2022 22:48:39 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id m12-20020a50cc0c000000b00461c6e8453dsm625806edi.23.2022.12.05.22.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 22:48:38 -0800 (PST)
Message-ID: <45c09e48-9e69-2371-70d2-8a0b1e9f4899@kernel.org>
Date:   Tue, 6 Dec 2022 07:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [patch 3/3] VT: Bump font size limitation to 64x128 pixels
Content-Language: en-US
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbd@lists.altlinux.org
Cc:     linux-kernel@vger.kernel.org
References: <20221205000739.583233140@ens-lyon.org>
 <20221205000807.896278194@ens-lyon.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221205000807.896278194@ens-lyon.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 12. 22, 1:07, Samuel Thibault wrote:
> This moves 32x32 font size limitation checking down to drivers, so that
> fbcon can allow large fonts.
> 
> We still keep a limitation to 64x128 pixels so as to have a simple bounded
> allocation for con_font_get and in the userland kbd tool. That glyph size
> will however be enough to have 128x36 characters on a "16/9 8K display".
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Index: linux-6.0/drivers/tty/vt/vt.c
> ===================================================================
> --- linux-6.0.orig/drivers/tty/vt/vt.c
> +++ linux-6.0/drivers/tty/vt/vt.c
> @@ -4575,17 +4575,20 @@ void reset_palette(struct vc_data *vc)
...
> -#define max_font_size 65536
> +#define max_font_width	64
> +#define max_font_height	128
> +#define max_font_glyphs	512
> +#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)

So this is 64K -> 4M switch. We should likely convert to kvmalloc() too.

regards,
-- 
js
suse labs

