Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74AD713244
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjE0D4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjE0D4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:56:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9919A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:56:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96fa4a6a79bso207409166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159785; x=1687751785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zcxx+uBeHJ8GiGdDOZOOVVIqwP9cLUm7L1SVeB9sLvM=;
        b=xE6160P9Zr4wEkT61Vr5IkbHXpmY1HjWeK774oQn5uOLjZ2QEShy9mhrvVb4HqrxNS
         Z6YAg0LrJSUZi4tWr0CbVwQP+J5RhaPpDHoV4HUQHCB33J/wh1mvABD2dO+suyipiw9p
         QCz+GmmD3/0o1Pyp7lX+CznaXnTzdYR0Id4oWQEPZ5F2ga6slqiCNJPehrr+OrqLM2d1
         Whe/YslfEdc084vxdVSFYv/Jl+2Z69RrvRZpAXfhZZiPq2ClZnt9quqrkENE6BIROcRp
         P+9RUjet0hlHRR4Qtj6bY4XtxobK8M7zWElCDxcqPoakr+NiUD5EL3rinGOj0K2M14QT
         nKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159785; x=1687751785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zcxx+uBeHJ8GiGdDOZOOVVIqwP9cLUm7L1SVeB9sLvM=;
        b=WuEu1PlEVtprW76RgR/Cjv0HGMRYhrJOcoSxqc8FZZ1TQS4Ax+/uuCdpZPKMjpZCh0
         Ixws9/AS6H6FA94/8FQRe8VegwtBIr9F5wEvvnT1rgnQnshSEN/UDIZ5u0hUWfQTJJfs
         aiVWaG2QvaX1b+zDyoTnQs5k6tAGrKrN7DRDmPGd3wovDNaPbw7m9wbrbJl4MZMPgJJz
         HPXm5TTrI2KtmuAxZGdG1qJNLg04vwDOVX5NBRMYJRAEkmAiMizOfu21oc+4F22HAdNG
         Xs34dwud8ioncwDoRZB/vewHlQGLHY7+ZCavBE+qMFPGNL2b7y0d79KgfmZO0gnSGgzs
         oWAg==
X-Gm-Message-State: AC+VfDwcHcaiRxk/XMubH8/gZAs2cRyEBwLQYBq/xGnUnxiDTETSbHqf
        +x49x34KC36sGMxdaQD2VdarwoRnrJN/IKADgzsZnw==
X-Google-Smtp-Source: ACHHUZ6Frq44/ZM1/LAefqKVo+JOcYtTAHNn83kaMix4r51rZzunIi70oDj7h1R4lHYEPc3BxQhVVEKHW1NueeZXB+8=
X-Received: by 2002:a17:907:9455:b0:94f:1c90:cb71 with SMTP id
 dl21-20020a170907945500b0094f1c90cb71mr5112500ejc.65.1685159785332; Fri, 26
 May 2023 20:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230527093353.153078-1-linmiaohe@huawei.com>
In-Reply-To: <20230527093353.153078-1-linmiaohe@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 26 May 2023 20:55:49 -0700
Message-ID: <CAJD7tkbY0kXbb3r3ObgOjmSa5kmw7n1uhN=Opvumty3=i9Ev0g@mail.gmail.com>
Subject: Re: [PATCH] cgroup: remove unused macro for_each_e_css()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 6:43=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> for_each_e_css() is unused now. Remove it.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM. I can't see any references in Linus's tree or mm-unstable.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  kernel/cgroup/cgroup.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 625d7483951c..413b4f1f1b70 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -689,21 +689,6 @@ EXPORT_SYMBOL_GPL(of_css);
>                                 lockdep_is_held(&cgroup_mutex)))) { }   \
>                 else
>
> -/**
> - * for_each_e_css - iterate all effective css's of a cgroup
> - * @css: the iteration cursor
> - * @ssid: the index of the subsystem, CGROUP_SUBSYS_COUNT after reaching=
 the end
> - * @cgrp: the target cgroup to iterate css's of
> - *
> - * Should be called under cgroup_[tree_]mutex.
> - */
> -#define for_each_e_css(css, ssid, cgrp)                                 =
           \
> -       for ((ssid) =3D 0; (ssid) < CGROUP_SUBSYS_COUNT; (ssid)++)       =
     \
> -               if (!((css) =3D cgroup_e_css_by_mask(cgrp,               =
     \
> -                                                  cgroup_subsys[(ssid)])=
)) \
> -                       ;                                                =
   \
> -               else
> -
>  /**
>   * do_each_subsys_mask - filter for_each_subsys with a bitmask
>   * @ss: the iteration cursor
> --
> 2.27.0
>
