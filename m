Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EC691C87
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjBJKPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjBJKPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:15:53 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540B319F1F;
        Fri, 10 Feb 2023 02:15:52 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id nd22so634047qvb.1;
        Fri, 10 Feb 2023 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YFIfsQQ5E9NpYa6J4Rd4ZByYS+XGHx8OIAC6z+bB9Nc=;
        b=JNhzyVETkA1NlKAJuW9inhikCXZQKAMKeU3vDPtCZCHWyCwOnnjSnS+rVsshh1fefd
         FWEMnpYeaVVl4SeXjmX4lT72jHZ6rihoczfTUTCV8so2oCqZ/Q+CtZyH44RATfOByuly
         bN9PS/HBIC8VsFQU5LxwZhmnzWYT4A0Hstq1BeU3waylMnF/L2VqVcugFr9NcASTFbkT
         nsZ8ozUnvEoDuG7AmeW2UobQ1xM60dTNW9RCR9kA/JurRg9g7i5wugBzrur3ZjOiqLwM
         heM0FIU7lwJQ/e7wk001vCZumJJCXCwka2hYUyLCRjFkfZh1fJ7B9eWTof9rmHpq1yf6
         SO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFIfsQQ5E9NpYa6J4Rd4ZByYS+XGHx8OIAC6z+bB9Nc=;
        b=y5u1KFK5jv88cXvcl1/xlKnVRnLIalpHGK9B6kpfqibp3p1SIa8we1mu7rl1XDQFVr
         XPk+iD9F1tqAjNz2o00goSZIB3APDtRbP+ESf8xkJDOwQMfK19dYWrE19iwXrgDlElRl
         kQUYURGPP7QymICVaKbD4Ty6uBvkO4p812OkxSzb0Yrum33aP3yJvqqgbszAyRi4iYnz
         wao6WcFpdhCZbCkmzKIlhqGZZRimzw6eHcxugOJcbSjtglUbtCCmr9g9bkM1ZP2oxWtV
         XeiLKhUn7+coF8qh0I2Noi14KM/rxMCYpDHhxxIZCHe4fT4x6/ptyJ4zKMEQo30H01Wb
         jBog==
X-Gm-Message-State: AO0yUKUvR9tG9tDrn/BUJy53EKbr1pPI4IIDp4FZZpiuNMoocERWKOGQ
        DIwR4Jn6rSiFBDx3aMTGAS+Z7Quf8B3w3R38+uk=
X-Google-Smtp-Source: AK7set8+O8Qk3I1/hMhfeye0TcWpCbDMaSowaT+AJXb7GAq2D8rF8Ja5/aMgAAqtpvmMkcFybP7p64BEDLs8q/bNz0o=
X-Received: by 2002:a0c:a88a:0:b0:56b:f460:af52 with SMTP id
 x10-20020a0ca88a000000b0056bf460af52mr1277543qva.81.1676024151445; Fri, 10
 Feb 2023 02:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20230208185714.27313-1-asmaa@nvidia.com> <CAHp75Vf7FcAvSwLPWj4OfnJ61iXy7TAFFzTAq_8b9VXeyCfBFg@mail.gmail.com>
 <CH2PR12MB3895C873B4381A88636A0EABD7D99@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895C873B4381A88636A0EABD7D99@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Feb 2023 12:15:15 +0200
Message-ID: <CAHp75VfVJ8B1d+gSi6WJw9guJBUkaJwH1yU7N7FpJ-DtL_L6Rg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add NVIDIA BlueField-3 GPIO driver and pin controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
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

On Fri, Feb 10, 2023 at 12:48 AM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

First of all, do not top-post!

> Thank you for your response. I was just going to contact you regarding this. I successfully sent these patches to you, Linus and Bartosz while they failed to get delivered to the "*.kernel.org" emails below:
> linux-gpio@vger.kernel.org;
> linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org
>
> Have these emails changed?

No, but you need to work with your company's IT to understand what's
going on. Your mails are only available privately and not in the
archives on lore.kernel.org. This is an issue and I'm not going to
comment on something that was not in public.

> These patches don't have much in common with gpio-mlxbf or gpio-mlxbf2 because the hardware registers and logic have changed across generations. The only similar code between gpio-mlxbf2.c and gpio-mlxbf3.c is the irq handling.

I see, don't forget to put it in the cover letter for the next version
(you will send it when you will be sure that emails are going to the
kernel.org archives).

-- 
With Best Regards,
Andy Shevchenko
