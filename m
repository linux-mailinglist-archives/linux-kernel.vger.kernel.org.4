Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2420B62EFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbiKRIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbiKRIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:44:32 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED64B6E55C;
        Fri, 18 Nov 2022 00:44:31 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id 128so4045056vsz.12;
        Fri, 18 Nov 2022 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MVeahOj3E/f6xo0VqbPul6zdCrv5MqdlvkN5Rm5HyFw=;
        b=f6Lt0TF5HSnqaK3wPtGnF2CHDWliyWh88gc/0NzFyZHTgMTFZKZWOxBwJd2TqAMCj3
         RBTqwPZyOjWDE8Cka2nUQDwc+ctPLd1sA7/MTy51TYscOFJEnVxer/gg9o6pfWa2yUGi
         xARo9n4nVsZA+3TlosovHRjIuNZuKAuFdjHREOsmVjx1g8ql4ruei8UDjbV1JrZwnmEx
         Gsb6jKNMJ5cJagnxxpjPMPry8SGMCoJe7ecb41zLGuSNNWI2BhGP/PQl4vqclj5tK2Bp
         zClNkdk1taSt6ePSBsFgS7n6flza9Djt57+3EUpBVBTcZ1pca8zWGCmJBitCzjjEhnZU
         Kfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVeahOj3E/f6xo0VqbPul6zdCrv5MqdlvkN5Rm5HyFw=;
        b=PVFi/CDF2zO6B31kBDXUW2fIh0a7SOrz7hP/0RmJ1iKQO0c4fukZ6T/aHDlzbS0RLa
         TOXE8i3gUvXMzkYY2O1laMvTP50tl0YOTY0AUsxXuG7wm+LO/BztOw9srBN0I/SnaibS
         jko0CymzopT5kEodUnNFlRaug0gahBKkgEcPhFUkBjJ+GsDJH4w7P61c0CAGbKSlQXRA
         F1SK3z9sGtyfIp3MN8oha1gkZ2H58V4biQeKWDLtG5JtQ5oqx93aDOrC5xIYovcMLRXV
         kzQ3nV2aIJkvvU8mKsDSK1w83yk65QcgeNDWCcIq/94OSzM9vIGWsfdrG3FaIOOTXD6p
         aLWg==
X-Gm-Message-State: ANoB5plLXInXdKnBk9Gln/6tGKO+M+tsY6QMKFDAxJ+oqZNg4p2QhBKJ
        0B+8AurN6kgTZHeeEIIt+6Z4o0SIRr2Bnv60Qsg=
X-Google-Smtp-Source: AA0mqf6Kf3a0YN7nTcz2C8GjBEO56NqmXz2f9yh0tM1ysJC9R5SRqeEcrqlmaOjC1wWHEf1K2lbVkNgxflacIjeWzGA=
X-Received: by 2002:a05:6102:a36:b0:3ac:1e22:15ae with SMTP id
 22-20020a0561020a3600b003ac1e2215aemr3898855vsb.72.1668761070970; Fri, 18 Nov
 2022 00:44:30 -0800 (PST)
MIME-Version: 1.0
References: <2829949.vuYhMxLoTh@cwmtaff>
In-Reply-To: <2829949.vuYhMxLoTh@cwmtaff>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 18 Nov 2022 09:44:20 +0100
Message-ID: <CAB95QAQRx3RhW-cwLe1HRW5m8Xak_aP=o1Uk8iicQYvd_03z_A@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add definitions for ROG ZENITH
 II EXTREME ALPHA
To:     Matthew Dawson <matthew@mjdsystems.ca>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
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

Hi Matthew,
On Fri, 18 Nov 2022 at 05:55, Matthew Dawson <matthew@mjdsystems.ca> wrote:
>
> Add support for the Zenith II Extreme Alpha.  It is basically the same
> board as the Zenith II Extreme, and has a similar sensor suite.  The
> DSDT is basically the same except for some address, so use the same
> board information as the non-Alpha board.

Thank you for the patch! I'd like to keep copies of the DSDT for all
the supported boards. Could you, please, send it to me directly or
share at https://github.com/zeule/asus-ec-sensors ?

>
> Signed-off-by: Matthew Dawson <matthew@mjdsystems.ca>
> ---
>  drivers/hwmon/asus-ec-sensors.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 81e688975c6a..ac0459be04c7 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -466,6 +466,8 @@ static const struct dmi_system_id dmi_table[] = {
>                                         &board_info_strix_z690_a_gaming_wifi_d4),
>         DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
>                                         &board_info_zenith_ii_extreme),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",

The board name needs to be added to the list in
Documentation/hwmon/asus_ec_sensors.rst.

> +                                       &board_info_zenith_ii_extreme),
>         {},
>  };

Kind regards,
Eugene
