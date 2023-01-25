Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8121067B30C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjAYNLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjAYNLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:11:44 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A658998;
        Wed, 25 Jan 2023 05:11:21 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 188so22877587ybi.9;
        Wed, 25 Jan 2023 05:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxVCkDNhqWiy/aUzQthd7MqU4/qZxhUdL9lWn/Iwbq8=;
        b=XSXqTZIR0afM0ZNzMqsAc0f3iodINERt6hzBX2BEVLUKLgz0FiIjsLCTyn4EncxsPm
         7+Agh9zfGuX6/dQ4AoNZhcTXvnNiDUOUwPC2XuOLvI/2Wd03xumb4m9xcjPuS/KyBjIY
         MzMYHvJukL15UaEp18yNFL6JCtJ6bLV8MeHD8f+kItMH7bbEX54+OBZ4DZHSV+wpCt6e
         HUNq2Ql6pZ0PeRZgpcn7KejP2yNivmSVhuhIsUTw28CaCHLQxHE7T8cFAoeTeAHz53Xm
         xkm4aUMZxRXjYsA7LmNo6zA9xPpE9/xq5sIUQjUhbPe970jF8qU2PVKjzhgZ6D4VNsfK
         l7QQ==
X-Gm-Message-State: AO0yUKWZs7TPFDg7Xpb2bY9JlT3ysWKKiKdoLLrq9r1gqnw/fHYUuwYZ
        ooOLAZwwrob1/FrG+Jur3Krxdlo8xy9G9A==
X-Google-Smtp-Source: AK7set8D9NZ42eAGmm7BXz7WrXvLBVXRQFjD3bYEJ5td3gXoLVVydzZ3WT56OkRXkoB//vkoKQqp3A==
X-Received: by 2002:a25:f623:0:b0:80b:af06:bb07 with SMTP id t35-20020a25f623000000b0080baf06bb07mr964596ybd.27.1674652280116;
        Wed, 25 Jan 2023 05:11:20 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9f805000000b0070d10ecb4besm3464570qkh.1.2023.01.25.05.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 05:11:19 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-501c3a414acso197941567b3.7;
        Wed, 25 Jan 2023 05:11:19 -0800 (PST)
X-Received: by 2002:a81:4b02:0:b0:507:6027:60e7 with SMTP id
 y2-20020a814b02000000b00507602760e7mr84672ywa.47.1674652279303; Wed, 25 Jan
 2023 05:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20230117232609.477247-1-aford173@gmail.com> <20230117232609.477247-2-aford173@gmail.com>
In-Reply-To: <20230117232609.477247-2-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 14:11:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnstJNjkKgD=fPXvCUjqbGZhtwciSF+RrN9RzA2yGUWg@mail.gmail.com>
Message-ID: <CAMuHMdUnstJNjkKgD=fPXvCUjqbGZhtwciSF+RrN9RzA2yGUWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: r8a774e1-beacon-rzg2h-kit: Sync aliases
 with rz/g2m
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jan 18, 2023 at 1:16 AM Adam Ford <aford173@gmail.com> wrote:
> The Beacon Embedded RZ/G2[MNH] boards all have the same baseboard
> and all share the same PCB.  To make sure all instances appear
> the same, make the aliases for RZ/G2H match the RZ/G2M to
> keep them consistent.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
