Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4285FA66D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJJUhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJJUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:37:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A519C1D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:36:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s2so17472705edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+IAkaWQMduMUEg/IVhJmoVF73YcOppT9cb4ycyjkC3A=;
        b=W032O2LbfFu2tTrlv2rIUts8WPhTnyvL84pdeEnoxXSpQMJD3GeGT7x1ncktcz5Ha3
         4oTddWAoYYDRL6rFVRRa8vHTt5QPMyUVCanb2Ntssm56+Oi7i8ct+dqa3jlbxywlcKyb
         pIrVgQglKhAk2B2OtPn+vfhBB5f5f555vYDbz2kErMRfcQVe0cmbAxol0dCEbBGQOYLJ
         EytERhLO8wejHo3DOSIyt1QXWx6VpXgyrkDqbCQ7AFTLf7MoH4eEgCjCqZSB3qyfRi5w
         6tR5sLRByB5d1RSjdcyu8hmFKAzI/CwDOqSu0sR+Sh/emlW4aBMKjX8ODe6I0yL7U2cH
         nyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IAkaWQMduMUEg/IVhJmoVF73YcOppT9cb4ycyjkC3A=;
        b=T7FVsP/tzrysUVIlePu44JXwt4llR38Fk7t73lkJ8LOSaX9liQBRIztixLLOiIE3NN
         CR7x25o/qfRqI8FoxQX418DL7+AaKbuL11l9t6R4kZGlu2d8uAZEToFbtmboIKWjfqHv
         NVbl59hWgBJlq27FT0oL6DTU6slaofGv42T7CsujcZ9i+TQB3gDLCMqAGWiFxIIMzkO/
         PwvZ27wOrMfWBn9rDHgeuGkJDKSm2q/2eJByUoNakQYhxbNqFqT8EGewwuU0d9G1jRkp
         z1259behJ6MkRP4XjMIKMn0QnaMESbVklktXlJcibp9fOUjYxPgRje+KLdPlAVo+MPJJ
         iYcw==
X-Gm-Message-State: ACrzQf3RNS27AWAjA5AnD4QPwglfmDHQl5cb/cAWPdRxc7Rd0fEPVX2L
        P4H68r+ccSk7b0TnW1UKiUII1HmfwApQZkkYs01LgQ==
X-Google-Smtp-Source: AMsMyM7zsMEYc1MPREFO6D91C5VC8qUsg6HO6V70YDqdxA6BfuO0DXyze3J2/BpvF/6sW69IkvpqwmFtlOSpBSXMFIA=
X-Received: by 2002:a05:6402:2690:b0:459:e6b2:cae3 with SMTP id
 w16-20020a056402269000b00459e6b2cae3mr19213770edd.158.1665434172329; Mon, 10
 Oct 2022 13:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <YzN6A9Y20Ea1LdEz@google.com> <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
 <YzwtG8CT9sTCqQQk@maple.lan> <CACRpkdZ-DfZKgCOHaKn1UZ8vVwy1dEiFBBDNdxu6VNzrUdeEtA@mail.gmail.com>
 <YzyZJSwy9xsy69WL@google.com> <CACRpkdYecQPUd-evVpOpMLY1XUa87kP4i+E694QfTtDbEarJfQ@mail.gmail.com>
 <Yz6oS/zdNIOEtWxI@maple.lan>
In-Reply-To: <Yz6oS/zdNIOEtWxI@maple.lan>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Oct 2022 22:36:00 +0200
Message-ID: <CACRpkdYdZaxSGy+YiexKtffKvUEr5dcu3g=1zY3Tfhv5WMDtew@mail.gmail.com>
Subject: Re: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 12:05 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On Thu, Oct 06, 2022 at 11:03:15AM +0200, Linus Walleij wrote:
> > On Tue, Oct 4, 2022 at 10:35 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >
> > > > Dmitry, could you fix this? Just patch away in gpiolib-of.c.
> > >
> > > Sure, I'll add a few quirks. I wonder what is the best way to merge
> > > this? I can create a bunch of IBs to be pulled, or I can send quirks to
> > > you/Bartosz and once they land send the patches to drivers...
> >
> > When I did it I was sufficiently convinced that I was the only one patching
> > the quirks in gpiolib-of.c that merge window so I just included it as
> > a hunk in the driver patch. If there will be some more patches to that
> > file I guess some separate patch(es) for gpiolib-of.c is needed, maybe
> > an immutable branch for those if it becomes a lot.
>
> Are renames likely to be a common quirk on the road to libgpiod
> conversion?
>
> I admit I sort of expected it to be common enough that there would be
> one rename quirk in the code supported by an alphabetized string table.
> Such a table would certainly still provoke troublesome merges but ones
> that are trivially resolved.

Dmitry added a table of sorts, the problems are usually a bit unique
for each instance of nonstandard DT GPIO bindings, that's why I
mostly solved it with open coding in gpiolib-of.c.

Yours,
Linus Walleij
