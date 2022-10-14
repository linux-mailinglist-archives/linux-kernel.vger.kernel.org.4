Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2648E5FE7C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJNDxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJNDw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:52:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3FB96202
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:52:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so3710701pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUyZ/n0F/EX7RUgST5DLtrH69Ec2HkwsjiWEkzoNdWU=;
        b=WQu+BmCi7I71B4fYLIFAOSb91HEFIuaX4k9Swwj1OBFWL4SNb9fTEPEOtxaC7B+DoL
         puvZWwJgw3CSbFrZ30vZzdGmM0SLydH6PJGPI/xGy2KoYNXJTwGYPvpW+34fVxs+CpuL
         x9cwxJzcBKW5xCZmFZn7SQt4uAObZeM2pEJT0NW7UARUPLc4t/5SRcdJqPxD5hspuVro
         3JqL+4KqZQuM+R6I3qNVFnDarKqkRh4vLexK55/lsUHfrJSsPx4z+hQeLFRg3nsF8k2C
         Vi3yZiHkJZ0a93i1BZ3EzAx1RWSOG3nzWw0JBqYt/LBUh8Kqnm/heoIXtxt0BMLHppxF
         +7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUyZ/n0F/EX7RUgST5DLtrH69Ec2HkwsjiWEkzoNdWU=;
        b=H9GT1Tu+0OoPjZerNZdBYEU7l+aRj6U7WztQljGaEWuw/qoMf6wq77HkAT7BYROMw0
         AdVBjJZ/2oFMFI7zUQZudiDLImzNEFvwSNDqLYsps4NrvhUPiaZ4lkeJD02YXItQZIZh
         ssmeptwUarJ64CuVMVK7XprlOyYRZ/vmXEN0ZzEK/sNga4ac4i8NaF5xuxgK35CAUY4B
         C91aD42ovV/+WPqvd3/8tGz4IFHkmGphcldccUvaj/AU0+Essb5RKXj36GOY+gAZ8OJP
         oDNN2JUTTumi61mXq/MHdwJLSDuODfM7bEX8wXeLOzAUtku4sqk1l5ZW2A5jCchIeElY
         x/Pw==
X-Gm-Message-State: ACrzQf2jbdL2J1PMFyPmpPj+99kEEh5QBGtrSl1DnE941CNoWCeCfbL9
        TmpNvIusJ4sXnt1GUlArtPJMWLIM+x8OfHtN
X-Google-Smtp-Source: AMsMyM6GBkaPLx8Gl7Z0ibncFhM0FbtDAQXtOxa8ew2pmnkS012aVIjP/GoSbF4Pee3uzMZpDFBN/g==
X-Received: by 2002:a17:90b:1bc9:b0:20d:75b8:ee5d with SMTP id oa9-20020a17090b1bc900b0020d75b8ee5dmr3478973pjb.147.1665719577003;
        Thu, 13 Oct 2022 20:52:57 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b0043b565cb57csm456796pga.73.2022.10.13.20.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:52:56 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:52:56 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 20:53:06 PDT (-0700)
Subject:     Re: [PATCH] get_maintainer: Add the --for-tree argument
In-Reply-To: <3251b73cce77964413e01d4f5361de48942e98ae.camel@perches.com>
CC:     linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     joe@perches.com
Message-ID: <mhng-fd2a2d7b-94e9-41c5-9219-9184731e6845@palmer-ri-x1c9a>
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

On Thu, 13 Oct 2022 20:48:10 PDT (-0700), joe@perches.com wrote:
> On Thu, 2022-10-13 at 19:56 -0700, Palmer Dabbelt wrote:
>> On Thu, 13 Oct 2022 17:39:53 PDT (-0700), joe@perches.com wrote:
>> > On Thu, 2022-10-13 at 14:57 -0700, Palmer Dabbelt wrote:
>> > > I recently wanted to look up the maintainers for each tree path via a
>> > > script, and I couldn't find a better way to do that than poking
>> > > get_maintainer.pl to add a new argument.  This lets folks run something
>> > > like
>> > > 
>> > >     $ ./scripts/get_maintainer.pl --for-tree git://github.com/kvm-riscv/linux.git
>> > >     Anup Patel <anup@brainfault.org> (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
>> > >     kvm@vger.kernel.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
>> > >     kvm-riscv@lists.infradead.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
>> > >     linux-riscv@lists.infradead.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
>> > > 
>> > > to find out who owns a tree.
>> > 
>> > I'm not sure this is useful.
> []
>> Generally sound like you 
>> don't want this one so I'm going to punt on fixing these for now, I 
>> don't care all that much about having this merged.
>> 
>> LMK if you want a v2, though.
>
> I think it's not necessary.

Works for me.
