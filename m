Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF46FFB75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbjEKUtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbjEKUtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:49:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EC619B1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:49:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so43496490276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683838145; x=1686430145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PS2/c9QvL/3w6lXNaswW1QRNDamQ1dzdDujUD8jAhA=;
        b=t5jjnWWlPBzm18PiMq9jTeykQKeXg72a0ZPYkd1CvETgVallEcxQl20dL/arMItNih
         VDwZTHGN/sArnIcr2Vu2jX/4+9V5T1VPRiWO634UyQB7AGkgCjzArNtlU4FzKB4V2/X5
         x+5S/QVNcfbm6s528mv+LMJhJVKV+RzuQ5NvqFfKKJLsaNPXG27xBOeFGKWu4tr21p0S
         196UndwRwbUhGy/W3n4W0bN4oKoDZwSJbnoLnyWZfmB8mvurEose/6ZNuyGA+q1cyAu0
         lUGjSFn/1OSKbBv5DPIVW9p9I1//SE49bZILQzdCUBLR/58gz+mVzgjFauGY46nvt8KM
         OZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683838145; x=1686430145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PS2/c9QvL/3w6lXNaswW1QRNDamQ1dzdDujUD8jAhA=;
        b=OQK9xWyYOgjPr+GCaMwUh+fPUamVtIHv1HmFDKb+6iD6ocxILSb5aqGCdpIim2YJBN
         jy+QJmREBrSFOXgVVl1deiaBss5QC8wP0sCWxkUt8Hll4NGAPoHCr99Eos8AGP/3u7gQ
         rV7V0AIroVD4JPrF68zFZkzz6/cmzFR8P6hIMPz6hKR+uOgAkFXp40dowiR1FknsrKIK
         i56NchhXZNMofNW7HhSGqsif4i2iVpWO7NEefmAoWp8pH8Ew/rw3cwvgeUiW+Liuu8mu
         SlSGXyqv/ZwWhNCLYXxkKwOHx6KLa6Qo7AsxrpqMgJRp1SIimd136L6HreF/lMY/0xCe
         exLQ==
X-Gm-Message-State: AC+VfDxAq+NQicdeJsuYoiAaPi7KPZDILKeNMELtTdMcaSgd1pStVQkg
        XSVLpMSdspzamylQziyGzkir4suznrkS+uJrCH4T3w==
X-Google-Smtp-Source: ACHHUZ4st1au4FNJjgEwZ7jT7NEg/ChCFOssevCzS0zHYemDBQorrme8sDYfsHWjvEv/Dy7q2VvkzjonSQAfc60NEFs=
X-Received: by 2002:a25:d8cd:0:b0:b94:bbf2:19a3 with SMTP id
 p196-20020a25d8cd000000b00b94bbf219a3mr22194052ybg.18.1683838144767; Thu, 11
 May 2023 13:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230510001151.3946931-1-chris.packham@alliedtelesis.co.nz>
 <ZFtK3DydE24Qijle@surfacebook> <760ae58f-cb0b-dfe6-9e24-664310651e18@alliedtelesis.co.nz>
 <CACRpkdb1UFQ=1gePeBBEQ3ODu+6m0dHBqaxdtOF9Qc01WytMEQ@mail.gmail.com> <ab62b83e-0074-4c71-11d7-9aa6846a1eee@alliedtelesis.co.nz>
In-Reply-To: <ab62b83e-0074-4c71-11d7-9aa6846a1eee@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 22:48:52 +0200
Message-ID: <CACRpkda55gYEnwgLGX-73POCHsQv769ziS6L6oJzHY2coDD0pQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Don't implicitly disable irq when masking
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:36=E2=80=AFPM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:

> I spent yesterday trying to demonstrate the
> problem on a newer kernel. Some teething issues aside I can trigger the
> warning if I have a gpio-button using one of the pca9555 pins as an
> interrupt and then I export some of the other pins via sysfs.
>
> Interestingly the warning isn't triggered if I use a gpio-hog instead of
> exporting the pins.

What happens if you use the gpio character device instead of sysfs?

Like for example with the tools in tools/gpio or using libgpiod
example tools?

> I haven't figured out why that is but I'm assuming
> it's something to do with the hogged pins being excluded from the irq
> domain before it is registered.

If you write something to the "edge" file I can easily see things
going sidewise. The sysfs is really not a nice tool, which is why
it is deprecated.

Yours,
Linus Walleij
