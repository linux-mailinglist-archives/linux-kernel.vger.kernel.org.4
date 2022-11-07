Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A061F9D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKGQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiKGQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:31:29 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A925C4F;
        Mon,  7 Nov 2022 08:29:55 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id h21so7177121qtu.2;
        Mon, 07 Nov 2022 08:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22NI28i4eJIAWoI0KP/jA56ElTKsufgBluLSOD3bIFI=;
        b=7rYAy88iB+wyLgcxbqMHbXFaeVYWz3pplarcHM+DBq9V1CpQA8HkLFJ03lJtS4NLas
         6MLfrS7Y+3seGe27AzoaMD8qKDnpqgYc/EnYx2rEW27h7LLF+OV0NjnXDR9QEGLJJid/
         2EQywbuYoelCPKfRjrY5SzHDZ49mlBL3I1lxlwSWXK/5VJNwK8/m8v2u+2b1VDQkP7xN
         +iz4V90Fsyb8S6Xk03RqisKOq+8wrGI8bl+Hijt4H331QigwjSSSN3sPcTQbCaA51O0Y
         7mVdMXX6/MDRRnWmuVk/mHf2vieeDoRZ3uy1VTOkYCDmLFeYRiZlyYGVR1JeeMndo8c4
         LTbw==
X-Gm-Message-State: ACrzQf1QCNsaWys6JlDzZEuxzNSBm8w1bVp5Gpw3oXh5vxcF14c9QbV8
        dyz8RkcPeB2Pl2EqQQCPafcrw3tbmhYChw==
X-Google-Smtp-Source: AMsMyM7udqnDmC1YLE6yEF61A91uHF2dmxXp8nDbmTdTpW7kGg83DMyv1sw+K6iIObtAtRUkEa3Grg==
X-Received: by 2002:ac8:7281:0:b0:3a5:3e54:694 with SMTP id v1-20020ac87281000000b003a53e540694mr25806432qto.647.1667838594114;
        Mon, 07 Nov 2022 08:29:54 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id i5-20020ac871c5000000b003a494b61e67sm6325156qtp.46.2022.11.07.08.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:29:53 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id j2so14250516ybb.6;
        Mon, 07 Nov 2022 08:29:53 -0800 (PST)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr46548846ybb.604.1667838593097; Mon, 07
 Nov 2022 08:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20221104151135.4706-1-wsa+renesas@sang-engineering.com> <20221104151135.4706-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221104151135.4706-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 17:29:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW1jNGBJgdfgS=3=FbK3VTHe-ZZ08CSEwdDrqv5C2FSwA@mail.gmail.com>
Message-ID: <CAMuHMdW1jNGBJgdfgS=3=FbK3VTHe-ZZ08CSEwdDrqv5C2FSwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a779g0: Add CMT node
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Thanh Quan <thanh.quan.xn@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 4:11 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Thanh Quan <thanh.quan.xn@renesas.com>
>
> Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
> [wsa: merged the fixes into this one and rebased]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
