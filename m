Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ECE60307F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJRQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJRQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:06:12 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64050717
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:06:08 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1324e7a1284so17339534fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M9GeweM506Qll66VGKD+g5QW2DGGV0t9dQASzMStmo8=;
        b=QolWHuOAGw9g1xp+QQNctKPPH4dhCEYk6lRTOxbt5TEGfVXAeNoSw+P2k7q54VJtW1
         0YOenviLTGZ1fofl4KNPawrQ9IN2Wj7x8wdoyGo88CI8DUmXqoXy57peowYLzS6F7HSo
         TNLmXZ8Acy8qExh8guni3KwM32jA74IeNBAbk+Ub9sRSk0S/9//600L0Hq51fOklx/VE
         jikadbt4GuUMq2QKvc/7hfDLFGFJ+ClK7nSCC/ynTREATduMX27JQAbeJkT3Kcm2tJCJ
         jf80Q1vxnKbuLCZo4oOHdc20PduUjcHuvqkcNQXzojvpNv8gCquYNKMtr+k7LZmWigQ/
         C3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9GeweM506Qll66VGKD+g5QW2DGGV0t9dQASzMStmo8=;
        b=4qfkgmPlzvblMHfSu9uBeYQqX2TNBytIMgb4PKqXfzpYnd23gbZmeN8L/U90Sdn2wE
         5ChyM6N7Bux93RqY8wLRKMKnaEnLhlwnEcjisW444AG4OWBflZVu9KCvQ+5xIMLwTniK
         vUbqkrpyRnC/805AcxMuOzmVk3wEn6zfZwJUqzhCiMmaE9lzw2AtnyJsZDIHcsuLwqS7
         PWJuvguDOaNMdmbyx6+iuKPJLyqs342LBh2JDkxhb80KxMs4judP4JC8NvqkcAcgIwPj
         Iv+sELJ5yE6WJUDGn+C61hqrl6W4lU3xE0733BLwKxgHYXzWm2bKYZW0ZK8TiIF6LxVv
         Czcg==
X-Gm-Message-State: ACrzQf2mnwDakNw//3rU/1BQCxU+i0Cwu/Ep0efoCRdc+O4rlFAwHnoJ
        vEy9X20O3z0k7XgkgNS7QqWHifxUX/9uNLQnduEBDg==
X-Google-Smtp-Source: AMsMyM5MmjoXBmroyCEW+8kPuqv55NwHd6IZ6+s8jej9A9DYv5Gf7AVAWcQmJV/PxZvqMA9/4aDL7N+NpgSXe4nkckQ=
X-Received: by 2002:a05:6870:4411:b0:136:71ed:c7cd with SMTP id
 u17-20020a056870441100b0013671edc7cdmr2090587oah.108.1666109167356; Tue, 18
 Oct 2022 09:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com> <Y0aq8y5mEZi14lJ/@arm.com>
In-Reply-To: <Y0aq8y5mEZi14lJ/@arm.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 18 Oct 2022 21:35:16 +0530
Message-ID: <CAMi1Hd3H2k1J8hJ6e-Miy5+nVDNzv6qQ3nN-9929B0GbHJkXEg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 at 17:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Amit,
>
> On Sat, Oct 08, 2022 at 08:28:26PM +0530, Amit Pundir wrote:
> > On Wed, 5 Oct 2022 at 20:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Will Deacon (2):
> > >       arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
> >
> > Hi Will,
> >
> > This patch broke AOSP on Dragonboard 845c (SDM845). I don't see any
> > relevant crash in the attached log and device silently reboots into
> > USB crash dump mode. The crash is fairly reproducible on db845c. I
> > could trigger it twice in 5 reboots and it always crash at the same
> > point during the boot process. Reverting this patch fixes the crash.
> >
> > I'm happy to test run any debug patche(s), that would help narrow
> > down this breakage.
>
> Cc'ing Robin, maybe he has a better idea (that's commit c44094eee32f).
> Architecturally the change shouldn't make any difference since the cache
> lines can be brought in via the linear mapping at any point. It's just
> less likely to hit a real bug (software or hardware). It's also possible
> that arch_dma_prep_coherent() is used outside the DMA API (if you have
> out of tree drivers).

Hi Catalin,

I can reproduce this crash on vanilla v6.1-rc1 as well with no
out-of-tree drivers.

>
> Leaving the original log in place for Robin. A question I have, with a
> successful boot, what's normally after the bpfloader lines are printed?
> We should try to pinpoint which device/driver causes this. It looks like
> it's well into user-space at that point (graphics about to start?)
>

Yes the device is well into user-space at this point with file-system
mounted. And it always crashes while it is busy bringing up remoteproc
(modem) and running bpf programs.

[   19.535003][    T1] init: starting service 'tqftpserv'...
[   19.579617][    T1] init: starting service 'rmtfs'...
[   19.588578][    T1] init: processing action (load_bpf_programs)
from (/system/etc/init/bpfloader.rc:17)
[   19.596465][  T456] remoteproc remoteproc0: powering up 4080000.remoteproc
[   19.600240][    T1] init: starting service 'bpfloader'...
[   19.608071][  T456] remoteproc remoteproc0: Booting fw image
qcom/sdm845/mba.mbn, size 242400
[   19.616901][    T1] init: SVC_EXEC service 'bpfloader' pid 457 (uid
0 gid 0+7 context default) started; waiting...
[   19.699862][  T457] bpfloader:
/apex/com.android.tethering/etc/flag/out-of-process exists.
[   19.710798][  T457] LibBpfLoader: Section bpfloader_min_ver value is 2 [0x2]
[   19.717980][  T457] LibBpfLoader: Section bpfloader_max_ver value
is 25 [0x19]
[   19.725375][  T457] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   19.732806][  T456] qcom-q6v5-mss 4080000.remoteproc: MBA booted
without debug policy, loading mpss
[   19.732996][  T457] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   19.749603][  T457] LibBpfLoader: BpfLoader version 0x0001c
ignoring ELF object /apex/com.android.tethering/etc/bpf/test.o with
max ver 0x00019
[   19.762621][  T457] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/test.o
        <... ...crash and reboot into bootloader here... ...>


In case of a successful boot, bpfloader exits successfully, modem
boots up fine and standard AOSP services start kicking in.

[   19.242267][    T1] init: starting service 'tqftpserv'...
[   19.272100][    T1] init: starting service 'rmtfs'...
[   19.280426][    T1] init: processing action (load_bpf_programs)
from (/system/etc/init/bpfloader.rc:17)
[   19.288715][  T448] remoteproc remoteproc0: powering up 4080000.remoteproc
[   19.290737][    T1] init: starting service 'bpfloader'...
[   19.299421][  T448] remoteproc remoteproc0: Booting fw image
qcom/sdm845/mba.mbn, size 242400
[   19.306169][    T1] init: SVC_EXEC service 'bpfloader' pid 449 (uid
0 gid 0+7 context default) started; waiting...
[   19.325297][  T449] bpfloader:
/apex/com.android.tethering/etc/flag/out-of-process exists.
[   19.335554][  T449] LibBpfLoader: Section bpfloader_min_ver value is 2 [0x2]
[   19.342773][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 25 [0x19]
[   19.350194][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   19.357886][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   19.365476][  T449] LibBpfLoader: BpfLoader version 0x0001c
ignoring ELF object /apex/com.android.tethering/etc/bpf/test.o with
max ver 0x00019
[   19.378519][  T449] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/test.o
[   19.391515][  T449] LibBpfLoader: Section bpfloader_min_ver value is 2 [0x2]
[   19.397239][  T448] qcom-q6v5-mss 4080000.remoteproc: MBA booted
without debug policy, loading mpss
[   19.398678][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 25 [0x19]
[   19.415184][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   19.422825][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   19.430424][  T449] LibBpfLoader: BpfLoader version 0x0001c
ignoring ELF object /apex/com.android.tethering/etc/bpf/offload.o with
max ver 0x00019
[   19.443723][  T449] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/offload.o
[   19.453137][  T449] LibBpfLoader: Section bpfloader_min_ver value
is 25 [0x19]
[   19.460494][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   19.468349][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   19.475903][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   19.483450][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object /apex/com.android.tethering/etc/bpf/test@btf.o
with ver [0x00019,0x10000)
[   19.527906][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_test_tether_downstream6_map id 1
[   19.536802][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_test_bitmap id 2
[   19.545451][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_test_xdp_drop_ipv4_udp_ether id 1
[   19.554598][  T449] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/test@btf.o
[   19.565372][  T449] LibBpfLoader: Section bpfloader_min_ver value
is 25 [0x19]
[   19.572672][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   19.580511][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   19.588069][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   19.595611][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object
/apex/com.android.tethering/etc/bpf/offload@btf.o with ver
[0x00019,0x10000)
[   19.629859][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_error_map id 3
[   19.636219][  T448] remoteproc remoteproc0: remote processor
4080000.remoteproc is now up
[   19.646726][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_stats_map id 4
[   19.646817][  T448] rmtfs (448) used greatest stack depth: 9952 bytes left
[   19.662274][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_limit_map id 5
[   19.670941][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_downstream6_map id 6
[   19.680189][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_downstream64_map id 7
[   19.689463][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_upstream6_map id 8
[   19.698492][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_downstream4_map id 9
[   19.707692][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_upstream4_map id 10
[   19.762291][  T449] LibBpfLoader: map
/sys/fs/bpf/tethering/map_offload_tether_dev_map id 11
[   19.781943][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_schedcls_tether_downstream6_ether
id 2
[   19.793483][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_schedcls_tether_upstream6_ether id
3
[   19.804834][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_schedcls_tether_downstream6_rawip
id 4
[   19.816326][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_schedcls_tether_upstream6_rawip id
5
[   19.828262][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_schedcls_tether_downstream4_rawip
id 6
[   19.840313][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_schedcls_tether_upstream4_rawip id
7
[   19.852089][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_schedcls_tether_downstream4_ether
id 8
[   19.864041][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_schedcls_tether_upstream4_ether id
9
[   19.875042][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_xdp_tether_downstream_ether id 10
[   19.885521][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_xdp_tether_downstream_rawip id 11
[   19.896037][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_xdp_tether_upstream_ether id 12
[   19.906437][  T449] LibBpfLoader: prog
/sys/fs/bpf/tethering/prog_offload_xdp_tether_upstream_rawip id 13
[   19.916186][  T449] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/offload@btf.o
[   19.927346][  T449] LibBpfLoader: Section bpfloader_min_ver value is 13 [0xd]
[   19.934578][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   19.942419][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   19.949981][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   19.957519][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object
/apex/com.android.tethering/etc/bpf/netd_shared/netd.o with ver
[0x0000d,0x10000)
[   19.981108][  T449] LibBpfLoader: map configuration_map
selinux_context [fs_bpf_netd_readonly            ] -> 5 ->
'fs_bpf_netd_readonly' (netd_readonly/)
[   19.995188][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_configuration_map id 12
[   20.004173][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_cookie_tag_map id 13
[   20.012604][  T449] LibBpfLoader: map uid_counterset_map
selinux_context [fs_bpf_net_shared               ] -> 4 ->
'fs_bpf_net_shared' (net_shared/)
[   20.026214][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_uid_counterset_map id 14
[   20.034984][  T449] LibBpfLoader: map app_uid_stats_map
selinux_context [fs_bpf_net_shared               ] -> 4 ->
'fs_bpf_net_shared' (net_shared/)
[   20.048710][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_app_uid_stats_map id 15
[   20.057599][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_stats_map_A id 16
[   20.065765][  T449] LibBpfLoader: map stats_map_B selinux_context
[fs_bpf_netd_readonly            ] -> 5 -> 'fs_bpf_netd_readonly'
(netd_readonly/)
[   20.079363][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_stats_map_B id 17
[   20.087521][  T449] LibBpfLoader: map iface_stats_map
selinux_context [fs_bpf_net_shared               ] -> 4 ->
'fs_bpf_net_shared' (net_shared/)
[   20.100823][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_iface_stats_map id 18
[   20.109330][  T449] LibBpfLoader: map uid_owner_map selinux_context
[fs_bpf_net_shared               ] -> 4 -> 'fs_bpf_net_shared'
(net_shared/)
[   20.122473][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_uid_owner_map id 19
[   20.130897][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_uid_permission_map id 20
[   20.139676][  T449] LibBpfLoader: map iface_index_name_map
selinux_context [fs_bpf_net_shared               ] -> 4 ->
'fs_bpf_net_shared' (net_shared/)
[   20.153413][  T449] LibBpfLoader: map
/sys/fs/bpf/netd_shared/map_netd_iface_index_name_map id 21
[   20.163738][  T449] LibBpfLoader: prog cgroupskb_ingress_stats
selinux_context [fs_bpf_netd_readonly            ] -> 5 ->
'fs_bpf_netd_readonly' (netd_readonly/)
[   20.180672][  T449] LibBpfLoader: prog
/sys/fs/bpf/netd_shared/prog_netd_cgroupskb_ingress_stats id 14
[   20.190075][  T449] LibBpfLoader: prog cgroupskb_egress_stats
selinux_context [fs_bpf_netd_readonly            ] -> 5 ->
'fs_bpf_netd_readonly' (netd_readonly/)
[   20.206105][  T449] LibBpfLoader: prog
/sys/fs/bpf/netd_shared/prog_netd_cgroupskb_egress_stats id 15
[   20.216274][  T449] LibBpfLoader: prog
/sys/fs/bpf/netd_shared/prog_netd_skfilter_egress_xtbpf id 16
[   20.226376][  T449] LibBpfLoader: prog
/sys/fs/bpf/netd_shared/prog_netd_skfilter_ingress_xtbpf id 17
[   20.235683][  T449] LibBpfLoader: prog schedact_ingress_account
selinux_context [fs_bpf_net_shared               ] -> 4 ->
'fs_bpf_net_shared' (net_shared/)
[   20.250698][  T449] LibBpfLoader: prog
/sys/fs/bpf/netd_shared/prog_netd_schedact_ingress_account id 18
[   20.261050][  T449] LibBpfLoader: prog
/sys/fs/bpf/netd_shared/prog_netd_skfilter_allowlist_xtbpf id 19
[   20.271359][  T449] LibBpfLoader: prog
/sys/fs/bpf/netd_shared/prog_netd_skfilter_denylist_xtbpf id 20
[   20.280757][  T449] LibBpfLoader: prog cgroupsock_inet_create
selinux_context [fs_bpf_netd_readonly            ] -> 5 ->
'fs_bpf_netd_readonly' (netd_readonly/)
[   20.296020][  T449] LibBpfLoader: prog
/sys/fs/bpf/netd_shared/prog_netd_cgroupsock_inet_create id 21
[   20.305386][  T449] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/netd_shared/netd.o
[   20.315965][  T449] LibBpfLoader: Section bpfloader_min_ver value is 13 [0xd]
[   20.323187][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   20.331029][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   20.338590][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   20.346129][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object
/apex/com.android.tethering/etc/bpf/net_shared/dscpPolicy.o with ver
[0x0000d,0x10000)
[   20.368275][  T449] LibBpfLoader: map
/sys/fs/bpf/net_shared/map_dscpPolicy_socket_policy_cache_map id 22
[   20.377973][  T449] LibBpfLoader: map
/sys/fs/bpf/net_shared/map_dscpPolicy_ipv4_dscp_policies_map id 23
[   20.387561][  T449] LibBpfLoader: map
/sys/fs/bpf/net_shared/map_dscpPolicy_ipv6_dscp_policies_map id 24
[   20.410850][  T449] LibBpfLoader: prog
/sys/fs/bpf/net_shared/prog_dscpPolicy_schedcls_set_dscp_ether id 22
[   20.420760][  T449] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/net_shared/dscpPolicy.o
[   20.432580][  T449] LibBpfLoader: Section bpfloader_min_ver value is 13 [0xd]
[   20.439803][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   20.447640][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   20.455200][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   20.462739][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object
/apex/com.android.tethering/etc/bpf/net_shared/block.o with ver
[0x0000d,0x10000)
[   20.505305][  T449] LibBpfLoader: map
/sys/fs/bpf/net_shared/map_block_blocked_ports_map id 25
[   20.515150][  T449] LibBpfLoader: prog
/sys/fs/bpf/net_shared/prog_block_bind4_block_port id 23
[   20.524754][  T449] LibBpfLoader: prog
/sys/fs/bpf/net_shared/prog_block_bind6_block_port id 24
[   20.533575][  T449] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/net_shared/block.o
[   20.544256][  T449] LibBpfLoader: Section bpfloader_min_ver value is 13 [0xd]
[   20.551477][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   20.559313][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   20.566875][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   20.574412][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object
/apex/com.android.tethering/etc/bpf/net_shared/clatd.o with ver
[0x0000d,0x10000)
[   20.617474][  T449] LibBpfLoader: map
/sys/fs/bpf/net_shared/map_clatd_clat_ingress6_map id 26
[   20.626210][  T449] LibBpfLoader: map
/sys/fs/bpf/net_shared/map_clatd_clat_egress4_map id 27
[   20.636225][  T449] LibBpfLoader: prog
/sys/fs/bpf/net_shared/prog_clatd_schedcls_ingress6_clat_ether id 25
[   20.647124][  T449] LibBpfLoader: prog
/sys/fs/bpf/net_shared/prog_clatd_schedcls_ingress6_clat_rawip id 26
[   20.657696][  T449] LibBpfLoader: prog
/sys/fs/bpf/net_shared/prog_clatd_schedcls_egress4_clat_ether id 27
[   20.668425][  T449] LibBpfLoader: prog
/sys/fs/bpf/net_shared/prog_clatd_schedcls_egress4_clat_rawip id 28
[   20.678202][  T449] bpfloader: Loaded object:
/apex/com.android.tethering/etc/bpf/net_shared/clatd.o
[   20.703175][  T449] LibBpfLoader: Section bpfloader_min_ver value
is 28 [0x1c]
[   20.710475][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   20.718306][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   20.725864][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   20.733404][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object /system/etc/bpf/gpuWork.o with ver
[0x0001c,0x10000)
[   20.746152][  T449] LibBpfLoader: map
/sys/fs/bpf/map_gpuWork_gpu_work_map id 28
[   20.753644][  T449] LibBpfLoader: map
/sys/fs/bpf/map_gpuWork_gpu_work_global_data id 29
[   20.762876][  T449] LibBpfLoader: prog
/sys/fs/bpf/prog_gpuWork_tracepoint_power_gpu_work_period id 29
[   20.772275][  T449] bpfloader: Loaded object: /system/etc/bpf/gpuWork.o
[   20.779516][  T449] LibBpfLoader: Section bpfloader_min_ver value
is 28 [0x1c]
[   20.786846][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   20.794688][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   20.802245][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   20.809784][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object /system/etc/bpf/gpuMem.o with ver
[0x0001c,0x10000)
[   20.849720][  T449] LibBpfLoader: map
/sys/fs/bpf/map_gpuMem_gpu_mem_total_map id 30
[   20.858655][  T449] LibBpfLoader: prog
/sys/fs/bpf/prog_gpuMem_tracepoint_gpu_mem_gpu_mem_total id 30
[   20.867977][  T449] bpfloader: Loaded object: /system/etc/bpf/gpuMem.o
[   20.874900][  T449] LibBpfLoader: Section bpfloader_min_ver value
is 28 [0x1c]
[   20.882196][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   20.890031][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   20.897583][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   20.905124][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object /system/etc/bpf/fuseMedia.o with ver
[0x0001c,0x10000)
[   20.917800][  T449] LibBpfLoader: No maps section could be found in
elf object
[   20.925097][  T449] bpfloader: Loaded object: /system/etc/bpf/fuseMedia.o
[   20.932463][  T449] LibBpfLoader: Section bpfloader_min_ver value
is 28 [0x1c]
[   20.939774][  T449] LibBpfLoader: Section bpfloader_max_ver value
is 65536 [0x10000]
[   20.947610][  T449] LibBpfLoader: Section size_of_bpf_map_def value
is 120 [0x78]
[   20.955166][  T449] LibBpfLoader: Section size_of_bpf_prog_def
value is 92 [0x5c]
[   20.962702][  T449] LibBpfLoader: BpfLoader version 0x0001c
processing ELF object /system/etc/bpf/timeInState.o with ver
[0x0001c,0x10000)
[   20.982983][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_total_time_in_state_map id 31
[   20.992893][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_uid_time_in_state_map id 32
[   21.002295][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_uid_concurrent_times_map id 33
[   21.011230][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_uid_last_update_map id 34
[   21.019706][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_cpu_last_update_map id 35
[   21.028159][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_cpu_last_pid_map id 36
[   21.036347][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_cpu_policy_map id 37
[   21.044356][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_policy_freq_idx_map id 38
[   21.052856][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_freq_to_idx_map id 39
[   21.060973][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_nr_active_map id 40
[   21.068895][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_policy_nr_active_map id 41
[   21.077437][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_pid_tracked_hash_map id 42
[   21.085969][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_pid_tracked_map id 43
[   21.094099][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_pid_task_aggregation_map id 44
[   21.103893][  T449] LibBpfLoader: map
/sys/fs/bpf/map_timeInState_pid_time_in_state_map id 45
[   21.116868][  T449] LibBpfLoader: prog
/sys/fs/bpf/prog_timeInState_tracepoint_sched_sched_switch id 31
[   21.127324][  T449] LibBpfLoader: prog
/sys/fs/bpf/prog_timeInState_tracepoint_power_cpu_frequency id 32
[   21.137979][  T449] LibBpfLoader: prog
/sys/fs/bpf/prog_timeInState_tracepoint_sched_sched_process_free id 33
[   21.148047][  T449] bpfloader: Loaded object: /system/etc/bpf/timeInState.o
[   21.157656][    T1] init: Service 'bpfloader' (pid 449) exited with
status 0 waiting took 1.853000 seconds
[   21.167396][    T1] init: Sending signal 9 to service 'bpfloader'
(pid 449) process group...
[   21.176037][    T1] libprocessgroup: Successfully killed process
cgroup uid 0 pid 449 in 0ms
[   21.186578][    T1] init: processing action
(ro.crypto.state=encrypted && ro.crypto.type=file && zygote-start)
from (/system/etc/init/hw/init.rc:1060)
[   21.200189][    T1] init:
start_waiting_for_property("odsign.verification.done", "1"): already
set
[   21.209345][    T1] init: Command 'exec_start
update_verifier_nonencrypted' action=ro.crypto.state=encrypted &&
ro.crypto.type=file && zygote-start (/system/etc/init/hw/init.rc:1063)
took 0ms and failed: Service not found
[   21.231829][    T1] init: starting service 'statsd'...
[   21.237303][    T1] init: Created socket '/dev/socket/statsdw',
mode 222, user 1066, group 1066
[   21.260054][    T1] init: starting service 'netd'...
[   21.265386][    T1] init: Created socket '/dev/socket/dnsproxyd',
mode 660, user 0, group 3003
[   21.274241][    T1] init: Created socket '/dev/socket/mdns', mode
660, user 0, group 1000
[   21.282628][    T1] init: Created socket '/dev/socket/fwmarkd',
mode 660, user 0, group 3003
[   21.294432][    T1] init: starting service 'zygote'...
[   21.299968][    T1] init: Created socket '/dev/socket/zygote', mode
660, user 0, group 1000
[   21.308548][    T1] init: Created socket
'/dev/socket/usap_pool_primary', mode 660, user 0, group 1000
[   21.320892][    T1] init: starting service 'zygote_secondary'...
[   21.327157][    T1] init: Created socket
'/dev/socket/zygote_secondary', mode 660, user 0, group 1000
[   21.336591][    T1] init: Created socket
'/dev/socket/usap_pool_secondary', mode 660, user 0, group 1000
[   21.348788][    T1] init: processing action (zygote-start) from
(/vendor/etc/init/init.db845c.rc:38)
[   21.360963][    T1] init: processing action
(firmware_mounts_complete) from (/system/etc/init/hw/init.rc:513)
[   21.371050][    T1] init: processing action (early-boot) from
(/system/etc/init/installd.rc:5)
[   21.385885][    T1] init: processing action (early-boot) from
(/vendor/etc/init/init.db845c.rc:30)
[   21.395343][    T1] init: Command 'mount debugfs debugfs
/sys/kernel/debug' action=early-boot
(/vendor/etc/init/init.db845c.rc:31) took 0ms and failed: mount()
failed: Device or resource busy
[   21.413899][    T1] init: processing action (boot) from
(/system/etc/init/hw/init.rc:1074)
[   21.424621][    T1] init: Command 'write
/dev/sys/block/by-name/rootdisk/queue/discard_max_bytes 134217728'
action=boot (/system/etc/init/hw/init.rc:1120) took 0ms and failed:
Unable to write to file
'/dev/sys/block/by-name/rootdisk/queue/discard_max_bytes': open()
failed: Permission denied
[   21.424733][  T336] type=1400 audit(27.187:4): avc: denied { write
} for comm="init" name="discard_max_bytes" dev="sysfs" ino=40490
scontext=u:r:init:s0 tcontext=u:object_r:sysfs:s0 tclass=file
permissive=0
[   21.451424][    T1] init: Command 'verity_update_state' action=boot
(/system/etc/init/hw/init.rc:1179) took 0ms and failed:
fs_mgr_load_verity_state() failed
[   21.483352][    T1] init: starting service 'hidl_memory'...
[   21.506462][    T1] init: starting service 'vendor.audio-hal'...
[   21.515157][    T1] init: starting service 'btlinux-1.1'...
[   21.544305][    T1] init: starting service
'vendor.camera-provider-2-4-ext'...
[   21.554697][    T1] init: starting service 'vendor.cas-hal-1-2'...
[   21.563521][    T1] init: starting service 'vendor.gatekeeper-1-0'...
[   21.572369][    T1] init: starting service 'vendor.graphics.allocator-4-0'...
[   21.581826][    T1] init: starting service 'vendor.hwcomposer-2-3'...
[   21.590550][    T1] init: starting service 'health-hal-2-1'...
[   21.598974][    T1] init: starting service 'vendor.power-default'...
[   21.607702][    T1] init: starting service 'vendor.power.stats-default'...
[   21.616988][    T1] init: Command 'class_start hal' action=boot
(/system/etc/init/hw/init.rc:1182) took 133ms and succeeded
[   21.628257][    T1] init: service 'ueventd' requested start, but it
is already running (flags: 2084)
[   21.637473][    T1] init: service 'console' requested start, but it
is already running (flags: 148)
[   21.641487][  T489] healthd: No battery devices found
[   21.643265][  T487] msm_dpu ae01000.display-controller:
[drm:adreno_request_fw [msm]] loaded qcom/a630_sqe.fw from new
location
[   21.646597][    T1] init: service 'apexd' requested start, but it
is already running (flags: 134)
[   21.646810][    T1] init: starting service 'audioserver'...
[   21.649530][  T487] msm_dpu ae01000.display-controller:
[drm:adreno_request_fw [msm]] loaded qcom/a630_gmu.bin from new
location
[   21.654333][  T489] healthd: battery l=85 v=3600 t=35.0 h=2 st=2 chg=au
[   21.665741][    T1] init: starting service 'credstore'...
[   21.724265][    T1] init: starting service 'gpu'...
[   21.731719][    T1] init: service 'lmkd' requested start, but it is
already running (flags: 36)
[   21.740534][    T1] init: service 'servicemanager' requested start,
but it is already running (flags: 2084)
[   21.750640][    T1] init: starting service 'surfaceflinger'...
[   21.756734][    T1] init: Could not create socket
'pdx/system/vr/display/client': Failed to bind socket
'pdx/system/vr/display/client': No such file or directory
[   21.771622][    T1] init: Could not create socket
'pdx/system/vr/display/manager': Failed to bind socket
'pdx/system/vr/display/manager': No such file or directory
[   21.786631][    T1] init: Could not create socket
'pdx/system/vr/display/vsync': Failed to bind socket
'pdx/system/vr/display/vsync': No such file or directory
[   21.827039][    T1] init: service 'vold' requested start, but it is
already running (flags: 2052)
[   21.836014][    T1] init: service 'qrtr-ns' requested start, but it
is already running (flags: 134)
[   21.845138][    T1] init: service 'pd_mapper' requested start, but
it is already running (flags: 134)
[   21.854438][    T1] init: service 'tqftpserv' requested start, but
it is already running (flags: 134)
[   21.863743][    T1] init: service 'rmtfs' requested start, but it
is already running (flags: 134)
[   21.872708][    T1] init: Command 'class_start core' action=boot
(/system/etc/init/hw/init.rc:1184) took 244ms and succeeded
[   21.884040][    T1] init: processing action
(persist.sys.usb.config=* && boot) from
(/system/etc/init/hw/init.usb.rc:108)
[   21.895504][    T1] init: processing action (boot) from
(/system/etc/init/dumpstate.rc:1)
[   21.903868][    T1] init: processing action (boot) from
(/system/etc/init/gsid.rc:25)
[   21.908105][   T11] ath10k_snoc 18800000.wifi: qmi chip_id 0x30214
chip_family 0x4001 board_id 0xff soc_id 0x40030001
[   21.912021][    T1] init: starting service 'exec 15
(/system/bin/gsid run-startup-tasks)'...
[   21.922451][   T11] ath10k_snoc 18800000.wifi: qmi fw_version
0x2009856b fw_build_timestamp 2018-07-19 12:28 fw_build_id
QC_IMAGE_VERSION_STRING=WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1
[   21.948810][    T1] init: processing action
(persist.device_config.profcollect_native_boot.enabled= && boot) from
(/system/etc/init/profcollectd.rc:19)
[   21.962718][    T1] init: starting service 'exec 16
(/system/bin/profcollectctl reset)'...
[   21.972858][    T1] init: processing action (boot) from
(/vendor/etc/init/init.db845c.usb.rc:1)
[   21.981877][    T1] init: Command 'mount configfs none /config'
action=boot (/vendor/etc/init/init.db845c.usb.rc:2) took 0ms and
failed: mount() failed: Device or resource busy
[   22.000190][    T1] init: Service 'exec 15 (/system/bin/gsid
run-startup-tasks)' (pid 522) exited with status 0 oneshot service
took 0.052000 seconds in background
[   22.014936][    T1] init: Sending signal 9 to service 'exec 15
(/system/bin/gsid run-startup-tasks)' (pid 522) process group...
[   22.026605][    T1] libprocessgroup: Successfully killed process
cgroup uid 0 pid 522 in 0ms
[   22.039827][  T263] file system registered
[   22.058523][    T1] init: processing action
(enable_property_trigger) from (<Builtin Action>:0)
[   22.067632][    T1] init: processing action (apexd.status=ready &&
ro.product.cpu.abilist32=*) from (/system/etc/init/hw/init.rc:484)
[   22.082698][    T1] init: starting service 'boringssl_self_test_apex32'...
[   22.092119][    T1] init: SVC_EXEC service
'boringssl_self_test_apex32' pid 528 (uid 0 gid 0+0 context default)
started; waiting...
[   22.308290][  T336] type=1400 audit(28.071:5): avc: denied { read }
for comm="composer@2.3-se" name="u:object_r:vendor_hw_prop:s0"
dev="tmpfs" ino=298 scontext=u:r:hal_graphics_composer_default:s0
tcontext=u:object_r:vendor_hw_prop:s0 tclass=file permissive=0
[   22.335281][    T1] init: Service 'boringssl_self_test_apex32' (pid
528) exited with status 0 waiting took 0.244000 seconds
[   22.346515][    T1] init: Sending signal 9 to service
'boringssl_self_test_apex32' (pid 528) process group...
[   22.356615][    T1] libprocessgroup: Successfully killed process
cgroup uid 0 pid 528 in 0ms
[   22.366335][    T1] init: processing action (apexd.status=ready &&
ro.product.cpu.abilist64=*) from (/system/etc/init/hw/init.rc:486)
[   22.378727][    T1] init: starting service 'boringssl_self_test_apex64'...
[   22.403204][    T1] init: SVC_EXEC service
'boringssl_self_test_apex64' pid 539 (uid 0 gid 0+0 context default)
started; waiting...
[   22.473464][    T1] init: Service 'boringssl_self_test_apex64' (pid
539) exited with status 0 waiting took 0.086000 seconds
[   22.484721][    T1] init: Sending signal 9 to service
'boringssl_self_test_apex64' (pid 539) process group...
[   22.494858][    T1] libprocessgroup: Successfully killed process
cgroup uid 0 pid 539 in 0ms
[   22.504380][    T1] init: processing action (bootreceiver.enable=1
&& ro.product.cpu.abilist64=*) from (/system/etc/init/hw/init.rc:657)
[   22.561656][    T1] init: Service 'exec 16
(/system/bin/profcollectctl reset)' (pid 523) exited with status 0
oneshot service took 0.589000 seconds in background
[   22.576223][    T1] init: Sending signal 9 to service 'exec 16
(/system/bin/profcollectctl reset)' (pid 523) process group...
[   22.587719][    T1] libprocessgroup: Successfully killed process
cgroup uid 0 pid 523 in 0ms
[   22.598544][    T1] init: processing action
(net.tcp_def_init_rwnd=*) from (/system/etc/init/hw/init.rc:1214)
[   22.608696][    T1] init: processing action
(sys.init.perf_lsm_hooks=1) from (/system/etc/init/hw/init.rc:1225)
[   22.614735][  T336] type=1400 audit(28.371:6): avc: denied { read }
for comm="composer@2.3-se" name="u:object_r:vendor_hw_prop:s0"
dev="tmpfs" ino=298 scontext=u:r:hal_graphics_composer_default:s0
tcontext=u:object_r:vendor_hw_prop:s0 tclass=file permissive=0
[   22.619036][    T1] init: processing action
(security.perf_harden=1) from (/system/etc/init/hw/init.rc:1239)
[   22.652295][    T1] init: processing action (ro.debuggable=1) from
(/system/etc/init/hw/init.rc:1274)
[   22.661766][    T1] init: processing action (sys.usb.config=adb &&
sys.usb.configfs=1) from (/system/etc/init/hw/init.usb.configfs.rc:17)
[   22.675031][    T1] init: starting service 'adbd'...
[   22.680343][    T1] init: Created socket '/dev/socket/adbd', mode
660, user 1000, group 1000
[   22.707151][    T1] init: processing action
(init.svc.audioserver=running) from
(/system/etc/init/audioserver.rc:35)
[   22.717816][    T1] init: service 'vendor.audio-hal' requested
start, but it is already running (flags: 4)
[   22.727591][    T1] init: Command 'start vendor.audio-hal-aidl'
action=init.svc.audioserver=running
(/system/etc/init/audioserver.rc:37) took 0ms and failed: service
vendor.audio-hal-aidl not found
[   22.745277][    T1] init: Command 'start
vendor.audio-effect-hal-aidl' action=init.svc.audioserver=running
(/system/etc/init/audioserver.rc:38) took 0ms and failed: service
vendor.audio-effect-hal-aidl not found
[   22.764197][    T1] init: Command 'start vendor.audio-hal-4-0-msd'
action=init.svc.audioserver=running
(/system/etc/init/audioserver.rc:39) took 0ms and failed: service
vendor.audio-hal-4-0-msd not found
[   22.782408][    T1] init: Command 'start audio_proxy_service'
action=init.svc.audioserver=running
(/system/etc/init/audioserver.rc:40) took 0ms and failed: service
audio_proxy_service not found
[   22.788406][  T544] read descriptors
[   22.799739][    T1] init: processing action
(ro.persistent_properties.ready=true) from
(/system/etc/init/bootstat.rc:66)
[   22.800153][    T1] init: processing action
(ro.persistent_properties.ready=true) from
(/system/etc/init/bootstat.rc:70)
[   22.803356][  T544] read strings
[   22.814550][    T1] init: starting service 'exec 17
(/system/bin/bootstat --set_system_boot_reason)'...
[   22.839864][    T1] init: processing action (bootreceiver.enable=1
&& ro.product.cpu.abilist64=*) from (/system/etc/init/dmesgd.rc:3)
[   22.852852][    T1] init: Command 'rm
/data/misc/dmesgd/sent_reports.txt' action=bootreceiver.enable=1 &&
ro.product.cpu.abilist64=* (/system/etc/init/dmesgd.rc:5) took 0ms and
failed: unlink() failed: No such file or directory
[   22.873188][    T1] init: processing action
(persist.heapprofd.enable= && traced.lazy.heapprofd=) from
(/system/etc/init/heapprofd.rc:49)
[   22.891868][    T1] init: processing action (ro.debuggable=1) from
(/system/etc/init/llkd-debuggable.rc:1)
[   22.902003][    T1] init: Service 'exec 17 (/system/bin/bootstat
--set_system_boot_reason)' (pid 547) exited with status 0 oneshot
service took 0.062000 seconds in background
[   22.917699][    T1] init: Sending signal 9 to service 'exec 17
(/system/bin/bootstat --set_system_boot_reason)' (pid 547) process
group...
[   22.930359][    T1] libprocessgroup: Successfully killed process
cgroup uid 1000 pid 547 in 0ms
[   22.939654][    T1] init: processing action (ro.debuggable=*) from
(/system/etc/init/llkd.rc:2)
[   22.949027][    T1] init: processing action
(debug.atrace.user_initiated= && persist.traced.enable=1) from
(/system/etc/init/perfetto.rc:47)
[   22.962061][    T1] init: starting service 'traced_probes'...
[   23.010308][    T1] init: processing action
(persist.traced.enable=1) from (/system/etc/init/perfetto.rc:50)
[   23.021462][    T1] init: starting service 'traced'...
[   23.026878][    T1] init: Created socket
'/dev/socket/traced_consumer', mode 666, user 0, group 0
[   23.035956][    T1] init: Created socket
'/dev/socket/traced_producer', mode 666, user 0, group 0
[   23.051235][    T1] init: service 'traced_probes' requested start,
but it is already running (flags: 132)
[   23.060954][    T1] init: processing action
(ro.persistent_properties.ready=true) from
(/system/etc/init/perfetto.rc:116)
[   23.072054][    T1] init: processing action
(persist.traced_perf.enable= && sys.init.perf_lsm_hooks=1 &&
traced.lazy.traced_perf=) from (/system/etc/init/traced_perf.rc:43)
[   23.088097][    T1] init: processing action
(vendor.usb.controller=*) from
(/vendor/etc/init/init.db845c.usb.rc:35)
[   23.099397][    T1] init: processing action (sys.usb.config=adb &&
sys.usb.configfs=1) from (/vendor/etc/init/init.db845c.usb.rc:67)
[   23.112391][    T1] init: processing action (nonencrypted) from
(/system/etc/init/hw/init.rc:1186)
[   23.117923][  T336] type=1400 audit(28.879:7): avc: denied { read }
for comm="composer@2.3-se" name="u:object_r:vendor_hw_prop:s0"
dev="tmpfs" ino=298 scontext=u:r:hal_graphics_composer_default:s0
tcontext=u:object_r:vendor_hw_prop:s0 tclass=file permissive=0
[   23.121464][    T1] init: service 'zygote_secondary' requested
start, but it is already running (flags: 4)
[   23.154401][    T1] init: service 'zygote' requested start, but it
is already running (flags: 4)
[   23.163563][    T1] init: starting service 'cameraserver'...
[   23.172550][    T1] init: starting service 'idmap2d'...
[   23.198923][    T1] init: starting service 'incidentd'...
[   23.206893][    T1] init: starting service 'installd'...
[   23.214605][    T1] init: starting service 'mediaextractor'...
[   23.223087][    T1] init: starting service 'mediametrics'...
[   23.231354][    T1] init: starting service 'media'...
[   23.238907][    T1] init: service 'netd' requested start, but it is
already running (flags: 4)
[   23.247824][    T1] init: starting service 'storaged'...
[   23.253312][    T1] init: Could not open file
'/d/mmc0/mmc0:0001/ext_csd': Failed to open file
'/d/mmc0/mmc0:0001/ext_csd': No such file or directory
[   23.269187][    T1] init: starting service 'wificond'...
[   23.277087][    T1] init: starting service 'vendor.media.omx'...
[   23.298553][    T1] init: starting service 'media.swcodec'...
[   23.307278][    T1] init: service 'statsd' requested start, but it
is already running (flags: 4)
[   23.316300][    T1] init: Command 'class_start main'
action=nonencrypted (/system/etc/init/hw/init.rc:1187) took 194ms and
succeeded
[   23.328685][    T1] init: starting service 'gatekeeperd'...
[   23.337437][    T1] init: service 'traced' requested start, but it
is already running (flags: 132)
[   23.338293][  T336] type=1400 audit(29.103:8): avc: denied { read }
for comm="storaged" name="stat" dev="sysfs" ino=40456
scontext=u:r:storaged:s0 tcontext=u:object_r:sysfs:s0 tclass=file
permissive=0
[   23.346654][    T1] init: service 'traced_probes' requested start,
but it is already running (flags: 132)
[   23.374381][    T1] init: starting service 'usbd'...
[   23.406482][    T1] init: Command 'class_start late_start'
action=nonencrypted (/system/etc/init/hw/init.rc:1188) took 77ms and
succeeded
[   23.415373][  T474] wsa881x-codec sdw:0:0217:2010:00:1: ASoC: error
at soc_component_read_no_lock on sdw:0:0217:2010:00:1 for register:
[0x0000312d] -16
[   23.419298][    T1] init: starting service 'bootanim'...
[   23.432850][  T474] wsa881x-codec sdw:0:0217:2010:00:1: ASoC: error
at soc_component_read_no_lock on sdw:0:0217:2010:00:1 for register:
[0x0000311b] -16
[   23.442000][    T1] init: Control message: Processed ctl.start for
'bootanim' from pid: 510 (/system/bin/surfaceflinger)
[   23.452050][  T474] wsa881x-codec sdw:0:0217:2010:00:2: ASoC: error
at soc_component_read_no_lock on sdw:0:0217:2010:00:2 for register:
[0x0000312d] -16
[   23.463322][    T1] init: processing action
(load_persist_props_action) from
(/system/etc/init/flags_health_check.rc:1)
[   23.476596][  T474] wsa881x-codec sdw:0:0217:2010:00:2: ASoC: error
at soc_component_read_no_lock on sdw:0:0217:2010:00:2 for register:
[0x0000311b] -16
[   23.488181][    T1] init: Encryption policy of
/data/server_configurable_flags set to
f4f3260e5a1591680b49745bca448896 v2 modes 1/4 flags 0xa
[   23.507702][   T11] qcom,slim-ngd-ctrl 171c0000.slim: SLIM SAT:
Rcvd master capability
[   23.515794][    T1] init: Service 'usbd' (pid 600) exited with
status 0 oneshot service took 0.135000 seconds in background
[   23.533772][    T1] init: Sending signal 9 to service 'usbd' (pid
600) process group...
[   23.542016][    T1] libprocessgroup: Successfully killed process
cgroup uid 0 pid 600 in 0ms
[   23.552397][    T1] init: starting service 'exec 18
(/system/bin/flags_health_check BOOT_FAILURE)'...
[   23.601248][    T1] init: SVC_EXEC service 'exec 18
(/system/bin/flags_health_check BOOT_FAILURE)' pid 614 (uid 1000 gid
1000+0 context default) started; waiting...
[   23.616131][    T1] init: Command 'exec - system system --
/system/bin/flags_health_check BOOT_FAILURE'
action=load_persist_props_action
(/system/etc/init/flags_health_check.rc:5) took 63ms and succeeded
[   23.635210][    T1] init: Service 'exec 18
(/system/bin/flags_health_check BOOT_FAILURE)' (pid 614) exited with
status 0 waiting took 0.072000 seconds
[   23.648836][    T1] init: Sending signal 9 to service 'exec 18
(/system/bin/flags_health_check BOOT_FAILURE)' (pid 614) process
group...
[   23.661364][    T1] libprocessgroup: Successfully killed process
cgroup uid 1000 pid 614 in 0ms
[   23.670476][    T1] init: processing action
(load_persist_props_action) from (/system/etc/init/logcatd.rc:29)
[   23.682014][  T336] type=1400 audit(29.447:9): avc: denied { read }
for comm="composer@2.3-se" name="u:object_r:vendor_hw_prop:s0"
dev="tmpfs" ino=298 scontext=u:r:hal_graphics_composer_default:s0
tcontext=u:object_r:vendor_hw_prop:s0 tclass=file permissive=0
[   23.682371][    T1] init: processing action (sys.usb.config=adb &&
sys.usb.configfs=1 && sys.usb.ffs.ready=1) from
(/system/etc/init/hw/init.usb.configfs.rc:20)
[   23.727765][    T1] init: processing action (llk.enable=0) from
(/system/etc/init/llkd.rc:12)
[   23.738126][    T1] init: processing action (khungtask.enable=1)
from (/system/etc/init/llkd.rc:18)
[   23.749813][    T1] init: processing action (llk.enable=0) from
(/system/etc/init/llkd.rc:12)
[   23.758922][    T1] init: processing action (khungtask.enable=0)
from (/system/etc/init/llkd.rc:21)
[   23.769039][    T1] init: processing action (init.svc.media=*) from
(/system/etc/init/mediaserver.rc:1)
[   23.779676][    T1] init: processing action (khungtask.enable=true)
from (/system/etc/init/llkd.rc:25)
[   23.789799][    T1] init: processing action
(khungtask.enable=false) from (/system/etc/init/llkd.rc:31)
[   24.344734][  T488] lt9611 10-003b: video check: hactive_a=0,
hactive_b=0, vactive=0, v_total=0, h_total_sysclk=0
[   25.070117][  T190] ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target
0x00000008 chip_id 0x00000000 sub 0000:0000
[   25.080846][  T190] ath10k_snoc 18800000.wifi: kconfig debug 0
debugfs 0 tracing 0 dfs 0 testmode 1
[   25.089988][  T190] ath10k_snoc 18800000.wifi: firmware ver  api 5
features wowlan,mgmt-tx-by-reference,non-bmi crc32 b3d4b790
[   25.135305][  T190] ath10k_snoc 18800000.wifi: htt-ver 3.53 wmi-op
4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
[   25.229856][  T190] ath10k_snoc 18800000.wifi: invalid MAC address;
choosing random
[   26.445563][  T336] type=1400 audit(32.211:10): avc: denied { read
} for comm="binder:350_4" name="wakeup4" dev="sysfs" ino=46186
scontext=u:r:system_suspend:s0 tcontext=u:object_r:sysfs:s0 tclass=dir
permissive=0
[   26.469050][  T336] type=1400 audit(32.211:11): avc: denied { read
} for comm="binder:350_4" name="wakeup2" dev="sysfs" ino=46035
scontext=u:r:system_suspend:s0 tcontext=u:object_r:sysfs:s0 tclass=dir
permissive=0
[   26.488294][  T336] type=1400 audit(32.211:12): avc: denied { read
} for comm="binder:350_4" name="wakeup0" dev="sysfs" ino=36243
scontext=u:r:system_suspend:s0 tcontext=u:object_r:sysfs:s0 tclass=dir
permissive=0
[   26.507755][  T336] type=1400 audit(32.211:13): avc: denied { read
} for comm="binder:350_4" name="wakeup7" dev="sysfs" ino=46674
scontext=u:r:system_suspend:s0 tcontext=u:object_r:sysfs:s0 tclass=dir
permissive=0
[   26.526919][  T336] type=1400 audit(32.211:14): avc: denied { read
} for comm="binder:350_4" name="wakeup5" dev="sysfs" ino=46247
scontext=u:r:system_suspend:s0 tcontext=u:object_r:sysfs:s0 tclass=dir
permissive=0
[   26.546041][  T336] type=1400 audit(32.211:15): avc: denied { read
} for comm="binder:350_4" name="wakeup3" dev="sysfs" ino=46116
scontext=u:r:system_suspend:s0 tcontext=u:object_r:sysfs:s0 tclass=dir
permissive=0
[   26.565141][  T336] type=1400 audit(32.211:16): avc: denied { read
} for comm="binder:350_4" name="wakeup6" dev="sysfs" ino=46588
scontext=u:r:system_suspend:s0 tcontext=u:object_r:sysfs:s0 tclass=dir
permissive=0
[   27.697073][  T432] AidlLazyServiceRegistrar: Process has 1 (of 1
available) client(s) in use after notification apexservice has
clients: 1
[   27.709713][  T432] AidlLazyServiceRegistrar: Shutdown prevented by
forcePersist override flag.
[   30.354040][  T688] package-parsing (688) used greatest stack
depth: 9792 bytes left
[   30.675961][    T1] init: service 'idmap2d' requested start, but it
is already running (flags: 4)
[   30.688043][    T1] init: Control message: Processed ctl.start for
'idmap2d' from pid: 639 (system_server)
[   30.834358][  T489] healthd: battery l=85 v=3600 t=35.0 h=2 st=2 chg=au
[   31.294095][    T1] init: processing action
(sys.sysctl.extra_free_kbytes=*) from
(/system/etc/init/hw/init.rc:1205)
[   31.307317][    T1] init: starting service 'exec 19
(/system/bin/extra_free_kbytes.sh 24300)'...
[   31.337257][    T1] init: SVC_EXEC service 'exec 19
(/system/bin/extra_free_kbytes.sh 24300)' pid 726 (uid 0 gid 0+0
context default) started; waiting...
[   31.639486][    T1] init: Service 'exec 19
(/system/bin/extra_free_kbytes.sh 24300)' (pid 726) exited with status
0 waiting took 0.320000 seconds
[   31.652700][    T1] init: Sending signal 9 to service 'exec 19
(/system/bin/extra_free_kbytes.sh 24300)' (pid 726) process group...
[   31.664733][    T1] libprocessgroup: Successfully killed process
cgroup uid 0 pid 726 in 0ms
[   32.696773][  T432] AidlLazyServiceRegistrar: Process has 0 (of 1
available) client(s) in use after notification apexservice has
clients: 0
[   32.709494][  T432] AidlLazyServiceRegistrar: Shutdown prevented by
forcePersist override flag.
[   36.255572][  T332] logd: logdr: UID=2000 GID=2000 PID=875 b tail=0
logMask=99 pid=0 start=0ns deadline=0ns
[   37.696487][  T432] AidlLazyServiceRegistrar: Process has 1 (of 1
available) client(s) in use after notification apexservice has
clients: 1
[   37.709241][  T432] AidlLazyServiceRegistrar: Shutdown prevented by
forcePersist override flag.
[   38.338612][  T336] type=1400 audit(1666104608.191:17): avc:
granted { read } for comm="rkstack.process" name="psched" dev="proc"
ino=4026531994 scontext=u:r:network_stack:s0
tcontext=u:object_r:proc_net:s0 tclass=file
[   38.358532][  T336] type=1400 audit(1666104608.191:18): avc:
granted { read open } for comm="rkstack.process"
path="/proc/1086/net/psched" dev="proc" ino=4026531994
scontext=u:r:network_stack:s0 tcontext=u:object_r:proc_net:s0
tclass=file
[   38.380026][  T336] type=1400 audit(1666104608.191:19): avc:
granted { getattr } for comm="rkstack.process"
path="/proc/1086/net/psched" dev="proc" ino=4026531994
scontext=u:r:network_stack:s0 tcontext=u:object_r:proc_net:s0
tclass=file
[   38.617748][  T475] Bluetooth: hci0: setting up wcn399x
[   38.757009][  T475] Bluetooth: hci0: QCA Product ID   :0x0000000a
[   38.763227][  T475] Bluetooth: hci0: QCA SOC Version  :0x40010214
[   38.769530][  T475] Bluetooth: hci0: QCA ROM Version  :0x00000201
[   38.775726][  T475] Bluetooth: hci0: QCA Patch Version:0x00000001
[   38.801570][  T475] Bluetooth: hci0: QCA controller version 0x02140201
[   38.808233][  T475] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[   39.633279][  T475] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[   39.644525][    T1] init: Service 'bootanim' (pid 603) exited with
status 0 oneshot service took 16.205000 seconds in background
[   39.656244][    T1] init: Sending signal 9 to service 'bootanim'
(pid 603) process group...
[   39.665372][    T1] libprocessgroup: Successfully killed process
cgroup uid 1003 pid 603 in 0ms
[   39.674836][  T475] Bluetooth: hci0: QCA setup on UART is completed
[   39.871775][    T1] init: processing action (sys.boot_completed=1)
from (/system/etc/init/hw/init.rc:1196)
[   39.882217][    T1] init: starting service 'exec 20 (/bin/rm -rf
/data/per_boot)'...
[   39.934126][    T1] init: SVC_EXEC service 'exec 20 (/bin/rm -rf
/data/per_boot)' pid 1432 (uid 1000 gid 1000+0 context default)
started; waiting...
[   39.947707][    T1] init: Command 'exec - system system -- /bin/rm
-rf /data/per_boot' action=sys.boot_completed=1
(/system/etc/init/hw/init.rc:1199) took 65ms and succeeded
[   39.963681][    T1] init: Service 'exec 20 (/bin/rm -rf
/data/per_boot)' (pid 1432) exited with status 0 waiting took 0.071000
seconds
[   39.975951][    T1] init: Sending signal 9 to service 'exec 20
(/bin/rm -rf /data/per_boot)' (pid 1432) process group...
[   39.987364][    T1] libprocessgroup: Successfully killed process
cgroup uid 1000 pid 1432 in 0ms
[   40.030995][    T1] init: Encryption policy of /data/per_boot set
to a24a2d090cd712a9f22d91a727e864b5 v2 modes 1/4 flags 0xa
[   40.042534][    T1] init: processing action (sys.boot_completed=1
&& sys.bootstat.first_boot_completed=0) from
(/system/etc/init/bootstat.rc:76)
[   40.056124][    T1] init: starting service 'exec 21
(/system/bin/bootstat --record_boot_complete --record_boot_reason
--record_time_since_factory_reset -l)'...
[   40.073771][    T1] init: processing action (sys.boot_completed=1)
from (/system/etc/init/flags_health_check.rc:7)
[   40.097685][    T1] init: processing action
(persist.dbg.keep_debugfs_mounted= &&
ro.product.debugfs_restrictions.enabled=true && sys.boot_completed=1)
from (/system/etc/init/init-debug.rc:15)
[   40.115950][    T1] init: processing action (sys.boot_completed=1)
from (/system/etc/init/logd.rc:34)
[   40.125509][    T1] init: starting service 'logd-auditctl'...
[   40.137943][    T1] init: processing action (sys.boot_completed=1
&& sys.wifitracing.started=0) from (/system/etc/init/wifi.rc:28)
[   40.150263][    T1] init: Service 'exec 21 (/system/bin/bootstat
--record_boot_complete --record_boot_reason
--record_time_since_factory_reset -l)' (pid 1497) exited with status 0
oneshot service took 0.078000 seconds in background
[   40.171258][    T1] init: Sending signal 9 to service 'exec 21
(/system/bin/bootstat --record_boot_complete --record_boot_reason
--record_time_since_factory_reset -l)' (pid 1497) process group...
[   40.189477][    T1] libprocessgroup: Successfully killed process
cgroup uid 1000 pid 1497 in 0ms
[   40.199201][    T1] init: Service 'logd-auditctl' (pid 1500) exited
with status 0 oneshot service took 0.066000 seconds in background
[   40.211365][    T1] init: Sending signal 9 to service
'logd-auditctl' (pid 1500) process group...
[   40.220647][    T1] libprocessgroup: Successfully killed process
cgroup uid 1036 pid 1500 in 0ms
[   40.230322][    T1] selinux: SELinux: Could not get canonical path
for /sys/kernel/debug/tracing/instances/wifi restorecon: No such file
or directory.
[   40.244011][    T1] selinux:
[   40.378651][    T1] init: processing action (sys.boot_completed=1)
from (/vendor/etc/init/init.db845c.rc:43)
