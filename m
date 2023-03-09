Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67596B263D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCIOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjCIOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:06:12 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3757DCF42
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:03:53 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id n18so1971338ybm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678370631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfLw2hJ09K7juhM7ToFdGQXgPnTRU+N2reGUNJs1fMk=;
        b=OglomTTR6Q/AS6flCU2rkHTHfevRiuEKKFNNQsDTkdIKRuP9x+vUSF+aki1Ul7UWEL
         /AOJLUYB2yPVeFTeNKDyjxn6Lp/dKbgPcXff4WQNrovSfK0NSzAG4FIXnz2EmnO0yHFc
         FmVEWTHnlbO/9MsC6rwIBriGSXj+PN++LIfoftIBjppkEMIqLGBJzytHueVRqxgnGoLr
         CHvJvRoEf8U0rhA0qezGmX4gw9Z+J4nbbqKBpVSnAXCssJxlBpy7/z15CuL+HDUYQw11
         nUNNKt7wJmy52PuHtapxj2ynZest4JK9Fv4EzitxfqF+Gv268XZWI3wS3TwdZA0HwPxX
         ZQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfLw2hJ09K7juhM7ToFdGQXgPnTRU+N2reGUNJs1fMk=;
        b=VyEoTXKVWQh9zC409EqY/Yuvy26qHO1kLZ1gHEfD9Y8Lz3y7b+tt/FRsRwIZMqi5fP
         ufn+9jxbwRWlnpjH7/lTNizRbQKZGwsPsKOrVjsUZ2L54+QgSoxAy5GqsF8CCoyXUGE8
         TTbTxKuuom3+9NMtgYOc18jRW38X34WAmBeneTkuYHEnrIo4LRi1IRxzXsf/xp0hpVvV
         5NBEorjmUMLdAVtcviD/0UXjxzOoG3Fu273Ncd7ISfPuyeMsJFbvxTI+j3Osu3r4SPu+
         6m8BX18ZbY+bWlWQgvmFztW7QOgk3fnJRZv+Kr3Dcz3tBwD6ufa2IvY1Yxr8jNeA2Mj7
         xkQg==
X-Gm-Message-State: AO0yUKW60miD4qWLTAPzqGPwosnueTRSVhcNO0GH5keCwVNIH+9LfgkR
        Lnmw4MC7Haj8I3IQXZC5d7qtf0d1BBPj78QN1gFhaw==
X-Google-Smtp-Source: AK7set/V9g47LXb/8bVVYX4aEcUjsLMStk6C108ueaS9M+e5hKMWh6BL/B8P3j74SyJtKGeS1gB7pU0gGTbjZfKvQFQ=
X-Received: by 2002:a25:8c84:0:b0:b23:4649:7ef3 with SMTP id
 m4-20020a258c84000000b00b2346497ef3mr707871ybl.4.1678370624827; Thu, 09 Mar
 2023 06:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20230308084309.396192-1-nm@ti.com>
In-Reply-To: <20230308084309.396192-1-nm@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Mar 2023 15:03:33 +0100
Message-ID: <CACRpkdbBWeFupRin=JuMCGDWkzbsR18N+4ZEbQOPJq=p3w0yLw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: k3: Introduce debounce select mux macros
To:     Nishanth Menon <nm@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
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

On Wed, Mar 8, 2023 at 9:43 AM Nishanth Menon <nm@ti.com> wrote:

> Introduce the debounce select mux macros to allow folks to setup
> debounce configuration for pins. Each configuration selected maps
> to a specific timing register as documented in appropriate Technical
> Reference Manual (example:[1]).
>
> [1] AM625x TRM (section 6.1.2.2): https://www.ti.com/lit/pdf/spruiv7
> Signed-off-by: Nishanth Menon <nm@ti.com>

Patch applied.

Consider doing what Krzysztof recommends: move thes <dt-bindings/*.h>
down to the arch where you're using it and have them as .dtsi files instead
or something.

Yours,
Linus Walleij
