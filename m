Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F96B712F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbjEZV6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbjEZV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:57:37 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B14173A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:56:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53eee18a192so1097221a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685138134; x=1687730134;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLAvQMER2SOLnEx4GHgiQ/jrA6UEouP5ZxfYcupEztU=;
        b=LHM4VIKOfTqivALm+Z6T0vyzaEZ8AhlZfyeEq/2NxjnrJsNop9k/1j6vyB4aly1Tk1
         Qhcz85JZZ2Eap4d1gY1Nc9GWlL4CRrCRGsac372kC2I4k/hR2tP71bADjEXic7xznLov
         Gum1LlWhXhearuTMzDTEsvFnnji4htZf2/SW1/iA+liz+btyKGDChTaRKsvLQFs70eem
         nkm4b8yab0Bxg/D9OLLmxU+FhdlXmcVd94NdytevccMe+mAHpPYgisMuebGa+atYZvBc
         Yxdbn82rY2wqyW4NTfe1uYK6etSCW9yy2qQgGZPkKz5lPCByXkBI8IEB1yIN9GMA+Jkw
         o50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138134; x=1687730134;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLAvQMER2SOLnEx4GHgiQ/jrA6UEouP5ZxfYcupEztU=;
        b=NstKNtb09xwh6bYx1qaFZBrpPpcYL8N6MwHQzqxjUK3vIXcst1elAPsMX80u0LOhJo
         DHeS7BTx07rs1algu/ibZiybVsrUKiEJimmAOTK9Ja2I+/F7b8JWam0l1W50ashlq6wZ
         jzrMuSkGBis6R+rDj8p2SigsdfGGpQbkH0BJTN2QcMyVPFzUlSRGS3yyhhCQZdS1O2cy
         NUyiW+b/M93dYci0GBUl5HIRZ27Or+hH6a1XhZZMF0NRuqCVqlodR61BmH1g306i7O/Q
         QXc1YevpiCCHAGRPy+CfqjSdyiKPMl6cg5BTgdcVeVfIxMSeZtPTSBRyGXkly/G43QvO
         Skgw==
X-Gm-Message-State: AC+VfDz2vLG2KCEaYoVUnWepxp4iMmnDi5vcTMzOpoeCeEZs/bgAJfoY
        sUoLcGY7L/H9Bo15ax5TANU=
X-Google-Smtp-Source: ACHHUZ6jZONJfN0l5aheTCIfTrjv+SJHJnmQhgHUvhWxlW0McxhUJWGhiuV0s127zxAtbEB5nJEfJQ==
X-Received: by 2002:a17:902:c94a:b0:1af:e2f2:1cce with SMTP id i10-20020a170902c94a00b001afe2f21ccemr5250821pla.38.1685138133854;
        Fri, 26 May 2023 14:55:33 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b001a2135e7eabsm3691204plf.16.2023.05.26.14.55.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 May 2023 14:55:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <e6cd1909-2776-28d2-ccc0-4b3d2d09e9ce@intel.com>
Date:   Fri, 26 May 2023 14:55:21 -0700
Cc:     Borislav Petkov <bp@alien8.de>, Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <49861038-B8CA-4CDD-BD44-73066FF453F3@gmail.com>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
 <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
 <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
 <e6cd1909-2776-28d2-ccc0-4b3d2d09e9ce@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2023, at 2:17 PM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>=20
> On 5/26/23 14:10, Nadav Amit wrote:
>>>> I did not ask to make them global. Just to keep them as local after
>>>> linkage in the executable, like all other functions in the kernel.
>>> Ok, not global. But local and present in the symbol table:
>>>=20
>>> 105185: ffffffff81b89330    17 NOTYPE  LOCAL  DEFAULT    1 =
bad_get_user_clac
>>>=20
>>> And again, this helps how exactly?
>> Allowing debuggers, tracers, disassemblers and instrumentation tools =
to
>> work the same way they work as they work with any other piece of code =
in
>> the kernel.
>>=20
>> I personally work on code instrumentation and this makes my life hard =
for
>> no good reason.
>>=20
>> [ Perhaps the question should go the other way around: why addresses =
of
>> code in these functions should not be mapped to any symbol? ]
>=20
> Nadav, is there a chance you could give us a real-life example of how
> this affects you as an end user?  What's a specific tool that you were
> using or a specific problem that you were trying to solve where these
> local symbols caused a problem?  How would the global symbol have =
helped?
>=20
> I can certainly _imagine_ some, but I'm curious what you saw that
> prompted you to send this patch.

So my tool takes a branch trace and then simulates the code execution.
As a preparatory step I need to disassemble the code, yet as I do not
know where the symbol starts and its size, I can only disassemble one
instruction at a time. [ I prefer to disassemble the whole symbol at =
once
not just for performance, but also to figure out if it includes some
instructions that my simulator does not know to simulate correctly. ]

In addition, as I read the code from kcore and the binary keeps =
changing,
I want to assume that if I do not find an address in the symbol table =
[*]
then it means this is some dynamically generated code that is no longer
available through kcore (eBPF, ftrace, etc.).

These are only 2 things that break to one extent or another. I can
have workarounds for them (I already do). I just see no reason to
treat these two symbols differently.

I would also note that I can think of many many additional reasons to
have each piece of code mapped back to a symbol (besides debuggers,
tracers, etc.) For instance, security monitoring tools should prefer to
be able to check what code is running in the kernel.

I seriously see no downside here and only benefit in consistency and
usability. I have no hidden agenda if for some reason you suspect that
I do. I don=E2=80=99t want to start talking too much about the tool I =
work on,
as I am afraid it is off-topic, but I hope to open source it soon.=20

--

[*] I know kallsyms does not give sizes, but I make some reasonable
assumptions and augment kallsyms with the symbols from the binary.=
