Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA867C1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjAZAoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAZAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:44:05 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC01BCF;
        Wed, 25 Jan 2023 16:44:04 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-50112511ba7so3814367b3.3;
        Wed, 25 Jan 2023 16:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+VrZKovn/MBBgeTmYZbf+d9DNZS3QsSRkph9bySasTs=;
        b=F6cZhMqtDIn/hkNKN+r1JlIwL3NvVUiq/vT7UKn5+G8bzX5MztiJaLiLlXeGx1x1bu
         EVOKs0f42J46SSyRlqUSlpH12WTYrOEzyCejC2EDPEgl5OznfBRmciRoGfQKN0mgnRr7
         ZdU1Lk4YT4h3rRMNzehqqfuG7c82tD4gUYQQapgcrkrVtPNqLk6V+WsuqmBkO3ovvWk5
         BUuocwsy/L8RWy1nxxgbjpid+8egXaFxEZPpCV8dV2r9QzrsvD22l6bkZjqITDM1YAM1
         pDSvwk4EtJX9WkrU/YwsLtWXcqluRKNiwLAPjaS5zE192ab9YHxhHLTgEuAhU7BA6fnX
         S0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VrZKovn/MBBgeTmYZbf+d9DNZS3QsSRkph9bySasTs=;
        b=KB2TWcVfAgiC1F7IYopMEqJHxOb7dNlhw/DfXygGECggMPtC6A1VDlhzNv3INNcouk
         cxeaL6I1N/TYl+ntP3wCs+SLW5MCH0ywxGXOoyM8lA9bfwxa5z/xXtdz26qsJmWI/3Zk
         RmasusTjIrcUOf4gvWBhWmrHpKFOnV3pN85nLx9FncEFs7QlLx9zl2njCRgIDPu2FQbT
         ppQ8ByE4qWsXKemkSqNRPRc64LBoT2guV+1UdX4VuK+qv0YSUMG3S+dBauTvSKWjaYcv
         d04BfFWbQK+kazSC0udxgvSUf+7fvhcVNaGV1MyMQbm7CvT7fiWHrPG3V4Xj7evEsRLk
         +gCA==
X-Gm-Message-State: AO0yUKWVefp5sMjroI4zR3X059swzj0/vXRWlm4MV8N+vH+EnEsJshNM
        fkc4Z7WlG3NgaUMpvB4w+vU54fNYJvOenlr2L6M=
X-Google-Smtp-Source: AK7set8amJfZLj/tmiwDsRSBvN66k9V14HptqNw6M79Lk2M+w3hYeuz3KKleYhYoBd59g4e7ek0pfuo5+UrRROSms0c=
X-Received: by 2002:a81:4c88:0:b0:506:3d15:738a with SMTP id
 z130-20020a814c88000000b005063d15738amr985723ywa.319.1674693843693; Wed, 25
 Jan 2023 16:44:03 -0800 (PST)
MIME-Version: 1.0
References: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it> <20230125-hid-unregister-leds-v1-3-9a5192dcef16@diag.uniroma1.it>
In-Reply-To: <20230125-hid-unregister-leds-v1-3-9a5192dcef16@diag.uniroma1.it>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Wed, 25 Jan 2023 16:43:52 -0800
Message-ID: <CAEc3jaCEKfqEJSV4=6GRj1Ry97xH+HwVSeEOZReNwkt=rLNvNQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] HID: dualsense_remove: manually unregister leds
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>,
        linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>
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

Hi Pietro,

Thanks for your patch. For sure for ds4/dualsense there have been edge
cases around rumble removal and others. Those were prevented by this
'output_worker_initialized' variable, which is checked during the
centralized work scheduling function (dualshock4_schedule_work /
dualsense_schedule_work). That said I don't mind the change as it
prevents the work scheduling functions to get called unnecessarily.

Thanks,
Roderick Colenbrander

On Wed, Jan 25, 2023 at 4:26 PM Pietro Borrello
<borrello@diag.uniroma1.it> wrote:
>
> Unregister the LED controller before device removal, as
> dualsense_player_led_set_brightness() may schedule output_worker
> after the structure has been freed, causing a use-after-free.
>
> Fixes: 8c0ab553b072 ("HID: playstation: expose DualSense player LEDs through LED class.")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
>  drivers/hid/hid-playstation.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index 27c40894acab..9e23860b7e95 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -1503,11 +1503,15 @@ static void dualsense_remove(struct ps_device *ps_dev)
>  {
>         struct dualsense *ds = container_of(ps_dev, struct dualsense, base);
>         unsigned long flags;
> +       int i;
>
>         spin_lock_irqsave(&ds->base.lock, flags);
>         ds->output_worker_initialized = false;
>         spin_unlock_irqrestore(&ds->base.lock, flags);
>
> +       for (i = 0; i < ARRAY_SIZE(ds->player_leds); i++)
> +               devm_led_classdev_unregister(&ps_dev->hdev->dev, &ds->player_leds[i]);
> +
>         cancel_work_sync(&ds->output_worker);
>  }
>
>
> --
> 2.25.1
