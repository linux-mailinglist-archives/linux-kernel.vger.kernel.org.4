Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C6660CBE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 08:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjAGHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 02:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAGHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 02:19:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44132278;
        Fri,  6 Jan 2023 23:19:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1880B81E24;
        Sat,  7 Jan 2023 07:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FEAC433D2;
        Sat,  7 Jan 2023 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673075989;
        bh=7FDbppzvbiFIiiadfrwRJOnbjnq8tWEucXEm0OYgd3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o+5hzIq88WaQsOqDeyAsSswDHTuInQN0GHksVjwCt+HSzMJLp0xD/E6x2dXAKQ6eu
         IfMSZ1fhAJtbRZpUMOMAVNK1UPqH6kH/xtjMW8dyW6LUInlC4E2jF/S6PgRNbUFR5P
         sftCG37UuomCgrk7Vt+FApYepppBTNSjOIic9khOLHHSjUHRYGLJ001m6yhJYgq+Rc
         JlFq208GA1zaswE4TXfbK26uxVFvnG1uN62fTekrGSLbpTUjsq5h2M+Ww97JhVQjeg
         SVKzeMUR/BT24S/5nv7JKEaylvMfgj2vnMr+gM+hekDRKlp/a1lJcYB3aEWbIkqJRV
         FOyT+weBQyzsw==
Received: by mail-oi1-f173.google.com with SMTP id r130so2875359oih.2;
        Fri, 06 Jan 2023 23:19:49 -0800 (PST)
X-Gm-Message-State: AFqh2kr+QNX8yx4AEDOhF8x2PX/8OtHaie3M8HqTd9wIP/aW11XroRMW
        d6uQLx2j7gRDIEZA0fWCt6Hau62r9JXYjCCDwcU=
X-Google-Smtp-Source: AMrXdXsTmZX3dFVSV8zYsIDGs77XAPqLQS1H4NW9g0iHyphPn/tdjHsDJHb6NIxapq8BtwjSdegqzvpCqr1CEYIymzc=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr3430462oia.287.1673075988693; Fri, 06
 Jan 2023 23:19:48 -0800 (PST)
MIME-Version: 1.0
References: <Y7i8+EjwdnhHtlrr@dev-arch.thelio-3990X>
In-Reply-To: <Y7i8+EjwdnhHtlrr@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 7 Jan 2023 16:19:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASkC3j5=cy7efMC=pFjgXMucBOVNrMCTMCUkJSLj8i=Dg@mail.gmail.com>
Message-ID: <CAK7LNASkC3j5=cy7efMC=pFjgXMucBOVNrMCTMCUkJSLj8i=Dg@mail.gmail.com>
Subject: Re: nm vmlinux error in arch/arm reappears after upgrade to make 4.4
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023 at 9:29 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Masahiro,
>
> My distribution recently updated their version of make to 4.4 from 4.3,
> after which I notice the following error from nm when building ARCH=arm
> kernels, which I thought that this was supposed to be resolved with
> commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux") but the
> tree clearly has this and it is not visible while just running clean (I
> have to build zImage to see it):


Presumably, this is a different issue than 3ec8a5b33dea


>
>   $ git show -s --format='%h ("%s")'
>   512dee0c00ad ("Merge tag 'x86-urgent-2023-01-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
>
>   $ make --version | head -1
>   GNU Make 4.4
>
>   $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig zImage
>   arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux': No such file
>
> vs.
>
>   $ make --version | head -1
>   GNU Make 4.3
>
>   $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig zImage
>
> I bisected make to see what change causes this and I landed on
> commit 98da874c ("[SV 10593] Export variables to $(shell ...)
> commands") [1], which certainly seems like a reasonable commit to
> blame but I am not sure how exactly it factors in here.
>
> If you need any more information on reproducing this, I am happy to
> provide it (CROSS_COMPILE is just the toolchains from kernel.org).
>
> [1]: https://git.savannah.gnu.org/cgit/make.git/commit/?id=98da874c43035a490cdca81331724f233a3d0c9a
>
> Cheers,
> Nathan



Confirmed, but I still do not understand what
is triggering this.

These are my findings:

 - O= option is needed to reproduce it.

 - allnoconfig still produces it.

 - I do not see it in the incremental builds.
   I see it again in the full build after "git clean -fdx".



If I slightly cleaned the code like follows,
this issue disappeared.
($(obj)/../../../../vmlinux is the same as vmlinux)




diff --git a/arch/arm/boot/compressed/Makefile
b/arch/arm/boot/compressed/Makefile
index 2ef651a78fa2..726ecabcef09 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -107,7 +107,7 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
 asflags-y := -DZIMAGE

 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
+KBSS_SZ = $(shell echo $$(($$($(NM) vmlinux | \
                sed -n -e 's/^\([^ ]*\) [ABD] __bss_start$$/-0x\1/p' \
                       -e 's/^\([^ ]*\) [ABD] __bss_stop$$/+0x\1/p') )) )
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)










-- 
Best Regards
Masahiro Yamada
