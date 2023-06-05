Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6602722D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjFERPA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 13:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjFEROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:14:43 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD2ED3;
        Mon,  5 Jun 2023 10:14:42 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f7364c2ed8so4364325e9.0;
        Mon, 05 Jun 2023 10:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985281; x=1688577281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XU+jPITmyoPvg1lBzxo3O9Iy6aVR1qw9rhOIr22a22c=;
        b=iX4Clpc+HFF2NMRRrDZxsl3dxZvphSvmhswpzNF9HS+78CdUrcJnhK+gqElYNxYtF/
         1k/BjhObH53hMlnKGxM6n4Q5A9JwcM+4rBEeUYmHMaCntaBo+Bjq4wopTVe5LtYigtI6
         Tlpwral9u5/0fBh9wLmsqhrDesS/cEnJtPf10fRHOWjH/bQX7BBeNvPXhocLr1oApovu
         b8Gf6vZAEzxOdC9kJ37emlofNzPzvk08OkDQbYnrxOha5GV+uRR5ELPdoA8YJ1jnslpk
         j0DH4CbfGQL9B5adRZRFVYBzVVFbwNu9U+H/Xo+YyolNgsJbJ/jaRfU4ywgYGuHfSeXL
         gemA==
X-Gm-Message-State: AC+VfDw4Fztcm0Aw0Bc+wXjtaRgv024twA7+LQcyu92evEqH/7SerLUb
        xmHM4901dAo4jzw3wihq++fsO9zRBAt0LsUm19o=
X-Google-Smtp-Source: ACHHUZ4P6nFls4Uv4pNH5wBEgvcZ8iGdoWVwhojr5Oa8Vx6lQo3Rgwr8iBG+BWxe9aCpRffRT+mZDSHZFWqQmwwnI3w=
X-Received: by 2002:a05:600c:8511:b0:3f7:1483:b229 with SMTP id
 gw17-20020a05600c851100b003f71483b229mr16853197wmb.3.1685985281202; Mon, 05
 Jun 2023 10:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230527095158.211568-1-linmiaohe@huawei.com>
In-Reply-To: <20230527095158.211568-1-linmiaohe@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 19:14:29 +0200
Message-ID: <CAJZ5v0gQS6O0Gj3vd-xdqEV+vpbCVg1Mdq8r-W0ZXpsKHyyRFA@mail.gmail.com>
Subject: Re: [PATCH] apei/ghes: remove unused ghes_estatus_pool_size_request
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     rafael@kernel.org, bp@suse.de, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 4:00 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> ghes_estatus_pool_size_request is unused now. Remove it.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied as 6.5 material, thanks!

> ---
>  drivers/acpi/apei/ghes.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 34ad071a64e9..a4148a7d3afe 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -152,7 +152,6 @@ struct ghes_vendor_record_entry {
>  };
>
>  static struct gen_pool *ghes_estatus_pool;
> -static unsigned long ghes_estatus_pool_size_request;
>
>  static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
> @@ -191,7 +190,6 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
>         len = GHES_ESTATUS_CACHE_AVG_SIZE * GHES_ESTATUS_CACHE_ALLOCED_MAX;
>         len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);
>
> -       ghes_estatus_pool_size_request = PAGE_ALIGN(len);
>         addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
>         if (!addr)
>                 goto err_pool_alloc;
> --
> 2.27.0
>
