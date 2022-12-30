Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47697659A35
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiL3Pvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3Pvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:51:44 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4615FC3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:51:44 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d127so18337552oif.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F656lMOposhMckkjCGjS5NjDE/VCVOvwvNVXUf+PeSw=;
        b=q9KhtncsHTQ9Ify6p0bGyTOm2n64gX0fIkSM54PoOaYAVYiU41+fYETKwn4vLgdfwC
         J4O9RXBDf6c3GiI1i9h0spItlYOh27mEv5S/DNZ+LgqIHKIUkEH/vSAJ3xS+CmSsayvw
         RxiJwj2cVg37rOYT0V55dMWnN5t5ttPqZ+pfvwss2ef/N9AOx99AZ6c9Tee3gtK9pKyv
         VUDviHy7ddITLAOWwEjABNcMzv//CFbTdAy50K2UCHGrcwYZ/B/jhxUaSu3Fyit03Sky
         pJ4z8wve+t/f60ws5M3PDyZiZNBYagSdTFnoQfUZCmwjhSo4Wbm8IsTtfMe/JPaFCQLC
         ITZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F656lMOposhMckkjCGjS5NjDE/VCVOvwvNVXUf+PeSw=;
        b=DbhwLL2ODQViFuKNDRKQgSkYWmTS5F6eK0XeKAgRfJ/q2/141nICqe/zYFPduZTzc1
         1ynjwKvhOmhedXgXIzpi2uVYkybKE14fpeYMl6TT4wzIVbGRclLESYFtZAQJp77J7i4I
         HmqJm/2C3wi7QAhtqwOIYJroOA2ETwJEH2aWyO1NRN2BSJhxiTwxA+I/xtwU6S7rasq0
         kQXK0Gu9t6w0G1mZYZJzt2hZk/AS3YgzEIB646Lb7Cle5COroVe6HRSbWkCx9xdVmshH
         GgirrbjhXVyT5sZaxw9y8eDGCbU+/66rPdjiiNqE0ymgYGd6zypEWp4NOnnk3C5ukZyK
         4MJg==
X-Gm-Message-State: AFqh2kpTZ3dFTxfK64rlQ/lTKHCf85SR83jtIg9hvyQ+rt5gTkDrexgc
        IsV7f9x/1H9t+9W5DmMDWzmdXQJgFGUIAKrIwAtFRw==
X-Google-Smtp-Source: AMrXdXuTY0+jFO1zHE2LSUiACUdxijn3DzB10hNf9rWgHZj3JVyKEaiK0B9P4P3EbIovcXxqRBz6EtbYJ67WUdY6TI8=
X-Received: by 2002:aca:3dd7:0:b0:35b:8358:aed4 with SMTP id
 k206-20020aca3dd7000000b0035b8358aed4mr1698246oia.291.1672415503475; Fri, 30
 Dec 2022 07:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20221230100044.23000-1-brgl@bgdev.pl>
In-Reply-To: <20221230100044.23000-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Dec 2022 16:51:31 +0100
Message-ID: <CACRpkdY72tihcurkf98pupYWiHOj0nCbX4uAp93KdG4xoscZ1Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca9570: rename platform_data to chip_data
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 11:00 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> By convention platform_data refers to structures passed to drivers by
> code that registers devices. When talking about model-specific data
> structures associated with OF compatibles, we usually call them chip_data.
>
> In order to avoid confusion rename all mentions of platform_data to
> chip_data.
>
> Fixes: fbb19fe17eae ("gpio: pca9570: add slg7xl45106 support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Yes this is more to the point.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
