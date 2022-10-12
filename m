Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7665FC51B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJLMQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJLMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:16:22 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C4B4886
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:16:20 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 3so17214340vsh.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6nwrNU0AH4f7iCQlXPH/XS5dC6On4VeTBI659GaqJI=;
        b=vevTxUPJ2H0KTi9Wj8buza5iEeGLeor1UI2UWdrrpCMTE+DPKtQpmTr/qCgdCaTpnD
         PKtrkvmeN0PUN+qp17dND8u3B53TnuB6ULTZZhuie1exOK1kIBFIrZarMlMi011S0M4A
         aKPbJanToEx38erRU7yddVnzxN8iVY85fV13fjsqj6cG0XvMHXiWIm8AqFyCn0H4UlxD
         oC7COYN2cKGobE38hxJW/AaxuzP3E54BVrXDDlxl5ssaj87qc+UqEceiufL39e9RtXeG
         Eqiu/FsrLPSe1v3edH28VxJIqn7qDKb92oOpYlKUvMx8Fx7fysJaQqZbJWtpD6RJZEni
         /I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6nwrNU0AH4f7iCQlXPH/XS5dC6On4VeTBI659GaqJI=;
        b=pP8d9yei14mDF3sPcG6BnJStRfY8rgqLtdFddWpwTWpBPFzfdi/T8Rgkl5qXrXyVEH
         ePZ+a/ql7/Ana9SUxATavlUP/+CE4dIy8ZDg5dE4RKZX+czvo1NK6b7l9OzuBW9PXxLc
         3Lf6B74pq3KeHrfDlXvRnn5k4Z70bJFbspDCp49i5B683wQME89I2g0yCEDNNn+1RnZN
         TZrORqplsdvwY15i8B/OhC8vZXzi3EF/WmicELc5W8eyr43nAajAtwJvn2GZcuEFUgPO
         uydqbfZCuqhHxFXZtcNZsFoO+Ev8iaCRNnf2eDx2jcF2B1uq0Gq8XEidtS93XQt/eGDa
         MU8g==
X-Gm-Message-State: ACrzQf1XdWNbC4D9h1YwoDVwAP/PP19ftoLPgV2rjscrlOPpmC9R+ETm
        c4QYCgGbLXM/jz9RdrJMYgg9ebXnLrcn2+gKnn9v6g==
X-Google-Smtp-Source: AMsMyM5GtV8SqwPGtpPeISERi9xTPcmdjX0MLuusrG/da9K3IRfi7wYwFUiAPDgNHQKn9pqqOg4yJTNzZYhNh7+fxm4=
X-Received: by 2002:a67:ead5:0:b0:3a6:e463:4b0e with SMTP id
 s21-20020a67ead5000000b003a6e4634b0emr13782590vso.61.1665576979909; Wed, 12
 Oct 2022 05:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221005145746.172138-1-m.zatovic1@gmail.com> <20221005145746.172138-4-m.zatovic1@gmail.com>
In-Reply-To: <20221005145746.172138-4-m.zatovic1@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 12 Oct 2022 14:16:08 +0200
Message-ID: <CAMRc=MfogAnGPL7BQp6r9_BpnJPPQ=DunqErfLrn2Ci960c=sg@mail.gmail.com>
Subject: Re: [RFCv2 PATCH 4/4] gpio: add Wiegand GPIO driver
To:     =?UTF-8?B?TWFydGluIFphxaVvdmnEjQ==?= <m.zatovic1@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jeffrey.l.hugo@gmail.com, andersson@kernel.org,
        Michael.Srba@seznam.cz, saravanak@google.com, mani@kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 4:58 PM Martin Za=C5=A5ovi=C4=8D <m.zatovic1@gmail.c=
om> wrote:
>
> Wiegand GPIO driver uses GPIO lines defined in the devicetree to
> transmit data following the Wiegand protocol.
>
> Signed-off-by: Martin Za=C5=A5ovi=C4=8D <m.zatovic1@gmail.com>
> ---

[snip]

> +
> +DEVICE_ATTR_RW(pulse_len);
> +DEVICE_ATTR_RW(interval_len);
> +DEVICE_ATTR_RW(frame_gap);
> +DEVICE_ATTR_RW(format);
> +DEVICE_ATTR_RW(payload_len);
> +

We don't really allow GPIO drivers to define all kinds of custom
device attributes. Also: this driver does not register a GPIO provider
- rather it's a GPIO consumer.

For what you're trying to achieve: have you tried using libgpiod and
controlling the lines from user-space? If that's too slow, then I'd
say this driver should go somewhere else. Maybe you'd need a whole new
protocol sub-system for that. In any case - this subsystem is not the
right place.

Bartosz

[snip]
