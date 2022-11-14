Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32977627754
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiKNITk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiKNITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:19:38 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952772DD8;
        Mon, 14 Nov 2022 00:19:37 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id h10so7368151qvq.7;
        Mon, 14 Nov 2022 00:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1f6hcexQwRSjpPtI2b6I+pAA5eVX0oLT0ZXtJfpdDAY=;
        b=q26T2PjvHvqj3Rnj5sDwXsG4pVQxNyUa1R12sYMmxxmfYdUiELkR3/4WeeSHSVjfN+
         GnSnFi5XeNQRJPdS46wGOh7ORO+AyVBKUO0zFawS4HaNLh5+hvFqTgcgDo7os29+4oDY
         9hG1tP9b6j//2SLAyYZuw4pPwJywZG8Bwu8gPZ/iCWxhX2hQoMWUI2wdqeD1Qt3raoX8
         iJsS9KwAWjYDP/Rcqtf9R047nNRbf1Z9UMQY6AbUR1ni0dsJezjFAuIoVK2axC5C1Fau
         5y7NtH0nFsVEGdCdvhObYVR/hHhk6n0+wKjy5WPPLLHiwZYwHl/8v38xju71iUknl/k+
         L/tg==
X-Gm-Message-State: ANoB5pmc4LImhEWTvIHaA2RfK6rOhxmGTuruwHnQ3lkuagezHaoma+30
        DmL412zKfGAYc4ZMZkkTZogsXwnPqcqfKw==
X-Google-Smtp-Source: AA0mqf7QYK0OC4H8/Mw2w7H/+IuvIJwGK6s5kDIZ+o4lozpfmFr1tpvmiWpgEm6b/AjtY0i7rcA4FQ==
X-Received: by 2002:ad4:43e2:0:b0:4bb:701b:f217 with SMTP id f2-20020ad443e2000000b004bb701bf217mr11417677qvu.46.1668413976620;
        Mon, 14 Nov 2022 00:19:36 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id br38-20020a05620a462600b006cfc01b4461sm6153472qkb.118.2022.11.14.00.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:19:35 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id r3so12556666yba.5;
        Mon, 14 Nov 2022 00:19:35 -0800 (PST)
X-Received: by 2002:a25:cb4a:0:b0:6dd:b521:a8f2 with SMTP id
 b71-20020a25cb4a000000b006ddb521a8f2mr11133712ybg.380.1668413975373; Mon, 14
 Nov 2022 00:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20221111212857.4104308-1-robh@kernel.org>
In-Reply-To: <20221111212857.4104308-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 09:19:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXT_+_afxBW6=dku+Y1ea8GTaWznM5vzXO7bYQ1Z8sRwQ@mail.gmail.com>
Message-ID: <CAMuHMdXT_+_afxBW6=dku+Y1ea8GTaWznM5vzXO7bYQ1Z8sRwQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop type from 'cpus' property
To:     Rob Herring <robh@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:29 PM Rob Herring <robh@kernel.org> wrote:
> 'cpus' is a common property, and it is now defined in dtschema schemas,
> so drop the type references in the tree.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

>  Documentation/devicetree/bindings/power/renesas,apmu.yaml   | 6 ++----

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
