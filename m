Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127A2605937
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJTIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiJTIAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:00:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F1D748F7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:00:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w18so45419814ejq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+NnDDSUoFW1p/YYrT8o2AeBUy64LBLrL7TXVJeeJNsE=;
        b=gfr0OOmHN/gW3+VUUkPNe/rvNFvWe/J4sFvkKffbWA5/GqgpDet+i9JcOu2BgYUH7m
         XMd7ff8HCmtgLsp9eWw/fBmMwQV1CAZ20wlTwEEF4G3My0AShqzcjsKBVwjcst+B5YLk
         PjW62HVCCYc4hIRkke7Kjrkq6kxJrHs1/RwT+Wj+cpri1LPkQ2AlokEfELqfp7SbPoVt
         lyCPrxFNsa6CBSLg1l1ua0LxY9qI901W8XPqD8zx2SkE7y7izLcdWfzLThr1zry8i3fR
         F29uO/Af2cKghsHzOLsagW3Z2GErdjA+GmGWN63MQtkxdj6PwvLdKcceQyIi3usk8cDR
         nYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NnDDSUoFW1p/YYrT8o2AeBUy64LBLrL7TXVJeeJNsE=;
        b=2jlJBphR/fZtZu9wnTPECUP8QgFGfsWToqWfsOtPj3vqlXlcVQCMQkqOw5J73LGxgc
         CWhK59uRbtlgsAfh+Cn05nZdKfMI1OXwK/6UIaez1aI0p9sENWY5k9/D+soXNNVrD8Sc
         be0Fs4ZMlz/4UK//B9HUH7ujX2IGfhAsXQZN1pfOUvRLI+aGYvR497zsjvNRwzAl5WMN
         RQ9GpgBW7YgewylXlsjnkVOi2OhM1XYCu5mFfA7AwfTFglvefu2dzUHjC0PZZAL9bTYq
         wyFYyMKEAEhgLGU7Fax/5sDTwOUNYeQWYtFHnYR8Iv8FYUckPtW/aFRLjP53jr5eHe7c
         f11Q==
X-Gm-Message-State: ACrzQf3AXEqyyPFUwkbMmag03gbBLkgdxuBTD3KgiJswiO8EtZ35RwdQ
        KVvY1iAYCYozOcP0LDgsM+hAyM1C8Rmr8sHABItj0w==
X-Google-Smtp-Source: AMsMyM5+Lku99gTMJI4bG6h/y7MjMSoqz4+WMa283TgV9DaUiQdCWvkKvZptj29nYoZKCK1khdCO9NPvJqUu05LPkgg=
X-Received: by 2002:a17:907:7606:b0:78e:61d:757e with SMTP id
 jx6-20020a170907760600b0078e061d757emr9365136ejc.690.1666252812748; Thu, 20
 Oct 2022 01:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
 <Y06cvrpcHn0jwZxU@smile.fi.intel.com> <CACRpkdZZZp5Li7OSybv8F7a8F5iik_gRumwR__BAwpWddfctxQ@mail.gmail.com>
 <Y0/cot711ad/hG/o@smile.fi.intel.com>
In-Reply-To: <Y0/cot711ad/hG/o@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Oct 2022 10:00:01 +0200
Message-ID: <CACRpkda_BbpNa+OLz=9vYuMbBNyWi4RBfoDS8F_gtc+vP_Fgyg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpiolib: more quirks to handle legacy names
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 1:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Oct 19, 2022 at 12:56:31PM +0200, Linus Walleij wrote:
> > On Tue, Oct 18, 2022 at 2:32 PM Andy Shevchenko

> > > I was wondering if we can use the approach that ACPI chose for itself,
> > > i.e.  the separate data that can be filled by the corresponding driver
> > > and then GPIO OF common code may use it. In that case each driver knows
> > > the exact list of compatible strings and associated quirks.
> >
> > I actually deliverately chose the other way around, to centralize all quirks,
> > so that drivers look nice and simple and the ugly historical errors of the
> > device tree be hidden away in gpiolib-of.c.
>
> This makes sense if and only if we may guarantee no quirks will appear in the
> future. So, it may be true for DT, but I'm quite skeptical about ACPI...

Right, the idea is to stop more idiomatic DT bindings from coming into existance
by review and formal verification of the reviewed bindings by using
YAML schemas.

ACPI is somewhat lacking public review of "bindings" and DSDT tables, and I
don't know if there is some counterpart to the schema validation, so that
makes for more new bugs. But maybe ACPI has some tricks up its sleeve that I
don't know about. To me it seems like bugs in ACPI are discovered by developers
after the devices are already produced :/

There are bindings and device trees which lack public review too, most notably
Apple Mac, so especially for them we are redefining new bindings and
who knows, maybe Apple will pick them up eventually!

Yours,
Linus Walleij
