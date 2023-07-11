Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F974EBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGKKpF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKKpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:45:03 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38074E60;
        Tue, 11 Jul 2023 03:44:59 -0700 (PDT)
X-UUID: 5ab2eed8384245e190523efe0c7c4026-20230711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:232bb03d-c028-437f-8d8f-aa2a3e0548cf,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:6
X-CID-INFO: VERSION:1.1.27,REQID:232bb03d-c028-437f-8d8f-aa2a3e0548cf,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:6
X-CID-META: VersionHash:01c9525,CLOUDID:aef8deda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:230711184442Q5F2LS16,BulkQuantity:0,Recheck:0,SF:24|17|19|42|38|102,
        TC:nil,Content:1,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULS
X-UUID: 5ab2eed8384245e190523efe0c7c4026-20230711
X-User: jianghaoran@kylinos.cn
Received: from [172.30.60.211] [(39.156.73.12)] by mailgw
        (envelope-from <jianghaoran@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1961543371; Tue, 11 Jul 2023 18:44:40 +0800
Message-ID: <b470ee4c7681eb37c45bb2ff38342281f89bb1ae.camel@kylinos.cn>
Subject: =?gb2312?Q?=BB=D8=B8=B4=A3=BA=5BPATCH?= v2] samples/bpf: Fix
 compilation failure for samples/bpf on LoongArch Fedora
From:   "jianghaoran@kylinos.cn" <jianghaoran@kylinos.cn>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kernel@xen0n.name, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        loongarch@lists.linux.dev, martin.lau@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, sdf@google.com, song@kernel.org,
        trix@redhat.com, yangtiezhu@loongson.cn, yhs@fb.com
Date:   Tue, 11 Jul 2023 18:39:03 +0800
In-Reply-To: <7ecc42aa-4a0f-77f7-a2ad-236270137b6e@iogearbox.net>
References: <CAAhV-H6s3N=-brDz24PfrtEKNFjvnLjbDR2NpOVDF_fN7rA53A@mail.gmail.com>
         <20230710052750.259595-1-jianghaoran@kylinos.cn>
         <CAAhV-H7orsUHDZuwcTUeWYbizcWRG4k_BPy53W7PT_MQ_2SXgw@mail.gmail.com>
         <7ecc42aa-4a0f-77f7-a2ad-236270137b6e@iogearbox.net>
Content-Type: text/plain; charset="euc-tw"
User-Agent: Evolution 3.36.1-2kord0k2.3.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Çã 2023-07-11ÑÓßæÄ¨Îû 09:39 +0200¡¢Daniel BorkmannŽ£¡úç¬¡¨
> On 7/10/23 7:54 AM, Huacai Chen wrote:
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > 
> > On Mon, Jul 10, 2023 at 1:34PM Haoran Jiang <
> > jianghaoran@kylinos.cn> wrote:
> > > When building the latest samples/bpf on LoongArch Fedora
> > > 
> > >       make M=samples/bpf
> > > 
> > > There are compilation errors as follows:
> > > 
> > > In file included from ./linux/samples/bpf/sockex2_kern.c:2:
> > > In file included from ./include/uapi/linux/in.h:25:
> > > In file included from ./include/linux/socket.h:8:
> > > In file included from ./include/linux/uio.h:9:
> > > In file included from ./include/linux/thread_info.h:60:
> > > In file included from
> > > ./arch/loongarch/include/asm/thread_info.h:15:
> > > In file included from
> > > ./arch/loongarch/include/asm/processor.h:13:
> > > In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
> > > ./arch/loongarch/include/asm/loongarch.h:13:10: fatal error:
> > > 'larchintrin.h' file not found
> > >           ^~~~~~~~~~~~~~~
> > > 1 error generated.
> > > 
> > > larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
> > > and the header file location is specified at compile time.
> > > 
> > > Test on LoongArch Fedora:
> > > https://github.com/fedora-remix-loongarch/releases-info
> > > 
> > > Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> > > 
> > > ---
> > > v2:
> > > use LoongArch instead of Loongarch in the title and commit
> > > message.
> > > ---
> > >   samples/bpf/Makefile | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > > index 615f24ebc49c..b301796a3862 100644
> > > --- a/samples/bpf/Makefile
> > > +++ b/samples/bpf/Makefile
> > > @@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
> > >          @echo "  CLANG-bpf " $@
> > >          $(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)
> > > $(BPF_EXTRA_CFLAGS) \
> > >                  -I$(obj)
> > > -I$(srctree)/tools/testing/selftests/bpf/ \
> > > -               -I$(LIBBPF_INCLUDE) \
> > > +               -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
> 
> There's still one location in XDP_SAMPLE_CFLAGS, do we need the
> $(CLANG_SYS_INCLUDES)
> there as well?

XDP_SAMPLE_CFLAGS only affects the compilation of xdp_sample_user.c. It
is a user-mode application¡¢the associated header files of clang are not
used. larchintrin.h will only be included in *.bpf.c and *kern.c
files.So I don't think $(CLANG_SYS_INCLUDES) needs to be included here.

> 
> > >                  -D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value 
> > > -Wno-pointer-sign \
> > >                  -D__TARGET_ARCH_$(SRCARCH) -Wno-compare-
> > > distinct-pointer-types \
> > >                  -Wno-gnu-variable-sized-type-not-at-end \
> > > --
> > > 2.27.0
> > > 
> > > 

