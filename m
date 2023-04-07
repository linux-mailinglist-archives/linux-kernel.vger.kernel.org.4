Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0778B6DB1ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjDGRlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjDGRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:41:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB60CA1C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:40:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q191so7575550pgq.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680889217; x=1683481217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKb29bg6tx4CJhhRnFeIAgI2BubugDeo6AhQSNXoOjk=;
        b=ZeOB4N2nMw/T0W+m53HyspppsYTatXHFUsBPQrdircDHtMw9efqiwwPC8ouTXD5mmu
         GzIE9+OQmYiyOhMOwdkgNlwXMnhivea/lDdwCLnEhl07OIkr/snh4v8BDsU9kj1pW442
         nnnpcNzvMbXmlSalIpGUu9AETBoPMxQmphh/+OqdyeCfBJcxrC7ktOmrrk6/7/r1m+Es
         GOkPApNDdYjVeFSF9RDu5xLGpCo5t/z41TOkPkYQO0CezUmwqryKvM+EXpH+WYgIMBzl
         8bN3+fxTUcGaPyn1TMdNEcmCoXvSL7igHt9YU+N2N+I6CBRUQdqN+oJfYsZBoM3wYp+A
         LiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680889217; x=1683481217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKb29bg6tx4CJhhRnFeIAgI2BubugDeo6AhQSNXoOjk=;
        b=TFJDkxFWljh62VeUWg9JMkBKBRciy+pW7kjOtOYlRJs47of22vH4ic2MlzHVU8CFeZ
         r+kJgWd5H3HSdYIRCTVGKnaNAmDLD27BuGhl++1AJ7Cqh5xfMOadsBEHBRc8OQBMAHuv
         1GhWMY4jZuL0VagNVsPcs4Hd1Yf693IeDz44vU7noxHDdCGxXfPuPwOoV687sVaqIjPU
         nNuRWpw6j3Vx5wCxAdtNbIKuEoysmRBQ/Ok2RHdoeZg0JFwGZ8nEB7QwKepTHd8A8+Bn
         zq/EWZsQ2mX0zr9YGLgkys/hjXQgqgtUjVHY1LnTaDAmkXrBp/GZuojHZX73PgcSnJjS
         Z9TA==
X-Gm-Message-State: AAQBX9epNsgaByY6xfo8+Xvly6r845NWIjPu1Lv/Z+eYjR9bL/6BJLpc
        CE4ZTNM/WUtFdFUZ3Bn+XamS6QGDyN6gl9vdfA1ibg==
X-Google-Smtp-Source: AKy350YUCzPBLxgYgXKQV3bzEg9zkHgzG9zgtpSVZEJ7BtTpjnG8NvJ6+yrbg54qCj108b33TAynRrQ6bp7uhOQcDco=
X-Received: by 2002:a65:578e:0:b0:513:a488:f05f with SMTP id
 b14-20020a65578e000000b00513a488f05fmr622511pgr.1.1680889217290; Fri, 07 Apr
 2023 10:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230321182414.1826372-1-trix@redhat.com>
In-Reply-To: <20230321182414.1826372-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 10:40:05 -0700
Message-ID: <CAKwvOdnrKujpv2A6a-6U6pxpd3Z9mKwV3SgD6ZL+ie4-g4n2-g@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: remove unused vmw_overlay function
To:     Tom Rix <trix@redhat.com>
Cc:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:24=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:56:35: error:
>   unused function 'vmw_overlay' [-Werror,-Wunused-function]
> static inline struct vmw_overlay *vmw_overlay(struct drm_device *dev)
>                                   ^
> This function is not used, so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_overlay.c
> index 8d171d71cb8a..7e112319a23c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
> @@ -53,12 +53,6 @@ struct vmw_overlay {
>         struct vmw_stream stream[VMW_MAX_NUM_STREAMS];
>  };
>
> -static inline struct vmw_overlay *vmw_overlay(struct drm_device *dev)
> -{
> -       struct vmw_private *dev_priv =3D vmw_priv(dev);
> -       return dev_priv ? dev_priv->overlay_priv : NULL;
> -}
> -
>  struct vmw_escape_header {
>         uint32_t cmd;
>         SVGAFifoCmdEscape body;
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
