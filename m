Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0874969696C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBNQ0E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Feb 2023 11:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBNQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:26:02 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250AD2C669;
        Tue, 14 Feb 2023 08:25:40 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id ch10so16965306qtb.11;
        Tue, 14 Feb 2023 08:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XujjaNJzottOxlelqCCl+jhNTWReue3n2BPGfmetq2w=;
        b=WhGgZ6oHuRekJymi5yZ7z98G22L2lVPz+7cgOPqHGvhYE2HF0LPwQmizdiHGXJp8Ee
         sIcFQUk7CmFb4OZDpQ2mHw1yQg+bPWKVBpf2utHkpiR9yQzMHnqBn2YQqTiRXSqZwYyp
         TJmBp0MEWOStIckH9XCrCv8PmsOTkJQ4CvXvuQIiCzlVMb/6PfAchNv4gy8+xngj+J6r
         sBTeIDyIYelKohb4THL7v1B28Kc0Oc35RWnJYDczgKdkJPrE8z6x0tZF0MZ9rIcbWQxH
         +zOyfMTyop7Qwpyl5R3BNgN36uwhf4gKODU1CzJO3n2TbTp9PJ5sSxvZsLmq1Lk72UAC
         ZVKg==
X-Gm-Message-State: AO0yUKUuHd8jHOM/GhqJoHqtORRzRwOkjx7b9eJRj4owY5CwkL5+0alC
        IThi9ggnFNsbh2OdIfDU6uKg+gMQELq41SE2
X-Google-Smtp-Source: AK7set98/yGDmwGxwJ7myczyPkqosAoYdjRZjZ42a9oxRf8OyUQf0fLOl6Och4ondYozHFIs33+ZbA==
X-Received: by 2002:a05:622a:307:b0:3b8:118d:83d9 with SMTP id q7-20020a05622a030700b003b8118d83d9mr4658014qtw.4.1676391915917;
        Tue, 14 Feb 2023 08:25:15 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id g4-20020ac80704000000b003b63b8df24asm11326845qth.36.2023.02.14.08.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 08:25:14 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id b1so7718496ybn.2;
        Tue, 14 Feb 2023 08:25:14 -0800 (PST)
X-Received: by 2002:a05:6902:4ec:b0:939:2fb5:36b4 with SMTP id
 w12-20020a05690204ec00b009392fb536b4mr363934ybs.270.1676391914633; Tue, 14
 Feb 2023 08:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20230209133507.150571-1-clement.leger@bootlin.com> <20230209133507.150571-2-clement.leger@bootlin.com>
In-Reply-To: <20230209133507.150571-2-clement.leger@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Feb 2023 17:25:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFi9FhsNw6KGWW+5+qQ_NUx035yXAXS-juyqAux6jPnA@mail.gmail.com>
Message-ID: <CAMuHMdVFi9FhsNw6KGWW+5+qQ_NUx035yXAXS-juyqAux6jPnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: renesas: renesas.yaml: add
 renesas,rzn1d400-eb compatible
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 2:32 PM Clément Léger <clement.leger@bootlin.com> wrote:
> Add "renesas,rzn1d400-eb" which target the RZ/N1 EB board when a RZ/N1D-DB
> daughter board is plugged on it.
>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
