Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7910368BA0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjBFKZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBFKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:25:40 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86D46BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675679136; bh=fDhIwgiXb16Zuvz1C8SFJAGtd1AmQo1DiiYBfvoE30c=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=qkKDMe6aZeAlSKCtTxwHTB2WMWDc7d/BfNzf0UbzSdjLCT6NfrZmOkqUKT9+IzE04
         UzNBv9AZbqa6cplhiM123jTWyd7otG771e2zx7etUBhoFeoK5rNw9Rp346b5GvyEFg
         QfNGThUMOTyodO/qqdRYND/V/AJ32qm3f+egtbY+C2C8TXuRVuP8qVzTbBSKtyNZTO
         CByTtQp1T/A9pTeA7mra067kYDryWKY4Ajy1vBIl79GQch2ux5jOU3mNneYKkJsDMF
         rmAaWj9bdKT0Ck8MSpYQ5Vt5n3ktod1Mw6KPfaqk5NWO1qkHFWd/wGwt3G4eVHFLs0
         4aDfQuTWMWLLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from schienar ([128.141.229.79]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLE9-1okSGj0CZ3-00ljmR for
 <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:25:36 +0100
Date:   Mon, 6 Feb 2023 11:25:34 +0100
From:   Julian Wollrath <jwollrath@web.de>
To:     linux-kernel@vger.kernel.org
Subject: 6.2-rc7: trace during suspend/wakeup kernel/irq/manage.c
 drivers/iommu/amd/init.c
Message-ID: <20230206112534.15acf5c8@schienar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RqGRneKUxfNs+DqqFNsrB27FXjq8NgIIaTIxzV7+uPoYt1xOgzB
 Dj6I+knU2iRXKxGfykli15WICRZANeVulmyMSefetDNl92QxxD3kZiCWLT6bXERpM3rP0u4
 HvpqZHKdnfT5YDWOLo+f8XaEnCpv6BuFRwhPMvEwDhUbbHguHh8kmZKGCaLt0dISH/GCNyT
 679RLrRA4F7H4jZrzMGsQ==
UI-OutboundReport: notjunk:1;M01:P0:TcBs2ImzlTo=;h6ACB0w9HRY6wKhf/2RBEosOQZN
 qoKPS0SC2kMRs0HeUzTcU/Mpu9e9MYmlirOkZixyep9tOXZ5COMdS9qBW33VHoAlexHkT3fzK
 vYkO9xAOdN8YgAr/mn8Fs7ao2ovAkKwsFPAzpLR0YtM4Z7u3jR39ZMEGdeaI6/hbPjKv58Uj1
 yx4zcKc8KhLu4X7nQxEbZQ5YwPY2sQJekVOaZCCl8aTNMllPcUNd7uZayV/UfWAt4gi1QgCmQ
 qTaSpakc6WTQYvxib/4+uNCLCMgQuWM73Idp/KVFHOAmCo3J5Pbgq5DyGVvxZne6YtSSnyFjg
 DcdkjODGG7eoXDwnMNx0mjh/R2e2jRUfvxl7CpUuFG6ajNsCCTus+G7vc5Wb0fvTWoALypJ+7
 EUAwOJzOaeKQ5g1I9HDBwmOOp9BG/PejWbbzIMjPXRXZs+jI1841wKK1Wsfemi+ZryTEVA4ip
 nfZDfR/lr9ZQZXN+9aQIgbd4J60eCs0TS6aaSHT5lYD8TbBG2j2C5v9lUDAYoTsNesljHid2i
 Gc654FyblL7bXOgMKMdMfmuflEpW7G+UwWGbA3zf5PJZii3+Z1x0dfPF+uCU+xyOOWoVslk0w
 nhrEwPh02z13fHOayQLtETacxsvI72qU4Cia8gMjCb/IXrEFYla0q8Fq9o7PlbeRjXUxBFRm8
 dbwFOmljKMbSjEKwmQ225tIHzKHPK9hxu0jKaJN+nHq2GdBA/+xB1WwSk60K9R/+9KACeDRYT
 w+xusJ+ErBMDTzlPdEVXHMV1zufNe/VNmuumZj7FBWAbRjZ7ArYrqpGsfZiBG2Z3ntPIlRaRk
 rzuHo4RvCOUK5KxySaY0wahzjxXniIgc6Xk4rderSjFbt6bd+04fT6egMmSdVkFx2l5BpR5k3
 bMqwvCUye4n18UWlUL2VVk1y9N8CvEIxbOyJOCEl6Q9a9OBuKE0W6y3swhtNrKEPmgLJLsyNa
 E6vG5Q==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during suspend to disk / wake-up I got the following two traces:

Unbalanced IRQ 1 wake disable
WARNING: CPU: 10 PID: 5506 at kernel/irq/manage.c:907 irq_set_irq_wake+0x1=
49/0x1a0
Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ccm cm=
ac algif_hash algif_skcipher af_alg 8021q garp stp mrp llc uvcvideo videob=
uf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc b=
nep btusb btintel bluetooth ecdh_generic crc16 snd_ctl_led snd_hda_codec_r=
ealtek iwlmvm snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi mac80=
211 snd_hda_intel snd_intel_dspcfg libarc4 nls_ascii nls_cp437 snd_hda_cod=
ec kvm_amd vfat snd_hwdep iwlwifi fat snd_hda_core kvm xhci_pci snd_pcm ir=
qbypass crc32_pclmul snd_rn_pci_acp3x sp5100_tco hid_multitouch nft_ct xhc=
i_hcd snd_timer ghash_clmulni_intel cfg80211 snd_acp_config nf_conntrack c=
cp watchdog hid_generic usbcore snd_soc_acpi snd sha512_ssse3 nf_defrag_ip=
v6 ucsi_acpi nf_defrag_ipv4 rapl typec_ucsi tpm_crb rfkill wmi_bmof usb_co=
mmon pcspkr rng_core snd_pci_acp3x soundcore roles i2c_piix4 i2c_hid_acpi =
k10temp typec battery i2c_hid tpm_tis hid wireless_hotkey tpm_tis_core cm3=
2181 industrialio nft_limit
 amd_pmc acpi_cpufreq button ac tcp_bbr sch_fq_codel nf_tables nfnetlink f=
use efi_pstore configfs efivarfs autofs4 xfs libcrc32c crc32c_generic dm_c=
rypt dm_mod amdgpu drm_ttm_helper ttm mfd_core gpu_sched i2c_algo_bit crc3=
2c_intel nvme drm_buddy nvme_core drm_display_helper t10_pi drm_kms_helper=
 syscopyarea crc64_rocksoft sysfillrect crc64 sysimgblt aesni_intel crc_t1=
0dif crypto_simd evdev crct10dif_generic drm cryptd crct10dif_pclmul serio=
_raw video crct10dif_common cec wmi
CPU: 10 PID: 5506 Comm: systemd-sleep Not tainted 6.2.0-rc7 #1
Hardware name: HP HP EliteBook 845 G7 Notebook PC/8760, BIOS S77 Ver. 01.1=
1.00 10/17/2022
RIP: 0010:irq_set_irq_wake+0x149/0x1a0
Code: f6 e8 8b 5b 80 00 89 c5 85 c0 74 38 c7 83 84 00 00 00 01 00 00 00 e9=
 38 ff ff ff 44 89 e6 48 c7 c7 88 7a 7d b8 e8 d4 ad 7b 00 <0f> 0b 31 ed e9=
 20 ff ff ff 48 8b 43 38 31 ed 81 08 00 40 00 00 e9
RSP: 0018:ffffb3f5c7ee7ce8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff8b6d40155600 RCX: 0000000000000027
RDX: ffff8b703fa9b308 RSI: 0000000000000001 RDI: ffff8b703fa9b300
RBP: 00000000ffffffea R08: 80000000fffff433 R09: 0000000000000000
R10: 3fffffffffffffff R11: ffffffffb90af2c8 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8b6e73d16320
FS:  00007f6382b49440(0000) GS:ffff8b703fa80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd71029d60 CR3: 000000016971a000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ? acpi_subsys_suspend_noirq+0x50/0x50
 amd_pmc_suspend_handler+0x90/0xc0 [amd_pmc]
 dpm_run_callback+0x4a/0x150
 __device_suspend+0xf1/0x470
 dpm_suspend+0x136/0x270
 hibernation_snapshot+0x7c/0x510
 hibernate.cold+0x99/0x2d0
 state_store+0xbf/0xd0
 kernfs_fop_write_iter+0x11e/0x200
 vfs_write+0x1f5/0x3d0
 ksys_write+0x63/0xe0
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x4b/0xb5
RIP: 0033:0x7f6382717190
Code: 40 00 48 8b 15 71 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7=
 0f 1f 00 80 3d 51 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffd7102b2b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6382717190
RDX: 0000000000000005 RSI: 00007ffd7102b3a0 RDI: 0000000000000004
RBP: 00007ffd7102b3a0 R08: 0000000000000007 R09: 0000560b4256e220
R10: 6dbdda95b41f6e2e R11: 0000000000000202 R12: 0000000000000005
R13: 0000560b4256a2d0 R14: 0000000000000005 R15: 00007f63827ed9e0
 </TASK>

WARNING: CPU: 0 PID: 5506 at drivers/iommu/amd/init.c:930 enable_iommus_va=
pic+0x30e/0x370
Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ccm cm=
ac algif_hash algif_skcipher af_alg 8021q garp stp mrp llc uvcvideo videob=
uf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc b=
nep btusb btintel bluetooth ecdh_generic crc16 snd_ctl_led snd_hda_codec_r=
ealtek iwlmvm snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi mac80=
211 snd_hda_intel snd_intel_dspcfg libarc4 nls_ascii nls_cp437 snd_hda_cod=
ec kvm_amd vfat snd_hwdep iwlwifi fat snd_hda_core kvm xhci_pci snd_pcm ir=
qbypass crc32_pclmul snd_rn_pci_acp3x sp5100_tco hid_multitouch nft_ct xhc=
i_hcd snd_timer ghash_clmulni_intel cfg80211 snd_acp_config nf_conntrack c=
cp watchdog hid_generic usbcore snd_soc_acpi snd sha512_ssse3 nf_defrag_ip=
v6 ucsi_acpi nf_defrag_ipv4 rapl typec_ucsi tpm_crb rfkill wmi_bmof usb_co=
mmon pcspkr rng_core snd_pci_acp3x soundcore roles i2c_piix4 i2c_hid_acpi =
k10temp typec battery i2c_hid tpm_tis hid wireless_hotkey tpm_tis_core cm3=
2181 industrialio nft_limit
 amd_pmc acpi_cpufreq button ac tcp_bbr sch_fq_codel nf_tables nfnetlink f=
use efi_pstore configfs efivarfs autofs4 xfs libcrc32c crc32c_generic dm_c=
rypt dm_mod amdgpu drm_ttm_helper ttm mfd_core gpu_sched i2c_algo_bit crc3=
2c_intel nvme drm_buddy nvme_core drm_display_helper t10_pi drm_kms_helper=
 syscopyarea crc64_rocksoft sysfillrect crc64 sysimgblt aesni_intel crc_t1=
0dif crypto_simd evdev crct10dif_generic drm cryptd crct10dif_pclmul serio=
_raw video crct10dif_common cec wmi
CPU: 0 PID: 5506 Comm: systemd-sleep Tainted: G        W          6.2.0-rc=
7 #1
Hardware name: HP HP EliteBook 845 G7 Notebook PC/8760, BIOS S77 Ver. 01.1=
1.00 10/17/2022
RIP: 0010:enable_iommus_vapic+0x30e/0x370
Code: 44 24 08 65 48 2b 04 25 28 00 00 00 75 68 49 8b bf a0 00 00 00 48 83=
 c4 10 31 f6 5b 5d 41 5c 41 5d 41 5e 41 5f e9 52 63 c9 ff <0f> 0b e9 a1 fd=
 ff ff 48 8b 15 5c 16 12 01 48 c1 ea 05 83 e2 07 48
RSP: 0018:ffffb3f5c7ee7d48 EFLAGS: 00010046
RAX: 0000002459b3abbc RBX: 00000000001e8480 RCX: 0000000000000000
RDX: 000000000000597f RSI: 00000000000051e2 RDI: 0000002459b3523d
RBP: 0000000080000000 R08: 0000000000000100 R09: fffff6fa0e69d200
R10: ffffb3f5c7ee7cd8 R11: ffffb3f5c7ee7cd8 R12: 000ffffffffffff8
R13: 0800000000000000 R14: 2000000000000000 R15: ffff8b6d40063000
FS:  00007f6382b49440(0000) GS:ffff8b703f800000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f402ac7a000 CR3: 000000016971a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 amd_iommu_reenable+0x34/0x50
 lapic_resume+0x22c/0x2c0
 syscore_resume+0x4a/0x180
 hibernation_snapshot+0x119/0x510
 hibernate.cold+0x99/0x2d0
 state_store+0xbf/0xd0
 kernfs_fop_write_iter+0x11e/0x200
 vfs_write+0x1f5/0x3d0
 ksys_write+0x63/0xe0
 do_syscall_64+0x3a/0x90
 entry_SYSCALL_64_after_hwframe+0x4b/0xb5
RIP: 0033:0x7f6382717190
Code: 40 00 48 8b 15 71 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7=
 0f 1f 00 80 3d 51 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffd7102b2b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6382717190
RDX: 0000000000000005 RSI: 00007ffd7102b3a0 RDI: 0000000000000004
RBP: 00007ffd7102b3a0 R08: 0000000000000007 R09: 0000560b4256e220
R10: 6dbdda95b41f6e2e R11: 0000000000000202 R12: 0000000000000005
R13: 0000560b4256a2d0 R14: 0000000000000005 R15: 00007f63827ed9e0
 </TASK>


Let me know, if you need more information.


Best regards,
Julian Wollrath

=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
