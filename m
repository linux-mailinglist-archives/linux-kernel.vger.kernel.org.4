Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B4166462E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjAJQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbjAJQd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:33:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B195C8B50A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:33:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so12379068wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ym/eJ5fz8Y4p1LUjtTeaH5cHFxFkmqxEFY4SImHkXcU=;
        b=rHL3utTJrZKGfZS+Yh+XnSQKpAJIVH7PQybEto1200q/cWSFzzpdsJA5VCNd5jWfPd
         Z2LmF0vMgQMrPmsPt2hohdQdShqMHZsM2alOgbrmFbTu4nv3rQWGIVVe6Fo9e5lf7f4g
         uwHWsIKCMX/rvnWo6aNDDbXoV/2TJ7Djq+PCaoGoyQNRbZX3NBtOtCi6wWj74Vg3LwpC
         vif4+KykyMKfc7BW1KuKpmKSnsrrcjYKjaoLED9kcYZ8Vx1TnCWx0yGW1u2a2NL3X43L
         fuqnmd3+cGc2r7cghg/nheSVcuBiU7+VMe8zV7LUNvd7l7kFEYPt9jFYAsdfVTmJYmrz
         d8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ym/eJ5fz8Y4p1LUjtTeaH5cHFxFkmqxEFY4SImHkXcU=;
        b=aFyyBBfpKX81AnoJfO0Vuh940Nt9iYceEhEugQOD9zwogg6o9zs4Es4d/fgTFCZ/9t
         hmKgTAqFDzshUHsZQpsUbPC/mVDVCCU8yiJPYCFmkxsc0frD/otjGTh7eiaQXNm7bQ5r
         0BffGnZbluHeV+lNkxOU5yzOincSU88l5PKg8RYgERaEvwsZ66TwGvYGIg+7Wdsec6BE
         AiXc0ag4L2ps3ZT+k9stN9+hly57nGg1Rp4e2Z9Yr3FFO1SV6etRGZ6Qv3859PCgiqgy
         dbwQku2It6SinqrjgOcova5oya4yH323et/nQF7xj3RBE1RfvScc4EsHB4qux628qByq
         epqw==
X-Gm-Message-State: AFqh2krSDbqfoan2LzObqOJIeyA005C7Y/P87Dhl6KGr/k3OU96aNCo1
        pKG57DiDWhia8ZqDffPIyq+BRA==
X-Google-Smtp-Source: AMrXdXtrx3/IptYlgrqDn6WDHI4/OcQNOgoMg0mpPzFL//dT9ibsQKHPGHOgfIQl0PSEJI2Rjj3YEA==
X-Received: by 2002:a5d:6e0a:0:b0:242:10ac:ac42 with SMTP id h10-20020a5d6e0a000000b0024210acac42mr43977833wrz.55.1673368390734;
        Tue, 10 Jan 2023 08:33:10 -0800 (PST)
Received: from localhost ([2a01:cb19:85e6:1900:2bf7:7388:731d:c4e1])
        by smtp.gmail.com with ESMTPSA id j14-20020adff00e000000b0024cb961b6aesm11492743wro.104.2023.01.10.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:33:10 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, hdegoede@redhat.com,
        wse@tuxedocomputers.com, chenhuacai@kernel.org, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add Clevo PCX0DX to i8042 quirk table
In-Reply-To: <20230110134524.553620-1-wse@tuxedocomputers.com>
References: <20230110134524.553620-1-wse@tuxedocomputers.com>
Date:   Tue, 10 Jan 2023 17:32:55 +0100
Message-ID: <87zgaq73k8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 14:45, Werner Sembach <wse@tuxedocomputers.com> wrote:

> The Clevo PCX0DX/TUXEDO XP1511, need quirks for the keyboard to not be
> occasionally unresponsive after resume.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/serio/i8042-acpipnpio.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index 46f8a694291ed..efc61736099b9 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -1238,6 +1238,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
>  					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "PCX0DX"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> -- 
> 2.34.1
