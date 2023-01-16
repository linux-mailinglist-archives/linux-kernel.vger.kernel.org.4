Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE82E66C149
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjAPOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjAPOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:07:24 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1722A3A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:03:43 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4e9adf3673aso45396907b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs1nOC1BgF0Yw9sZ8FNPaDvLfeuxX3ryCgdw4QPGT0Y=;
        b=NpTpfQpwXRyV/0FZU7AxgVGzwv5WYCS6o/mqW5qp+doCLsXz0N+OdxNUFHOwSQI87T
         fqtUfEXnX7RVFAvkcVbesfRy5u4TvfmKQx/XMX2BdU6Ytg6IGmr8N8GTaR0dEibHOSa8
         fw/OQS77aPMsPVYazNn1FWGV/hK2GXbWNYAZ+9E8qn4zEhY6htJwMMb7utgp0ME4ttVE
         r4jlszYkM9jYlZcdea7YttzodI6tgc+hQ+8g5mEu0oT4Em2Em+jDCkt1nZPc8gwTtri0
         ikPHbl2ngXYy09iiPKgsDl7hM05pgcjdvkQWWeoiBliyXK2F1e/sTBza59TtXKCP03v8
         nFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cs1nOC1BgF0Yw9sZ8FNPaDvLfeuxX3ryCgdw4QPGT0Y=;
        b=YO3b/MKYFODQkYp2b76u30Tvq54JyIbH3f4oJG6XCoxbSUkcamSxkhnqIpS/t4ceaS
         p+5jxlRqKY8nYdD6ET4qJOwSx4LT59ZGpzYoBG7SeiGgdW1lM8iLKcxN+SVczH6FhpTu
         QTtJEVoANbkPBTBaBLJtToES7GT0w/rLEgqlqQaYVZ935NjnHVOG8n3h3JwKYPJtsZB3
         vNKkvEskHPcxX9LEJaTypjPGX9u4dATAki9GSHK+O/W7muWhsmKxSFXJThXf5qyY324P
         CDHEZHoeXOrCe/FdhGS5QzG77uwojSqlE1cqXgUHG4P/m65Q8ur79qHOBeCtIYpQTZXS
         uF8Q==
X-Gm-Message-State: AFqh2krgOQD2IRiJKHQ11sD0v4NtLhYD0Qjzdwe71gjBEi3vKDlOXzti
        olWfMpaCJSZMUV8sJvuAxCkc1pAfhIYz5liBMeaMmA==
X-Google-Smtp-Source: AMrXdXurzujl2iT8SUQnqmXrhxj7HcRTi+V6Nb7ymWtMCMJW+xhnjzzeHzauY3+XtIvkPSgoEvkDo4jpe3AyvZozrVo=
X-Received: by 2002:a81:6685:0:b0:4dc:818f:f9f2 with SMTP id
 a127-20020a816685000000b004dc818ff9f2mr1265000ywc.469.1673877822982; Mon, 16
 Jan 2023 06:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20230112185122.45216-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112185122.45216-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 15:03:31 +0100
Message-ID: <CACRpkdYVFxMQVbM47cMkiKGRhtEWUKHT309P3pj3AY0x1EvhZg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: sunplus: sppctl: Remove duplicate
 assignment of of_gpio_n_cells
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wells Lu <wellslutw@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dvorkin Dmitry <dvorkin@tibbo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 7:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
