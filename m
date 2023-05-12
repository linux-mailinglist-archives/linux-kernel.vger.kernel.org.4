Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56AE70087A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbjELMv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbjELMvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:51:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCEADD90;
        Fri, 12 May 2023 05:51:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3063891d61aso9479599f8f.0;
        Fri, 12 May 2023 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683895892; x=1686487892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgLcpkOWjTuKgLbFL1cilELC3qgg7jjF46hKO6uvH6M=;
        b=oTkkeSWsttEZNS2wqBOIoDatoMqrfPswSu82LAzhnGIyJ7B4YXbuVF23HAToR71Beo
         FXwRJXw8AfZdp+GYoURQbAdr+7uwoHvgKXooptxLRWdka+60UvPs0nMXRxKmKoi/reIQ
         krgCSdBT8X2OwnBImjly11/nbqrP0ubtb6+iRMy/IQnDST9dk6gO+V+j+NH85gWwrYUE
         yZhX33I8oGm9UMcAVIiTJWtOawidfEkUsWWCBzidncUyVMZz4duk/uBgj/MURZXA0N0M
         8WwPzr+gTU0b9bwUlBTmZjVO8cmK46tWicChKs9Dq/9C9WQJnHyyOgVGUdOPAbY2eF25
         E3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683895892; x=1686487892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgLcpkOWjTuKgLbFL1cilELC3qgg7jjF46hKO6uvH6M=;
        b=B1I71IjJf0pZ7LbpLm6Vbgv0Phwmbq+NWpPPCICMTaxqNYYK7mJ1Xv6qYL9ci4Jvvk
         ZFfM/YrwLpGsPsqeBzHZZfpGavUMxFICi3tBuAz+B2SZWFSh6bmJVDoWyOi9sbh//hwW
         u/2G5pyAnC1g9MR1U73BVB3tmIsLy4+StqeaM3qQkrotp9ae9MZZqoUF9JCpJPrUejrr
         4DS42n+P7E/XnAqZL3IwOxb8qikwise/kl+TgB3xaniq7mIFY+cVwoHLDGruK83cXFpk
         qFoQFBHmJ3bdjq4cmgRtmEIh1SMLZ2mB6ZkTdcrgKVALfIYTVg0azDbKYNJCM0NUV/1E
         I07g==
X-Gm-Message-State: AC+VfDxN1oYYFztYan9fjMqvokZNvOcVL38ph50ZTufcyG/NJfA9JpYh
        QVIsR8caRQ8gbz18tUs4F90cvwn8E1g=
X-Google-Smtp-Source: ACHHUZ6mtWJ0L6q1tUMub8NAYzVbvLAVB9ukIA9kOyQkdS/IIl8CCgpuL5zb5TbFX8IzuBTtv7AVWw==
X-Received: by 2002:adf:ed92:0:b0:2f8:24f7:cc4a with SMTP id c18-20020adfed92000000b002f824f7cc4amr18424422wro.57.1683895892340;
        Fri, 12 May 2023 05:51:32 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id l19-20020a1c7913000000b003f42ceb3bf4sm9940148wme.32.2023.05.12.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:51:31 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Adaptec RAID 6405 controller driver crash at apater reset
Date:   Fri, 12 May 2023 15:51:12 +0300
Message-Id: <20230512125114.1329613-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello mates!

I have server with Adaptec RAID 6405 controller.
RAID10 is configured with four SAS disks.
I use arcconf tool for disks health monitoring.

Sometimes I faced with the problem that arcconf stuck and at the same
time cpu io usage grew to ~60-70%. In kernel log I got this report about
use-after-free and NULL pointer dereference error.

I was starting to look at aacraid driver. After some "investigations"
I found that if `aac_adapter_check_health` fail (line 2474), it leads to
`aac_command_thread` finish. 
Then after ~20-30 seconds `scsi_try_host_reset` happens.
Farther execution reach `_aac_reset_adapter` function and try to stop
already finished thread (kthread_stop(aac->thread) in line 1499).

As a result we got use-after-free warning and NULL pointer dereference
crash. (Actually if we will enable KASAN than we will get waring a
little bit earlier when accessing `aac->thread->pid` in line 1497)

So, I added some debug output to make things clear.

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index deb32c9f4b3e..38df5e8d8e38 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1494,13 +1494,14 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
         *        commands are completing in the interrupt service.
         */
        aac_adapter_disable_int(aac);
+       printk(KERN_INFO">>> %s [%d] Before access to aac->thread\n", __func__, __LINE__);
        if (aac->thread && aac->thread->pid != current->pid) {
                spin_unlock_irq(host->host_lock);
                kthread_stop(aac->thread);
                aac->thread = NULL;
                jafo = 1;
        }
-
+       printk(KERN_INFO">>> %s [%d] After access to aac->thread\n", __func__, __LINE__);
        /*
         *      If a positive health, means in a known DEAD PANIC
         * state and the adapter could be reset to `try again'.
@@ -2471,8 +2472,10 @@ int aac_command_thread(void *data)
 
                        /* Don't even try to talk to adapter if its sick */
                        ret = aac_adapter_check_health(dev);
-                       if (ret || !dev->queues)
+                       if (ret || !dev->queues) {
+                               printk(KERN_INFO">>> %s [%d] adapter_check_health problem. Go out...\n", __func__, __LINE__);
                                break;
+                       }
                        next_check_jiffies = jiffies
                                           + ((long)(unsigned)check_interval)
                                           * HZ;
@@ -2518,6 +2521,7 @@ int aac_command_thread(void *data)
        if (dev->queues)
                remove_wait_queue(&dev->queues->queue[HostNormCmdQueue].cmdready, &wait);
        dev->aif_thread = 0;
+       printk(KERN_INFO">>> %s [%d] aac_command_thread stopped\n", __func__, __LINE__);
        return 0;
 }

And here is the kernel log I got.


[  436.735653] >>> aac_command_thread [2476] adapter_check_health problem. Go out...
[  436.735663] >>> aac_command_thread [2524] aac_command_thread stopped
[  461.667761] aacraid: Host bus reset request. SCSI hang ?
[  461.669216] aacraid 0000:01:00.0: Adapter health - 247
[  461.670575] aacraid 0000:01:00.0: outstanding cmd: midlevel-0
[  461.670581] aacraid 0000:01:00.0: outstanding cmd: lowlevel-0
[  461.670585] aacraid 0000:01:00.0: outstanding cmd: error handler-0
[  461.670589] aacraid 0000:01:00.0: outstanding cmd: firmware-1
[  461.670592] aacraid 0000:01:00.0: outstanding cmd: kernel-0
[  461.707700] >>> _aac_reset_adapter [1497] Before access to aac->thread
[  461.707724] ------------[ cut here ]------------
[  461.707725] refcount_t: addition on 0; use-after-free.
[  461.707729] WARNING: CPU: 1 PID: 116 at lib/refcount.c:25 refcount_warn_saturate+0x72/0x100
[  461.707734] Modules linked in: fuse md5 hmac nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc cn iptable_raw xt_conntrack iptable_nat bpfilter sctp ip6_udp_tunnel udp_tunnel nf_nat_sip nf_nat nf_conntrack_sip nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ipv6 nls_iso8859_1 nls_cp437 ipmi_watchdog sg overlay squashfs loop crc32c_generic ext4 mbcache jbd2 ipmi_ssif input_leds led_class hid_generic usbhid hid sd_mod iTCO_wdt intel_pmc_bxt iTCO_vendor_support mfd_core ast drm_shmem_helper coretemp drm_kms_helper ahci syscopyarea sysfillrect x86_pkg_temp_thermal sysimgblt i2c_i801 libahci i2c_smbus igb i2c_algo_bit libata aacraid dca scsi_mod xhci_pci scsi_common xhci_hcd intel_pch_thermal fan acpi_ipmi 8250 8250_base ipmi_si serial_mctrl_gpio ipmi_devintf serial_core ipmi_msghandler video wmi acpi_power_meter intel_pmc_core hwmon button unix
[  461.707783] CPU: 1 PID: 116 Comm: scsi_eh_0 Tainted: G        W          6.3.0.0-g2cd293ea6f73-dirty #12
[  461.707785] Hardware name: Supermicro Super Server/X11SSH-LN4F, BIOS 2.7 12/07/2021
[  461.707786] RIP: 0010:refcount_warn_saturate+0x72/0x100
[  461.707789] Code: db d6 86 00 01 e8 5e 83 df ff 0f 0b 5d c3 80 3d ca d6 86 00 00 75 d1 48 c7 c7 68 6a 53 99 c6 05 ba d6 86 00 01 e8 3e 83 df ff <0f> 0b 5d c3 80 3d ac d6 86 00 00 75 b1 48 c7 c7 40 6a 53 99 c6 05
[  461.707790] RSP: 0018:ffffb964402f7d58 EFLAGS: 00010286
[  461.707792] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000027
[  461.707793] RDX: ffffa2ca2fa5c548 RSI: 0000000000000001 RDI: ffffa2ca2fa5c540
[  461.707795] RBP: ffffb964402f7d58 R08: ffffffff996aa3a8 R09: 0000000000000003
[  461.707796] R10: ffffffff9963a3c0 R11: ffffffff996923c0 R12: ffffa2c8d03b8000
[  461.707797] R13: ffffa2c8d03b8028 R14: ffffa2c8d9bc0000 R15: ffffa2c8d9bc0000
[  461.707798] FS:  0000000000000000(0000) GS:ffffa2ca2fa40000(0000) knlGS:0000000000000000
[  461.707799] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  461.707801] CR2: 00007f9209808000 CR3: 00000001caa2a002 CR4: 00000000003706e0
[  461.707802] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  461.707803] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  461.707804] Call Trace:
[  461.707805]  <TASK>
[  461.707806]  kthread_stop+0xdb/0xe0
[  461.707809]  aac_reset_adapter+0x409/0x6f0 [aacraid]
[  461.707815]  aac_eh_host_reset+0x50/0x90 [aacraid]
[  461.707819]  scsi_try_host_reset+0x26/0xc0 [scsi_mod]
[  461.707825]  scsi_eh_ready_devs+0x34e/0x920 [scsi_mod]
[  461.707831]  ? scsi_eh_get_sense+0x160/0x160 [scsi_mod]
[  461.707838]  scsi_error_handler+0x355/0x360 [scsi_mod]
[  461.707845]  kthread+0xda/0x100
[  461.707847]  ? kthread_complete_and_exit+0x20/0x20
[  461.707849]  ret_from_fork+0x1f/0x30
[  461.707852]  </TASK>
[  461.707852] ---[ end trace 0000000000000000 ]---
[  461.707855] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  461.708215] #PF: supervisor write access in kernel mode
[  461.708552] #PF: error_code(0x0002) - not-present page
[  461.708900] PGD 0 P4D 0 
[  461.709234] Oops: 0002 [#1] PREEMPT SMP
[  461.709558] CPU: 1 PID: 116 Comm: scsi_eh_0 Tainted: G        W          6.3.0.0-g2cd293ea6f73-dirty #12
[  461.710197] Hardware name: Supermicro Super Server/X11SSH-LN4F, BIOS 2.7 12/07/2021
[  461.710521] RIP: 0010:kthread_stop+0x3f/0xe0
[  461.710837] Code: 41 54 49 89 fc 53 f0 0f c1 47 28 85 c0 0f 84 a6 00 00 00 8d 50 01 09 c2 78 6d 41 f6 44 24 2e 20 74 7a 49 8b 9c 24 80 04 00 00 <f0> 80 0b 02 4c 89 e7 e8 65 ff ff ff f0 41 80 4c 24 02 02 4c 89 e7
[  461.711831] RSP: 0018:ffffb964402f7d68 EFLAGS: 00010202
[  461.712177] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
[  461.712531] RDX: ffffa2ca2fa5c548 RSI: 0000000000000001 RDI: ffffa2ca2fa5c540
[  461.712890] RBP: ffffb964402f7d88 R08: ffffffff996aa3a8 R09: 0000000000000003
[  461.713262] R10: ffffffff9963a3c0 R11: ffffffff996923c0 R12: ffffa2c8d03b8000
[  461.713633] R13: ffffa2c8d03b8028 R14: ffffa2c8d9bc0000 R15: ffffa2c8d9bc0000
[  461.713998] FS:  0000000000000000(0000) GS:ffffa2ca2fa40000(0000) knlGS:0000000000000000
[  461.714365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  461.714734] CR2: 0000000000000000 CR3: 00000001caa2a002 CR4: 00000000003706e0
[  461.715114] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  461.715497] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  461.715884] Call Trace:
[  461.716267]  <TASK>
[  461.716651]  aac_reset_adapter+0x409/0x6f0 [aacraid]
[  461.717052]  aac_eh_host_reset+0x50/0x90 [aacraid]
[  461.717455]  scsi_try_host_reset+0x26/0xc0 [scsi_mod]
[  461.717856]  scsi_eh_ready_devs+0x34e/0x920 [scsi_mod]
[  461.718262]  ? scsi_eh_get_sense+0x160/0x160 [scsi_mod]
[  461.718656]  scsi_error_handler+0x355/0x360 [scsi_mod]
[  461.719044]  kthread+0xda/0x100
[  461.719429]  ? kthread_complete_and_exit+0x20/0x20
[  461.719823]  ret_from_fork+0x1f/0x30
[  461.720216]  </TASK>
[  461.720604] Modules linked in: fuse md5 hmac nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc cn iptable_raw xt_conntrack iptable_nat bpfilter sctp ip6_udp_tunnel udp_tunnel nf_nat_sip nf_nat nf_conntrack_sip nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ipv6 nls_iso8859_1 nls_cp437 ipmi_watchdog sg overlay squashfs loop crc32c_generic ext4 mbcache jbd2 ipmi_ssif input_leds led_class hid_generic usbhid hid sd_mod iTCO_wdt intel_pmc_bxt iTCO_vendor_support mfd_core ast drm_shmem_helper coretemp drm_kms_helper ahci syscopyarea sysfillrect x86_pkg_temp_thermal sysimgblt i2c_i801 libahci i2c_smbus igb i2c_algo_bit libata aacraid dca scsi_mod xhci_pci scsi_common xhci_hcd intel_pch_thermal fan acpi_ipmi 8250 8250_base ipmi_si serial_mctrl_gpio ipmi_devintf serial_core ipmi_msghandler video wmi acpi_power_meter intel_pmc_core hwmon button unix
[  461.724589] CR2: 0000000000000000
[  461.725038] ---[ end trace 0000000000000000 ]---
[  461.725493] RIP: 0010:kthread_stop+0x3f/0xe0
[  461.725930] Code: 41 54 49 89 fc 53 f0 0f c1 47 28 85 c0 0f 84 a6 00 00 00 8d 50 01 09 c2 78 6d 41 f6 44 24 2e 20 74 7a 49 8b 9c 24 80 04 00 00 <f0> 80 0b 02 4c 89 e7 e8 65 ff ff ff f0 41 80 4c 24 02 02 4c 89 e7
[  461.727247] RSP: 0018:ffffb964402f7d68 EFLAGS: 00010202
[  461.727693] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
[  461.728150] RDX: ffffa2ca2fa5c548 RSI: 0000000000000001 RDI: ffffa2ca2fa5c540
[  461.728598] RBP: ffffb964402f7d88 R08: ffffffff996aa3a8 R09: 0000000000000003
[  461.729053] R10: ffffffff9963a3c0 R11: ffffffff996923c0 R12: ffffa2c8d03b8000
[  461.729504] R13: ffffa2c8d03b8028 R14: ffffa2c8d9bc0000 R15: ffffa2c8d9bc0000
[  461.729948] FS:  0000000000000000(0000) GS:ffffa2ca2fa40000(0000) knlGS:0000000000000000
[  461.730396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  461.730840] CR2: 0000000000000000 CR3: 00000001caa2a002 CR4: 00000000003706e0
[  461.731308] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  461.731766] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  461.732223] note: scsi_eh_0[116] exited with irqs disabled


Also I made a kinda ugly patch that fixes this issue for me.

Does anyone have any thoughts on this? I will be glad to see them :)

Maksim Kiselev (1):
  scsi: aacraid: Prevent stopping of already finished thread on adapter
    reset

 drivers/scsi/aacraid/commsup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.39.2

