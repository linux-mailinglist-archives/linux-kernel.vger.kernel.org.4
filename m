Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FEE6A2D0E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBZCG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBZCG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:06:27 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A568113DA;
        Sat, 25 Feb 2023 18:06:26 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q6so1220993iot.2;
        Sat, 25 Feb 2023 18:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EFQbRxHSsPKNCItLK55Hjyu7uq3Glv5bk5SL/HPENLw=;
        b=pWl9WeshiUsJJpSN94ckZrzGj8ltCX4QfX3dzF6nARHNtRoAXdghfuRZf4/vGXUJUW
         sBbfR7GSZoF0L4vP+oi5w9YxWVGK5Pn2hSymO9bcaYg1mCtKrdACDzuRlCbzHJUPJneR
         cS2G2kA5UMrR+ly5+pz6W/9B6XhTQjXg/0KUsNeOZ1VLEqTINL8i3AW6u6o7vegrbjfN
         XQSqyClPFVy1LrEHgCTr5711M4o6uUvyAKzqWRwfhQOUXdW5A6/iIpIMvX3k+AV3gboi
         2cCgVlNGbFIlazjeF+pRTo/tSfOhu+E9riJK6xid9d+sz7NMmkGcAqCUEwKXOtFlS+ox
         HU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFQbRxHSsPKNCItLK55Hjyu7uq3Glv5bk5SL/HPENLw=;
        b=JGqCzhzpTLbfcqEpE5LuoPotZ+LEJqIV5K8lBUbXpc7mM9RLSPoLWOYpOpTmih/di1
         U1pBmgvnoWHE+SKYzwwTn9qIcxH+m4LCrZHvA0b+Rx5Wtah16Ad4OuHqf+YbQmGh4DdX
         dSTs8udZxjMyqoCIPUOJmeY9vSZs8dO206Ge9t1ON+aF7GTuqlp+Gw/FdxohsIXZGf1T
         LZh8wAQs1krKtCUHrnnKz5C4nKvQ6FTgG47mAJv/ACkD/yuqTzVzcSaoTPfTYSFq9IY2
         oozum1r+0XCqntj+d5Mz41helF9UKZ0Ej016GYbBpXTXw3s24oLHkKQQJbZSXKsgFUG3
         TSag==
X-Gm-Message-State: AO0yUKVD/LlVOxU1p+Nvo3y9cTeMv47zl1BpgpaHqVhtaFZAyAnwwIQ4
        tWVt95oPGhm6Ky1e2TcV5z9We4Wv7Bapwg0s0dQrd3Nllojz5g==
X-Google-Smtp-Source: AK7set/MlPlEPWlLadEyKgt76qfDiD1Iz/AOVbvZ4H8WCSAmhnYu/DiJXy6NU2VZEz/DY7PVFKYxnwwJ0fwprCFhX9A=
X-Received: by 2002:a02:85ae:0:b0:3e5:c536:392 with SMTP id
 d43-20020a0285ae000000b003e5c5360392mr4590406jai.5.1677377185660; Sat, 25 Feb
 2023 18:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20220929101329.31036-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220929101329.31036-1-lukas.bulwahn@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 25 Feb 2023 21:06:14 -0500
Message-ID: <CAEdQ38Gp0rFZjpRKsrYp94WyBQPB6=7YbHu6JvjYwf2odx+TgQ@mail.gmail.com>
Subject: Re: [PATCH] alpha: update config files
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 6:14 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Clean up config files by:
>   - removing configs that were deleted in the past
>   - removing configs not in tree and without recently pending patches
>   - adding new configs that are replacements for old configs in the file
>
> For some detailed information, see Link.
>
> Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/alpha/configs/defconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/alpha/configs/defconfig b/arch/alpha/configs/defconfig
> index 6a39fe8ce9e5..1816c1dc22b1 100644
> --- a/arch/alpha/configs/defconfig
> +++ b/arch/alpha/configs/defconfig
> @@ -39,14 +39,12 @@ CONFIG_PATA_CYPRESS=y
>  CONFIG_ATA_GENERIC=y
>  CONFIG_NETDEVICES=y
>  CONFIG_DUMMY=m
> -CONFIG_NET_ETHERNET=y
>  CONFIG_NET_VENDOR_3COM=y
>  CONFIG_VORTEX=y
>  CONFIG_NET_TULIP=y
>  CONFIG_DE2104X=m
>  CONFIG_TULIP=y
>  CONFIG_TULIP_MMIO=y
> -CONFIG_NET_PCI=y
>  CONFIG_YELLOWFIN=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> --
> 2.17.1
>

Thanks for the patch! This was included in my pull request today and
is now upstream in Linus' tree.
