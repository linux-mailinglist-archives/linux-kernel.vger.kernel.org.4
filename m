Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F55F3D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJDHRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJDHRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:17:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8980846878
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:17:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hy2so26874457ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FgVeTPqRw4B3XAH2kYr+aPe2b3d0JKi9DV9fMipPoGo=;
        b=ey5bCSZ3PQTUCb+QiKsru+2J4XcK5RXGNjM47DG7oFIJNfIyH+Y8t1kwhXTWF/MhAm
         CTIKcCwkCZmWoJimjMRO+exYfN22e18PScPPI0eTj7mHIO7m2Cl09sXvv1pceptE1Rfa
         9I4pxv+cfVK/4LSBOmJ0bJbrG+BE7iSLFe2bX8V4ZMUJSajsFJAdDtd6C/L2PhN8+lZi
         9CgHnje7bw0znV/nNxmxhItNAWce3myzuue1lTCtA6nfc6L+GKR9TYtmSeDPLZeS1YnH
         JB2QsCG2+EMmycw1/leJMg/k2BBPJnW6xfX6amPFFrIHdhaohfHz/WrVKjzmuaoBD0Gz
         CcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FgVeTPqRw4B3XAH2kYr+aPe2b3d0JKi9DV9fMipPoGo=;
        b=yj+Mq9W7fDl1vDKWl+kgiE8JrYTUJIoF1CB8HotZRSkR34ePq2vZEqHj3F9ibiNFn+
         NQEbnjkf/46vmnFYAnJN74B2HvSFUvCM4DQgdLIKQJEUwPLvP1+iqigg2BL+FHG5K6yC
         6chlXo4S0FghPu1/WWJTCGsQxSMotwuzKlQk2Fdrz/D/z4Nr63TyhZUiLf9s82zBkCL2
         GELvQOyOD7Teo6adsgo5T4vV780nzUqB9fTNH29etkj5kn4kgDoMdDIBHvjfiUjj04tF
         5NDQsAjmxGnQrOI5sPrfi2nSHmkgRaLF5ur3FyEwPcZRHHYFkITjoRomhtz22nNKqepE
         sedA==
X-Gm-Message-State: ACrzQf1U6aefd/4UDXPStqV/8s2ZjIcNGwSMYA6LvecL/99sbpL78W72
        /5sqW1REn+Wo938gQvkvhBSS9oO2zto6XjDf0ejudbF+Xv0=
X-Google-Smtp-Source: AMsMyM7hSdj1S8kUyJJWdUvxk28dwWUaTuGGEOV58h89seD4YZSGchbmCIbbYfpHrcsoW+BONxwNGvucF9EZLaEysWI=
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id
 k16-20020aa7c050000000b004534427a947mr22205982edo.172.1664867819366; Tue, 04
 Oct 2022 00:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-16-jay.xu@rock-chips.com>
 <CACRpkdb0wysqkSST7Qv+yy8g53oTpYWvbSqxLk6EVMEABQW4iA@mail.gmail.com>
In-Reply-To: <CACRpkdb0wysqkSST7Qv+yy8g53oTpYWvbSqxLk6EVMEABQW4iA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 09:16:48 +0200
Message-ID: <CACRpkdbgi1XZq=Nmeum=2Fvv68pxj=66nseAiv5HpVOsnMfx_A@mail.gmail.com>
Subject: Re: [PATCH 15/20] gpio/rockchip: disable and put clocks when gpiolib
 register failed
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     heiko@sntech.de, brgl@bgdev.pl, andriy.shevchenko@linux.intel.com,
        robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 9:16 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:
>
> > When gpiolib register failed, the clocks should be disabled and put.
> >
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> (...)
> > +err_put_clk:
> > +       clk_put(bank->clk);
> > +       clk_put(bank->db_clk);
> > +       clk_disable_unprepare(bank->clk);
> > +       clk_disable_unprepare(bank->db_clk);
>
> Always clk_disable_unprepare() before clk_put().
>
> I think you can drop clk_put() if you switch to devres dev_clk_get()
> instead.

devm_clk_get() I mean.

Yours,
Linus Walleij
