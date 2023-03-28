Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDE6CCB76
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjC1UZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC1UZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:25:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1E10E9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:25:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id er13so13657913edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680035154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkSy08zqM2zZxZOkgvIi8R7ExZAWcEvUoUyAS1rq5JQ=;
        b=Um4uOHv/S1TSdbjkUeCbMtfNzZZFRXj5Q9VfxhZyXta/iNIBUWXaPV4il8S8bQw4OS
         szNrHMqkFdypw/JzinGECZCCQTZ+DXhE1kEQrxnLgIZ30CN0p6tfhBFjanxpXzikiiHe
         iU9eXyAI+pjn+kvL00reGFwH02OpXfaAPsPG5e3AivhCghe8QMRsrUV7rs+zVv/ds4Xl
         kd37qn8YQdB8+TkMVC1KPmQDWcyoTqFUBhaIUiGNbCyzqmogC4xO0KmPFFguK6Jooj9m
         V9gwuEqCzeCQaAyMo6WC149qoIsKQM+cFW+3dT81hwQ6izVoM+GUUR2YnPNEQ3vvtKSU
         rIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680035154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkSy08zqM2zZxZOkgvIi8R7ExZAWcEvUoUyAS1rq5JQ=;
        b=h1a7WWTb8O/8/8eJCJm6/KPGBbC1iwTqnnj4v/XiN34SJrXoAw3CJ1eBoAZnH447KL
         yGTrXC+Zwit3x9qyXRb3wBgnJMJfhV2UW4ja4CcdEb3QF9IK7nMLc6SgfUMcFJiaT7zG
         g2TadFRzrqoO0AzUzH6AuLce6hTwL9OhQxOSBVM9tEcns40q+de0OEaOcK5HT8sBL37T
         uc7uDTVN+z3mRFddRBNMrBiGJgg7/7tWSfbc06ZYOWcFar+/bU9bj7jYgaKxJxWIsedm
         h9eLWLfRB33ALBqjeYAYAPLGeBia+3p8w8JYK7Ri1XC0Geart77xdlTo0QXXUwR/XOhN
         DDVg==
X-Gm-Message-State: AAQBX9eTH9sHxazyKLaLGh4Jt+epQAk4qb8RTKJtufCfVUNAHkIQlM6c
        bznjeu4UWdGzUJsh5ly8UqK4I6YiWLNAza/OYV0=
X-Google-Smtp-Source: AKy350ZF5kb7lMfzE9/11IZUnbilw2ckELhzoAd91nvfhFzqEdjkUvnL+UvHXZHo2AZ2x4gf242lYLuUFVzsXNPmAu0=
X-Received: by 2002:a50:c055:0:b0:502:227a:d0dc with SMTP id
 u21-20020a50c055000000b00502227ad0dcmr7794046edd.4.1680035154468; Tue, 28 Mar
 2023 13:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
 <CAFBinCB3yuyNJD=7UJ7jzf45Masms_PD4sm42YNjO8M4cr+4wg@mail.gmail.com>
 <fe2ed378-cdac-dbb3-acd2-ff542bd7e887@sberdevices.ru> <81632eee-533e-5e44-1520-5321a06c6797@sberdevices.ru>
 <20230328185001.5661132b@xps-13> <e8edcbc8-5c72-b29e-21d7-6f4438391924@sberdevices.ru>
In-Reply-To: <e8edcbc8-5c72-b29e-21d7-6f4438391924@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 28 Mar 2023 22:25:43 +0200
Message-ID: <CAFBinCCCNYJV4RBbM78r3yGPnY4oNKySEFRkzBgUD3xYJGkJmw@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in command word
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On Tue, Mar 28, 2023 at 8:39=E2=80=AFPM Arseniy Krasnov
<avkrasnov@sberdevices.ru> wrote:
[...]
> >
> > By the way any reason not to have Cc'ed stable?
>
> Sorry, what do You mean? I've included linux-mtd mailing lists, there is
> one more list for mtd reviews? I will appreciate if You can point me
"stable" typically refers to the stable tree where fixes for already
released kernel versions are maintained.
When Miquel applies the patch it will either land in the next -rc of
the current development cycle (typically applies to fixes - currently
6.3-rc5) or -rc1 of the next kernel version (typically applies to new
features, cleanups, etc. - currently 6.4-rc1).

Let's say you are fixing a bug now but want the fix to be included in
6.1 LTS (long term stable) or other stable release.
In this case it's recommended to Cc the maintainers of the stable
trees as part of your patch, see [0].
That way once the commit with your fix hits Linus Torvalds linux tree
it will be backported by the stable team within a few days (assuming
of course that the patch applies cleanly to older versions, if not
they're notifying you).
Note: even without Cc'ing the stable maintainers your commit may be
backported (semi-automatically) if it has a Fixes tag and the stable
maintainers find your commit. But my understanding is that it's
easiest for them if they're explicitly Cc'ed on the patch.

I hope this makes sense. If not: don't hesitate to ask.


Best regards,
Martin


[0] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-rules.html#=
option-1
