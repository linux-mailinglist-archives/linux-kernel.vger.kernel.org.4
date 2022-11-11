Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665F8625A57
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiKKMOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKKMOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:14:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D5532C0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:14:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y4so4128205plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8h/gxEbgp/s/07Zs6AcE/Avv27PL6C1T/Tli7c1kLiY=;
        b=yjBupdFzwDJFvHI1bjwTyb/Zc8dj3fTykmviPaLHAfVabpLtDuk3Cpl3cQyvwcsT8V
         b6sMvIlfzJA7m6nETsGDXyABmw5jcg3muCpp2lIKoom6eigufGHytopetb8RfcVbd+Pp
         q/VoA7+V14+W+iywQQ6H9c479EE9k3zJT2Cb0bj08PGQYslAW5TVS+hVnovJQPhPE44Y
         fG0/aqQo8d3plBQNnesQcfD0sSEMoxeMGgmqwAd3EdZeD2BxT6ouQfNL+3IrHSbVnDBU
         a4kDHY/RoS+SpFut9bug1tOtAg+qTsj6v9ZDkG4/5c1JliSOzLpw1HjFfLeGtpbcj/bM
         BzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8h/gxEbgp/s/07Zs6AcE/Avv27PL6C1T/Tli7c1kLiY=;
        b=jycZ8x6JhXlGRt0D8ZMfvEjpvrWaPXmzaAPGckg9CvvBaFP8s/IXpZ5tdnL2JFANts
         uts9tAr3XlINYZRjjlEsnzwV5a0LmjBeVPT8FvyoShxYxZq6i6ZrMEl/jkkNAbjQZku3
         /TsIJ18hwHOh65qPkAAQN1PYzOPkEIpfDEj60nRtyzGs6HSDuSUu/9g3zdvXqeDxLqn8
         H4yumsTJ0af8zZteZ4lMs7MiLAa+k7Fmj6KwvxssC1O0HXtau0b+bk3Bes7Zo60582cu
         3mjpyLCNJ4OlWlnl1EUo+dJ9YzKpk2m4ui4gi3Wc4iMVwzU2MypNcYtVKJ6w6mmhzcrw
         lN1A==
X-Gm-Message-State: ANoB5pkoqvvvdNprEty98foKwPWXYzS8VtvugDZ773Mq5Z6I4BVTRG9B
        p1vWcPqnKrnL70du9WL8EZUPkVPOD9c6E1c/3Bqq93j0Uc6Rxg==
X-Google-Smtp-Source: AA0mqf6xZYsqTdkuJYEXRTfCQc2yElFRvIGtYWnXzaWhdSSpHBmCOGve7EiTtfEgh7UyFJZEaPYDv5+VK/8c94uvILo=
X-Received: by 2002:a17:90a:d3d6:b0:211:2d90:321 with SMTP id
 d22-20020a17090ad3d600b002112d900321mr1658230pjw.84.1668168852228; Fri, 11
 Nov 2022 04:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
 <20221108082533.21384-2-hayashi.kunihiko@socionext.com> <CAPDyKFoiowaut9EhDeBH0ci50WJ7y8UFivxqExxS0EfV_KAhpw@mail.gmail.com>
 <5ed33703-0f20-68d0-d3d5-1a53ab08a1b8@socionext.com>
In-Reply-To: <5ed33703-0f20-68d0-d3d5-1a53ab08a1b8@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Nov 2022 13:13:35 +0100
Message-ID: <CAPDyKFo-rQ9ijSXtzE6xV0d58xdqv1qfEV1+Jycfn1ekzVp1ug@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: f-sdh30: Add reset control support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 at 07:15, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Ulf,
>
>
> On 2022/11/09 21:15, Ulf Hansson wrote:
> > On Tue, 8 Nov 2022 at 09:25, Kunihiko Hayashi
> > <hayashi.kunihiko@socionext.com> wrote:
> >>
> >> Add reset control support for F_SDH30 controller. This is optional.
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >
> > This needs an update to the DT doc too, which is also the case for patch4.
> >
> > That said, please convert the DT doc into the yaml based format as the
> > first step.
>
> Yes, I also think the document to be converted in order to add new compatible.
> I'm concerned about the maintainer and the filename.

If you can't find a maintainer from Socionext, feel free to put my
name in there.

I don't know if there are any good rules to apply for the filename in
cases like this. Let's just try something and see what DT maintainers
think of it. Perhaps just repeating the name of the driver for the
filename? So something along the lines of:
Documentation/devicetree/bindings/mmc/sdhci-f-sdh30.yaml

>
> I'll convert it anyway.

Great, thanks for doing this!

Kind regards
Uffe
