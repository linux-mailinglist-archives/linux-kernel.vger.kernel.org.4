Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18983632372
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKUN3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKUN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:28:54 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA91FCFD;
        Mon, 21 Nov 2022 05:28:53 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z17so7933413qki.11;
        Mon, 21 Nov 2022 05:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7SLOSEmo3c/autUam2NMSke0Dg2eHn3/Wx3yXtrjEQ=;
        b=YyAsJz2BOFyuEjOkVhDBgTXg77QVJWbBfpISHtBRg9vGfgCmpStkNzRWOxFgSQ7S2P
         1K51hlzjU5zMihi5cWdm59tzhU0Cu5ANWsWJLVye10EqciN7wGU+M2NRXOAFeTFcAO/7
         KfI07OnPEEWd9UQM581YCtOJj7fMCos6HDFluFCi7Oqfbzqt0LusAGqHIAVELijOSMpg
         x8ppcAB2Ty2sYtREDltwm+Ki7Ix22aBK8D3ZHIAzUqri0ofu8PVEesifheusuU8M/Tft
         MuVay5MR+Wj3ve8MVSntb+7dIFkgHiFaO7mhAgiRlhJynOc9MiHt4o2JzwCm0RhtteFL
         s73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7SLOSEmo3c/autUam2NMSke0Dg2eHn3/Wx3yXtrjEQ=;
        b=kOCM40HBzW2Comb6YJr5Wt37JrR8+8yrFs5ONtojpdlXivoKVpeKcuXJHg1a+rRTL2
         yjIgJ4PBXe5RplTDsabFrRBTYD5KcbzIvedKuvocsY9ePOc7jiltzvLNbVIAWB27lXWJ
         BeSFueyitiI8LwmePAszBxBfivg1pSEO8nO1IgUUezbfcTFGAuNLJR/rbAfzGXyflpRI
         ZRfI+s12LMhoYUq9eNXztCatp43Y1b8+MTNwcDB6iUAll3Tv4f8LbrmwCp/O3bBkm9NI
         WJigO+PLKl9F3Qov4tUCoDvloB5qFOsWynzkQjSz8+ADKMBZkY9uHRPxdyovmZayoo++
         wtvg==
X-Gm-Message-State: ANoB5pnwJB9TfffsGD3hF2bydEtZu64QjJLnhkGHH7ilKj1Wxe6ivfh9
        MaZsTtXJd7Kec+R2y3bRSADzZbuVwgV3zq5u69k=
X-Google-Smtp-Source: AA0mqf7bai9IT3izMsbtAYwTLXg//4UesAvpCpijl0TJGAWmZfKrvnq16aIoHrqeyhOvkPpIqqmi1GJplPcb/AXdUpk=
X-Received: by 2002:a37:b404:0:b0:6fa:4a82:1152 with SMTP id
 d4-20020a37b404000000b006fa4a821152mr16720179qkf.504.1669037332239; Mon, 21
 Nov 2022 05:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20221121123833.164614-1-mmkurbanov@sberdevices.ru> <20221121123833.164614-2-mmkurbanov@sberdevices.ru>
In-Reply-To: <20221121123833.164614-2-mmkurbanov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Nov 2022 15:28:16 +0200
Message-ID: <CAHp75VeUDnkjnssO4pjJ5TKw63=YgjqtAruunKA4FiLaHNX1Jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] leds: trigger: pattern: minor code style changes
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel@sberdevices.ru
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

On Mon, Nov 21, 2022 at 2:39 PM Martin Kurbanov
<mmkurbanov@sberdevices.ru> wrote:
>
> This patch adds some minor code style changes:
>     - remove a blank line before DEVICE_ATTR_RW declarations
>     - convert sysfs scnprintf() to sysfs_emit()/sysfs_emit_at()
>     - use module_led_trigger instead of pattern_trig_init/exit
>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>

...

> +               count += sysfs_emit_at(buf, count,
> +                                      "%d %u ",

With this getting shorter you may put these to one line.

> +                                      data->patterns[i].brightness,
> +                                      data->patterns[i].delta_t);

...

> -static int __init pattern_trig_init(void)
> -{
> -       return led_trigger_register(&pattern_led_trigger);
> -}
> -
> -static void __exit pattern_trig_exit(void)
> -{
> -       led_trigger_unregister(&pattern_led_trigger);
> -}
> -
> -module_init(pattern_trig_init);
> -module_exit(pattern_trig_exit);
> +module_led_trigger(pattern_led_trigger);

This should be a separate patch.

...

Otherwise this looks good to me.

-- 
With Best Regards,
Andy Shevchenko
