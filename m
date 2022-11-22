Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325F46336F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiKVIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiKVIYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:24:55 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A840453
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:24:54 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3704852322fso137077067b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kb63W+UIsuIrJz3AXei8J+4cfxCV44ANkMXV9cCXccg=;
        b=mH3OJYCvcyiKq8qtqJs/nYHURgE0zFOMnwKbBA4doL7OTC+Bxtbq4P7yK2l1D/UuvN
         ANKZM0yAo0iINKoNVgjnUzbNgIWuqxYh1X/xuZiT8mSUoDlyeN0Lg8SU7M3+lTrVDYjS
         iHouLEschtv7HO2nz9Lzpjav0eSDfmIgsT9Nn4hsNchVesmK4Zu7ZDmwQ2K4TpwokokN
         a5aGK7yB03Ia45Ew8rOA5MugsI7VZS6F9h9VmiM/Mdefw1TNhTs49q1dDZhd3IqKIyxx
         /r5PDA7TDx5CqBoR5hHQUR+MR/DydEW04bG7M5HO5mz3YOvwpFBisdBX5D1WZe761Mf5
         sgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb63W+UIsuIrJz3AXei8J+4cfxCV44ANkMXV9cCXccg=;
        b=ogrlSqBwq6Jkydv95N2NC/+75E2aYxOjeDcw3TAZDEGp8JsxGJyg1o6vG2+W01JbIG
         psk/1pYNsf9kcX9hbW8YpLjZKbws+Z3XKdh6+7CQpS5KRCf4Tp0+174angnleFh66fLS
         ad0GzK8VZDBe6xGHYVMYO+jAyKWC4GEXfABHKROVsMxOh4wa+1PchmNi5sSUPAwopfq/
         iJ2sO0+Fnp57jN5SzpDPJOsOxTB+3WB/nrQWICg4YFyOmFZqDI6O8OGDQw7drTOp57Mf
         11jsbeybm2HtHm5/+1ned+vv5pWJnIsYRx6lQEUpGTkNrNNVeHaNinR0Y/e8EDmEOIBZ
         sfLg==
X-Gm-Message-State: ANoB5plyPAkzNr46xULh6zuw6FPVFSUtyAZnjynr1uotSMn/3hFr9kKM
        XX46QDT/z46kJgh7nPLT628dFYUXZiqv2RuHmTmQQg==
X-Google-Smtp-Source: AA0mqf6v4Oku4YPWYpKZedL/YubM1du4LxGnRE3pB9Srgo4LCWZJDt8YSfISwjZdRDSTk8Jimww5m+PQcWGnpt8ZpOM=
X-Received: by 2002:a05:690c:285:b0:3ab:189e:3465 with SMTP id
 bf5-20020a05690c028500b003ab189e3465mr1206489ywb.343.1669105493788; Tue, 22
 Nov 2022 00:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20221121-sx150xq_bindings_fixup-v1-0-e754f183b611@linaro.org>
In-Reply-To: <20221121-sx150xq_bindings_fixup-v1-0-e754f183b611@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Nov 2022 09:24:41 +0100
Message-ID: <CACRpkdb+y=tkFQHLFdKmYDrBhz3h-6zyJ3EDEgxo6eT8Tew2-w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: semtech,sx150xq: fix match patterns
 for 16 GPIOs matching
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
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

On Mon, Nov 21, 2022 at 3:12 PM Neil Armstrong
<neil.armstrong@linaro.org> wrote:

> The current pattern for SX1503 and SX1509Q with 16 GPIOs only matches
> "gpio0", "gpio1", and "gpio5" instead of "gpio0" to "gpio15" included.
>
> Fix these patterns to match the whole 16 GPIO line names.
>
> Fixes: 29c10bcec50a ("dt-bindings: pinctrl: convert semtech,sx150xq bindings to dt-schema")
> Reported-by: Sander Vanheule <sander@svanheule.net>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Patch applied, thanks for fixing this up so quickly!

Yours,
Linus Walleij
