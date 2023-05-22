Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D870BBCF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjEVL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:29:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F2E6;
        Mon, 22 May 2023 04:29:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so1610804e87.3;
        Mon, 22 May 2023 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684754973; x=1687346973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9OEFUOoGXK/sscyvJjLmyzJj4mBlJlC9NSkygSY/CM=;
        b=LKpuAIG5XVko9dXNt1Fs61epBepCiohbEPK6onYyKoSRf06Ik1Lo2p/v8x7/Mi/Ynv
         xuqfF7km3x5pyTO6q5dsTpuYoQLHgqbp1oS4OSwx+Lnjp6q+vokhLbVEQnCAN91qlHZL
         Pz0R0sCxg4UneCYzDfDw5g6SMdUh/6W63VSut+H/LfJIsFCmHjJ7OGODJTf73nmqugj5
         3d7PS19XbMQ40DkT+cvlZgDB1W6nOSNXN3W7gnxaX5n9aA8nUTq4LJKN8r6uTfe0oZgv
         kNj3Upog3RA5k9uSb/YNLyf5k7Yv+4QVrk+dGwGs6X/JDGWNjKVVZE8dHEnV87vK91Ms
         OSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754973; x=1687346973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9OEFUOoGXK/sscyvJjLmyzJj4mBlJlC9NSkygSY/CM=;
        b=GPk6SH+NS11HnMsA2GjGlRuj1CySCL9+D3ZgGYvguCWZQCoFsxMbM4aojmNM6HTrWZ
         sNczE26pbszTg+KLivvkElMXwHcvdAtipU2OH1se3ijZNfIMpovyWsT1nsVxmftUIexR
         wMyyzRmRVAfQZxSlQQF0goqK9/Tha4K4vM/xlgaefBX2w03s6jqcM+8eEPVGhwZfXMIf
         13UbU7PB3W4g+BgKKxldvCgeGKuSNiFs5pvN6ZL7I/LRtPtC5OqOLkjwolXK6esDxKsu
         TqNDGKbPGhS2s9SGgSmQ3UkWGH/GaLQmRrEjNxvlXg7+Y72JJfBkZPHWb5VngFBdRRTz
         uYXw==
X-Gm-Message-State: AC+VfDygkjPfoYEVua8+4b173JjesCKaiLUXFtt7uwak7ufEklheDnHq
        FKy+XASu0yL+zpMW2PVeXdNkElj2OX5k70k1
X-Google-Smtp-Source: ACHHUZ7QOZ1MuRWr6OqoIgTzlT6+LIWOTkCuoFPsrZqzHsekHg9tEVQthBROggwKWP4cz7SUfxXLew==
X-Received: by 2002:a05:6512:38d1:b0:4f3:96ac:6dd8 with SMTP id p17-20020a05651238d100b004f396ac6dd8mr3574442lft.4.1684754972121;
        Mon, 22 May 2023 04:29:32 -0700 (PDT)
Received: from [192.168.88.92] (95-158-68-28.static.chello.pl. [95.158.68.28])
        by smtp.gmail.com with ESMTPSA id u17-20020ac243d1000000b004f1406b059asm948340lfl.219.2023.05.22.04.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 04:29:31 -0700 (PDT)
Message-ID: <8c4aae2c-4a5f-3d7e-41a4-dc198bf15956@gmail.com>
Date:   Mon, 22 May 2023 13:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: target: Fix data corruption under concurrent target
 configuration
Content-Language: en-US
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dutkahugo@gmail.com
References: <5f637569-36af-a8d0-e378-b27a63f08501@gmail.com>
 <20230520084600.GC20571@yadro.com>
 <d0f77858-4370-aa0c-0ece-32f4dcfe85f0@gmail.com>
From:   Grzegorz Uriasz <gorbak25@gmail.com>
In-Reply-To: <d0f77858-4370-aa0c-0ece-32f4dcfe85f0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,
I've added a debug printk call to see whether the devices are enabled 
concurrently:
---
  drivers/target/target_core_device.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/target/target_core_device.c 
b/drivers/target/target_core_device.c
index 5054b647dd0b..f594ee86a986 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -910,6 +910,8 @@ int target_configure_device(struct se_device *dev)
          return -EEXIST;
      }

+    pr_err("Configuring %p device", dev);
+
      /*
       * Add early so modules like tcmu can use during its
       * configuration.
-- 
2.40.0

It turns out that even when the flags are set atomically it seems that 
there is either no mutex protecting the setup or concurrent kzalloc 
calls returned the same address:

[ 3179.785908] kobject: 'maps' (000000000fdf10fd): calling ktype release
[ 3179.785910] kobject: (000000000fdf10fd): dynamic_kobj_release
[ 3179.785912] kobject: 'maps': free name
[ 3179.785953] tcmu nl cmd 2/0 completion could not find device with dev 
id 87.
[ 3179.786015] kobject: 'uio8' (000000001b25d2de): kobject_uevent_env
[ 3179.786315] kobject: 'uio8' (000000001b25d2de): fill_kobj_path: path 
= '/devices/tcm_user/uio/uio8'
[ 3179.786315] tcmu nl cmd 2/0 completion could not find device with dev 
id 87.
[ 3179.786322] tcmu nl cmd 2/0 completion could not find device with dev 
id 87.
[ 3179.786557] kobject: 'uio8' (000000001b25d2de): kobject_cleanup, 
parent 0000000000000000
[ 3179.786902] kobject: 'uio8' (000000001b25d2de): calling ktype release
[ 3179.786904] kobject: 'uio8': free name
[ 3179.786906] tcmu nl cmd 2/0 completion could not find device with dev 
id 87.
[ 3179.787226] tcmu nl cmd 2/0 completion could not find device with dev 
id 87.
[ 3179.809906] kobject: 'map0' (000000003fa04166): kobject_cleanup, 
parent 00000000e5849eec
[ 3179.809914] kobject: 'map0' (000000003fa04166): auto cleanup kobject_del
[ 3179.809930] tcmu nl cmd 2/0 completion could not find device with dev 
id 89.
[ 3179.809936] kobject: 'map0' (000000003fa04166): calling ktype release
[ 3179.810216] kobject: 'map0': free name
[ 3179.810218] tcmu nl cmd 2/0 completion could not find device with dev 
id 89.
[ 3179.810219] kobject: 'maps' (00000000e5849eec): kobject_cleanup, 
parent 00000000345aab09
[ 3179.810226] tcmu nl cmd 2/0 completion could not find device with dev 
id 89.
[ 3179.810535] kobject: 'maps' (00000000e5849eec): auto cleanup kobject_del
[ 3179.810890] tcmu nl cmd 2/0 completion could not find device with dev 
id 89.
[ 3179.810890] kobject: 'maps' (00000000e5849eec): calling ktype release
[ 3179.811171] kobject: (00000000e5849eec): dynamic_kobj_release
[ 3179.811174] kobject: 'maps': free name
[ 3179.811195] tcmu nl cmd 2/0 completion could not find device with dev 
id 89.
[ 3179.811292] kobject: 'uio9' (00000000345aab09): kobject_uevent_env
[ 3179.811546] kobject: 'uio9' (00000000345aab09): fill_kobj_path: path 
= '/devices/tcm_user/uio/uio9'
[ 3179.811576] kobject: 'uio9' (00000000345aab09): kobject_cleanup, 
parent 0000000000000000
[ 3179.811578] kobject: 'uio9' (00000000345aab09): calling ktype release
[ 3179.811581] kobject: 'uio9': free name
[ 3179.829730] kobject: '0' (00000000981718a9): kobject_cleanup, parent 
0000000000000000
[ 3179.829736] kobject: '0' (00000000981718a9): calling ktype release
[ 3179.829740] kobject: '0': free name
[ 3179.829743] kobject: 'cpu0' (00000000155d52b3): kobject_cleanup, 
parent 0000000000000000
[ 3179.829744] kobject: 'cpu0' (00000000155d52b3): calling ktype release
[ 3179.829746] kobject: 'cpu0': free name
[ 3179.829751] kobject: 'cpu1' (0000000050648bc7): kobject_cleanup, 
parent 0000000000000000
[ 3179.829753] kobject: 'cpu1' (0000000050648bc7): calling ktype release
[ 3179.829754] kobject: 'cpu1': free name
[ 3179.829755] kobject: 'cpu2' (00000000f0e72c5c): kobject_cleanup, 
parent 0000000000000000
[ 3179.829757] kobject: 'cpu2' (00000000f0e72c5c): calling ktype release
[ 3179.829758] kobject: 'cpu2': free name
[ 3179.829759] kobject: 'cpu3' (000000000b256e81): kobject_cleanup, 
parent 0000000000000000
[ 3179.829760] kobject: 'cpu3' (000000000b256e81): calling ktype release
[ 3179.829761] kobject: 'cpu3': free name
[ 3179.829762] kobject: 'cpu4' (000000008d489b4f): kobject_cleanup, 
parent 0000000000000000
[ 3179.829764] kobject: 'cpu4' (000000008d489b4f): calling ktype release
[ 3179.829765] kobject: 'cpu4': free name
[ 3179.829766] kobject: 'cpu5' (00000000f2e35ad0): kobject_cleanup, 
parent 0000000000000000
[ 3179.829767] kobject: 'cpu5' (00000000f2e35ad0): calling ktype release
[ 3179.829768] kobject: 'cpu5': free name
[ 3179.829769] kobject: 'cpu6' (00000000ecbd8737): kobject_cleanup, 
parent 0000000000000000
[ 3179.829771] kobject: 'cpu6' (00000000ecbd8737): calling ktype release
[ 3179.829772] kobject: 'cpu6': free name
[ 3179.829773] kobject: 'cpu7' (00000000813ca063): kobject_cleanup, 
parent 0000000000000000
[ 3179.829774] kobject: 'cpu7' (00000000813ca063): calling ktype release
[ 3179.829775] kobject: 'cpu7': free name
[ 3179.829776] kobject: 'mq' (0000000062154d34): kobject_cleanup, parent 
0000000000000000
[ 3179.829778] kobject: 'mq' (0000000062154d34): calling ktype release
[ 3179.829781] kobject: 'mq': free name
[ 3179.937204] tcmu daemon: command reply support 1.
[ 3180.242175] Configuring 0000000048576d33 device
[ 3180.242191] Configuring 00000000a24b9f12 device
[ 3180.243085] Configuring 0000000048576d33 device
[ 3180.243097] Configuring 0000000048576d33 device
[ 3180.243195] kobject: 'uio8' (00000000d48cde09): kobject_add_internal: 
parent: 'uio', set: 'devices'
[ 3180.243293] kobject: 'uio8' (00000000d48cde09): kobject_uevent_env
[ 3180.243325] kobject: 'uio9' (0000000025c5cb20): kobject_add_internal: 
parent: 'uio', set: 'devices'
[ 3180.243388] kobject: 'uio9' (0000000025c5cb20): kobject_uevent_env
[ 3180.243392] kobject: 'uio9' (0000000025c5cb20): fill_kobj_path: path 
= '/devices/tcm_user/uio/uio9'
[ 3180.243419] kobject: 'maps' (000000007f057cf5): kobject_add_internal: 
parent: 'uio9', set: '<NULL>'
[ 3180.243424] kobject: 'map0' (00000000f663b250): kobject_add_internal: 
parent: 'maps', set: '<NULL>'
[ 3180.243432] kobject: 'map0' (00000000f663b250): kobject_uevent_env
[ 3180.243433] kobject: 'map0' (00000000f663b250): kobject_uevent_env: 
filter function caused the event to drop!
[ 3180.243565] Configuring 0000000048576d33 device
[ 3180.243598] tcmu nl cmd 1/-2 completion could not find device with 
dev id 91.
[ 3180.243606] tcmu nl cmd 1/-2 completion could not find device with 
dev id 91.
[ 3180.243618] kobject: 'uio8' (00000000d48cde09): fill_kobj_path: path 
= '/devices/tcm_user/uio/uio8'
[ 3180.243622] tcmu nl cmd 1/-2 completion could not find device with 
dev id 91.
[ 3180.243640] kobject: 'maps' (00000000592a7aac): kobject_add_internal: 
parent: 'uio8', set: '<NULL>'
[ 3180.243646] kobject: 'map0' (0000000009bdede6): kobject_add_internal: 
parent: 'maps', set: '<NULL>'
[ 3180.243656] kobject: 'map0' (0000000009bdede6): kobject_uevent_env
[ 3180.243658] kobject: 'map0' (0000000009bdede6): kobject_uevent_env: 
filter function caused the event to drop!
[ 3180.243726] se_dev->se_dev_ptr already set for storage object
[ 3180.243731] se_dev->se_dev_ptr already set for storage object
[ 3180.243735] se_dev->se_dev_ptr already set for storage object
[ 3180.243738] se_dev->se_dev_ptr already set for storage object
[ 3180.243742] se_dev->se_dev_ptr already set for storage object
[ 3180.243746] se_dev->se_dev_ptr already set for storage object
[ 3180.243749] se_dev->se_dev_ptr already set for storage object
[ 3180.243760] se_dev->se_dev_ptr already set for storage object
[ 3180.243763] se_dev->se_dev_ptr already set for storage object
[ 3180.243767] se_dev->se_dev_ptr already set for storage object
[ 3180.243777] se_dev->se_dev_ptr already set for storage object
[ 3180.243780] se_dev->se_dev_ptr already set for storage object
[ 3180.243784] se_dev->se_dev_ptr already set for storage object
[ 3180.243788] se_dev->se_dev_ptr already set for storage object
[ 3180.244302] kobject: 'uio10' (000000001e7fdf06): 
kobject_add_internal: parent: 'uio', set: 'devices'
[ 3180.244472] tcmu nl cmd 1/-2 completion could not find device with 
dev id 93.
[ 3180.244628] kobject: 'uio11' (00000000a5f1af78): 
kobject_add_internal: parent: 'uio', set: 'devices'
[ 3180.244738] kobject: 'uio11' (00000000a5f1af78): kobject_uevent_env
[ 3180.244746] kobject: 'uio10' (000000001e7fdf06): kobject_uevent_env
[ 3180.244753] kobject: 'uio10' (000000001e7fdf06): fill_kobj_path: path 
= '/devices/tcm_user/uio/uio10'
[ 3180.244781] kobject: 'maps' (00000000def336c9): kobject_add_internal: 
parent: 'uio10', set: '<NULL>'
[ 3180.244787] kobject: 'map0' (0000000026045935): kobject_add_internal: 
parent: 'maps', set: '<NULL>'
[ 3180.244797] kobject: 'map0' (0000000026045935): kobject_uevent_env
[ 3180.244798] kobject: 'map0' (0000000026045935): kobject_uevent_env: 
filter function caused the event to drop!
[ 3180.244820] kobject: 'uio12' (00000000768952da): 
kobject_add_internal: parent: 'uio', set: 'devices'
[ 3180.244837] list_add double add: new=ffff888017480000, 
prev=ffffffff82e35ba0, next=ffff888017480000.
[ 3180.244855] tcmu nl cmd 1/-2 completion could not find device with 
dev id 93.
[ 3180.244883] kobject: 'uio12' (00000000768952da): kobject_uevent_env
[ 3180.244888] kobject: 'uio12' (00000000768952da): fill_kobj_path: path 
= '/devices/tcm_user/uio/uio12'
[ 3180.244894] ------------[ cut here ]------------
[ 3180.244897] kernel BUG at lib/list_debug.c:33!
[ 3180.244901] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 3180.244902] kobject: 'maps' (000000008b3ebaee): kobject_add_internal: 
parent: 'uio12', set: '<NULL>'
[ 3180.244903] CPU: 5 PID: 240588 Comm: node Not tainted 
6.4.0-rc2hocus-00247-g02bf964976ef-dirty #11 
1a56ed25763fc52a0220ba3bab2f1b70cacabece
[ 3180.244905] kobject: 'map0' (0000000012d7aa89): kobject_add_internal: 
parent: 'maps', set: '<NULL>'
[ 3180.244908] kobject: 'map0' (0000000012d7aa89): kobject_uevent_env
[ 3180.244909] kobject: 'map0' (0000000012d7aa89): kobject_uevent_env: 
filter function caused the event to drop!
[ 3180.244906] RIP: 0010:__list_add_valid+0x94/0xa0
[ 3180.244917] Code: d1 48 89 c6 4c 89 c2 48 c7 c7 38 e1 4b 82 e8 63 25 
b3 ff 0f 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 90 e1 4b 82 e8 4c 25 b3 
ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[ 3180.244918] RSP: 0018:ffffc90002e7fd68 EFLAGS: 00010246
[ 3180.244919] RAX: 0000000000000058 RBX: ffff888017480018 RCX: 
0000000000000000
[ 3180.244919] RDX: 0000000000000000 RSI: ffffffff824440d9 RDI: 
00000000ffffffff
[ 3180.244920] RBP: ffffc90002e7fd68 R08: 0000000000000001 R09: 
0000000000000001
[ 3180.244921] R10: 000000001b629664 R11: 0000000000000005 R12: 
0000000000000000
[ 3180.244921] R13: ffff888017480000 R14: ffff888017480000 R15: 
ffff888017480010
[ 3180.244924] FS:  00007f26e5a526c0(0000) GS:ffff88841fc80000(0000) 
knlGS:0000000000000000
[ 3180.244924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3180.244925] CR2: 00007f0104208440 CR3: 000000032af22000 CR4: 
00000000003506a0
[ 3180.244926] Call Trace:
[ 3180.244926]  <TASK>
[ 3180.244927]  tcmu_configure_device+0x29f/0x3a0
[ 3180.244933]  target_configure_device+0x8c/0x2f0
[ 3180.244936]  target_dev_enable_store+0x32/0x60
[ 3180.244940]  configfs_write_iter+0xd5/0x140
[ 3180.244944]  vfs_write+0x1ed/0x4f0
[ 3180.244948]  ksys_write+0x70/0xf0
[ 3180.244949]  __x64_sys_write+0x18/0x20
[ 3180.244950]  do_syscall_64+0x3e/0x90
[ 3180.244956]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 3180.244962] RIP: 0033:0x7f26e875611f
[ 3180.244963] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 d5 f8 
ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c d5 f8 ff 48
[ 3180.244963] RSP: 002b:00007f26e5a51cf0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000001
[ 3180.244966] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f26e875611f
[ 3180.244966] RDX: 0000000000000001 RSI: 00007f26be6549f0 RDI: 
0000000000000030
[ 3180.244967] RBP: 00007f26e5a51e20 R08: 0000000000000000 R09: 
00000000ffffffff
[ 3180.244967] R10: 0000000000000000 R11: 0000000000000293 R12: 
00007f26e5a525c0
[ 3180.244968] R13: 00007f26e5cab8a8 R14: 0000000000000001 R15: 
0000000000000400
[ 3180.244968]  </TASK>
[ 3180.244969] ---[ end trace 0000000000000000 ]---
[ 3180.244970] RIP: 0010:__list_add_valid+0x94/0xa0
[ 3180.244971] Code: d1 48 89 c6 4c 89 c2 48 c7 c7 38 e1 4b 82 e8 63 25 
b3 ff 0f 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 90 e1 4b 82 e8 4c 25 b3 
ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[ 3180.244972] RSP: 0018:ffffc90002e7fd68 EFLAGS: 00010246
[ 3180.244973] RAX: 0000000000000058 RBX: ffff888017480018 RCX: 
0000000000000000
[ 3180.244973] RDX: 0000000000000000 RSI: ffffffff824440d9 RDI: 
00000000ffffffff
[ 3180.244974] RBP: ffffc90002e7fd68 R08: 0000000000000001 R09: 
0000000000000001
[ 3180.244974] R10: 000000001b629664 R11: 0000000000000005 R12: 
0000000000000000
[ 3180.244975] R13: ffff888017480000 R14: ffff888017480000 R15: 
ffff888017480010
[ 3180.244977] FS:  00007f26e5a526c0(0000) GS:ffff88841fc80000(0000) 
knlGS:0000000000000000
[ 3180.244977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3180.244978] CR2: 00007f0104208440 CR3: 000000032af22000 CR4: 
00000000003506a0
[ 3180.245068] se_dev->se_dev_ptr already set for storage object
[ 3180.245087] kobject: 'uio11' (00000000a5f1af78): fill_kobj_path: path 
= '/devices/tcm_user/uio/uio11'
[ 3180.245265] tcmu nl cmd 1/-2 completion could not find device with 
dev id 91.
[ 3180.245491] kobject: 'maps' (000000009b2a87fb): kobject_add_internal: 
parent: 'uio11', set: '<NULL>'
[ 3180.245749] tcmu nl cmd 1/-2 completion could not find device with 
dev id 94.
[ 3180.245966] kobject: 'map0' (00000000d832f7b9): kobject_add_internal: 
parent: 'maps', set: '<NULL>'
[ 3180.246150] tcmu nl cmd 1/-2 completion could not find device with 
dev id 94.
[ 3180.246349] kobject: 'map0' (00000000d832f7b9): kobject_uevent_env
[ 3180.246523] tcmu nl cmd 1/-2 completion could not find device with 
dev id 93.
[ 3180.246691] kobject: 'map0' (00000000d832f7b9): kobject_uevent_env: 
filter function caused the event to drop!
[ 3180.246878] tcmu nl cmd 1/0 completion could not find device with dev 
id 91.
[ 3180.263756] tcmu nl cmd 1/-2 completion could not find device with 
dev id 93.

Best regards,
Grzegorz Uriasz

On 21/05/2023 13:28, Grzegorz Uriasz wrote:
> Hi Dmitry,
>
> Thank you for your feedback :)
>
> On 20/05/2023 10:46, Dmitry Bogdanov wrote:
>> Hi Grzegorz,
>>
>> On Sat, May 20, 2023 at 02:26:14AM +0200, Grzegorz Uriasz wrote:
>>> This fixes data corruptions arising from concurrent enabling of a 
>>> target
>>> devices. When multiple enable calls are made concurrently then it is
>>> possible for the target device to be set up twice which results in a
>>> kernel BUG.
>>> Introduces a per target device mutex for serializing enable requests.
>> Device enable call is already secured by configfs per-file mutex. That
>> is actually per device. So Enable procedures are already not executed
>> simulteniously.
> True, I've checked the code in configfs and indeed there is a per 
> file/subsystem mutex.
>>
>> Look like you wrongly identified the root cause of double list_add.
>>
>>
>> If you have an evidence that dev->dev_flags could have no DF_CONFIGURED
>> bit, then it meeans that it (dev_flags) is raced in other
>> configuration actions (udev_path, vpd_unit_serial, alias).
>> Bits in dev->dev_flags are written not atomically and if you writes to
>> enable, alias, udev_path,unit_serial files simulteniously, then some
>> bits could be lost.
>>
>> IHMO the best solution is to make dev_flags changes be atomical.
>
> I've tried that using the following patch:
> ---
>  drivers/target/target_core_configfs.c | 12 ++++++------
>  drivers/target/target_core_device.c   |  2 +-
>  drivers/target/target_core_iblock.c   |  2 +-
>  drivers/target/target_core_pscsi.c    |  4 ++--
>  drivers/target/target_core_spc.c      |  8 ++++----
>  drivers/target/target_core_tpg.c      |  2 +-
>  include/target/target_core_backend.h  |  2 +-
>  include/target/target_core_base.h     |  4 ++--
>  8 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/target/target_core_configfs.c 
> b/drivers/target/target_core_configfs.c
> index 74b67c346dfe..bdc06f654aa8 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1621,7 +1621,7 @@ static ssize_t 
> target_wwn_vpd_unit_serial_store(struct config_item *item,
>       * it is doing 'the right thing' wrt a world wide unique
>       * VPD Unit Serial Number that OS dependent multipath can depend on.
>       */
> -    if (dev->dev_flags & DF_FIRMWARE_VPD_UNIT_SERIAL) {
> +    if (atomic_read(&dev->dev_flags) & DF_FIRMWARE_VPD_UNIT_SERIAL) {
>          pr_err("Underlying SCSI device firmware provided VPD"
>              " Unit Serial, ignoring request\n");
>          return -EOPNOTSUPP;
> @@ -1654,7 +1654,7 @@ static ssize_t 
> target_wwn_vpd_unit_serial_store(struct config_item *item,
>      snprintf(buf, INQUIRY_VPD_SERIAL_LEN, "%s", page);
>      snprintf(dev->t10_wwn.unit_serial, INQUIRY_VPD_SERIAL_LEN,
>              "%s", strstrip(buf));
> -    dev->dev_flags |= DF_EMULATED_VPD_UNIT_SERIAL;
> +    atomic_or(DF_EMULATED_VPD_UNIT_SERIAL, &dev->dev_flags);
>
>      pr_debug("Target_Core_ConfigFS: Set emulated VPD Unit Serial:"
>              " %s\n", dev->t10_wwn.unit_serial);
> @@ -2263,7 +2263,7 @@ static ssize_t target_dev_alias_show(struct 
> config_item *item, char *page)
>  {
>      struct se_device *dev = to_device(item);
>
> -    if (!(dev->dev_flags & DF_USING_ALIAS))
> +    if (!(atomic_read(&dev->dev_flags) & DF_USING_ALIAS))
>          return 0;
>
>      return snprintf(page, PAGE_SIZE, "%s\n", dev->dev_alias);
> @@ -2289,7 +2289,7 @@ static ssize_t target_dev_alias_store(struct 
> config_item *item,
>      if (dev->dev_alias[read_bytes - 1] == '\n')
>          dev->dev_alias[read_bytes - 1] = '\0';
>
> -    dev->dev_flags |= DF_USING_ALIAS;
> +    atomic_or(DF_USING_ALIAS, &dev->dev_flags);
>
>      pr_debug("Target_Core_ConfigFS: %s/%s set alias: %s\n",
>          config_item_name(&hba->hba_group.cg_item),
> @@ -2303,7 +2303,7 @@ static ssize_t target_dev_udev_path_show(struct 
> config_item *item, char *page)
>  {
>      struct se_device *dev = to_device(item);
>
> -    if (!(dev->dev_flags & DF_USING_UDEV_PATH))
> +    if (!(atomic_read(&dev->dev_flags) & DF_USING_UDEV_PATH))
>          return 0;
>
>      return snprintf(page, PAGE_SIZE, "%s\n", dev->udev_path);
> @@ -2330,7 +2330,7 @@ static ssize_t target_dev_udev_path_store(struct 
> config_item *item,
>      if (dev->udev_path[read_bytes - 1] == '\n')
>          dev->udev_path[read_bytes - 1] = '\0';
>
> -    dev->dev_flags |= DF_USING_UDEV_PATH;
> +    atomic_or(DF_USING_UDEV_PATH, &dev->dev_flags);
>
>      pr_debug("Target_Core_ConfigFS: %s/%s set udev_path: %s\n",
>          config_item_name(&hba->hba_group.cg_item),
> diff --git a/drivers/target/target_core_device.c 
> b/drivers/target/target_core_device.c
> index 90f3f4926172..5054b647dd0b 100644
> --- a/drivers/target/target_core_device.c
> +++ b/drivers/target/target_core_device.c
> @@ -967,7 +967,7 @@ int target_configure_device(struct se_device *dev)
>      hba->dev_count++;
>      spin_unlock(&hba->device_lock);
>
> -    dev->dev_flags |= DF_CONFIGURED;
> +    atomic_or(DF_CONFIGURED, &dev->dev_flags);
>
>      return 0;
>
> diff --git a/drivers/target/target_core_iblock.c 
> b/drivers/target/target_core_iblock.c
> index cc838ffd1294..38d0d104661d 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -112,7 +112,7 @@ static int iblock_configure_device(struct 
> se_device *dev)
>      if (!ib_dev->ibd_readonly)
>          mode |= FMODE_WRITE;
>      else
> -        dev->dev_flags |= DF_READ_ONLY;
> +        atomic_or(DF_READ_ONLY, &dev->dev_flags);
>
>      bd = blkdev_get_by_path(ib_dev->ibd_udev_path, mode, ib_dev);
>      if (IS_ERR(bd)) {
> diff --git a/drivers/target/target_core_pscsi.c 
> b/drivers/target/target_core_pscsi.c
> index e7425549e39c..36a1ac519f0b 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -201,7 +201,7 @@ pscsi_get_inquiry_vpd_serial(struct scsi_device 
> *sdev, struct t10_wwn *wwn)
>
>      snprintf(&wwn->unit_serial[0], INQUIRY_VPD_SERIAL_LEN, "%s", 
> &buf[4]);
>
> -    wwn->t10_dev->dev_flags |= DF_FIRMWARE_VPD_UNIT_SERIAL;
> +    atomic_or(DF_FIRMWARE_VPD_UNIT_SERIAL, &wwn->t10_dev->dev_flags);
>
>      kfree(buf);
>      return 0;
> @@ -450,7 +450,7 @@ static int pscsi_configure_device(struct se_device 
> *dev)
>           * For the newer PHV_VIRTUAL_HOST_ID struct scsi_device
>           * reference, we enforce that udev_path has been set
>           */
> -        if (!(dev->dev_flags & DF_USING_UDEV_PATH)) {
> +        if (!(atomic_read(&dev->dev_flags) & DF_USING_UDEV_PATH)) {
>              pr_err("pSCSI: udev_path attribute has not"
>                  " been set before ENABLE=1\n");
>              return -EINVAL;
> diff --git a/drivers/target/target_core_spc.c 
> b/drivers/target/target_core_spc.c
> index 89c0d56294cc..d380d08a2df0 100644
> --- a/drivers/target/target_core_spc.c
> +++ b/drivers/target/target_core_spc.c
> @@ -159,7 +159,7 @@ spc_emulate_evpd_80(struct se_cmd *cmd, unsigned 
> char *buf)
>      struct se_device *dev = cmd->se_dev;
>      u16 len;
>
> -    if (dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL) {
> +    if (atomic_read(&dev->dev_flags) & DF_EMULATED_VPD_UNIT_SERIAL) {
>          len = sprintf(&buf[4], "%s", dev->t10_wwn.unit_serial);
>          len++; /* Extra Byte for NULL Terminator */
>          buf[3] = len;
> @@ -239,7 +239,7 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned 
> char *buf)
>       * /sys/kernel/config/target/core/$HBA/$DEV/wwn/vpd_unit_serial
>       * value in order to return the NAA id.
>       */
> -    if (!(dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL))
> +    if (!(atomic_read(&dev->dev_flags) & DF_EMULATED_VPD_UNIT_SERIAL))
>          goto check_t10_vend_desc;
>
>      /* CODE SET == Binary */
> @@ -267,7 +267,7 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned 
> char *buf)
>       */
>      id_len = 8; /* For Vendor field */
>
> -    if (dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL)
> +    if (atomic_read(&dev->dev_flags) & DF_EMULATED_VPD_UNIT_SERIAL)
>          id_len += sprintf(&buf[off+12], "%s:%s", prod,
>                  &dev->t10_wwn.unit_serial[0]);
>      buf[off] = 0x2; /* ASCII */
> @@ -720,7 +720,7 @@ spc_emulate_evpd_00(struct se_cmd *cmd, unsigned 
> char *buf)
>       * Registered Extended LUN WWN has been set via ConfigFS
>       * during device creation/restart.
>       */
> -    if (cmd->se_dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL) {
> +    if (atomic_read(&cmd->se_dev->dev_flags) & 
> DF_EMULATED_VPD_UNIT_SERIAL) {
>          buf[3] = ARRAY_SIZE(evpd_handlers);
>          for (p = 0; p < ARRAY_SIZE(evpd_handlers); ++p)
>              buf[p + 4] = evpd_handlers[p].page;
> diff --git a/drivers/target/target_core_tpg.c 
> b/drivers/target/target_core_tpg.c
> index c0e429e5ef31..c88dc36db6de 100644
> --- a/drivers/target/target_core_tpg.c
> +++ b/drivers/target/target_core_tpg.c
> @@ -656,7 +656,7 @@ int core_tpg_add_lun(
>      list_add_tail(&lun->lun_dev_link, &dev->dev_sep_list);
>      spin_unlock(&dev->se_port_lock);
>
> -    if (dev->dev_flags & DF_READ_ONLY)
> +    if (atomic_read(&dev->dev_flags) & DF_READ_ONLY)
>          lun->lun_access_ro = true;
>      else
>          lun->lun_access_ro = lun_access_ro;
> diff --git a/include/target/target_core_backend.h 
> b/include/target/target_core_backend.h
> index a3c193df25b3..27c70a69e088 100644
> --- a/include/target/target_core_backend.h
> +++ b/include/target/target_core_backend.h
> @@ -122,7 +122,7 @@ bool target_configure_unmap_from_queue(struct 
> se_dev_attrib *attrib,
>
>  static inline bool target_dev_configured(struct se_device *se_dev)
>  {
> -    return !!(se_dev->dev_flags & DF_CONFIGURED);
> +    return !!(atomic_read(&se_dev->dev_flags) & DF_CONFIGURED);
>  }
>
>  #endif /* TARGET_CORE_BACKEND_H */
> diff --git a/include/target/target_core_base.h 
> b/include/target/target_core_base.h
> index 5f8e96f1516f..5794b2360c47 100644
> --- a/include/target/target_core_base.h
> +++ b/include/target/target_core_base.h
> @@ -792,8 +792,8 @@ struct se_device_queue {
>
>  struct se_device {
>      /* Used for SAM Task Attribute ordering */
> -    u32            dev_cur_ordered_id;
> -    u32            dev_flags;
> +    u32         dev_cur_ordered_id;
> +    atomic_t    dev_flags;
>  #define DF_CONFIGURED                0x00000001
>  #define DF_FIRMWARE_VPD_UNIT_SERIAL        0x00000002
>  #define DF_EMULATED_VPD_UNIT_SERIAL        0x00000004
