Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BEA6D4382
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjDCL3a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjDCL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:29:29 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB023C00;
        Mon,  3 Apr 2023 04:29:27 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17e140619fdso30358599fac.11;
        Mon, 03 Apr 2023 04:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4vs4Q7IOsuBvb2xA6jfcMJFNzPk+3jZ8pvqIxT/IUE=;
        b=Hxtyo7hNfuwCpUiLZMJikfIXIFCgU5GrSBZ/2Ch/at+XYKq3HLdavGULVH5Xd1YxNJ
         Oo6PuTKHTzQ829LLFM0VSaKckmpxeCfgW22T3zidTDc1CJpFY1CS6C+BBoN9dkcDOnMY
         eqzHr37Qte5W7RMKj8RyDBbU77j4y+do2rFkOWvTdxXAW0NCUhKCDTf8oAN/V8oDjXjN
         jLE9HLDYKRruj2/5sCLOCXRKA077ieOjLLy8ZssqYnffHMwagUF/BHWeeUjfX1qjRErA
         cSIEva5NkexAHtiID/0HKELML/JJSdOEY5byCNlTltf1V67AivD5hFYYMgUjT6OUxr4c
         hiTg==
X-Gm-Message-State: AAQBX9fe9VaZIKas6Qj9HRi9iZvYPYBNRMA06PCooitYssO7CnM6/THF
        f4ZiBA2NWZNQn9Ine99XCjnnRU/C5He6Hg==
X-Google-Smtp-Source: AKy350aWAa24JPlUR4+1x1DG7QXcctZ9w0bFfO71fYG3X8PfHXpiS7psHbEEjdO9p34DrmTA0Ap10A==
X-Received: by 2002:a05:6870:2181:b0:177:9a21:19f8 with SMTP id l1-20020a056870218100b001779a2119f8mr8732843oae.6.1680521367053;
        Mon, 03 Apr 2023 04:29:27 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com. [209.85.160.41])
        by smtp.gmail.com with ESMTPSA id vj12-20020a0568710e0c00b001762ce27f9asm3413452oab.23.2023.04.03.04.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 04:29:26 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso30389684fac.4;
        Mon, 03 Apr 2023 04:29:25 -0700 (PDT)
X-Received: by 2002:a05:687c:198:b0:17e:3201:41b0 with SMTP id
 yo24-20020a05687c019800b0017e320141b0mr11414592oab.5.1680521365606; Mon, 03
 Apr 2023 04:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
 <ZCl7NFN5igCkIaLz@debian.me>
In-Reply-To: <ZCl7NFN5igCkIaLz@debian.me>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Mon, 3 Apr 2023 12:29:14 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2fqAzURWrXWKnsMH6wEE8w2o=YSk62gNmDZFcr1Yit3g@mail.gmail.com>
Message-ID: <CAJX_Q+2fqAzURWrXWKnsMH6wEE8w2o=YSk62gNmDZFcr1Yit3g@mail.gmail.com>
Subject: Re: Kernel Panic - V6.2 - Reseved memory issue
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 2, 2023 at 1:55 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Sun, Apr 02, 2023 at 09:10:36AM +0100, Lucas Tanure wrote:
> > Log:
> >
> > [ 9.792966] SError Interrupt on CPU3, code 0x00000000bf000000 -- SError
> > [ 9.792980] CPU: 3 PID: 3471 Comm: kded5 Tainted: G C 6.2.0 #1
> > [ 9.792985] Hardware name: Khadas VIM3 (DT)
> > [ 9.792987] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [ 9.792991] pc : kmem_cache_free_bulk.part.98+0x1f0/0x528
> > [ 9.793004] lr : kmem_cache_free_bulk.part.98+0x2f8/0x528
> > [ 9.793008] sp : ffff80000a2eb7f0
> > [ 9.793009] x29: ffff80000a2eb7f0 x28: ffff00001f358518 x27: ffff000000008800
> > [ 9.793016] x26: ffff00000262b300 x25: ffff00000262b300 x24: 0000000000000001
> > [ 9.793019] x23: ffff00000262b000 x22: 0000000000000000 x21: ffff00001f358538
> > [ 9.793022] x20: fffffc0000098ac0 x19: 0000000000000004 x18: 0000000000000040
> > [ 9.793025] x17: 0000000000000018 x16: 00000000000007f8 x15: 0000000000000003
> > [ 9.793028] x14: 0000000000000006 x13: ffff800008e48550 x12: 0000ffff9dc91fff
> > [ 9.793031] x11: 0000000000000004 x10: 0000000000000001 x9 : ffff000007e93680
> > [ 9.793035] x8 : 0000000000000020 x7 : ffff000001d2b100 x6 : 0000000000000007
> > [ 9.793037] x5 : 0000000000000020 x4 : ffff000000008800 x3 : 0000000000000001
> > [ 9.793040] x2 : 0000000000000007 x1 : 0000000000000000 x0 : ffff00001f358540
> > [ 9.793045] Kernel panic - not syncing: Asynchronous SError Interrupt
> >
> > This doesn't happen with downstream Khadas 6.2 kernel, and that's
> > because the downstream kernel removed this from
> > early_init_dt_reserve_memory (drivers/of/fdt.c):
> >
> > /*
> > * If the memory is already reserved (by another region), we
> > * should not allow it to be marked nomap, but don't worry
> > * if the region isn't memory as it won't be mapped.
> > */
> > if (memblock_overlaps_region(&memblock.memory, base, size) &&
> >     memblock_is_region_reserved(base, size))
> >           return -EBUSY;
> >
>
> What commit on downstream kernel that fix the issue?
Here:
https://github.com/khadas/linux/commit/2cb57b1071bf69f615fedc999b7ecacf2cde7228

 Can you reproduce
> on mainline with above conditional removed?
No, without that code mainline works fine.


Alternatively, can
> you post the downstream fix here?
Same https://github.com/khadas/linux/commit/2cb57b1071bf69f615fedc999b7ecacf2cde7228

>
> Also, can you find last working commit on mainline? If so, this is
> regression.
That is difficult as 5.13.0 has the line:
OF: fdt: Reserved memory: failed to reserve memory for node
'secmon@5000000': base 0x0000000005000000, size 3 MiB
But doesn't crash. It could be that no process used that address so no crash.

>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
