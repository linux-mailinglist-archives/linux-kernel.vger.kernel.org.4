Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6B25F3EA3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiJDIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJDInZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:43:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0742286EE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:43:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so27281429ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9y6mckp6QwqVlkCMwSWHyLCrVK+e0UEzLE8ZnwJRiY8=;
        b=ktTkCfG+LGxaPC1FxhwkFYJUP/uVyiOL59RxCdYRtkujLdjXw8gvt2wUv+3x36ZqEK
         gr+uKk6uEhNT17sQPZ+KjFSX97a/KZpXepfHXgmhrDb/3eL9AHcIu+haa3EHsmJlJnzs
         R+SN9ofuPDXQjzLSQb4X72bpgfANjBE8P6Ib46jOf8xbgd6EArUjlzdayYBgqbKSLnRb
         yA9oWfoFVPykqzj7yWWyR9cV4XJmxmMBtiBzim10xNw0tIseI7tW35fyhQC0NGXVzhMy
         VlAoApKSJ0FnZlTgOKRnAPpO6m++30KnTUXBS3hDU/FaSdixESMfE5c4EeyFBh4KwinZ
         wxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9y6mckp6QwqVlkCMwSWHyLCrVK+e0UEzLE8ZnwJRiY8=;
        b=dZmaOzQHdk72U6g68dY2nOBHMIcN2eDx1MuTcBndu+VgKCFoQobfXLmurA9HOZLfTF
         ytWM/clRmophetWUmG2LmzNoieoGKWi1pEyuw2LAz4bQ5X3oOHdTabWt3/Dh1leEcSgV
         m1FkGYfGBSpyL9dQuhZTvWU4zar3mbVeDyBtCpuD2MDWC8cpIbOtjEmYgq6CxGPOrth+
         9i1YBILCKvlZTI4HRFr6EzGOS70CRBBy4+52qoBKmPbi4NN0ObscnnRJ5pWPSC4RLqz4
         PGjziVPkZJAv68X+7BnMcCIdqH4PaxYaKnUlyf8FGvTYJkHVwzjC907FnGUa5IEU8fZ/
         tR9g==
X-Gm-Message-State: ACrzQf1By5v5WhQYqk21aOK6xJB8zZr6CLayrHLgKFG3fhuf5mhuM9Fk
        RmC7LwsX5bMDpUY/B8ytWd5FbvLiZCez6f6kQuGZqQ==
X-Google-Smtp-Source: AMsMyM7smwSso6PfOzdvyNfHYtM5xmnUQGdDRlyqmuW7idFRUM5gJbnvbj0OLrfrEFIn9hTirM/sNLEnKZ34nmjZXfM=
X-Received: by 2002:a17:906:8a46:b0:781:71fc:d23f with SMTP id
 gx6-20020a1709068a4600b0078171fcd23fmr18624979ejc.500.1664873002520; Tue, 04
 Oct 2022 01:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220930060819.5320-1-hal.feng@linux.starfivetech.com>
In-Reply-To: <20220930060819.5320-1-hal.feng@linux.starfivetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 10:43:11 +0200
Message-ID: <CACRpkdb-7YxfJB5YpYf4t1rT+u=mctLyVbCwm4+TtEHm1k2ANA@mail.gmail.com>
Subject: Re: [PATCH v1 22/30] pinctrl: Create subdirectory for StarFive drivers
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 8:08 AM Hal Feng
<hal.feng@linux.starfivetech.com> wrote:

> From: Jianlong Huang <jianlong.huang@starfivetech.com>
>
> Move the StarFive JH7100 pinctrl driver to a new subdirectory
> in preparation for adding more StarFive pinctrl drivers. No
> functional change.
>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>

I applied this patch for v6.1 so you don't have to reiterate it, it's clearly
just infrastructure that you'll need going forward.

Yours,
Linus Walleij
