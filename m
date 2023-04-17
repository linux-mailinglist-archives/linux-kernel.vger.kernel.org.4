Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04A36E42F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDQIxN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDQIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:53:11 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED394210;
        Mon, 17 Apr 2023 01:53:10 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id a11so2573187ybm.3;
        Mon, 17 Apr 2023 01:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681721589; x=1684313589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mu7Hch1DiBF07SUCPix+0KBbOFjQRP+x98Um6bdp30s=;
        b=PnFNdTtZt0Y1VO7EK9swxDnISYllCaoLyf9HKRMYdIzyUItfOxNBGrkUJn17s6WKBv
         WalPQxSm0ZoK7kT2HLqPJhXnuMxUDr3/HZ2TOxupnWaWMgIJXPlUMOry5iKoW3+xPzYz
         SQQjKwqt6mVMPLlVk9Vo68ZWRgK6pVhNquwWLyQSA2JNawL/cWLyeoAR3VlW9ayLrSCd
         tXVR63aaFW4hv4vN4uNXm7Xirjx9+UTVpc6hqSalQqVnQnJ14WAHX+0U3X8uEjuiGRqO
         L0+HrjEXk1eDKOz0wHRuR6nsTv2VrVgeG6E7as21nPsVpJyrUUB7F+f0zTkJihYVZtWq
         Uklg==
X-Gm-Message-State: AAQBX9fpUbVkVBOxjsJKV7TkmtbBkEizlM2GvDlyUDxKRspUCCPbxNEU
        BzCajKZhUbixjyrX+ZIa49HWGaHHQij6XA==
X-Google-Smtp-Source: AKy350ZG8hkUHJnT1YXwItDS1L2vqsB6KJizSd15YMzCphb/9lRvLHT4liN876LbbdcWGCZmqe1Cpg==
X-Received: by 2002:a25:1b04:0:b0:b8f:4bff:d54d with SMTP id b4-20020a251b04000000b00b8f4bffd54dmr14174999ybb.63.1681721589316;
        Mon, 17 Apr 2023 01:53:09 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id g8-20020a81ae48000000b005463e45458bsm3000559ywk.123.2023.04.17.01.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 01:53:08 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id m14so7515743ybk.4;
        Mon, 17 Apr 2023 01:53:06 -0700 (PDT)
X-Received: by 2002:a25:68cc:0:b0:a27:3ecc:ffe7 with SMTP id
 d195-20020a2568cc000000b00a273eccffe7mr11775312ybc.3.1681721586452; Mon, 17
 Apr 2023 01:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230412110900.69738-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230412110900.69738-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 10:52:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVe6DXpM5zQk-zitNTk17QiStusOTQcjTMVy6HnhXyq1w@mail.gmail.com>
Message-ID: <CAMuHMdVe6DXpM5zQk-zitNTk17QiStusOTQcjTMVy6HnhXyq1w@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] riscv: asm: vendorid_list: Add Andes Technology to
 the vendors list
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed, Apr 12, 2023 at 1:09 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add Andes Technology to the vendors list.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
