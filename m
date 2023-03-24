Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46A16C7D64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCXLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:43:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAB81EBC1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:43:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i9so1501136wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679658193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEeRHO/zUWvbMymxotAYrIHIcsBog8Q80jrMbSXh8GA=;
        b=jtZSsoPSziKeFSqWmKe4UJGQbP8HAsz9FRaV1wjqLkOnMX2Bz2PLVjuVjktfcNUGwN
         fwU4JI0qlVBfYSZhRQ4MQ3gPyLkRZGdkbNVjusrWaMjCVF43pIhKWsDehBtXBIwttP/n
         32zHASDiLjykr08A1+lYeoNOTxpAOoJr3o+9BQKPD1bCt+0jvWgFQUYFv6pMFPp4ARkT
         mqsV8739AmY9NbU8op9dpy7xI9/TU02s06hGEd4hAX0YD25XElzFn9AeQiWYyupNXcGH
         H+oz74SEcLjgaKBupVWzFd3TMO+mekIbPTW/YF4ufYRoWsU91uz5vupyKZiZLrhY0D/0
         4fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679658193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEeRHO/zUWvbMymxotAYrIHIcsBog8Q80jrMbSXh8GA=;
        b=7ky9C8SyF6eFW9sxZQyC93ZmVCxwsW2aXA1/trsuBjnycVm8nBtcS7URV9td39QLc1
         9u2DdWYFYp3J8Gxv/IFo21gVsScITHKjZoJ2Lq1U2+TX8GjlPq3nFMN/CvuhupDkMwdY
         tdnNUcW0YSuvWNdH8Q4INX8IDuRqCX0UGig9dFbt+8LMTo0avqAvT04fYmo5mktZOmqw
         fehgMhzQUz56FA+kWYFoNVvkfpkLWg/HplTdmtvDCRjao9CKQ7qwMKDXZA8GKkUFlQ75
         vsjYRigVuOanvOWV6OrNPVcI5YwURJI3bcbujVWDL4j9/Y8Q0e4SKuKk3/kRxKtArGNW
         JOvw==
X-Gm-Message-State: AAQBX9fDF+Q7gVZJvW0aFDgBybFxsLvG0asKzE/lFu89EyqVz+lC22pT
        uLKhK6Y4dkVly3k+uIwFFyO6dg==
X-Google-Smtp-Source: AKy350Z/UCo3kmjL9dhSC1YdmHdx2KJPkpn9W8DAu/g/ULXFouz75vnHb+P2zmaIxhPKxzu5o8zeLQ==
X-Received: by 2002:a5d:6986:0:b0:2cf:ef5b:49d4 with SMTP id g6-20020a5d6986000000b002cfef5b49d4mr1766130wru.48.1679658193019;
        Fri, 24 Mar 2023 04:43:13 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b002c561805a4csm18190041wrr.45.2023.03.24.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 04:43:12 -0700 (PDT)
Date:   Fri, 24 Mar 2023 12:43:11 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] RISC-V: Fixes for
 riscv_has_extension[un]likely()'s alternative dependency
Message-ID: <20230324114311.qjz62iofsrhgdlnz@orel>
References: <20230324100538.3514663-1-conor.dooley@microchip.com>
 <20230324113107.djp4ejnlpzn3qzrb@orel>
 <e7a93223-54e4-4c97-b121-5d1be3af0d65@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a93223-54e4-4c97-b121-5d1be3af0d65@spud>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:37:05AM +0000, Conor Dooley wrote:
> On Fri, Mar 24, 2023 at 12:31:07PM +0100, Andrew Jones wrote:
> > On Fri, Mar 24, 2023 at 10:05:37AM +0000, Conor Dooley wrote:
> > > Here's my attempt at fixing both the use of an FPU on XIP kernels and
> > > the issue that Jason ran into where CONFIG_FPU, which needs the
> > > alternatives frame work for has_fpu() checks, could be enabled without
> > > the alternatives actually being present.
> > > 
> > > For the former, a "slow" fallback that does not use alternatives is
> > > added to riscv_has_extension_[un]likely() that can be used with XIP.
> > > Obviously, we want to make use of Jisheng's alternatives based approach
> > > where possible, so any users of riscv_has_extension_[un]likely() will
> > > want to make sure that they select RISCV_ALTERNATIVE.
> > > If they don't however, they'll hit the fallback path which (should,
> > > sparing a silly mistake from me!) behave in the same way, thus
> > > succeeding silently. Sounds like a
> > > 
> > > To prevent "depends on !XIP_KERNEL; select RISCV_ALTERNATIVE" spreading
> > > like the plague through the various places that want to check for the
> > > presence of extensions, and sidestep the potential silent "success"
> > > mentioned above, all users RISCV_ALTERNATIVE are converted from selects
> > > to dependencies, with the option being selected for all !XIP_KERNEL
> > > builds.
> > > 
> > > I know that the VDSO was a key place that Jisheng wanted to use the new
> > > helper rather than static branches, and I think the fallback path
> > > should not cause issues there.
> > > 
> > > See the thread at [1] for the prior discussion.
> > > 
> > > Cheers,
> > > Conor.
> > > 
> > > 1 - https://lore.kernel.org/linux-riscv/20230128172856.3814-1-jszhang@kernel.org/T/#m21390d570997145d31dd8bb95002fd61f99c6573
> > > 
> > > CC: Paul Walmsley <paul.walmsley@sifive.com>
> > > CC: Palmer Dabbelt <palmer@dabbelt.com>
> > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > CC: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > CC: Andrew Jones <ajones@ventanamicro.com>
> > > CC: Anup Patel <apatel@ventanamicro.com>
> > > CC: Jisheng Zhang <jszhang@kernel.org>
> > > CC: Andrew Jones <ajones@ventanamicro.com>
> > > CC: Jason A. Donenfeld <Jason@zx2c4.com>
> > > CC: linux-riscv@lists.infradead.org
> > > CC: linux-kernel@vger.kernel.org
> > > 
> > > Conor Dooley (2):
> > >   RISC-V: add non-alternative fallback for
> > >     riscv_has_extension_[un]likely()
> > >   RISC-V: always select RISCV_ALTERNATIVE for non-xip kernels
> > > 
> > >  arch/riscv/Kconfig             | 12 ++++----
> > >  arch/riscv/Kconfig.erratas     |  6 ++--
> > >  arch/riscv/include/asm/hwcap.h | 50 ++++++++++++++++++++--------------
> > >  3 files changed, 38 insertions(+), 30 deletions(-)
> > > 
> > > -- 
> > > 2.39.2
> > >
> > 
> > LGTM, but if it was based on for-next then it could also immediately be
> > applied to zicboz. For the series,
> 
> Hmm, I did it on top of fixes since this needs to go into v6.3.

Ah, sure.

> Perhaps I can create a standalone patch for Zicboz and Palmer could merge
> these two into both fixes & for-next, with the standalone applied on
> top?

Sounds good.

Thanks,
drew
