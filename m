Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923B16FF2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbjEKNep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbjEKNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0258A7F;
        Thu, 11 May 2023 06:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B9960F76;
        Thu, 11 May 2023 13:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BADC433EF;
        Thu, 11 May 2023 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683812002;
        bh=asAC0jcXp3GtSMVaoQSHXlx7T1tfg7P0hXCfEi1McDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=co7xWMjfTZpbTw/cY3R4mO/AWqWBlPt9EGOAcU/VAbU8ME8ODtODd90xaYneH2zJt
         DXSjs+CNun4rEz2+Q/GbeOtUKKYaU0SvVwGnBzfzUTsGeQELmhapZZtlpY/Pov4K0c
         SHY4vHe06DgMeMxBEbxlsAkWN98Jpxj8DyLH4hNY=
Date:   Thu, 11 May 2023 22:33:17 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <2023051156-alabaster-shading-c266@gregkh>
References: <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c>
 <2023050913-spearhead-angrily-fc58@gregkh>
 <20230509145806.GA8@df3c0d7ae0b0>
 <2023051025-plug-willow-e278@gregkh>
 <CAG9oJsnr55Atybm4nOQAFjXQ_TeqVG+Nz_8zqMT3ansdnEpGBQ@mail.gmail.com>
 <2023051048-plus-mountable-6280@gregkh>
 <CAG9oJskrJotpyqwi6AHVMmhnFmL+Ym=xAFmL51RiZFaU78wv-A@mail.gmail.com>
 <2023051132-dweller-upturned-b446@gregkh>
 <CAG9oJskf0fE7LiumdzD4QW8dTmGpmVyXBSyiKu_xP+s72Rw44A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG9oJskf0fE7LiumdzD4QW8dTmGpmVyXBSyiKu_xP+s72Rw44A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 06:30:02PM +1000, Rudi Heitbaum wrote:
> On Thu, 11 May 2023 at 09:00, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, May 10, 2023 at 09:58:06PM +1000, Rudi Heitbaum wrote:
> > > On Wed, 10 May 2023 at 19:09, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, May 10, 2023 at 06:29:23PM +1000, Rudi Heitbaum wrote:
> > > > > On Wed, 10 May 2023 at 17:25, Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Tue, May 09, 2023 at 02:58:06PM +0000, Rudi Heitbaum wrote:
> > > > > > > On Tue, May 09, 2023 at 03:56:42PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > On Tue, May 09, 2023 at 01:10:32PM +0000, Rudi Heitbaum wrote:
> > > > > > > > > On Tue, May 09, 2023 at 08:06:58AM +0000, Rudi Heitbaum wrote:
> > > > > > > > > > On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > > > This is the start of the stable review cycle for the 6.3.2 release.
> > > > > > > > > > > There are 694 patches in this series, all will be posted as a response
> > > > > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > > > > let me know.
> > > > > > > > > > >
> > > > > > > > > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > > > > > > > > Anything received after that time might be too late.
> > > > > > > > > >
> > > > > > > > > > Hi Greg,
> > > > > > > > > >
> > > > > > > > > > 6.3.2-rc2 tested.
> > > > > > > > >
> > > > > > > > > Hi Greg,
> > > > > > > > >
> > > > > > > > > Further testing and have seen ntfs3: NULL pointer dereference with ntfs_lookup errors
> > > > > > > > > with 6.3.2-rc2 (I have not seen this error before.) No other errors in the logs.
> > > > > > > >
> > > > > > > > Can you reproduce this without the extern, gpl-violation module loaded?
> > > > > > > >
> > > > > > > > thanks,
> > > > > > > >
> > > > > > > > greg k-h
> > > > > > >
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > I dropped the bcm_sta and recompiled and commented out the i915.guc=3
> > > > > > > and was able to reproduce.
> > > > > > >
> > > > > > > [   84.745080] BUG: kernel NULL pointer dereference, address: 0000000000000020
> > > > > > > [   84.746239] #PF: supervisor read access in kernel mode
> > > > > > > [   84.747599] #PF: error_code(0x0000) - not-present page
> > > > > > > [   84.748929] PGD 0 P4D 0
> > > > > > > [   84.750240] Oops: 0000 [#1] SMP NOPTI
> > > > > > > [   84.751575] CPU: 2 PID: 3176 Comm: .NET ThreadPool Not tainted 6.3.2-rc2 #1
> > > > > > > [   84.752998] Hardware name: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
> > > > > > > [   84.754474] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
> > > > > >
> > > > > > And do you get this same crash on ntfs3 on 6.4-rc1?  Is this a new
> > > > > > regression, or does it also show up on 6.3.1?
> > > > >
> > > > > Tested with 6.3.1 during the day today. No errors, and had been
> > > > > running 6.3.1 with no issue. Retested with 6.3.2-rc2 and problem
> > > > > immediately evident. So yes - I believe a regression.
> > > > >
> > > > > I have built and am now testing 6.4.0-rc1 this evening - no errors so far.
> > > > >
> > > > > [    0.000000] Linux version 6.4.0-rc1 (docker@1ccd349e2545)
> > > > > (x86_64-libreelec-linux-gnu-gcc-13.1.0 (GCC) 13.1.0, GNU ld (GNU
> > > > > Binutils) 2.40) #1 SMP Wed May 10 07:51:37 UTC 2023
> > > > >
> > > > > > And ntfs, ick, why?  And .NET?  What a combination...
> > > > >
> > > > > Joys of media players. Test device gets to test exfat, ntfs3, .NET,
> > > > > and throw in a compile host/GHA runner to put it through paces.
> > > >
> > > > Yeah, this should work.  Thanks for verifying this works on other
> > > > releases.  Any chance you can do 'git bisect' to track down the
> > > > offending commit?  In looking things over, I don't see anything
> > > > obvious...
> > >
> > > Hi Greg,
> > >
> > > I can confirm the offending commit in 6.3.2-rc2 is
> > >
> > > bf11fd528a97 fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
> >
> > Thanks!  Odd that this didn't show up for you on the other stable -rc
> > releases, as that commit is also in those trees.
> >
> > I'll go revert this for now and ask the maintainer to send a fixed
> > version.
> 
> Hi Greg,
> 
> I have run 6.1.28-rc2 today, and was able to trigger the error. So
> definitely bad in both 6.3 and 6.1.
> 
> [13812.020209] BUG: kernel NULL pointer dereference, address: 0000000000000020
> [13812.021322] #PF: supervisor read access in kernel mode
> [13812.022346] #PF: error_code(0x0000) - not-present page
> [13812.023591] PGD 0 P4D 0
> [13812.024876] Oops: 0000 [#1] SMP NOPTI
> [13812.026088] CPU: 5 PID: 20386 Comm: .NET ThreadPool Not tainted 6.1.28-rc2 #1
> [13812.027336] Hardware name: Intel(R) Client Systems
> NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
> [13812.028593] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
> [13812.029827] Code: 00 00 00 49 89 c4 e8 19 47 fe ff 85 c0 79 3a 48
> 63 d8 48 8b 3d 4b 1d 77 cd 4c 89 e6 e8 33 25 d1 c3 48 81 fb 00 f0 ff
> ff 77 07 <48> 83 7b 20 00 74 41 4c 89 ee 48 89 df e8 88 a5 d5 c3 5b 41
> 5c 41
> [13812.031149] RSP: 0018:ffff91f40537bbc8 EFLAGS: 00010207
> [13812.032408] RAX: ffff8a844946a001 RBX: 0000000000000000 RCX: 00000000000042f7
> [13812.033650] RDX: 00000000000042f6 RSI: fffff40a00000000 RDI: 0000000000030ed0
> [13812.034869] RBP: ffff91f40537bbe8 R08: ffff8a844946c01e R09: ffff8a8474d0387e
> [13812.036138] R10: ffff8a845a900000 R11: 0000000000000017 R12: ffff8a844946c000
> [13812.037372] R13: ffff8a84db3fd2c0 R14: ffff8a84b44a0470 R15: ffff8a84b44a0548
> [13812.039002] FS:  00007f437e7fc6c0(0000) GS:ffff8a8b77740000(0000)
> knlGS:0000000000000000
> [13812.040509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [13812.041741] CR2: 0000000000000020 CR3: 000000017835e006 CR4: 0000000000f70ea0
> [13812.042986] PKRU: 55555554
> [13812.044227] Call Trace:
> [13812.045464]  <TASK>
> [13812.046708]  __lookup_slow+0x81/0x130
> [13812.047939]  walk_component+0x10b/0x180
> [13812.049169]  path_lookupat+0x6a/0x1a0
> [13812.050388]  filename_lookup+0xd0/0x190
> [13812.051612]  vfs_statx+0x84/0x150
> [13812.052838]  ? getname_flags+0x54/0x1d0
> [13812.054062]  vfs_fstatat+0x5c/0x80
> [13812.055284]  __do_sys_newlstat+0x37/0x70
> [13812.056580]  ? trace_hardirqs_on+0x3a/0xe0
> [13812.058429]  __x64_sys_newlstat+0x1a/0x20
> [13812.059878]  do_syscall_64+0x3c/0x90
> [13812.061109]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [13812.062369] RIP: 0033:0x7f447ea17184
> [13812.063598] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00
> 00 00 0f 1f 40 00 89 f8 48 89 f7 48 89 d6 83 f8 01 77 2b b8 06 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 04 c3 0f 1f 00 48 8b 15 61 cc 0b 00 f7
> d8 64
> [13812.064927] RSP: 002b:00007f437e7fa098 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000006
> [13812.066267] RAX: ffffffffffffffda RBX: 00007f43cf45a870 RCX: 00007f447ea17184
> [13812.067601] RDX: 00007f437e7fa0a0 RSI: 00007f437e7fa0a0 RDI: 00007f437e7fa210
> [13812.068940] RBP: 00007f437e7fa1f0 R08: 00007f437e7fa320 R09: 000000000000002d
> [13812.070276] R10: 00007f44051a15e8 R11: 0000000000000246 R12: 00007f43cc018408
> [13812.071616] R13: 00007f437e7fa210 R14: 00007f43cf45a870 R15: 000000000000002d
> [13812.072960]  </TASK>
> [13812.074295] Modules linked in: rfcomm xt_nat xt_tcpudp veth
> xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat
> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype
> iptable_filter ip_tables x_tables br_netfilter bridge stp llc overlay
> 8021q ntfs3 bnep btusb btrtl btbcm btintel btmtk bluetooth
> ecdh_generic ecc exfat snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_hda_codec
> iwlwifi mei_hdcp snd_hwdep tpm_tis mei_pxp x86_pkg_temp_thermal
> snd_hda_core tpm_tis_core cfg80211 intel_rapl_msr mei_me
> intel_powerclamp snd_intel_dspcfg intel_rapl_common mei rfkill tpm_crb
> idma64 tpm rng_core pkcs8_key_parser fuse dmi_sysfs
> [13812.079600] CR2: 0000000000000020
> [13812.081160] ---[ end trace 0000000000000000 ]---

Wonderful, thanks for testing this out!

Hopefully the real releases in a bit are all good, thanks for letting us
know.

greg k-h
