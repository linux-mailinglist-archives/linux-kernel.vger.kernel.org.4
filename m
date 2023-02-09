Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6088C690EE8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBIRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjBIRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:10:15 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014A66EE7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:09:54 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h4so2835945lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40dyMgqFR1jhkwFKYPOlrUymSjEFMlS6pCrNocuBtSk=;
        b=odyZyLnCbQgBbN2iJeJzzPI+MasYlWfH6MjT1G5wK5VryQcBG6POjzlqTxik6huCTm
         MDpKA8YErI8YHhcOz3rimJeq5wS1Vc+hQKWpD1Rsgmohfl29zb0KtL4ScWM05QAgrYdr
         njnHwina4sA1BIoTUh8Y1dz6xqCCSo9t+wyP3UeuwcBTBGXlCXll0SWqlGCTH8u+a6ee
         qvApSLoV0R+k9YKjNHvvAELknWp5r+o6eOuKyf1cMSp5wmeWaIKLkaf0K9z0FPkGirX2
         P0FzV8dzm9WIHBkVLc0waM9YnbNeD5PdD1Q4qcZaJJaCY0wW3I31RxmAjQST7gKE5PjF
         j5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40dyMgqFR1jhkwFKYPOlrUymSjEFMlS6pCrNocuBtSk=;
        b=sIQ9jCwLwjfmIiyq3TkVeSGkLNOEepT46C47ajNjKXc42t3ECFLG02/xhef18xqGZd
         mUwIJwKT3Ycq9QI8I+LuAY8/LXPzgseRMD0z9JWowLNogdnFXHr9B4QQrVFnDB1Q5h4x
         3QwSAxmwkN2UwXMjt5BidsHHxjzdwkiQsWyCXlhyd7mCR1s72HEz5d/HoTi5xHy1MXWv
         9Hmw8jkKP1hg8VMSCn/jHEwtxTVCoauVvB4GmtrEfwUyRjSo16wQwrUVCQt7eKTVJ/FJ
         R6l+GEiX/au13mqr7aQBooEPOCAmiV0KxXCMk3hd+2nIchlJSRbIUyDaV3MxkKgzUqeC
         PuvQ==
X-Gm-Message-State: AO0yUKXOBOfbFZA/6O9bXvJBeci/16CcXK+NR1SeWlfwAxjrdvhMjMD2
        W2nfTmQp/1t8lVNWu/41SIwIEwxoJG9wA/rj9CoQKg==
X-Google-Smtp-Source: AK7set93dRuD5/ioQI1TmSE3wAUYoqC+pSkvpepu4Zbjim1mcGZ49sZ0fEd60UnyJAfwy9BDcu6jvg2t7uOuX5Dzulc=
X-Received: by 2002:a05:651c:3db:b0:290:5b65:ab86 with SMTP id
 f27-20020a05651c03db00b002905b65ab86mr1652382ljp.200.1675962592813; Thu, 09
 Feb 2023 09:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-3-evan@rivosinc.com>
 <Y+HsE397cY4HF+5K@kroah.com> <C3C21677-5250-4120-9A4F-24945C1EE51B@kernel.org>
In-Reply-To: <C3C21677-5250-4120-9A4F-24945C1EE51B@kernel.org>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 9 Feb 2023 09:09:16 -0800
Message-ID: <CALs-HsvuX-Uj5g9c6vvUp=MaUpdcPdpwwQCsxzjoXpqS+3LEsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
To:     Conor Dooley <conor@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 10:32 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Evan, Greg,
>
>
> On 7 February 2023 06:13:39 GMT, Greg KH <gregkh@linuxfoundation.org> wrote:
> >On Mon, Feb 06, 2023 at 12:14:51PM -0800, Evan Green wrote:
> >> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> >> system call that quite does this, so let's just provide an arch-specific
> >> one to probe for hardware capabilities.  This currently just provides
> >> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> >> the future.
> >
> >Ick, this is exactly what sysfs is designed to export in a sane way.
> >Why not just use that instead?  The "key" would be the filename, and the
> >value the value read from the filename.  If the key is not present, the
> >file is not present and it's obvious what is happening, no fancy parsing
> >and ABI issues at all.
>
> https://lore.kernel.org/linux-riscv/20221201160614.xpomlqq2fzpzfmcm@kamzik/
>
> This is the sysfs interface that I mentioned drew
> suggested on the v1.
> I think it fits ~perfectly with what Greg is suggesting too.

Whoops, I'll admit I missed that comment when I reviewed the feedback
from v1. I spent some time thinking about sysfs. The problem is this
interface will be needed in places like very early program startup. If
we're trying to use this in places like the ifunc selector to decide
which memcpy to use, having to go open and read a fistful of files is
going to be complex that early, and rough on performance.

Really this is data that would go great in the aux vector, except
there's probably too much of it to justify preparing and copying into
every new process. You could point the aux vector into a vDSO data
area. This has the advantage of great performance and no syscall, but
has the disadvantages of making that data ABI, and requiring it all to
be known up front (eg the kernel can't compute any answers on the
fly).

After discussions with Palmer, my plan for the next version is to move
this into a vDSO function plus a syscall. Private vDSO data will be
prepped with common answers for the "all CPUs" case, avoiding the need
for a syscall in most cases and making this fast. Since the data is
hidden behind the vdso function, it's not ABI, which is a plus. Then
the vdso function can fall back to the syscall for cases with exotic
CPU masks or keys that are unknown/expensive to compute at runtime.

-Evan
