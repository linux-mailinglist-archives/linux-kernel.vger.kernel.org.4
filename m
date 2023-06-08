Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B827285CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjFHQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbjFHQvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:51:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB39E50;
        Thu,  8 Jun 2023 09:51:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso1035230e87.0;
        Thu, 08 Jun 2023 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686243095; x=1688835095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfBd7IwFmk3YrhG+ik/Edcn1cuNHHU9CIjX4DWK6Ixo=;
        b=lXA9AbUvrD2ebTkRc27wxG4izZ7jVGYa+YdV7EpHMAwPtD4Sn8HWAE2GCkm3hjfDz9
         7WF/TMFcWceR2V9lGMNE2KvT7vx9rjui8IP1R22qbEkJnrozM7gv4MwvF7651FuzqWAi
         b75mRRVMTodNDRkwv3fWM2qa7EBJGM0fmRdAkETXHBGGYNxy+URJttC1wabhR1ZVTZqn
         McKvLBFBNjRd9fzncGkQW4RrK5yc7kuRFrv4HPAADdgPXZ8kwW2WR9tYSaSUQJJjs4AT
         3SeABEBlclQCrp8h7ROfl0xJbyrW+aA+D4WMMi1ejI5+ktyJ6qMYrQ1MhCO1Aqwz+jHI
         //og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686243095; x=1688835095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfBd7IwFmk3YrhG+ik/Edcn1cuNHHU9CIjX4DWK6Ixo=;
        b=Ybh8avHSHgPXF48FflZzv6/WmBt7jmJtZqXVQJUjYP1EPA8dXcCZB5a5Nmvbt+07lN
         /lOG+nmPgADXzYvt84kgTPKNDpcD3Y77LUNfMUd4NH/Tu9ElkV0lZ2ECmRs15ljcSwPV
         TgSoBLrKPBHOeuAt1UkGNJ73bU5BsjZ6SRMlxNFxJ/V3t9B2pybiWQyp4lpSbWG+X3zZ
         YStzYwjWgQqGoCTH6eQZJs/1ZJKPb4/3vWc39YDrjwhRvkha9qYRL8mOlQnqatJVoVWT
         4ZTVd1VeT6S7THUCgsN/CrAsHZG1M0GCOOHCEuh4fJ/Qsj4VE62xEZ2nhnCQGCDakmJ4
         yxBQ==
X-Gm-Message-State: AC+VfDy1PlZCoLVhKC/0FX1bcMiT/864B9JSBgjE+OhV54mLBLPB1qCe
        /11XbAKu6LPjTU7S+2+yGfgsxFdWpkXFPw2v+0Q=
X-Google-Smtp-Source: ACHHUZ5eAnlqAQECMWH9LJy+Vn3yo1r4QTBfQ29lZcf0jRGXhgoRuls5VwKQQfBfufqpme1QgPwwdeK5+JYb3Va3dfY=
X-Received: by 2002:a2e:94d7:0:b0:2ad:b9ed:5498 with SMTP id
 r23-20020a2e94d7000000b002adb9ed5498mr3274541ljh.24.1686243094745; Thu, 08
 Jun 2023 09:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230607091814.46080-1-puranjay12@gmail.com> <20230607091814.46080-4-puranjay12@gmail.com>
 <CAPhsuW7soOQasGw5fHB2qTeJnqR4ZrGBodyO87k=vg=TYqCsWA@mail.gmail.com>
In-Reply-To: <CAPhsuW7soOQasGw5fHB2qTeJnqR4ZrGBodyO87k=vg=TYqCsWA@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Thu, 8 Jun 2023 18:51:23 +0200
Message-ID: <CANk7y0ihF2RvwGXK0p0gOaGrMoPxfb6fcfn3-J40zn8LS8vROQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To:     Song Liu <song@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Thu, Jun 8, 2023 at 6:28=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Wed, Jun 7, 2023 at 2:18=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
> >
> [...]
> > +
> >  static inline int epilogue_offset(const struct jit_ctx *ctx)
> >  {
> >         int to =3D ctx->epilogue_offset;
> > @@ -701,7 +716,8 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
> >                                  struct jit_ctx *ctx,
> >                                  int dst_reg)
> >  {
> > -       off_t offset;
> > +       off_t ins_offset;
> > +       off_t fixup_offset;
>
> Please add some comments for these two offsets.

Here I am using two variables because I need to change from the RO
buffer for calculating offsets
to the RW buffer for writing.

Earlier, a single variable could work because it was being reused for
calculating the second offset
after writing the first one. Here, I can't re-calculate using the same
variable because I have to change
to the RW buffer, and using the same variable would need changing back
to the RO buffer.

So, I am calculating both offsets first, changing to RW buffer and
writing both offsets.

But I will add comments explaining what these offsets are being used for.

>
> >         unsigned long pc;
> >         struct exception_table_entry *ex;
> >
> > @@ -717,12 +733,11 @@ static int add_exception_handler(const struct bpf=
_insn *insn,
> >                 return -EINVAL;
> >
> >         ex =3D &ctx->prog->aux->extable[ctx->exentry_idx];
> > -       pc =3D (unsigned long)&ctx->image[ctx->idx - 1];
> > +       pc =3D (unsigned long)&ctx->ro_image[ctx->idx - 1];
> >
> > -       offset =3D pc - (long)&ex->insn;
> > -       if (WARN_ON_ONCE(offset >=3D 0 || offset < INT_MIN))
> > +       ins_offset =3D pc - (long)&ex->insn;
> > +       if (WARN_ON_ONCE(ins_offset >=3D 0 || ins_offset < INT_MIN))
> >                 return -ERANGE;
> > -       ex->insn =3D offset;
> >
> >         /*
> >          * Since the extable follows the program, the fixup offset is a=
lways
> > @@ -732,11 +747,20 @@ static int add_exception_handler(const struct bpf=
_insn *insn,
> >          * modifying the upper bits because the table is already sorted=
, and
> >          * isn't part of the main exception table.
> >          */
> > -       offset =3D (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
> > -       if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
> > +       fixup_offset =3D (long)&ex->fixup - (pc + AARCH64_INSN_SIZE);
> > +       if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
> >                 return -ERANGE;
> >
> > -       ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
> > +       /*
> > +        * The offsets above have been calculated using the RO buffer b=
ut we
> > +        * need to use the R/W buffer for writes.
> > +        * switch ex to rw buffer for writing.
> > +        */
> > +       ex =3D (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image=
);
> > +
> > +       ex->insn =3D ins_offset;
> > +
> > +       ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
> >                     FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
> >
> >         ex->type =3D EX_TYPE_BPF;
> [...]
> >         /* And we're done. */
> >         if (bpf_jit_enable > 1)
> >                 bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
> >
> > -       bpf_flush_icache(header, ctx.image + ctx.idx);
> > +       bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
> >
> >         if (!prog->is_func || extra_pass) {
> >                 if (extra_pass && ctx.idx !=3D jit_data->ctx.idx) {
> >                         pr_err_once("multi-func JIT bug %d !=3D %d\n",
> >                                     ctx.idx, jit_data->ctx.idx);
> > -                       bpf_jit_binary_free(header);
> >                         prog->bpf_func =3D NULL;
> >                         prog->jited =3D 0;
> >                         prog->jited_len =3D 0;
> > +                       goto out_free_hdr;
> > +               }
> > +               if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_heade=
r,
> > +                                                        header))) {
> > +                       ro_header =3D NULL;
>
> I think we need
>        prog =3D orig_prog;
> here.

I agree, this is a mistake from my side.
I will add this in the next version.


Thanks,
Puranjay Mohan
