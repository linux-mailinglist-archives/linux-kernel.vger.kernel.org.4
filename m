Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334367E608
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjA0NEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjA0NEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:04:33 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B93457FE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:04:32 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4c24993965eso65506727b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZo/hOYMB4XOmHZVPhSJdaahe3ybSLuj3uH6A8FCzzM=;
        b=jJYWslZkmkFXxgqZ5bdPU/nw9lygDqHUByzlWiL8HeRbTYABD/PnUc691WhGYECIkY
         ri0GgHVzqkJ2TrI9QrJGtGtX1b/QaF17lakrkV+Xdd6uwRNKkfiFpV0WbE9yVL2hH1pE
         FzchvPs8z08XOiDW77CFm3O0rmi13GqXJMh1cfjNt7pscWR620rmSgjNHmpZPPxzg4bX
         EL/VLoGXrUSm7DNL8LQPxZ2vVvCoe1f99Tz2+Pjnm5Gx8hwj8rqFuU28R+tqBjhbufdJ
         pn3/h3PGg1uTdeI93iLafvj0cBUVbDvxfTkcpztcAhNmHEAl1/CFov2MHDxMqqTu+Tyu
         KurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZo/hOYMB4XOmHZVPhSJdaahe3ybSLuj3uH6A8FCzzM=;
        b=lFgmECdp/PY9R2c93VscJOmSAZoQnBUQzD/wTOwg6pGmsxcR37J6KHfozA9UUjr4wO
         u6+RVdK/Hj/G8o8NfGbpgRHEu6z9h9PKCWsl+K7XzdCiza0dh6WhyjjRn+EDNZonv57f
         pPvji8UNLvBPn04GEwjLYj2I8ukK5PvD9Z99ADKC0qSQfmwum5yZEgle+/231mMpMOXc
         UQSwFmNlJUv3Wcw4yAhZqdCLxOfDxg9EQ0bA0xybvq595fZtNB6faE74yk9MK39U5aG7
         VVQbiDs03J2RDmWKnV5pXkNdbSGEQPafuhhFfhucvvn6DFJu94xd5QFumJHMkRaE3pBE
         ExQA==
X-Gm-Message-State: AO0yUKUGXtu52JNYWfz3/QZ3uSOn1TzrMdgJ6bcVBdSt4skESMU6RWRY
        FAHNuufMLcw1Ks4ox0m7fpwy2oT0DxIUbBCcU08YTQ==
X-Google-Smtp-Source: AK7set9vhN45ZZFCUVfym6zIJVFa9K2ZAJPmPf0hGMrTMV9guIEPiRKMUIgGy39dYhzRz19N9U57SfH8YsKtpN+iKPs=
X-Received: by 2002:a0d:e701:0:b0:506:66f5:fd24 with SMTP id
 q1-20020a0de701000000b0050666f5fd24mr1522627ywe.130.1674824671621; Fri, 27
 Jan 2023 05:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20230126132801.2042371-1-arnd@kernel.org> <20230126132801.2042371-2-arnd@kernel.org>
In-Reply-To: <20230126132801.2042371-2-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:04:20 +0100
Message-ID: <CACRpkdZatOzwaEVe==-VpuJwBC4VzkqqC-_-04xi1CqKyH2Wqg@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpiolib: remove empty asm/gpio.h files
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 2:28 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The arm and sh versions of this file are identical to the generic
> versions and can just be removed.
>
> The drivers that actually use the sh3 specific version also include
> cpu/gpio.h directly, with the exception of magicpanelr2, which is
> easily fixed. This leaves coldfire as the only gpio driver
> that needs something custom for gpiolib.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
