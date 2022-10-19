Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95875605075
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiJSTbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJSTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:31:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D6183E35
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:31:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n7so18244111plp.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nhk0S6BX/tj1IAjSct4UcDQ2+49Nwz+BIdnFL7zCaYA=;
        b=F8i5BghzMOYroFvSZG7rt+Oj+s3TxnAMbLMokne8U5IeEMbuR1P2u2fP7ipn8XhzlY
         7le1q626iUuN6TlafAYtdkjvyu682Ox2PpscD4Vy0YCSCxe0/r0hs5BZ75DG5ebqq80u
         sgHcZMNDGUbsLTI2WLLYG4rdyBioWm/AoRvQDA85UrpDQXra8tFKu/01OOScqabywoZm
         byQVucdDbKST21w6eEIDFACNuW5fwtfMYPOZ7E2DYA1VZnVSumqWVPo0cJ8Qz36gqzkf
         5DqsQ3VI1coosbmfM5h5mjJFbzFVeX+r8wNxMMhfiCc2gCaTzzzv75RRrmsPeQ36bARt
         1vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhk0S6BX/tj1IAjSct4UcDQ2+49Nwz+BIdnFL7zCaYA=;
        b=0f20VValVEs58LATiL4Ojb/Ojei/xTNXqoJ4q5KdIWABkOM2eyyhq6djKUe1K/9Fk3
         nG3ZmbWY46jD2pN6c8LwDMGy/rWWlmIn94yegwTxmAmPcZnnY0lw9wy6hz0SPpRaew72
         h7GdIhurnoZ/DSSW2GJdY+nk3HKNTtdSdDkvTwdk/MjP10VKvj+hxY53OpSOsBBSHHR/
         gWLodIZqHgcP87i7mxnSmYnaOJLPnE8pyCP9tWdNISVl3sRshMj/hxOh91P9GoBxDtPa
         iPjqw4P/abua+e7IzgG+4UvNUwgC/R4T4sG8gyWg3rScgW96AEk0erKNIyq3g6MxuQxy
         qrlw==
X-Gm-Message-State: ACrzQf0+j4jt7bjWZeC78zzF2B2IDMouBGN235d3y7fXOFIY/qwMdX0W
        AxBKIFVvAf/6Hr94oPfQ4M1muPHS6aYFIS5IuK5lwA==
X-Google-Smtp-Source: AMsMyM4LVO5uEPG5vJ83CT6FamzFE+zBr5ojMb9HgfrzHDLQLrjsKpYFh2sWWVTztQwlZl+I/ZrRzZmvSQ0N3Vs4b3w=
X-Received: by 2002:a17:902:8ec7:b0:182:dcf0:4a22 with SMTP id
 x7-20020a1709028ec700b00182dcf04a22mr10337791plo.61.1666207895513; Wed, 19
 Oct 2022 12:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221019083249.951566199@linuxfoundation.org>
In-Reply-To: <20221019083249.951566199@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Wed, 19 Oct 2022 15:31:23 -0400
Message-ID: <CA+pv=HPB4aUV25bmp3M6fWZRwcs000+W+iWsx8DD7Nv16Ty_cA@mail.gmail.com>
Subject: Re: [PATCH 6.0 000/862] 6.0.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 4:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.0.3 release.
> There are 862 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Oct 2022 08:30:19 +0000.
> Anything received after that time might be too late.

6.0.3-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Thanks,
-srw
