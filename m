Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4C621122
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiKHMmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiKHMms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:42:48 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6050F36
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:42:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l11so22275314edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NAwkd5gvafBd9aj3NDsmPd7fQCXQtLGmi5pO3EUXBs=;
        b=eEG90ipC8yImPAY3uFD8QLSUoEXgAoFv6K64zitJ8kXVIrIgC6p1DWoWSiXZwHsN4L
         3dq1PuI+nuTyhq4v7byubmLh2P9/WixKct1VKlitOiryyDcIUUUBTtoazFf/m3Go+CjR
         4cGAyhkanz+alVEidSSPNzWLyGiagwm8ywpjZQLI4uM0KqsqSENxHFqk3zXeQpzAmhbn
         MNfmsCdmX6JsWJFjPYV3X68XjKlu2nnZM2xDyYDzjx2MEiDMJjcAHRicUyZe2DxeYjNb
         K5IjjDvS32KrnkY63tSQGpk2lGrSdu6kgAbXXWIU5iQeNIvMFkV8eTO9tozBWWX+wTld
         6meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NAwkd5gvafBd9aj3NDsmPd7fQCXQtLGmi5pO3EUXBs=;
        b=YxuuzVBXMiozD9GU4cSUbex0vcn6I/tTqKBKwEAkx89pL0Ao5MNzohEpct8WTHKrLR
         xFy24XyfOKpTevVoe4b72LejvS8aMeZ/CJjIkemIaR2nlsvT7C4OqYX/8pvOywjAUv/i
         5zRWknZs2OnnBhMXHTq9uoOURfp5g6LXc/4ofENrAQ133anbKLzUuVcI3+gVZrJdM/az
         B6pIRnUBCohTKPy2PEzSd1C8EN3/toSpmlLBQ4wSwPIo40JZgoGgXfJgXjmB/H4s/lVY
         2fT+Nq6N4XjFwCMpQ5cckJNXr2zY+a+hBd+sKY3pt7RKUnwBE6Sn9Zoxn/Fpo0XrMhCW
         jVKQ==
X-Gm-Message-State: ACrzQf1FA6HIdO2GXy0Ih3OT2ejJnEGkTySBOjQmUjJR/LmH1YWMuALL
        6yskrTBhtqJnHFNSzqXtGyPrHW1WQQkaOtJuD3nWVA==
X-Google-Smtp-Source: AMsMyM4X463PCUWbCEJ9/WMIHfY6oheXBJQ6mxshnNqJwtlvyN0tlU11yHLyFhWP5bFEE6kg2MWl76/sJjnM1TB+FC4=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr55679890edb.46.1667911365383; Tue, 08
 Nov 2022 04:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20220818172528.23062-1-pali@kernel.org> <20220818172528.23062-2-pali@kernel.org>
 <CACRpkdYWQVW_akJS7hvtU2=c063LCMfjN22X-neTfuTZRbt+yw@mail.gmail.com>
 <20220831114936.vukjsovdxw3cmj6h@pali> <20221009114043.6rdgpgzkngd527o7@pali> <20221101223255.rhzerarzld45xfjh@pali>
In-Reply-To: <20221101223255.rhzerarzld45xfjh@pali>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:42:34 +0100
Message-ID: <CACRpkdad6WDo7rGfa4MW8zz0mLXmcPHo+SEC-yLQnRz_kdrryA@mail.gmail.com>
Subject: Re: [PATCH 2/2] leds: syscon: Implement support for active-low property
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 11:33 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Sunday 09 October 2022 13:40:43 Pali Roh=C3=A1r wrote:
> > On Wednesday 31 August 2022 13:49:36 Pali Roh=C3=A1r wrote:
> > > On Friday 26 August 2022 10:05:26 Linus Walleij wrote:
> > > > On Thu, Aug 18, 2022 at 7:25 PM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
> > > >
> > > > > This new active-low property specify that LED has inverted logic
> > > > > (0 - enable LED, 1 - disable LED).
> > > > >
> > > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > >
> > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > >
> > > > Yours,
> > > > Linus Walleij
> > >
> > > Is something else needed for this patch series?
> >
> > PING?
>
> PING?

If the LED subsystem isn't working consider sending the patch to the
SoC tree with a notice that they apply it instead and why.

Yours,
Linus Walleij
