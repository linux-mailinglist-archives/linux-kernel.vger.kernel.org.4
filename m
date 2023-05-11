Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0306FEC35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjEKHC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbjEKHCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:02:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662C06A45;
        Thu, 11 May 2023 00:02:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EBCEB2D8;
        Thu, 11 May 2023 09:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683788512;
        bh=A53poAkEzuZFNXT7uUwb/MQQ1q82De35S8dPpNeNMFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYvBVRioIKXTcd3whT3QMKDfyN2fBBN0M2th3KQTSInnTx02R+pheW+HwOUQSwbql
         sXUz/Vj5x3Uuvr2LT9ycDtMI6kWs/Ux49DW2ZsssugCBGjDriS065qaEBfr8I/TGNW
         WWlDl1vgQAyZUr4G0r3C2m4jBIwHoRmH11Q7PHZo=
Date:   Thu, 11 May 2023 10:01:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
Message-ID: <20230511070156.GQ11711@pendragon.ideasonboard.com>
References: <ZElaVmxDsOkZj2DK@debian>
 <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
 <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
 <20230510090527.25e26127@sal.lan>
 <742856c0-ab93-1a6c-4fc8-9451c0908930@leemhuis.info>
 <20230511074606.0349fc69@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511074606.0349fc69@sal.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:46:06AM +0100, Mauro Carvalho Chehab wrote:
> Em Wed, 10 May 2023 11:02:57 +0200 "Linux regression tracking (Thorsten Leemhuis)" escreveu:
> > On 10.05.23 10:05, Mauro Carvalho Chehab wrote:
> > > Em Mon, 8 May 2023 09:27:28 -0700
> > > Linus Torvalds <torvalds@linux-foundation.org> escreveu:  
> > >> On Mon, May 8, 2023 at 3:55 AM Linux regression tracking #adding
> > >> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:  
> > >>>
> > >>> Thanks for the report. The fixes (see the mail from Laurent) apparently
> > >>> are still not mainlined (or am I missing something?), so let me add this
> > >>> report to the tracking to ensure this is not forgotten:    
> > >>
> > >> Gaah. I was intending to apply the patch directly before rc1, but then
> > >> I forgot about this issue.
> > >>
> > >> Mauro: I'm currently really *really* fed up with the media tree. This
> > >> exact same thing happened last merge window, where the media tree
> > >> caused pointless build errors, and it took way too long to get the
> > >> fixes the proper ways.  
> > > [...]
> > >
> > > In the specific case of this fixup patch, I didn't identify it as a build
> > > issue, so it followed the usual workflow. We have a huge number of patches
> > > for media, and it usually takes some time to handle all of them. This one
> > > just followed the normal flow, as it didn't break Jenkins builds nor the
> > > subject mentioned anything about build breakage.  
> > 
> > Makes me wonder again if we should start adding
> > 
> >  CC: regressions@lists.linux.dev
> > 
> > to any patches that fix regressions, that way maintainers and reviewers
> > would have something to filter for -- and I would become aware of all
> > regression fixes in the work, too.
> 
> Having some way that could be parsed by e-mail filters would be
> nice. 

The presence of a Fixes: tag is already a strong indication that the
patch should be prioritized. Looking at the last 10 kernel releases,
here's the number of commits with a Fixes: tag in drivers/media/:

v5.14 - v5.15:    19
v5.15 - v5.16:    36
v5.16 - v5.17:    50
v5.17 - v5.18:    49
v5.18 - v5.19:    25
v5.19 - v6.0:     44
v6.0  - v6.1:     35
v6.1  - v6.2:     72
v6.2  - v6.3:     39
v6.3  - v6.4-rc1: 39

Some are likely not regressions and wouldn't need to be treated with the
highest priority, but keeping an eye on patches with a Fixes: tag seems
doable.

There's also the issue of regression fixes missing a Fixes: tag, but I
doubt those would get CC: regressions@lists.linux.dev, so from a mail
filtering point of view, that wouldn't help.

> > Ciao, Thorsten
> > 
> > P.S.: BTW, let me tell regzbot that Linus merged the fix for the build
> > failure.
> > 
> > #regzbot fix: ba0ad6ed89f
> > 
> > FWIW, the one for the gcc warnings[1] Laurent mentioned elsewhere in
> > this thread is not merged yet afaics.
> > 
> > [1] https://lore.kernel.org/all/20230418092007.2902984-1-arnd@kernel.org/
> 
> Just sent a pull request.
> 
> Btw, I did some changes at linux-media Jenkins instance to help early
> track some extra build issues. They're all against
> https://git.linuxtv.org/media_stage.git/, which is the tree where we place
> media patches that are ready. We move them later, after a couple of days
> to https://git.linuxtv.org/media_tree.git/. So, if something bad happens,
> we have a chance to fix before setting them into a stone. With such
> changes, we now have:
> 
> 1. https://builder.linuxtv.org/job/patchwork/
> 
>    This is a pre-merge test. It tests patch per patch the PRs with patch
>    sets ready to be merged, with W=1, allyesconfig/almodconfig[1] on x86_64. 
>    Builds drivers/media and drivers/staging/media. 
>    This is there already for a long time;
> 
> 2. https://builder.linuxtv.org/job/media_stage_clang/
> 
>    Checks build with clang-12 on x86_64 with W=1. Builds drivers/media
>    and drivers/staging/media with allyesconfig[1].
> 
>    It was building with WERROR disabled, as some core macros were
>    producing errors at the time I created it (and for a while).
>    It was modified to enable WERROR as well. 
> 
> 3. https://builder.linuxtv.org/job/media_stage_gcc-pipeline/ 
> 
>    It replaces another job that was just doing builds for x86_64
>    with W=1. Builds drivers/media and drivers/staging/media with
>    different configurations[1]:
>       x86_64: allyesconfig, allmodconfig, almodconfig with PM disabled;
>       arm32: allyesconfig
>       arm64: allyesconfig
> 
> 4. https://builder.linuxtv.org/job/linux-media/
> 
>    Does full builds with different configurations[1]:
>       x86_64: allyesconfig, allmodconfig, almodconfig with PM disabled;
>       arm32: allyesconfig
>       arm64: allyesconfig
>       docs: htmldocs and pdfdocs
> 
> I hope this will help avoiding future build regressions from our side.
> Feel free to suggest a couple of other configs that we might add to
> jobs (3) and (4).
> 
> I'm still adjusting the pipeline for (4), but currently, it is failing
> on an issue that seems unrelated with the media subsystem with gcc 10.2.1:
> 
> 	  AR      drivers/built-in.a
> 	  AR      built-in.a
> 	  AR      vmlinux.a
> 	  LD      vmlinux.o
> 	vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x2d8: call to vmread_error_trampoline() leaves .noinstr.text section
> 	vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xe1: relocation to !ENDBR: native_write_cr4+0x40
>       
> Is this a known regression? The media-stage tree is on the top of
> Kernel 6.4-rc1.
> 
> Regards,
> Mauro
> 
> -
> 
> [1] On all builds, the jobs disable some symbols that should not affect
>     media subsystem, to speedup the builds:
> 
>    scripts/config -d MODULE_SIG -d KEYS -d IMA -d CONFIG_DEBUG_INFO -d SYSTEM_TRUSTED_KEYRING -d MODVERSIONS

-- 
Regards,

Laurent Pinchart
