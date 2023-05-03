Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D26F53CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjECI4q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 May 2023 04:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjECI4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:56:42 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F92C10D9;
        Wed,  3 May 2023 01:56:41 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so6855179276.2;
        Wed, 03 May 2023 01:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104200; x=1685696200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLIjSxvkFoShCDz7/AeeChAXiJ9TCtnKs3s5wZ5JN+8=;
        b=FRpPJUrL5Hb3oc5BuMFQBhZ4kfNvTcKqJqUBY8MtwS3Rxd1E/6kRj/uMVORK4XtsJ8
         NhiwCMkJGlulmZqTPkIQyNhEEZ8EgaL7peQWqoPL3svLDhFi2Jqf2h5Ot6oasv9w+0AB
         43Hv5gwYZe1Qp1QTybQAbVsGPZGWdnBUo0e6KC8Psinp4ZtqJgRNnOgsG6LzyADMvOxy
         fAvNvDamkFZAkAYlw7Wvt0/SnTk/idRl/OAV9CcxctVAaCWZYGFHr5z3Kp053v189/XA
         47rgAz865l5z2iKIKXN6mo0MF95H6hO3+F0PH38RPzxt/VI1fo4sps6cZGAJ8VpDduRL
         kBVg==
X-Gm-Message-State: AC+VfDz+F4ErOC3guT9EWPgPM52AB/CRV7nShJgRHVsL5DEjIgN89qKT
        CrL0BCLU8ge1LiLBdE/gez5cG15lQPK6ew==
X-Google-Smtp-Source: ACHHUZ6toUWOAd7Hr3Z+9B+MCMog8Eb57DYlvSZrBCsL/ydWUww26o17p03f5N8yRj9DSX3eTb0+BQ==
X-Received: by 2002:a25:e68d:0:b0:b9e:7f1b:ea9d with SMTP id d135-20020a25e68d000000b00b9e7f1bea9dmr4464171ybh.33.1683104200482;
        Wed, 03 May 2023 01:56:40 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id z12-20020a5b020c000000b00b7767ca7485sm7179350ybl.34.2023.05.03.01.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 01:56:39 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so6855147276.2;
        Wed, 03 May 2023 01:56:39 -0700 (PDT)
X-Received: by 2002:a25:fc1b:0:b0:b9a:6f77:9018 with SMTP id
 v27-20020a25fc1b000000b00b9a6f779018mr19158460ybd.41.1683104199175; Wed, 03
 May 2023 01:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 10:56:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjKwfBizmH8cZYEmVC2ZYLLqQG4kyrHm6Ct0j4EK4eQg@mail.gmail.com>
Message-ID: <CAMuHMdXjKwfBizmH8cZYEmVC2ZYLLqQG4kyrHm6Ct0j4EK4eQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, May 2, 2023 at 9:40 PM Rob Herring <robh+dt@kernel.org> wrote:
>     'r7' : 'renesas',
>     'r8' : 'renesas',
>     'r9' : 'renesas',
>     'emev2' : 'renesas',
>     'sh73a' : 'renesas',
>     'gr-' : 'renesas',
>     'iwg' : 'renesas',

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
