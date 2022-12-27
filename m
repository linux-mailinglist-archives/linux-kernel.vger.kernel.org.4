Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54416567D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiL0HZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiL0HZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:25:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3E9C5C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:25:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3E50B80E0D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC428C433F0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672125904;
        bh=EpYmHkiSUxN6CZwyP7d8u5iSfObEZ3YEZ0QZYWo7V1E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bqcru/9vcz6jcEHf7HGz99ESH2beV5PzKZhtATL9RHpuVx6KyupSkQ3zsNrqU6lSI
         1HyptJOt9tYv0dau5nqFEJxts0IxFIWjRcJSP14DNQTEJkBL3PPj/9D1u7PCXs8z9L
         Sa7KxojvFUzD4WBzihGK/BQX1/Ss4JDLOzGGdZ7VFhBl1hy9oGxnyfkvveXr0HNAaj
         9gv21ZOAMuUOCmUEo9K7ZABdLZ1apV34Nx7p1kZTuyN8uPF62A75WXmwlKY0MfJg8j
         rpXKfeZ+jAdmwYQztU7hWIcqbYA83Bu6XzFSB9HYnH4/clusQ8IB2OIe4Pr+2OJ+0q
         i4JLmWZz95ToA==
Received: by mail-ed1-f46.google.com with SMTP id z11so2089910ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:25:04 -0800 (PST)
X-Gm-Message-State: AFqh2kqTE+ICveGoZ90ZOceNhjggAuaGpKANBnNyEvZ/63R0ASuJ6Vb0
        POPfpihw2kP73K3BiKY1c/50WSmIzPOqpeCl0BI=
X-Google-Smtp-Source: AMrXdXtHEczM2d2A7DOdruuCGEhCEEf5spIMxio62P/0bURuMuWgcO3LuNdOXidY7VCnDaWu0wcpPikrz8b9E7XHdTA=
X-Received: by 2002:aa7:cdc5:0:b0:470:327d:c46c with SMTP id
 h5-20020aa7cdc5000000b00470327dc46cmr1812602edw.298.1672125902905; Mon, 26
 Dec 2022 23:25:02 -0800 (PST)
MIME-Version: 1.0
References: <1671761320-31392-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1671761320-31392-1-git-send-email-tangyouling@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 27 Dec 2022 15:24:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H49QBCZNo-qUBR-oJ-5Oxbb8Dd7=fp5=7_+1FK_uR46qg@mail.gmail.com>
Message-ID: <CAAhV-H49QBCZNo-qUBR-oJ-5Oxbb8Dd7=fp5=7_+1FK_uR46qg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Simplifying larch_insn_gen_xxx implementation
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Huacai

On Fri, Dec 23, 2022 at 10:08 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Simplify larch_insn_gen_xxx implementation by reusing emit_xxx.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/loongarch/include/asm/inst.h |  1 +
>  arch/loongarch/kernel/inst.c      | 45 +++++--------------------------
>  2 files changed, 8 insertions(+), 38 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index c00e1512d4fa..a463b518a636 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -401,6 +401,7 @@ static inline void emit_##NAME(union loongarch_instruction *insn,   \
>  }
>
>  DEF_EMIT_REG0I26_FORMAT(b, b_op)
> +DEF_EMIT_REG0I26_FORMAT(bl, bl_op)
>
>  #define DEF_EMIT_REG1I20_FORMAT(NAME, OP)                              \
>  static inline void emit_##NAME(union loongarch_instruction *insn,      \
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 512579d79b22..badc59087042 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -58,7 +58,6 @@ u32 larch_insn_gen_nop(void)
>  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest)
>  {
>         long offset = dest - pc;
> -       unsigned int immediate_l, immediate_h;
>         union loongarch_instruction insn;
>
>         if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
> @@ -66,15 +65,7 @@ u32 larch_insn_gen_b(unsigned long pc, unsigned long dest)
>                 return INSN_BREAK;
>         }
>
> -       offset >>= 2;
> -
> -       immediate_l = offset & 0xffff;
> -       offset >>= 16;
> -       immediate_h = offset & 0x3ff;
> -
> -       insn.reg0i26_format.opcode = b_op;
> -       insn.reg0i26_format.immediate_l = immediate_l;
> -       insn.reg0i26_format.immediate_h = immediate_h;
> +       emit_b(&insn, offset >> 2);
>
>         return insn.word;
>  }
> @@ -82,7 +73,6 @@ u32 larch_insn_gen_b(unsigned long pc, unsigned long dest)
>  u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
>  {
>         long offset = dest - pc;
> -       unsigned int immediate_l, immediate_h;
>         union loongarch_instruction insn;
>
>         if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
> @@ -90,15 +80,7 @@ u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
>                 return INSN_BREAK;
>         }
>
> -       offset >>= 2;
> -
> -       immediate_l = offset & 0xffff;
> -       offset >>= 16;
> -       immediate_h = offset & 0x3ff;
> -
> -       insn.reg0i26_format.opcode = bl_op;
> -       insn.reg0i26_format.immediate_l = immediate_l;
> -       insn.reg0i26_format.immediate_h = immediate_h;
> +       emit_bl(&insn, offset >> 2);
>
>         return insn.word;
>  }
> @@ -107,10 +89,7 @@ u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj, enum loongar
>  {
>         union loongarch_instruction insn;
>
> -       insn.reg3_format.opcode = or_op;
> -       insn.reg3_format.rd = rd;
> -       insn.reg3_format.rj = rj;
> -       insn.reg3_format.rk = rk;
> +       emit_or(&insn, rd, rj, rk);
>
>         return insn.word;
>  }
> @@ -124,9 +103,7 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm)
>  {
>         union loongarch_instruction insn;
>
> -       insn.reg1i20_format.opcode = lu12iw_op;
> -       insn.reg1i20_format.rd = rd;
> -       insn.reg1i20_format.immediate = imm;
> +       emit_lu12iw(&insn, rd, imm);
>
>         return insn.word;
>  }
> @@ -135,9 +112,7 @@ u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
>  {
>         union loongarch_instruction insn;
>
> -       insn.reg1i20_format.opcode = lu32id_op;
> -       insn.reg1i20_format.rd = rd;
> -       insn.reg1i20_format.immediate = imm;
> +       emit_lu32id(&insn, rd, imm);
>
>         return insn.word;
>  }
> @@ -146,10 +121,7 @@ u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
>  {
>         union loongarch_instruction insn;
>
> -       insn.reg2i12_format.opcode = lu52id_op;
> -       insn.reg2i12_format.rd = rd;
> -       insn.reg2i12_format.rj = rj;
> -       insn.reg2i12_format.immediate = imm;
> +       emit_lu52id(&insn, rd, rj, imm);
>
>         return insn.word;
>  }
> @@ -158,10 +130,7 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
>  {
>         union loongarch_instruction insn;
>
> -       insn.reg2i16_format.opcode = jirl_op;
> -       insn.reg2i16_format.rd = rd;
> -       insn.reg2i16_format.rj = rj;
> -       insn.reg2i16_format.immediate = (dest - pc) >> 2;
> +       emit_jirl(&insn, rj, rd, (dest - pc) >> 2);
>
>         return insn.word;
>  }
> --
> 2.37.3
>
>
