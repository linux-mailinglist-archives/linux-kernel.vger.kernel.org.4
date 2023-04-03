Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E006D4BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjDCP3C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 11:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjDCP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:28:59 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95AE1BFE;
        Mon,  3 Apr 2023 08:28:58 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id b19so21999377oib.7;
        Mon, 03 Apr 2023 08:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680535738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfXSjA7q7dvjRoKzxnHZQeB6zpJL1qkef91cGmYxqmc=;
        b=f1UaoKIKwcBv6AwsvlXnAGNxT3frMblLoQQk5EF3GvUod3VB/kt/2EdtPDN4aZVb1d
         3uccwbc0rlmwbQ4IVCFoqIGIu4UtuwDlq3oMi1QSULtjbXikLr+MztcgtL3GIpeOtdow
         PTD67N5YA0wk/pTefrNiWzL3+EOOZdWpIGNIpo72z20iKzxuArPoJfXUJ89t38kKXcJM
         aFY5baIIeBMMH+qUEr3tj4qRjYTdpDZlfJB74s4Ur4z8igCMNyDyz6CvFGv3kyPPJO0n
         tibxX0kJYIlLCEHTvJU49pHvZ/UO2GnUMAm8WpiFDd/ROgCHDeYGda4pC/OThNxKuSr/
         nhsw==
X-Gm-Message-State: AAQBX9fBAet4hiVSsWs4EANmc1BE9yKZkVdE40dACErwW01BdbjTqULd
        EaNt7RlGMAgrlYfkS+WAcVu/11QyqyJ9JWzh
X-Google-Smtp-Source: AKy350aFcm37uD3w61HtiCbn+3VdoSRvi6NEHRdGmLV8j5g3bjiKj+o5mn3qKDhLlKXGmE/YEIcePw==
X-Received: by 2002:a05:6808:3941:b0:389:5135:68d8 with SMTP id en1-20020a056808394100b00389513568d8mr10394004oib.5.1680535737811;
        Mon, 03 Apr 2023 08:28:57 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id o184-20020acabec1000000b003646062e83bsm3961970oif.29.2023.04.03.08.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:28:54 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso15812590oti.8;
        Mon, 03 Apr 2023 08:28:53 -0700 (PDT)
X-Received: by 2002:a9d:65d1:0:b0:69f:1418:7a8f with SMTP id
 z17-20020a9d65d1000000b0069f14187a8fmr11995072oth.3.1680535733526; Mon, 03
 Apr 2023 08:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
 <ZCl7NFN5igCkIaLz@debian.me> <CAJX_Q+2fqAzURWrXWKnsMH6wEE8w2o=YSk62gNmDZFcr1Yit3g@mail.gmail.com>
In-Reply-To: <CAJX_Q+2fqAzURWrXWKnsMH6wEE8w2o=YSk62gNmDZFcr1Yit3g@mail.gmail.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Mon, 3 Apr 2023 16:28:42 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2uSBaudKrA6hcRhGP-7j__V5bTpRwGPLUoBaMjuwO+CQ@mail.gmail.com>
Message-ID: <CAJX_Q+2uSBaudKrA6hcRhGP-7j__V5bTpRwGPLUoBaMjuwO+CQ@mail.gmail.com>
Subject: Re: Kernel Panic - V6.2 - Reseved memory issue
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 12:29 PM Lucas Tanure <tanure@linux.com> wrote:
>
> On Sun, Apr 2, 2023 at 1:55 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On Sun, Apr 02, 2023 at 09:10:36AM +0100, Lucas Tanure wrote:
> > > Log:
> > >
> > > [ 9.792966] SError Interrupt on CPU3, code 0x00000000bf000000 -- SError
> > > [ 9.792980] CPU: 3 PID: 3471 Comm: kded5 Tainted: G C 6.2.0 #1
> > > [ 9.792985] Hardware name: Khadas VIM3 (DT)
> > > [ 9.792987] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [ 9.792991] pc : kmem_cache_free_bulk.part.98+0x1f0/0x528
> > > [ 9.793004] lr : kmem_cache_free_bulk.part.98+0x2f8/0x528
> > > [ 9.793008] sp : ffff80000a2eb7f0
> > > [ 9.793009] x29: ffff80000a2eb7f0 x28: ffff00001f358518 x27: ffff000000008800
> > > [ 9.793016] x26: ffff00000262b300 x25: ffff00000262b300 x24: 0000000000000001
> > > [ 9.793019] x23: ffff00000262b000 x22: 0000000000000000 x21: ffff00001f358538
> > > [ 9.793022] x20: fffffc0000098ac0 x19: 0000000000000004 x18: 0000000000000040
> > > [ 9.793025] x17: 0000000000000018 x16: 00000000000007f8 x15: 0000000000000003
> > > [ 9.793028] x14: 0000000000000006 x13: ffff800008e48550 x12: 0000ffff9dc91fff
> > > [ 9.793031] x11: 0000000000000004 x10: 0000000000000001 x9 : ffff000007e93680
> > > [ 9.793035] x8 : 0000000000000020 x7 : ffff000001d2b100 x6 : 0000000000000007
> > > [ 9.793037] x5 : 0000000000000020 x4 : ffff000000008800 x3 : 0000000000000001
> > > [ 9.793040] x2 : 0000000000000007 x1 : 0000000000000000 x0 : ffff00001f358540
> > > [ 9.793045] Kernel panic - not syncing: Asynchronous SError Interrupt
> > >
> > > This doesn't happen with downstream Khadas 6.2 kernel, and that's
> > > because the downstream kernel removed this from
> > > early_init_dt_reserve_memory (drivers/of/fdt.c):
> > >
> > > /*
> > > * If the memory is already reserved (by another region), we
> > > * should not allow it to be marked nomap, but don't worry
> > > * if the region isn't memory as it won't be mapped.
> > > */
> > > if (memblock_overlaps_region(&memblock.memory, base, size) &&
> > >     memblock_is_region_reserved(base, size))
> > >           return -EBUSY;
> > >
> >
> > What commit on downstream kernel that fix the issue?
> Here:
> https://github.com/khadas/linux/commit/2cb57b1071bf69f615fedc999b7ecacf2cde7228
>
>  Can you reproduce
> > on mainline with above conditional removed?
> No, without that code mainline works fine.
>
>
> Alternatively, can
> > you post the downstream fix here?
> Same https://github.com/khadas/linux/commit/2cb57b1071bf69f615fedc999b7ecacf2cde7228
>
> >
> > Also, can you find last working commit on mainline? If so, this is
> > regression.
> That is difficult as 5.13.0 has the line:
> OF: fdt: Reserved memory: failed to reserve memory for node
> 'secmon@5000000': base 0x0000000005000000, size 3 MiB
> But doesn't crash. It could be that no process used that address so no crash.
>
> >
> > Thanks.
> >
> > --
> > An old man doll... just what I always wanted! - Clara

Hi,
I git bisect point it out commit that even reverting it would trigger the panic.
So this is a memory corruption problem that a simple git bisect will
not find the correct offending commit.

I managed to understand a little more about the issue:
1 ) early_init_fdt_scan_reserved_mem is executed first, reserves
[0x0000000005000000-0x00000000052fffff] but doesn't mark as no-map.
2 ) early_init_dt_reserve_memory tries to mark that region as nomap,
but it is already reserved and memblock_overlaps_region and
memblock_is_region_reserved return true, so it fails to mark as nomap.
3 ) kernel uses that memory and crashes

I think we have two options here:
1) Allow early_init_dt_reserve_memory mark nomap memory that is already reserved
2) Make early_init_fdt_scan_reserved_mem reserve with the flag nomap
if necessary. I don't know if that's possible.

Question MM guys, Mike Rapoport and Andrew Morton:
- Is it possible to make early_init_fdt_scan_reserved_mem reserve
memory with flags?
- It ok for early_init_fdt_scan_reserved_mem to mark regions already
reserved as nomap?

Thanks
Lucas
