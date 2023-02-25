Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6936A2B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 19:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBYSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 13:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYSnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 13:43:23 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B2915C84
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:43:22 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536b7ffdd34so68435027b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I8IK9P+jxWu1bL2qvPFPSE4kfaDrqnJN0ZzsIbW1USE=;
        b=BnXWFItg8a2+FZNR7isonXjZb42cX9XDWvBZInCTCKs2hb6/Z5ohjcNZAIMAXJSoSj
         m81pc1XjI2C/IXYtGnfJsKtx2Y/iYEzwPlGAeoKTpdKtYmP4ma2y1/4VoJ8defkDhDuO
         +apeXjZ69z3QthLGSuTPIbhnqzQa/H6eyYy1rKeBIlEhZUw3aamVSzzyh6s28LfYytmi
         mZ1vQv2daZjsbxUAAVOz31AxQztRAQtioPt4wDkyzmjYc5nzopi42gamDvWqspwsb9sR
         HEHvf0zd3lgloiHp9716097ezx33Hp+RDSGQdZHjI1C220DJKkPWC+0aIXwai8g+lOeE
         Lyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8IK9P+jxWu1bL2qvPFPSE4kfaDrqnJN0ZzsIbW1USE=;
        b=nbhOTpFhKy35j90o96Eu7gA0Oo/87ZZwT+61kAnfwAAh3BryUEnWkOi7oLNAL0g1xa
         JcLZniwSmz8wtGsx3+EXMXIUg63NxmEHGBc33BGiHMo007yigMrsOz7BACxXALEVo4oF
         vK5oTKXUha8qKmIUHhAbXgPnB0K/bbIYDIk+I4+rNgsRIjevXyftpA8x1hNnNx40qAPi
         ZZV55BsCyZ/6FDunLKdXff6g3gWvKULW8YearZa2hYr2ZkYgP2zw1zyyD81FQ1OGTcXt
         UA3H2aDkTVGCyMsggYttTqnx8b8aBqtJ3kKyBNa5+gAsdKzq+/bxrNAnhSN6gcCzgRp7
         XRdw==
X-Gm-Message-State: AO0yUKVo1/b0134oI6mcsdMrOk+9w/I2RsUkweUK0CqUgpFxCoOFEh/z
        Pvfu1/fIM17pz7hCCOx+BiMC0w4cJrZT+CR9BTNb66KOgAzFXALl
X-Google-Smtp-Source: AK7set93mxYiVsX1P9d5lhnp8iCFcRX+ZIXUaDmhw51o8NIZKTJHHwhCVsQEuDtqpadeSwQMOtC5+v4ycnX6Btdh3P0=
X-Received: by 2002:a05:6902:118c:b0:a06:538f:265f with SMTP id
 m12-20020a056902118c00b00a06538f265fmr3259165ybu.4.1677350601666; Sat, 25 Feb
 2023 10:43:21 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
 <CACRpkdb5dWOqRZpjcmx0M4H_REcZ+K6zY0tPz0K-hH9o_Ybd+g@mail.gmail.com> <Y/oltFrnnMI17IOY@kroah.com>
In-Reply-To: <Y/oltFrnnMI17IOY@kroah.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Feb 2023 19:43:10 +0100
Message-ID: <CACRpkdYc6dHG+EpRHHdnszt-Q4TfdoXTAUkJqhHzb+rWtpKp5g@mail.gmail.com>
Subject: Re: Regression in probing some AMBA devices possibly devlink related
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 4:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Feb 25, 2023 at 04:06:48PM +0100, Linus Walleij wrote:
> > On Sat, Feb 25, 2023 at 3:28 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > > I have a boot regression for Ux500 on mainline, but bisecting mainline
> > > isn't quite working for misc reasons :/
> >
> > I however managed to revert Gregs entire branch for driver core
> > with:
> >
> > git revert -m 1 a93e884edf61
> >
> > And this makes the regression go away, so I'm pretty sure it has
> > something to do with the device link patches.
>
> Does the fix at:
>         https://lore.kernel.org/r/0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be
>
> resolve this?

Sadly no.

It seems pretty different, my problem is eternal probe deferral.

That patch looks good though.

Yours,
Linus Walleij
