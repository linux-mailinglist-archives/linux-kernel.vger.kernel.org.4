Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698DE5BE5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiITMez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiITMeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:34:50 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545FF19018;
        Tue, 20 Sep 2022 05:34:49 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id w4so1892514qvp.2;
        Tue, 20 Sep 2022 05:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DScy5TK0GP5AqTqFl701GW46IDwtxGgy76xOd2cvfOc=;
        b=rAedqHJCKUz1FFJmPMPtQFFJzRU95uT9J02jZeqB0yClI3gMUlERSieH5tMqeYTq3X
         j13bqfPAEi0FKuYgeODQpVHxKHaHj8eyDPRfjqWiMWqNf7oHTRdS24hktUqLnV55TSl7
         T99b783aEo710bqQdKV0qY2JDgLulYuuWrOMXMM+WgCZ/FKyN5K/V2LVFJfuxG9pw5Hp
         7N2M6PayLrTdUVA5geCetTQtnv5PNdBqo1ttgXc7QaQu4Y9TsNpL9ZHUCobv0NyKmpfa
         LAWGZK1D8uA6mSTWG85u8DIpdTAlEjrcdKLKZsb6bpywT7ufS7z45gPcGhD6T2esAG9n
         6XGQ==
X-Gm-Message-State: ACrzQf21txhdIgMOGLaX8ZWfivTVMiGQOlKT2rXlR4EwzxDYs1HMfsul
        QCyHbRorxQ8zN0zoMMQmtV9TU87+9PfOFA==
X-Google-Smtp-Source: AMsMyM6C+shd7dihay6XlWt6Es6bG/q9Kks5AstAoKM8ZXJJCPjKFCXaa2i2xJf3lz6Jx9zqjfT3Gw==
X-Received: by 2002:a0c:8d85:0:b0:497:8b1:d372 with SMTP id t5-20020a0c8d85000000b0049708b1d372mr18938386qvb.68.1663677288043;
        Tue, 20 Sep 2022 05:34:48 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id i11-20020a05622a08cb00b00342f844e30fsm875816qte.31.2022.09.20.05.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:34:47 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p69so3233938yba.0;
        Tue, 20 Sep 2022 05:34:46 -0700 (PDT)
X-Received: by 2002:a25:3746:0:b0:6b1:4a12:b2d5 with SMTP id
 e67-20020a253746000000b006b14a12b2d5mr16262084yba.89.1663677286562; Tue, 20
 Sep 2022 05:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220915181558.354737-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915181558.354737-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Sep 2022 14:34:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWOGRpdG5=GLHc=fySqn7ErHtO0c91bJsgOO+Bp1ZUoA@mail.gmail.com>
Message-ID: <CAMuHMdUWOGRpdG5=GLHc=fySqn7ErHtO0c91bJsgOO+Bp1ZUoA@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] MAINTAINERS: Add entry for Renesas RISC-V architecture
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Sep 15, 2022 at 8:17 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add RISC-V architecture as part of ARM/Renesas architecture, as they have
> the same maintainers, use the same development collaboration
> infrastructure, and share many files.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> * Merged as part of ARM

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
