Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB66F55A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjECKL3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 May 2023 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjECKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:11:27 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B41A5;
        Wed,  3 May 2023 03:11:26 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so2515052276.0;
        Wed, 03 May 2023 03:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108686; x=1685700686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZtrVLKnAX2pxnlVF4pY/ZydKFTcmn+Q19HXitjOZjU=;
        b=ZOnCyP+Yv2IF+OUAsQAolALAArMqRrDRe/X5oE2UWiYQiLhXEOyIlVYVf4zwIER8UI
         R6quEHkssFnBGseKKsB6hNpZ9yQTWlw6dF8Oxuh9id4HHxlkGVUqfQ/3h88+oFmAcfvd
         jJ8b6XZkWxBIT44tj3uIYqQu8UMWE+aWWzh9Nk9rTkoVQL1L+oV+Gc1JTKp7IdKmU6WL
         IvATSn9ZRMMjL/4m/URXcEc2bBjPL4ofCtGalidtXRf6aUp+hk++TYD242X4ud5vVPKc
         dOf7qmJdBxIi6d+JFxoCizKZ77f/q7VxlznFQ+VYOmA1kydj5wwt11Lg4eMB8CGotOUw
         Tm9g==
X-Gm-Message-State: AC+VfDzc7KHiANtb708LSDKaZd0Ne3sgzh9KL2XDCKWxZb00vRNk4Qnl
        GaYjJppfA0IBKhQDWS1MP2+gf7JAYUZOpQ==
X-Google-Smtp-Source: ACHHUZ7D0fYYJ5jbojmA5YPHIjazHXSLmdQDImO1vrcPdUrDh4T2AgDndA3GvLlfYnsnN8IwkoLTGg==
X-Received: by 2002:a81:160a:0:b0:552:a4af:da with SMTP id 10-20020a81160a000000b00552a4af00damr1537309yww.10.1683108685776;
        Wed, 03 May 2023 03:11:25 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id z188-20020a8165c5000000b00545a08184d0sm8584840ywb.96.2023.05.03.03.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 03:11:25 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so2433565276.1;
        Wed, 03 May 2023 03:11:24 -0700 (PDT)
X-Received: by 2002:a0d:e894:0:b0:55d:626e:3dcf with SMTP id
 r142-20020a0de894000000b0055d626e3dcfmr396904ywe.12.1683108684523; Wed, 03
 May 2023 03:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230502165330.55769-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230502165330.55769-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 12:11:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVh73ZzNy0Gv4hchQxzWwfMy5JinZz_972QoaZ2Obiy7A@mail.gmail.com>
Message-ID: <CAMuHMdVh73ZzNy0Gv4hchQxzWwfMy5JinZz_972QoaZ2Obiy7A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: Add R-Car V3U device tree bindings
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, May 2, 2023 at 6:53 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
