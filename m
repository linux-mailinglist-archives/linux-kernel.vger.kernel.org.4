Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ED769F036
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjBVIaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBVIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:30:12 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D423300
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:30:11 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e194so7837735ybf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JITitTilRwWtZ+8TA+RouLdVmRL4gJWiHTZg0eIoCZk=;
        b=WavO+JxF5t2H6lyHA9auxfHcsBrAcoHviimxf5CHYYFC3iCdGEEiV0Uistm18ClnGp
         Jcxs9k2VyQ/WiTRdwRQrkHEcx+S8vGlX4DUp6jZnyICuvJH7o/WrO38Ts96LXorRpP0b
         jSWYdkZ4fJQ5Fkq70u7sGir5DsrJnAeUh2/cpipuM3+am9rWQnes7IrxXZc7T9v7Ox/h
         tI/SMMwdR/QMA/gpU4lIIeOyOvfwaDdTd4b/66cjgDO/wlf1WGsM5IJMfa/bCIlYoJH9
         cMFjMIcYGnaMkOI97qMSAm0lugWk0RxnZ8onrWURR/DqecfRcsJnMrhNqu06F1BSy4WB
         Q/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JITitTilRwWtZ+8TA+RouLdVmRL4gJWiHTZg0eIoCZk=;
        b=pGznvdkwXJCc4hi3RsuTt4q0aqyNXZmgvw53wk/hUHbL0lPqQDTUYh5LJSQjSI3DkA
         DUb6xdK66hgIlHWfSXap5SLBhg59x5KxmstJCET8mSZWiYjuDo8dzj2X1oVBhURGuPWM
         SAJFHJS1jvLEqpJROCV16g+tbSeDRG+1oMBPOJGXYHu1sYsIGMrttolGLDsOceJn/Ewy
         trzG3SAY89QzlpV3dbvlNB+jPbw2H3R5ywot+xFNdKK+pC4ZedJWe22NwZSvSs3dN0dI
         OjgDw0vNp0QBbY/WvuqR4z9Pm4GSs9WY1LJ6UYfSpp9rUB8GXLWBEaHfsfv2/kswX7zt
         iYJw==
X-Gm-Message-State: AO0yUKVYNDxeJ/fnWN8FOKDMZIp9MkIcqxZn+xm5/5dvk9OMlrGqRkwZ
        NRTftNYFOpmFTxRbVgumY0OmEbbvMOFVT+3qvcCGwHJMu+8=
X-Google-Smtp-Source: AK7set97RST0PeQPQTJeZTMdfm2YTJw6VZNymGmZPZ9S39UjA/dBb5dfR+sjusjnhrQQYfra71NGN1GJvQwFGNp3mZs=
X-Received: by 2002:a25:8289:0:b0:a15:8c3a:dc72 with SMTP id
 r9-20020a258289000000b00a158c3adc72mr81267ybk.273.1677054610362; Wed, 22 Feb
 2023 00:30:10 -0800 (PST)
MIME-Version: 1.0
References: <202302221228.E0rmVamR-lkp@intel.com>
In-Reply-To: <202302221228.E0rmVamR-lkp@intel.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 22 Feb 2023 13:59:58 +0530
Message-ID: <CAOh2x=nPyOhBean4gEdTT-ZNDH1Sa3nCbBNyeZPNkGawQcYaOw@mail.gmail.com>
Subject: Re: kernel/bpf/core.c:1913:3: error: call to undeclared function
 'barrier_nospec'; ISO C99 and later do not support implicit function declarations
To:     kernel test robot <lkp@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Feb 22, 2023 at 11:12 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5b7c4cabbb65f5c469464da6c5f614cbd7f730f2
> commit: 74e19ef0ff8061ef55957c3abd71614ef0f42f47 uaccess: Add speculation barrier to copy_from_user()
> date:   6 hours ago
> config: hexagon-buildonly-randconfig-r005-20230222 (https://download.01.org/0day-ci/archive/20230222/202302221228.E0rmVamR-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)

> >> kernel/bpf/core.c:1913:3: error: call to undeclared function 'barrier_nospec'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    barrier_nospec();
>                    ^

I got the same one for arm64, the following patch must fix this.

https://lore.kernel.org/all/9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org/
