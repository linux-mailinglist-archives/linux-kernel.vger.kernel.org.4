Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE044750AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGLORH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGLORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:17:05 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD112E;
        Wed, 12 Jul 2023 07:17:04 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5700b15c12fso78427367b3.1;
        Wed, 12 Jul 2023 07:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689171424; x=1691763424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyyFJfH5D8Bahiy0fpzGvTieHeBNsFN/lGuaj1/X0Yw=;
        b=QPWJaI0s6BhnWK18XsagKyGIwmUUw1CSGjcwIDpCCik1A3oRQQdh22hQlebTtkEGRC
         8RNs/qZvwgzngnZ9/uNJj0/czaQ7NGeR1pdXZyGO5YOXfzl6RaJHj1NV2r/q5SGjkyJv
         IMr9pJ76E7iEVVZkHMJtz65nTARQV8F3aR3MVSl5HMjuHwV4iTxUDd3OyMrTo+ZoKcF/
         RUKffUquR8dTDTLG8o9quh2iwBCTQRysljnkNiSqL4pu6MCEWj2CotkXv6Tz1s5JFNsx
         t/b56uotAQ9gtGyghxlh2Um5cNmUiwvdfQ/l2R4gLdEtaWWgWPHoLW1IAk50xFfWOZRz
         saTg==
X-Gm-Message-State: ABy/qLYCcP2lsXlgvc21mhdIE21RDFR0gODOfM9e5s1NgLGW5NQiTLCc
        L5sQPy3BrlSJ65ZJFyoL8O6yI6n6DKy4sw==
X-Google-Smtp-Source: APBJJlED3MiB1h58MvI3CEE1zUbP2k+V5iFclE+HKSuKnStPCorlG5fifPR5gqYEyu4u0qK6uH/2+g==
X-Received: by 2002:a0d:c784:0:b0:56f:ff88:2e43 with SMTP id j126-20020a0dc784000000b0056fff882e43mr17762581ywd.27.1689171423726;
        Wed, 12 Jul 2023 07:17:03 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id x66-20020a0dee45000000b005772646629csm1174508ywe.144.2023.07.12.07.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:17:03 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-579d5d89b41so78328727b3.2;
        Wed, 12 Jul 2023 07:17:03 -0700 (PDT)
X-Received: by 2002:a5b:a83:0:b0:bc9:1019:543 with SMTP id h3-20020a5b0a83000000b00bc910190543mr15888117ybq.58.1689171422864;
 Wed, 12 Jul 2023 07:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230712140116.18718-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230712140116.18718-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 16:16:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXkMWDsjp_QOMUeV3XN5TdYtmMqX1GKbV=Bn8Q-3zyJYg@mail.gmail.com>
Message-ID: <CAMuHMdXkMWDsjp_QOMUeV3XN5TdYtmMqX1GKbV=Bn8Q-3zyJYg@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: remove outdated indentation
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 4:05 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Using tabs to make a structure initialization more readable is not
> considered helpful. Remove the final appearance from this driver.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
