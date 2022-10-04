Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72BC5F4389
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiJDMvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJDMuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:50:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235C02037A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:48:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w18so12421395wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5FDnm2H/W/x2DFmhg71Nta+FeWO4YaM7G3m7L/vK71s=;
        b=RV0Icnq7JyjkDq4zALy3T9K1NtTnzWjiLhC5x/9mhWPbNCH7clGMMtzwiAvejvQyG/
         CKxVawo0wdA9g0YjqOVJJ02usIz0xNekX5vTOo4Z7TC1Hc4l4wBrLuTHWFSydEPblKXm
         1fMKSjuueH9Xarg6dHodlXVb22KFxYI1iuScYvZLCGdxSCP6AKjESGzsw1R0kgSdkUkl
         3XhE9NZj5/IIGE+7eCOX9MWuUEPhqwrCryvScNvOgGZcthJ8PFTOyOXCo6kEAaYds1Xr
         GLZuk8b9oeLEizJTsIXbdnqgjN9GM8+EUu5DauNO+q6sTwanerNmD8BqkPwYW+TEgrfC
         zXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5FDnm2H/W/x2DFmhg71Nta+FeWO4YaM7G3m7L/vK71s=;
        b=ilJsSaK7Lu2W2/1Z4YZx2WTiP6h3Z7vrEhvp8mdp6s+yuHBKVojp1I2QnThdthAlXN
         SlsqRH7V8MPK/FkT9gDbOyBFbcrhb8LRpOVdr1E6PTSVHBTGyzRCxQ1nj/MGjpcknJ8M
         oHIKu+AFkGDap/CWqHNKvC9QcN9AxUlqBcolmLwiru9VIKWFTKU6IluY2bNSeKjpdKEr
         JFVCVYgnrEgueEnP70Ew1MRPAGyqzRoBmyIj//6ZNla6AyKFgEnp9j5FWbQGwsp3Vpan
         oM0uT6MpdKP8shIc5Klq/taX2IDh6JPyoI3eCyUzC4fflIXh7vAtK30fyVDJwln9o2B0
         UYYw==
X-Gm-Message-State: ACrzQf18fkEEO8+ERdqNKs5sEqDhkpJD57NXhvhiCjcmkA2zy86d9pnA
        co1fqhIltxdDMzUj+GBVXKzmUOyzkQ==
X-Google-Smtp-Source: AMsMyM6FKJgbq9tX0YKLekJlW+xb46Q9+MawH6DeGjtR1jPXDGr1te4aqmrpSwYbmES7b9gcA+tydg==
X-Received: by 2002:a5d:404b:0:b0:22e:331e:1cba with SMTP id w11-20020a5d404b000000b0022e331e1cbamr8278403wrp.488.1664887659995;
        Tue, 04 Oct 2022 05:47:39 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.140])
        by smtp.gmail.com with ESMTPSA id t1-20020a0560001a4100b0022cd539ce5esm12418648wry.50.2022.10.04.05.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:47:39 -0700 (PDT)
Date:   Tue, 4 Oct 2022 15:47:37 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aaron Tomlin <atomlin@redhat.com>
Subject: "Unloaded tainted modules:" prints repeated wrong value
Message-ID: <YzwraXZ3J0p7lch2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got obiously incorrect values of "pcc_cpufreq():1" on a clean kernel
and clean oops (see below). Original oops is different bug.

	A

[17752.703567] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[17752.703580] #PF: supervisor read access in kernel mode
[17752.703583] #PF: error_code(0x0000) - not-present page
[17752.703587] PGD 0 P4D 0=20
[17752.703593] Oops: 0000 [#1] PREEMPT SMP PTI
[17752.703598] CPU: 0 PID: 60649 Comm: cat Tainted: G        W         5.19=
=2E9-100.fc35.x86_64 #1
[17752.703603] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/X99 Extreme6/3.1, BIOS P3.30 08/05/2016
[17752.703607] RIP: 0010:show_smaps_rollup+0x159/0x2e0
[17752.703619] Code: 4c 39 e2 0f 87 12 01 00 00 48 8b 40 10 48 85 c0 0f 85 =
78 ff ff ff 48 8b 43 10 48 8b 00 4c 89 e2 6a 00 4c 8b 64 24 18 45 31 c9 <48=
> 8b 30 45 31 c0 31 c9 4c 89 e7 e8 87 f0 ff ff be 20 00 00 00 4c
[17752.703623] RSP: 0018:ffffa47c85273cb8 EFLAGS: 00010246
[17752.703628] RAX: 0000000000000000 RBX: ffff91e444615480 RCX: 00000000000=
00000
[17752.703631] RDX: 0000000000000000 RSI: 0000000000000100 RDI: 00000000fff=
fffff
[17752.703635] RBP: ffff91e444f97700 R08: 0000000000001000 R09: 00000000000=
00000
[17752.703638] R10: 0000000000020000 R11: 0000000000000000 R12: ffff91e44a1=
8e3c0
[17752.703641] R13: 0000000000000000 R14: ffff91e444f97778 R15: ffffa47c852=
73cd8
[17752.703644] FS:  00007f20bc8ae740(0000) GS:ffff91f39d800000(0000) knlGS:=
0000000000000000
[17752.703648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17752.703652] CR2: 0000000000000000 CR3: 0000000160bbe005 CR4: 00000000003=
726f0
[17752.703655] Call Trace:
[17752.703658]  <TASK>
[17752.703664]  ? mod_objcg_state+0xc6/0x300
[17752.703675]  seq_read_iter+0x120/0x4b0
[17752.703680]  ? folio_add_lru+0x8d/0x100
[17752.703689]  seq_read+0xd8/0x100
[17752.703693]  ? 0xffffffffa6000000
[17752.703698]  vfs_read+0x97/0x190
[17752.703708]  ksys_read+0x4f/0xd0
[17752.703713]  do_syscall_64+0x5c/0x90
[17752.703724]  ? exc_page_fault+0x71/0x170
[17752.703730]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[17752.703738] RIP: 0033:0x7f20bc73e762
[17752.703742] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 3a 10 08 00 e8 e5 e9 01 =
00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48=
> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[17752.703745] RSP: 002b:00007ffc7ff96c88 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[17752.703750] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f20bc7=
3e762
[17752.703753] RDX: 0000000000020000 RSI: 00007f20bc88d000 RDI: 00000000000=
00003
[17752.703756] RBP: 00007f20bc88d000 R08: 00007f20bc88c010 R09: 00000000000=
00000
[17752.703759] R10: 0000000000000022 R11: 0000000000000246 R12: 00000000000=
22000
[17752.703762] R13: 0000000000000003 R14: 0000000000020000 R15: 00000000000=
20000
[17752.703768]  </TASK>
[17752.703771] Modules linked in: snd_seq_dummy snd_hrtimer nft_fib_inet nf=
t_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ip=
v6 nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle ip6table_ra=
w ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defra=
g_ipv4 iptable_mangle iptable_raw iptable_security rfkill ip_set nf_tables =
nfnetlink ip6table_filter ip6_tables iptable_filter qrtr nct6775 nct6775_co=
re hwmon_vid sunrpc vfat fat intel_rapl_msr intel_rapl_common intel_uncore_=
frequency intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal intel_=
powerclamp coretemp kvm_intel kvm irqbypass snd_hda_codec_realtek snd_hda_c=
odec_generic snd_hda_codec_hdmi ledtrig_audio snd_hda_intel iTCO_wdt intel_=
pmc_bxt snd_intel_dspcfg iTCO_vendor_support snd_intel_sdw_acpi rapl snd_hd=
a_codec intel_cstate intel_uncore snd_hda_core snd_hwdep intel_wmi_thunderb=
olt snd_seq snd_seq_device snd_pcm joydev mei_me snd_timer mei snd i2c_i801=
 soundcore lpc_ich i2c_smbus
[17752.703859]  zram ip_tables nouveau video drm_ttm_helper ttm i2c_algo_bi=
t drm_display_helper drm_kms_helper crct10dif_pclmul mxm_wmi crc32_pclmul d=
rm crc32c_intel ghash_clmulni_intel nvme e1000e alx nvme_core cec mdio wmi =
uas usb_storage fuse ipmi_devintf ipmi_msghandler
[17752.703891] Unloaded tainted modules: pcc_cpufreq():1 pcc_cpufreq():1 ac=
pi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 ac=
pi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpuf=
req():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 =
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpu=
freq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 =
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpuf=
req():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 a=
cpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufre=
q():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pc=
c_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq=
():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi=
_cpufreq():1 pcc_cpufreq():1
[17752.703979]  acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pc=
c_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufre=
q():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc=
_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq=
():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_=
cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq()=
:1 fjes():1 acpi_cpufreq():1 fjes():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi=
_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq()=
:1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_c=
pufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():=
1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cp=
ufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1=
 pcc_cpufreq():1
[17752.704063]  acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 ac=
pi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq=
():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc=
_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq(=
):1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_c=
pufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq()=
:1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cp=
ufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1=
 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpuf=
req():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 =
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 ac=
pi_cpufreq():1
[17752.704148]  pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pc=
c_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq=
():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_=
cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq(=
):1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_c=
pufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():=
1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cp=
ufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 =
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpuf=
req():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 p=
cc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pc=
c_cpufreq():1
[17752.704235]  acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 ac=
pi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq=
():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc=
_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq(=
):1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_=
cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():=
1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cp=
ufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1=
 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpuf=
req():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 =
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 ac=
pi_cpufreq():1
[17752.704315]  pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acp=
i_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq=
():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi=
_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq(=
):1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_c=
pufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():=
1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpu=
freq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1=
 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpuf=
req():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 a=
cpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufre=
q():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pc=
c_cpufreq():1
[17752.704390]  acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pc=
c_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufre=
q():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi=
_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq(=
):1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_c=
pufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq()=
:1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cp=
ufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1=
 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpu=
freq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():1 fjes():1
[17752.704464] CR2: 0000000000000000
[17752.704469] ---[ end trace 0000000000000000 ]---
[17752.704471] RIP: 0010:show_smaps_rollup+0x159/0x2e0
[17752.704480] Code: 4c 39 e2 0f 87 12 01 00 00 48 8b 40 10 48 85 c0 0f 85 =
78 ff ff ff 48 8b 43 10 48 8b 00 4c 89 e2 6a 00 4c 8b 64 24 18 45 31 c9 <48=
> 8b 30 45 31 c0 31 c9 4c 89 e7 e8 87 f0 ff ff be 20 00 00 00 4c
[17752.704483] RSP: 0018:ffffa47c85273cb8 EFLAGS: 00010246
[17752.704488] RAX: 0000000000000000 RBX: ffff91e444615480 RCX: 00000000000=
00000
[17752.704491] RDX: 0000000000000000 RSI: 0000000000000100 RDI: 00000000fff=
fffff
[17752.704494] RBP: ffff91e444f97700 R08: 0000000000001000 R09: 00000000000=
00000
[17752.704497] R10: 0000000000020000 R11: 0000000000000000 R12: ffff91e44a1=
8e3c0
[17752.704500] R13: 0000000000000000 R14: ffff91e444f97778 R15: ffffa47c852=
73cd8
[17752.704503] FS:  00007f20bc8ae740(0000) GS:ffff91f39d800000(0000) knlGS:=
0000000000000000
[17752.704508] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17752.704511] CR2: 0000000000000000 CR3: 0000000160bbe005 CR4: 00000000003=
726f0
