Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8555F5570
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJENcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJENcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:32:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2879EFA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:32:20 -0700 (PDT)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE4843F138
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664976738;
        bh=6LkuqTP0xa6XajPgZoG/IjY8IZRdyk1AbTrKKTZip3M=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=occGOyRn3hyBeTNlbf+F3KveT9D/456dhK8qTFtBNyFHwtpBtYW44mcTbndHkaET5
         FfuBAlDY8BVJEZNpme2Y3GTCN+oqPryYN6U6duPhp/ITk394vGRbnfDwntKHWm+R2r
         t9yiQjR1sQKxRE/PxfxPJJcajl54Lj9XTZMZ0HvNPM3IpKUyuNioDv1bVU8fQ1LJsk
         UdRgucE6ml4CoC+tbMOCrarO96qE76fsBFQAVDn5IOurTtq3AIaQ43AoE3DoodrrRt
         0NJDC/UhD6unyjoeUhj6Ka/NhWkQVjPmI2pk4zHmpjn4yOU586Oh4Sci8vZ3eMudp7
         8RwrjqkclBDzA==
Received: by mail-qv1-f70.google.com with SMTP id c1-20020a0cfb01000000b00495ad218c74so10543791qvp.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 06:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6LkuqTP0xa6XajPgZoG/IjY8IZRdyk1AbTrKKTZip3M=;
        b=xeNR9Yf2qsxib5MES9yoKYaOTnXMFi/JlYfIo+XQ7lhh9Z1H4y5RBAmKnbppVUXhux
         /NA2/lhrQP8gLVvKnjt99VZh1JmW7ei0llkX7g62rLWyIhQ7kx6D9Zuo82ebgpiHZR8w
         BqsjBvp/9okzaKnu3prtNtKpY+IAkHu1K9czbWaMFP0ij4yFg2JIblVUyZMZI2Bl2LGM
         f4mpn6OQx2n+tKj6NGCEqDvtF9FdIeLWUtaJbXp1wzgQv1Tkmn19apZ2k7IVqLxrolN8
         iAGnt4lDaabVhtjRKn8qWxCubHkp6/birCj1JrdYdwT8i860iRWCSrDHsn/jTy5F/4Gm
         JviQ==
X-Gm-Message-State: ACrzQf0Jnj0D3O4KJpefJ+7slqr5CPGBWaPUBnhscKi1rRAamZ3N4ipK
        GP6p48+EZ5LmsdYd74zGMO1msT9WIrc3UKM+A67kV6MNGE0UJXFieQsgKb1ibbAf8XSRIKDyjqo
        uWuyd69U5vMlIckqXoTEqk8sd9MH6vrIJ/hjtA/JRTcisjIwQeie0XohU8A==
X-Received: by 2002:a05:620a:488a:b0:6ce:5caa:37d1 with SMTP id ea10-20020a05620a488a00b006ce5caa37d1mr19656620qkb.37.1664976735803;
        Wed, 05 Oct 2022 06:32:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Xl+UsR78BPCM9pC3pjMNNB38LjTXXtDyoeNI34kPvrpVwp+y4DCHK0DykjnJjicQW6z4ascUy+oxEZUfANUw=
X-Received: by 2002:a05:620a:488a:b0:6ce:5caa:37d1 with SMTP id
 ea10-20020a05620a488a00b006ce5caa37d1mr19656602qkb.37.1664976735563; Wed, 05
 Oct 2022 06:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930074341.6386-1-hal.feng@linux.starfivetech.com> <CACRpkdYMQ98Q1iXr7-YdUkQrSK8aauZuSFeDp2f7ubNH_W7_HQ@mail.gmail.com>
In-Reply-To: <CACRpkdYMQ98Q1iXr7-YdUkQrSK8aauZuSFeDp2f7ubNH_W7_HQ@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 5 Oct 2022 15:31:59 +0200
Message-ID: <CAJM55Z91TL4eLOjZsRVZuxspcL40gG2MQRZf31h0L2yyaW--Cg@mail.gmail.com>
Subject: Re: [PATCH v1 26/30] pinctrl: starfive: Add StarFive JH7110 driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hal Feng <hal.feng@linux.starfivetech.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
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
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 at 10:57, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Sep 30, 2022 at 9:45 AM Hal Feng
> <hal.feng@linux.starfivetech.com> wrote:
>
> > From: Jianlong Huang <jianlong.huang@starfivetech.com>
> >
> > Add pinctrl driver for StarFive JH7110 SoC.
> >
> > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
>
> Since Emil submitted the first driver I would really appreciate his review
> on this version.

I tried really hard to come up with a good way to share code between
the JH7100 and JH7110 drivers, but so many details different on the
JH7110 that it's probably best to just have a separate driver, so that
part is fine.

As mentioned elsewhere this driver certainly shouldn't be accepted
without following the generic pinctrl and pinmux bindings. You can see
the driver I wrote here:
https://github.com/esmil/linux/commit/c2633315385fef1a25aa3711facef07d915820e1

It is certainly not perfect and far from complete, but at least it
does follow the generic bindings. Feel free to copy all or parts of
that.

/Emil


>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
