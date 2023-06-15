Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33825731332
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbjFOJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbjFOJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:08:24 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1E1FFF;
        Thu, 15 Jun 2023 02:08:20 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62de1a3e354so26723426d6.3;
        Thu, 15 Jun 2023 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686820099; x=1689412099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WSj6TQv3vBLARHOJ2yajyVkw7AyFI4ZOe0aw/IQH/U=;
        b=gzpdtC2oKKSvAsSSSE13exp+rXvu3PBiXTLFtAKaYq193Y/8RSJZnKbaXGDk6dxo2A
         PUSxk9O9XQkz+uMXnaaMj4TpHz7EMYnxeuyd/mSlubKRO7GAomC+A1tL0Sow1iUKB3Ve
         K3z4/TT25npQrPHqf4VIUwvR/feBumlutzCPzJyQSDRRK9T2mWacPvNrjh0T8KfIbwnW
         e/NA00WqHPQTrc+GYqTm7f+edo3wwE4l9VhIcur91O1ZfHbeqIw7lfCVCXElD+PE6lf/
         9XGiU3BpYuCm+u8INmZ02UolC7nESMTWGsnDa5cx5wBQHpHDsaCfnga5sfScHA0wZi/+
         acaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686820099; x=1689412099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WSj6TQv3vBLARHOJ2yajyVkw7AyFI4ZOe0aw/IQH/U=;
        b=PwNQxxSmHeO1nBk3+dMmYJyGcvHzDJjtsSmQ1TERI5O7VOi4+VCBlI7W5GVEbwfUmU
         D+LteAI26lSjhhKYIaBZQEaXqwFX6Wk+W709XKnfd12N4ua7UKfair0mI12dWWVYK58N
         r1oGC8ItF/A1zr8aghWL1V7vK82vvqst5BWtQZ5GRIRBmNUf7gKjeYDndNGx78gGEHC+
         oMuu8EgUdtnU220fg4A77acob/dCTR6i4+FtOPsWmCGGb7ipu+aGjeOsh9MABP47Xtlx
         ajqZjW3wPDoCXudpBMh2QN8jjr6yEMFIHf9HqAkSE6IsJGKkFUfiiRIT155JONaxh3zT
         fMsA==
X-Gm-Message-State: AC+VfDwOdIp6Tp3bHwEY5A6Uva4jw5Nmr3QFVYNP51mTRtSGFWQVDgST
        dGk5rtXAWwEvkSPYOKdu1J5dUYOMF7E7mln2sdM=
X-Google-Smtp-Source: ACHHUZ4MqjM7aqb2JoPXfjP85vyJdTQhybQ+drvfyMGnQ1feLcHLP7kZDLFOW8WAUd9M+dglkx2J3aXb9UauUAeh0Ds=
X-Received: by 2002:a05:6214:21ed:b0:61b:6a71:e741 with SMTP id
 p13-20020a05621421ed00b0061b6a71e741mr18837605qvj.23.1686820099334; Thu, 15
 Jun 2023 02:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
 <20230614231446.3687-4-andriy.shevchenko@linux.intel.com> <CAMuHMdVaJ2Fqc5+YFCO9isUebUaeZE31T3C+SXDeVXOii=Ra4A@mail.gmail.com>
In-Reply-To: <CAMuHMdVaJ2Fqc5+YFCO9isUebUaeZE31T3C+SXDeVXOii=Ra4A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jun 2023 12:07:43 +0300
Message-ID: <CAHp75VezU_GN-C_ZARmLZ-WyLcz_rxqicwnAjvSu6fnv-y4Mkg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: aggregator: Set up a parser of delay line parameters
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:48=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Jun 15, 2023 at 1:14=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > The aggregator mode can also handle properties of the platform,
> > that do not belong to the GPIO controller itself. One of such
> > a property is a signal delay line. Set up a parser to support it.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you!

> One suggestion for improvement below...

Sure, for v3!

--=20
With Best Regards,
Andy Shevchenko
