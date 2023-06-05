Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94E97221D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjFEJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFEJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:16:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340CEDF;
        Mon,  5 Jun 2023 02:16:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75eb918116aso62112085a.3;
        Mon, 05 Jun 2023 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685956589; x=1688548589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WHls5vQFZx80W/l+gbncXvHnqH5QXt3iJI8lxFm3PY=;
        b=RvdmEXVrXmbQI2SNhDHXQn58R9uc/X1bJV3eGNsZOms4wgvJjzHPAwHnCifgJk/xoM
         LxccJgt+FkYAnCYsOBD4ElnbsfKlVBLcOqM3T9f1xNJ0DuENh2wU6itfZd119Abb3CpB
         Ap95gJxWDBNNgCS6lauQkBG1eCBMUlS6LfD1wUYnzP3/YqKhJc0vo3iaXPmVhtTsWQW6
         4fMjFcnvT1Lx/CJMaztpeFfta4GYC1ThHuDr8ks+tRSJsezRFeGb/w2DChVFkIev976Q
         5imGwEfqpQBCv6Ws0dTkAlL2z46acaBHCM8pc+8oZHq6/iqaRcrs2ds7yT2rUANVJAnG
         5NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685956589; x=1688548589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WHls5vQFZx80W/l+gbncXvHnqH5QXt3iJI8lxFm3PY=;
        b=EPiumvWzvHnunIF6db8j7F/4GWfgl1AYgXLsDHiEKY92Bm0Z5+oB0HWA7nm466J5vo
         bThMrcoAJFERwtSFPu+JD+hRg4OsWtvJNn+uXU4woUr60faCgTqOg/eiJbbBQgJHnxs4
         h4aOt74BDpn8pSriFBV8cDYJQewgRs0DFhfhwi0jtTeHyCvP+0qzlclA6+0GE2FU2YTg
         eXw4lCBJXr89W7Uc05na3+UqakgnpF+urhye+DTK5qvSXAFOSMR18nfcJQfcGxBnQ/Rt
         R0/lIHVOSUHJFvAshUM/A1EGsarh6udR/YwSh5xSUoL2KGexRvXA/sZJnA4lt2aMZ2LU
         UH/w==
X-Gm-Message-State: AC+VfDyObh3RN4xkBvwrd/A2ozrAi69kEDt1MBtdaM6b35HJiJkCTX1B
        ql8cPFOHrBo0sTCKSqHn/YjTA/tEJ4oP+/Gdt/E=
X-Google-Smtp-Source: ACHHUZ5kXZxKvvxXL3/TR98yQ+T0PWRC6NTnlWLGlp/Hz0N7wSOgU/8gUGP9yTCgRo1kncIYrxzV9T5ydQn55sjCmKs=
X-Received: by 2002:a05:620a:2702:b0:75e:c23f:82ee with SMTP id
 b2-20020a05620a270200b0075ec23f82eemr452792qkp.64.1685956589268; Mon, 05 Jun
 2023 02:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230605014850.9591-1-jiasheng@iscas.ac.cn> <CAHp75VdZct58EiLDL0ebCvcQBVMzuZxJZ8z=bs8D2UDaCsuo9A@mail.gmail.com>
In-Reply-To: <CAHp75VdZct58EiLDL0ebCvcQBVMzuZxJZ8z=bs8D2UDaCsuo9A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Jun 2023 12:15:53 +0300
Message-ID: <CAHp75VcO2LRFyZV0nsmMsPRHByStyQ5AzeWSM9S99Qh60=UHvQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sifive: Add missing check for platform_get_irq
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 5, 2023 at 12:13=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 5, 2023 at 4:49=E2=80=AFAM Jiasheng Jiang <jiasheng@iscas.ac.=
cn> wrote:
> >
> > Add the missing check for platform_get_irq() and return error code
> > if it fails.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Actually, the change is functional and now the wrong IRQ numbering in
the DT will fail the ->probe(). This needs an additional explanation
in the commit message why it's not a problem.

> > -       for (i =3D 0; i < ngpio; i++)
> > -               chip->irq_number[i] =3D platform_get_irq(pdev, i);
> > +       for (i =3D 0; i < ngpio; i++) {
> > +               ret =3D platform_get_irq(pdev, i);
> > +               if (ret < 0)
> > +                       return ret;
> > +               chip->irq_number[i] =3D ret;
> > +       }

--=20
With Best Regards,
Andy Shevchenko
