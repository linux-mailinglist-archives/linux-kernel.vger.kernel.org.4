Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4E6F587F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjECNCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjECNCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:02:02 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7121BEB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:01:59 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-77d049b9040so3331803241.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1683118919; x=1685710919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BozmJEISZG8VpIGq5e9BO+B4B1xoIZSJv2J5QCTb/TI=;
        b=QJB01erZq4Dl9kb2aaAgTlatKObfffx2TkkUpx6KcRHBIG1MImlxfZX01s0x21O8I6
         jerF940TXB7lQsK1cNi8HQwJvIMecyQjyJqV6htQL/o6eS6hUmjF+jqFvJAe+i5TFU2p
         uVQFIa0nPVE9u0tJYu4h0xes82wfu0g1L5HyManuIUGsh540aWDme10lUkSMSKEnc7Qh
         J4t+m3o9hlI5l3UhpdXjeLE5mIjvjZzSZzdIaq4NSDuitZYyUtKkjggOZBDjfcOKzdm2
         4BgmBOYfG0pcELHPZk3a9KLtAd7xj+512PQQsnmCxiNy+8Rtw1p9hknnSqW+GavC6mBX
         hC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118919; x=1685710919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BozmJEISZG8VpIGq5e9BO+B4B1xoIZSJv2J5QCTb/TI=;
        b=WB35X/ay3/l01dbMCX5oIitVUSgE2G1FZy35zY7/QNKFEBJVGTOK+WrJ/NHGPWc3r9
         MNx2FKt82qj/gs8WrwziTE9whNHLT01TPR4mohTyUUKxyx5wdcdXlufnlKmdgavcBTUO
         VhO+MdD3pwCdUjlHQPXPPkToU4aY4LPoEdHnyKOBboT/Cn9ZjfC3gdfgN6WaHKBYrTNI
         tg5h/I1Fno8AKGuzNkKz9vQOLf7b+WImaKfwkxVK3Aqok+7uS2f4xQSS2OA+XBxYkJw4
         Ypx+1Q6So5qVWuk8CLoCPCxrwAVQ1+dd3rw33zVay6RY24m6QQc+rKlA88ZdUxK8XQcN
         3r0A==
X-Gm-Message-State: AC+VfDwBn99AtjLZLJQIBa5cd9XQ7bdldsTh7aw5kV+Iogq8fU5+wWFM
        mZruEj/UlZkZxC9zA753xKtB44vgJMx2owutaiVGoHVcCQ8+BZAbARE=
X-Google-Smtp-Source: ACHHUZ5LN+eYNk66xWzeUOrIQ44drhXJBGqRDqWgma5Pqn9ZPSaIvNOiJD2JNY1TU6z/w7ISvI3So0l4DdgBV/7QihQ=
X-Received: by 2002:a05:6102:ecb:b0:434:4737:9760 with SMTP id
 m11-20020a0561020ecb00b0043447379760mr608005vst.16.1683118917498; Wed, 03 May
 2023 06:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-omap2-pdata-quirks-v1-0-e015f3a3ea46@linaro.org> <20230430-omap2-pdata-quirks-v1-1-e015f3a3ea46@linaro.org>
In-Reply-To: <20230430-omap2-pdata-quirks-v1-1-e015f3a3ea46@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 3 May 2023 15:01:46 +0200
Message-ID: <CAMRc=MczGKVFo+iWe_Pnvi3-hCK0fhmmkjp-h92RHONEHFAP_g@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM/gpio: Push OMAP2 quirk down into TWL4030 driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Lee Jones <lee@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 1, 2023 at 11:05=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> The TWL4030 GPIO driver has a custom platform data .set_up()
> callback to call back into the platform and do misc stuff such
> as hog and export a GPIO for WLAN PWR on a specific OMAP3 board.
>
> Avoid all the kludgery in the platform data and the boardfile
> and just put the quirks right into the driver. Make it
> conditional on OMAP3.
>
> I think the exported GPIO is used by some kind of userspace
> so ordinary DTS hogs will probably not work.
>

While I haven't tested it (nor can I) so don't take my word for it, it
looks to me as if regular DTS hogs *should* work. If anything, the way
this quirk is implemented in your patch moves the export past the chip
registration, while ordinary hogs would be applied when the chip is
first added.

Am I missing something?

Bart

[snip]
