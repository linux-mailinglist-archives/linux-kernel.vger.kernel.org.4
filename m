Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDDA68020E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjA2Vzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjA2Vzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:55:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C8526C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:55:29 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so9351885pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qauMi/XLx1BF2qIxkQh1DFcqa5RzSo19nqPi3Q20fMM=;
        b=mWiNSjDMT/pc+IwgiBgu9kT54J1DPozmL+fbyX0oTQ+YFmDM8fruSair0i3GnMFzDi
         AuPldEEp8AfgOPurYujw+mFzgMXdqPVUkBmZ4KfF3dS9Ys/QPIaVGfQ30raPOyD7ylhR
         Syc6AYUWovR+VBrxup35ReQ2v5ojDq0YHwTirpSX8So0l1ViYIJim5d0VY8m3Xg/1pI2
         kfed1vX31BMxdy2UabpPNgu2xCf8JZ2L7ahF5W9TZxLhWyExzsEkQFGvVYuDAPyzZ9us
         HZ2huTuYohqXJ+Ke9VslBb4MtMKAMxUmarJ1xuEcL9hXhMjc9pTjy0Sy+qhObLDpkRHT
         20yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qauMi/XLx1BF2qIxkQh1DFcqa5RzSo19nqPi3Q20fMM=;
        b=GL2cEL7T/dE+5ftFzwXI8ccpPqhJmcS2ErfMb1F8AdRcLAuQsZyYcTulI9gzdreNfz
         0LzNKfn18HqcSfZM/VaRfeeSIApJ2hGTc25yNbRrJ9cfYQPxv455sXhnOymBnVPElHdN
         Z5AiavznlL7FYE3prStAqXv3yGYgC2mz0hGI1DWIF/RJ01pu7JXTz3TpAtK3Q6vHbSHz
         ut0Bww4v5R8BaKyPLfymudLil5hAnTloJDRjM0Pa13munFQmzgTa6NYgpDPMzuUGYWXw
         6zLZQowwkZVoUf8obttz7KbYN5DE/Z3WyV5nqvhmPXz2vyXoci5s5ueiezv+oIncAN33
         Kxzw==
X-Gm-Message-State: AO0yUKXHxAIzyxYPYTWDcjXuFD8MT1l53BTdietmQ4uEigQzsXykTKis
        +qxHsXNTo+246kzdOBvhGinvmJ9s+O86C4d4
X-Google-Smtp-Source: AK7set/e13TmCJseFDig7JIeQTTDyzOzCsDnluanE2RWXKl3cuwYXYTKav5ispRLtzMdVCUOU6UW5A==
X-Received: by 2002:a17:903:22c2:b0:196:b0c:f0b9 with SMTP id y2-20020a17090322c200b001960b0cf0b9mr5657432plg.6.1675029328819;
        Sun, 29 Jan 2023 13:55:28 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jk11-20020a170903330b00b00188c04258c9sm6337516plb.52.2023.01.29.13.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 13:55:28 -0800 (PST)
Message-ID: <8a22d187-57b4-7a2a-b564-f88bde4ac7ce@kernel.dk>
Date:   Sun, 29 Jan 2023 14:55:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: pktcdvd
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
 <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
 <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
 <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
 <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk>
 <20230106165809.vkz7lr7gi3xce22e@pali>
 <fd143218-d8ba-e6c5-9225-b8e2aee09979@kernel.dk>
 <20230128193458.ukl35ev4mwbjmu6b@pali>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230128193458.ukl35ev4mwbjmu6b@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/23 12:34?PM, Pali Roh?r wrote:
> On Friday 06 January 2023 10:04:47 Jens Axboe wrote:
>> On 1/6/23 9:58?AM, Pali Roh?r wrote:
>>> On Thursday 05 January 2023 13:33:11 Jens Axboe wrote:
>>>> On 1/5/23 1:03?PM, Linus Torvalds wrote:
>>>>> So nobody is going to be motivated to do any development in this ar=
ea,
>>>>> and the best we can do is probably to just keep it limping along.
>>>>
>>>> Indeed...
>>> ...
>>>>> There's probably other cruft in pktcdvd that could be removed witho=
ut
>>>>> removing the whole driver, but I do get the feeling that it's just
>>>>> less pain to keep the status quo, and that there isn't really much
>>>>> motivation for anybody to do anything else.
>>>>
>>>> I'm reluctant to touch it outside of changes that are driven by core=

>>>> changes, and of course the motivation to remove it was driven by not=

>>>> wanting to do that either. Any kind of re-architecting of how it wor=
ks I
>>>> would not advocate for. It supposedly works well enough that none of=
 the
>>>> (few) users are reporting issues with it, best to just let it remain=

>>>> like that imho.
>>>
>>> Yea, I agree. This code is in state when it is _used_ and not develop=
ed
>>> anymore. Nobody is really motivated to re-architecture or rewrite thi=
s
>>> code. Such work has big probability to break something which currentl=
y
>>> works fine. And because lot of users are on stable/LTS kernel version=
s,
>>> it is possible that we would not notice breakage earlier than (lets s=
ay)
>>> in 5 years.
>>
>> I did sent out the revert this morning, would be great if you can test=

>> 6.2-rc3 when it is out. I'm a bit skeptical on the whole devnode front=
,
>> and suspect we might need to convert that to disk_name manipulation.
>> Which would be fine, as we can then drop the devnode reinstate revert =
as
>> well going forward. But I need to find a bit of time to look closer at=

>> this part.
>=20
> Hello! Sorry for a longer delay. Now I have started testing it with
> Linux 6.2.0-rc5. Adding mapping works fine. Reading also works. Mountin=
g
> filesystem also works, reading mounted fs also. But after writing some
> data to fs and calling sync cause kernel oops. Below is the dmesg log.
> "sync" freezes and never finish.
>=20
> [ 1284.701497] pktcdvd: pktcdvd0: writer mapped to sr0
> [ 1321.432589] pktcdvd: pktcdvd0: Fixed packets, 32 blocks, Mode-2 disc=

> [ 1321.437543] pktcdvd: pktcdvd0: maximum media speed: 10
> [ 1321.437546] pktcdvd: pktcdvd0: write speed 10x
> [ 1327.098955] pktcdvd: pktcdvd0: 590528kB available on disc
> [ 1329.737263] UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2023/=
01/28 19:16 (103c)
> [ 1435.627449] ------------[ cut here ]------------
> [ 1435.627466] kernel BUG at drivers/block/pktcdvd.c:2434!
> [ 1435.627472] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [ 1435.627476] CPU: 3 PID: 9 Comm: kworker/u8:0 Tainted: G S   U       =
      6.2.0-rc5 #4
> [ 1435.627478] Hardware name: Dell Inc. Latitude E6440/02P3T1, BIOS A05=
 02/18/2014
> [ 1435.627480] Workqueue: writeback wb_workfn (flush-253:0)
> [ 1435.627487] RIP: 0010:pkt_submit_bio+0x398/0x430 [pktcdvd]
> [ 1435.627494] Code: 55 28 41 89 55 28 41 3b 55 40 7c 07 41 83 7d 44 01=
 74 7c 4c 89 f7 e8 97 32 e1 e9 48 8b 7c 24 10 e8 8d 32 e1 e9 e9 e6 fe ff =
ff <0f> 0b 0f 0b 49 8b 3f 48 c7 c1 a0 97 d0 c0 ba 00 0c 00 00 48 89 c6
> [ 1435.627496] RSP: 0018:ffffb6a10007b828 EFLAGS: 00010283
> [ 1435.627498] RAX: 0000000000000080 RBX: ffff8a4757170800 RCX: 0000000=
000001800
> [ 1435.627500] RDX: 0000000000001604 RSI: 0000000000001680 RDI: 0000000=
000001603
> [ 1435.627501] RBP: ffff8a4750a37480 R08: 0000000000000200 R09: fffffff=
fffffff80
> [ 1435.627502] R10: 0000000000000400 R11: 0000000000000040 R12: ffff8a4=
721bd0dc0
> [ 1435.627504] R13: 0000000000001000 R14: 0000000000000000 R15: ffff8a4=
739e56000
> [ 1435.627505] FS:  0000000000000000(0000) GS:ffff8a4826b80000(0000) kn=
lGS:0000000000000000
> [ 1435.627507] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1435.627508] CR2: 0000560a548f8490 CR3: 0000000067210005 CR4: 0000000=
0001706e0
> [ 1435.627510] Call Trace:
> [ 1435.627512]  <TASK>
> [ 1435.627514]  ? __mod_memcg_lruvec_state+0x72/0xd0
> [ 1435.627519]  ? __mod_lruvec_page_state+0x93/0x130
> [ 1435.627523]  __submit_bio+0x89/0x130
> [ 1435.627528]  submit_bio_noacct_nocheck+0xe5/0x2b0
> [ 1435.627532]  __mpage_writepage+0x6f9/0x860
> [ 1435.627536]  ? __mod_memcg_lruvec_state+0x72/0xd0
> [ 1435.627539]  ? folio_clear_dirty_for_io+0x13c/0x190
> [ 1435.627542]  write_cache_pages+0x18a/0x4d0
> [ 1435.627555]  ? __pfx___mpage_writepage+0x10/0x10
> [ 1435.627558]  mpage_writepages+0x56/0xb0
> [ 1435.627561]  ? __pfx_udf_get_block+0x10/0x10 [udf]
> [ 1435.627571]  do_writepages+0xd5/0x1b0
> [ 1435.627573]  ? __wb_calc_thresh+0x3a/0x120
> [ 1435.627576]  __writeback_single_inode+0x41/0x360
> [ 1435.627579]  writeback_sb_inodes+0x1f0/0x460
> [ 1435.627583]  __writeback_inodes_wb+0x5f/0xd0
> [ 1435.627586]  wb_writeback+0x235/0x2d0
> [ 1435.627589]  wb_workfn+0x311/0x480
> [ 1435.627592]  ? _raw_spin_unlock+0x15/0x30
> [ 1435.627595]  ? finish_task_switch+0x91/0x2f0
> [ 1435.627600]  ? __switch_to+0x106/0x430
> [ 1435.627606]  process_one_work+0x1b3/0x380
> [ 1435.627611]  worker_thread+0x30/0x360
> [ 1435.627614]  ? __pfx_worker_thread+0x10/0x10
> [ 1435.627617]  kthread+0xe8/0x110
> [ 1435.627620]  ? __pfx_kthread+0x10/0x10
> [ 1435.627623]  ret_from_fork+0x2c/0x50
> [ 1435.627627]  </TASK>
> [ 1435.627628] Modules linked in: udf crc_itu_t pktcdvd rfcomm ctr ccm =
cmac algif_hash bnep binfmt_misc ip6_tables ip6t_rt xt_set xt_multiport x=
t_recent xt_tcpudp ip_tables xt_conntrack nft_compat x_tables nft_chain_n=
at nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables ip_set_has=
h_ipport ip_set nfnetlink nls_ascii nls_cp437 vfat fat lp btusb btrtl btb=
cm btintel btmtk bluetooth uvcvideo jitterentropy_rng videobuf2_vmalloc v=
ideobuf2_memops videobuf2_v4l2 drbg videodev ansi_cprng videobuf2_common =
ecdh_generic ecc mc snd_hda_codec_hdmi amdgpu intel_rapl_msr intel_rapl_c=
ommon qmi_wwan qcserial gpu_sched cdc_wdm usb_wwan usbnet usbserial mii x=
86_pkg_temp_thermal intel_powerclamp i915 radeon snd_ctl_led coretemp snd=
_hda_codec_realtek snd_hda_codec_generic drm_buddy kvm_intel drm_display_=
helper snd_hda_intel iwldvm cec snd_intel_dspcfg snd_soc_rt5640 snd_intel=
_sdw_acpi drm_ttm_helper rc_core kvm mac80211 snd_hda_codec snd_soc_rl623=
1 dell_laptop ttm dell_wmi msr ledtrig_audio irqbypass
> [ 1435.627676]  libarc4 snd_hda_core ppdev sparse_keymap rapl drm_kms_h=
elper snd_soc_core dell_smbios intel_cstate dell_smm_hwmon snd_hwdep snd_=
compress joydev evdev iwlwifi iTCO_wdt dcdbas intel_uncore intel_pmc_bxt =
drm pcspkr efi_pstore serio_raw wmi_bmof iTCO_vendor_support dell_wmi_des=
criptor lis3lv02d_i2c watchdog parport_pc i2c_algo_bit cfg80211 snd_pcm l=
is3lv02d at24 snd_timer sg parport snd dell_rbtn soundcore dell_smo8800 r=
fkill ac button ext4 crc16 mbcache jbd2 btrfs blake2b_generic xor raid6_p=
q libcrc32c crc32c_generic algif_skcipher af_alg dm_crypt dm_mod hid_cher=
ry hid_generic usbhid hid sd_mod t10_pi crc64_rocksoft_generic sr_mod crc=
64_rocksoft crc_t10dif cdrom crct10dif_generic crc64 ahci libahci crct10d=
if_pclmul crct10dif_common crc32_pclmul crc32c_intel libata ghash_clmulni=
_intel sha512_ssse3 sha512_generic e1000e aesni_intel sdhci_pci ehci_pci =
xhci_pci ehci_hcd cqhci sdhci xhci_hcd crypto_simd scsi_mod ptp i2c_i801 =
psmouse cryptd i2c_smbus lpc_ich scsi_common mmc_core
> [ 1435.627729]  usbcore pps_core usb_common battery video wmi [last unl=
oaded: pktcdvd]
> [ 1435.627735] ---[ end trace 0000000000000000 ]---
> [ 1435.788193] RIP: 0010:pkt_submit_bio+0x398/0x430 [pktcdvd]
> [ 1435.788204] Code: 55 28 41 89 55 28 41 3b 55 40 7c 07 41 83 7d 44 01=
 74 7c 4c 89 f7 e8 97 32 e1 e9 48 8b 7c 24 10 e8 8d 32 e1 e9 e9 e6 fe ff =
ff <0f> 0b 0f 0b 49 8b 3f 48 c7 c1 a0 97 d0 c0 ba 00 0c 00 00 48 89 c6
> [ 1435.788207] RSP: 0018:ffffb6a10007b828 EFLAGS: 00010283
> [ 1435.788210] RAX: 0000000000000080 RBX: ffff8a4757170800 RCX: 0000000=
000001800
> [ 1435.788212] RDX: 0000000000001604 RSI: 0000000000001680 RDI: 0000000=
000001603
> [ 1435.788214] RBP: ffff8a4750a37480 R08: 0000000000000200 R09: fffffff=
fffffff80
> [ 1435.788216] R10: 0000000000000400 R11: 0000000000000040 R12: ffff8a4=
721bd0dc0
> [ 1435.788218] R13: 0000000000001000 R14: 0000000000000000 R15: ffff8a4=
739e56000
> [ 1435.788221] FS:  0000000000000000(0000) GS:ffff8a4826b80000(0000) kn=
lGS:0000000000000000
> [ 1435.788223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1435.788226] CR2: 0000560a548f8490 CR3: 00000001949f0003 CR4: 0000000=
0001706e0
> [ 1435.788230] ------------[ cut here ]------------
> [ 1435.788231] WARNING: CPU: 3 PID: 9 at kernel/exit.c:812 do_exit+0x91=
b/0xbe0
> [ 1435.788237] Modules linked in: udf crc_itu_t pktcdvd rfcomm ctr ccm =
cmac algif_hash bnep binfmt_misc ip6_tables ip6t_rt xt_set xt_multiport x=
t_recent xt_tcpudp ip_tables xt_conntrack nft_compat x_tables nft_chain_n=
at nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables ip_set_has=
h_ipport ip_set nfnetlink nls_ascii nls_cp437 vfat fat lp btusb btrtl btb=
cm btintel btmtk bluetooth uvcvideo jitterentropy_rng videobuf2_vmalloc v=
ideobuf2_memops videobuf2_v4l2 drbg videodev ansi_cprng videobuf2_common =
ecdh_generic ecc mc snd_hda_codec_hdmi amdgpu intel_rapl_msr intel_rapl_c=
ommon qmi_wwan qcserial gpu_sched cdc_wdm usb_wwan usbnet usbserial mii x=
86_pkg_temp_thermal intel_powerclamp i915 radeon snd_ctl_led coretemp snd=
_hda_codec_realtek snd_hda_codec_generic drm_buddy kvm_intel drm_display_=
helper snd_hda_intel iwldvm cec snd_intel_dspcfg snd_soc_rt5640 snd_intel=
_sdw_acpi drm_ttm_helper rc_core kvm mac80211 snd_hda_codec snd_soc_rl623=
1 dell_laptop ttm dell_wmi msr ledtrig_audio irqbypass
> [ 1435.788319]  libarc4 snd_hda_core ppdev sparse_keymap rapl drm_kms_h=
elper snd_soc_core dell_smbios intel_cstate dell_smm_hwmon snd_hwdep snd_=
compress joydev evdev iwlwifi iTCO_wdt dcdbas intel_uncore intel_pmc_bxt =
drm pcspkr efi_pstore serio_raw wmi_bmof iTCO_vendor_support dell_wmi_des=
criptor lis3lv02d_i2c watchdog parport_pc i2c_algo_bit cfg80211 snd_pcm l=
is3lv02d at24 snd_timer sg parport snd dell_rbtn soundcore dell_smo8800 r=
fkill ac button ext4 crc16 mbcache jbd2 btrfs blake2b_generic xor raid6_p=
q libcrc32c crc32c_generic algif_skcipher af_alg dm_crypt dm_mod hid_cher=
ry hid_generic usbhid hid sd_mod t10_pi crc64_rocksoft_generic sr_mod crc=
64_rocksoft crc_t10dif cdrom crct10dif_generic crc64 ahci libahci crct10d=
if_pclmul crct10dif_common crc32_pclmul crc32c_intel libata ghash_clmulni=
_intel sha512_ssse3 sha512_generic e1000e aesni_intel sdhci_pci ehci_pci =
xhci_pci ehci_hcd cqhci sdhci xhci_hcd crypto_simd scsi_mod ptp i2c_i801 =
psmouse cryptd i2c_smbus lpc_ich scsi_common mmc_core
> [ 1435.788398]  usbcore pps_core usb_common battery video wmi [last unl=
oaded: pktcdvd]
> [ 1435.788407] CPU: 3 PID: 9 Comm: kworker/u8:0 Tainted: G S   UD      =
      6.2.0-rc5 #4
> [ 1435.788410] Hardware name: Dell Inc. Latitude E6440/02P3T1, BIOS A05=
 02/18/2014
> [ 1435.788413] Workqueue: writeback wb_workfn (flush-253:0)
> [ 1435.788419] RIP: 0010:do_exit+0x91b/0xbe0
> [ 1435.788423] Code: e8 8a 36 a5 00 8b 83 60 13 00 00 65 01 05 51 e9 f7=
 55 e9 a8 fe ff ff 48 8b bb 98 09 00 00 31 f6 e8 ea d9 ff ff e9 24 fd ff =
ff <0f> 0b e9 49 f7 ff ff 4c 89 ee bf 05 06 00 00 e8 61 f0 00 00 e9 ea
> [ 1435.788426] RSP: 0018:ffffb6a10007bee0 EFLAGS: 00010286
> [ 1435.788429] RAX: 0000000000000000 RBX: ffff8a4700aacbc0 RCX: 0000000=
000000001
> [ 1435.788431] RDX: 0000000000000001 RSI: 0000000000002710 RDI: 0000000=
0ffffffff
> [ 1435.788433] RBP: ffff8a4700aa4800 R08: 0000000000000000 R09: c000000=
0ffffefff
> [ 1435.788436] R10: 0000000000000001 R11: ffffb6a10007b4e8 R12: ffff8a4=
700a90840
> [ 1435.788438] R13: 000000000000000b R14: 0000000000000000 R15: ffffb6a=
10007b778
> [ 1435.788440] FS:  0000000000000000(0000) GS:ffff8a4826b80000(0000) kn=
lGS:0000000000000000
> [ 1435.788443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1435.788445] CR2: 0000560a548f8490 CR3: 00000001949f0003 CR4: 0000000=
0001706e0
> [ 1435.788447] Call Trace:
> [ 1435.788449]  <TASK>
> [ 1435.788451]  ? worker_thread+0x30/0x360
> [ 1435.788458]  make_task_dead+0x6f/0x80
> [ 1435.788462]  rewind_stack_and_make_dead+0x17/0x20
> [ 1435.788466] RIP: 0000:0x0
> [ 1435.788470] Code: Unable to access opcode bytes at 0xffffffffffffffd=
6.
> [ 1435.788471] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 00=
00000000000000
> [ 1435.788473] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000000
> [ 1435.788474] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000000
> [ 1435.788475] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000=
000000000
> [ 1435.788476] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000000
> [ 1435.788477] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
> [ 1435.788479]  </TASK>
> [ 1435.788480] ---[ end trace 0000000000000000 ]---

This does not look like a new issue (eg related to this series), and
this is exactly one of the reasons we wanted to get rid of this code -
basically nobody tests it, as nobody has the ability to. That means it's
very time consuming to debug issues with it.

What is the newest kernel you've run the pktcdvd driver on?

--=20
Jens Axboe

