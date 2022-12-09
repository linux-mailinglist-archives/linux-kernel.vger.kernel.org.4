Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFD647DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLIG1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLIG13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:27:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6DA0F81
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 22:27:27 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x66so3009587pfx.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 22:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jUPsjxg8mjZtPZdgOOBhKekaG25NqeQVx3NoTckFqU=;
        b=Om/s5iBhy8JwdyH6SpFGpvmiX0UPIEiHvO0hdr4EDejdTZOXZ3j4iXjv/5my7z2b8O
         Z6fALnQob1nShvjNHelMTr5wK0Pfaq2BnnCmL1ryM5qNkEW4e7md51ure7IzTowbi7M3
         6VaRdkCbxLd8G2WPqS9T2VIpux4aLHBt+h4WU/eWUem2z9LsV4be6PFsn93R+lH0YUDp
         0AteGwXK5H5PRwywxxk5Qlu+j04Y3HiwBg4rZIy+n1ST/S1FlWq7UKU+r2JcVZa6q0vX
         YfNpt/B2bJVP+a5QZdS2+bl7A9U23yiKGcNCmFfKIO5fEDEzvx5/809EjG67/u1dkfkX
         82sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jUPsjxg8mjZtPZdgOOBhKekaG25NqeQVx3NoTckFqU=;
        b=pe/Z8tS01XnFD9NsT03YBNd8Z06QnQfRh/S3e9j4brtMP7y1fyAqyCsZGZHZ/vGYRp
         4v1JXKn9v6e22eqj3J5RSfzXj1RLQc0yvVuMmcg5Suyh3SYy9Se5exSpHYfqMS3Ceg07
         cmSfHxL09kelNldnMCzgkYqXPg7ps3FWzTymazZ1CyAXAk77wuXnz/Rd+fcLNeJmHp9V
         6x1uGZryl783MwEvUz5ig4duF2s2nEBQHMxFbAN9+w2mQ+Q2u+6QPXYm30NbOE7A9JmD
         ADu8MjpRKegFPoQktJtb4ar1P0Mfzl2GgWD91CHU2Rt+mjSgYlLWXkBvC5wWZMV2/MrE
         lbNg==
X-Gm-Message-State: ANoB5pn0UlspBOHNwzOHY+PyfvepIJxPG11RAK3mx3Z54Qxwv/Q5SIAw
        l1b++JiVz/Y6gOFTClf3vviq3g==
X-Google-Smtp-Source: AA0mqf65atgRZvrXd5DTqRN8+QS2yCowlpJ7bliMI1T8LHb+bEEQ43Npp6j2jbLxgB5kgdsxYFtJag==
X-Received: by 2002:a62:3896:0:b0:576:1c37:5720 with SMTP id f144-20020a623896000000b005761c375720mr4539976pfa.4.1670567247274;
        Thu, 08 Dec 2022 22:27:27 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id e67-20020a621e46000000b00574e84ed847sm503077pfe.24.2022.12.08.22.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 22:27:26 -0800 (PST)
Date:   Thu, 08 Dec 2022 22:27:26 -0800 (PST)
X-Google-Original-Date: Thu, 08 Dec 2022 22:27:22 PST (-0800)
Subject:     Re: RISCV Vector unit disabled by default for new task (was Re: [PATCH v12 17/17] riscv: prctl to enable vector commands)
In-Reply-To: <b1dae947-d52a-d28e-5ddc-c1ad6d29828c@rivosinc.com>
CC:     stillson@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, Andrew Waterman <andrew@sifive.com>,
        Darius Rad <darius@bluespec.com>, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, fweimer@redhat.com, libc-alpha@sourceware.org,
        Conor Dooley <conor.dooley@microchip.com>,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Vineet Gupta <vineetg@rivosinc.com>
Message-ID: <mhng-84ad9495-ef4b-4343-89ee-dfe45ab69ff7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022 21:16:06 PST (-0800), Vineet Gupta wrote:
> Hi Darius, Andrew, Palmer
>
> On 9/21/22 14:43, Chris Stillson wrote:
>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>>
>> @@ -134,7 +135,6 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>>   			if (WARN_ON(!vstate->datap))
>>   				return;
>>   		}
>> -		regs->status |= SR_VS_INITIAL;
>>
>
> Perhaps not obvious from the patch, but this is a major user experience
> change: As in V unit would be turned off for a new task and we will rely
> on a userspace prctl (also introduced in this patch) to enable V.

IMO that's the only viable option: enabling V adds more user-visible 
state, which is a uABI break.  I haven't really had time to poke through 
all the versions here, but I'd have the call look something like

    prctl(RISCV_ENABLE_V, min_vlenb, max_vlenb, flags);

where

* min_vlenb is the smallest VLENB that userspace can support.  There's 
  alreday an LLVM argument for this, I haven't dug into the generated 
  code but I assume it'll blow up on smaller VLENB systems somehow.
* max_vlenb is the largest VLENB that userspace can support.
* flags is just a placeholder for now, with 0 meaning "V as defined by 
  1.0 for all threads in this proces".  That should give us an out if 
  something more complicated happens in the future.

That way VLA code can call `prctl(RISCV_ENABLE_V, 128, 8192, 0)` as it 
supports any V 1.0 implementation, while code with other constraints can 
avoid having V turned on in an unsupported configuration.

I think we can start out with no flags, but there's a few I could see 
being useful already:

* Cross process/thread enabling.  I think a reasonable default is 
  "enable V for all current and future threads in this process", but one 
  could imagine flags for "just this thread" vs "all current threads", a 
  default for new threads, and a default for child processes.  I don't 
  think it matters so much what we pick as a default, just that it's 
  written down.
* Setting the VLENB bounds vs updating them.  I'm thinking for shared 
  libraries, where they'd only want to enable V in the shared library if 
  it's already in a supported configuration.  I'm not sure what the 
  right rules are here, but again it's best to write that down.
* Some way to disable V.  Maybe we just say `prctl(RISCV_ENABLE_V, 0, 0, 
  ...)` disables V, or maybe it's a flag?  Again, it should just be 
  written down.
* What exactly we're enabling -- is it the V extension, or just the V 
  registers?

There's a bunch of subtly here, though, so I think we'd at least want 
glibc and gdb support posted before committing to any uABI.  It's 
probably also worth looking at what the Arm folks did for SVE: I gave it 
a quick glance and it seems like there's a lot of similarities with what 
I'm suggesting here, but again a lot of this is pretty subtle stuff so 
it's hard to tell just at a glance.

> I know some of you had different opinion on this in the past [1], so
> this is to make sure everyone's on same page.
> And if we agree this is the way to go, how exactly will this be done in
> userspace.
>
> glibc dynamic loader will invoke the prctl() ? How will it decide
> whether to do this (or not) - will it be unconditional or will it use
> the hwcap - does latter plumbing exist already ? If so is it AT_HWCAP /
> HWCAP2.

That part I haven't sorted out yet, and I don't think it's sufficient to 
just say "userspace should enable what it can support" because of how 
pervasive V instructions are going to be.

I don't think we need HWCAP, as userspace will need to call the prctl() 
anyway to turn on V and thus can just use the success/failure of that to 
sort things out.  

Maybe it's sufficient to rely on some sort of sticky prctl() (or sysctl 
type thing, the differences there would be pretty subtle) and just not 
worry about it, but having some way of encoding this in the ELF seems 
nice.  That said, we've had a bunch of trouble sorting out the ISA 
encoding in ELFs so maybe it's just not worth bothering?

> Also for static linked executables, where will the prctl be called from ?

I guess that's pretty far in the weeds, but we could at least hook CRT 
to insert the relevant code.  We'd really need to sort out how we're 
going to encode the V support in binaries, though.

> [1] https://sourceware.org/pipermail/libc-alpha/2021-November/132883.html
