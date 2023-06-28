Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9486D74136B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjF1OIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjF1OGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:06:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD0B3A94
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:06:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b80f2e6c17so24416625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687961193; x=1690553193;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3BkDK05241Wak+mm9YscMVNm89SWiJwn3V52UthfcY=;
        b=ZOXHBpjyf+Vv9nCWYMngb0aLLIb04YHicJdy+dd7g/pI7h8Nuas58L+U96kQzDip+z
         EixEkcSGm5ShYnfXRguksXVRezjciTromRJQsg/W2DdffJzx8ybw5KFjQx8RAwRRSA+f
         Np5wDP+mf26mYMjHq4gFoF+zAU5SbA2WkADfDvjEqKSnV/vGY8jNnLYYG3wmKK4GeiF3
         vR/NRJnDjWkHepVjzWdUPwGqVJ/bNFvgA1VJMfSocZnxtgoeFmdcQ5aABxVQdIEiTd9N
         LshqRaTFd0bm051b/uljpTJD3MRSU0j31aEYHXM3jnU0Vyi6S4mg9/mluX7rKijT0dC5
         SYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687961193; x=1690553193;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j3BkDK05241Wak+mm9YscMVNm89SWiJwn3V52UthfcY=;
        b=FodrDqx95l6jk2c74PzLxY+6B8Lhri3Fh9Ed88GGMx/tWaOxAdw7S09OEDj+SsgQa8
         vDCWNSUMoDRDKTTNDcrWmVwgBOkEUHT8vG8ePhz6630MHcZ29E3AoG9QQGeFPEPG4Eo2
         OPru0KFu3ycVpzNdL/KNeUONKMMYBQqSV6X2U0ltjZxlkoaqOVRm2JMJO4aFH8IEHI8P
         Kq21dKhUu0bJb9fuvLD3M4NUxTq8FhepJe1fKmH/k782Il+TW1WwH/dJnZGll6691wxg
         6FZu68Z+7R2obSjLEIKIadiNgNDt5amXZdj/D+GeSv/0VZ0qXsfapJkF2iKVFceXYWbJ
         iDDQ==
X-Gm-Message-State: AC+VfDzMQswqrzSpoazc/usBpD6O5w5M3iv9PP1QgNrv5IYLS79gdaIY
        mXQiR98jagLwXiKOtSzJjZt/QYHiu/ZltA==
X-Google-Smtp-Source: ACHHUZ4G5B13ogdRQDNY1fe0TTeMCA5uMAxuIijkt1rxDchefc9P14S00VFh229EU8HzgmZlRHU61A==
X-Received: by 2002:a17:903:41cf:b0:1a1:b3bb:cd5b with SMTP id u15-20020a17090341cf00b001a1b3bbcd5bmr13962320ple.62.1687961192736;
        Wed, 28 Jun 2023 07:06:32 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b001b8025b32cesm5512359plg.131.2023.06.28.07.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 07:06:32 -0700 (PDT)
Message-ID: <4d9fb4a9-6c48-600c-f625-8ef66208090a@gmail.com>
Date:   Wed, 28 Jun 2023 21:06:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Borislav Petkov <bp@alien8.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: commit 9df9d2f0471b causes boot failure in pre-rc1 6.5 kernel
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Since yesterday my builds of the https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git no longer boot with a black screen immediately upon booting. Today I finished git bisecting the issue and arrived at the following:
> 
> 9df9d2f0471b4c4702670380b8d8a45b40b23a7d is the first bad commit
> commit 9df9d2f0471b4c4702670380b8d8a45b40b23a7d
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed Jun 14 01:39:39 2023 +0200
> 
>     init: Invoke arch_cpu_finalize_init() earlier
>     
>     X86 is reworking the boot process so that initializations which are not
>     required during early boot can be moved into the late boot process and out
>     of the fragile and restricted initial boot phase.
>     
>     arch_cpu_finalize_init() is the obvious place to do such initializations,
>     but arch_cpu_finalize_init() is invoked too late in start_kernel() e.g. for
>     initializing the FPU completely. fork_init() requires that the FPU is
>     initialized as the size of task_struct on X86 depends on the size of the
>     required FPU register buffer.
>     
>     Fortunately none of the init calls between calibrate_delay() and
>     arch_cpu_finalize_init() is relevant for the functionality of
>     arch_cpu_finalize_init().
>     
>     Invoke it right after calibrate_delay() where everything which is relevant
>     for arch_cpu_finalize_init() has been set up already.
>     
>     No functional change intended.
>     
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>     Link: https://lore.kernel.org/r/20230613224545.612182854@linutronix.de
> 
>  init/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Since it might be relevant, my CPU is Intel Core i5-12400 with UEFI from december 2022 and the compiler is gcc (Gentoo Hardened 13.1.1_p20230527 p3) 13.1.1 20230527. If additional information such as the kernel configuration is required, let me know.

See Bugzilla for the full thread.

The reporter can't provide requested dmesg due to this is early
boot failure, unfortunately.

Nevertheless, this regression has already been taken care of on
Bugzilla, but to ensure it is tracked and doesn't get fallen through
cracks unnoticed, I'm adding it to regzbot:

#regzbot introduced: 9df9d2f0471b https://bugzilla.kernel.org/show_bug.cgi?id=217602
#regzbot title: early arch_cpu_finalize_init() cause immediate boot failure

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217602

-- 
An old man doll... just what I always wanted! - Clara
