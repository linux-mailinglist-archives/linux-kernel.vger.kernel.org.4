Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCE470FEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjEXT6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjEXT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:58:33 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD6199;
        Wed, 24 May 2023 12:58:19 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75b08ceddd1so19101485a.1;
        Wed, 24 May 2023 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684958298; x=1687550298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVXrSa9eps6197mlhDW0wlvhygfqywDXFbK8GDGZ+pM=;
        b=dfMXzQ7D7gXj0Wg/xJwb7g6XusaR2UShrQkjH9QTED5eN/ocr/Wt31vUZXzr2MTnrH
         KVA5Qk/SVBX8Cirt0GlaNW/W8N9H/IHjoNnbCOZHYAjg2B1+r//1ykdVJKWMVM4kW2Ir
         zoTV1CNMxlC20v74mkAph3q3+ErWDSsWmuzE++sfdd4zz6UpHTtl6XI1cPz+ZviBJ1GY
         l//Q3ZZPx2vfURG+txB/pyif4pgZBVT0l141HD04nP/f0LbphI+6CU1f/kDb5T82ANho
         9wSoN7DSK60mRnictRdNdMC9w18eC/EEOJr3A4SA4PgBhc2vWcLnalYDmbaZ3vujeyfD
         sc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684958298; x=1687550298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVXrSa9eps6197mlhDW0wlvhygfqywDXFbK8GDGZ+pM=;
        b=Iq9Aj/q3+oiO7fB8p2Qk6wS9nXI5vv9H6f20oN+hYVCjsYHAmRNPLjYzCmicclPrkx
         93V7cchYy4JKBmXdd361KVEr0sYY92UK4Nj46+k3BysFIcKWTDl9iE9+JGQSJgdcnfKd
         eWhTDDW4mzKVt5KfgZ6PI8C6SoVThWo89NtUlV7cOiSA3XgWZBl6TYhu2emWhdYuTuLo
         g/hqJt7gCaP0rtFKMzXgtxoFh5NuF0E3yvOEs6epqqHvAc6m+zufArcg7xF1/UYOCLFc
         TCSU+9S2ERCA0BSmqryxP60UPimflzJDWZ2Tb9POim6Nxylg2khsHDj98ucciOoI5snz
         9Sjg==
X-Gm-Message-State: AC+VfDw+FoP9CsvRWnWFqkb9XInYvz5O2u5EEE8Iu4oLuz1oy+SwekSS
        AIN35NJAVbhDPTotE0R32sAcAtBmrsNZJh0TkhEVxFUS98SbeA==
X-Google-Smtp-Source: ACHHUZ4UWO8rC8EKL1W4HzHcpgfDIFX1Cv2ogk0iDhfD0sUuP+4RLj8VpP7+4HLnuo6YqJngGf9x5MfkTqbb3zXJqIE=
X-Received: by 2002:a05:6214:d02:b0:61b:5afc:d4be with SMTP id
 2-20020a0562140d0200b0061b5afcd4bemr31110518qvh.7.1684958298520; Wed, 24 May
 2023 12:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-3-mario.limonciello@amd.com> <ZGzwCdTO2LptPeQs@surfacebook>
 <CAJZ5v0hO4hq=TLZ=tK5vXv_pA4SsAo5Gqr5K9g=EU6bFRPYU6g@mail.gmail.com>
In-Reply-To: <CAJZ5v0hO4hq=TLZ=tK5vXv_pA4SsAo5Gqr5K9g=EU6bFRPYU6g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 May 2023 22:57:42 +0300
Message-ID: <CAHp75Vf-0ap+hSeTFUFqaTNsH2+dEodd=E3xPnfRmvMNewfMxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging messages
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 9:28=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> On Tue, May 23, 2023 at 6:55=E2=80=AFPM <andy.shevchenko@gmail.com> wrote=
:
> > Mon, May 22, 2023 at 03:00:32PM -0500, Mario Limonciello kirjoitti:

...

> > > -                             dev_dbg(&gpio_dev->pdev->dev,
> > > -                                     "GPIO %d is active: 0x%x",
> > > -                                     irqnr + i, regval);
> > > +                             pm_pr_dbg("GPIO %d is active: 0x%x",
> > > +                                       irqnr + i, regval);
> >
> > Regression 1: The device is now omitted from the output.
>
> Right.
>
> > Regression 2: See https://stackoverflow.com/a/43957671/2511795
>
> Care to elaborate?  I'm not sure what you mean exactly.

dev_dbg has 3 cases how it prints its content:
1/ With dynamic debug when it's enabled.
2/ With -DDEBUG if it's defined for the certain file(s) in the Makefile.
3/ No print.

pm_pr_dbg relies on CONFIG_PM_SLEEP_DEBUG, pm_debug_messages_on and
not on -DDEBUG. I haven't checked all relations between those 3, but
it seems to me that DEBUG is not equivalent to the others.
CONFIG_PM_SLEEP_DEBUG=3Dn prevents printing with the dynamic debug on.

OTOH I dunno how this is relevant to the functionality of the driver
in question. Maybe it's okay to have such changes.

--=20
With Best Regards,
Andy Shevchenko
