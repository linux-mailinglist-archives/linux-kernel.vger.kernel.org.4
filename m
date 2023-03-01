Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2B6A7622
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCAVZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCAVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:25:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0826515D7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:25:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id oj5so10771585pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677705950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfDKxSNXUZkyr9HPYqhhs/0ANtQuBaTHkbXalVBy5zk=;
        b=UNGsJ3biOKSzh4RkNSFGw9vcwiKQpSji4f8sFivPMkcAccNzJr/fls/Y8X4hOX8Pce
         7S156qAgFm+qrhwcB8sKV5XDzlbkBGDYicDP+vAkdTcJP6cZCzeWrZmeLQjN47nc8y03
         gljP0LTitATXr04lm/ypv09bUdJIZQbfok13rUfQtvD7trvQ5iGqHns6Ja4HY5JePA0T
         R5FEsUB5sDbiG+m0gQtpP7Sc3tvqV+byjuHnx1PEQ+b2VJMm7qU1yLMNonjU6AmgjFuf
         Bmkb2i2wikqRjC8XXuQ8ieo2csFBsxqSnZ/CpRjFcXT7yekWjF1zmo+JW6Kne9GRhLLs
         s8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677705950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfDKxSNXUZkyr9HPYqhhs/0ANtQuBaTHkbXalVBy5zk=;
        b=XtcCQky6M7Ln5syRp0Rx9Bic8qZi3AToeUPS1jwnOEuanaxYaQXer1yzxWw8od1tlK
         zKdhHnRmGsaBbLwpPpQ2Odz7IRV/yLd1rHP4vy/tvI6gpiaCAUrz/D5ss7LtZGB+IYfr
         E/aiaL96uSywj/4PTjC3qNScbFVQeytix7AQ+yqLG3XfuJOY+5bCckZ41vA78PLrByAt
         ipp7LCNix1PZtYl3ApIlHHsJDbDBhuc5r/uDMJfz9cnyleVvSDHoGIZwUV2KNL/CiQGK
         KCj5zwWmQ57ruVXrO+42abwF42TonOL6QN5yiI5bOKyHcYMPuUwL8Dc7JWc3AZ0TKkrz
         dgaw==
X-Gm-Message-State: AO0yUKUIIMpW6SIPL+c1l1WyW7GdhAO0cRmFO2OU5XjbzBg/BJxIGiXn
        kXo2rd/zycasWv7CQSs35GRkXvkdiccZfwBzF1XalA==
X-Google-Smtp-Source: AK7set8JQ40suSmwkx15PVX6UZ1AsVJmYZ4GetG+ODueLpuC0f3mO9pZzDoFq5Kx5Y1JyJlY4nvKWZ0FKjAVzqseTgc=
X-Received: by 2002:a17:90a:39c8:b0:233:cc2c:7dae with SMTP id
 k8-20020a17090a39c800b00233cc2c7daemr3061292pjf.8.1677705950059; Wed, 01 Mar
 2023 13:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20230301012506.1401883-1-saravanak@google.com>
 <31ae9957edf319416d4551f14eba2071.sboyd@kernel.org> <7cca9a24b24d849565cd6a4f40ddbee9.sboyd@kernel.org>
In-Reply-To: <7cca9a24b24d849565cd6a4f40ddbee9.sboyd@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Mar 2023 13:25:13 -0800
Message-ID: <CAGETcx82r-YC7cBUY5xa57FCEOUP_BeGNp2zURG=HUJkUMSVPA@mail.gmail.com>
Subject: Re: [PATCH v1] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE* macros
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 12:48=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Stephen Boyd (2023-03-01 12:40:03)
> > Quoting Saravana Kannan (2023-02-28 17:25:06)
> > > The CLK_OF_DECLARE macros sometimes prevent the creation of struct
> > > devices for the device node being handled. It does this by
> > > setting/clearing OF_POPULATED flag. This can block the probing of som=
e
> > > devices because fw_devlink will block the consumers of this node till=
 a
> > > struct device is created and probed.
> >
> > Why can't you use CLK_OF_DECLARE_DRIVER()?
>
> Ah I misunderstood. CLK_OF_DECLARE() _always_ prevents the creation of a
> struct device for the device node being handled. The 'sometimes' threw
> me off.

The "sometimes" is because dependending on the macro we go back and
clear the flag.

> >
> > >
> > > Set the appropriate fwnode flags when these device nodes are initiali=
zed
> > > by the clock framework and when OF_POPULATED flag is set/cleared. Thi=
s
> > > will allow fw_devlink to handle the dependencies correctly.
>
> How is this different from commit 3c9ea42802a1 ("clk: Mark fwnodes when
> their clock provider is added/removed")? Do you have some user of
> CLK_OF_DECLARE() that isn't registering an OF clk provider?

So it looks like drivers don't always register the same node used for
CLK_OF_DECLARE() as the clock provider. So, this is covering for the
case when that's not true.

-Saravana
