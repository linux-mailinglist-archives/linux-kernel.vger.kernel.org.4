Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACD74DC23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGJRTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGJRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:19:46 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B041D128
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:19:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a3b7fafd61so3896450b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689009585; x=1691601585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf12W3QMfs8wvFJMdqGBjbgKzWxSCEjVtEY7fJMchAc=;
        b=chZ3x25f3s+60NDSQ0WbJLU67n5riu5akD7uta1MmfBjYnD3qhkRXaV0MzbYTUHLy6
         nd6s8ypIqSXuEYguSk2epTD+HY2nKcsH7+8Nq6ARy29Ake00XMOMiU8bW9kHSku0ijGh
         gWM+0qwflHgKVV77vvm5DnHzKuRVTLTfhMjVZ8aKiQT50Vx642VdCB28Ur2c5vLwx6bo
         41efc6E5X4IrXzuf36jSg4msj9szH4161XIK/ogVfkjONxSm5zR7Ks0lIapYZJ3SIqHD
         vzmA8RNS1vU0U1nqSiaRG04Gn2Rvc24Q9I1r3R4/JoGa26zj0kMmrrzETon7cZIZioLX
         PD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009585; x=1691601585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf12W3QMfs8wvFJMdqGBjbgKzWxSCEjVtEY7fJMchAc=;
        b=HJfD+XNK4kecefBGLBehdVmzcMZ1ktjr7+m6eM7d9p0GK+rXqErL1MgRINqS1bXJ+9
         rkn8brD6UH94Enj4JThsB0Qc4PDOyrtTrv3tU7YFqzFhDZjAIyKcx8SUIcXTNuP3eKWR
         bwTONp4A8PHuwyX0hzAyQV6FbgxcveBk1BXTQTnBgZ8ne1kYmwtnA8lqkDc8u2SqoyO5
         50JVdoFtUfAT4A4B31m14sVtVy0x5qYpMNFHsF9gh8k3+014kDPxZ2Ffn9T5oAHnD4Er
         Pmcgcx7nY+eB1EiVLy7tI5WSeW2j75k2KRfrtk3UmNubjgGX3QW/+rLSgdgrAnw+ZTt6
         qR4Q==
X-Gm-Message-State: ABy/qLbkmoINI2GGF4tJS1FYiBomZjvpfJxLmTb+f6YcDS6SJmmUol2+
        h7F9pNle8eotiSSJ6Irtkwt49/2S41JmLfuwcNivrA8V
X-Google-Smtp-Source: APBJJlFM8ZDKgVy49NDz3B7j5aBzgSQO8+18VJjfx3IzNM4skrvEF5DbrZ/rJnoOmaNfdNeaUCY50FaGuUWZ6sqIjmY=
X-Received: by 2002:a05:6808:2216:b0:3a3:72ef:5959 with SMTP id
 bd22-20020a056808221600b003a372ef5959mr16680965oib.53.1689009585008; Mon, 10
 Jul 2023 10:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230710073659.54188-1-xujianghui@cdjrlc.com> <656c6d33a676c141ea35fadb519ccfbc@208suo.com>
In-Reply-To: <656c6d33a676c141ea35fadb519ccfbc@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jul 2023 13:19:33 -0400
Message-ID: <CADnq5_NwriVSHx27GTpHN1gWZ3Y=dd6ObmvSYHaBX=uf_DEo-A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: ERROR: "foo * bar" should be "foo *bar"
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jul 10, 2023 at 3:38=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix nine occurrences of the checkpatch.pl error:
> ERROR: "foo * bar" should be "foo *bar"
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/atom.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atom.c
> b/drivers/gpu/drm/radeon/atom.c
> index c1bbfbe28bda..11a1940bb26d 100644
> --- a/drivers/gpu/drm/radeon/atom.c
> +++ b/drivers/gpu/drm/radeon/atom.c
> @@ -1156,7 +1156,7 @@ static struct {
>       atom_op_shr, ATOM_ARG_MC}, {
>   atom_op_debug, 0},};
>
> -static int atom_execute_table_locked(struct atom_context *ctx, int
> index, uint32_t * params)
> +static int atom_execute_table_locked(struct atom_context *ctx, int
> index, uint32_t *params)
>   {
>       int base =3D CU16(ctx->cmd_table + 4 + 2 * index);
>       int len, ws, ps, ptr;
> @@ -1216,7 +1216,7 @@ static int atom_execute_table_locked(struct
> atom_context *ctx, int index, uint32
>       return ret;
>   }
>
> -int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int
> index, uint32_t * params)
> +int atom_execute_table_scratch_unlocked(struct atom_context *ctx, int
> index, uint32_t *params)
>   {
>       int r;
>
> @@ -1237,7 +1237,7 @@ int atom_execute_table_scratch_unlocked(struct
> atom_context *ctx, int index, uin
>       return r;
>   }
>
> -int atom_execute_table(struct atom_context *ctx, int index, uint32_t *
> params)
> +int atom_execute_table(struct atom_context *ctx, int index, uint32_t
> *params)
>   {
>       int r;
>       mutex_lock(&ctx->scratch_mutex);
> @@ -1359,8 +1359,8 @@ void atom_destroy(struct atom_context *ctx)
>   }
>
>   bool atom_parse_data_header(struct atom_context *ctx, int index,
> -                uint16_t * size, uint8_t * frev, uint8_t * crev,
> -                uint16_t * data_start)
> +                uint16_t *size, uint8_t *frev, uint8_t *crev,
> +                uint16_t *data_start)
>   {
>       int offset =3D index * 2 + 4;
>       int idx =3D CU16(ctx->data_table + offset);
> @@ -1379,8 +1379,8 @@ bool atom_parse_data_header(struct atom_context
> *ctx, int index,
>       return true;
>   }
>
> -bool atom_parse_cmd_header(struct atom_context *ctx, int index, uint8_t
> * frev,
> -               uint8_t * crev)
> +bool atom_parse_cmd_header(struct atom_context *ctx, int index, uint8_t
> *frev,
> +               uint8_t *crev)
>   {
>       int offset =3D index * 2 + 4;
>       int idx =3D CU16(ctx->cmd_table + offset);
