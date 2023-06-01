Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA80671A2E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjFAPoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjFAPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:44:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13968B3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685634264; x=1686239064; i=marcel_schwarz@gmx.de;
 bh=s1E8ds8QdtaJcPBRqCcgj023lHoCONqVZR011kL84uY=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=rERoUlgX9D6NvbG5oL3xCJzuQXrc/1v2R0zbba9Jx5ReYOmQDqyEjIbClM+Wcupev6dGuuK
 DP2rk5Yq5MjfcbE+Pq0jtxadKQMNhrN2y3JG21Y8WoXz8w2GxlTijW3w5ImvYcf/LQ26iwFCk
 k4icajUGUQwhOzLQNFAVJYikdOH9hPUWx0G6GAC2/KczTyYXhee1OGeKqitXH6ewQkm7KBydc
 TUdrmT3GssAMSuQJ1UdHhTu/UQcy+QSiXwgoHpNFb8nGwz86ApPAesU6lrg5BwqcdZOiX36q3
 VJLVO6iQbWBg9wXXiPQHlxYm/S2VIzZ6uREzt+igd/zySEXTPRGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.104] ([2.202.125.220]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1qfBDp1Gsv-00an7z for
 <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 17:44:24 +0200
Message-ID: <cc36fca9-e77d-88fa-abbe-af99b731cabd@gmx.de>
Date:   Thu, 1 Jun 2023 17:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: de-DE
To:     linux-kernel@vger.kernel.org
From:   Marcel Schwarz <marcel_schwarz@gmx.de>
Subject: system hangs with kernel 6.1.30 f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SxrjT6VqJSOI70J5vMTnbe36YYbULtC5kcbe3SmGX5BD1HRHD71
 fTNQr375xEDNGSkwnczhHbLxPRN/hU/w6qVcwDnxJyimuXNHVhkWUu9d6DNvH56yYeiLGZN
 M/Qh8ONwUM6YmI+UVjEvfrvTzGY0R1yvLA8YmBPWel+lz82tF10jK8i0ODz4ON/xY3KuKqa
 ZJTF9MvgH2WreGghLfu5w==
UI-OutboundReport: notjunk:1;M01:P0:T1MoayI3XBE=;zJj2pKsFBUT2QhpWZdD6/zA3u+o
 IW0iAnSYQHeEIi+ATCWPyoiogjlvKVbX7rvJ455e2O0vLkalrF1TYqcKsAJ/LLtkr0EmNWx/9
 QJgXaXonmfTgQY6+vVlCfJsiaFUw0otTq2HWnfuh4iO7LoZtiy7JozWljI/MmHdyn+LOPJyAx
 LN6+kyzqyKQhsgCkvGMJFWRrUcUEpiXADZRW6ZmoriLpRMbdorxPXStaJIxJCZcWC+5+zkU0H
 vJ4CU4aE4mqE0uchuYp9uZuHWi+0nwCFbYwkx9KjersfDKiFThF/OeXrFAoR+p7U1Ljc3Donl
 nohyZLHbwxxeuXjc287DY6QvoIGQvdN1h4g4vl+iEDgD5tt/0DPYhPH5WGh0l0YsYci6tED7g
 F6P4cH9NjrEmvNCg6YRTJPhRVUe9i7HK1Hh0OCPFPPA6YVS3K38VbaiUII10+1u8pAzrZyZyp
 6f5lVEY5c6MFJSe9pnLjsu+Ar5i+6ubLPvAM2M8/CoCrrutE9dj+aOIgWSTJVrQCCwTMuPKST
 mytYspEFKC7jBS15vTEszrOenJd5Rp3wTbIgXqP0nt5O9KDojgi7vLvl+pDhKrANYg+dz8Qyn
 iI5JAKJFgRheJI0McDLRL3TLaaJhVOkGEOh7n5wSW6NNrtUeNIvjweQ4/+Xp6N+0A1ooIcCWl
 eRZuLRVo4rDQB5LZqn+Ox6fXMAJz+PomrBUftYrnyw/sEbaNd1vvaaxzp5qZWdXclYYdcPpK3
 Ap621b4KdxAeuBG3FD7o81FPTtX7mZzdXaBh7aylS+jVQDz/l6S0Tmvnsw6zQiP35SVEvHx9f
 HoK0FjsRQwhga+9Xe3A9cAmNMgeleRUv+nNjdlsq+YFiprFWq96vojzkmxqPrhlcPkjOc64Qy
 pHHTKe6N2vku1NYIzuFiSkwNwnR2OsRQzMWhwX4DpHQFE6Rf4aNkiDwEYb6OAeJ2UsdQz/uLS
 01LDSQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have already posted this in a forum of my distribution. There I was
advised to write this mail.
Since an update of the kernel to version 6.1.30 the system hangs as soon
as you try to log in.
(Except linux61 and linux61-nvidia no other packages were updated.)

last working kernel: 6.1.29 (5.x is working too)
first not working kernel: 6.1.30 (6.1.31, 6.3.4 does not work either)


Some system information
=2D------------------------------------

Machine:
 =C2=A0 Type: Laptop System: Acer product: ConceptD CN715-71 v: V1.09 seri=
al:
<superuser required>
 =C2=A0 Mobo: CFL model: GhibliC_CFS v: V1.09 serial: <superuser required>
UEFI: Insyde v: 1.09
 =C2=A0=C2=A0=C2=A0 date: 09/15/2020
CPU:
 =C2=A0 Info: 6-core model: Intel Core i7-9750H bits: 64 type: MT MCP arch=
:
Coffee Lake rev: A cache:
 =C2=A0=C2=A0=C2=A0 L1: 384 KiB L2: 1.5 MiB L3: 12 MiB
 =C2=A0 Speed (MHz): avg: 2247 high: 4311 min/max: 800/4500 cores: 1: 930 =
2:
800 3: 4311 4: 4192
 =C2=A0=C2=A0=C2=A0 5: 3940 6: 3363 7: 4202 8: 916 9: 900 10: 900 11: 1117=
 12: 1397
bogomips: 62431
 =C2=A0 Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
 =C2=A0 Device-1: Intel CoffeeLake-H GT2 [UHD Graphics 630] vendor: Acer
Incorporated ALI driver: i915
 =C2=A0=C2=A0=C2=A0 v: kernel arch: Gen-9.5 bus-ID: 00:02.0
 =C2=A0 Device-2: NVIDIA TU106M [GeForce RTX 2060 Mobile] vendor: Acer
Incorporated ALI driver: nvidia
 =C2=A0=C2=A0=C2=A0 v: 530.41.03 arch: Turing bus-ID: 01:00.0
 =C2=A0 Device-3: Chicony HD WebCam driver: uvcvideo type: USB bus-ID: 1-5=
:2
 =C2=A0 Display: wayland server: X.org v: 1.21.1.8 with: Xwayland v: 23.1.=
1
compositor: kwin_wayland
 =C2=A0=C2=A0=C2=A0 driver: X: loaded: modesetting,nvidia dri: iris gpu: i=
915,nvidia
resolution: 1920x1080
 =C2=A0 API: OpenGL v: 4.6 Mesa 23.0.3 renderer: Mesa Intel UHD Graphics 6=
30
(CFL GT2)
 =C2=A0=C2=A0=C2=A0 direct-render: Yes
Audio:
 =C2=A0 Device-1: Intel Cannon Lake PCH cAVS vendor: Acer Incorporated ALI
driver: snd_hda_intel
 =C2=A0=C2=A0=C2=A0 v: kernel bus-ID: 00:1f.3
 =C2=A0 Device-2: NVIDIA TU106 High Definition Audio vendor: Acer
Incorporated ALI
 =C2=A0=C2=A0=C2=A0 driver: snd_hda_intel v: kernel bus-ID: 01:00.1
 =C2=A0 API: ALSA v: k5.10.181-1-MANJARO status: kernel-api
 =C2=A0 Server-1: JACK v: 1.9.22 status: off
 =C2=A0 Server-2: PipeWire v: 0.3.70 status: off
 =C2=A0 Server-3: PulseAudio v: 16.1 status: active
Network:
 =C2=A0 Device-1: Intel Cannon Lake PCH CNVi WiFi vendor: Rivet Networks
Killer Wireless-AC 1550i
 =C2=A0=C2=A0=C2=A0 Wireless driver: iwlwifi v: kernel bus-ID: 00:14.3
 =C2=A0 IF: wlp0s20f3 state: up mac: <filter>
 =C2=A0 Device-2: Realtek Killer E3000 2.5GbE vendor: Acer Incorporated AL=
I
driver: r8169 v: kernel
 =C2=A0=C2=A0=C2=A0 port: 3000 bus-ID: 40:00.0
 =C2=A0 IF: enp64s0 state: down mac: <filter>
Drives:
 =C2=A0 Local Storage: total: 953.87 GiB used: 268.56 GiB (28.2%)
 =C2=A0 ID-1: /dev/nvme0n1 vendor: Western Digital model: PC SN720 SED
SDAQNTW-1T00 size: 953.87 GiB
 =C2=A0=C2=A0=C2=A0 temp: 44.9 C
Partition:
 =C2=A0 ID-1: / size: 49.68 GiB used: 9.74 GiB (19.6%) fs: ext4 dev:
/dev/nvme0n1p6
 =C2=A0 ID-2: /boot/efi size: 625 MiB used: 29.6 MiB (4.7%) fs: vfat dev:
/dev/nvme0n1p1
 =C2=A0 ID-3: /home size: 112.01 GiB used: 2.58 GiB (2.3%) fs: xfs dev:
/dev/nvme0n1p7


Probably relevant part of the system log
=2D---------------------------------------------------------

Jun 01 16:37:33 ConceptD7 kernel: BUG: kernel NULL pointer dereference,
address: 0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: #PF: supervisor read access in kernel mo=
de
Jun 01 16:37:33 ConceptD7 kernel: #PF: error_code(0x0000) - not-present pa=
ge
Jun 01 16:37:33 ConceptD7 kernel: PGD 0 P4D 0
Jun 01 16:37:33 ConceptD7 kernel: Oops: 0000 [#1] PREEMPT SMP PTI
Jun 01 16:37:33 ConceptD7 kernel: CPU: 11 PID: 132 Comm: kworker/11:1
Tainted: P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.1.31-1-MANJARO #1
4296b1b34f35d173981fd810fc2adad6b528cbaa
Jun 01 16:37:33 ConceptD7 kernel: Hardware name: Acer ConceptD
CN715-71/GhibliC_CFS, BIOS V1.09 09/15/2020
Jun 01 16:37:33 ConceptD7 kernel: Workqueue: events_long ucsi_init_work
[typec_ucsi]
Jun 01 16:37:33 ConceptD7 kernel: RIP:
0010:ucsi_acpi_async_write+0x30/0x50 [ucsi_acpi]
Jun 01 16:37:33 ConceptD7 kernel: Code: 44 00 00 41 55 49 89 cd 41 54 49
89 d4 55 53 89 f3 e8 24 0e 08 00 4c 89 e6 89 df 4c 89 ea 48 03 78 10 48
89 c5 e8 d0 ff 3e f6 <49> 8b 04 24 48 89 ef be 01 00 00 00 48 89 45 50
5b 5d 41 5c 41 5d
Jun 01 16:37:33 ConceptD7 kernel: RSP: 0018:ffffb05c8062fdb0 EFLAGS:
00010282
Jun 01 16:37:33 ConceptD7 kernel: RAX: ffffb05c801da002 RBX:
0000000000000002 RCX: 0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: ffffb05c801da002
Jun 01 16:37:33 ConceptD7 kernel: RBP: ffff89ac015bcfa8 R08:
0000000000000000 R09: ffff89ac0a4e5c80
Jun 01 16:37:33 ConceptD7 kernel: R10: ffffffffb734c080 R11:
0000000000000001 R12: 0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: R13: 0000000000000000 R14:
ffff89ac08c4eab8 R15: 0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: FS:=C2=A0 0000000000000000(0000)
GS:ffff89b3744c0000(0000) knlGS:0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 01 16:37:33 ConceptD7 kernel: CR2: 0000000000000000 CR3:
00000005d9610006 CR4: 00000000003706e0
Jun 01 16:37:33 ConceptD7 kernel: Call Trace:
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 <TASK>
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ? __die_body.cold+0x1a/0x1f
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ? page_fault_oops+0x15a/0x2d0
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ? exc_page_fault+0x74/0x170
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ? asm_exc_page_fault+0x26/0x30
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ? ucsi_acpi_async_write+0x30/0x50
[ucsi_acpi 1a3d000051001f041d33c99a422e817b52f6062b]
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ucsi_exec_command+0x1e6/0x200
[typec_ucsi 177e49d6b21dc34fc59c0e466546c986508a8305]
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ucsi_send_command+0x4b/0xe0
[typec_ucsi 177e49d6b21dc34fc59c0e466546c986508a8305]
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ucsi_init_work+0x337/0x720
[typec_ucsi 177e49d6b21dc34fc59c0e466546c986508a8305]
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 process_one_work+0x1c4/0x380
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 worker_thread+0x51/0x390
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ? rescuer_thread+0x3b0/0x3b0
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 kthread+0xdb/0x110
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ? kthread_complete_and_exit+0x20/0=
x20
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 ret_from_fork+0x1f/0x30
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 </TASK>
Jun 01 16:37:33 ConceptD7 kernel: Modules linked in: qrtr cmac
algif_hash algif_skcipher af_alg bnep nvidia_uvm(POE)
snd_sof_pci_intel_cnl snd_sof_intel_hda_common soundwire_intel
soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda
snd_sof_pci snd_sof_xtensa_dsp nvidia_drm(POE) snd_sof snd_sof_utils
soundwire_bus snd_soc_skl intel_tcc_cooling snd_soc_hdac_hda
x86_pkg_temp_thermal intel_powerclamp snd_hda_ext_core coretemp
snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match kvm_intel
snd_soc_acpi nvidia_modeset(POE) snd_soc_core kvm snd_hda_codec_realtek
irqbypass snd_compress snd_hda_codec_generic crct10dif_pclmul ac97_bus
ledtrig_audio crc32_pclmul snd_hda_codec_hdmi snd_pcm_dmaengine
polyval_clmulni polyval_generic gf128mul ghash_clmulni_intel joydev
snd_hda_intel iwlmvm sha512_ssse3 snd_intel_dspcfg mousedev nvidia(POE)
iTCO_wdt mac80211 i2c_nvidia_gpu i915 snd_intel_sdw_acpi uvcvideo
aesni_intel btusb intel_pmc_bxt videobuf2_vmalloc xfs libarc4
crypto_simd snd_hda_codec btrtl
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 videobuf2_memops cryptd ee1004
iTCO_vendor_support btbcm snd_hda_core
processor_thermal_device_pci_legacy videobuf2_v4l2 btintel
hid_multitouch iwlwifi r8169 snd_hwdep videobuf2_common
processor_thermal_device btmtk snd_pcm vfat rapl fat libcrc32c mei_hdcp
mei_pxp acer_wmi intel_rapl_msr intel_wmi_thunderbolt wmi_bmof
sparse_keymap snd_timer realtek processor_thermal_rfim drm_buddy spi_nor
intel_cstate bluetooth videodev processor_thermal_mbox mdio_devres
i2c_i801 i2c_hid_acpi snd ttm processor_thermal_rapl cfg80211
intel_uncore mc mtd pcspkr i2c_smbus libphy intel_lpss_pci ucsi_acpi
video i2c_hid int3403_thermal soundcore intel_rapl_common intel_lpss
drm_display_helper ecdh_generic mei_me typec_ucsi int340x_thermal_zone
idma64 rfkill intel_soc_dts_iosf cec mei intel_gtt intel_pch_thermal
typec roles int3400_thermal wmi acer_wireless acpi_thermal_rel acpi_pad
mac_hid crypto_user loop fuse dm_mod bpf_preload ip_tables x_tables ext4
crc32c_generic crc16 mbcache jbd2 serio_raw
Jun 01 16:37:33 ConceptD7 kernel:=C2=A0 atkbd libps2 vivaldi_fmap nvme
nvme_core spi_intel_pci crc32c_intel xhci_pci spi_intel nvme_common
xhci_pci_renesas i8042 serio
Jun 01 16:37:33 ConceptD7 kernel: CR2: 0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: ---[ end trace 0000000000000000 ]---
Jun 01 16:37:33 ConceptD7 kernel: RIP:
0010:ucsi_acpi_async_write+0x30/0x50 [ucsi_acpi]
Jun 01 16:37:33 ConceptD7 kernel: Code: 44 00 00 41 55 49 89 cd 41 54 49
89 d4 55 53 89 f3 e8 24 0e 08 00 4c 89 e6 89 df 4c 89 ea 48 03 78 10 48
89 c5 e8 d0 ff 3e f6 <49> 8b 04 24 48 89 ef be 01 00 00 00 48 89 45 50
5b 5d 41 5c 41 5d
Jun 01 16:37:33 ConceptD7 kernel: RSP: 0018:ffffb05c8062fdb0 EFLAGS:
00010282
Jun 01 16:37:33 ConceptD7 kernel: RAX: ffffb05c801da002 RBX:
0000000000000002 RCX: 0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: ffffb05c801da002
Jun 01 16:37:33 ConceptD7 kernel: RBP: ffff89ac015bcfa8 R08:
0000000000000000 R09: ffff89ac0a4e5c80
Jun 01 16:37:33 ConceptD7 kernel: R10: ffffffffb734c080 R11:
0000000000000001 R12: 0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: R13: 0000000000000000 R14:
ffff89ac08c4eab8 R15: 0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: FS:=C2=A0 0000000000000000(0000)
GS:ffff89b3744c0000(0000) knlGS:0000000000000000
Jun 01 16:37:33 ConceptD7 kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 01 16:37:33 ConceptD7 kernel: CR2: 0000000000000000 CR3:
00000005d9610006 CR4: 00000000003706e0
Jun 01 16:37:33 ConceptD7 kernel: note: kworker/11:1[132] exited with
irqs disabled


I hope this helps to find and fix a possible bug.

=2D-
Marcel Schwarz

