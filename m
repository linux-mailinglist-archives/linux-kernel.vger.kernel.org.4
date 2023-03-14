Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434D26B9CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCNRWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCNRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:22:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D773645D;
        Tue, 14 Mar 2023 10:22:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 133so43805qkh.8;
        Tue, 14 Mar 2023 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678814551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suEo5q4kBDDywmWFC0XZhac6bHzCgGm7WzrS+eIxQzA=;
        b=X8LuaWCi/cWCn/yhB5ScJGMvBRnfM0+Ub6iYLGHGnV94OovJiLjEQC7n426B13xuyQ
         yi3vyJiGj5rwxFDaZ8fgKHeQNjUC227GpXPiQ5Cmv1d4sFZMDHk/FvgQHD5Dv+HAWtLp
         kMLzT0XNkROfT/+3ff0h4th9Dwx+oHxEJC1GuYutIsW5yw6j8RP62TJSwqEWm4fYzBhj
         CF3Vl+2I7fm9zLMzfoTqLeXELKxsAx/BBfC95NrbKBvBZqHh29/7VA5D0z28lJK4BxIB
         adcvhyeoU/Xs9KLOI9Ul2AlkwccYiKQwCzqr9W3Ly/ixubYoTexjTUW+cdQobdhvWCeH
         uAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678814551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suEo5q4kBDDywmWFC0XZhac6bHzCgGm7WzrS+eIxQzA=;
        b=43SBC9fnOEZTHLkCHaZKKChFVYBu+V7dhYyb7Jx7BZWzt5wAZvBoNxM5F2FGjFv1da
         Nso6SgcSfaTxJ1NwjjKkUo6FJmxLQ/0mla//1qP+YNwBTLPDF3oZ3y2SulmMSMb3BPxO
         vBLTcIauYIcl9zHbKWgDDPI/tlRcPQ8Oo58/S/uEv3OjiqYZsikaPuvRZx/XIInsY9kc
         r4egTfhkJ47AUvH7ZWnUJP75hVKZiotj4SC1+3qmBuPUYv877VvyLfDOLjrAiIBxL1ET
         Pel2BCPHNBYKwM3BR3ODG1V8lQ8y/fuEwc0uVvH7Fo0Ueky9+n7ixBEhQNFK5V4wrAZl
         uxCw==
X-Gm-Message-State: AO0yUKUammmyc7ftoI/2ls4ZMjleest+VGtIQhN+Wx50A1uTGhBdjeKO
        1QZUmvxNJycZIEVn0rK9vxUXhGeG6UoE1bwtCfI=
X-Google-Smtp-Source: AK7set9phtGasDo2TuEdzNNmfyK0DFe73IrasByKBzcM2xELmwyqQdsCnTFNgda2x3qPRe+CtJYcaQ0cBgR5SL4Idkc=
X-Received: by 2002:a05:620a:d5a:b0:742:412d:1dc6 with SMTP id
 o26-20020a05620a0d5a00b00742412d1dc6mr4298690qkl.14.1678814550818; Tue, 14
 Mar 2023 10:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230314134642.21535-1-clin@suse.com>
In-Reply-To: <20230314134642.21535-1-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Mar 2023 19:21:55 +0200
Message-ID: <CAHp75Ve=U_rkgL6ohpy1r4RejXK-PqgrqfkPmCrhzK9O3necnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: s32: driver improvements and generic struct use
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
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

On Tue, Mar 14, 2023 at 3:46=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> Hello,
>
> This patch series contains some improvements for s32 pinctrl drivers sugg=
ested
> by upstream[1], such as
>
>   - Fix error shadowings and improve return value handlings.
>   - Fix print format.
>   - Remove unnecessary blanks.
>   - Use proper macros and helpers to simplify codes.
>   - Refactor config param parsing and remove config arguments that are ne=
ver used.
>   - Use generic struct pingroup and struct pinfunction to describe pin da=
ta.

Overall it looks not bad, thank you for doing this.
Individual patches have been reviewed and commented accordingly.

--=20
With Best Regards,
Andy Shevchenko
