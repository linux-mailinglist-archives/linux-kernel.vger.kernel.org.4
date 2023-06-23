Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265D973B114
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjFWHKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWHKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:10:00 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42252130
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:09:58 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4715758343aso65857e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687504198; x=1690096198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RHQjiCvzOs7wkooIRWLOZmThBnNBkQeFjcYbmM5kFA=;
        b=W7VK2Aaw99thAk6HjrHt5G3dpc7Ft3jD7b9TNY6ct/YZkFzA2Ep1pnrYCauecXNjrn
         9yVoasq5L5Ff7m2F6YJlY7bdwYT3e5WUKXRYjxe+RD05v41xzqKUp4xSKKO+R+8qXFUz
         35RJSZ7n7Z8RCngunlKx1AxHp2uXkHb69wDTH8N0hlV45meKnh0qIHXZUDRT4mkpF+3N
         maj1D9Z3kHHJ4CAvf0s7IUQDICEs4g0OKeVrsYXOLhcIpHttd8czAz+6lu1XX7fh+9ug
         9h3ADn11WNeH8U9iMrtVdB9PeadGNNGVBrXm53el2XsgveFlojUxYrHQ+QLH4oR9XN6D
         7xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687504198; x=1690096198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RHQjiCvzOs7wkooIRWLOZmThBnNBkQeFjcYbmM5kFA=;
        b=T8+dsDb/RwqWYiJ9mctNNIhXGHxoWCpMHGyQcrsabE9PapWEtwq+bbxqNjl/oF/ypK
         TyCfBZ/L3Z+mvxYmZJDGFUubZ7WwuGQu6Uui0txLL6prNbOWLmnoEXqXnG6Mc9hZ6bIe
         nmmI/0/LpCrGVYjTn0B64XkQdGj1/VuytLmh4r+omb0TMEQ70hrMdX8g55hKzZlHe/Zo
         6pR8ca1EbZhvBwUiVED1aMM0IxIzUFlCv8UXZdFy/+Gktc3+dUT82krkYbp4x0VT6465
         TkRbz5afCAYTULbAihJpKWiJXm9KvhJmYcXOBm5+qeLnYDOJwvpmiMZ8XoPBdqP9ILNa
         DK8A==
X-Gm-Message-State: AC+VfDwNHPQRJQM/i7STVlQWTb/EgD3+/i55SF9FoVtOoPeVynj9YwUf
        sVEcbGCW7dXFpYtfzTEJLZfvQnDU8ZtRNnA/v8VqGTt8TjmrgzI7zt9UqQ==
X-Google-Smtp-Source: ACHHUZ7n89JTvr5+M32d1uFfGnb7dOelMLsHh15zu+NcwqNENpw0mwbhMpFFAjgWcof82155yJ6ocUryxydRf4BcSbQ=
X-Received: by 2002:a1f:e4c2:0:b0:476:36df:dc51 with SMTP id
 b185-20020a1fe4c2000000b0047636dfdc51mr200645vkh.16.1687504197683; Fri, 23
 Jun 2023 00:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu0GLCFUKsqod7cO8jku7Sp6b7gRqFo1sz7oxfpC78GGg@mail.gmail.com>
In-Reply-To: <CA+G9fYu0GLCFUKsqod7cO8jku7Sp6b7gRqFo1sz7oxfpC78GGg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 23 Jun 2023 12:39:46 +0530
Message-ID: <CA+G9fYt9VWZq20rkRawusr+7GKZveYas2U8FKHpHo7C1p615Lg@mail.gmail.com>
Subject: Re: next: drivers/char/mem.c:164:25: error: implicit declaration of
 function 'unxlate_dev_mem_ptr';
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still notice this problem on Linux next.

On Wed, 14 Jun 2023 at 14:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Following build regressions noticed on Linux next-20230614 and next-20230613.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Regressions found on sh:
>
>  - build/gcc-8-microdev_defconfig
>  - build/gcc-11-dreamcast_defconfig
>  - build/gcc-11-microdev_defconfig
>  - build/gcc-8-shx3_defconfig
>  - build/gcc-8-dreamcast_defconfig
>  - build/gcc-11-defconfig
>  - build/gcc-11-allnoconfig
>  - build/gcc-8-tinyconfig
>  - build/gcc-11-tinyconfig
>  - build/gcc-8-allnoconfig
>  - build/gcc-8-defconfig
>  - build/gcc-11-shx3_defconfig
>
>
> build log:
> ======
> drivers/char/mem.c: In function 'read_mem':
> drivers/char/mem.c:164:25: error: implicit declaration of function
> 'unxlate_dev_mem_ptr'; did you mean 'xlate_dev_mem_ptr'?
> [-Werror=implicit-function-declaration]
>   164 |                         unxlate_dev_mem_ptr(p, ptr);
>       |                         ^~~~~~~~~~~~~~~~~~~
>       |                         xlate_dev_mem_ptr
> cc1: some warnings being treated as errors
>
> steps to reproduce:
> =========
> tuxmake --runtime podman --target-arch sh --toolchain gcc-11 --kconfig
> shx3_defconfig
>
> Links,
> ===
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230614/testrun/17514799/suite/build/test/gcc-11-shx3_defconfig/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230614/testrun/17514799/suite/build/tests/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230614/testrun/17514799/suite/build/test/gcc-11-shx3_defconfig/history/
>
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh
