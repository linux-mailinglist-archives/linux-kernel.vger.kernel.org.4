Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE671F765
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjFBAxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFBAxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:53:34 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFD6138
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:53:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38dec65ab50so1274726b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685667206; x=1688259206;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeEawLUjJLRgdu4kwyGqdCJZV+L8bI8PPgE9UhqJdFM=;
        b=Ej0Gm6HoaAVNrELRGVf5K4Z0s7qvrVV824R+kmNSiruHtdI2pU3g8r0Yd054Eqq99E
         iBRc95ObFHcwHPs1V/qlwFgPALbqKQ3v1O+X6s+22k56ADUxczAbBaKIRHCcpTHPEPKo
         Df4XMxAxq7QwtPmIv5C6jMtNyy8b+9JU+7EjwuY7Wx4bX2tzCJP4Mkrjas5EugfZryWt
         zkfNdKo+XgsT8feTVCp2sXAz4xLzDPEf7jSC9pjIgiX3ofhnyNee6yqM5+8tqwLygHHC
         0L1DRQuA3r3m5NiEawEjTvlXr/BCDHX9hB3Ino9DvEYR1irf/EUwT8vXi8t3O1Ad61Zb
         4Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685667206; x=1688259206;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeEawLUjJLRgdu4kwyGqdCJZV+L8bI8PPgE9UhqJdFM=;
        b=X4poIItGD3LitavnxRVrO9+7R/Pm2+g4S1w1EDGKjY31NXfj7sci0XxzyHSeovdkiA
         fgHA0w9y/RstSo4ah5bhj8i4CoDM6/hgAVdcJZr7bQ45y6HHtRh5vZPVCyNdVijc2d5N
         HTVgKuIAsNep0HHAJ+GZgyP/QdgZDlmgXCc6h2nIYd7MCneVHvNnudaSzjYFlhK5UiAQ
         3+sw9oD6EqMuEW+gbhrN1Av8Imvbb5Qc7bwBZWam4i86hHTPuySbsT4K5My0nJkcKVyN
         BdlV/zfN3/euw9rYMRvextI6sNlKP+xX0KWC3i1pnWt/DOqI0PD06kt0D6qqke8TAOAi
         l6tQ==
X-Gm-Message-State: AC+VfDw0Er8WRcK4YscBgSsYikPGDGol0xbEV7c/Z6MfZyjxraIBecyz
        NGXbiOh3ESSkCwuRJ9VpGYHh0KeVQYRrMQ==
X-Google-Smtp-Source: ACHHUZ5OKpb2dZxlGGO4cejTpskTh0ytJ5c24s7e15fqb0+HaO+HQpt/I1bCSvOAP9iSyctvpi9geg==
X-Received: by 2002:aca:2105:0:b0:39a:618b:17e2 with SMTP id 5-20020aca2105000000b0039a618b17e2mr946722oiz.21.1685667205727;
        Thu, 01 Jun 2023 17:53:25 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id e19-20020a62ee13000000b0063b898b3502sm5609508pfi.153.2023.06.01.17.53.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2023 17:53:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230527122916.GAZHH3nHk7kkUA7CeM@nazgul.local>
Date:   Thu, 1 Jun 2023 17:53:13 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5C390E4-8CF7-49EE-A94C-205DB537E1AB@gmail.com>
References: <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
 <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
 <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
 <e6cd1909-2776-28d2-ccc0-4b3d2d09e9ce@intel.com>
 <49861038-B8CA-4CDD-BD44-73066FF453F3@gmail.com>
 <20230527072338.GAZHGv+no2LZASyLWM@nazgul.local>
 <9A302EB1-308A-4904-801C-DC70D9908E11@gmail.com>
 <20230527122916.GAZHH3nHk7kkUA7CeM@nazgul.local>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 27, 2023, at 5:29 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> As to what you want to address, I'll talk to toolchain folks first and
> get back to you.

I hope you got the answer you were looking for. I am not sure what is =
holding
this simple patch back.

To rehash - we are talking about local two symbols that are not exposed. =
Based
on my search they cover the only region of the kernel text (on x86) that =
is
not covered by any symbol.

Doing so have two types of impacts. Some tools are affected by the fact =
the
closest previous symbol is not related, and as a result the symbol they =
show
when they unwind the stack is unrelated. So instead of seeing
=E2=80=9Cbad_get_user_clac=E2=80=9D, you may see __get_user_nocheck_8 . =
This is confusing and
 misleading users.

This should impact perf, ftrace, /proc/[pid]/stack, dump_stack(), BUG().=20=


The second type of impact occurs since certain code addresses is not =
covered
by any symbol. This mostly results in reduced functionality of tools.

This includes for instance gdb that cannot =E2=80=9Cdisas=E2=80=9D =
addresses in
bad_get_user_clac (you can x/i for reduced functionality) or crash in
which =E2=80=9Cdis=E2=80=9D only disassembles a single instruction. It =
might also have impact
on backtraces - I did not try it.

addr2line and llvm-symbolizer also seem to be affected in such a way and =
they
do not find the symbol that is associated with addresses in
bad_get_user_clac. This means that tools that rely such tools, including
decode_stacktrace.sh are also affected. [*]

There might be other impacts, for instance on kpatch.

Overall, as a general rule, I think it would be best not to have code =
that is
not covered by any symbol. It can result in misleading output from the =
kernel
or related tools, and in addition in more limited functionality from =
tools
such as gdb and crash.

More concretely, I think these two symbols should not be stripped. The =
fact
that the code of these symbols runs under relatively complicated =
conditions
(exception tables), makes it even more important to let debug/tracing =
tools
to see them.
=20
I you wish, I can include the gist of these points in the commit log, =
although
I think it might be an overkill.



[*] It is worth noting that tools such as addrline and llvm-symbolizer
    are able to use DWARF to find the source code location, yet they
    do not appear to be able to find the relevant symbol.

