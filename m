Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C13715686
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjE3HUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjE3HUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:20:30 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAE0116;
        Tue, 30 May 2023 00:19:51 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-43951f7002dso1375269137.3;
        Tue, 30 May 2023 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685431186; x=1688023186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KgQaAODHlXo2UhqS4DZgHfyJexrSHnjyY7roTHh0ZrI=;
        b=oI4J1gA457cbgXT87D3qGdyD7M4LQj4eiQVm2cmm+oapgwmNpAN7HVxO/u/jOzke9o
         1whyf5zEETvADDyNsvF0FgpUAlXLdcpHNFTW7LH4dPhRvu9VtBfBmrckMcNzcVT9hiQR
         g34Gn2j+a2GcL0WXjTD97/jUz4gc/RzNL+7/Xi/5PARmfDU4PQgOJ/AH89iVW5ZPU3O7
         35b4ugyEuGyAxIGV7SevH1DSAJreqLxh5O764LyH9bp/X1fbV5iK8UAryLolJlEU5zMV
         p6a8DELGB+8iJcRcbscqIEO2CT+GAplGBZrHy2cnY3JICGW69lC6ogQh5OMc3XZV/+NE
         LsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685431186; x=1688023186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgQaAODHlXo2UhqS4DZgHfyJexrSHnjyY7roTHh0ZrI=;
        b=fccZ8j1/F8wHJW2q6/GMA1gfecWUoP+w37MQ5DOPU4wAdcyD7SveUsXuKSa5sH2bJy
         dgAF9JoFQgBF1iuV5RBLrVhMNNcJgzW/KXDLnPi6s+UWaMBoIbLyarsEpXd95fxNuDcm
         gNNhAJtTF0/2MnXk8nXBmS8SLS0iAcNgLxSbdwYHexLG+6Bkt1NnqlNSa87rjzn/+i82
         X+Ao5jr4UJGfxsIOULAcDqDqLBeifGu7Z9+sP71J7zzHNqTA2OU3rpeDfliuK675nuzE
         PZQZLEuJiNv82udecOyedYVQ903E5VRXpZzUT42c/1W4p3LONiuzKjlB2v3m42rk4ZSw
         W0Ow==
X-Gm-Message-State: AC+VfDx6nCr4bzpELIDHeozgA+8TK6f2myVipJ6sRoxYhPrMVljMZohv
        zwWtP2sBzx0lwQ3N311GUT8Z09fdSx/LMLuOYNUkTQDsrNUaZg==
X-Google-Smtp-Source: ACHHUZ7bnT72ykk3QhmcxHdnRYYbKC8OQ48Jcr+4I/x3CfJtJE6I3Rx1rAH5zaidm1VdMprDZorzpxOXpfGF1yV36/4=
X-Received: by 2002:a67:f598:0:b0:434:6d1b:8b15 with SMTP id
 i24-20020a67f598000000b004346d1b8b15mr363192vso.25.1685431186065; Tue, 30 May
 2023 00:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230529113421.8970-1-franziska.naepelt@gmail.com> <ZHSt5JKOc1hwEGTv@lenoch>
In-Reply-To: <ZHSt5JKOc1hwEGTv@lenoch>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Tue, 30 May 2023 09:19:35 +0200
Message-ID: <CAAUT3iNqR0_UjGh=eRAoyfVfqTQNJkMZMK4xaLFSno8S3pR2oA@mail.gmail.com>
Subject: Re: [PATCH] mips: Fix spacing issue
To:     Ladislav Michl <oss-lists@triops.cz>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 29. Mai 2023 um 15:51 Uhr schrieb Ladislav Michl <oss-lists@triops.cz>:
>
> Hi,
>
> coould we just fix all whitespaces while there?
>
> diff --git a/arch/mips/sibyte/swarm/platform.c b/arch/mips/sibyte/swarm/platform.c
> index 484969db7713..339d77a0a08f 100644
> --- a/arch/mips/sibyte/swarm/platform.c
> +++ b/arch/mips/sibyte/swarm/platform.c
> @@ -88,15 +88,15 @@ device_initcall(swarm_pata_init);
>  #define sb1250_dev_struct(num) \
>         static struct resource sb1250_res##num = {              \
>                 .name = "SB1250 MAC " __stringify(num),         \
> -               .flags = IORESOURCE_MEM,                \
> -               .start = A_MAC_CHANNEL_BASE(num),       \
> -               .end = A_MAC_CHANNEL_BASE(num + 1) -1,  \
> +               .flags = IORESOURCE_MEM,                        \
> +               .start = A_MAC_CHANNEL_BASE(num),               \
> +               .end = A_MAC_CHANNEL_BASE(num + 1) - 1,         \
>         };\
>         static struct platform_device sb1250_dev##num = {       \
> -               .name = "sb1250-mac",                   \
> -       .id = num,                                      \
> -       .resource = &sb1250_res##num,                   \
> -       .num_resources = 1,                             \
> +               .name = "sb1250-mac",                           \
> +               .id = num,                                      \
> +               .resource = &sb1250_res##num,                   \
> +               .num_resources = 1,                             \
>         }
>
>  sb1250_dev_struct(0);
>
> On Mon, May 29, 2023 at 01:34:21PM +0200, Franziska Naepelt wrote:
> > This removes the following checkpatch issue:
> > - ERROR: need consistent spacing around '-' (ctx:WxV)
> >
> > Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> > ---
> >  arch/mips/sibyte/swarm/platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/sibyte/swarm/platform.c b/arch/mips/sibyte/swarm/platform.c
> > index 484969db7713..06bf7105e7b1 100644
> > --- a/arch/mips/sibyte/swarm/platform.c
> > +++ b/arch/mips/sibyte/swarm/platform.c
> > @@ -90,7 +90,7 @@ device_initcall(swarm_pata_init);
> >               .name = "SB1250 MAC " __stringify(num),         \
> >               .flags = IORESOURCE_MEM,                \
> >               .start = A_MAC_CHANNEL_BASE(num),       \
> > -             .end = A_MAC_CHANNEL_BASE(num + 1) -1,  \
> > +             .end = A_MAC_CHANNEL_BASE(num + 1) - 1, \
> >       };\
> >       static struct platform_device sb1250_dev##num = {       \
> >               .name = "sb1250-mac",                   \
> >
> > base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
> > --
> > 2.39.2 (Apple Git-143)

Hi Ladislav,

done in v2, thanks for your help.

Franziska
