Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACF6A79DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCBDRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCBDRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:17:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCB14FAA1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:17:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i5so14501831pla.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 19:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1677727036;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yy8ScGXaPSZXR051KFshbh6rpME2gALKfyyYjKgrOsY=;
        b=1Fjb1Ol7oyLqZePeb695gZAWNtlosNuUTHqTxxBczo/bwNsajQZ3gXYBbUqqyBGcCs
         Ll5Ny1mgiMzGgATsdQTmchHzetb9I0JwA8PpRaYGw3/A6L46QFVfdpOPJFj9ctQ65OK1
         8O1h8N6pYgzLtxrOlXGs5+KNdOf7N+gnG3b+wGWC1ifpnuUZqVnfQwWlphqMahuwSL+/
         5LBrbVsKhqj0n6VcRvkh39rmW1c5/jA3ulK6ysyYlLBYWSZ64Pe+GCo5gxF7BWjgPivS
         aI6lGqJruNSWZlJxgdBIuZ1pAVTxEfyMnkq6gs5btO6Sxp1aPQZrm4U2swNf6BpPbzsU
         6Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677727036;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy8ScGXaPSZXR051KFshbh6rpME2gALKfyyYjKgrOsY=;
        b=m2x2pCSUBgegrnqJNjcOgaj9RtjrIjj72B9Ol8CeCcI0bI45C74kkCq6TE0hKTDANH
         nNOpmTmB02V92E/Nk4sbqmkeRFudr2/Qvh9N1MEQHcgMvMlYj1790rOxge8SAWUQIfHy
         ihE/9Xy8KbTHPXiAkzGfNSE5HDw5Vgk7itgcJU7/JXXGOuAtbHhOZnd4dVXbgMd0iquN
         3yU9Am9+0NiIHkJS3IyXQCzvTiv/HhH7/1TpFFeafsHyRy9s0L27Vf8Rq+8yJ4Nu/1M8
         bp/HtXA7XHzb9evsYZyN5Ii+BBVyiOK5yAF1VWlz3Q18eIAD3clPxzmzpSnluQXNBd73
         69Ww==
X-Gm-Message-State: AO0yUKUltQHJN6LaGr5tTL7wnuljcnt3LOuJhvF2AGgaajwrxswf7j98
        gHnSLfEJmvXnTi1IRIUMnzdRww==
X-Google-Smtp-Source: AK7set86iSrspYl9o5QA4dvohEJpeugUFFE2LdL8HMA1D0E7CvP+4EY0c6yOV5XVN8vGyzkrQJiagw==
X-Received: by 2002:a17:90b:1d12:b0:238:e9:8994 with SMTP id on18-20020a17090b1d1200b0023800e98994mr10162686pjb.0.1677727035890;
        Wed, 01 Mar 2023 19:17:15 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a6b0e00b00233b5d6b4b5sm471042pjj.16.2023.03.01.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 19:17:15 -0800 (PST)
Date:   Wed, 01 Mar 2023 19:17:15 -0800 (PST)
X-Google-Original-Date: Wed, 01 Mar 2023 18:50:05 PST (-0800)
Subject:     Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
In-Reply-To: <20210316193420.904-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, dvyukov@google.com,
        linux-api@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr, Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-b5f934ff-a9bb-4c2b-9ba6-3ab68312077a@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 12:34:20 PDT (-0700), alex@ghiti.fr wrote:
> Increase COMMAND_LINE_SIZE as the current default value is too low
> for syzbot kernel command line.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/uapi/asm/setup.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 arch/riscv/include/uapi/asm/setup.h
>
> diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/asm/setup.h
> new file mode 100644
> index 000000000000..66b13a522880
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/setup.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_ASM_RISCV_SETUP_H
> +#define _UAPI_ASM_RISCV_SETUP_H
> +
> +#define COMMAND_LINE_SIZE	1024
> +
> +#endif /* _UAPI_ASM_RISCV_SETUP_H */

This is now back on for-next, with some commit text explaining why it's 
not a uABI change as per Arnd's message 
<https://lore.kernel.org/linux-riscv/874b8076-b0d1-4aaa-bcd8-05d523060152@app.fastmail.com/#t>.  
I intend on sending this one for 6.3 as syzkaller depends on it.

Thanks!
