Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CC56FC9B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjEIO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjEIO6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:58:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2F35A6
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:58:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaebed5bd6so42361335ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1683644296; x=1686236296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQyduyaOzxht+4mYPyPs/f7DEi3T9R3/shYnH8c6rNQ=;
        b=RLXshpVwTLVfs7Mh1ykszJU/0Rad9zYj0ppJPBR5+2SgzMjZKTIGaJDLyf6vHiWhG7
         APTdiVXBrKXM0DPBstzuVTQES+mK9V4LaHZxT51y64UHNGTgkYrgxgVRA4g0EMgYdXgE
         gQW4nyWp5Jxuul6kqZOwmLhhiVNlwz0WQwyKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683644296; x=1686236296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQyduyaOzxht+4mYPyPs/f7DEi3T9R3/shYnH8c6rNQ=;
        b=fIUEUuypoU9Mba3dx984SYiEwaKMq/yjK+rQi+2T7ENdAkvokMjyXnMsSGLOjcZDf0
         p27w/vNtJMoKHnae6p20o7e9vsJEwaxRNdES18dSnOFXiXIo6a1St85L2G5oxCQGwEQo
         tzoo8liMW9XwQ8/gHgZPxFyjLk+j+CXclf1RoGFWCatDceB0PGulMIVSPaCw2x3pcC4w
         1GW7NkjrRezt7OCYkdRl+9g//wMp+EyqGFvhQKTsS8xZJy865FpKn4z08kJPHZ83O7zw
         vUrK4+6Fme0chciR+Jf7MEdo9h/1Q2fR28adcdPNBohCmm5kNKSdrdL0NfI/PzgTKNhA
         mg4w==
X-Gm-Message-State: AC+VfDzufuHKdSFjJxJggc+rtTrNFVl8e58Cx2O/1OBLt9spKnpB0eIB
        er7u1lyCGChjkXk0uu/CLBzWSw==
X-Google-Smtp-Source: ACHHUZ5+1hrInnUBHEW4lVg0LxkYXc2XplebkzdDOGq0nbcz3ZPfDaINnbQNdKCZwwHJgk6KYCNZDQ==
X-Received: by 2002:a17:903:1c6:b0:1ac:946e:468e with SMTP id e6-20020a17090301c600b001ac946e468emr3553731plh.57.1683644296073;
        Tue, 09 May 2023 07:58:16 -0700 (PDT)
Received: from df3c0d7ae0b0 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902a9c700b001ab849b46d3sm1681391plr.178.2023.05.09.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 07:58:14 -0700 (PDT)
Date:   Tue, 9 May 2023 14:58:06 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <20230509145806.GA8@df3c0d7ae0b0>
References: <20230509030705.399628514@linuxfoundation.org>
 <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c>
 <2023050913-spearhead-angrily-fc58@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023050913-spearhead-angrily-fc58@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 03:56:42PM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 09, 2023 at 01:10:32PM +0000, Rudi Heitbaum wrote:
> > On Tue, May 09, 2023 at 08:06:58AM +0000, Rudi Heitbaum wrote:
> > > On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.3.2 release.
> > > > There are 694 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > Anything received after that time might be too late.
> > > 
> > > Hi Greg,
> > > 
> > > 6.3.2-rc2 tested.
> > 
> > Hi Greg,
> > 
> > Further testing and have seen ntfs3: NULL pointer dereference with ntfs_lookup errors 
> > with 6.3.2-rc2 (I have not seen this error before.) No other errors in the logs.
> 
> Can you reproduce this without the extern, gpl-violation module loaded?
> 
> thanks,
> 
> greg k-h

Hi Greg,

I dropped the bcm_sta and recompiled and commented out the i915.guc=3
and was able to reproduce.

[   84.745080] BUG: kernel NULL pointer dereference, address: 0000000000000020
[   84.746239] #PF: supervisor read access in kernel mode
[   84.747599] #PF: error_code(0x0000) - not-present page
[   84.748929] PGD 0 P4D 0 
[   84.750240] Oops: 0000 [#1] SMP NOPTI
[   84.751575] CPU: 2 PID: 3176 Comm: .NET ThreadPool Not tainted 6.3.2-rc2 #1
[   84.752998] Hardware name: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
[   84.754474] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
[   84.755899] Code: 00 00 00 49 89 c4 e8 d9 33 fe ff 85 c0 79 3a 48 63 d8 48 8b 3d 2b 51 74 e4 4c 89 e6 e8 83 a0 d3 da 48 81 fb 00 f0 ff ff 77 07 <48> 83 7b 20 00 74 41 4c 89 ee 48 89 df e8 e8 85 d8 da 5b 41 5c 41
[   84.757430] RSP: 0018:ffff9dea4072bbb8 EFLAGS: 00010207
[   84.758943] RAX: ffff94fcf4efb001 RBX: 0000000000000000 RCX: 0000000000058509
[   84.760485] RDX: 0000000000058508 RSI: ffffc40100000000 RDI: 00000000000324f0
[   84.762031] RBP: ffff9dea4072bbd8 R08: ffff94fcf4eff008 R09: ffff94fcaaeb2c88
[   84.763621] R10: ffff94fc58fc0000 R11: 0000000000000013 R12: ffff94fcf4eff000
[   84.765191] R13: ffff94fcfe67a600 R14: ffff94fcdf008470 R15: ffff94fcdf008548
[   84.766773] FS:  00007f51d1ffb6c0(0000) GS:ffff950377680000(0000) knlGS:0000000000000000
[   84.768386] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.770001] CR2: 0000000000000020 CR3: 0000000177b5a004 CR4: 0000000000f70ea0
[   84.771632] PKRU: 55555554
[   84.773261] Call Trace:
[   84.774890]  <TASK>
[   84.776499]  __lookup_slow+0x81/0x130
[   84.778107]  walk_component+0x10b/0x180
[   84.779719]  path_lookupat+0x6a/0x1a0
[   84.781368]  filename_lookup+0xd0/0x190
[   84.782978]  ? sched_clock+0xd/0x20
[   84.784592]  ? sched_clock_cpu+0x14/0x190
[   84.786202]  ? __smp_call_single_queue+0x40/0x50
[   84.787816]  ? ttwu_queue_wakelist+0xfd/0x100
[   84.789436]  ? kmem_cache_alloc+0x47/0x3c0
[   84.791050]  vfs_statx+0x84/0x150
[   84.792669]  ? getname_flags+0x54/0x1d0
[   84.794288]  vfs_fstatat+0x5c/0x80
[   84.795905]  __do_sys_newlstat+0x37/0x70
[   84.797549]  ? do_futex+0x12e/0x1a0
[   84.799166]  ? __x64_sys_futex+0x112/0x1d0
[   84.800773]  ? trace_hardirqs_off.part.0+0x20/0x70
[   84.802395]  ? trace_hardirqs_on+0x2f/0x80
[   84.803998]  __x64_sys_newlstat+0x1a/0x20
[   84.805599]  do_syscall_64+0x3c/0x90
[   84.807193]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   84.808802] RIP: 0033:0x7f529d04e184
[   84.810409] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 89 f8 48 89 f7 48 89 d6 83 f8 01 77 2b b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 04 c3 0f 1f 00 48 8b 15 61 cc 0b 00 f7 d8 64
[   84.812161] RSP: 002b:00007f51d1ff9028 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[   84.813959] RAX: ffffffffffffffda RBX: 00007f51eee2c010 RCX: 00007f529d04e184
[   84.815723] RDX: 00007f51d1ff9030 RSI: 00007f51d1ff9030 RDI: 00007f51d1ff91a0
[   84.817496] RBP: 00007f51d1ff9180 R08: 00007f51d1ff92b0 R09: 0000000000000029
[   84.819271] R10: 00007f52237915e8 R11: 0000000000000246 R12: 00007f51ec018408
[   84.821051] R13: 00007f51d1ff91a0 R14: 00007f51eee2c010 R15: 0000000000000029
[   84.822845]  </TASK>
[   84.824621] Modules linked in: rfcomm xt_nat xt_tcpudp veth 8021q xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables x_tables br_netfilter bridge stp llc overlay ntfs3 bnep btusb btrtl btbcm btintel btmtk bluetooth exfat ecdh_generic ecc iwlmvm snd_hda_codec_hdmi mac80211 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio libarc4 iwlwifi snd_hda_intel snd_hda_codec cfg80211 mei_pxp snd_hwdep mei_hdcp intel_rapl_msr x86_pkg_temp_thermal intel_powerclamp snd_hda_core intel_rapl_common mei_me snd_intel_dspcfg tpm_tis tpm_tis_core idma64 mei rfkill tpm_crb tpm rng_core pkcs8_key_parser fuse dmi_sysfs
[   84.830844] CR2: 0000000000000020
[   84.832982] ---[ end trace 0000000000000000 ]---
