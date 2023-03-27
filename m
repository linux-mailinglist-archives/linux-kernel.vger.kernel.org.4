Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2719A6CAE1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjC0TEd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0TEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:04:30 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A52719;
        Mon, 27 Mar 2023 12:04:28 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id i7so12056436ybt.0;
        Mon, 27 Mar 2023 12:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UFBf/PJ4B8eptCmmhaug8CchpjKto2XVsuXPxLn/2U=;
        b=yl2ANp/j8rffygGEC8guR7gZlqWyY8mHgHZWgi7wMaQzVGz7gR8Fv2nKaQYg8y4TuS
         8kV8C6XjZOUjtMro3EQ6chVAoJ7IHekmPdMf5dWK8EC+IYSXlGqc3MsapAlEmPMWCKYG
         pz/NSAfctWhSwspzqHzbQHsBQjTg2rBM/LMmtviAL+ZYqDy5Wn1oA/m0Fi/dV+m9Juns
         j/qCH8z+ZaoHPfBSXBiChXcR3Xto41Bpl9GM9ydkp7sSKY9JdIv2VWv8mCr35wJRI52L
         GIcX8ya8y9sfJNqu3rkMszQ1TwXIbzB77XPxj6xAmm8N4bSmy18cvQ32jGrh9mCI88gA
         8UbA==
X-Gm-Message-State: AAQBX9f9fZA2VOCFUTLlao/I1nKOzckb1CimFqLYfeS883wHQFqjWSt0
        ypGnoIAXKkmI9rR7XazRtRReBIPL1saNXw==
X-Google-Smtp-Source: AKy350ZlgSO0AIZgBRroytZb9+3+UdOnRdZ7bbVz6SQazMY4N6YHRrmm2tkgFAYP7d2pS4LXaBrluw==
X-Received: by 2002:a25:6948:0:b0:b63:e1f7:b121 with SMTP id e69-20020a256948000000b00b63e1f7b121mr11365104ybc.5.1679943867510;
        Mon, 27 Mar 2023 12:04:27 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 198-20020a250bcf000000b00b7767ca746asm2414493ybl.7.2023.03.27.12.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:04:26 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id n125so11991834ybg.7;
        Mon, 27 Mar 2023 12:04:26 -0700 (PDT)
X-Received: by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP id
 r14-20020a056902154e00b00b77d2db5f8fmr7646774ybu.12.1679943866424; Mon, 27
 Mar 2023 12:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230327170053.4100949-1-robh@kernel.org>
In-Reply-To: <20230327170053.4100949-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Mar 2023 21:04:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUV9KAtp87rWOhB6eSPWL3jTBf0frwpQDaWPD=H=w3skg@mail.gmail.com>
Message-ID: <CAMuHMdUV9KAtp87rWOhB6eSPWL3jTBf0frwpQDaWPD=H=w3skg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 7:01 PM Rob Herring <robh@kernel.org> wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
