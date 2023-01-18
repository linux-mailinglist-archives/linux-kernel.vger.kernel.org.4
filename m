Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ABB671EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjAROCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjAROBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:01:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE888B332
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:35:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 581313EB51;
        Wed, 18 Jan 2023 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674048918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KBGA0fHKIIYZT5fSoaJ6tT5T/t7L+6nuwsMbS4FGYwE=;
        b=RCDsLYFvYwJongnwyfSAX5NBrcuGjkTQutPICwbjdWQJusZz4SHr4ZMTJnlCHBEbuSt9z+
        cMsMs0bCkUb3X1MxEbu3q5h99VDTUE8vA022qKsZNoJR6/Igr1lPcmErF4B06jSTFFA4Dl
        94SLDFu97vrFCwyAvx6qB1/dWxIK5qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674048918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KBGA0fHKIIYZT5fSoaJ6tT5T/t7L+6nuwsMbS4FGYwE=;
        b=g+HuLDZHBUZAIcP5Ld6gw8mrsEIl29Re4oZORaGVaGehlX33EXdsIkFnOa2K10yzFKjarT
        y9aKAaHkTrR68aAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0625F139D2;
        Wed, 18 Jan 2023 13:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O0/aAJb1x2OgQwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 18 Jan 2023 13:35:18 +0000
Content-Type: multipart/mixed; boundary="------------8Cla80fHKfVBjkCzfkPzSfej"
Message-ID: <2b857e20-5e3a-13ec-a0b0-1f69d2d047a5@suse.cz>
Date:   Wed, 18 Jan 2023 14:35:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linus:master] [hugetlb] 7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>
Cc:     "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, hongjiu.lu@intel.com
References: <202301170941.49728982-oliver.sang@intel.com>
 <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz> <Y8ZVxJSZdtEk8Nco@feng-clx>
 <Y8aSc5xGO+rW2pyo@feng-clx>
 <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8Cla80fHKfVBjkCzfkPzSfej
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/23 19:25, Linus Torvalds wrote:
> On Tue, Jan 17, 2023 at 4:22 AM Feng Tang <feng.tang@intel.com> wrote:
>>
>> With the following patch to use 'O1' instead 'O2' gcc optoin for
>> page_alloc.c, the list corruption issue can't be reproduced for
>> commit 7118fc2906 in 1000 runs.
> 
> Ugh.
> 
> It would be lovely if you could just narrow it down with
> 
>   #pragma GCC optimize ("O1")
>  ...
>   #pragma GCC optimize ("O2")
> 
> around just that prep_compound_page(), but when I tried it myself I
> get some function attribute mismatch errors.
> 
> 
>> As is can't be reproduced with X86_64 build, it could be i386
>> compiling related.
> 
> Your particular config causes a huge amount of nasty 64-bit arithmetic
> according to the objdump code, with sequences like
> 
>   c13b3cbb:       83 05 d0 28 6c c5 01    addl   $0x1,0xc56c28d0
>   c13b3cc2:       83 15 d4 28 6c c5 00    adcl   $0x0,0xc56c28d4
> 
> which seems to be just from some coverage profiling being on
> (CONFIG_GCOV?), or something. It makes it very hard to read the code.

I think whatever this is, it's also responsible for the bug.
Now from all the dumps I've seen so far, the struct page corruptions looked
like prep_compound_page() is called more times than it should. Which didn't
make sense as the code is very simple, a loop of 1 << order - 1 iterations.

If I look at Feng's disassembly of 48b8d744ea84 (the "good" parent commit),
I can work out that edi holds the 1 << order, ebx is initialized as 1, and
there's a nice clear "inc ebx, cmp ebx, edi, jne <loop>".

Now the disassembly of the "bad" commit is much harder to follow when it
comes to the iteration control. There are xors and or's involved so I didn't
even try to work out the meaning. Clearly it can't be deterministically
wrong or it would crash always and fast. But crucially I think it uses
memory addresses 0xc56c28f8 and 0xc56c28fc in a racy way and that could
explain the bug.

Before the loop iteration itself, it initializes several registers from
these addreses, and the values end up modifying also registers used for the
loop iteration control (ebx/esi) And crucially in the loop iteration it also
writes some values to the same addresses, and there seems to be no
synchronization whatsoever. So it seems to me, even if these addresses are
supposed to be "private" to prep_compound_page(), running two
prep_compound_page() in parallel, or even due to interrupt (Hyeonggon did
reproduce this with -smp 1 as well) can result in a race ultimately
affecting the number of iterations taken.

Attaching the disasm I annotated for more details. Everything register whose
value is coming from 0xc56c28f8/0xc56c28fc in some way is annotated as
"crap" there (sorry).

> You also have UBSAN enabled, which - again - makes for some really
> grotty asm that hides any actual logic.
> 
> Finally, your objdump version also does some horrendous decoding, like
> 
>   c13b3e29:       8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
> 
> which is just a 7-byte 'nop' instruction, but again, it makes it
> rather hard to actually read the code.
> 
> With the i386 defconfig, gcc generates a function that is just ~30
> instructions for me, so this makes a huge difference in the legibility
> of the code.
> 
> I wonder if you can recreate the issue with a much more
> straightforward config. By all means, leave DEBUG_PAGEALLOC and SLUB
> debugging on, but without the things like UBSAN and GCOV.
> 
>> I also objdumped 'prep_compound_page' for vmlinux of 7118fc2906 and
>> its parent commit 48b8d744ea84, which have big difference than the
>> simple 'set_page_count()' change, but I can't tell which part is
>> abnormal, so attach them for further check.
> 
> Yeah, I can't make heads or tails of them either, see above on how
> illegible the objdump files are. And that's despite not even having
> all of prep_compound_page() in them (it's missing
> prep_compound_page.cold, which is probably just UBSAN fixup code, but
> who knows..)
> 
> That said, with the i386 defconfig, the only change from adding
> set_page_count() to the loop seems to be exactly that:
> 
>  .L589:
> -       movl    $1024, 12(%eax)
> +       movl    $0, 28(%eax)
>         addl    $32, %eax
> +       movl    $1024, -20(%eax)
>         movl    %esi, -28(%eax)
>         movl    $0, -12(%eax)
>         cmpl    %edx, %eax
> 
> (don't ask me why gcc does *one* access using the pre-incremented
> pointer, and then the rest to the post-incremented ones, but whatever
> - it means that it's not just "add a mov $0", it's also changing how
> the
> 
>         p->mapping = TAIL_MAPPING;
> 
> instruction is done, which is that
> 
> -       movl    $1024, 12(%eax)
> +       movl    $1024, -20(%eax)
> 
> part of the change)
> 
>              Linus

--------------8Cla80fHKfVBjkCzfkPzSfej
Content-Type: text/plain; charset=UTF-8; name="objdump_annotated.txt"
Content-Disposition: attachment; filename="objdump_annotated.txt"
Content-Transfer-Encoding: base64

aW5wdXRzOgplYXg6IHBhZ2UKZWR4OiBvcmRlcgoKc3RhY2sgYmVsb3cgZWJwCi0weDA0IHNh
dmVkIGVkaQotMHgwOCBzYXZlZCBlc2kKLTB4MGMgc2F2ZWQgZWJwCihzdWIgICAgJDB4MTQs
JWVzcCkKLTB4MTAgIGNyYXAKLTB4MTQgIGNyYXAKLTB4MTggIHBhZ2V8MSAoY29tcG91bmRf
aGVhZCB2YWx1ZSkKLTB4MWMgIGNvcHkgb2Ygb3JkZXIKLTB4MjAgIHBhZ2UKLTB4MjQKZXNw
CgplYXggPSBwYWdlfDEgKGNvbXBvdW5kX2hlYWQgdmFsdWUpIC8gY3JhcAplZHggPSBwYWdl
IC8gY3JhcAplZGkgPSBwYWdlIC8gY3JhcAplYnggPSAxIDw8IG9yZGVyICg9MikgLyAxIDw8
IG9yZGVyIC0yICg9MCkgLyBjcmFwIQplY3ggPSBwYWdlICsgMSAoZmlyc3QgdGFpbCBwYWdl
KQplc2kgPSAwIC8gY3JhcAoKYzEzYjNiOTAgPHByZXBfY29tcG91bmRfcGFnZT46CmMxM2Iz
YjkwOgk1NSAgICAgICAgICAgICAgICAgICAJcHVzaCAgICVlYnAKYzEzYjNiOTE6CTg5IGU1
ICAgICAgICAgICAgICAgIAltb3YgICAgJWVzcCwlZWJwCmMxM2IzYjkzOgk1NyAgICAgICAg
ICAgICAgICAgICAJcHVzaCAgICVlZGkKYzEzYjNiOTQ6CTg5IGM3ICAgICAgICAgICAgICAg
IAltb3YgICAgJWVheCwlZWRpICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVkaSA9IHBh
Z2UKYzEzYjNiOTY6CTU2ICAgICAgICAgICAgICAgICAgIAlwdXNoICAgJWVzaQpjMTNiM2I5
NzoJNTMgICAgICAgICAgICAgICAgICAgCXB1c2ggICAlZWJ4CmMxM2IzYjk4Ogk4MyBlYyAx
NCAgICAgICAgICAgICAJc3ViICAgICQweDE0LCVlc3AKYzEzYjNiOWI6CTgzIGZhIDFmICAg
ICAgICAgICAgIAljbXAgICAgJDB4MWYsJWVkeCAgICAgICAgICAgICAgICAgICAgICAgICAg
IApjMTNiM2I5ZToJODkgNTUgZTQgICAgICAgICAgICAgCW1vdiAgICAlZWR4LC0weDFjKCVl
YnApICAgICAgICAgICAgICAgICAgICAKYzEzYjNiYTE6CTBmIDg3IDMzIDMxIGVkIDAxICAg
IAlqYSAgICAgYzMyODZjZGEgPHByZXBfY29tcG91bmRfcGFnZS5jb2xkPiAgIG9ubHkgd2hl
biBvcmRlciA+IDMxICg/KSAKYzEzYjNiYTc6CTBmIGI2IDRkIGU0ICAgICAgICAgIAltb3Z6
YmwgLTB4MWMoJWVicCksJWVjeCAgICAgICAgICAgICAgICAgICAgIGVjeCA9IG9yZGVyCmMx
M2IzYmFiOgliYiAwMSAwMCAwMCAwMCAgICAgICAJbW92ICAgICQweDEsJWVieCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBlYnggPSAxCmMxM2IzYmIwOglkMyBlMyAgICAgICAgICAg
ICAgICAJc2hsICAgICVjbCwlZWJ4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlYngg
PSAxIDw8IG9yZGVyICAoPTIpCmMxM2IzYmIyOgk4MyAzZiBmZiAgICAgICAgICAgICAJY21w
bCAgICQweGZmZmZmZmZmLCglZWRpKQpjMTNiM2JiNToJMGYgODQgNjUgMDIgMDAgMDAgICAg
CWplICAgICBjMTNiM2UyMCA8cHJlcF9jb21wb3VuZF9wYWdlKzB4MjkwPiAgb25seSB3aGVu
IHBhZ2UgZmxhZ3MgPT0gMHhmZmZmZmZmZiAoPykKYzEzYjNiYmI6CTgzIDA1IGQwIDI4IDZj
IGM1IDAxIAlhZGRsICAgJDB4MSwweGM1NmMyOGQwCmMxM2IzYmMyOgk4MyAxNSBkNCAyOCA2
YyBjNSAwMCAJYWRjbCAgICQweDAsMHhjNTZjMjhkNApjMTNiM2JjOToJMGYgYmEgMmYgMTAg
ICAgICAgICAgCWJ0c2wgICAkMHgxMCwoJWVkaSkgICAgICAgICAgICAgICAgICAgICAgICAg
c2V0cyBiaXQgMHgxMCAoUEdfaGVhZCkgaW4gcGFnZSBmbGFncwpjMTNiM2JjZDoJODMgMDUg
ZjAgMjggNmMgYzUgMDEgCWFkZGwgICAkMHgxLDB4YzU2YzI4ZjAKYzEzYjNiZDQ6CTgzIDE1
IGY0IDI4IDZjIGM1IDAwIAlhZGNsICAgJDB4MCwweGM1NmMyOGY0CmMxM2IzYmRiOgk4MyBm
YiAwMSAgICAgICAgICAgICAJY21wICAgICQweDEsJWVieApjMTNiM2JkZToJMGYgOGUgODAg
MDAgMDAgMDAgICAgCWpsZSAgICBjMTNiM2M2NCA8cHJlcF9jb21wb3VuZF9wYWdlKzB4ZDQ+
ICAgbnJfcGFnZXMgPD0gMSAtPiBza2lwIG92ZXIgdGhlIHdob2xlIGxvb3AKYzEzYjNiZTQ6
CThkIDQ3IDAxICAgICAgICAgICAgIAlsZWEgICAgMHgxKCVlZGkpLCVlYXggICAgICAgICAg
ICAgICAgICAgICAgIGVheCA9IHBhZ2V8MSAoY29tcG91bmRfaGVhZCB2YWx1ZSkKYzEzYjNi
ZTc6CThiIDE1IGZjIDI4IDZjIGM1ICAgIAltb3YgICAgMHhjNTZjMjhmYywlZWR4ICAgICAg
ICAgICAgICAgICAgICAgIGVkeCBub3cgc29tZSBjcmFwLCB3ZSBkb24ndCBrbm93IGhvdyB0
aGlzIHdhcyBpbml0aWFsaXplZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICEhIQpjMTNiM2JlZDoJODkgNDUgZTggICAgICAgICAgICAgCW1vdiAgICAlZWF4
LC0weDE4KCVlYnApICAgICAgICAgICAgICAgICAgICAgc2F2ZXMgdGhlIHBhZ2V8MSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCmMxM2IzYmYwOglhMSBmOCAyOCA2YyBjNSAgICAg
ICAJbW92ICAgIDB4YzU2YzI4ZjgsJWVheCAgICAgICAgICAgICAgICAgICAgICBlYXggbm93
IHNvbWUgY3JhcCwgYWdhaW4gd2UgZG9uJ3Qga25vdyBob3cgdGhpcyB3YXMgaW5pdGlhbGl6
ZWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhISEKYzEzYjNiZjU6CThk
IDRmIDI4ICAgICAgICAgICAgIAlsZWEgICAgMHgyOCglZWRpKSwlZWN4ICAgICAgICAgICAg
ICAgICAgICAgIGVjeCA9IGVkaSArIDB4MjggLSBmaXJzdCB0YWlsIHBhZ2UKYzEzYjNiZjg6
CTg5IDdkIGUwICAgICAgICAgICAgIAltb3YgICAgJWVkaSwtMHgyMCglZWJwKSAgICAgICAg
ICAgICAgICAgICAgIHNhdmVzIHBhZ2UgcG9pbnRlcgpjMTNiM2JmYjoJODMgYzAgMDEgICAg
ICAgICAgICAgCWFkZCAgICAkMHgxLCVlYXggICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y3JhcCArIDEgCmMxM2IzYmZlOgk4OSA0NSBlYyAgICAgICAgICAgICAJbW92ICAgICVlYXgs
LTB4MTQoJWVicCkgICAgICAgICAgICAgICAgICAgICBzYXZlcyB0aGUgY3JhcApjMTNiM2Mw
MToJODMgZDIgMDAgICAgICAgICAgICAgCWFkYyAgICAkMHgwLCVlZHggICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY3JhcCBpbiBjcmFwIG91dApjMTNiM2MwNDoJYTEgZjggMjggNmMg
YzUgICAgICAgCW1vdiAgICAweGM1NmMyOGY4LCVlYXggICAgICAgICAgICAgICAgICAgICAg
cmVzZXQgYXMgY3JhcApjMTNiM2MwOToJODkgNTUgZjAgICAgICAgICAgICAgCW1vdiAgICAl
ZWR4LC0weDEwKCVlYnApICAgICAgICAgICAgICAgICAgICAgc2F2ZSBtb3JlIGNyYXAKYzEz
YjNjMGM6CThiIDE1IGZjIDI4IDZjIGM1ICAgIAltb3YgICAgMHhjNTZjMjhmYywlZWR4ICAg
ICAgICAgICAgICAgICAgICAgIHJlc2V0IGFzIGNyYXAKYzEzYjNjMTI6CTgzIGViIDAyICAg
ICAgICAgICAgIAlzdWIgICAgJDB4MiwlZWJ4ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGVieCBpcyBucl9wYWdlcyAtIDIgKGZvciBvcmRlci0xIHdhcyAyLCBub3cgMCkgLSByZW1h
aW5pbmcgdGFpbCBwYWdlcyBhZnRlciBmaXJzdCBpdGVyYXRpb24/CmMxM2IzYzE1OgkzMSBm
NiAgICAgICAgICAgICAgICAJeG9yICAgICVlc2ksJWVzaSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlc2kgaXMgMApjMTNiM2MxNzoJODMgYzAgMDIgICAgICAgICAgICAgCWFkZCAg
ICAkMHgyLCVlYXggICAgICAgICAgICAgICAgICAgICAgICAgICAgY3JhcCArIDIKYzEzYjNj
MWE6CTgzIGQyIDAwICAgICAgICAgICAgIAlhZGMgICAgJDB4MCwlZWR4ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNyYXAKYzEzYjNjMWQ6CTAxIGMzICAgICAgICAgICAgICAgIAlh
ZGQgICAgJWVheCwlZWJ4ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVieCBpcyBub3cg
bW9kaWZpZWQgYnkgY3JhcCAhISEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICEhIQpjMTNiM2MxZjoJOGIgNDUg
ZWMgICAgICAgICAgICAgCW1vdiAgICAtMHgxNCglZWJwKSwlZWF4ICAgICAgICAgICAgICAg
ICAgICAgcmVzZXQgYXMgY3JhcApjMTNiM2MyMjoJMTEgZDYgICAgICAgICAgICAgICAgCWFk
YyAgICAlZWR4LCVlc2kgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXNpIG5vdyBhbHNv
IGNyYXAKYzEzYjNjMjQ6CThiIDU1IGYwICAgICAgICAgICAgIAltb3YgICAgLTB4MTAoJWVi
cCksJWVkeCAgICAgICAgICAgICAgICAgICAgIHJlc2V0IGFzIGNyYXAKYzEzYjNjMjc6CTg5
IGY3ICAgICAgICAgICAgICAgIAltb3YgICAgJWVzaSwlZWRpICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGVkaSBub3cgYWxzbyBjcmFwLCBvaCBteQpjMTNiM2MyOToJODkgZGUgICAg
ICAgICAgICAgICAgCW1vdiAgICAlZWJ4LCVlc2kgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3VwcG9zZWQgdG8gYmUgdGhlIHJlbWFpbmluZyB0YWlsIHBhZ2VzLCBieXQgbW9kaWZp
ZWQgYnkgY3JhcApjMTNiM2MyYjoJOGQgNzQgMjYgMDAgICAgICAgICAgCWxlYSAgICAweDAo
JWVzaSwlZWl6LDEpLCVlc2kgICAgICAgICAgICAgICAgZWxhYm9yYXRlIG5vcApjMTNiM2My
ZjoJOTAgICAgICAgICAgICAgICAgICAgCW5vcCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbm9wCgovLyB0aGlzIHNob3VsZCBiZSB0aGUgbG9vcCBmb3IgcHJl
cF9jb21wb3VuZF90YWlsCmMxM2IzYzMwOglhMyBmOCAyOCA2YyBjNSAgICAgICAJbW92ICAg
ICVlYXgsMHhjNTZjMjhmOCAgICAgICAgICAgICAgICAgICAgICB1aCBub3cgd2Ugc2F2ZWQg
c29tZSB2YWx1ZSB0byB0aGUgbWVtb3J5IHdlIHJlYWQgcHJldmlvdXNseSBhc3N1bWluZyBz
b21lIGtub3duIGdvb2QgdmFsdWU/ICAgICAgICAhISEKYzEzYjNjMzU6CThiIDVkIGU4ICAg
ICAgICAgICAgIAltb3YgICAgLTB4MTgoJWVicCksJWVieCAgICAgICAgICAgICAgICAgICAg
IGVieCA9IHBhZ2V8MSAoY29tcG91bmRfaGVhZCB2YWx1ZSkKYzEzYjNjMzg6CTgzIGMwIDAx
ICAgICAgICAgICAgIAlhZGQgICAgJDB4MSwlZWF4ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0aWxsIGNyYXAKYzEzYjNjM2I6CTg5IDE1IGZjIDI4IDZjIGM1ICAgIAltb3YgICAg
JWVkeCwweGM1NmMyOGZjICAgICAgICAgICAgICAgICAgICAgIGFuZCBub3cgd2Ugd3JvdGUg
dG8gdGhlIG90aGVyIGFkZHJlc3MgYXMgd2VsbD8gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICEhIQpjMTNiM2M0MToJODMgZDIgMDAgICAg
ICAgICAgICAgCWFkYyAgICAkMHgwLCVlZHggICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RpbGwgY3JhcApjMTNiM2M0NDoJODMgYzEgMjggICAgICAgICAgICAgCWFkZCAgICAkMHgy
OCwlZWN4ICAgICAgICAgICAgICAgICAgICAgICAgICAgZWN4IHBvaW50ZWQgdG8gZmlyc3Qg
dGFpbCBwYWdlcywgbm93IHBvaW50cyB0byBzZWNvbmQgdGFpbCBwYWdlCmMxM2IzYzQ3Oglj
NyA0MSBlNCAwMCAwNCAwMCAwMCAJbW92bCAgICQweDQwMCwtMHgxYyglZWN4KSAgICAgICAg
ICAgICAgICAgICAoZmlyc3QgdGFpbCBwYWdlKS0+bWFwcGluZyA9IFRBSUxfTUFQUElORzsK
YzEzYjNjNGU6CTg5IDU5IGRjICAgICAgICAgICAgIAltb3YgICAgJWVieCwtMHgyNCglZWN4
KSAgICAgICAgICAgICAgICAgICAgIChmaXJzdCB0YWlsIHBhZ2UpLT5jb21wb3VuZF9oZWFk
IGlzIG5vdyBzZXQKYzEzYjNjNTE6CTg5IGZiICAgICAgICAgICAgICAgIAltb3YgICAgJWVk
aSwlZWJ4ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVieCBub3cgY3JhcApjMTNiM2M1
MzoJMzEgZDMgICAgICAgICAgICAgICAgCXhvciAgICAlZWR4LCVlYnggICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZWJ4IHhvcmVkIHdpdGggbW9yZSBjcmFwCmMxM2IzYzU1Ogk4OSA1
ZCBlYyAgICAgICAgICAgICAJbW92ICAgICVlYngsLTB4MTQoJWVicCkgICAgICAgICAgICAg
ICAgICAgICB3ZSBtaWdodCBuZWVkIHRoYXQgY3JhcCBsYXRlcgpjMTNiM2M1ODoJODkgZjMg
ICAgICAgICAgICAgICAgCW1vdiAgICAlZXNpLCVlYnggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3VwcG9zZWQgdG8gYmUgdGhlIHJlbWFpbmluZyB0YWlsIHBhZ2VzLCBieXQgbW9k
aWZpZWQgYnkgY3JhcApjMTNiM2M1YToJMzEgYzMgICAgICAgICAgICAgICAgCXhvciAgICAl
ZWF4LCVlYnggICAgICAgICAgICAgICAgICAgICAgICAgICAgeWVhaCB3aHkgbm90IHhvciBp
dCB3aXRoIG1vcmUgY3JhcApjMTNiM2M1YzoJMGIgNWQgZWMgICAgICAgICAgICAgCW9yICAg
ICAtMHgxNCglZWJwKSwlZWJ4ICAgICAgICAgICAgICAgICAgICAgYW5kICJvciIgaXQgd2l0
aCB0aGUgcHJldmlvdXNseSBzYXZlZCBjcmFwCmMxM2IzYzVmOgk3NSBjZiAgICAgICAgICAg
ICAgICAJam5lICAgIGMxM2IzYzMwIDxwcmVwX2NvbXBvdW5kX3BhZ2UrMHhhMD4gICBhbmQg
dGhhdCdzIGhvdyB3ZSBkZWNpZGVkIGlmIHdlIHNob3VsZCBkbyBhbm90aGVyIGl0ZXJhdGlv
biA6KAoKYzEzYjNjNjE6CThiIDdkIGUwICAgICAgICAgICAgIAltb3YgICAgLTB4MjAoJWVi
cCksJWVkaSAgICAgICAgICAgICAgICAgICAgIHJlc3RvcmUgZWRpID0gcGFnZQoKLy8gaGVy
ZSB3ZSBsYW5kIGlmIHdlIHNraXAgZXZlcnl0aGluZyBhdCBjMTNiM2JkZQpjMTNiM2M2NDoJ
YzYgNDcgMzAgMDEgICAgICAgICAgCW1vdmIgICAkMHgxLDB4MzAoJWVkaSkKLy8gdGhlIHJl
c3Qgc2hvdWxkbid0IGJlIGltcG9ydGFudAo=

--------------8Cla80fHKfVBjkCzfkPzSfej--
