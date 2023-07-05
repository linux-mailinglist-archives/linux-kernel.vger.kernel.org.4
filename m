Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C004474829D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGEK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGEK7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:59:32 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD29170D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:59:31 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7948c329363so1803354241.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688554770; x=1691146770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k/syZjZ5ecf+T5Y2kxPo2h389Z9w9y0KIrLdIakXXU=;
        b=eBqbUcVB+swDDWpWU/yAgoyCDP73cTdu3A0wSHXfMaOjUVwXPdJioyVMih1KYaUlA+
         ugGQvNKSU1xFwFYsvBhvHR6dPCYwGTrp+nc6vQtO6JRU3TH5BNsjibyhCr7ce+zATWMW
         emj6qn25fo2nkkFA+9fwqCPgivNIzli6o+csNlrGltEzQmp7w/tLch2SdLAlod7mKt4B
         4q+Z+g847ziOa2/Q2ch8ah2zfTrkgeKjbG8J/TI8rWaNXpLFMEL7mGDHy0H4IG6IGptW
         rsU+wD37DiXQIHw0UMG8TJSRyQhxKJ8MoH6cpAImMi1OI6cR/Hm3oDdtkQZGyxbFGgm7
         jb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688554770; x=1691146770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3k/syZjZ5ecf+T5Y2kxPo2h389Z9w9y0KIrLdIakXXU=;
        b=RAYLKGXMoW+anzFYbcQ4Qvg5fYuXKxsfjtYqH10bXruEyqME79h3iYThVZmMktObfZ
         2QF5iZ1OxmoV1kEadzI06Mj26pNu0bBKe+l5nP5XcmZ4lmzMUkkSAUMdE8LRSdeenU2Q
         Fu2LFbaQ0IgoWBxQwWSN2oRju3h4Kgwn27OKUHau/tti+V2Yq4ukbpJTGHSYxstnTzpj
         zWfP5dQ5H8oPQ0G4oH2MFYsbWnc7FNr27UajClbJI3Z1YwHpCeQze4BwsZ6zzflph9tp
         tVbY5Vfnra3J3fnqtYK5frFMd29Aa5HVv24ub9GKGMz1tOiLC/Ud6d2RrEdU0iezlFpj
         eEeg==
X-Gm-Message-State: ABy/qLaleCMk+7kPuGn4ISPJIdmeInO3OTOodMQQcThJ8IDS/9aL2Dze
        rmmaU1N+UK0goVcxlnXF0BAP3nDWkhnB0oWVvsDutA==
X-Google-Smtp-Source: APBJJlE7EztWM9v58nL7sBZryj6YvHUyHkIIKUBzQHIxK86KN1aupEITpHUWARRXg5G77DuSg0XIkGDdF1VKluxATOs=
X-Received: by 2002:a1f:c1c2:0:b0:471:3639:210d with SMTP id
 r185-20020a1fc1c2000000b004713639210dmr7079460vkf.15.1688554770371; Wed, 05
 Jul 2023 03:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230705074219.8321-1-brgl@bgdev.pl> <ZKVMr9yrL2JavqhF@sol>
In-Reply-To: <ZKVMr9yrL2JavqhF@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 5 Jul 2023 12:59:19 +0200
Message-ID: <CAMRc=MfVsayqftsBJcxyotP2Lz-EPzcXWofFBdYuBDSsVjho_g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add missing include
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 12:57=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Jul 05, 2023 at 09:42:19AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiolib.h uses notifiers but doesn't include <linux/notifier.h>.
> >
>
> Fair enough.
>
> Reviewed-by: Kent Gibson <warthog618@gmail.com>
>
> Same is true for gpiolib-cdev, btw.
> You want to touch that one up as well?
>

No, it already includes gpiolib.h.

Bart

> Cheers,
> Kent.
>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpiolib.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> > index cca81375f127..1409d52487c0 100644
> > --- a/drivers/gpio/gpiolib.h
> > +++ b/drivers/gpio/gpiolib.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/err.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/notifier.h>
> >  #include <linux/cdev.h>
> >  #include <linux/rwsem.h>
> >
> > --
> > 2.39.2
> >
