Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7A677963
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjAWKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAWKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:43:19 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3412F04;
        Mon, 23 Jan 2023 02:43:18 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id jr19so8062145qtb.7;
        Mon, 23 Jan 2023 02:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Nz7epYXM0pVoAXm+SmhP1LKWnLLacoKbNMTlqFkP4Y=;
        b=Evr0aUIvS6DdSLmFWJ/ovEjHKcUHZZ+zqV0L9DuwIEGO96KyL08SxjgM5cB68DwzgH
         PtGEKdEHXwgHYbqJUGBHX4WrYJZKeCMvSWAae+4diaR2Xcod8qQxnlfTEtu3Op4rlBYc
         uBsK8noHGikYmr3mlIj+a9vcL8Dc0G49fpUacOhWsARUUdEL6CU3eLHDb6vRKQhWzKno
         lhFzanSVhpjEFD+PYJKyfzUPDkvP+drBkqe+oe6NUbVC4x1+8Zr2BofX9sjE86+hdG8v
         xmeg6oiGWwsb4YvOZ1qVSfn4vsPdATVANDWSyJgG/rB9OZB9fmmsf6TzRBJFgzNLVRpR
         THSQ==
X-Gm-Message-State: AFqh2kqAu9a6Nf/R0SZadkYI7c94S6uTnfTZudWk8HHSwC5VMhyVCFgs
        ekf+lLnEGPYlPB+Nw5m034mY/piyrJei1g==
X-Google-Smtp-Source: AMrXdXvL7BmjmL7/zAf4Azen9Ha73nYzAF4ZMHJXhyYdyn+thn+9YDkSOX2Z0OMd7Xd3ud9s82GXqQ==
X-Received: by 2002:ac8:45ce:0:b0:3b6:326f:b69c with SMTP id e14-20020ac845ce000000b003b6326fb69cmr31915492qto.1.1674470597668;
        Mon, 23 Jan 2023 02:43:17 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a444d00b00709041c3206sm7726868qkp.103.2023.01.23.02.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 02:43:17 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-4a2f8ad29d5so165359097b3.8;
        Mon, 23 Jan 2023 02:43:17 -0800 (PST)
X-Received: by 2002:a05:690c:851:b0:480:fa10:459e with SMTP id
 bz17-20020a05690c085100b00480fa10459emr1894031ywb.283.1674470596924; Mon, 23
 Jan 2023 02:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20230122121129.28699-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230122121129.28699-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jan 2023 11:43:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXdZbJDTOzQG4=pRpR1OCU0=RTDZDH0MnPW8Ea2LJKs6A@mail.gmail.com>
Message-ID: <CAMuHMdXdZbJDTOzQG4=pRpR1OCU0=RTDZDH0MnPW8Ea2LJKs6A@mail.gmail.com>
Subject: Re: [GIT PULL] memory: drivers for v6.3
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Jan 22, 2023 at 1:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
>
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.3
>
> for you to fetch changes up to 4fd1a0e496cb81e939c55143fc81c2be130099c4:
>
>   Merge branch 'for-v6.3/renesas-rpc-if' into mem-ctrl-next (2023-01-22 13:05:21 +0100)
>
> ----------------------------------------------------------------
> Memory controller drivers for v6.3
>
> 1. TI Emif: simplify device_get_match_data().
> 2. Renesas RPC IF: Few fixes (missing address set in manual mode;
>    decouple driver's private data structure from other drivers; unbind
>    and rebind due to triggering managed resources allocation from other
>    drivers) and bigger rework around improved runtime Power Management.
>
> ----------------------------------------------------------------
> Geert Uytterhoeven (6):
>       memory: renesas-rpc-if: Split-off private data from struct rpcif
>       memory: renesas-rpc-if: Move resource acquisition to .probe()
>       memory: renesas-rpc-if: Always use dev in rpcif_probe()
>       memory: renesas-rpc-if: Improve Runtime PM handling
>       memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
>       memory: renesas-rpc-if: Remove Runtime PM wrappers
>
> JaimeLiao (1):
>       memory: renesas-rpc-if: Fix missing setting address

This is commit 21a1234f82cbf425
("memory: renesas-rpc-if: Fix missing setting address").

The same patch, sent by someone else, was sort of nack'ed in
https://lore.kernel.org/all/CAMuHMdWpvuC2Cm41jCQm+rT8MZB5GN+Z0bPz941QzsHX17Ux-g@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
