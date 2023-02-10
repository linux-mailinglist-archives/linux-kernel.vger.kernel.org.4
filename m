Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7B691DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjBJLKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjBJLK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:10:28 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA1B71014;
        Fri, 10 Feb 2023 03:10:19 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id o42so853356qvo.13;
        Fri, 10 Feb 2023 03:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpyfNMsIf7u2o4EXgAx33Jd/nnkTR0WPsrSKRqooKc8=;
        b=Qx5OQ6pWRZE+5bpapzGgKMYRHckAqDhnCCETUwVGuCl2QZ+9Wa2zg3hrPi+JGRDYF+
         6mLE6HdPRhF/MXt49oitQE1uz9H3SOhHVICzgpM3VBpQrDc3TnwxqiElUam395cMBJFT
         1HXcH5Z73bVNIA511pf3K3X6/WNtlK07jBa2ZBxsYGxZfkhqlpX/RPsf9gJW5NiUkcV2
         6sbeDsfBElZ3ZCjHMRft7mU9DW4u77dlaGwR/IRRwifmOf/IfFGojxLtg2zeTlSSqopX
         kxweW/7ve+e5hfeGdZvNdiVwMsH2bxYFJrH6oaHr6KlzIOpYMt1Fy5JIzMankrJ+RshH
         vFow==
X-Gm-Message-State: AO0yUKXcbJhANQEz2+xVMXR+BBKLnkW1GUNdlYwYP1JPOajHomrPvKIn
        5sZKv/ws790unaAGnYP1Comw7QukFfpkNnAi
X-Google-Smtp-Source: AK7set8Bl93dMMA44zVRXTfNjmAQZ4kWE/Tx+Wbw/esI5vUsOtjm3Dt6WDyoG4SR4rAfXlRb2lFWzg==
X-Received: by 2002:a05:6214:4104:b0:56b:eb9d:4342 with SMTP id kc4-20020a056214410400b0056beb9d4342mr25437340qvb.49.1676027418739;
        Fri, 10 Feb 2023 03:10:18 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id v129-20020a37dc87000000b0071df8b60681sm3452600qki.94.2023.02.10.03.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:10:18 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-520dad0a7d2so63208417b3.5;
        Fri, 10 Feb 2023 03:10:17 -0800 (PST)
X-Received: by 2002:a0d:e9c1:0:b0:514:a90f:10ea with SMTP id
 s184-20020a0de9c1000000b00514a90f10eamr1412958ywe.316.1676027417617; Fri, 10
 Feb 2023 03:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20230206002136.29401-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230206002136.29401-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Feb 2023 12:10:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUXXrYPcNiD3M_ONjX2Jn16KKXdY=4JMqJbm9F=9GMBvA@mail.gmail.com>
Message-ID: <CAMuHMdUXXrYPcNiD3M_ONjX2Jn16KKXdY=4JMqJbm9F=9GMBvA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: Drop specifying the
 GIC_CPU_MASK_SIMPLE() for GICv3 systems
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Mon, Feb 6, 2023 at 1:28 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The GICv3 interrupts binding does not have a cpumask. The CPU mask only
> applies to pre-GICv3. So just drop using them from GICv3 systems.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4...

> ---
> Note, this patch applies on top of [0]
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

As this patch is a fix, I think it makes sense to drop that dependency.

So I'll do

    git show -- arch/arm64/boot/dts/renesas/r9a07g044.dtsi | sed -e
's/044/054/g' | patch -p1 && git commit -a --amend

while applying.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
