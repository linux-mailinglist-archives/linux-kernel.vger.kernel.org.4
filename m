Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D19D5B787F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiIMRoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiIMRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:43:59 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8D7E03D;
        Tue, 13 Sep 2022 09:38:11 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 28DGbe52014661;
        Wed, 14 Sep 2022 01:37:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 28DGbe52014661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663087061;
        bh=nud6kkeErbj6gxCVhXXnTfwdmo0n39YPcG7dhFcvh1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wjX8kQsZucG0nawp4iyuS3KdSdKib6JGS+CoO3GcK0rdtfymKQlBFdt/AGmub8uTO
         j1Pkz0E7g4H6nDfcR2MUZ3vd5+XT5CVlE0ktlEAXUfKzzKkt0n35+RiIPfJDQHZG7G
         qIuGWb66EkLjnTHbMatqtHqHdsNubrxLsnNpafMcCL8jSRJ03KuZKPlN6XJZopc+Hp
         8O0QWIAK+mOokFEEV7db0/DJfN2Pw1gKj+KN93Z1171jgPf/IPiUsho+BpsuLtmwhz
         L4p4j/waNMsfQTjIfP9g72gxRWP0zVfoYEsqzRo4JbS4iP29eilBVdGf3IdWIN7Yfy
         csjp4cO8X+V9w==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1280590722dso33684803fac.1;
        Tue, 13 Sep 2022 09:37:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo00i+mFupA9P/CyyxxwLvIiwWx0gZLqQodlFBPkSTv8PTFL3pMk
        eP57zFlLpkgIEbYTkC2j/1phM0WHJH43xYpOsIk=
X-Google-Smtp-Source: AA6agR78qVQuH9wKYoWkuMUWPBYpVpifhhBNrbSGkbiYxAOFG2gxyJmesUEHCW2oS3y/qY8FIy/cjblygWe+q4GCd4A=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr100015oab.194.1663087059946; Tue, 13
 Sep 2022 09:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220912094838.2398580-1-zengheng4@huawei.com> <20220912094838.2398580-3-zengheng4@huawei.com>
In-Reply-To: <20220912094838.2398580-3-zengheng4@huawei.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 14 Sep 2022 01:37:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS75yHbaumt0POFASTM2GXuNK=AyuFOeh7QM72w5QUs5A@mail.gmail.com>
Message-ID: <CAK7LNAS75yHbaumt0POFASTM2GXuNK=AyuFOeh7QM72w5QUs5A@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] Kconfig: remove unused function 'menu_get_root_menu'
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 6:41 PM Zeng Heng <zengheng4@huawei.com> wrote:
>
> There is nowhere calling `menu_get_root_menu` function,
> so remove it.
>
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>


Applied to linux-kbuild. Thanks.


> ---
>  scripts/kconfig/lkc.h  | 1 -
>  scripts/kconfig/menu.c | 5 -----
>  2 files changed, 6 deletions(-)
>
> diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> index 279d56a44136..a61907686d22 100644
> --- a/scripts/kconfig/lkc.h
> +++ b/scripts/kconfig/lkc.h
> @@ -98,7 +98,6 @@ bool menu_is_empty(struct menu *menu);
>  bool menu_is_visible(struct menu *menu);
>  bool menu_has_prompt(struct menu *menu);
>  const char *menu_get_prompt(struct menu *menu);
> -struct menu *menu_get_root_menu(struct menu *menu);
>  struct menu *menu_get_parent_menu(struct menu *menu);
>  bool menu_has_help(struct menu *menu);
>  const char *menu_get_help(struct menu *menu);
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index 3d6f7cba8846..62b6313f51c8 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -661,11 +661,6 @@ const char *menu_get_prompt(struct menu *menu)
>         return NULL;
>  }
>
> -struct menu *menu_get_root_menu(struct menu *menu)
> -{
> -       return &rootmenu;
> -}
> -
>  struct menu *menu_get_parent_menu(struct menu *menu)
>  {
>         enum prop_type type;
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
