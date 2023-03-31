Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73946D18B8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCaHhU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaHhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:37:17 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE67199B;
        Fri, 31 Mar 2023 00:37:17 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5463fa0c2bfso69789997b3.1;
        Fri, 31 Mar 2023 00:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMCPBKqa5X7qdxmutmPXldx9K7gy/4RLJ6RttIJMQZE=;
        b=bYb5Hlx4fJLVvInPcmj4uLtRfeQvc5uPYKTCLQhd5IGqZ4b8UbpdDBn0zEof7dJT7M
         lpZ29AZNfPpaDgI+fXN4Qd4jy3IGonC+WUrfu/aIaQosCFG4e60FCxSsvRjr1YBPUEXi
         KxwfvZZCzXEUBL8mBIYK5/Z1PqEuWLGlikzBcJaG5auq6Uw6GFWyUEOSt4tvqf1CfsRi
         VvvzGVuwOrqVOGb+kyKubMPHDJCfORjJnTEvjDIjK0m0qsEVTujdanTo5Zefu+bV6W4d
         MSQ0UeEJz8d7ukhx4JKcR2WTq1wD+SAFdkfNst9nZCRTdW61hU4uembXzjgBGOYFJM03
         DQZg==
X-Gm-Message-State: AAQBX9c4PvbXZ9Ge3Oh7ZJCm7387MvT6pj8p+z/poqy+tJUQHMRT7RQV
        Fo83X+IBT+3LIPBc/IelV3XatDke6+N9W6fl
X-Google-Smtp-Source: AKy350YKTTRDcNXIjTfJDfEOv4ZMgswwLd47ihrHjWmjOf9Eca3Yfg5BdZ4ylcvIVx3BEFa4Sm/M7w==
X-Received: by 2002:a81:6141:0:b0:52e:cd73:f927 with SMTP id v62-20020a816141000000b0052ecd73f927mr22476359ywb.48.1680248236195;
        Fri, 31 Mar 2023 00:37:16 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id l133-20020a81258b000000b00545a08184e5sm368272ywl.117.2023.03.31.00.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 00:37:15 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id f188so7980218ybb.3;
        Fri, 31 Mar 2023 00:37:15 -0700 (PDT)
X-Received: by 2002:a25:24c3:0:b0:a02:a3a6:78fa with SMTP id
 k186-20020a2524c3000000b00a02a3a678famr13492502ybk.12.1680248235245; Fri, 31
 Mar 2023 00:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230330204217.47666-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230330204217.47666-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Mar 2023 09:37:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWz=Vf1svs3TJrCSq8ED0rEy-NURQ++bUspo73zfct50A@mail.gmail.com>
Message-ID: <CAMuHMdWz=Vf1svs3TJrCSq8ED0rEy-NURQ++bUspo73zfct50A@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] soc: renesas: Kconfig: Select the required configs
 for RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
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
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:42 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Explicitly select the required Cache management and Errata configs
> required for the RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
