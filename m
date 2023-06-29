Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75C1742BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjF2Se7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjF2SeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:34:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3C1988
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:33:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so3960215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688063630; x=1690655630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP5uBK62gMjC6rOkCCdZlOO2En6flGgqBqs4cAOdDzQ=;
        b=WWMQh1bqCQ7y6wYXZpyMPwHg++IgPNX2eOm0dO2tWkG0hZsR8LOYlLL+sf48crnIvF
         KJmrnzh8dI8CJcuPdp8gHstB8SmMiZcYd/Fj3lDT7PoX1U7eIp8HDI/3itvt6Fxg4BwI
         J/83rruGNCfzmPkaIQD9L02PqldSn/DgtylP4HX0GejHuQyZGBSUNx/d4nlDu4FzKn7t
         xo45eM60nPijWAzh+Ut+kuI89fwsVfRof5b+D5//1ys5q4d9k/LU6CD/Ao/HlBoej2FY
         Js/hynpHKk54icqcxy27C7AQ0S6wwZcHZBRJvvj95ye/kfQWaBXm7MttnMzchL2sq4KD
         qahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688063630; x=1690655630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP5uBK62gMjC6rOkCCdZlOO2En6flGgqBqs4cAOdDzQ=;
        b=Zf+AJ2Fgu8f1rC0MqYXrGTA3Zp/7D/joIHH+80Jw/VHjqgHZ2znc+8LsLNkac5uR9p
         9F3ipSFteWyqo7oJIZ4vI+mt5Tk3eUCkpjHH0yM2AIwj5G8g+grwq+gXfTeONIaDfRX7
         CaGFOFE+c7etu/r7gC6JpP9D2wyXO9UJ3dWb9+bxiDOc2gmy12fwMgopN7CSB22exUNk
         HlyD2E62i0XALWaxzsCtIaVyUmhRJYYB03V0ZhOSclVkpTlCiGqfcsYHFa568HMsCHE6
         eYCJ5ZZgpFommh/ukXCLSIkNHqLGzkRweR9jZqtGaWyk5UdlcCwwDyHDDSimHM/hUuD+
         m1MA==
X-Gm-Message-State: AC+VfDwv0iU30XqLksLo4HpZBQl+ikcBQMqj+KeNSoLBVQMdajyVgbre
        45wqKs57z4hd9zZIzaOO2kx49LAI53X85daKRTU=
X-Google-Smtp-Source: ACHHUZ60aeDsy5KSR1e0/2v8LN0ZxwtIIOWZuW6s+AXZjBYC+UX3ODxG5pBqwwAUvseXxzbKVsyrjX1qhBVDiZZ9mdw=
X-Received: by 2002:a7b:c847:0:b0:3fb:be07:5343 with SMTP id
 c7-20020a7bc847000000b003fbbe075343mr139733wml.27.1688063630144; Thu, 29 Jun
 2023 11:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230628112958.45374-1-dg573847474@gmail.com> <2a1220fc-777c-4611-9f75-3a8e07a04850@app.fastmail.com>
In-Reply-To: <2a1220fc-777c-4611-9f75-3a8e07a04850@app.fastmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Fri, 30 Jun 2023 02:33:38 +0800
Message-ID: <CAAo+4rWgg7ZCTt1K=sdTb6Nt1unKEP5e5rWMknS3=cebXP818w@mail.gmail.com>
Subject: Re: [PATCH v2] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
To:     Arnd Bergmann <arnd@arndb.de>, scott.branden@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The timer function does not seem to be performance critical at all,
> it might be nicer to just move it into process context using
> a delayed workqueue instead of a timer.

Thanks for the suggestion, new patch is sent with a delayed workqueue.

Best Regards,
Chengfeng

Arnd Bergmann <arnd@arndb.de> =E4=BA=8E2023=E5=B9=B46=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=B8=89 19:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 28, 2023, at 13:29, Chengfeng Ye wrote:
> > As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
> > context, other process context code should disable irq or bottom-half
> > before acquire the same lock, otherwise deadlock could happen if the
> > timer preempt the execution while the lock is held in process context
> > on the same CPU.
> >
> > Possible deadlock scenario
> > bcm_vk_open()
> >     -> bcm_vk_get_ctx()
> >     -> spin_lock(&vk->ctx_lock)
> >       <timer iterrupt>
> >       -> bcm_vk_hb_poll()
> >       -> bcm_vk_blk_drv_access()
> >       -> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)
> >
> > This flaw was found using an experimental static analysis tool we are
> > developing for irq-related deadlock, which reported the following
> > warning when analyzing the linux kernel 6.4-rc7 release.
>
> The timer function does not seem to be performance critical at all,
> it might be nicer to just move it into process context using
> a delayed workqueue instead of a timer.
>
>      Arnd
