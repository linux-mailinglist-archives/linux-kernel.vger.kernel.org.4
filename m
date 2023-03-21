Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C26C2C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCUIVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCUIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:21:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B82BEDD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:20:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u38so3670642pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679386854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr1BhuALy9XAego6b5UVtN71EPRczW+dr6tvJtB9h1Y=;
        b=oCzcn+cIlhpZEcIK/AOA0pR/20Gpgd0Tm3VulJkMjV3ceJd3kfxnXDTdsNyRP7gNh2
         cdDBUlOXB1PgGQitsqwzcxc6w3jBm3jbfeY4IZ3Ws/TKTIKaEIB+5Pbnz6SHGE2O2XUp
         2lvDW5kL6ZCgUOa4qgT9d1Rh5WeKTAQqvQniqfBHCSkTlF/RJIppvgDa70px5hYD4fen
         kTIsIQiLQRaRlHxmtg1trk791g2T0SnnTDB7b1TI1ayLXs5U3WjEUdVqF9wuljHpXT/7
         euE+sYGvW8YfjffTIhHBBLQJjrQKLWzFkOuqqkWdPl83yUuDQgNRTA+9/2QwiayA+Iua
         XE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679386854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jr1BhuALy9XAego6b5UVtN71EPRczW+dr6tvJtB9h1Y=;
        b=n1BTHsRg/usC5kkBDcPYiaOGTs3ENQccY4WZ0daEZ8T3FgKz6DPRo+IRQJ3DQvAEwQ
         9uEf+K/1NMMOJQ01qrClZNFDQ/pKONiOlyRpfhTOsMK1n7piLDadUpANowjfFZ4KYfbG
         xjptfD+8j1sTGcZnKCNiZ/TrZkvmnEWuoyE5hwF7IQLdskISohpN0KTZD3YdX/hKi5To
         VWMzyU2iVFjynw2CS9b1JkgE8OA8j5ptJpo5gxcmZsIQgXa5X/SHJWlTf12eBXBJoB/b
         kHasUlTq/M8QqjKtiSIJh/0tT+BdAyWvymWXmIaZmvr0l598WyjfWWrsthbt3W2v28PI
         HZ1Q==
X-Gm-Message-State: AO0yUKV4vYTy5BsAhrwHNsSV2rGlzMQJ0vK9yYDkmoc3oZOk6nF+k+HU
        9yrI9o3albRC/o/6ZG2Tzn5kUOscikLmp7I6yFY=
X-Google-Smtp-Source: AK7set9OHjXGmmq5OcDZabAExRFA2HJQohhoRRbZLZ2vOzaQtU0kJl1n7DBXcS2HNaFfJUQotoJd/CBHL5nDV00YGjU=
X-Received: by 2002:a05:6a00:2d9d:b0:627:fb45:9279 with SMTP id
 fb29-20020a056a002d9d00b00627fb459279mr1258618pfb.0.1679386853807; Tue, 21
 Mar 2023 01:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230319142320.1704336-1-trix@redhat.com>
In-Reply-To: <20230319142320.1704336-1-trix@redhat.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue, 21 Mar 2023 09:20:36 +0100
Message-ID: <CAMeQTsZmJP-RCXfMcLntLx-M=-O=D=hAvu5kNVJWwUzG3Emm=g@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: remove unused gma_pipe_event function
To:     Tom Rix <trix@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 3:23=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/gma500/psb_irq.c:35:19: error: unused function
>   'gma_pipe_event' [-Werror,-Wunused-function]
> static inline u32 gma_pipe_event(int pipe)
>                   ^
> This function is not used, so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied to drm-misc-next

Thanks
Patrik

> ---
>  drivers/gpu/drm/gma500/psb_irq.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/ps=
b_irq.c
> index d421031462df..343c51250207 100644
> --- a/drivers/gpu/drm/gma500/psb_irq.c
> +++ b/drivers/gpu/drm/gma500/psb_irq.c
> @@ -32,17 +32,6 @@ static inline u32 gma_pipestat(int pipe)
>         BUG();
>  }
>
> -static inline u32 gma_pipe_event(int pipe)
> -{
> -       if (pipe =3D=3D 0)
> -               return _PSB_PIPEA_EVENT_FLAG;
> -       if (pipe =3D=3D 1)
> -               return _MDFLD_PIPEB_EVENT_FLAG;
> -       if (pipe =3D=3D 2)
> -               return _MDFLD_PIPEC_EVENT_FLAG;
> -       BUG();
> -}
> -
>  static inline u32 gma_pipeconf(int pipe)
>  {
>         if (pipe =3D=3D 0)
> --
> 2.27.0
>
