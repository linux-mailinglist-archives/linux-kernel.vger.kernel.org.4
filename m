Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B90623F20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKJJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKJJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:55:24 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618C69DE7;
        Thu, 10 Nov 2022 01:55:24 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k2so776858qkk.7;
        Thu, 10 Nov 2022 01:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQw1KJ5AWDcX1kLbPZYv1EymkpPJcZtJEdFtyQbRpsA=;
        b=IHhUx/7uO9ULiSPOrRD75OiqqQq4dWCrNZA621PlpaeNxjDf1acz+5I4qcQkvyP/1q
         ntVDqQFAoQsBWeuBd3Rg0Z5lg42wLxTI5LXOZdTK73OQR3JYVzUJXo5mIbtDsUSHuqr2
         +/6HMgjyc5SznbOh9/e0KyRW7jl7pTniY7zxyojpwg551PQ66LC44RKmXTHpG+dhLkGd
         b38hq3q47mWdIWMN+hO8l3Qndbo4IAt6s7UpFcTAsTb3AXlPDeLJm3YMdZD5v7EMpfNl
         R6BTQee4OeM52FJiju/yn+epc1/JujZY+Ru92StcyJT73UjWIX7MEPTI/M4OrDB2EOhO
         bkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQw1KJ5AWDcX1kLbPZYv1EymkpPJcZtJEdFtyQbRpsA=;
        b=fJazREBEIfFjyN4mtRizmUWsafWyM5mdQHbKgW1R2e7J2c2DQePlNUMXuAkLjN8I89
         24bS+IdH/blYSkerGcwwJsdg09apOhpsrAlsWqHfQG4NSccQThz9LNUjHaqzdFgbNSNV
         OuH1eRO6RF1c2UMtyZoPOfbyCEg/JFb+yCQ3Cn9NYKwTJ5XYSCh8wubpL5Co8XyErlxU
         dCPNiHD/ex4PORqNmY6nBdcsgtmV5jaMQ610GbzuhY0e6BqRFe78iMbW1o6urmSWiMiR
         MvY8N0XTq0MK4uupJ+g3r0RB6yJfZbmmklWmr1HTM3cN1mQ0wP0QvYAFLGriemoXGD/h
         HMHw==
X-Gm-Message-State: ANoB5pn8q52e5YKw2zDbuSLQFR+NR3SGu0xCp1SL5ydPtKOud32q3KBn
        K9L4/McXwO1QmEg/arWzLU9vvk1DgYxrhnbkjto=
X-Google-Smtp-Source: AA0mqf4GbxuiT+PsQj+zMXsXu13wwCJnuO0NSB5qh5VrABmCjs/10yLeYfoLUIGav90FCLSqiEJGINLLB4DqqhxvDXQ=
X-Received: by 2002:a37:46d3:0:b0:6fb:1454:e2b8 with SMTP id
 t202-20020a3746d3000000b006fb1454e2b8mr4435749qka.383.1668074123297; Thu, 10
 Nov 2022 01:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-2-andriy.shevchenko@linux.intel.com> <20221110070718.bqpam7h3hjf2hkip@pengutronix.de>
In-Reply-To: <20221110070718.bqpam7h3hjf2hkip@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Nov 2022 11:54:46 +0200
Message-ID: <CAHp75VcQ98Rxxq4Zw0AAp8rEtRg7oAb_eR_hyMFRx7AQnCifCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] pwm: Add a stub for devm_pwmchip_add()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 9:07 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Nov 08, 2022 at 04:22:21PM +0200, Andy Shevchenko wrote:

...

> > +static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip=
 *chip)
> > +{
> > +     return -EINVAL;
> > +}
> > +
>
> I'm a bit surprised to see this returning -EINVAL and not -ENOSYS. But
> that's in line with the other stubs, so:

Exactly my thoughts when I created such a change.

> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thank you!

--=20
With Best Regards,
Andy Shevchenko
