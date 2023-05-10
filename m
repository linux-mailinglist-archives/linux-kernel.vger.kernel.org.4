Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C016FD941
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjEJI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjEJI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:27:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C864488
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:27:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6436e004954so7149256b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683707224; x=1686299224;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGI6Lm0AtHzSQXtW9u+HWh/q47GLCgh6RMnfXKjtk10=;
        b=YnwK0D3uKISsnbmkLu/Sz2qEaUpF/rrJT6uvrOoLYwds3FdiFRlmjeK476qnd3MGE9
         AJdtQgkElfru8rnQ2nKkw1UTf/5MfGgd9GnsCVqvHrkuD+Emyu2IBMWaIJmUVRi5RxG4
         sMisuF/kJ4orfSI6BK56uzDEOAjgthG/g/oY/TWl+MN49yBtsIIca3n8+bwT67POXErD
         embuMk0HH8YV1SA0WHY4yqOoYeh4r5EBo24AxQcTR65mDc6KIrAC0MvG6pQ9pXRD57PT
         F/hWGRPfhJP6LE/bSa6zVUUxJ/pd7L/60Lw1VYq80XAovRMRZz+kJ7zuqngQnWOr6snr
         iYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707224; x=1686299224;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fGI6Lm0AtHzSQXtW9u+HWh/q47GLCgh6RMnfXKjtk10=;
        b=AEfMr8UkNDXF1krOjcZ2haSc+zb2j86cnwUHLpn1c2A42AXcGZ9km1EGWgWjoZY9M3
         QeC1tHbe50qMdDoyKI2wwygEFsvVq+uyXsV2AnpWPRGfDXLzwJYujxRpDuWdm1UAFmHU
         Eai0D71ufZHgjoVdFUijH/QyVTuDNsPmMxXCh3py+CnxX4WZI/p6HUZCHNp9GfU5Z2bu
         vjsSSAuZ0l+xYDiM52E/Qb/QcmBdlfYEzoY91IzrwCVwiwUflpjbh0NuNLJttzLitZa+
         2e2d2ZwLcbO7J5j4eP6oJJmZrnnddNGmqpJc2+xsnEvaT9VLAEPTzifFYmuUFlgjm7IY
         Acxg==
X-Gm-Message-State: AC+VfDzmwhPE/RzOWN07T2bluQIXnfvtkxRKQpVXeFN54rhcMoywE0Qc
        V0r78NazMVo+YieM/LcrkPWvxgv/zkCI8w==
X-Google-Smtp-Source: ACHHUZ7G4coGPv/o20Pt3xAf2wqBDv9uLRjifxHDFgKM8gjudvDiKaJ8QVkC6VJLFijHhAiDaiMFGg==
X-Received: by 2002:a05:6a20:6a14:b0:d9:250:665c with SMTP id p20-20020a056a206a1400b000d90250665cmr20275025pzk.15.1683707224082;
        Wed, 10 May 2023 01:27:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id p15-20020a63fe0f000000b00514256c05c2sm2671485pgh.7.2023.05.10.01.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 01:27:03 -0700 (PDT)
Message-ID: <c2168e4f-4d47-0d5d-a1b7-d237f0760df8@gmail.com>
Date:   Wed, 10 May 2023 15:26:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        "Jiadong.Zhu" <Jiadong.Zhu@amd.com>,
        Yang Wang <KevinYang.Wang@amd.com>,
        Candice Li <candice.li@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     "Azamat S. Kalimoulline" <turtle@bazon.ru>,
        max <kernel-ODwfxu5zp4@maxxor.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Kernel 5.11 crashes when it boots, it produces black screen.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a regression report on Bugzilla ([1]). As many developers don't
have a look on it, I decided to forward it by email. See the report
for the full thread.

Quoting from the report:

>  Azamat S. Kalimoulline 2021-04-06 15:45:08 UTC
> 
> Same as in https://bugzilla.kernel.org/show_bug.cgi?id=212133, but not StoneyRidge related. I have same issue in 5.11.9 kernel, but on Renoir architecture. I have AMD Ryzen 5 PRO 4650U with Radeon Graphics. Same stuck on loading initial ramdisk. modprobe.blacklist=amdgpu 3` didn't help to boot. Same stuck. Also iommu=off and acpi=off too. 5.10.26 boots fine. I boot via efi and I have no option boot without it.

Azamat, can you try reproducing this issue on latest mainline?

Anyway, let me add this regression to regzbot:

#regzbot introduced: v5.10..v5.11 https://bugzilla.kernel.org/show_bug.cgi?id=212579
#regzbot title: Booting kernel on AMD Ryzen 5 PRO stucks in loading initrd

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=212579

-- 
An old man doll... just what I always wanted! - Clara
