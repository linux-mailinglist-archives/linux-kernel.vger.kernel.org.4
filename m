Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650F467E730
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjA0N52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjA0N5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:57:21 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D177D280
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:57:14 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id v127so5321065vsb.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBVrZ7Q7DuNnewLFiNGoE0LN1qG/UCTMSF+G5Ptq+ww=;
        b=yo2NyAzopyQOqEyD3V618wzEbXXfwsqh1KP612mKC0X9ymcSpySO9oMm4SxzXIM5jn
         izCH0yMcnEbHjwe3WRNF8WZhXPLFy7AVNFTWe5yQ6LQBJ1IIGxidXUH0geRZOW6JQ5AL
         hI97H6gJ3891HIq41W6KTxBl63E5Nzb99Hg3IyBTxK3b1A+kHSC4pnC6CuN2O1nwtLTX
         RNL8cq6ZTV8NHjJ7Bkh1kG+yQ929FoK3oH/h9UzkQsldc9cQ+UUTBgD035UPIwdiOtJD
         oL8ThH/MWRnPjkC+so1efkV7/UiL6kh5wwqObBumC23p6DrkhBo3U/Ry1G/BX1C6P336
         GICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBVrZ7Q7DuNnewLFiNGoE0LN1qG/UCTMSF+G5Ptq+ww=;
        b=YhrV9X4eUjHLlNT19jJqewSpai92HWoCGp0++zgexxjEirHQ+fR8+O8RFp9LKyIrLg
         pj1kM+QPrY8OoqiCrEY0ftHk2S+7l87i2vD1qbUUPoKdvB4HjklGoLSTDgW+0geMAr2r
         mwx6oQAmM2B+ADxq6LkTXeTCWm32NnG47SRfCDFz02sCsbSdtT9z3tItyXguIWBjBHMS
         ikIuC4I5vRgS7h+8GekXYAwLcyxyFD1iUvfKX8kgNHPMzr5rX8njUZVPuaH6IAhBmF9x
         tBQeHlSVzx8jlkp4ShloXt1M/MxsfyZV9rPcScYrQGCY4sx8BHJ5GA7l+7P5pM+TMPxM
         m+HA==
X-Gm-Message-State: AO0yUKUHqP/DiUeYJq5uwAhrwDqGAn7a7GZfUJYO21VwU6zH22W/Gj8G
        etYigGsZugk5pYPsCrLIMJVoU4KGBeSBIWnLmHDkhg==
X-Google-Smtp-Source: AK7set9mj1CJJHr+TTwT8hSRz9OOunsPEMFmRYh2hPArPnZjpXqYuN0JoPloLw5xuqk8PKO0C2hnel7PBRWLT/5ektg=
X-Received: by 2002:a67:5e43:0:b0:3f0:5f85:e86f with SMTP id
 s64-20020a675e43000000b003f05f85e86fmr83634vsb.17.1674827833818; Fri, 27 Jan
 2023 05:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20230127101149.3475929-1-arnd@kernel.org> <Y9O1oA2KKUUvOcnP@smile.fi.intel.com>
In-Reply-To: <Y9O1oA2KKUUvOcnP@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 27 Jan 2023 14:57:02 +0100
Message-ID: <CAMRc=Mc+kqfqOWdNnAV4u=MotoSan0obxakhua78CW=TL=9i8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] gpiolib cleanups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jan 27, 2023 at 11:11:42AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These are some older patches I did last year, rebased to linux-next-20230127.
> >
> > The main goal is to remove some of the legacy bits of the gpiolib
> > interfaces, where the corner cases are easily avoided or replaced
> > with gpio descriptor based interfaces.
>
> Thank you!
>
> I guess we may go with this via GPIO tree.
>

Arnd: are you fine with that? There are lots of changes from many
different architectures after all.

Bart
