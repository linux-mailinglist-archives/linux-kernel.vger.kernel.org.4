Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7585F9762
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiJJEZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiJJEZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:25:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92B1C102
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:25:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g27so14245486edf.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eYIWoBzISWNiaFgZK0kBLxYMV/52i3ncI+TFO3bhqBI=;
        b=txgJwnubEG4zxxfOzPKAburmZc6NqVwL5t9UsZsAwui8bnwnWbeNdjBgCh4ySZFASj
         +/w6WWBbSgs2rbyni2WTq3E3oIS5sHNJRcW0NV0GBvwJvfU/RgMj4yE0IPzdJmT3yZ8E
         EzRDeD6KlRgBpye2kC8BScSsU7HH3NF4b4ZrBndjsmb4PfaIat6aVpd0nBgMmz3kzDUO
         XvP5Ysvu8GN4IGcJWtZRqW3APvPBinvkPc7NzDwpaA1yZ3QnAUHgg34SJPF3m0JogGd1
         SDU4qgMSfrf9SPs05ZvetWqTnFay28lBPeEWSUasbe3RURjP2lZuEARrvYTQvTXBqwu0
         8Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYIWoBzISWNiaFgZK0kBLxYMV/52i3ncI+TFO3bhqBI=;
        b=VEEXendRcaAhMaJQBNqSqFpUCs4BVi1F0NzQi2L1q4vDI1uNBg2cctAEVmHvB9cAiP
         X+OBCupE8OuWQ6NbFEuyL9dgFXPsXSJP3KVsIVq9mydI7O31GQY3vNGyRocTPS6b6Mg8
         PHRk6OZjPB7ZijFIrxn6SZLsOv+KRXb29fvCvhGAJ5QBYwmfFfLaxLBljwt3M7vlzGlK
         3Rf9uFxtqc/UizLbD6bjRuvUi2OWgrz9PCLbapeiTylDwmZElADa4gu4/1e5pwJ3jYrU
         Idgh94TvQqyrvLEuBOoJ2sBPl8wCU9i7eXtpAJrQ0ZFkLMJLuivIQsQuRkaPvJxe3ZMr
         ruSQ==
X-Gm-Message-State: ACrzQf33sT7cwyii/cdaxWv8pbkkEg8B3VQu4CoS+rcLcw2YANe4t0yd
        DcNyrz/hnLzqNwpQ9+77+H9sn1DXJCMV7+SxfCzDYDEv
X-Google-Smtp-Source: AMsMyM7WLePdaCQwBE/zbL5rFNhk7s6ramJmXX+AI0/fTiACo7PPGL26BroGQQrC7qdYcr7pfyYh2EOuN7cxN7KvtUc=
X-Received: by 2002:a05:6402:847:b0:453:943b:bf4 with SMTP id
 b7-20020a056402084700b00453943b0bf4mr16214829edz.301.1665375899634; Sun, 09
 Oct 2022 21:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <202209280309.kaIzKfm8-lkp@intel.com>
In-Reply-To: <202209280309.kaIzKfm8-lkp@intel.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 10 Oct 2022 09:54:47 +0530
Message-ID: <CAOh2x=mJp+xsR=Y4PnHTT9DGemUx491j2ST7dP9XDUf89A+xLw@mail.gmail.com>
Subject: Re: arch/arm/mach-spear/spear6xx.c:365:13: warning: no previous
 prototype for function 'spear6xx_map_io'
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 1:49 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   46452d3786a82bd732ba73fb308ae5cbe4e1e591
> commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
> date:   5 months ago
> config: arm-randconfig-r016-20220927
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-spear/ drivers/clk/spear/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

Sent patches to fix these warnings today. Thanks.
