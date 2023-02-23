Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63506A0C00
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjBWOjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjBWOi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:38:59 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661CB30B03
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:38:55 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id m10so13780331vso.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KRU/Mil2/Cn0wlylXq7PWdU4aS/7MOdCPh+sd7lM4Ek=;
        b=TlOYWovu1/4C3AH4v6gHtFk48F5kE+WGwULXVqbuZNwoavh9mn7xMAQoA5rd165aTb
         FradEzbYegmFDHFW58C6UbWIPYD+0TgRN5OGuHtBEL/DFodZL3G7pcG2pSWDiy4kscLd
         8v9ml5l+lCmW9K/bZE+Z9s5KxmVxSQ1oScLZTIOR93BytwVhOBpk9q+WnxPYTVSArdkB
         SESzfiMRZXuepaj4hxogoHdQiauAPe8TsFKGM3Mxw6+wLzRQ1kOBR/QZTxDPNok0Cnaz
         uv5AvTjLJ9qDdKsc4Lqafnw4FODpO7fowDs35KVCMNfGmMW5pEi6Djva9E3IhIG7r/0q
         HTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRU/Mil2/Cn0wlylXq7PWdU4aS/7MOdCPh+sd7lM4Ek=;
        b=J4nlTHSk83IjWn0FD9tFxAMqa0TX1YbzsQVdxNRm8SHhcFx4Bl1hkL3QTzhNVU7YRt
         ZIUWfuFFBfkIY2fNxdwkKCAVfM0HgfxJ5uHMlO7HFkV5p/1yKbbvC4t2whHELQVI30Wc
         itHRjfw2K2poT4Dap0p7nc3tfMVOqv/VLNHS+Q4ILIOwr2ov3REXXZEJw+IzaM7HoqG3
         4ahAmF6A8EdbNPfvbLRpDNNmEDM2L+lZpU2xTeroUfZFLcXgrrZVw5qC3t2wKQ7WauJK
         BDXyVtNUpZGpBX9ytGsWr7VJKcwm6UhZGbSOTwjqafnre+yi6QcHFUHA4V76saMx/yzW
         rzhg==
X-Gm-Message-State: AO0yUKXrOhyVRtAE2x+AafX0sPbZk30XwJMPciJ8ujhdZXiMvhzPONUe
        yQp1tBJRc2S7RthCxWoxyBxiQyifiu2qUKstZgspdQ==
X-Google-Smtp-Source: AK7set92kDhiLsYT2rc8uVgLLx9awLk+m8hYTvq/N4btKS5iC8vlmSaqeDDCSSg5WGfEss/5zbmtqhFO9CIwNrCBeiw=
X-Received: by 2002:a05:6102:1161:b0:41f:2138:41eb with SMTP id
 k1-20020a056102116100b0041f213841ebmr538860vsg.28.1677163134299; Thu, 23 Feb
 2023 06:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20230223130431.553657459@linuxfoundation.org> <Y/d5KdOfh5rXUeqk@wendy>
In-Reply-To: <Y/d5KdOfh5rXUeqk@wendy>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Feb 2023 20:08:43 +0530
Message-ID: <CA+G9fYsG8t1qO6MzJ=OYmegDwXCePafWbYjCc=JgiF3Mk5yQxg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/46] 6.1.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 at 20:03, Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Thu, Feb 23, 2023 at 02:06:07PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.14 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 25 Feb 2023 13:04:16 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.14-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
>
> > Dave Hansen <dave.hansen@linux.intel.com>
> >     uaccess: Add speculation barrier to copy_from_user()
>
> This breaks the build for me on RISC-V, you need to take f3dd0c53370e
> ("bpf: add missing header file include") from Linus' tree.
> It was broken in mainline too, so it is probably broken everywhere you
> backported it :(

Thanks for your report.

I do see arm and arm64 build breaks with following build warnings / errors:

kernel/bpf/core.c: In function '___bpf_prog_run':
kernel/bpf/core.c:1911:17: error: implicit declaration of function
'barrier_nospec' [-Werror=implicit-function-declaration]
 1911 |                 barrier_nospec();
      |                 ^~~~~~~~~~~~~~
cc1: some warnings being treated as errors

>
> Thanks,
> Conor.
>

- Naresh

--
Linaro LKFT
https://lkft.linaro.org
