Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CCA5FE611
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJNAJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJNAJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:09:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E6183E1D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:09:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so3346783pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj9UHYdTEClCDGs7ZVXNSHPGH6NTmofQXt+kpp/4++0=;
        b=pr+yTvMHVaxfuWfNcD2nkJYRGcySw1wKj1/73MzVdthBRivG4B3iQua5wlOsGMJY8W
         dAUVmF+8zGizDN13Man5A3Y9MIYtTAkyMKVUe1HAUm/mDmP+CXPfZO48m1P5UX+U3eLh
         aMI5tvb2EyXb2bD8cLuSR+HNMVyvjKYRipmF/zzspIoMzGYveEY2TXPCr/OuEc82/LqW
         HQ4vfbqn9ZQmYqfV9dVV7a6ErpNgLUrLZBkewVe8j+Zl1KhFP9TxtghBc5y+pzLghpAq
         TQk9tmM6QPA/9u32lRk/AClmFowB8SemTg7EunkwiNgwy7XZ827m4jHz/L+2uK3fE3Mg
         mpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aj9UHYdTEClCDGs7ZVXNSHPGH6NTmofQXt+kpp/4++0=;
        b=CQlLCqzDWMSKOYQOZE4NJ4FGKhtDNcEz3HbHLzczjirkWbYcnjbJHF1viCP5l6TOYL
         WACFB9AdyFkDJXhw3/KMO+Dlx0GNsKKg2HG7QZL4ErFcxCvybEGoiKe7HeRAIl4X4FRM
         ZqKux0oSacWwI83y1G6ZduJ5eAKRnzI0veW5SsTNlPG/ifOT1krDwEsjKGSYXBDeoFww
         WsG+0OKEkUJCLKEUktubrELrdgTnSjEE+XJgu56kCmQVUhePTCPDa0YicgzxDJ8u6+NK
         cqzpb7riKLcfVwTCXeABVAFukKyWJLCxM/SzBapQP2sa8EF7daeePUL4HkC92UA+ERtf
         8jnA==
X-Gm-Message-State: ACrzQf2ZmwFs+9fsW8OeqfJCf791CeFocbGq7giJ1qT1/6moEmdADuzk
        1P+pCcjbZQWpZG6nj8nC3/6onJL5bcRoG8PMp9wv2Q==
X-Google-Smtp-Source: AMsMyM6IoUprrVkCPe8aCtWSxaVKuoLvC+I1ZT4cC66bVxNJWUHZLdKflGiEwSJHl7KK5W4ObxsuHwz7skEDwlCZ/yA=
X-Received: by 2002:a17:90a:bd87:b0:20b:1cb4:2c92 with SMTP id
 z7-20020a17090abd8700b0020b1cb42c92mr2641738pjr.210.1665706154127; Thu, 13
 Oct 2022 17:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221013175146.507746257@linuxfoundation.org>
In-Reply-To: <20221013175146.507746257@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Thu, 13 Oct 2022 20:09:01 -0400
Message-ID: <CA+pv=HOgkkRzFbXrxF6tiatFW+c=9_zPDZ2nFwyHaJRhd_HPyA@mail.gmail.com>
Subject: Re: [PATCH 6.0 00/34] 6.0.2-rc1 review
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

On Thu, Oct 13, 2022 at 2:02 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.0.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.

Greg,
6.0.2-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Thanks,
-srw
