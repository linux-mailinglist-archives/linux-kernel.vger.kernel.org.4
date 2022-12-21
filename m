Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD93652E25
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiLUI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLUI7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:59:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80580F05
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671613149; bh=QQjWLr0feu2YypZxnPsKpIgIHQaJKoPn4rkf2vwSZHg=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=e/J1LeQEdvmnUE8WRBc1k20qb9fn47WL4Z++/BvjRggpzFhSeetGgVTUDcOon/IGr
         QI1Oj5cZi9SjJj7bL4mn/j+pDg530W5XPrwt0IFjpjKEKIOnUaSU8ml3Zu/Yn4syM1
         Xrp5rYEFrwk/1vUYK7qU4WObUFJlR70aWFmD9k4pXr6E2S1AzAAYJ9R6K/k4RezFpN
         f8ay1uK9EqzsTi59V4Xak5W1toCftpJ1AEjUVLtrZJL4+dRZQK5K+kPzApjG/0eqb9
         cMtaT3W7vfYCA6gUbxcMaZIkX8IMlHDlWRbYq0weK2vrBbWddWYrGsF4YamJ65WnO7
         hlhZ3K+ncma0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1oWhVs1Wsj-00p8WZ; Wed, 21
 Dec 2022 09:59:09 +0100
Message-ID: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
Subject: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Dec 2022 09:59:08 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U/glhBh9xvQ71vxKLmtUygW5vf5jpp95RWusWiiAS+rIJ3Ycihn
 LBOTDNKQvn/ZyigQxC0DkKdn0sr+yqMKfxzcqECS4G2RebD2n9UHh9oIut5gjHGGyxwzGLd
 CxR8p7enVqp/1jTlhmYN1fITqsZql3IfS6e5br4QgfVlR8QGM0vZ5qraM/U/oURq3Kl6tao
 HvwzXh9oocKnUab7ll42w==
UI-OutboundReport: notjunk:1;M01:P0:j9uMjq5PE1A=;YKw6NSoCJHa5/gRBODBjnblxVFU
 YhdEww80wBC7NQxUnCbu9J779bKxbBa/sgfyBgHv/pxnX0jrgMKpkuf5pkhvC/4QexoktlbpI
 soI2OFaaeZpVhwjBIYTZyj7w5GyDAwvvXlTKmg+AqtfwCpnB/74XMyy4QZacByVKGvSVZrS/t
 eeFCesQqIhZPOBwshDqnpxbBQL7cyhIDFNEp+vWAsfCJlzUdtb/Qi70N1fZybpgrlof9CtEes
 vYCcMvjp8SmJ9pIyaa+YQQuEQmDs+7ti/ocUD+rZWe9Le/glZomaqxKIbI1lTNpeyjRS+6oAg
 eNDXF4fSjKEVDgnX/gbFDq8a1b8wglbCeQpNUie2HkiLCrN1yjDYc0KpNoz3vuhBaqVWEIBeM
 Fx1+Lz1mebaelL8hrlCJ8TYpQccv72pau1buvmJ5X3w+ZXkMA6fxns1YcWmGsRWD9DEiZTwO6
 3PXf286d3qInoQs14kY5Jup1jEyuqfGLsLhyu5XZIexMzhB+t2kNNdy5pRXCiTW9XZ20Nf719
 i7GQdViGE6Y5QELVObsQE86xF6NWI35k6p58k4yyKVFxbtmaNlnLcH6xhbnwEOHit3T8BXpkV
 ZJA9z7qoqodvwUpsxzT/rs9DFO4reD2c2VWIJeDvSX8ttg85KhQlql+zA/Je9Mziq082LBqvq
 by7i/pYnq2MQGQCKNiDMshxYq8twZFoQIfRZ5V5NH+NHv8LriHd3zfVBaM82kyaEH2uic69EW
 lh3ou7pkgdVv65GQQ47n/v7PXv5RuHBBYR+j6RYggBvJVRJ+BMPWns6E2UZW9bXs3tbepa0bk
 z8Zp2jhgM8ocCMYGhl8BU0OfYnKu9bNhgCx5vRzYZ+4xzIOaFxkyCp5QJUJng89Tymceu4Pid
 HWoY8yciUMjzvB23bNMTBZE3U+MsHl14p4Yf1h/G8foFCLc9nDf2BjEUtQyMpnh1CmP4cpGIe
 97zQhzRs9N/L2wyZIcuRboWKBgM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scenario: /home/mikeg of desktop box mounted by lappy, lappy sitting
idle with user mikeg not even logged in.  Reclaim inducing activity on
desktop box eventually leads to spew below.  I've hung the box three
times in two days, twice with light client side activity, and below
with none, ie with the mount point allegedly merely existing. Sans nfs
mount, box seems perfectly fine. 6.1 didn't reproduce either, so it
would appear to be a merge window bug.

[ 1171.959773] ------------[ cut here ]------------
[ 1171.959792] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1654 __queue_d=
elayed_work+0x6a/0x90
[ 1171.959804] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.959869]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.959962] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
     E      6.1.0.g6feb57c-master #41
[ 1171.959969] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.959972] RIP: 0010:__queue_delayed_work+0x6a/0x90
[ 1171.959981] Code: 50 48 01 c1 83 ff 08 48 89 4a 30 75 2c 4c 89 c7 e9 1b =
b1 07 00 e9 46 e8 ff ff 0f 0b eb cc 0f 0b 48 81 7a 38 20 32 0a 81 74 aa <0f=
> 0b 48 8b 42 28 48 85 c0 74 a8 0f 0b eb a4 89 fe 4c 89 c7 e9 1d
[ 1171.959988] RSP: 0018:ffff8881010a7c78 EFLAGS: 00010003
[ 1171.959992] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[ 1171.959997] RDX: ffff88818016b748 RSI: ffff88810a0bae00 RDI: 00000000000=
00008
[ 1171.960001] RBP: ffff88818016b748 R08: 0000000000000000 R09: 00000000000=
00000
[ 1171.960005] R10: 0000000000000000 R11: 000000000354f7fb R12: 00000000000=
00008
[ 1171.960010] R13: ffff88810a0bae00 R14: 0000000000000000 R15: ffff8881801=
6b710
[ 1171.960015] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.960019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.960022] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.960026] Call Trace:
[ 1171.960033]  <TASK>
[ 1171.960038]  mod_delayed_work_on+0x49/0x70
[ 1171.960049]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.960113]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.960122]  shrink_node+0x1c5/0x420
[ 1171.960129]  balance_pgdat+0x25f/0x530
[ 1171.960137]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.960143]  kswapd+0x12c/0x360
[ 1171.960149]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.960155]  ? __pfx_kswapd+0x10/0x10
[ 1171.960161]  kthread+0xc0/0xe0
[ 1171.960167]  ? __pfx_kthread+0x10/0x10
[ 1171.960172]  ret_from_fork+0x29/0x50
[ 1171.960180]  </TASK>
[ 1171.960184] ---[ end trace 0000000000000000 ]---
[ 1171.960190] ------------[ cut here ]------------
[ 1171.960193] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1656 __queue_d=
elayed_work+0x5a/0x90
[ 1171.960202] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.960259]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.960352] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.960358] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.960363] RIP: 0010:__queue_delayed_work+0x5a/0x90
[ 1171.960369] Code: 8b 05 0a 47 16 01 4c 8d 42 20 48 89 72 48 89 7a 50 48 =
01 c1 83 ff 08 48 89 4a 30 75 2c 4c 89 c7 e9 1b b1 07 00 e9 46 e8 ff ff <0f=
> 0b eb cc 0f 0b 48 81 7a 38 20 32 0a 81 74 aa 0f 0b 48 8b 42 28
[ 1171.960377] RSP: 0018:ffff8881010a7c78 EFLAGS: 00010003
[ 1171.960383] RAX: ffff88818016b750 RBX: 0000000000000000 RCX: 00000000000=
00000
[ 1171.960388] RDX: ffff88818016b748 RSI: ffff88810a0bae00 RDI: 00000000000=
00008
[ 1171.960394] RBP: ffff88818016b748 R08: 0000000000000000 R09: 00000000000=
00000
[ 1171.960453] R10: 0000000000000000 R11: 000000000354f7fb R12: 00000000000=
00008
[ 1171.960459] R13: ffff88810a0bae00 R14: 0000000000000000 R15: ffff8881801=
6b710
[ 1171.960463] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.960468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.960473] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.960478] Call Trace:
[ 1171.960481]  <TASK>
[ 1171.960484]  mod_delayed_work_on+0x49/0x70
[ 1171.960492]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.960542]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.960550]  shrink_node+0x1c5/0x420
[ 1171.960557]  balance_pgdat+0x25f/0x530
[ 1171.960564]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.960571]  kswapd+0x12c/0x360
[ 1171.960578]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.960583]  ? __pfx_kswapd+0x10/0x10
[ 1171.960589]  kthread+0xc0/0xe0
[ 1171.960594]  ? __pfx_kthread+0x10/0x10
[ 1171.960599]  ret_from_fork+0x29/0x50
[ 1171.960607]  </TASK>
[ 1171.960611] ---[ end trace 0000000000000000 ]---
[ 1171.960617] ------------[ cut here ]------------
[ 1171.960620] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.960628] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.960687]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.960775] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.960781] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.960787] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.960793] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.960801] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.960807] RAX: ffff88818016b750 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.960811] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.960816] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.960821] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.960826] R13: 0000000000000004 R14: ffff88818016b748 R15: ffff888120a=
5e000
[ 1171.960831] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.960838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.960842] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.960848] Call Trace:
[ 1171.960853]  <TASK>
[ 1171.960857]  mod_delayed_work_on+0x49/0x70
[ 1171.960864]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.960912]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.960919]  shrink_node+0x1c5/0x420
[ 1171.960926]  balance_pgdat+0x25f/0x530
[ 1171.960932]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.960939]  kswapd+0x12c/0x360
[ 1171.960945]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.960950]  ? __pfx_kswapd+0x10/0x10
[ 1171.960956]  kthread+0xc0/0xe0
[ 1171.960961]  ? __pfx_kthread+0x10/0x10
[ 1171.960965]  ret_from_fork+0x29/0x50
[ 1171.960973]  </TASK>
[ 1171.960976] ---[ end trace 0000000000000000 ]---
[ 1171.961009] ------------[ cut here ]------------
[ 1171.961013] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.961022] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.961079]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.961171] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.961177] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.961183] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.961189] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.961195] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.961200] RAX: ffff8881ecf4b350 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.961207] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.961212] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.961217] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.961222] R13: 0000000000000004 R14: ffff8881ecf4b348 R15: ffff888120a=
5e000
[ 1171.961226] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.961232] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.961237] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.961242] Call Trace:
[ 1171.961245]  <TASK>
[ 1171.961249]  mod_delayed_work_on+0x49/0x70
[ 1171.961256]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.961306]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.961314]  shrink_node+0x1c5/0x420
[ 1171.961320]  balance_pgdat+0x25f/0x530
[ 1171.961326]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.961332]  kswapd+0x12c/0x360
[ 1171.961338]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.961344]  ? __pfx_kswapd+0x10/0x10
[ 1171.961349]  kthread+0xc0/0xe0
[ 1171.961354]  ? __pfx_kthread+0x10/0x10
[ 1171.961359]  ret_from_fork+0x29/0x50
[ 1171.961367]  </TASK>
[ 1171.961370] ---[ end trace 0000000000000000 ]---
[ 1171.961382] ------------[ cut here ]------------
[ 1171.961386] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.961395] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.961451]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.961542] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.961548] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.961552] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.961561] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.961568] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.961572] RAX: ffff888198393b50 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.961578] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.961583] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.961589] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.961593] R13: 0000000000000004 R14: ffff888198393b48 R15: ffff888120a=
5e000
[ 1171.961598] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.961602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.961606] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.961612] Call Trace:
[ 1171.961615]  <TASK>
[ 1171.961619]  mod_delayed_work_on+0x49/0x70
[ 1171.961625]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.961674]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.961681]  shrink_node+0x1c5/0x420
[ 1171.961687]  balance_pgdat+0x25f/0x530
[ 1171.961693]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.961700]  kswapd+0x12c/0x360
[ 1171.961706]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.961712]  ? __pfx_kswapd+0x10/0x10
[ 1171.961718]  kthread+0xc0/0xe0
[ 1171.961723]  ? __pfx_kthread+0x10/0x10
[ 1171.961728]  ret_from_fork+0x29/0x50
[ 1171.961735]  </TASK>
[ 1171.961738] ---[ end trace 0000000000000000 ]---
[ 1171.961752] ------------[ cut here ]------------
[ 1171.961757] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.961765] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.961822]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.961911] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.961917] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.961921] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.961927] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.961934] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.961939] RAX: ffff8881058ad350 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.961947] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.961951] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.961955] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.961959] R13: 0000000000000004 R14: ffff8881058ad348 R15: ffff888120a=
5e000
[ 1171.961964] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.961969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.961973] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.961978] Call Trace:
[ 1171.961982]  <TASK>
[ 1171.961986]  mod_delayed_work_on+0x49/0x70
[ 1171.961993]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.962041]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.962049]  shrink_node+0x1c5/0x420
[ 1171.962055]  balance_pgdat+0x25f/0x530
[ 1171.962063]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.962069]  kswapd+0x12c/0x360
[ 1171.962074]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.962080]  ? __pfx_kswapd+0x10/0x10
[ 1171.962085]  kthread+0xc0/0xe0
[ 1171.962091]  ? __pfx_kthread+0x10/0x10
[ 1171.962095]  ret_from_fork+0x29/0x50
[ 1171.962105]  </TASK>
[ 1171.962108] ---[ end trace 0000000000000000 ]---
[ 1171.962116] ------------[ cut here ]------------
[ 1171.962121] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.962129] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.962185]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.962274] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.962280] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.962285] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.962290] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.962296] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.962302] RAX: ffff8881313dab50 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.962306] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.962310] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.962314] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.962319] R13: 0000000000000004 R14: ffff8881313dab48 R15: ffff888120a=
5e000
[ 1171.962323] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.962328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.962333] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.962337] Call Trace:
[ 1171.962341]  <TASK>
[ 1171.962345]  mod_delayed_work_on+0x49/0x70
[ 1171.962351]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.962399]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.962406]  shrink_node+0x1c5/0x420
[ 1171.962413]  balance_pgdat+0x25f/0x530
[ 1171.962420]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.962427]  kswapd+0x12c/0x360
[ 1171.962433]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.962438]  ? __pfx_kswapd+0x10/0x10
[ 1171.962445]  kthread+0xc0/0xe0
[ 1171.962450]  ? __pfx_kthread+0x10/0x10
[ 1171.962454]  ret_from_fork+0x29/0x50
[ 1171.962461]  </TASK>
[ 1171.962465] ---[ end trace 0000000000000000 ]---
[ 1171.962471] ------------[ cut here ]------------
[ 1171.962474] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.962483] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.962539]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.962628] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.962634] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.962638] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.962644] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.962650] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.962655] RAX: ffff888199989f50 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.962660] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.962665] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.962670] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.962674] R13: 0000000000000004 R14: ffff888199989f48 R15: ffff888120a=
5e000
[ 1171.962681] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.962686] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.962690] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.962695] Call Trace:
[ 1171.962699]  <TASK>
[ 1171.962704]  mod_delayed_work_on+0x49/0x70
[ 1171.962712]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.962760]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.962767]  shrink_node+0x1c5/0x420
[ 1171.962772]  balance_pgdat+0x25f/0x530
[ 1171.962780]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.962786]  kswapd+0x12c/0x360
[ 1171.962791]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.962797]  ? __pfx_kswapd+0x10/0x10
[ 1171.962802]  kthread+0xc0/0xe0
[ 1171.962807]  ? __pfx_kthread+0x10/0x10
[ 1171.962812]  ret_from_fork+0x29/0x50
[ 1171.962819]  </TASK>
[ 1171.962823] ---[ end trace 0000000000000000 ]---
[ 1171.962830] ------------[ cut here ]------------
[ 1171.962833] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.962841] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.962895]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.962984] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.962990] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.962995] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.963001] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.963009] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.963014] RAX: ffff88814ae67350 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.963019] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.963024] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.963029] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.963034] R13: 0000000000000004 R14: ffff88814ae67348 R15: ffff888120a=
5e000
[ 1171.963039] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.963045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.963050] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.963054] Call Trace:
[ 1171.963058]  <TASK>
[ 1171.963062]  mod_delayed_work_on+0x49/0x70
[ 1171.963070]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.963117]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.963124]  shrink_node+0x1c5/0x420
[ 1171.963130]  balance_pgdat+0x25f/0x530
[ 1171.963136]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.963142]  kswapd+0x12c/0x360
[ 1171.963148]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.963153]  ? __pfx_kswapd+0x10/0x10
[ 1171.963160]  kthread+0xc0/0xe0
[ 1171.963165]  ? __pfx_kthread+0x10/0x10
[ 1171.963170]  ret_from_fork+0x29/0x50
[ 1171.963176]  </TASK>
[ 1171.963180] ---[ end trace 0000000000000000 ]---
[ 1171.963188] ------------[ cut here ]------------
[ 1171.963192] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.963200] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.963255]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.963342] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.963348] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.963352] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.963358] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.963364] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.963370] RAX: ffff888191ea9f50 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.963374] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.963379] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.963384] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.963389] R13: 0000000000000004 R14: ffff888191ea9f48 R15: ffff888120a=
5e000
[ 1171.963394] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.963399] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.963404] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.963408] Call Trace:
[ 1171.963412]  <TASK>
[ 1171.963416]  mod_delayed_work_on+0x49/0x70
[ 1171.963423]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.963471]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.963478]  shrink_node+0x1c5/0x420
[ 1171.963484]  balance_pgdat+0x25f/0x530
[ 1171.963491]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.963498]  kswapd+0x12c/0x360
[ 1171.963504]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.963509]  ? __pfx_kswapd+0x10/0x10
[ 1171.963515]  kthread+0xc0/0xe0
[ 1171.963520]  ? __pfx_kthread+0x10/0x10
[ 1171.963524]  ret_from_fork+0x29/0x50
[ 1171.963531]  </TASK>
[ 1171.963535] ---[ end trace 0000000000000000 ]---
[ 1171.963542] ------------[ cut here ]------------
[ 1171.963546] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.963554] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.963609]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.963697] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.963703] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.963709] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.963715] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.963721] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.963726] RAX: ffff8881a6e87b50 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.963730] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.963735] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.963740] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.963744] R13: 0000000000000004 R14: ffff8881a6e87b48 R15: ffff888120a=
5e000
[ 1171.963748] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.963753] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.963757] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.963762] Call Trace:
[ 1171.963765]  <TASK>
[ 1171.963768]  mod_delayed_work_on+0x49/0x70
[ 1171.963775]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.963819]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.963826]  shrink_node+0x1c5/0x420
[ 1171.963831]  balance_pgdat+0x25f/0x530
[ 1171.963837]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.963844]  kswapd+0x12c/0x360
[ 1171.963850]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.963855]  ? __pfx_kswapd+0x10/0x10
[ 1171.963860]  kthread+0xc0/0xe0
[ 1171.963864]  ? __pfx_kthread+0x10/0x10
[ 1171.963869]  ret_from_fork+0x29/0x50
[ 1171.963875]  </TASK>
[ 1171.963878] ---[ end trace 0000000000000000 ]---
[ 1171.963885] ------------[ cut here ]------------
[ 1171.963890] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.963897] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.963945]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.964026] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.964032] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.964035] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.964041] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.964046] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.964051] RAX: ffff888198394b50 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.964056] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.964062] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.964066] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.964073] R13: 0000000000000004 R14: ffff888198394b48 R15: ffff888120a=
5e000
[ 1171.964077] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.964081] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.964086] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.964090] Call Trace:
[ 1171.964095]  <TASK>
[ 1171.964099]  mod_delayed_work_on+0x49/0x70
[ 1171.964106]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.964154]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.964160]  shrink_node+0x1c5/0x420
[ 1171.964166]  balance_pgdat+0x25f/0x530
[ 1171.964174]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.964181]  kswapd+0x12c/0x360
[ 1171.964187]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.964192]  ? __pfx_kswapd+0x10/0x10
[ 1171.964198]  kthread+0xc0/0xe0
[ 1171.964202]  ? __pfx_kthread+0x10/0x10
[ 1171.964207]  ret_from_fork+0x29/0x50
[ 1171.964213]  </TASK>
[ 1171.964217] ---[ end trace 0000000000000000 ]---
[ 1171.964224] ------------[ cut here ]------------
[ 1171.964229] WARNING: CPU: 4 PID: 81 at kernel/workqueue.c:1499 __queue_w=
ork+0x33b/0x3d0
[ 1171.964235] Modules linked in: netconsole(E) af_packet(E) hid_logitech_h=
idpp(E) joydev(E) usblp(E) hid_logitech_dj(E) ip6table_mangle(E) ip6table_r=
aw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E)=
 ip6_tables(E) iptable_filter(E) bpfilter(E) intel_rapl_msr(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) snd_hda_codec_realtek(=
E) snd_hda_codec_generic(E) ledtrig_audio(E) coretemp(E) snd_hda_codec_hdmi=
(E) iTCO_wdt(E) snd_hda_intel(E) at24(E) nls_iso8859_1(E) kvm_intel(E) inte=
l_pmc_bxt(E) snd_intel_dspcfg(E) regmap_i2c(E) mei_hdcp(E) nls_cp437(E) iTC=
O_vendor_support(E) snd_hda_codec(E) snd_hwdep(E) kvm(E) snd_hda_core(E) ir=
qbypass(E) r8169(E) pcspkr(E) snd_pcm(E) realtek(E) i2c_i801(E) mei_me(E) s=
nd_timer(E) mdio_devres(E) snd(E) lpc_ich(E) i2c_smbus(E) libphy(E) soundco=
re(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E)
[ 1171.964287]  lockd(E) sch_fq_codel(E) grace(E) fuse(E) sunrpc(E) configf=
s(E) ip_tables(E) x_tables(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E=
) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_display_helper(E)=
 crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) drm_kms_helper(=
E) sha512_ssse3(E) ahci(E) sha512_generic(E) xhci_pci(E) syscopyarea(E) aes=
ni_intel(E) sysfillrect(E) libahci(E) ehci_pci(E) sysimgblt(E) crypto_simd(=
E) xhci_hcd(E) ehci_hcd(E) cryptd(E) drm(E) libata(E) cec(E) usbcore(E) usb=
_common(E) rc_core(E) video(E) wmi(E) button(E) sd_mod(E) t10_pi(E) crc64_r=
ocksoft_generic(E) crc64_rocksoft(E) crc64(E) vfat(E) fat(E) virtio_blk(E) =
virtio_mmio(E) virtio(E) virtio_ring(E) ext4(E) crc32c_intel(E) crc16(E) mb=
cache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) sc=
si_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E) msr(E) efivarfs(E) =
autofs4(E)
[ 1171.964371] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1171.964378] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1171.964382] RIP: 0010:__queue_work+0x33b/0x3d0
[ 1171.964388] Code: 25 40 d3 02 00 f6 47 2c 20 74 18 e8 6f 6f 00 00 48 85 =
c0 74 0e 48 8b 40 20 48 3b 68 08 0f 84 f5 fc ff ff 0f 0b e9 fe fd ff ff <0f=
> 0b e9 ee fd ff ff 83 c9 02 49 8d 57 68 e9 d7 fd ff ff 80 3d f3
[ 1171.964394] RSP: 0018:ffff8881010a7c38 EFLAGS: 00010003
[ 1171.964399] RAX: ffff88838c101f50 RBX: ffffffff81fcc880 RCX: 00000000000=
00000
[ 1171.964404] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881000=
78000
[ 1171.964408] RBP: ffff88810a0bae00 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1171.964412] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: 00000000000=
00008
[ 1171.964416] R13: 0000000000000004 R14: ffff88838c101f48 R15: ffff888120a=
5e000
[ 1171.964420] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1171.964425] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1171.964429] CR2: 00007f39558dc000 CR3: 00000001b893a002 CR4: 00000000001=
706e0
[ 1171.964433] Call Trace:
[ 1171.964437]  <TASK>
[ 1171.964442]  mod_delayed_work_on+0x49/0x70
[ 1171.964450]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1171.964498]  shrink_slab.constprop.94+0x9d/0x370
[ 1171.964504]  shrink_node+0x1c5/0x420
[ 1171.964510]  balance_pgdat+0x25f/0x530
[ 1171.964518]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.964524]  kswapd+0x12c/0x360
[ 1171.964530]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1171.964536]  ? __pfx_kswapd+0x10/0x10
[ 1171.964541]  kthread+0xc0/0xe0
[ 1171.964545]  ? __pfx_kthread+0x10/0x10
[ 1171.964551]  ret_from_fork+0x29/0x50
[ 1171.964559]  </TASK>
[ 1171.964562] ---[ end trace 0000000000000000 ]---
[ 1281.909660] rcu: INFO: rcu_sched self-detected stall on CPU
[ 1281.909674] rcu: 	4-...!: (15000 ticks this GP) idle=3D3ee4/1/0x40000000=
00000000 softirq=3D437305/437305 fqs=3D210
[ 1281.909680] 	(t=3D15000 jiffies g=3D566765 q=3D19351 ncpus=3D8)
[ 1281.909684] rcu: rcu_sched kthread starved for 14580 jiffies! g566765 f0=
x0 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D3
[ 1281.909691] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM=
 is now expected behavior.
[ 1281.909695] rcu: RCU grace-period kthread stack dump:
[ 1281.909697] task:rcu_sched       state:R  running task     stack:0     p=
id:14    ppid:2      flags:0x00004000
[ 1281.909704] Call Trace:
[ 1281.909707]  <TASK>
[ 1281.909710]  __schedule+0x2ba/0x8e0
[ 1281.909720]  schedule+0x55/0xb0
[ 1281.909723]  schedule_timeout+0x18d/0x280
[ 1281.909729]  ? __pfx_process_timeout+0x10/0x10
[ 1281.909733]  rcu_gp_fqs_loop+0x328/0x3b0
[ 1281.909738]  ? __pfx_rcu_gp_kthread+0x10/0x10
[ 1281.909742]  rcu_gp_kthread+0xb6/0x170
[ 1281.909747]  kthread+0xc0/0xe0
[ 1281.909752]  ? __pfx_kthread+0x10/0x10
[ 1281.909756]  ret_from_fork+0x29/0x50
[ 1281.909762]  </TASK>
[ 1281.909764] rcu: Stack dump where RCU GP kthread last ran:
[ 1281.909767] Sending NMI from CPU 4 to CPUs 3:
[ 1281.909772] NMI backtrace for cpu 3
[ 1281.909774] CPU: 3 PID: 9 Comm: kworker/u16:0 Kdump: loaded Tainted: G  =
      W   E      6.1.0.g6feb57c-master #41
[ 1281.909776] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1281.909777] Workqueue: writeback wb_workfn (flush-8:48)
[ 1281.909781] RIP: 0010:native_queued_spin_lock_slowpath+0x47/0x290
[ 1281.909784] Code: c0 75 f2 5b 5d 41 5c 41 5d c3 cc cc cc cc f3 90 eb e3 =
81 fe 00 01 00 00 0f 84 da 00 00 00 40 30 f6 85 f6 75 4f f0 0f ba 2f 08 <0f=
> 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff
[ 1281.909785] RSP: 0018:ffff8881008a7418 EFLAGS: 00000046
[ 1281.909786] RAX: 0000000000000001 RBX: ffff88818016b748 RCX: 00000000000=
00000
[ 1281.909787] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88840ec=
2d4c0
[ 1281.909787] RBP: ffff8881008a7470 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1281.909788] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: ffff88840ec=
2d4c0
[ 1281.909788] R13: ffff88810a0bae00 R14: 0000000000000000 R15: ffff8881801=
6b710
[ 1281.909789] FS:  0000000000000000(0000) GS:ffff88840ecc0000(0000) knlGS:=
0000000000000000
[ 1281.909790] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1281.909791] CR2: 0000559bf0ef4034 CR3: 0000000004210003 CR4: 00000000001=
706e0
[ 1281.909792] Call Trace:
[ 1281.909792]  <TASK>
[ 1281.909793]  _raw_spin_lock+0x1e/0x30
[ 1281.909795]  try_to_grab_pending+0x49/0x120
[ 1281.909798]  mod_delayed_work_on+0x2d/0x70
[ 1281.909802]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1281.909842]  shrink_slab.constprop.94+0x9d/0x370
[ 1281.909845]  shrink_node+0x1c5/0x420
[ 1281.909847]  try_to_free_pages+0x17b/0x560
[ 1281.909850]  __alloc_pages_slowpath.constprop.125+0x35d/0xc70
[ 1281.909853]  __alloc_pages+0x2b3/0x2e0
[ 1281.909855]  new_slab+0x276/0x360
[ 1281.909856]  ___slab_alloc+0x217/0x710
[ 1281.909858]  ? mempool_alloc+0x54/0x160
[ 1281.909860]  ? ext4_mark_iloc_dirty+0x177/0x600 [ext4]
[ 1281.909897]  ? mempool_alloc+0x54/0x160
[ 1281.909898]  kmem_cache_alloc+0x1b6/0x1d0
[ 1281.909899]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1281.909901]  mempool_alloc+0x54/0x160
[ 1281.909903]  bio_alloc_bioset+0x1d5/0x3a0
[ 1281.909906]  ? __pfx_ext4_end_bio+0x10/0x10 [ext4]
[ 1281.909933]  ext4_bio_write_page+0x49f/0x530 [ext4]
[ 1281.909956]  mpage_submit_page+0x4c/0x70 [ext4]
[ 1281.909978]  mpage_map_and_submit_buffers+0x141/0x220 [ext4]
[ 1281.909998]  ? __check_block_validity.constprop.83+0x3e/0x90 [ext4]
[ 1281.910016]  ? ext4_map_blocks+0x1fd/0x5a0 [ext4]
[ 1281.910035]  ? __cond_resched+0x15/0x30
[ 1281.910037]  ? kmem_cache_alloc+0xe1/0x1d0
[ 1281.910038]  ext4_do_writepages+0x60d/0xbc0 [ext4]
[ 1281.910060]  ? sock_wmalloc+0x60/0x60
[ 1281.910063]  ? update_group_capacity+0x24/0x220
[ 1281.910065]  ext4_writepages+0x6a/0xd0 [ext4]
[ 1281.910085]  do_writepages+0xc8/0x1a0
[ 1281.910087]  __writeback_single_inode+0x39/0x2d0
[ 1281.910089]  writeback_sb_inodes+0x1c2/0x480
[ 1281.910090]  __writeback_inodes_wb+0x5f/0xd0
[ 1281.910091]  wb_writeback+0x1de/0x250
[ 1281.910093]  wb_workfn+0x18b/0x3f0
[ 1281.910094]  ? finish_task_switch+0x87/0x2c0
[ 1281.910096]  process_one_work+0x1f7/0x3c0
[ 1281.910098]  worker_thread+0x2d/0x3b0
[ 1281.910100]  ? __pfx_worker_thread+0x10/0x10
[ 1281.910102]  kthread+0xc0/0xe0
[ 1281.910103]  ? __pfx_kthread+0x10/0x10
[ 1281.910104]  ret_from_fork+0x29/0x50
[ 1281.910106]  </TASK>
[ 1281.910764] CPU: 4 PID: 81 Comm: kswapd0 Kdump: loaded Tainted: G       =
 W   E      6.1.0.g6feb57c-master #41
[ 1281.911452] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1281.911455] RIP: 0010:try_to_grab_pending+0x79/0x120
[ 1281.911459] Code: 04 74 11 48 81 e7 00 ff ff ff 49 89 fd 74 05 4c 3b 27 =
74 59 4c 89 e7 c6 07 00 0f 1f 00 48 8b 45 00 f6 c4 02 74 01 fb 48 8b 13 <b8=
> fe ff ff ff 83 e2 14 48 83 fa 10 74 9f f3 90 b8 f5 ff ff ff 5b
[ 1281.911463] RSP: 0018:ffff8881010a7c58 EFLAGS: 00000202
[ 1281.911466] RAX: 0000000000000246 RBX: ffff88818016b748 RCX: 00000000001=
00000
[ 1281.911469] RDX: 0000000000000001 RSI: 0000000000100000 RDI: ffff88840ec=
2d4c0
[ 1281.911471] RBP: ffff8881010a7c80 R08: ffff888100400028 R09: ffff8881004=
00000
[ 1281.911474] R10: 0000000000000000 R11: ffffffff8225d5c8 R12: ffff88840ec=
2d4c0
[ 1281.911529] R13: ffff88810a0bae00 R14: 0000000000000000 R15: ffff8881801=
6b710
[ 1281.911532] FS:  0000000000000000(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[ 1281.911535] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1281.911538] CR2: 00007fab452688ce CR3: 0000000004210002 CR4: 00000000001=
706e0
[ 1281.911540] Call Trace:
[ 1281.911542]  <TASK>
[ 1281.911545]  mod_delayed_work_on+0x2d/0x70
[ 1281.911549]  nfsd4_state_shrinker_count+0x24/0x50 [nfsd]
[ 1281.911581]  shrink_slab.constprop.94+0x9d/0x370
[ 1281.911585]  shrink_node+0x1c5/0x420
[ 1281.911590]  balance_pgdat+0x25f/0x530
[ 1281.911594]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1281.911650]  kswapd+0x12c/0x360
[ 1281.911654]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 1281.911658]  ? __pfx_kswapd+0x10/0x10
[ 1281.911661]  kthread+0xc0/0xe0
[ 1281.911664]  ? __pfx_kthread+0x10/0x10
[ 1281.911667]  ret_from_fork+0x29/0x50
[ 1281.911671]  </TASK>
[ 1371.224288] sysrq: Resetting

