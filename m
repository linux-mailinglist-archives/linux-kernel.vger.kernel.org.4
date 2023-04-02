Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A676D38A2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDBPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDBPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:00:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED657A98
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 08:00:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso18265123wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680447616; x=1683039616;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSXBpjNIfAZb7ePYZTTtcoPttI3k4uY8GZ4lxKggzHw=;
        b=Hh5OEwLP9pfuc25Bb92TlOrH0LpPGS0aiTGi9a8yDsvmGY9GQify37QRRHu/RjzHpf
         wjXUhybHDcBIK0tLmcmxqAkZ1ilsJN2duLuaDKLzYHKF+X3EECGdmDtGO+wSVxAiYBYQ
         QEr45ripvXKSzY/6I3IU28K2BrrdS0MQIzoTljvA/3H4IaL4mVKSPYTsRFkLkJGEtQ53
         teCWsO1oTV7LvwQDemMZP7rnJBSKr2g1zaWJ5C6vsmizBXqj3nb8U0twGcYncFHyvZ4P
         FJWhZG/0QHXGgqjrExd8S6YISgaPbBbguPPuBjPBnMSde4693XNsOEOLGtHIuRSGeZr6
         6omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680447616; x=1683039616;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lSXBpjNIfAZb7ePYZTTtcoPttI3k4uY8GZ4lxKggzHw=;
        b=jb92NjdR7SkhFwtvliAs3op5tml0EsWCEgZ8+/tjI5iltqOOJLMNh/zrv9Z18a+mlo
         euuE6ZBHj7zxr6/JSIqIrIsPVT8RU6IpdLTZ7vkMSBexHni8k4xt7XLJAI1Y/z9jjORL
         D5Jzue8iscVTG+YGsV8cE7wI7dx9SgNvyC1kqcSRwBLtQEwY836+a420t7+qfAs4TAt4
         5cOYo/NB2BuWas7ann+8YKAlYLa5NPRXWD7nBthlL8hHXzNd73KU+EFoqQ5aHsCpeHbX
         vKBqrvbBr/i9o2Qmb+jix3kEpvgWBMejA1koUPo3muFWV9QVcLWRnUUKEOUyWKXy88TS
         Kl/w==
X-Gm-Message-State: AAQBX9evJp2GPcbzHUbmb75C/1slZr/wBKCmrS8RMS5yJ6vG/+7c2YtU
        cSXFD7SSMYqgn/u5WEIv9IE=
X-Google-Smtp-Source: AKy350Y/YwFfC1OvX9VMuBzPbYSWIINUpn6ug/4MD4Ndy2D3mkxph1w+9suQvnhW3xJpC4DuZUmGEQ==
X-Received: by 2002:a05:600c:310e:b0:3f0:4570:b834 with SMTP id g14-20020a05600c310e00b003f04570b834mr6234211wmo.0.1680447615614;
        Sun, 02 Apr 2023 08:00:15 -0700 (PDT)
Received: from [192.168.0.103] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id q9-20020a1cf309000000b003f04f0c5a6fsm2521167wmq.26.2023.04.02.08.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 08:00:14 -0700 (PDT)
Message-ID: <39dc735c-fd6d-e405-856c-788a52704d63@gmail.com>
Date:   Sun, 2 Apr 2023 17:00:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [BUG] staging: rtl8192e: oops occurs when finding hardware rtl8192se
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when I use the hardware rtl8192se the driver 
drivers/staging/rtl8192e/rtl8192e/r8192e_pci.ko detects that it should 
not run on this hardware and aborts.
But when the driver is freeing the resources an oops occures. Find oops 
at the end of this Email.

When I comment out the following lines those errors disappear:
cancel_delayed_work_sync(&ieee->hw_wakeup_wq);
cancel_delayed_work_sync(&ieee->hw_sleep_wq);
cancel_work_sync(&ieee->ips_leave_wq);

When I do an init before the cancel:
INIT_DELAYED_WORK(&priv->rtllib->hw_wakeup_wq, (void *)rtl92e_hw_wakeup_wq);
The oops are gone as well.

When I use cancel_delayed_work() instead of cancel_delayed_work_sync() 
it also works.

Can somebody give me a hint what the expected way is to solve this?

Thanks for your support.

Philipp




kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ sudo dmesg -c
[17498.738997] rtl819xE 0000:03:00.0: Freeing irq 16
[17498.788312] lib80211_crypt: unregistered algorithm 'R-CCMP'
[17498.823409] lib80211_crypt: unregistered algorithm 'R-WEP'
[17498.850483] lib80211_crypt: unregistered algorithm 'R-TKIP'
[17517.546303] rtllib: module is from the staging directory, the quality 
is unknown, you have been warned.
[17517.556731] rtllib_crypt_tkip: module is from the staging directory, 
the quality is unknown, you have been warned.
[17517.557042] lib80211_crypt: registered algorithm 'R-TKIP'
[17517.565264] rtllib_crypt_wep: module is from the staging directory, 
the quality is unknown, you have been warned.
[17517.565639] lib80211_crypt: registered algorithm 'R-WEP'
[17517.576821] rtllib_crypt_ccmp: module is from the staging directory, 
the quality is unknown, you have been warned.
[17517.577095] lib80211_crypt: registered algorithm 'R-CCMP'
[17518.603762] r8192e_pci: module is from the staging directory, the 
quality is unknown, you have been warned.
[17518.606673] rtl819xE 0000:03:00.0: Memory mapped space start: 0xf7b00000
[17518.606712] ------------[ cut here ]------------
[17518.606714] WARNING: CPU: 0 PID: 27845 at kernel/workqueue.c:3167 
__flush_work+0x22f/0x240
[17518.606724] Modules linked in: r8192e_pci(COE+) 
rtllib_crypt_ccmp(COE) rtllib_crypt_wep(COE) rtllib_crypt_tkip(COE) 
rtllib(COE) ccm cfg80211 lib80211 libarc4 snd_seq_dummy xt_conntrack 
xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo 
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c 
xt_addrtype iptable_filter bpfilter br_netfilter bridge stp llc overlay 
nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_conexant 
snd_hda_codec_generic ledtrig_audio intel_rapl_msr intel_rapl_common 
sch5627 mei_hdcp binfmt_misc x86_pkg_temp_thermal intel_powerclamp i915 
coretemp kvm_intel snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm 
snd_hda_codec drm_buddy snd_hda_core ttm snd_hwdep crct10dif_pclmul 
ghash_clmulni_intel snd_pcm drm_display_helper sha512_ssse3 aesni_intel 
snd_seq_midi cec crypto_simd sch56xx_common snd_seq_midi_event cryptd 
rc_core snd_rawmidi joydev rapl intel_cstate snd_seq drm_kms_helper 
input_leds snd_seq_device snd_timer at24 i2c_algo_bit syscopyarea 
serio_raw sysfillrect snd
[17518.606809]  mei_me sysimgblt soundcore mei tpm_infineon mac_hid 
sch_fq_codel msr parport_pc ppdev lp ramoops parport reed_solomon drm 
efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid ahci 
crc32_pclmul lpc_ich e1000e i2c_i801 xhci_pci libahci xhci_pci_renesas 
i2c_smbus video wmi [last unloaded: rtllib(COE)]
[17518.606844] CPU: 0 PID: 27845 Comm: insmod Tainted: G        WC OE 
6.3.0-rc1+ #7
[17518.606848] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS 
V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[17518.606851] RIP: 0010:__flush_work+0x22f/0x240
[17518.606856] Code: 8b 43 28 48 8b 53 30 89 c1 e9 f9 fe ff ff 4c 89 f7 
e8 a5 1a d8 00 e8 d0 d2 08 00 45 31 ff e9 11 ff ff ff 0f 0b e9 0a ff ff 
ff <0f> 0b 45 31 ff e9 00 ff ff ff e8 22 b7 d6 00 66 90 90 90 90 90 90
[17518.606859] RSP: 0018:ffffbd48819a38b0 EFLAGS: 00010246
[17518.606863] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[17518.606865] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff96d65f8a7960
[17518.606867] RBP: ffffbd48819a3928 R08: 0000000000000000 R09: 
ffffbd4881cf1000
[17518.606869] R10: ffffffff867da3c0 R11: ffff96d70aaa51f8 R12: 
ffff96d65f8a7960
[17518.606871] R13: 0000000000000001 R14: ffff96d65c086400 R15: 
0000000000000001
[17518.606873] FS:  00007f08a1f93740(0000) GS:ffff96d756200000(0000) 
knlGS:0000000000000000
[17518.606876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17518.606878] CR2: 000056259a089558 CR3: 0000000116948005 CR4: 
00000000001706f0
[17518.606881] Call Trace:
[17518.606884]  <TASK>
[17518.606886]  ? find_next_iomem_res+0xf1/0x110
[17518.606894]  ? preempt_count_add+0x7c/0xc0
[17518.606901]  __cancel_work_timer+0x124/0x1b0
[17518.606907]  ? __try_to_del_timer_sync+0x67/0xa0
[17518.606914]  cancel_delayed_work_sync+0x13/0x20
[17518.606919]  rtllib_softmac_free+0x7d/0xe0 [rtllib]
[17518.606941]  free_rtllib+0x27/0x70 [rtllib]
[17518.606955]  _rtl92e_pci_probe+0x1e9/0x1190 [r8192e_pci]
[17518.606976]  ? up_write+0x3c/0x70
[17518.606981]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[17518.607006]  local_pci_probe+0x4b/0xb0
[17518.607015]  pci_device_probe+0xc8/0x240
[17518.607019]  really_probe+0x177/0x3e0
[17518.607026]  __driver_probe_device+0x7e/0x180
[17518.607031]  driver_probe_device+0x23/0xa0
[17518.607036]  __driver_attach+0xc5/0x190
[17518.607040]  ? __pfx___driver_attach+0x10/0x10
[17518.607045]  bus_for_each_dev+0x7c/0xd0
[17518.607049]  driver_attach+0x1e/0x30
[17518.607053]  bus_add_driver+0x11c/0x220
[17518.607058]  driver_register+0x64/0x130
[17518.607063]  ? __pfx_init_module+0x10/0x10 [r8192e_pci]
[17518.607097]  __pci_register_driver+0x68/0x70
[17518.607100]  rtl8192_pci_driver_init+0x23/0xff0 [r8192e_pci]
[17518.607109]  do_one_initcall+0x48/0x220
[17518.607113]  ? kmalloc_trace+0x2a/0xa0
[17518.607117]  do_init_module+0x52/0x220
[17518.607120]  load_module+0x20ad/0x2380
[17518.607124]  __do_sys_finit_module+0xc8/0x140
[17518.607126]  ? __do_sys_finit_module+0xc8/0x140
[17518.607129]  __x64_sys_finit_module+0x1a/0x20
[17518.607131]  do_syscall_64+0x3b/0x90
[17518.607134]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[17518.607137] RIP: 0033:0x7f08a1b2673d
[17518.607139] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 23 37 0d 00 f7 d8 64 89 01 48
[17518.607140] RSP: 002b:00007ffdd0a30378 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[17518.607142] RAX: ffffffffffffffda RBX: 000056259a085770 RCX: 
00007f08a1b2673d
[17518.607144] RDX: 0000000000000000 RSI: 0000562598108358 RDI: 
0000000000000003
[17518.607145] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007f08a1bfd580
[17518.607146] R10: 0000000000000003 R11: 0000000000000246 R12: 
0000562598108358
[17518.607147] R13: 0000000000000000 R14: 000056259a088550 R15: 
0000000000000000
[17518.607149]  </TASK>
[17518.607150] ---[ end trace 0000000000000000 ]---
[17518.607153] ------------[ cut here ]------------
[17518.607153] WARNING: CPU: 0 PID: 27845 at kernel/workqueue.c:3167 
__flush_work+0x22f/0x240
[17518.607157] Modules linked in: r8192e_pci(COE+) 
rtllib_crypt_ccmp(COE) rtllib_crypt_wep(COE) rtllib_crypt_tkip(COE) 
rtllib(COE) ccm cfg80211 lib80211 libarc4 snd_seq_dummy xt_conntrack 
xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo 
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c 
xt_addrtype iptable_filter bpfilter br_netfilter bridge stp llc overlay 
nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_conexant 
snd_hda_codec_generic ledtrig_audio intel_rapl_msr intel_rapl_common 
sch5627 mei_hdcp binfmt_misc x86_pkg_temp_thermal intel_powerclamp i915 
coretemp kvm_intel snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm 
snd_hda_codec drm_buddy snd_hda_core ttm snd_hwdep crct10dif_pclmul 
ghash_clmulni_intel snd_pcm drm_display_helper sha512_ssse3 aesni_intel 
snd_seq_midi cec crypto_simd sch56xx_common snd_seq_midi_event cryptd 
rc_core snd_rawmidi joydev rapl intel_cstate snd_seq drm_kms_helper 
input_leds snd_seq_device snd_timer at24 i2c_algo_bit syscopyarea 
serio_raw sysfillrect snd
[17518.607198]  mei_me sysimgblt soundcore mei tpm_infineon mac_hid 
sch_fq_codel msr parport_pc ppdev lp ramoops parport reed_solomon drm 
efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid ahci 
crc32_pclmul lpc_ich e1000e i2c_i801 xhci_pci libahci xhci_pci_renesas 
i2c_smbus video wmi [last unloaded: rtllib(COE)]
[17518.607217] CPU: 0 PID: 27845 Comm: insmod Tainted: G        WC OE 
6.3.0-rc1+ #7
[17518.607219] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS 
V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[17518.607220] RIP: 0010:__flush_work+0x22f/0x240
[17518.607222] Code: 8b 43 28 48 8b 53 30 89 c1 e9 f9 fe ff ff 4c 89 f7 
e8 a5 1a d8 00 e8 d0 d2 08 00 45 31 ff e9 11 ff ff ff 0f 0b e9 0a ff ff 
ff <0f> 0b 45 31 ff e9 00 ff ff ff e8 22 b7 d6 00 66 90 90 90 90 90 90
[17518.607224] RSP: 0018:ffffbd48819a38b0 EFLAGS: 00010246
[17518.607225] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[17518.607226] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff96d65f8a79b8
[17518.607227] RBP: ffffbd48819a3928 R08: 0000000000000000 R09: 
ffffbd4881cf1000
[17518.607228] R10: ffffffff867da3c0 R11: ffff96d70aaa51f8 R12: 
ffff96d65f8a79b8
[17518.607229] R13: 0000000000000001 R14: ffff96d65c086400 R15: 
0000000000000001
[17518.607231] FS:  00007f08a1f93740(0000) GS:ffff96d756200000(0000) 
knlGS:0000000000000000
[17518.607232] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17518.607233] CR2: 000056259a089558 CR3: 0000000116948005 CR4: 
00000000001706f0
[17518.607234] Call Trace:
[17518.607235]  <TASK>
[17518.607236]  ? find_next_iomem_res+0xf1/0x110
[17518.607239]  ? preempt_count_add+0x7c/0xc0
[17518.607242]  __cancel_work_timer+0x124/0x1b0
[17518.607245]  ? __try_to_del_timer_sync+0x67/0xa0
[17518.607249]  cancel_delayed_work_sync+0x13/0x20
[17518.607251]  rtllib_softmac_free+0x89/0xe0 [rtllib]
[17518.607262]  free_rtllib+0x27/0x70 [rtllib]
[17518.607269]  _rtl92e_pci_probe+0x1e9/0x1190 [r8192e_pci]
[17518.607279]  ? up_write+0x3c/0x70
[17518.607281]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[17518.607285]  local_pci_probe+0x4b/0xb0
[17518.607288]  pci_device_probe+0xc8/0x240
[17518.607290]  really_probe+0x177/0x3e0
[17518.607293]  __driver_probe_device+0x7e/0x180
[17518.607296]  driver_probe_device+0x23/0xa0
[17518.607298]  __driver_attach+0xc5/0x190
[17518.607300]  ? __pfx___driver_attach+0x10/0x10
[17518.607303]  bus_for_each_dev+0x7c/0xd0
[17518.607305]  driver_attach+0x1e/0x30
[17518.607307]  bus_add_driver+0x11c/0x220
[17518.607309]  driver_register+0x64/0x130
[17518.607312]  ? __pfx_init_module+0x10/0x10 [r8192e_pci]
[17518.607321]  __pci_register_driver+0x68/0x70
[17518.607324]  rtl8192_pci_driver_init+0x23/0xff0 [r8192e_pci]
[17518.607332]  do_one_initcall+0x48/0x220
[17518.607335]  ? kmalloc_trace+0x2a/0xa0
[17518.607339]  do_init_module+0x52/0x220
[17518.607341]  load_module+0x20ad/0x2380
[17518.607344]  __do_sys_finit_module+0xc8/0x140
[17518.607346]  ? __do_sys_finit_module+0xc8/0x140
[17518.607349]  __x64_sys_finit_module+0x1a/0x20
[17518.607351]  do_syscall_64+0x3b/0x90
[17518.607353]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[17518.607356] RIP: 0033:0x7f08a1b2673d
[17518.607357] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 23 37 0d 00 f7 d8 64 89 01 48
[17518.607359] RSP: 002b:00007ffdd0a30378 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[17518.607360] RAX: ffffffffffffffda RBX: 000056259a085770 RCX: 
00007f08a1b2673d
[17518.607361] RDX: 0000000000000000 RSI: 0000562598108358 RDI: 
0000000000000003
[17518.607362] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007f08a1bfd580
[17518.607363] R10: 0000000000000003 R11: 0000000000000246 R12: 
0000562598108358
[17518.607364] R13: 0000000000000000 R14: 000056259a088550 R15: 
0000000000000000
[17518.607366]  </TASK>
[17518.607367] ---[ end trace 0000000000000000 ]---
[17518.607370] ------------[ cut here ]------------
[17518.607370] WARNING: CPU: 0 PID: 27845 at kernel/workqueue.c:3167 
__flush_work+0x22f/0x240
[17518.607373] Modules linked in: r8192e_pci(COE+) 
rtllib_crypt_ccmp(COE) rtllib_crypt_wep(COE) rtllib_crypt_tkip(COE) 
rtllib(COE) ccm cfg80211 lib80211 libarc4 snd_seq_dummy xt_conntrack 
xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo 
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c 
xt_addrtype iptable_filter bpfilter br_netfilter bridge stp llc overlay 
nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_conexant 
snd_hda_codec_generic ledtrig_audio intel_rapl_msr intel_rapl_common 
sch5627 mei_hdcp binfmt_misc x86_pkg_temp_thermal intel_powerclamp i915 
coretemp kvm_intel snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm 
snd_hda_codec drm_buddy snd_hda_core ttm snd_hwdep crct10dif_pclmul 
ghash_clmulni_intel snd_pcm drm_display_helper sha512_ssse3 aesni_intel 
snd_seq_midi cec crypto_simd sch56xx_common snd_seq_midi_event cryptd 
rc_core snd_rawmidi joydev rapl intel_cstate snd_seq drm_kms_helper 
input_leds snd_seq_device snd_timer at24 i2c_algo_bit syscopyarea 
serio_raw sysfillrect snd
[17518.607414]  mei_me sysimgblt soundcore mei tpm_infineon mac_hid 
sch_fq_codel msr parport_pc ppdev lp ramoops parport reed_solomon drm 
efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid ahci 
crc32_pclmul lpc_ich e1000e i2c_i801 xhci_pci libahci xhci_pci_renesas 
i2c_smbus video wmi [last unloaded: rtllib(COE)]
[17518.607432] CPU: 0 PID: 27845 Comm: insmod Tainted: G        WC OE 
6.3.0-rc1+ #7
[17518.607434] Hardware name: FUJITSU ESPRIMO P710/D3161-A1, BIOS 
V4.6.5.3 R1.16.0 for D3161-A1x 10/29/2012
[17518.607435] RIP: 0010:__flush_work+0x22f/0x240
[17518.607437] Code: 8b 43 28 48 8b 53 30 89 c1 e9 f9 fe ff ff 4c 89 f7 
e8 a5 1a d8 00 e8 d0 d2 08 00 45 31 ff e9 11 ff ff ff 0f 0b e9 0a ff ff 
ff <0f> 0b 45 31 ff e9 00 ff ff ff e8 22 b7 d6 00 66 90 90 90 90 90 90
[17518.607439] RSP: 0018:ffffbd48819a38b0 EFLAGS: 00010246
[17518.607440] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[17518.607441] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff96d65f8a77e0
[17518.607442] RBP: ffffbd48819a3928 R08: 0000000000000000 R09: 
ffffbd4881cf1000
[17518.607443] R10: ffffffff867da3c0 R11: ffff96d70aaa51f8 R12: 
ffff96d65f8a77e0
[17518.607444] R13: 0000000000000000 R14: ffff96d65c086400 R15: 
0000000000000001
[17518.607445] FS:  00007f08a1f93740(0000) GS:ffff96d756200000(0000) 
knlGS:0000000000000000
[17518.607446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17518.607447] CR2: 000056259a089558 CR3: 0000000116948005 CR4: 
00000000001706f0
[17518.607449] Call Trace:
[17518.607449]  <TASK>
[17518.607450]  ? find_next_iomem_res+0xf1/0x110
[17518.607453]  ? preempt_count_add+0x7c/0xc0
[17518.607456]  __cancel_work_timer+0x124/0x1b0
[17518.607458]  ? __try_to_del_timer_sync+0x67/0xa0
[17518.607462]  cancel_work_sync+0x10/0x20
[17518.607464]  rtllib_softmac_free+0xad/0xe0 [rtllib]
[17518.607474]  free_rtllib+0x27/0x70 [rtllib]
[17518.607481]  _rtl92e_pci_probe+0x1e9/0x1190 [r8192e_pci]
[17518.607491]  ? up_write+0x3c/0x70
[17518.607493]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[17518.607497]  local_pci_probe+0x4b/0xb0
[17518.607500]  pci_device_probe+0xc8/0x240
[17518.607502]  really_probe+0x177/0x3e0
[17518.607505]  __driver_probe_device+0x7e/0x180
[17518.607507]  driver_probe_device+0x23/0xa0
[17518.607510]  __driver_attach+0xc5/0x190
[17518.607512]  ? __pfx___driver_attach+0x10/0x10
[17518.607515]  bus_for_each_dev+0x7c/0xd0
[17518.607517]  driver_attach+0x1e/0x30
[17518.607519]  bus_add_driver+0x11c/0x220
[17518.607521]  driver_register+0x64/0x130
[17518.607524]  ? __pfx_init_module+0x10/0x10 [r8192e_pci]
[17518.607532]  __pci_register_driver+0x68/0x70
[17518.607535]  rtl8192_pci_driver_init+0x23/0xff0 [r8192e_pci]
[17518.607543]  do_one_initcall+0x48/0x220
[17518.607546]  ? kmalloc_trace+0x2a/0xa0
[17518.607550]  do_init_module+0x52/0x220
[17518.607551]  load_module+0x20ad/0x2380
[17518.607555]  __do_sys_finit_module+0xc8/0x140
[17518.607557]  ? __do_sys_finit_module+0xc8/0x140
[17518.607560]  __x64_sys_finit_module+0x1a/0x20
[17518.607561]  do_syscall_64+0x3b/0x90
[17518.607564]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[17518.607567] RIP: 0033:0x7f08a1b2673d
[17518.607568] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 23 37 0d 00 f7 d8 64 89 01 48
[17518.607569] RSP: 002b:00007ffdd0a30378 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[17518.607571] RAX: ffffffffffffffda RBX: 000056259a085770 RCX: 
00007f08a1b2673d
[17518.607572] RDX: 0000000000000000 RSI: 0000562598108358 RDI: 
0000000000000003
[17518.607573] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007f08a1bfd580
[17518.607574] R10: 0000000000000003 R11: 0000000000000246 R12: 
0000562598108358
[17518.607575] R13: 0000000000000000 R14: 000056259a088550 R15: 
0000000000000000
[17518.607577]  </TASK>
[17518.607577] ---[ end trace 0000000000000000 ]---
