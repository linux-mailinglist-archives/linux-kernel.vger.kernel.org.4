Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86363FD1E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiLBAcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiLBAcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:32:23 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E784B0D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:30:09 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id u10so2502276qvp.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XtB7qSqiIzlg8ss9ldhy5DqRNqK+3OXWrV3JxhE5L/Q=;
        b=NShPh6Ldo6cB9Y7/znInI3jzj6Ptq2/otJBs0262+9AWk8MYfYjMQfa2K6i2/34orr
         GmzzjpcDdTZBw+e1rAyA/G21UiefhbIN1Byy436S0o1TpcmSx5QNtNJyWwMADtjJfSnO
         aakdUkAsRdnbvcyg0/DM198QVoHyC4d1KEEUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtB7qSqiIzlg8ss9ldhy5DqRNqK+3OXWrV3JxhE5L/Q=;
        b=OLy1/ZZHXr6I0LxOQ2c4207Ijp6pcGBm3WLrM9B2P6XIGL0tTGQtHoJ8a/1wftlONB
         AlZkF27PsqGoF2ZbQ9HEgWeEmDo2ETy51VhcFR12TU56QvfFcQwl75XgjxHojPzDByab
         Z2QQrNrTnOWJAE4LlezqPORy6cTPKckpmh3tXaW/DvZcGoX6alL4FUTwwicDKxvAGaTs
         q/OKpyDtCUDM2Jajr+HtJnpPemji5imaXPKXeQapPtISu8SaNqT1SstVDuup6OKl3QUP
         8yjFB07yaiw2YA2kH0CkTPapGz4nDsKY5q/rrV6/cAuJOO0ionK1Sg5YYI7WudV2QvDH
         uPSg==
X-Gm-Message-State: ANoB5pn3oE1MGeIxkAreq13Gs8YCe0vawlptBVEO2LDt6AXjOoZW1qo4
        Oe/KPwOu3viKpXtXKwBWf3AW9H+D1VYQF3PfUPpvDw==
X-Google-Smtp-Source: AA0mqf6pXA5paunfIyUQM4dR0nhu88sVVy/J9X/OwrIZwSH+1q9zgBsefaDBHJtmmDWMiwBxjk4He6NieG7Y4WhlN/Y=
X-Received: by 2002:ad4:4c03:0:b0:4bc:182e:78c2 with SMTP id
 bz3-20020ad44c03000000b004bc182e78c2mr44392547qvb.2.1669941008652; Thu, 01
 Dec 2022 16:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20221130231936.1666390-1-wonchung@google.com> <CACeCKad16bs_f6bLthTAoEL28tPvf1S10WDeM7ugeaS9g7R25w@mail.gmail.com>
 <CANLzEksD=dKgPuCUD74b3YQKCApbZKO_t7Q=tyNKONvAOQ89hw@mail.gmail.com>
 <CACeCKad7RGVPGdrd9WNpRhn3n99R5TG9zFJpCrMj7CDLK18rMA@mail.gmail.com> <CAOvb9ygJ9afqLaeJRuCK+zFMH2vxjA4JGXAu2qZUvqqyUzhnmQ@mail.gmail.com>
In-Reply-To: <CAOvb9ygJ9afqLaeJRuCK+zFMH2vxjA4JGXAu2qZUvqqyUzhnmQ@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 1 Dec 2022 16:29:57 -0800
Message-ID: <CACeCKae3SGt9ihq-B2s6V2HiiHU+dSL6pRaxY15aaLoJUNQYmg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Create new USB driver for RGB keyboard
 in ChromeOS devices
To:     Won Chung <wonchung@google.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 2:52 PM Won Chung <wonchung@google.com> wrote:
>
> On Thu, Dec 1, 2022 at 1:36 PM Prashant Malani <pmalani@chromium.org> wrote:
> > >
> > > We're seeing some behavior where a bound driver is needed in order for
> > > this USB device to properly enter suspend state. Just manipulating the
> > > power/control and other sysfs nodes for this usb device when there's
> > > no driver in the kernel doesn't seem to affect the device's ability to
> > > drop into a usb low power state.
> >
> > That seems like an issue with the device then, which should be debugged
> > from the device side and/or its interaction with the USB subsystem.
> >
>
> Hi Prashant,
>
> As Benson mentioned, I can check on my test Vell device that changing
> power/control does not suspend the device.
> Should it be controllable even without a driver bound?

Um, it should be(?); usb_enable_autosuspend() [1] and `echo auto >
power/control` [2]
both seem to call the same runtime PM function. I've not looked into
runtime PM code
deeper than that, but it may be worthwhile to examine what's causing the suspend
to get blocked.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/usb/core/driver.c#L1637
[2] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/sysfs.c#L113
