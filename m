Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99673652ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiLUBQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiLUBQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:16:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF51083
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:16:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso563750pjp.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w0sDuoFh6MSuhNngxpWhM/u9+zdVKy8ObNvF6Q1i44g=;
        b=kR1idSC/5v3uYvDJN4qO9E82qhonSL05hnd79797sZhhUBXcwLYsom9onDacq0NcyM
         D617g1OSnEnYTdZuTq9mNrVXCh9EwsDXs3q+wYvJDX3xE+V9frrB5jHWTE+Z3Rl8qLDa
         fV13cqgdfl91jH/quDK7qZBWzYPiBriywE6Deee/CN0kcyVXtwNzatjzvyglLKUR5RI3
         nIhQOTb0LOY7onBgPvqxwXXOBbO/MEw8hz2n39TTMo8KvzZwWkC4m8xAIoH9rNmLTa6h
         UhQpfkbSewbSyiPCz4OPoUQFtbwt0PrgRv8v9frQQsA3So5K9P7FjFYzxM+fCys7Wnyd
         zvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0sDuoFh6MSuhNngxpWhM/u9+zdVKy8ObNvF6Q1i44g=;
        b=bjAmjbUTDneXXw51sYQCMsKgbXFh+FW0tUfqpJfPj7ZshLta/Zkw+Srx+unzNJxLsD
         HieRr1LjXOtkPaZL6WNfPsohy3vuk3xTBzL1nUo8NGAYondhnRwrNAYYCnToWuWiLya6
         Kc2uRbYoHp+agY44KzZB84bpsn4MLq4Y5YC2cAScnSTjGcRPqMOHD/rsGPVBE3fNxsAD
         OVhxLDI+4I0kSTMAkkzk1RugiG7w8Fy55V0ztOgWBprAKX27UgpsEKbCQr0IW5GAsr+1
         ZDNuRsn0RnanmoDhAP1hcgJCR51y7WlXwjIf7u2J+iNMpe08nLfs4vElJKMTbg2q/ej2
         Qbsg==
X-Gm-Message-State: AFqh2krk1JHDhrE2Te+7Cr3RLw6ReURbNpSc7lvYPOTmbLbLi77QStYe
        kco4ptbUUjd/zHI/ZE+QFR9TnVzmMXNzbh8O/AoE2Q==
X-Google-Smtp-Source: AMrXdXskRn9c72nwM9MiqZVBhnmRHi9uC0mbTXP48nGEwJyF1XRb6i5oUctJRN6w5Wj+cu4aPZ+vVBgWFuVt6teGTnQ=
X-Received: by 2002:a17:90a:b301:b0:218:fb5c:a762 with SMTP id
 d1-20020a17090ab30100b00218fb5ca762mr8952pjr.241.1671585378255; Tue, 20 Dec
 2022 17:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20221219182944.179389009@linuxfoundation.org>
In-Reply-To: <20221219182944.179389009@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Tue, 20 Dec 2022 20:16:07 -0500
Message-ID: <CA+pv=HPwsCa9qAHORB_5U7B6MYbRsR8Lk=rrQkJm0CD7+Z7T-Q@mail.gmail.com>
Subject: Re: [PATCH 6.0 00/28] 6.0.15-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
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

On Mon, Dec 19, 2022 at 2:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.0.15 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.

Hi,
Compiled and tested on my x86_64 test systems, no errors or
regressions to report.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade
