Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4575EEF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiI2Hgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiI2HgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:36:25 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA351296B1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:36:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id e145so526368yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HF5Uidh/azrCMm3aklUrXyZ8EuVDO+7z+qW3aO/ertw=;
        b=LsGbKzgEwNZzNBO0rhERldTkuDy0qwLF8MGijzRgk97wJzegikv9b3b4U9ZTkMDeB3
         lcdmEbdOWNMGxc/g1Q3v7XiXcla5YaAHnzm8tApSf8GJ4NhN154o5fjLwlG2X/r/q3eq
         GfvLUSnCdh/H8B/RowoJ35FSs8XFDznvKxfBVNP7VvKPI7LNRuys8hn/AEDV70LoOubA
         +UyfwDtmKwHBMUyjR9nKIUHZfjagE8ZWRRu/PZY24FWDKStCnsp4yITEaQT/AaXa1qj6
         T4QqjDVt8hJrF4aZIBgz9eCHhHIJtmXul1jvYvmhDrgF6vl8+/j1SsPHiE6bmblgdLhj
         upLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HF5Uidh/azrCMm3aklUrXyZ8EuVDO+7z+qW3aO/ertw=;
        b=P/vU7kGMgA1J6IsfKkqxmUPGvdKylti5GBfobdBzE+hpFQb8uz5J8YIN/NriYYqZEq
         /tuq9EVI2J0188/G4yoHUqqBG5kT6q27QXu8/qkHFMx2bi7WodHijajpeOxO2eVT4Yj/
         Rd9likHX3i2b6jAl1lfJps3xZpjGwuVRiz3Sv/Or7oGSoVAtSmH8qqKreLuPGz89p8zB
         fLJS3oKy1EKZcCZAXXi+kaIyW1IlAA0wXK6FNj3zXwhxT2WrqXWnnmncLlx+S9uvQgrP
         l2PY1yUP0SInjTySh75pN7V/owiXZ/yoFanIs8iJyHPFpHj+egvWhu19CAvuUVhahiMO
         pUNg==
X-Gm-Message-State: ACrzQf1CVb6fLxTkIXjXp8Vr+Dqr0tlL//qPp8LWxMgC0ZWfbVX4HM1O
        fyGVx1QTV68ewPyQQleSUGYoVyiQnPSlYWadgAg=
X-Google-Smtp-Source: AMsMyM74YdrxQ12K4Nc13OpFKTBwkzx6xmC3oEI/uiQjJzK3OZ/pFR5Q3apXLofvq1HdzhGXGM61Bc2ycLyYZBYN2IY=
X-Received: by 2002:a25:ea08:0:b0:6bc:436f:6798 with SMTP id
 p8-20020a25ea08000000b006bc436f6798mr1933681ybd.31.1664436983343; Thu, 29 Sep
 2022 00:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220929070057.59044-1-renzhijie2@huawei.com>
In-Reply-To: <20220929070057.59044-1-renzhijie2@huawei.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 29 Sep 2022 09:36:12 +0200
Message-ID: <CAKXUXMxHZtjr3-7vNtOm90u_dZ9M6SWy2+g6pDTwMo5C2fsyGg@mail.gmail.com>
Subject: Re: [PATCH v2 -next] init/Kconfig: fix unmet direct dependencies
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     bigeasy@linutronix.de, arnd@arndb.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 29, 2022 at 9:04 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
>
> Commit 3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on PROC_FS")
> make config PROC_CHILDREN depend on PROC_FS.
>
> When CONFIG_PROC_FS is not set and CONFIG_CHECKPOINT_RESTORE=y,
> make menuconfig screams like this:
>
> WARNING: unmet direct dependencies detected for PROC_CHILDREN
>   Depends on [n]: PROC_FS [=n]
>   Selected by [y]:
>   - CHECKPOINT_RESTORE [=y]
>
> CHECKPOINT_RESTORE would select PROC_CHILDREN which depends on PROC_FS,
> so add depends on PROC_FS to CHECKPOINT_RESTORE to fix this.
> Fixes: 3c07bfce92a5 ("proc: make config PROC_CHILDREN depend on PROC_FS")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
> Changes in v2:
>         - change dependency of CHECKPOINT_RESTORE to depends on PROC_FS

Thanks.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Lukas

> ---
>  init/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index e11307310fc1..a19314933e54 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1273,6 +1273,7 @@ endif # NAMESPACES
>
>  config CHECKPOINT_RESTORE
>         bool "Checkpoint/restore support"
> +       depends on PROC_FS
>         select PROC_CHILDREN
>         select KCMP
>         default n
> --
> 2.17.1
>
