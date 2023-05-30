Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D0715DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjE3LrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjE3LrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:47:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6618121
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:46:37 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so6351199276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685447181; x=1688039181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUJILdtJMJoGIdgauKb6V4jUFqAoPR4Aj10k+ul/UDE=;
        b=IMWC0wjY59bzCGS7zJk3bSQYlIXqw+JeQ3y1IWQWhQiLXF2vaTJtZJmQh9zf2CmT/M
         DDhnX+WopwHeb5JG+ZbwPMualrcvR2RzAUySfQTek1xnsdICL2hD2phnyJoLU7Rna3Km
         wgUeYMrWbpk4R2vbpDNVFt7XlDg/efUR0iOCtWY39X/czK03aOmLF53ZFAhaEo2Tc0Jk
         LLVsjfeFPEMcncWvdCQtotATPrGD9ibH6jagYVr+s0krbxSnc73BP58bZ4BQT8kTt7Yg
         NzeEgvwW7ZLNQnkOZjFujIU7cSH2hbIdOi7Iio4f8z2jxiX1C5i1iL4Gr++KacL5xPuQ
         bqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685447181; x=1688039181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUJILdtJMJoGIdgauKb6V4jUFqAoPR4Aj10k+ul/UDE=;
        b=YaNlG1a5XDynrMm9rFzHPN/pVTGk/bB4Is8+lZz2m+bQymfeApeyub1rF29qb/ms8e
         KLqWcqms2pL0VzmgstXlA9Dmz0lGKnGGDZKUkojo6JSwJ5tIKRJ4ktlQEsPGqQDhNc+r
         rRiCKWt+luOqHxZx+ItxqUH7tW3Wd2C5SEEUndk+jM2bq3+tYdQpn2lO+OYn3l9da6od
         b9JXc3BisRV/+1QnIBSr2UwUuFZJbFs0cfnhjjD1JfXZWwb0HhY2Hod9MZtq+jXqF8Wq
         ByrdsByu8KqE6z5Txf5vmFnjXdBM4Ccd9Ne6oRL2yT48QBPjSn/KHsUMMUbh+S5DDBso
         NMog==
X-Gm-Message-State: AC+VfDzmohlGDnVKvOY0+ul5k1FiPf53UnShtZtXWpHkvPSt1p4GhV1h
        Y5f2H1hXDVu4uOuGfwK7ar0V3Y0mXkM5EtdC0Q0w6Q==
X-Google-Smtp-Source: ACHHUZ6qeK1VUlzVVoYriVl36VUfxvr4XRHsg/sZx0twYHip1poh59C0DDAZeBtvwHO44f/HwXpTzoDZGovs/QbkI0Y=
X-Received: by 2002:a81:5b55:0:b0:561:a422:f3cd with SMTP id
 p82-20020a815b55000000b00561a422f3cdmr1795570ywb.30.1685447181672; Tue, 30
 May 2023 04:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230527114057.36091-1-andriy.shevchenko@linux.intel.com> <20230527114057.36091-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230527114057.36091-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 May 2023 13:46:10 +0200
Message-ID: <CACRpkdbnKngR7x2pvvvvbhj-4z+EyCiwchrrEbbwO=MSOn-HsQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpiolib: Unify allocation and initialization of
 GPIO valid mask
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 1:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Now that the of_gpiochip_add() doesn't use valid mask, we may
> unify GPIO valid mask allocation and initialization. With this
> it makes a symmetry to the similar which we done for IRQ chip.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
