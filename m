Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361172AFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 01:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjFJX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 19:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFJX2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 19:28:49 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A57C35BB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686439723;
        bh=Fn02ERRTdshIy31ivri71MFDl08htZpi5ZW/1B1Yklk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RoTQNaPnb3BqEhoxdgH5HaBTxxioANrHFnLd1LukIgrwv45hFloQWpxCw3Ucl5rFO
         p01sv1k5JffRzrO7Ap0d6Md6efwMx2CVKruiBnk+d6JpC7Eqb2apy7nuWF0BBC5puP
         ExC7dz8jMm4AVaRDu8/FbF1jxcImz719BYrXABwE=
Received: from localhost ([101.224.149.128])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 6C88D4B4; Sun, 11 Jun 2023 07:27:08 +0800
X-QQ-mid: xmsmtpt1686439628t5vxva631
Message-ID: <tencent_06282B9141D32F1D19BE2BB41998E1612607@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie/ax1XRHrhBLZq6mCcLiuvDNt/91BzhUp23FvjncXJ7GelEe3vM
         9OAGxznL5b2IhQ28j88ewmLPJ3lH3nD/j6FA1YP8aNEjbE0aYxSc602m22PyY5pTGqT17iolSgf+
         IrqCx4Zi6HmEqVVPMapH0ioVbBJwLiiwVtiv5H4KOxgvH9AM5zb3nR1cHmfn6M7MGjdcodXvggSz
         gOjRh1qmAXSZDviwLVUP7imhArz3DWJUVDrWFhWbF+muhLKzneucXXx3jmvC+LdPUGC+/D7ZQFLV
         AUVbzoLaYy95K8y6wrJskoGPruHFjkqe1fSbBH8CDuWjX51RTYucuPkzaVfROFsRQCvO/D2Pb/eO
         VcNyBBElLm0cC1ia5z0ACkysYN19UqskQ+teQRpSx5TNwnzHrL6+x65ek6j8UkUVCb0OIecbF6+L
         l80g9Ylm7c6aHQXv0CozzrpJO+Aq7c+NX2lk8poCTzy9y5wVK1rOdRD6OifEVsnwW9h7EB8zVhqQ
         MJ5kl8gAc2Dk2Akm6Q24MkToF7FIHSj4THhg+9n7/rTP0S/6qYIdOhOeXpNMsMCML5KBek7UUgqf
         MgeqEeZUFkn2KXLQIkRN000bluhWfugfnziETRgnca2fD9O9PUaKISZWsaaImOB+7gOFwB4k9wPH
         vmkVNNqTv8Y/KuQFQ6GVcYfYo6Di1bgQyfcQHkafGqtpLCMdma4eNTld0bQNX4vZdewtXL/m08YS
         QAL0l1gmXF593b5xMriqDT8t/E4BthO2/HrhseEZnzScWyB9QH2hCX6H83R9JHHVE8NbZEjZN9ZD
         7waUowtBucgKsyWtuM1ioqh07sAjQFSL2fOVfHnjYtAm/6kNluWJnUTJJX4HiJbNA/sxL7CSQyoU
         pSpN3w7dotYXlUfdHAGFxZxD+yYRxxgPrV8JbvH2lZMhCqNrRORrG2WiqCNf+HWdVi7inHuS8HYa
         d6MNI1w9TXpiNO/8u6eA==
Date:   Sun, 11 Jun 2023 07:27:08 +0800
From:   Woody Zhang <woodylab@foxmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: reserve DTB before possible memblock allocation
X-OQ-MSGID: <ZIUGzGfoEivEICkQ@dev>
References: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
 <20230607-jogging-grudging-70dede86bc53@spud>
 <CAHVXubggydGfNu3OzcxWXREJbB+G9dmr9sFD7vXhVxbG-N58Pg@mail.gmail.com>
 <20230610-ability-mockup-f6aa71bad6a1@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230610-ability-mockup-f6aa71bad6a1@spud>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 04:41:17PM +0100, Conor Dooley wrote:
>On Thu, Jun 08, 2023 at 09:49:44AM +0200, Alexandre Ghiti wrote:
>> On Wed, Jun 7, 2023 at 8:17 PM Conor Dooley <conor@kernel.org> wrote:
>> >
>> > +CC Alex, you should take a look at this patch.
>> >
>> > On Wed, Jun 07, 2023 at 09:35:19PM +0800, Woody Zhang wrote:
>> > > It's possible that early_init_fdt_scan_reserved_mem() allocates memory
>> > > from memblock for dynamic reserved memory in `/reserved-memory` node.
>> > > Any fixed reservation must be done before that to avoid potential
>> > > conflicts.
>> > >
>> > > Reserve the DTB in memblock just after early scanning it.
>> >
>> > The rationale makes sense to me, I am just wondering what compelling
>> > reason there is to move it away from the memblock_reserve()s for the
>> > initd and vmlinux? Moving it above early_init_fdt_scan_reserved_mem()
>> > should be the sufficient minimum & would keep things together.
>
>> Thanks Conor.
>> 
>> So the patch looks good to me.
>> 
>> But I find this fragile:
>> 
>> - we do not check memblock_reserve() return value to make sure the
>> reservation really happened (and quickly looking at the code, I'm not
>> even sure it returns an error if the region was already allocated).
>> - we have to make sure no memblock allocation happens before setup_bootmem().
>> - we also have to check that no fixed memblock_reserve() happens after.
>> 
>> The last 2 points may sound natural, but we'll have to take great care
>> when adding some code around here. I'm working on an "early boot
>> document" and I'll add something about that, but a runtime thing would
>> be way better IMO.
>> 
>> You can add:
>> 
>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
>btw Alex/Woody, what is the appropriate Fixes tag here?

In ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap region"),
Alex move early_init_fdt_scan_reserved_mem to setup_bootmem() to prevent
memory allocations before of reservations. But it should not be put before
DTB reservation.


Woody

