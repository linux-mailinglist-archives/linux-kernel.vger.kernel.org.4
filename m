Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE362269D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiKIJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiKIJQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:16:12 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4758422B04
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:14:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n12so44886076eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BII9zpGzB69RugugB6yoflzCcqpd30y/N1Z9Get0kNc=;
        b=kbovMEF+8HLQIt31/GrcUDBIGre3xrC8pBrRd5oe7sfJkpNpFdzAoEm+XSpeIPn1cM
         1JdHOaKHVMwjdxmAMHZ8ifz82J5VAnAD+09wU3dIL4/I8o3AImDcRZw55jxwCvpBFlm5
         Ns7TQ3Q6CC/l8R1UzGv31aRJ5KWYrvrqIsW5y/rQ2ZITwr7o0vqDCJ7YKaOk0FR1RaBh
         uM0DG4ve29ACq9duIvMGpZlXDXZ+89wNzYdDqvTJSqoTFvLLliy9V6XwXdwYuHFgEIAO
         boT+SnoFdEU6w4AvkXW/uDcdRpXM82h82QHBix/0qIM7xdI/mFpuG9YS8g7H03LKKw0z
         RqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BII9zpGzB69RugugB6yoflzCcqpd30y/N1Z9Get0kNc=;
        b=2G8gvjhPPSjyNqfMVDRcuSSxhZPxmAcyFx6FiXtwhd7Vlk6qM2CHBvLDv66ErtOuAy
         A+0DfYEuM/gFFiP9voQ9HZgEkSGJ3qMja6zcc40b2q2uHI1lPVns+t/uNCIp8urG8imX
         MBeBJUI2H/k94tikAq/yV65eFPo8q0nOTTgJOv9GYwg+w72PmOaOY+UdAYJRRIrQ9/AL
         oeHJNodLHktoYu0eWe1TgQXVpHpyL2Q71syfeV8x1LHq34nD08K65qB/XwCV5nKzrmNb
         iAXE74y+KO0FnTMXnylfpF4WnHCtRJFJBHOCJ00WbZ4LyJM6k14Ux6Z/nkmD7XVO53ks
         ykvQ==
X-Gm-Message-State: ACrzQf26UXQl01Clsk3yjBIQ94ohvARwwSyj7jEW7t9t1wyt83Io39Ag
        k9A9HVrA+bJNQFNlEFteBq0ilHg4i58AjVzQ3D4Ifg==
X-Google-Smtp-Source: AMsMyM5ksqUJ8SVIvXrtIwFN5i88+m+DzparWxKXy8NGnIIzbgssm45e6mhLSH/PRjclkP8xuAkTVBww6rMhLGIwxzg=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr24270592ejc.690.1667985287893; Wed, 09
 Nov 2022 01:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20221108092840.14945-1-JJLIU0@nuvoton.com> <20221108092840.14945-4-JJLIU0@nuvoton.com>
In-Reply-To: <20221108092840.14945-4-JJLIU0@nuvoton.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 10:14:36 +0100
Message-ID: <CACRpkdb+Bkwa8yCKGtRcsJ6KnJh+RUuz_gOrQV63pcYQLaHCaw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O
 expansion interface(SGPIO)
To:     Jim Liu <jim.t90615@gmail.com>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
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

On Tue, Nov 8, 2022 at 10:29 AM Jim Liu <jim.t90615@gmail.com> wrote:

> +  nin_gpios: true
> +
> +  nout_gpios: true

My comment from v1 still holds.
I'd say just drop these two, it's too much trying to protect
the users from themselves.

> +  bus-frequency: true

Given that you have clocks already, what does this actually specify?
Which bus? The one the GPIO is connected to? Why is it different
from the frequency from the clocks? And what is it used for, why does
it need to be specified? So many questions.

A description is necessary.

I guess the : true means it is picked up from the core schemas somehow
but that doesn't make me smarter.

Yours,
Linus Walleij
