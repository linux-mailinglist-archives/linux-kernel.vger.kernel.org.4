Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B40602B88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJRMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJRMTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:19:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188AAD9BB;
        Tue, 18 Oct 2022 05:19:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w3so9457951qtv.9;
        Tue, 18 Oct 2022 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LiNDBNVyZfRCvjPG4NAD0FPyNgn27eYCFKSVJt21O1A=;
        b=CdtklZI4CVjxSMQNIZZn21ikyKOwFwTSAmkb1Q2iioTBafnzbO2blM03OYarRgWcQ6
         jO01FgQr4dB+gyKfPjQ+2geWll7bKxTxxQ8/wXus+f7c8ApINwU/Spi9tVFYzX8Q11Bx
         YJqlBYPr+2JqdRHDrJ4qY0Zj1CFrkSioxE9Q10GYQHgnJHBre8Hg4oG6iZz9r7Zzvi9S
         ih/WLMhQ3rdC4gTja7VAHXDUgD0XxwOVQCifuH6HTovM1CidvW9XwYkck3c49x4tJGMS
         Yv4RtvmIp0TLZHmOdYMxfgzg3qOLBUfWOGyCAb1WhCuVF7woAZek8yya6U4vvjpv6r4p
         fGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiNDBNVyZfRCvjPG4NAD0FPyNgn27eYCFKSVJt21O1A=;
        b=rJ9tGTpL7vkVAeMdgL8cxmA5r8rSykj12qxwwtgDN+raT6sXlyRTT9+QmPg2DmvkLi
         ktMVoWJdU6enrOA9bhLJz8t096bcvUbpKDyO20Z/eQaeWB9bLEXLl9BxE4/jV8h8EVuZ
         fXbkJCVaCxxaocizL0spGVLn2mRXSKev46ts4aalN6UomXxcnesHPslI25U64DM52WP0
         tJO8/bbmmtU5OAuaDxwj6BUgN3WyYV+c2OZAYtkxzsDUEtyq1jtmVJX1vMd1KTVfGxiV
         nUsHP6as6J4vTJ5+Qka7hOPF5tNEw9gaptPN60I5dl8dQt8pKBsRx2jg9bHfe5O4Bub6
         Vwmg==
X-Gm-Message-State: ACrzQf1ZzIDpk4GNr/llAwvZLFYLDXdmNMAn+gQ48S3Qz5qsEbxToId9
        1pd0EJZiGPvHfoOHjCwljLrcNh2qfHFZlobLVrE=
X-Google-Smtp-Source: AMsMyM42wYUHzaf6FdDo7ooxTQC/Q7AwwYYKqUW+nOUiZm+XijDhUYwDXtRDPnOV2rYbFAxZpbitt+QCIXfZL2hNI8w=
X-Received: by 2002:a05:622a:1045:b0:39c:e2e1:dc59 with SMTP id
 f5-20020a05622a104500b0039ce2e1dc59mr1718640qte.195.1666095554850; Tue, 18
 Oct 2022 05:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
 <20221017184419.62d365c1@jic23-huawei> <LYfRwE3pxZfgZBDC6gwvsSrHWqcSQXHK@localhost>
In-Reply-To: <LYfRwE3pxZfgZBDC6gwvsSrHWqcSQXHK@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Oct 2022 15:18:38 +0300
Message-ID: <CAHp75VfL5TXvoVY8Zq946eUJYetLt2Od2m26mUSPGxsdF=TC-Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] Add support for AXP192 PMIC
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, lars@metafoo.de, linus.walleij@linaro.org,
        brgl@bgdev.pl, michael@walle.cc, samuel@sholland.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 18, 2022 at 2:06 AM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
> Jonathan Cameron <jic23@kernel.org> writes:
> > On Mon, 17 Oct 2022 00:43:22 +0100
> > Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

...

> > Lee has recently expressed that he keen to take as much of these sorts
> > of series as possible via the various subsystem trees.
> >
> > As such, it is useful to call out in the cover letter of such a series
> > if this can be done.  For example, patch 9 (last IIO one) can't be
> > applied without defines in patch 6 (I think).  Thus I'm assuming Lee
> > will do an immutable branch with at least those patches on it.
> >
> > Perhaps worth expressing if that is also the case for the power
> > and regulator subsystem patches?

> Yep, the IIO, regulator, and power subsystem patches all depend on
> the MFD patch.

There are two types of dependencies: compile and functional.

> Specifically, patches 6, 9, and 10 depend on patch 5.
> I can't get rid of this dependency because the variant ID (AXP192_ID)
> has to be defined centrally in the MFD patch.

It's not clear which one you are talking about. If it's functional,
then each driver can be taken separately via each concerned subsystem.

> The axp20x_battery patches (last three of the whole series) don't
> depend on the variant ID or other defines, so they could be taken
> independently through the power subsystem.
>
> Even though the IIO cleanups (7 and 8) don't depend on anything else
> I imagine it'd cause problems to take those via IIO because patch 9
> depends on them.
>
> IOW: Lee probably needs to take patches 5-10.



-- 
With Best Regards,
Andy Shevchenko
