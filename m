Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8C72FEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244693AbjFNMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbjFNMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:45:40 -0400
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07286198
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686746733;
        bh=W9K2TxMhc8/BCOfweWhHmxvkNzTtaiHhyGiv6S2JZdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MHFjK+qugkuo8rRX/SIGUer8gaPz9NDlyanKFlnRM4z8ZA+mJvwv3j02TzjzKOqvE
         pkn55oVdNGcgD9FZ6wHFWVQ6r6b/mq16NimINoAThpeFTzl7+BBvPFU7ehJ4P1Aq0T
         TKoIwl1gmv3kvnQGW0k7CdyhiMdh26OpKRKzP+So=
Received: from localhost ([101.224.149.128])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id A70A7608; Wed, 14 Jun 2023 20:41:48 +0800
X-QQ-mid: xmsmtpt1686746508taw99y47e
Message-ID: <tencent_C1CE680F8B300559050D967C7DC8305CA90A@qq.com>
X-QQ-XMAILINFO: ONeAaaONYXuw+NsuqA0HVM0JtE6Xfpe7VSuvouDHpiQ9EP60FsSsp2ZVsfbc9Y
         ezlnQyGT4svrR4QrXHQjXRLaJoJEQGbbrVO22MxSQFNM6vIBvxHV59zZpJG37v8OKyrbgR32XtLu
         U+QeDI3js9uYwtOJiijFjcBJEJetXW/tfjaZJsIirkqvinrYyfn8UJhq1/jXgeBI69gD1NaFIeYl
         ZkKNStGbjLV/JobHpnIp0/rOcahI162KwO/8DTXaDm3iinug5CnjyB+HuzOPRVuKs5DydCcSfoa5
         Mz3jKDZggEH5VK7ToMT0VptYc21BACpRTh51phb3WmBl4A6WF5k6fT6qe5V/1opN4XcqUwLr8IPp
         PHyUYPgMk/veLO/JMCJXm8iperT0OA/faRjmBV246B0O3OzmVxzOqTOGVTnv4u0UusD2Lvz6/rRX
         G+rUSsSX0C+BJqTEWxAwx7iDl6RRyOKihovyRLDb3aw/NdCFDDvJGlHHnJ9a9v0w960ZcdYMst0N
         mnSkwVnDHdL076kjImSFlNoykqj0mnBjb6jPKwJXmKTRb0gvbiKs5bW3mIyNFII3K3W3LWxhfs4g
         3oJFIz8TEMTE5LDOSJQV4bUXjVoWj+CL84AQLQw6TU8JclLD2e5Xl6sVuttknPEGTmUE2vnsziTf
         JsoTztbSLMsQAFL0CuUcEKEC1huLK+3BTvVlfMLEh+Z1SzfHDmReZWjPOOL0fBQ+VgaiulJm5ioK
         sIlEUEvuMktPcEFKjYR9idkCANV4tfqP8HnJWVR6DdDwTLjOVhglaxW+86bVZ/yCfpz0Kyz9IHYD
         KECNch+bKbh9DhVssouN6vb5+G9+piwfbAYqXC5KYRpHFajq+juult/yhbRR/b7GYcg5QcsILTyN
         HHBYW6Pa9xdai4Ydfqx41Ink+E+nn8yvySMK65NtyPKCpz72beEqZeZcIypYIVLd2FEo82RZHlg+
         2/xtc08Rtaf7g1kDynYNcIPnXe2t6V
X-QQ-XMAILREADINFO: M6MeDH90Kfa7jdireGRnptI=
Date:   Wed, 14 Jun 2023 20:41:48 +0800
From:   Woody Zhang <woodylab@foxmail.com>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move memblock_allow_resize() after lm is ready
X-OQ-MSGID: <ZIm1jOGyx0Ucvbx7@dev>
References: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
 <CAHVXubiYHQCYkymde2y_okNb2XcE-xVBMj8iZ7kM5d08bhqxiQ@mail.gmail.com>
 <6B512C74DCAB0BF0+0ad9a892-6933-baa3-0848-1e1efc685c9f@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6B512C74DCAB0BF0+0ad9a892-6933-baa3-0848-1e1efc685c9f@tinylab.org>
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

On Wed, Jun 14, 2023 at 05:51:23PM +0800, Song Shuai wrote:
>
>
>在 2023/6/12 15:15, Alexandre Ghiti 写道:
>> Hi Woody,
>> 
>> On Sat, Jun 10, 2023 at 1:49 AM Woody Zhang <woodylab@foxmail.com> wrote:
>> > 
>> > The initial memblock metadata is accessed from kernel image mapping. The
>> > regions arrays need to "reallocated" from memblock and accessed through
>> > linear mapping to cover more memblock regions. So the resizing should
>> > not be allowed until linear mapping is ready. Note that there are
>> > memblock allocations when building linear mapping.
>> > 
>> > Signed-off-by: Woody Zhang <woodylab@foxmail.com>
>> > ---
>> >   arch/riscv/mm/init.c | 4 +++-
>> >   1 file changed, 3 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> > index 9e9da69720ce..8a33ecbb4d0f 100644
>> > --- a/arch/riscv/mm/init.c
>> > +++ b/arch/riscv/mm/init.c
>> > @@ -258,7 +258,6 @@ static void __init setup_bootmem(void)
>> >          dma_contiguous_reserve(dma32_phys_limit);
>> >          if (IS_ENABLED(CONFIG_64BIT))
>> >                  hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>> > -       memblock_allow_resize();
>> >   }
>> > 
>> >   #ifdef CONFIG_MMU
>> > @@ -1250,6 +1249,9 @@ static void __init setup_vm_final(void)
>> >          csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_mode);
>> >          local_flush_tlb_all();
>> > 
>> > +       /* Depend on that Linear Mapping is ready */
>> > +       memblock_allow_resize();
>> > +
>> >          pt_ops_set_late();
>> >   }
>> >   #else
>> > --
>> > 2.39.2
>> > 
>> 
>> The commit log does not describe the issue thoroughly enough to me,
>> maybe you could point to the arm64 commit that did the same? I mean
>> commit 24cc61d8cb5a ("arm64: memblock: don't permit memblock resizing
>> until linear mapping is up").
>@Alex
>
>I reproduced the problem as the arm64 commit describes.
>You can find the complete log via this link: https://termbin.com/bx0o
>
>I constructed the dtb with numerous discrete /memreserve/ regions
>(the numbers of these regions approximate INIT_MEMBLOCK_REGIONS) which full
>the reserved regions up.
>
>When memblock_allow_resize was set, the calling of memblock_reserve() would
>double/resize the reserved regions and do the __memcopy() from the old
>regions ( mapped by kernel)
>to the new ones (provided by __va()).
>But before the linear mapping was ready (like: during the creating of linear
>mapping),
>memblock_reserve() was called and the memcopy would trigger a Store/AMO page
>fault.
>
>> 
>> Another point is that I would not put this call into setup_vm_final(),
>> I'd rather add it in paging_init() as it does not seem like a good fit
>> for setup_vm_final(). But that's a nit so up to you of course.
>> 
>I agree.
>
>@Woody
>
>I noticed your V2 [1] didn't take this suggestion, maybe you can take it at
>V3.
>And it will be more sound if you supplement the commit-msg with the panic
>info from the log.
>

Thanks for your comments. I will update it with your panic log in next
version.


Woody

