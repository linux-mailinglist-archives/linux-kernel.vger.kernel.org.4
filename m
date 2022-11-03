Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A24617B23
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKCKzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiKCKzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:55:09 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7A11172;
        Thu,  3 Nov 2022 03:55:01 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e15so955154qts.1;
        Thu, 03 Nov 2022 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxCfvK9F2HThh2W2Xp3je+aG6Hjdmf1tZ0bHKXB3Kes=;
        b=cl5jX+mpkbBsC/BK8H1TagMbrvQqLrh96Jj+Zrw1zmpLEfzQvojfxWxdfXDLgRcv5I
         MFnQ82NOWLxqGaPh8I/v3thVDCGmjC0lICIb0V7XNdGUx0p1bY1JRirzuN44E59kL92x
         HVWCzxhRlutrZlrMcFLtDxMuPOhiJJdDYluVtZ8UV1X9hBcf3Um9jl2Lshn+aL/c0rPI
         t6ezk35AHLA8lAo9MOlKMFUpwo4rDG71CjapUdECSQDS+EdC9/k/BbAu5Y4Fi+WLDpBO
         iUXtwfannQhJEMH1QXsyHH8FCl51FvKeIHtSPOqRncMwRX5PD3I735TuDGe31wur6GPM
         0/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxCfvK9F2HThh2W2Xp3je+aG6Hjdmf1tZ0bHKXB3Kes=;
        b=yeeXckbVMFjLHcS6/K1BL2c8IQrE1Au/FxtrirsJX305q01xystIdH4nPKGK0TCIMs
         RfSZQInMn7ZAMRh9qpUf1apBKAbUxrPorAOJcCpDZWxYHqubtxClpK+i70ONWlPnC/qy
         efS3ZfEy3R4qwEF+FKmb2N5TghsU1TCdOiQrdbWfhwok2KlBmhWP7Ns4SpAEhpM3mmxX
         VJnuh/WTlqKk8RDuJeq96+fQQt4uJ5s8f1yZDGXa2IfDtldROrWhXRp1BKKpQyWNUFsS
         dy6x+rJOQzqhaWMWBipgcVOzcCLJm6etGUUHhIma8b2vVwTawY0vGnLVUGB+MVi3BmDp
         Txdg==
X-Gm-Message-State: ACrzQf3K570i5WSuXkofCN8G/gicfIkYzLuZ1FBlaIREvlkquDZuo5KO
        sZguYrR/4ehgX+waraQQ7sse6M1JcE7cDNOxNVRUtk/CRJMhNudZ
X-Google-Smtp-Source: AMsMyM7T54w+5Irb0QStrHCnYXmnkwvVqdeMy6UQV0NjN3Om8lGlCy9go33LOKO0WGsNQKx1AIs5J6Zfqk5mr3Ub1oo=
X-Received: by 2002:ac8:5751:0:b0:39c:b848:198f with SMTP id
 17-20020ac85751000000b0039cb848198fmr23931962qtx.429.1667472900226; Thu, 03
 Nov 2022 03:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221102152915.22995-1-andriy.shevchenko@linux.intel.com> <Y2NtQgRwkUlU5bMw@black.fi.intel.com>
In-Reply-To: <Y2NtQgRwkUlU5bMw@black.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Nov 2022 12:54:23 +0200
Message-ID: <CAHp75Vd520HKL8_JQrDr7JBEVf1rDzJC=T=mceZvovq8AwrUVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: intel: Use temporary variable for struct device
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
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

On Thu, Nov 3, 2022 at 9:26 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Nov 02, 2022 at 05:29:14PM +0200, Andy Shevchenko wrote:
> > Use temporary variable for struct device to make code neater.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pinctrl/intel/pinctrl-intel.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> > index fe5bf2184cbf..e15629348cb5 100644
> > --- a/drivers/pinctrl/intel/pinctrl-intel.c
> > +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> > @@ -1522,14 +1522,15 @@ static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
> >  int intel_pinctrl_probe(struct platform_device *pdev,
> >                       const struct intel_pinctrl_soc_data *soc_data)
> >  {
> > +     struct device *dev = &pdev->dev;
> >       struct intel_pinctrl *pctrl;
> >       int i, ret, irq;
> >
> > -     pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
> > +     pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
>
> IMHO &pdev->dev is neater and saves an extra line. I would agree if this
> would be something like &foo->bar->baz->dev but it is not.

I have no strong opinion, but one thing which may play in favour of
the patches is that all other drivers, that have their custom
->probe() implemented, are using temporary variable. That said, let's
consider this as unification among Intel pin control drivers.

> Anyway, no feelings about this so feel free to add,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> for both patches.

Thank you!

-- 
With Best Regards,
Andy Shevchenko
