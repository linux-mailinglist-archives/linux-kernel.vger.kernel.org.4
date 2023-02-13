Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC536947BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBMOK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBMOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:10:55 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FDD10258;
        Mon, 13 Feb 2023 06:10:55 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id cr22so13754129qtb.10;
        Mon, 13 Feb 2023 06:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgaxEZgP/aHK2LwLwDWflJdoNQsljt9UM71CZ67CXiU=;
        b=ax9okrZp0c7koxWFazHaRkR2J2vngyXO5OacAMMFQ+GllxPcNTAJv8DQDEfAWPmBDH
         V7B6JskldIZ7QI+B616h/QKOmdICfDhZ5nG+y2jf/od+vwHS5yUVK6wbNrkthcm0R/Xp
         KJE6ydaVCimzJGIPdbNEUoosNdBibNkDrVMj8ssJsZUxr6XML0MM2IXuwsVtx2sGh6xw
         wtZB5lGpzCV6YMqMaogFZcofH/Ad3GYCv1+3MGovBovUdEt2m5zeGAw6CdA3wg1McTxZ
         1oPlOd3VdblrzkBLfWFDWQab28AqReQOXBAGZuQXAeoy35+JX7A92cJoHmWDeUe7t1ED
         ENMA==
X-Gm-Message-State: AO0yUKXdcPwmuS0YdoRUlzytp0AXwyt+/7FUj7woITM3EXcwsv/g3gAB
        u4ZuulF8+NOoa/XwmRAbztDhEpBHgoTnHg==
X-Google-Smtp-Source: AK7set9IIOAHHeelxfPs0MmWFK7XgKzNIvMY9DPGTlMEohCK46/LOb0nsWyfCN7CUrFX4mzzETDrSw==
X-Received: by 2002:a05:622a:1aa0:b0:3b8:6a9f:9144 with SMTP id s32-20020a05622a1aa000b003b86a9f9144mr44048051qtc.46.1676297453916;
        Mon, 13 Feb 2023 06:10:53 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id d186-20020a3768c3000000b006fa7b5ea2d1sm9750768qkc.125.2023.02.13.06.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:10:53 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id o66so8584946ybc.0;
        Mon, 13 Feb 2023 06:10:53 -0800 (PST)
X-Received: by 2002:a25:9348:0:b0:8ba:81cd:a7b7 with SMTP id
 g8-20020a259348000000b008ba81cda7b7mr1436536ybo.270.1676297453183; Mon, 13
 Feb 2023 06:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230131223529.11905-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230131223529.11905-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Feb 2023 15:10:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=6uSY2_cZDgzQg-81e00Jhys497mLAT5ni1knAWqnSw@mail.gmail.com>
Message-ID: <CAMuHMdU=6uSY2_cZDgzQg-81e00Jhys497mLAT5ni1knAWqnSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: renesas: r9a07g054: Reuse RZ/G2L SoC DTSI
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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

On Tue, Jan 31, 2023 at 11:43 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> RZ/V2L SoC is almost identical to RZ/G2L SoC hence re-use the RZ/G2L SoC
> DTSI and just update the compatible strings wherever required.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Sorted the nodes based on the names

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
