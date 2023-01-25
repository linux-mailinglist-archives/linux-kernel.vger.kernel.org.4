Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD22967A9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 06:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjAYFXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 00:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYFXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 00:23:11 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2031.outbound.protection.outlook.com [40.92.107.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78BA22DC4;
        Tue, 24 Jan 2023 21:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc3UpKPwr619usGG+DFL9lfYjdv8QenAujJwlA77RmPXLXQdVB0aGBulUS4f7jv2MZvqhT7XA2yHdBqmJxME5ARnkKTBnXRbzlj6ajRGxzj46vK1tI17WIapK0hUl9jQFpSm5nfbqZmd4RzCabuMZ1wLxsdV/1GH+DFK5PFJKngHvp6fuHh4HBsZDbTu+dZ5LLMFo4Vm+qefXVo9I56rOLbowQgQPywhMUaJJWqAOlYCg82Cwk4ghDtl0FmqtYxSonBGfSDu4pIuhUFjrc9CVajKPiyb4WxTc3JOe1zRaKJWVCFKA7GQqxIMBqVhDh5A0Wbd0T1tlLrb+8Nurh/yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWZqbMN8Ppjc9C+kFItIB2QRxjjPJi/Q8jJzOLC2VvE=;
 b=arGqAx3X6yuurSuMkeuWIxwGwDJ1KpWguOnL7WvjuDbAeSzMRrxlXuRbYjmoRunpTwaR5MHEU5uSdsncsweyuBLlX8Jpsm4AUzhfplqpRUYvNZGEvV3kbz2RrTNuNyDBjUYzCuG1EjbUGXBJbfD5NmVeU4aoqEpVdMN0QiJ5XosyPHPVQM8yTRCGQMKgd/GLm3iiVjnVcQeb34tJ/KOpLoP4T0BaB1MzHJjX0ed8n52Stoglr3WCQssgsW+0eXy5ALvo01r8jwt6yfpN1Bvr7iQp5apXnW/W+6uEWrnvkp6Y8vjwp8ErziKO+mBVfzWrg01kqH3YTqjUN7r/Z0e51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWZqbMN8Ppjc9C+kFItIB2QRxjjPJi/Q8jJzOLC2VvE=;
 b=gRBltHpb4zwv7ELyEgXnMT2MDU5/Us3cNo/uwqGtZpI/R4emxLZWMyiYK0v2HB4U+TvFF2Pjn+FL4wm17BR949vuvAXwa1MDIJTuDQ8WwHkOpOqNarzYmRwNY5fR5TJlghjCuXy6Azz6tX4sa1ak0Cvo4ojwbY4F3gCzi7UOr4VX6CQUxrb+dH17EPRDBRSdZobXzmFh8MMersdMsDbGqrByPWkfvpgagvZP0bKux/h1AmpGUP1iXAENyDstJjh1/48jhCyLre30XMMCamB+UAhaswbG4FcUO3doW3jmY5OO68GtOR4Gk4gyY8EZz3Wa+A6CSAlobqeqMI799XYz3g==
Received: from SG2PR02MB4090.apcprd02.prod.outlook.com (2603:1096:4:a4::16) by
 TY2PR02MB4399.apcprd02.prod.outlook.com (2603:1096:404:8011::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 05:23:06 +0000
Received: from SG2PR02MB4090.apcprd02.prod.outlook.com
 ([fe80::ef9f:f14:b935:7b92]) by SG2PR02MB4090.apcprd02.prod.outlook.com
 ([fe80::ef9f:f14:b935:7b92%6]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 05:23:06 +0000
Message-ID: <SG2PR02MB4090B1F3E5EC0B7FCCC01807D7CE9@SG2PR02MB4090.apcprd02.prod.outlook.com>
Date:   Wed, 25 Jan 2023 13:23:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
From:   Fan Chengwei <fancieux@outlook.com>
Content-Language: en-US
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: BUG: crash after suspending
To:     heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [saXblo4Hb7HtRfVIOHtz2Z36MsAp+KdDYmAq9O5KV/9kNPVqFx3P4yYtDmPOdWB7]
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To SG2PR02MB4090.apcprd02.prod.outlook.com (2603:1096:4:a4::16)
X-Microsoft-Original-Message-ID: <34e5c2c5-92d3-3f44-3455-593c7a88a6d7@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR02MB4090:EE_|TY2PR02MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: fde1b219-1499-4438-10e4-08dafe943d03
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STXE9oI2ua4jlL1YkmdWvzYJuGQu/yGzOtzsF5RKVrxpInVhspIKNer5VYMzAuU60PbU/bHi/okluGNJL03DTSn5AePa4/+/ms6S0M6iFFewf3ag3zX/9X7nt6KcIa0qz+NYJ6JwCCIWetTDlmewWkMs/u7n28/ifgxmYmOixcF0unkTC1xE+qhZwmCGA49GnByak3Mw5fq1Fg3hzM8EdLe9yL4BpU6IAK4nXuSevFJ4rqtgT3g9l4jMDzXOK2dMP0PjKTHzPSK9kBXL68OzBTKSjU8aEWQsXzmhSWFeFuS8y8pGlHARFA9ssQo6MsiiVppSZyQYH0+SGgrIzqSP094gF3FVivgHu5uhcaYYqd1M+p93pH5DHAC7EitHsNAwtFD6Ujs9daA03tselkX3qplaNj/CcIQp9spfwRVeuVhEE+8SRZWpXkERpA44zXEAfUU/YRoQammN/BkLdICWAzGZB+2JahWSKFlSpXkS1uF3NOUluUA0J5VavWvUQ/uYyCiaMDasP3WAvtQYraoK55EWmNbYF5on7J9rTY7fcQd/SN8MA7Z9wurqTfsIP4xmz8KT9+ZhjMqjW8TPftTSWw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZBc3BzSStqQW1MeFNrSU9oeHZ4QzRYZGVxVXcrNVl4WDA0MWZkRlVhbTA1?=
 =?utf-8?B?WlJMS1dIWWE3YkZjYmxtbkZZbm1TWmVRNVVvZ3hMTEdkM002NWNwdmVrc3F2?=
 =?utf-8?B?WHoxTW1xQjJ6K0k2VzlVU3NGREI0Tndhd3pKV0pId3hXQlNCOS9hMzA2a2hM?=
 =?utf-8?B?NllhUUpqK1VEdEMxQWFsMkgyWmpBa3VkNmZDcmFxZkxOWmIyZGZzTEFjZnRm?=
 =?utf-8?B?SFk2MFpBc0RybGlGTVBzYld6a3lSOFhVZUFKWmJrY0JLcVVhbWtSZWF0ekxy?=
 =?utf-8?B?K3JiWE1VRStCRlFMMi8vWWlQNzl0SXJ2R1F4SHhpN2lPdWt6OUpRQkFJbUtP?=
 =?utf-8?B?c1FwekV3NzBpNjcvZ3JQSmNvRmFsVmRTV0ZQaEs1NmpqWUJPVlpCTlJYdGJL?=
 =?utf-8?B?cnc3QU91UnNLa1cyTGNUOXdsWGhUcHY0QUlpaWsydnlvWkNSdVl5eDJqM3dx?=
 =?utf-8?B?cXYxQ0F3eUQrTDJZTTd1NW5TT3QxaDNHUEN4MTlPS1dPZVQyLzNIVUJVRFFx?=
 =?utf-8?B?OTU4T2t4RkIweEpxVk9uUXVBODI5Qko2MnRTdFVzVDBQUndTamZ0eC9TN2V4?=
 =?utf-8?B?ZVcxL09WSXZRMloxM1pGNStHU0FJSm5TME5BWHJqRVZqMzVQZlhHR2xZUE11?=
 =?utf-8?B?S3kwQmZjOWw0QXFQUUNDZHJYdWlFbnBCbzJ5ZXN5NytBQy9jSy9jaFlTaENC?=
 =?utf-8?B?QzE1bmVPTnRhcU5OWHUzNzJtL0d1TEloTEt0b3B5OEVXR1dXTVpMd283S2ZH?=
 =?utf-8?B?VVZmUUl1aHh6MW1VNC95cTMzV09ib0FlT09yYzJRRE9DOTlMSzk0WDFwL3ZC?=
 =?utf-8?B?enBSdFFLNFloSDExMFM5K0NMc2lkVUlFd2JHS0UyYkVuY1BmTkRNVURLT0hv?=
 =?utf-8?B?Z1NpQTlyZ2l6aVRnYXgzWElpMWpSZjhycFZnazkvV0VrSXJzVzlaSk9pbjM0?=
 =?utf-8?B?YWN2d2VPVUxYQWh4QWlaQWNVdkFTN25VeXdLc2FVTDhpZmlYa3JHZFRzMGhN?=
 =?utf-8?B?UDkweDVuenZldzJneWNDN25yVEE5NlNIMkw4L0FRNVl3MXc1YmU2ZUVBY2pB?=
 =?utf-8?B?L0dZYml5WmtETUY2NTRJNlA3enhRR2paOGI2RG10aVFjdDhGMFdwQmlORzlo?=
 =?utf-8?B?bDhYZ1ZqZGI4ek1HczhIK0oyR2NXWndSeWhiK0xhcy91ak9UKzdYM0FGKytu?=
 =?utf-8?B?R0JiWXFlVVFWcGdqZFArUHI5UUZ0U3pyZXlpZ1JKT1JJS0hLclJqQ3Z4VFc4?=
 =?utf-8?B?VVZxUzNSeEVQWlozbnBVajlwZkx1Y05yMXZ1b05FTzRFN1UzYXNpQUdmZW9z?=
 =?utf-8?B?aDA4WVVWUk9aTmwrdjhUSDlTbWdQaEtDdGw1MytpTHBlVU9OMGt3R0dBNGM2?=
 =?utf-8?B?TnZTUzRMNnFvRCt4YUg4dVR3cWxSQjBSREkreENadUdmMXY0TFRxVWNBSlUw?=
 =?utf-8?B?cEV3RmZNZ1hJU3F1UVJYZW9UL0EyRUFFNFpGellQRUZiK0hrWWRhNDVGdUNq?=
 =?utf-8?B?ZGNkSDhQZWFUNjIxNWRRNjBCSHJNUjhuUW5GR1djNGMxYjdud0NVakVmLzJX?=
 =?utf-8?B?WHNoS1h5V3hYNlo2Qll1ZzRtNXY4QXpybTNaekw3aGFQa1h6M3E5WWswejA3?=
 =?utf-8?B?cWxGS3kxSTM3d21ScW14b1NUTVZlbVR6aW1aK015U3lsU2Zzem5sRm5KdEhM?=
 =?utf-8?B?cU5CTlRhc2IzajUzMUZBdUM1cHdlamxUKytKWFhoeTYvdnVuNkFweDhOWVVU?=
 =?utf-8?B?aTRzeHNPTHBaU2JxL2xxaU96VXFPcTluZGRuZWtxRTFNd0R3bUN0Z3d0NGFV?=
 =?utf-8?B?RzNHdzZEK2NyY1NMUjFmUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde1b219-1499-4438-10e4-08dafe943d03
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4090.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 05:23:06.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB4399
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

My laptop crash after suspending due to failure of driver of usb type c.

This may be a follow-up to 
https://bugzilla.kernel.org/show_bug.cgi?id=216706 and 
https://bugzilla.kernel.org/show_bug.cgi?id=216697. You mentioned a 
patch in BUG 216697 above, which was merged into mainline in 6.2.0-rc5. 
But I tried 6.2.0-rc5 yesterday and it still doesn't work.

I add a comment here in 
https://bugzilla.kernel.org/show_bug.cgi?id=216697#c11 and there is some 
discussion in https://bbs.archlinux.org/viewtopic.php?id=282999.

Bisection shows that
> # first bad commit: [4e3a50293c2b21961f02e1afa2f17d3a1a90c7c8] usb: 
typec: ucsi: acpi: Implement resume callback
which makes my laptop freezes when resuming from suspend. While in 
https://bugzilla.kernel.org/show_bug.cgi?id=216706, someone reports that 
the same commit causes that USBC resume callback takes far too long.

That bad commit was merged in mainline in 6.1.0-rc2, which causes my 
laptop to freeze and journalctl can't capture any message. While after 
the archlinux kernel package is upgraded to 6.1.1 and later, the system 
will not be stuck, but a oops will be displayed, I posted it here 
https://bbs.archlinux.org/viewtopic.php?id=282999. And following is the 
dmesg in 6.2.0-rc5:
 > [   29.677975] Oops: 0000 [#1] PREEMPT SMP PTI
 > [   29.677981] CPU: 4 PID: 73 Comm: kworker/4:1 Not tainted 
6.2.0-rc5-1-mainline #1 9dd3e34c332001c1d20c681d031ef729664f899d
 > [   29.677989] Hardware name: LENOVO 81HX/LNVNB161216, BIOS 
6UCN53WW(V4.08) 09/26/2018
 > [   29.677992] Workqueue: events_long ucsi_resume_work [typec_ucsi]
 > [   29.678017] RIP: 0010:ucsi_resume_work+0x32/0x80 [typec_ucsi]
 > [   29.678037] Code: 00 55 31 c9 31 d2 53 48 8b b7 a0 00 00 00 48 89 
fb 48 83 ef 38 48 83 ce 05 e8 5a f6 ff ff 85 c0 0f 88 95 22 00 00 48 8b 
5b f8 <48> 83 bb 88 00 00 00 00 74 3b 48 8d 6b 10 48 89 ef e8 f8 57 a6 e2
 > [   29.678041] RSP: 0000:ffffb2dac030fe80 EFLAGS: 00010246
 > [   29.678047] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000002
 > [   29.678050] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 
ffff91b009189db8
 > [   29.678053] RBP: ffff91b169f32b00 R08: 0000000000000001 R09: 
0000000000000000
 > [   29.678056] R10: 0000000000000004 R11: 0000000000000000 R12: 
ffff91b169f38b00
 > [   29.678059] R13: 0000000000000000 R14: ffff91b000f5dc00 R15: 
ffff91b009189d40
 > [   29.678063] FS:  0000000000000000(0000) GS:ffff91b169f00000(0000) 
knlGS:0000000000000000
 > [   29.678067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > [   29.678071] CR2: 0000000000000088 CR3: 000000005e810001 CR4: 
00000000003706e0
 > [   29.678075] Call Trace:
 > [   29.678080]  <TASK>
 > [   29.678085]  process_one_work+0x1c5/0x380
 > [   29.678099]  worker_thread+0x51/0x390
 > [   29.678109]  ? __pfx_worker_thread+0x10/0x10
 > [   29.678117]  kthread+0xdb/0x110
 > [   29.678124]  ? __pfx_kthread+0x10/0x10
 > [   29.678130]  ret_from_fork+0x29/0x50
 > [   29.678146]  </TASK>
 > [   29.678148] Modules linked in: nft_chain_nat xt_REDIRECT nf_nat 
nf_conntrack xt_mark nft_compat nf_tables libcrc32c nfnetlink 
snd_soc_avs xt_TPROXY snd_soc_hda_codec nf_tproxy_ipv6 snd_soc_skl 
nf_tproxy_ipv4 nf_defrag_ipv6 snd_soc_hdac_hda nf_defrag_ipv4 
snd_hda_ext_core snd_soc_sst_ipc intel_tcc_cooling snd_soc_sst_dsp 
x86_pkg_temp_thermal snd_soc_acpi_intel_match intel_powerclamp kvm_intel 
snd_soc_acpi snd_soc_core ccm snd_hda_codec_hdmi algif_aead snd_compress 
snd_hda_codec_conexant kvm snd_hda_codec_generic ac97_bus cbc 
ledtrig_audio irqbypass ath10k_pci snd_pcm_dmaengine crct10dif_pclmul 
crc32_pclmul hid_logitech_hidpp polyval_clmulni des_generic 
snd_hda_intel polyval_generic libdes gf128mul snd_intel_dspcfg 
ath10k_core ecb ghash_clmulni_intel snd_intel_sdw_acpi sha512_ssse3 
iTCO_wdt snd_hda_codec ath intel_pmc_bxt aesni_intel algif_skcipher 
uvcvideo cmac joydev snd_hda_core serio_raw crypto_simd snd_hwdep 
iTCO_vendor_support mei_hdcp mousedev mei_pxp intel_rapl_msr 8021q atkbd
 > [   29.678263]  cryptd hid_logitech_dj garp libps2 md4 btusb 
videobuf2_vmalloc snd_pcm mrp mac80211 rapl vivaldi_fmap algif_hash 
videobuf2_memops processor_thermal_device_pci_legacy btrtl snd_timer 
r8169 btbcm stp intel_cstate af_alg llc videobuf2_v4l2 snd coretemp 
processor_thermal_device i2c_i801 libarc4 intel_uncore btintel realtek 
btmtk intel_wmi_thunderbolt wmi_bmof mdio_devres i2c_smbus soundcore 
ucsi_acpi mei_me processor_thermal_rfim cfg80211 bluetooth videodev 
libphy typec_ucsi processor_thermal_mbox intel_lpss_pci vfat 
i2c_hid_acpi mei processor_thermal_rapl intel_lpss fat idma64 typec 
ecdh_generic videobuf2_common i2c_hid intel_xhci_usb_role_switch 
intel_rapl_common mc usbhid intel_soc_dts_iosf intel_pch_thermal roles 
elan_i2c ideapad_laptop sparse_keymap platform_profile int3403_thermal 
rfkill int340x_thermal_zone i8042 serio int3400_thermal soc_button_array 
acpi_thermal_rel acpi_pad mac_hid vmw_vmci pkcs8_key_parser dm_multipath 
crypto_user fuse bpf_preload ip_tables x_tables
 > [   29.678388]  ext4 crc32c_generic crc16 mbcache jbd2 dm_mod nvme 
nvme_core crc32c_intel xhci_pci nvme_common xhci_pci_renesas i915 
drm_buddy intel_gtt video wmi drm_display_helper cec ttm
 > [   29.678420] CR2: 0000000000000088
 > [   29.678424] ---[ end trace 0000000000000000 ]---
 > [   29.678426] RIP: 0010:ucsi_resume_work+0x32/0x80 [typec_ucsi]
 > [   29.678445] Code: 00 55 31 c9 31 d2 53 48 8b b7 a0 00 00 00 48 89 
fb 48 83 ef 38 48 83 ce 05 e8 5a f6 ff ff 85 c0 0f 88 95 22 00 00 48 8b 
5b f8 <48> 83 bb 88 00 00 00 00 74 3b 48 8d 6b 10 48 89 ef e8 f8 57 a6 e2
 > [   29.678449] RSP: 0000:ffffb2dac030fe80 EFLAGS: 00010246
 > [   29.678454] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000002
 > [   29.678457] RDX: 0000000000000000 RSI: 0000000000000246 RDI: 
ffff91b009189db8
 > [   29.678460] RBP: ffff91b169f32b00 R08: 0000000000000001 R09: 
0000000000000000
 > [   29.678462] R10: 0000000000000004 R11: 0000000000000000 R12: 
ffff91b169f38b00
 > [   29.678465] R13: 0000000000000000 R14: ffff91b000f5dc00 R15: 
ffff91b009189d40
 > [   29.678468] FS:  0000000000000000(0000) GS:ffff91b169f00000(0000) 
knlGS:0000000000000000
 > [   29.678472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > [   29.678475] CR2: 0000000000000088 CR3: 000000005e810001 CR4: 
00000000003706e0
Although you merged a patch in 6.2.0-rc5, nothing seems to have changed.

I also noticed one more thing, since I started using linux system every 
time I boot there is a message:
 > ucsi_acpi USBC000:00: PPM init failed (-16)
Its return value sometimes changes, about 70% is -16, 20% is -19, 10% is 
-110, and sporadically -22, -95. On the past system, this will not cause 
any problems. I thought it was completely harmless. But one time when I 
was testing the kernel this error did not appear and the system resumed 
normally from suspending, even though it was a bad kernel. This happens 
once in about 150 boots, I can't reproduce it. Besides, even on a bad 
kernel, as long as after entering the system, `rmmod ucsi_acpi 
typec_ucsi` and then modprobe them. The system can resume normally.

I'm not an experienced linux user and I don't know much about it, I hope 
to get your help.

Best,
Chengwei
