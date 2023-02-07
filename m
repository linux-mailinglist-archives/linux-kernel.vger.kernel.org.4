Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D207F68DDBC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjBGQQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjBGQQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:16:15 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A95FFC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:16:14 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id cz15so7166398vsb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECI+PzCj+E54+WpHWzgMmg74ln8b0Tr68JRWC1+n9Sc=;
        b=Z/ylueHNUjN0c3ItPm/Efhz3UI9FvbJA+ZUKR1ljVfSwG1SdBn8GUzRooA2+bqzRxR
         2Do2i4/SxXrs3kO+3Ze385oOxvhIwS5Wur7TACNlSkQxef/WQjFxDfmsNf9TVe94YPom
         +MYOfaDyCA1SQWTQk8PELkWSTRvCSzOhX6gIrGT/Cf3gQQHs2W+FLaeJjB/ZDwQ2qHIr
         cBWdYMacY93jyftnAkPIADK2aMxnDUZO7KEfMJiNGEWdRcs1t2oUPad+blfHtJ3j7ENx
         wLv+vIOdF83MEEOJ0zwtXLlOt8ITSutINfUuQRW8t5ByiArXhzH6ZS9fQAIxByVz2nl4
         Ti5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECI+PzCj+E54+WpHWzgMmg74ln8b0Tr68JRWC1+n9Sc=;
        b=DQ8EgIDATR8B4hpYaSrAXsk8aXziIMPw8D/8ICj17b9XysaBXUHwX0wS4hVNjC6Jam
         e709M2U8nf9X0ntmCOCj7341rgzYfursNnGaHKiLKyBWTdfIOSkycUX8cBjuXdz27fYj
         4bimiDAAnGPlWNSNA7/Ibe0MmAV+CGZiCz0iU65e1PcsWFFWrs/zXc0pnKTQeTewFCYC
         xqqe/BxyCsZNKHqEDqjYaWG4q0xRWU3GaW7KyKoavQF2RZn4vllxNdMOK+moq9mClyCa
         F7zSknI6sSFY391HN8G+vBWsdl9GdS1EdLxgZMNwWIAzGLtgVnq90dgNTTLfCjf5Kic0
         Nr4Q==
X-Gm-Message-State: AO0yUKVxMlM1CN+nrl2bvXpo5+fh2z8ID3iYU9NNRn4VvLgPVvNfq+U6
        uWxs9dOqv44KUn9pnyZXX5ByspiKQjwGynW5Yffh1g==
X-Google-Smtp-Source: AK7set9bAX5I5Ps+szZERO0BYb7ipUxT01xY2LVEv7SjrSspE1s9Id4U/RpR/vT2uE+hL55jZuATpYmAQJK5c8AqcuU=
X-Received: by 2002:a67:d98a:0:b0:3ea:3ea0:8956 with SMTP id
 u10-20020a67d98a000000b003ea3ea08956mr757219vsj.5.1675786573226; Tue, 07 Feb
 2023 08:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
In-Reply-To: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Feb 2023 08:16:01 -0800
Message-ID: <CABXOdTfDk4JXCk-3OS77S7o0kn-4O276aLeWWrQJaiSMnOUcOg@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: Remove GOOGLE_COREBOOT_TABLE_ACPI/OF
 Kconfig entries
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julius Werner <jwerner@chromium.org>,
        David Gow <davidgow@google.com>,
        Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Feb 7, 2023 at 8:12 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Ever since commit a28aad66da8b ("firmware: coreboot: Collapse platform
> drivers into bus core") the Kconfig entries GOOGLE_COREBOOT_TABLE_OF
> and GOOGLE_COREBOOT_TABLE_ACPI have been dead. They have no "help"
> text and thus aren't user choosable. They also aren't "select"ed by
> anything. They also control the compilation of no code.
>
> Let's remove them.
>
> Fixes: a28aad66da8b ("firmware: coreboot: Collapse platform drivers into bus core")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/firmware/google/Kconfig | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index 9f190eab43ed..1bc7cbf2f65d 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -44,14 +44,6 @@ config GOOGLE_COREBOOT_TABLE
>           device tree node /firmware/coreboot.
>           If unsure say N.
>
> -config GOOGLE_COREBOOT_TABLE_ACPI
> -       tristate
> -       select GOOGLE_COREBOOT_TABLE
> -
> -config GOOGLE_COREBOOT_TABLE_OF
> -       tristate
> -       select GOOGLE_COREBOOT_TABLE
> -
>  config GOOGLE_MEMCONSOLE
>         tristate
>         depends on GOOGLE_MEMCONSOLE_X86_LEGACY || GOOGLE_MEMCONSOLE_COREBOOT
> --
> 2.39.1.519.gcb327c4b5f-goog
>
