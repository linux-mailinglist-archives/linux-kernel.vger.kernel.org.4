Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0691F5FADCD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJKHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJKHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:51:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83785C977;
        Tue, 11 Oct 2022 00:51:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g27so18919866edf.11;
        Tue, 11 Oct 2022 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rP496A/lcLyx0bTP6cSlzGpGHo4a5gYQwaxd9XF77S0=;
        b=KlM3CIEFeya4zIVJ6N1EQ1LFWrYSsOGkJuKL0TNSTvv/H+GfM/rhr7G9zOu9oKTuVX
         kGpdhTZ0/A0cNCRdFjMPm4rHMAKLNlOIcBeGnmyvipY2pTHzvkXp1BCozLTU1mwEzgbD
         J1ifD6V/2AIu9t0jTUbJmLvhJKHvzX+/wmCJUq4rS6b7dUjjLvT39kmPE1wtn92gKhKJ
         VoTSnOqJashjCsLecc1hscChXB8FVck8HfzwenqgKPTuN+/ffCVUF9+mYDBa0uMmGMAp
         sVr+PhE7FW68jPmVLxQNhNdSd+//N2ARmcsv5rd0jaGVn+9+Vx/bvbSFC4rhZYp/0rNV
         ZUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP496A/lcLyx0bTP6cSlzGpGHo4a5gYQwaxd9XF77S0=;
        b=j4C74kywiZxfSsy+WvlOHlApTAQGmRFn6A+6L2Tn4mOFL6c6KqwQ+iz1Fy9seW55ra
         n19Z3GeQ1dgZAesyBxJWgzw8d0Re0CQBjJmJKjU5gHAL+S+sWq2brAYuo5TLaS+6cIXJ
         VRyradX0rb+OZRATqokDffieFK0ncwwPaBu6PA09kJOoEMJW+7cRwnL1ZZqmZnud0thk
         QEX8fu2Y5zcNXYP5RXPklZP86CFZtTXFIBdg+w8lUwesRgqg8lrlI6z2c9KZqiowl5ov
         Gf7LQuI9SxlUqVVr+Bp5naaezEQ80g7cLQbYcAIiBOTIQf65ItsSyvmNnlvzMPy0dZfm
         ySpg==
X-Gm-Message-State: ACrzQf2YMwrkIh0ofv9szvU1736vuhEAe9+8+ZE8V4MwB52ZHjdxG77J
        ynqWZKchiYY1syzGHoKkD32x9iF7pETBWf393+g=
X-Google-Smtp-Source: AMsMyM4RTY4GEMSNNbYHojdtxPPx7IMXUAC3pzDloniztOZm3sAhStdnkA5ea3lAesMVQ2ZFgV2PDd/huznqrJNBYWk=
X-Received: by 2002:a05:6402:35ca:b0:459:f9c3:cfe7 with SMTP id
 z10-20020a05640235ca00b00459f9c3cfe7mr20810866edc.275.1665474688204; Tue, 11
 Oct 2022 00:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221009230044.10961-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0PBdDtFzcsmbtMv@shikoro> <CA+V-a8sOxyQj8J06kqnRN5G=L6KPdusJ-qLWntVa8kgFBh-MEQ@mail.gmail.com>
 <CAMuHMdXoDmwNnYNt6mVnHNYoNQY5fN207iyR_TopOsux6RKhnA@mail.gmail.com>
In-Reply-To: <CAMuHMdXoDmwNnYNt6mVnHNYoNQY5fN207iyR_TopOsux6RKhnA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 11 Oct 2022 08:51:01 +0100
Message-ID: <CA+V-a8sN6twzEHmMcK9Cnnjciqz0O2tDYEhDVz0QEMCrqHQLNA@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: renesas: rzg2l-smarc-som: Drop enabling WDT2
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Geert,

On Tue, Oct 11, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Oct 10, 2022 at 10:01 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Mon, Oct 10, 2022 at 7:53 AM Wolfram Sang <wsa@kernel.org> wrote:
> > > On Mon, Oct 10, 2022 at 12:00:40AM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> > > > used from CA55 CPU would result in an unexpected behaviour. Hence drop
> > > > enabling WDT2.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >
> > > I'd squash patches 1+2, but that's minor.
> > >
> > OK, I'll wait for Geert before sending a v2.
>
> I'd even squash the whole series into a single patch
> "arm64: dts: renesas: rzg2l: Drop WDT2 node".
>
OK.

> If that would be the only change for v2, I can take care of that while
> applying.
>
Thanks for taking care of it.

Cheers,
Prabhakar
