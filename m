Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF296B1498
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCHV41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCHV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:56:15 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377DBD23BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:56:14 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-53916ab0c6bso329890277b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678312573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SNpxUvoL3wJxQvDMk4hmZFaxXnNEcCgcZlciVtsvXc=;
        b=CDQcTCIVb/Mbv0ESOZ6tgosr11PuDIjK/sne0DVXVcMGwsaSV0+NmVsnd2HG1WfuNG
         Y4KzJFuCJ6sorGtK20lC8/nM/kecNTJdJRJs1wMs9axjzcPpn8LjzNn6YEPUQ1N6heOI
         y72YJ7p4DvB3ei8QC1Mlj8qEvqjtXS+pIgguSFuCWqR98j4MYIvP7capwe2QYoMpUqwC
         bK5Q7HAEQRGCFdGZjcGNLx/BRRPYpN4TtN1wFSygnsKwCj4Y1hQ83NVZTM9a2MOWIcWu
         mdR0TryaP9O58xQ5iYRXdRa/LnUMjrdF1so+7ag4xgSMK5SR10JQJq2Wl1FAnHx/2zNu
         cPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678312573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SNpxUvoL3wJxQvDMk4hmZFaxXnNEcCgcZlciVtsvXc=;
        b=fzidUKQ5o7obixEM7i8YDNDy53uwP3RQ5Jh7nqDJJWeGRHBkzeewkhTq31wMsrab2W
         gzj1DfWv3v+PdqrsDxw5KrjQm4W7yWtFt0bVpmulwPFEcbpSs76JYL6iji/X1o8LyUCf
         aV8vSoccvK5UdVTBtvohLCbWM2cgpVB+uCIFs0nfk1BH09AflGSDz2Wora4wK8s0a+iJ
         yorZpjAxamJkNvtkIVqYn1gYC9IhcxtpSypiseU46j/gkbvA/SWeWbAtysQ+CA3M9onl
         15lVgf+yWxGp6ExorfEyyBDdsv7VAaJQd7tWv2GQ+5RuWzBFRTXFqBVrpCKYOYj406I5
         zbSA==
X-Gm-Message-State: AO0yUKVy+bs10YlP6YoIXKgIfFxU1ohNG40AWQmCJZZaBVbdwJz6u5fX
        hgXLDKfDa3u/eALxJL0oFe/FWmGp0wUggztcBI6Mlg==
X-Google-Smtp-Source: AK7set8yauEv2vcx8SVSOeBSvIcZLRFAawEdiiK3vsGVmvLq0nGKK1nv0pzzTynl2uX93OymJM1VQT+KwzqxmI6CYtw=
X-Received: by 2002:a81:b149:0:b0:530:b21f:d604 with SMTP id
 p70-20020a81b149000000b00530b21fd604mr4893153ywh.9.1678312573418; Wed, 08 Mar
 2023 13:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20230308145303.826942-1-arnd@kernel.org>
In-Reply-To: <20230308145303.826942-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Mar 2023 22:56:02 +0100
Message-ID: <CACRpkdZAJJr5+f8wiEhnAAV8mLjzYCBMDC9GXwQOAmsQLfShoA@mail.gmail.com>
Subject: Re: [PATCH] mips: ar71: include linux/gpio/driver.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 3:53=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The change to remove the implicit gpio/driver.h include was done
> after fixing all the other users, but the ar7 file still needs
> the same change.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 21d9526d13b5 ("gpiolib: Make the legacy <linux/gpio.h> consumer-on=
ly")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If this is the only problem merging this set was amazingly painless.

Yours,
Linus Walleij
