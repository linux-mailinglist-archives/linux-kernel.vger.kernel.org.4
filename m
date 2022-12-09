Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112956487A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiLIRWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiLIRVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:21:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE1101C2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:21:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so5623751pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3ftz22T4PBLAKYuAEy8MSiyeSsUvlcVd5LGzrsdS20=;
        b=o9iqnF1AFARrXLpxgvQ9MMiwrWgg/fYr9Im7EHbyQw4/mk6D1BEdl8J94wSiC8a3yw
         yijrOJXrMtAjL8BGmZ8C68RwIt10n1LBw/ki6zzN3MZCxq2mB36FcSScnkxzaj+pfTbA
         O/gsspSRNgHDKTYgpX8DbCDjxnFRGO7eSPD8kjXLRb3fKk1/nbh5+dST1MLO8dmvVYGc
         rRgG+r8bE1qrrt/QkqSARea+Nt7W8FMhF4Tjsgh9wGR0uB1216RAXtZSviYKd1yZNafv
         nToYZR1UgCXCODgPege/HytqhANmxMkBE1nxm6GvWwkTtNy0NY3nEydwEW00AvGvToMe
         xqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3ftz22T4PBLAKYuAEy8MSiyeSsUvlcVd5LGzrsdS20=;
        b=f+zaVfWEyaqkB7N+UpNaXBj9WEru5CpdsIvRJ6eYDCS7Tu/Cgn9w2j9I5AtKeLzEc9
         Rhc7nh7ytYx9Scv+NFiNrmagjX9uWp9NDQ1q7giA7us07auCDUa6LZEoMPN+rOxOaZ6L
         DuWrw9WTAA8JeDlIci5PJsXcJwnwBGSOAq5HB61jLH/w0hAv7droXd5zqJXR3meRUsSz
         M3vJEgq3jCZKdlw3oAtgyUQjqd9tMSYweiS6ccdq1veI8SK1tuPu9Hwixwh9qXL3yJF2
         Et0bMNRSJLrqP057GGoCAuJog3ZWyRUe2a6SuupyMK0bsyjkhJlPZ4pYumtyNioWD65E
         UX+Q==
X-Gm-Message-State: ANoB5pnLy6nkdHMECy/q+ncfKIwXHf+Dh2F2msgyATVDLfLJV7rlhKSW
        ocTK1DQ9+E9NrEdfkUMeLgo8PQ==
X-Google-Smtp-Source: AA0mqf5YLC0cMA5zeF7YRupkfPKEOPx/AfvG6bFsSz1kH37k+fIn4AaBCFQeOXKRSZWLtuKxEA57NQ==
X-Received: by 2002:a17:90a:d515:b0:219:c1e8:114d with SMTP id t21-20020a17090ad51500b00219c1e8114dmr6508249pju.26.1670606506081;
        Fri, 09 Dec 2022 09:21:46 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id kk10-20020a17090b4a0a00b001fde655225fsm10884328pjb.2.2022.12.09.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:21:45 -0800 (PST)
Date:   Fri, 09 Dec 2022 09:21:45 -0800 (PST)
X-Google-Original-Date: Fri, 09 Dec 2022 09:21:41 PST (-0800)
Subject:     Re: RISCV Vector unit disabled by default for new task (was Re: [PATCH v12 17/17] riscv: prctl to enable vector commands)
In-Reply-To: <87zgbwk9t4.fsf@oldenburg.str.redhat.com>
CC:     Andrew Waterman <andrew@sifive.com>,
        Vineet Gupta <vineetg@rivosinc.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     fweimer@redhat.com
Message-ID: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
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

On Fri, 09 Dec 2022 05:04:23 PST (-0800), fweimer@redhat.com wrote:
> * Darius Rad:
>
>> On Fri, Dec 09, 2022 at 01:32:33PM +0100, Florian Weimer via Libc-alpha wrote:
>>> * Darius Rad:
>>>
>>> > On Fri, Dec 09, 2022 at 11:02:57AM +0100, Florian Weimer wrote:
>>> >> * Andrew Waterman:
>>> >>
>>> >> > This suggests that ld.so, early-stage libc, or possibly both will need
>>> >> > to make this prctl() call, perhaps by parsing the ELF headers of the
>>> >> > binary and each library to determine if the V extension is used.
>>> >>
>>> >> If the string functions use the V extension, it will be enabled
>>> >> unconditionally.  So I don't see why it's okay for libc to trigger this
>>> >> alleged UAPI change, when the kernel can't do it by default.
>>> >>
>>> >
>>> > Because the call to enable can fail and userspace needs to deal with that.
>>>
>>> Failure is usually indicated by an AT_HWCAP or AT_HWCAP2 bit remaining
>>> zero, or perhaps a special CPU register (although that is more unusual).
>>
>> That would indicate that the extension is not present, which is one of, but
>> not the only way it can fail.
>
> I think you should bring down the number of failure modes.  HWCAP has
> the advantage that it communicates kernel/hypervisor/firmware/CPU
> support in a single bit, which simplifies the programming model and
> avoids hard-to-detect bugs.  It's not clear why it would be beneficial
> to continue on ENOMEM failures here because the system must clearly be
> in bad shape at this point, and launching a new process is very unlikely
> to improve matters.  So I think the simpler programming model is the way
> to go here.
>
>> The vector extension relies on dynamically allocated memory in the kernel,
>> which can fail.

The issue I'm worried about is that V needs more space in the 
ucontext-type structures.  We have an extensibility scheme there so we 
think it can be made to work, but IIUC we'll need glibc to be updated to 
handle the extended contexts in order to avoid losing state when doing 
ucontext-related operations like signal handling.

I don't see a way to handle that with just HWCAP, as we essentially need 
some bi-directional communicaton between userspace and the kernel so 
they can both decide to turn on V.  I don't think we strictly need a 
system call to do that, we kicked around the idea of encoding this in 
the ELF, but there's a lot of flavors of vector in RISC-V and we've had 
trouble trying to encode these in binaries before so it seems easier to 
just use the syscall.

> But this failure can be reported as part of execve and clone.
>
>> It also provides the opportunity for the kernel to deny access to the
>> vector extension, perhaps due to administrative policy or other future
>> mechanism.
>
> HWCAP can do this, too.
>
> Thanks,
> Florian
