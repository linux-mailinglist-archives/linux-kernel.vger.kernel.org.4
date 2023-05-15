Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B3702601
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbjEOH0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjEOH0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:26:07 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8FD1AB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:26:05 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-559debdedb5so184910817b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684135565; x=1686727565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eurMz9NQAUmkORq8ZJu1AgnEBQF8a6B21GIn/UfxOEI=;
        b=URaTzQG6g74E8biL/yJ5/3corUdz5kezIBq8rpkzGX9Lj4RGuyYIwzggM9i3yP/toH
         TWT9U3hF7A5kDzqL7CrTnM/e7/2qSclroVT1O3JKPjx7eN4O5ztR9SOnKNGgBL5Cn4M6
         720A5c4RLjqxkCe3SZVi5906Lc8023qjsuk5lOVoHtFJSXve5zsQJzmXLGyvan3hAPm1
         G1al3fa/jAL177yGkpoqGNHpVi7sQU4O7k2+H27pTjFvlPdBZmpTazg3BgZ/CJZoeMDS
         Fv7wmuUNmcTEF5WEpzg8QfroJgQjdjl4XCtW1xdXcM5sNDw2Go4KZqLhavnSlv4laa8W
         iwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684135565; x=1686727565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eurMz9NQAUmkORq8ZJu1AgnEBQF8a6B21GIn/UfxOEI=;
        b=PbFJhpFtsuXZHNvu+ed5QwwUZf4NYEdLDuiWeSPwoo57YDyYAjM9JlxdJzKlM50SgJ
         hnBzirpXQbkAtmsEW6OU+qtUwvPPEWxR5AL5LLKaM45HncopnxXHvJlnmD/tU1WRiqdA
         dzz2qx2Di7uT2CkMNjjSmGLnHGL+NXxv0ACOgdoRKtcQf+CROYmvtvPMSCPn0B4PRkuD
         qpVY2Z5oZQZZYrKQtyesjzeiaFOMLncHpozoqwnl6Fe3Ctcipl9lnxccxlwmQ+hEFcjX
         dbIn4YZCtUixFdU1CSUEaij3Qx0OAqQRPwWBSRK9auSxuCdwDjLuayB6rTNlM79mOu8i
         1ztQ==
X-Gm-Message-State: AC+VfDwx+JSTIzYnXYpbM6qa/F+2vM4ApE61Wmr+TFnURk/7FIU9vJwh
        WV97tTIYfYt2ynKUEFW/Zpjk5+YCd0ajqFf1F4p7WQ==
X-Google-Smtp-Source: ACHHUZ4rQ+YJh1EEoZTA+7CazQQ7vitOT3vS9R1tfo6aJWm4yep7gQisGdpXMJ5icbi8vBLCRVbW1YCcFJ4YkotuEMY=
X-Received: by 2002:a0d:fc44:0:b0:555:d983:f4f0 with SMTP id
 m65-20020a0dfc44000000b00555d983f4f0mr28247355ywf.24.1684135564884; Mon, 15
 May 2023 00:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <202304232146.7M89pwCz-lkp@intel.com> <KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
In-Reply-To: <KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 May 2023 09:25:53 +0200
Message-ID: <CACRpkdbDNfrUZiVbDRx9EQWByfzXHtA3ZO+dUXvEK5RzYYYgUw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: gpiolib: clear the array_info's memory space
To:     Yan Wang <rk.code@outlook.com>
Cc:     brgl@bgdev.pl,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -4359,6 +4359,8 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,

>                          * hardware number is different from its array index.
>                          */
>                         if (bitmap_full(array_info->get_mask, descs->ndescs)) {
> +                               /*clear descs->info*/
> +                               memset(array_info, 0, sizeof(struct gpio_array));
>                                 array_info = NULL;

This is not the right solution.

The array_info points beyond descs and descs have be krealloc:ed
to fit the array info.

The right solution is not to fill that memory with zeroes, but to krealloc
back to the size that descs had before we did this resizing to begin
with.

Possibly the condition should be detected *before* we start to krealloc()
so we can avoid all the krealloc():ing.

If the actual issue cannot be fixed I think it is no better or worse to just
leave the code as it is, we are just zeroing some unused memory.

Yours,
Linus Walleij
