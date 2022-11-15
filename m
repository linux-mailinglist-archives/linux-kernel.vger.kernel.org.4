Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26275629DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiKOPlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbiKOPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:41:17 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970902C659;
        Tue, 15 Nov 2022 07:41:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so37053267ejc.4;
        Tue, 15 Nov 2022 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uHMRqOt47L6ujRv/jyT4aFt+Qk8f0ZhiaQpy1RyL+lg=;
        b=L96/5GX0Q2toIyrXZ12bwo7+frDpMical49EPMLddUG6R3/s22JBgdEFELezo4kDoZ
         gPVcvlVu0jEIpggfS2BxKdp1dE6zmW3kYx4PAOqoYihozXpdusuiY3kL3/yGTo8TjGob
         ZRDXIMpOxUjvAl0rRCbjY+79HMzUsrrfUw/TFrTBtY0+VOikYn5A2HNMPEu/tKv+9pC+
         NxREFuwaH+D2ZfxF1HlohAlBhbEg8Yp7xoEDbUYGfTuG/iokEuIPjrv0oYpIsO6h6IzI
         KpN7BFAbGJZyhAlLPZUI1p1YkGrF33NtSCf0OXZzEj51LEWR3hY4oarRoDvUa7OyBASB
         kryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHMRqOt47L6ujRv/jyT4aFt+Qk8f0ZhiaQpy1RyL+lg=;
        b=goZB3GSfYUj1JDqAsd4RQ5QGxJQh8Cr8c9acjYa64M3Hlp2jEvpsxQzC6lxmazizhw
         6PAxTfLHuDFPRaJVIDDZ7Tyfk50G8bVd0tcmZ+F0XWiUEgdLuqbSVGMFqmzN8jjVedXA
         /AoRB2mYB5XIpD7teFlrgevrw0Rvko1HHOyTkVgJm0iRHtRa+sX32Le0f3h8EAMbzSda
         faXnO0m76QK7twWmfjIL7bCCZ8aiX+iYuI4KYcG0ZZs8oRmvsAOCxW98YsKl/JHLhiZQ
         sIfEVWOkW/PIeRM6WrqOpobZw4a1nw6exSQf2+1AKBZis050qW2rldCThRz8fxYp9hWc
         QIqQ==
X-Gm-Message-State: ANoB5pmlpgQU90b24sdPgTwYnTb9O8JvItD/05aG+VVzB8DKAo3CyXGv
        ji+cU7H8wtIodwURy+wyjXBoa2GBXKxR4Hi868Q=
X-Google-Smtp-Source: AA0mqf4umbT2P2RED6nkHbHeJSlf8XXdjmexdOZALAq2vLOfi1l6MaZUAQDb70ZBL+8+6yg/PvG4v9uWUaw5gdWb9Rc=
X-Received: by 2002:a17:906:e24d:b0:7ad:934f:abc2 with SMTP id
 gq13-20020a170906e24d00b007ad934fabc2mr13216386ejb.690.1668526875049; Tue, 15
 Nov 2022 07:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20221115053920.65318-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20221115053920.65318-1-jiapeng.chong@linux.alibaba.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Tue, 15 Nov 2022 07:41:02 -0800
Message-ID: <CAEc3jaBVw40YU9DTFY0nr_bqBSHdvbqFZBgyXwTGKLOQkuzxEw@mail.gmail.com>
Subject: Re: [PATCH] HID: playstation: remove unreachable code
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     roderick.colenbrander@sony.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
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

On Mon, Nov 14, 2022 at 9:40 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The function dualshock4_get_calibration_data cannot execute hid_err,
> delete the invalid code.
>
> drivers/hid/hid-playstation.c:1766 dualshock4_get_calibration_data() warn: ignoring unreachable code.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3073
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/hid/hid-playstation.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index bae3e712a562..a4106f760d1f 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -1763,8 +1763,6 @@ static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
>                                         ret = -EILSEQ;
>                                         goto err_free;
>                                 }
> -                               hid_err(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
> -                               goto err_free;
>                         } else {
>                                 break;
>                         }
> --
> 2.20.1.7.g153144c
>

Thanks for pointing this out. The error message is actually needed and
should be moved either in the else statement or we just take the else
statement.

Thanks,
Roderick
