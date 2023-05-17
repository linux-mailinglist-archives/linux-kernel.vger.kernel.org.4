Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5F706093
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEQHBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEQHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:01:38 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15EB2D43
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:01:36 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-559e53d1195so3345547b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684306896; x=1686898896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QbqyeKnb8q+lJPI9nOEWELmEZmSd2lE3lrjGrinywY=;
        b=N1b1zhKc7V+vPMTgjMc9dQMUMq6HFBKv0HsIg6gct0rFr+Wo5g1GOUt4quETyX6gHM
         YAfxJT7jOvxBHM9/DQOKX60BMPGLuathk2awEa5/4hAOg8jVrw7mxsHhN90Sjua5yrHR
         BzkyCh0O1zlJxTkELtOEPjLqigckJ4UPtoUxpuO3HcQV3Ebaa0GVXAKlxWVChvF4fxZr
         An6nsAHQSXaBBxPntSI65ymgFmHAetZjR85bDtp0tcuTSpWMprCeHZLrxozaorNdVx00
         0jFR8vavJVlYLNTDLl11ITBv4eHqfIyy5fVSbGw4yPc+s91jrMVrMB211aqkpMg7c4Mm
         r5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684306896; x=1686898896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QbqyeKnb8q+lJPI9nOEWELmEZmSd2lE3lrjGrinywY=;
        b=LYZaAbfwGqXOunMryh8/M7SEMzLOrGo1bS45578QTZkT/Ihla6rGw/4gS7GC9QpF0D
         WlIcGlOApS9fJgCKPEc+1PnH7+Rn3lyp02sKSRjNrEkE+EDdRzopERugoNUxmPaGtx+0
         61MC6VNmPB6h8oHoCaWPnJzROPRucFArNXhHCn8PevY70vkFHNGKzCo9eDA5FUQHSFXF
         AaPcO1P1BaY0xegPvmjn+yyq4//c/Od6S65LASFrxaBfY3tWTuQOm8nTggszYUqNS62T
         cK7C/qJLQQoRuXADcvdMAjyi3JGpcuJTIjWAZ8fRaqZKTI07RCeJnB2nX5vAbT4Trnfw
         uxCw==
X-Gm-Message-State: AC+VfDyvZ1eS0UTcoKJOVAgKih0x+C8MFJN2IHJRwMZETlCdMZgybM0x
        X02ChIhmKCvylm+PMME0NEyIN5BBb9v848UfVXAQsA==
X-Google-Smtp-Source: ACHHUZ7HNpOvB0FdI2cAa/Hk0BFIP//PIYaz0SF/x2yxS0dBusYtoqcXSr81Prhidgkp3dwlaGZQgYGxmxIthlDfeG8=
X-Received: by 2002:a0d:e84f:0:b0:55a:679f:1d90 with SMTP id
 r76-20020a0de84f000000b0055a679f1d90mr40987757ywe.2.1684306896118; Wed, 17
 May 2023 00:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230517061338.1081810-1-bagasdotme@gmail.com> <20230517061338.1081810-2-bagasdotme@gmail.com>
In-Reply-To: <20230517061338.1081810-2-bagasdotme@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 May 2023 09:01:25 +0200
Message-ID: <CACRpkda9q4WBNHFFR5w540SRUEOwrKNbRf_w2J_UJHts2EwVcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pcmcia: Convert dual GPL/MPL notice to SPDX license identifier
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Paolo Abeni <pabeni@redhat.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Pavel Machek <pavel@ucw.cz>, Kalle Valo <kvalo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        "John G . Dorsey" <john+@cs.cmu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 8:13=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:

> Replace license boilerplate for dual GPL 2.0/MPL 1.1 with corresponding
> SPDX license identifier.
>
> Cc: David A. Hinds <dahinds@users.sourceforge.net>
> Cc: John G. Dorsey <john+@cs.cmu.edu>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
