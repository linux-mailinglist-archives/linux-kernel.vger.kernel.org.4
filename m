Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4C60C5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiJYH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJYH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:59:13 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C1169139
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:59:12 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id p4so5666662uao.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=POiVnTiHc9X7N8hVY0cMXv0XUMTtBCC7disU+JLan4o=;
        b=sS4vNS0n1ObcoSX1KrgOv7kqsWOP8qqKvvcpDhyYdEp8fLnwQk2BxRvLpU7gzmmSc+
         hZx14gwuF+DjP2BfMkdMPQC9FctQS/E4a4QpvWHtf7zSpLZRzE0bgkdYb+BPSRUfimrO
         0Lnwf9q7gRvDNwoB7G6D6Zd2To+IEwG4bskYtTweJe7o8faaXQ+eVuzMFrApoZnomtVi
         EcDbaMXi+5Erhwfz8VraQR1rt8UqUFqVWNtWn2hEqkkAC6ORUA+YGkJL29PpDNCaen49
         CDc8Snlr9b+9GgPoqvgvdbTni7Z370zMJGbzZOV52Ej5GC3M+aMywQzU1pWXKfRl71TB
         6kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POiVnTiHc9X7N8hVY0cMXv0XUMTtBCC7disU+JLan4o=;
        b=xFy8AWVjwRQjP2eONRTHxb4ViVUsJ/4pysOrscjCXJGNeHkORcFw4MtBNkeEND48Oc
         AreAXXPAoPeMgoHe56j5yNBzGpRs7bXpbQ0fpTNi5pXeY+H7Zpk+CaBjelZG6JBoM5am
         L2rN9rdUz3Qu8dmr3RhsqcafNNkdNRcMhoy/ck6GgnnoJVgQfr9+TKNPkIFsg5K9sGSa
         baEDYmgniQD6fxaHz/gOkfWcgHblPpwUVOPHN0IX3ZDvk8in+wJo4RLVT/TMcAA/It+E
         jCWOgSUAUUtfuKSGYxqLvWlJrHQ85efP8tYW+rKb4IsMrHVdU0NmZHIr0y2FhtEqW9vL
         trKA==
X-Gm-Message-State: ACrzQf1gndM69hdZkv1kcD8yB5Ck5qGzCb3FWB2OUmFMScXct3gtR2wn
        gILDTqhobwLK4StHs5L80Dw5+puAYQpa7WxY/cdZ4/FerL8=
X-Google-Smtp-Source: AMsMyM5WwZ0JIsztOelDmz8zAJdIn11gPe0cVi3leN/2y6zZsXO+tB7iaGPpdgiVrkADj0KBOSHP8A6BaA12AQ+FvzA=
X-Received: by 2002:ab0:2155:0:b0:3e2:bdc:cfa5 with SMTP id
 t21-20020ab02155000000b003e20bdccfa5mr21311272ual.119.1666684751678; Tue, 25
 Oct 2022 00:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663519546.git.william.gray@linaro.org> <80c7fa6ca523b8a62f70aae8758fdf89771b742e.1663519546.git.william.gray@linaro.org>
In-Reply-To: <80c7fa6ca523b8a62f70aae8758fdf89771b742e.1663519546.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Oct 2022 09:59:00 +0200
Message-ID: <CAMRc=Mc-8W3gW-sXu1NwJ6+QqnbgEDH8Cwf56U3RRmrfZSLfVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio: idio-16: Introduce the ACCES IDIO-16 GPIO
 library module
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 9:54 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Exposes consumer library functions to facilitate communication with
> devices within the ACCES IDIO-16 family such as the 104-IDIO-16 and
> the PCI-IDIO-16.
>
> A CONFIG_GPIO_IDIO_16 Kconfig option is introduced by this patch.
> Modules wanting access to these idio-16 library functions should select
> this Kconfig option and import the GPIO_IDIO_16 symbol namespace.
>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---

Queued, thanks!

Bart
