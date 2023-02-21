Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE6169E910
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBUUkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjBUUkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:40:21 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D95301BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:40:11 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id s8so2205419ilv.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhJ03HWaHgcQf5OOYhlL9i+S+dAZS2VRK1yIdsqmC7s=;
        b=b6ktkeNj8WV1cTpi4ZZdby245M/K7jo3YcUSE0syTwjhuTI7mywNeTt//HMF69Mx9E
         2YSGktOCxrRiJjbofyxPuH85woOah/dfpZTvUoTgEwvXC5MIwdUg/T/jocbAG9A5qUFa
         JAgl32076dnrIx7tdF1gADyv3jbo6S9CvGd8YvsSPdem3Tt+ZZOWBq21rgNcSwdAMKnE
         sSIyFrMeg1KHXavwRjQbFSRGt/Od4D0VkMU8kcknlTUkoP36pboBg6I1KAGAyCXI8yLm
         yKmwsgyIyS3rvJCBYJ24/a7OC8H+SWakfZRON6Kkliz5dTEE0tGTSjctsLRBCFmhqIY1
         akQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yhJ03HWaHgcQf5OOYhlL9i+S+dAZS2VRK1yIdsqmC7s=;
        b=DaLyUD5undw4PdmtalcKPluC6zbm1Ne8Dp1M6pMw3AUafpBw4S//oJkyUPqEmGjoVr
         Fcl7nUQ2ULKfiR+Kg9/jLu+5FUFRC2ebYogmHJXh59aVnBIqrW+jm09prCnEwmPN9WCC
         pzzmfhNutC5oNrkArweLzA8s0hKi8rfe8RefUA8+oVimtfXnVsFuB/I+zjKm7/9+lF/N
         TG6xquAj9KZTq/Qdo2bIxgk7JOOYh1TnX03NnKMqbl6csaT6GHucyu9d7M5CQ3FueWpO
         YGC7n5kKXcTjlDeK6RgtgGq+gStsCMaJYh5Oh36ynRW0iHtCjLoffmFpjZmX8of55IHt
         WoVA==
X-Gm-Message-State: AO0yUKXeZs0HOitU0U3828kA8i7Hd/8gPWxcVk9onaPvHi7X/TnjlCiA
        PuMFLVaE/qEfv7BLYc0tf2PAucCJ8qmdbefrAhQ=
X-Google-Smtp-Source: AK7set88KnKoKx+kHGOs5DNe/wu/M+9pYE9ROIHJ7WN0WfN4v9J5xt/zSSCAbRWyJVWCa46eLmwPng==
X-Received: by 2002:a92:cd8e:0:b0:315:459a:8bd with SMTP id r14-20020a92cd8e000000b00315459a08bdmr6555310ilb.25.1677012010889;
        Tue, 21 Feb 2023 12:40:10 -0800 (PST)
Received: from [172.16.32.78] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id r2-20020a922a02000000b00313ca4be5e1sm756486ile.12.2023.02.21.12.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 12:40:10 -0800 (PST)
Message-ID: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
Date:   Tue, 21 Feb 2023 14:53:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kbuild@vger.kernel.org, Li Zhe <lizhe.67@bytedance.com>,
        llvm@lists.linux.dev, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>
From:   Rob Landley <rob@landley.net>
Subject: [PATCH 0/5] Patches used to build mkroot.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ~300 line bash script in toybox that builds bootable Linux systems
for a dozen-ish targets can use a vanilla kernel, but the binaries I
ship are built from a kernel with these patches:

https://github.com/landley/toybox/blob/master/scripts/mkroot.sh
https://landley.net/toybox/downloads/binaries/mkroot/0.8.9/

I've posted each patch to the list already, but here they are together
and updated for 6.2:

1) let LLVM build normally without telling Linux on the command line
This way I can mix CROSS_COMPILE=$ARCH-unknown-linux-cross- without
having to care that some are llvm and some are gcc.

2) don't require an extra dependency to build x86-64 no other target needs.

3) Make CONFIG_DEVTMPFS_MOUNT work in initramfs. That way having
the kernel build archive up a directory into a cpio.gz as a normal
user doesn't leave me without a /dev/console and thus init running
with stdin/stderr/stdout closed.

4) Replace the only user of bc with c. (Another package dependency
with only one user.)

5) Fix rootfstype=tmpfs in initramfs. (A thinko I made in 2013 which
nobody else has bothered to fix for a decade now.)
