Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44461250B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 21:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ2TOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 15:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJ2TOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 15:14:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21526FAED;
        Sat, 29 Oct 2022 12:14:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt23so20299895ejc.7;
        Sat, 29 Oct 2022 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AJRIdsMw/IOATrytnmVavgGTGfe9xVPXjP+iBSme7yU=;
        b=EQiTJUYjRkrYfC1hDKqfmlKYDk13GZOfknnLeRcwKl12UuZsoQDMLOzMR72KnGAY/V
         LWbDk+Np2vAp6n638Q0pkyMSSycx3KcyywNuuhlKZ16UESJZVhrbqOveuKBdF593Vvc8
         hwmLXGgn6YDsd2ZyqaaP9JqJ5tJsogdluGr4IHv876tDDkVzuwnwFUZMlThsAIenFA5Z
         Z832cHjIRZq3u2zo0YmTqpTpwKgrM0yw2Qxr/iZY4yvT5fp1/r3TNZMuyJ4zGN4RM/t8
         GCx/ucQgaEZ9cb/lFVp3X82zytiS5aAurpGV2rxz+djYTx/QlGOF0YrvIXRwYS4deJDf
         upTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJRIdsMw/IOATrytnmVavgGTGfe9xVPXjP+iBSme7yU=;
        b=aZODLBVIU0WIxijaGysg1Y3NwoWnXnlv38C0czlRo03vn3Nz2iHssfxTXmH8Ir9L7b
         viBayUZ66LgVCR8DTcRrMDlRkTPKeMSF1NunNhuskkRMyXheTqgEN7UCYLtOmniID5hg
         82HJljCyXLj7iyj8UhTnpYqpbr/byniiSkS0inTmEY0uBeKnXxjkx+iJt3T2YVNfJGCP
         Nk/5nZt++9GNt1T2ytiecH8/r/GEER0GTfR1OsKkVNWgAjoWxwA5hIw3MzaMgdDdWPcr
         5ojZ6zQuAd39ZJt0c6rPMQg0UPhrQ6Qm7/lqM9cv3t6/hNI7Nz/jDHHduFtInwdv8Tc2
         UXjw==
X-Gm-Message-State: ACrzQf1yYe17BmR2XZ3qFS2O29UuwQw/NXewudpgdAGx9gpN/+8MycLB
        RJH5TPiJ4OU7wQjMD34WzX8Dvk6ZaqOgMOkuTmY=
X-Google-Smtp-Source: AMsMyM5SayRe8eI5BmOIfBcPwMVf1RiS3yjxDSbTADPEcsw84802zGEC7OlnAiyqYT9YXCe+QIOgNcTI416kZVLx2Rg=
X-Received: by 2002:a17:907:270b:b0:7ad:ae01:e0d9 with SMTP id
 w11-20020a170907270b00b007adae01e0d9mr4392845ejk.196.1667070868665; Sat, 29
 Oct 2022 12:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAJF2gTQn+6pTjuiGf-febHhDHjVeJ78Zdywd+EkteeO0MEUGaw@mail.gmail.com>
In-Reply-To: <CAJF2gTQn+6pTjuiGf-febHhDHjVeJ78Zdywd+EkteeO0MEUGaw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 29 Oct 2022 20:14:01 +0100
Message-ID: <CA+V-a8ugVeUB5qCG0CtTZHr43WXqv13-GBLRG9X1n_62LtJ4Aw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Sat, Oct 29, 2022 at 5:26 AM Guo Ren <guoren@kernel.org> wrote:
>
> This should combine with the previous one, which makes the patch complete.
>
For easier review purposes we tend to have separate patches for SoC
and the board on ARM/64 which is what I have followed here. If you
insist I can merge this along with the SoC DTSI patch.

Cheers,
Prabhakar
