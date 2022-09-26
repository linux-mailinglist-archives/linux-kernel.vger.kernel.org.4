Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B85E9E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiIZJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiIZJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:50:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F126A20F6E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:50:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s14so9411377wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=slUfOYuDocHXvoiOKi/PLZKBwEeaKg4fvimUypzpNFE=;
        b=AAtKLaqaduwHpH1pwz7t0Sfn9uoftCpSiLLB/YNkmg6AC67wwx2f7aMNxyF6td21Ym
         LqPco5+Rmt/vu+4i/CzlJg3wRR0FbGwAtCi1AcWW3wEfptYDNfnh/pxrO+S9f3I6eFLQ
         Pm63nPEJrkayrBJW29EfJH7lYSnNJwNqth3lL5PV5HdFto59L2Ye05tjOX3WsOUd+HV5
         LIcXG8tjrIy3jx7+GGFuAtwQSw/wLW6v8UGMGBgTEZQxTwESEaSecYbrOUXtZsE7KHzl
         dteSU0AOzKz9C6UFzrZARYxpYhyRdC4IGj6bNyIUmkylMEj1XpMo5YRgtPvOhBy46wWB
         rU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=slUfOYuDocHXvoiOKi/PLZKBwEeaKg4fvimUypzpNFE=;
        b=xwSU73SIAXc405YEiuuMjhPZJ/IZJFgz8S2eSYYUr3fQ9Ph9sSrV4OmxOBTplDR0KX
         7lUU2NY0nYngG7lKioU2Dw1Jf7ki7T+MJ4ABPIMVtIo2sR3ZHYpV1pXqTJxZw6DvVPki
         +0yV5oshvFHLPTSNMl/Oiy0PAt+a4qz/o31+tq6mOvYNb2qpF0Q8WehqVzxAFxfDNzwc
         0BETOrDoYfAMD65xI0M6VUYngDeS91WUEXbmfwSzUDf65bY+EoPioyD0ni1bGMg6Y8Cs
         E3vO4gfGXi9c70j00P6plj7Uh8HIZpc5EhaSFb3K+xj62Rb00seGkAeszwM9i4jLwEo+
         g3VQ==
X-Gm-Message-State: ACrzQf2rxlpwjwDgduqU72bHCG01vKtlHhRc3+j/1Qi930O7MUxLnbFz
        HL4Wp7hzmu1q3FftB3tXOsy6QRegV/LwFKPNYQ5cvg==
X-Google-Smtp-Source: AMsMyM5GlZ0aGJWvUwmmBD4y46JOQLVvPJm4IGbwzlkXd6lPNuIP64Zfl5MKr7fv97hNwz39zS437aoILdnUMGTun3M=
X-Received: by 2002:a5d:6c6f:0:b0:22a:7778:6ea2 with SMTP id
 r15-20020a5d6c6f000000b0022a77786ea2mr13176073wrz.15.1664185807520; Mon, 26
 Sep 2022 02:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <12079576.O9o76ZdvQC@kreacher> <CAPDyKFpVMnxCd9bMg=Wd7_TpSsNM6699NG0QLz8q=KWXk9G9hw@mail.gmail.com>
 <CAJZ5v0h5atuB5mdedfste5EiZKRFgz+7QGQUgWs+=sme4EKbig@mail.gmail.com>
In-Reply-To: <CAJZ5v0h5atuB5mdedfste5EiZKRFgz+7QGQUgWs+=sme4EKbig@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Sep 2022 11:49:30 +0200
Message-ID: <CAPDyKFpHJf5KPWn4jke+xBKxD-Z7m1T=dQJyj6qQr2NVVO0e2Q@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Return -EINPROGRESS from rpm_resume() in the
 RPM_NOWAIT case
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sept 2022 at 17:53, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Sep 23, 2022 at 3:26 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 22 Sept 2022 at 20:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The prospective callers of rpm_resume() passing RPM_NOWAIT to it may
> > > be confused when it returns 0 without actually resuming the device
> > > which may happen if the device is suspending at the given time and it
> > > will only resume when the suspend in progress has completed.  To avoid
> > > that confusion, return -EINPROGRESS from rpm_resume() in that case.
> > >
> > > Since none of the current callers passing RPM_NOWAIT to rpm_resume()
> > > check its return value, this change has no functional impact.
> >
> > Sounds like there are additional improvements that can be made around
> > this, right?
>
> This allows RPM_NOWAIT to be used in places where the caller doesn't
> want to wait, because it might deadlock or similar, but they still
> need to know whether or not the device can be accessed safely.
>
> Or do you mean something else?

Nope, I was mostly wondering if you are planning to make those
improvements too. Sooner or later.

[...]

Kind regards
Uffe
