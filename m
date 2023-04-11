Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A3F6DE1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDKQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDKQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:59:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB2198
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:59:15 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mbj3Y-1qN0BB0WCc-00dCN0; Tue, 11 Apr 2023 18:53:39 +0200
Message-ID: <437e9983-55e9-3f9d-a94b-c746922973da@i2se.com>
Date:   Tue, 11 Apr 2023 18:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvmem: rmem: Make reserved region name unique
To:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230411135035.106725-1-iivanov@suse.de>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230411135035.106725-1-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JIR5IuZI1s/TSCpfSJQ4lEZdMEaQmJu2Qhz2QVuj5pY6/GPn3Ia
 Gz/cLDle5eT+m5Z81tTREriesMfRh5jrf2ph7VFbi4jLPd73uU+dqXpjxcZEv5MJfoKb7Gl
 5HW55mGKCL9O9HKYzryemnxNz8SUg1ZtejNk8JKxnZzi1989oxXM/iDrxyLpF0yKhWL8fGi
 D3334dTHxICakhqWAC2uw==
UI-OutboundReport: notjunk:1;M01:P0:HwjU1YyIMtU=;F72XKl5pHUoBy4qI6dq2WfqcC94
 1usEX2OgZjMwwWOAGYkLxsKzud4tcAvZhQfStUHZoiSBCQdSBm9UT4eRgGMqfy43+qB7FvFvq
 jDxm4PGHnbxa9C6S43/EstehyKAiegBhvRcJQ8U10lAaAsYPSxiecCAo8USNmjpMNtfD4Pbh9
 OZNA0rHMcSYqEs9YjWDKra9vZo9dPGOj9HPRPbPDWvL3vIm6SmeI7q1eh0GGGd3IMAjZHFTq5
 Wv1WCiowP2y+objE8DM6kI6srzrbOcxBVouc6nIqgIVRCQrGOlj78Hwkqo8OVSV3KmjOcgeAk
 KMm2Prd24xaEgIUVRBdzpv9LYy7sSamjkGWQanlTVUJ5SPn8OKt4HQKvJ5CuZgnOc3XMHN9fI
 HiNebzJafW+TzSsgk9FXn0domcIZSvU3dWfQr2yAG7UOmngrHfL2p9PSwea7se59+lAVpmCK6
 wAnTrCaedudJ/Y/TMaERWFEz8owXgNglzJcZESC24a5q+e5IH2A/OMz0myqhSOfoeMW/R0sXf
 8JueZafFcR7Rd6VG2t9XZBdawKk6MZZ4Mr8DOQ1ZS0zYTv5O5+jlm8PNgHa3Zm+5RSJOJrAgt
 TPwzvITV4q2TT6ATTn66D8qzGOyrrlfEQ/vtEwIUKZq6wEtMmDJ4a49Y3C8bZZMIQNgM3Q7lM
 muavMTwITq7XdtOVBTJgqi0f7jtx57wtcdVNVbmheQ==
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 11.04.23 um 15:50 schrieb Ivan T. Ivanov:
> They could be multiple reserved memory regions,
> so let's make their names unique.
> 
> This fixes following kernel error:
> 
> [    9.831285] sysfs: cannot create duplicate filename '/bus/nvmem/devices/rmem0'

could you please provide more background information:

- are two instances of rmem trying to create this file?
- which exact platform is affect (Raspberry Pi 4), because the Hardware 
name from the trace is useless?
- could you provide some reliable scenario/config to reproduce this issue?

> [    9.831304] CPU: 3 PID: 467 Comm: (udev-worker) Not tainted 6.2.9-1-default #1 openSUSE Tumbleweed a4aeb3a90c0f23041a8a7944b12739b07585f009
> [    9.831326] Hardware name: raspberrypi rpi/rpi, BIOS 2023.01 01/01/2023
> [    9.831335] Call trace:
> [    9.831343]  dump_backtrace+0xe4/0x140
> [    9.831366]  show_stack+0x20/0x30
> [    9.831379]  dump_stack_lvl+0x64/0x80
> [    9.831398]  dump_stack+0x18/0x34
> [    9.831410]  sysfs_warn_dup+0x6c/0x90
> [    9.831424]  sysfs_do_create_link_sd+0xf8/0x100
> [    9.831437]  sysfs_create_link+0x28/0x50
> [    9.831449]  bus_add_device+0x70/0x190
> [    9.831468]  device_add+0x3e8/0x84c
> [    9.831481]  nvmem_register+0x85c/0x9f0
> [    9.831500]  devm_nvmem_register+0x24/0x70
> [    9.831517]  rmem_probe+0xa0/0xf4 [nvmem_rmem 649243b01e5e28ee94e4dd53bd13b6ececa836f8]
> [    9.831555]  platform_probe+0x70/0xd0
> [    9.831566]  really_probe+0xc8/0x3e4
> [    9.831582]  __driver_probe_device+0x84/0x190
> [    9.831598]  driver_probe_device+0x44/0x11c
> [    9.831613]  __driver_attach+0xf8/0x200
> [    9.831629]  bus_for_each_dev+0x78/0xd0
> [    9.831643]  driver_attach+0x2c/0x40
> [    9.831657]  bus_add_driver+0x188/0x250
> [    9.831672]  driver_register+0x80/0x13c
> [    9.831688]  __platform_driver_register+0x30/0x40
> [    9.831699]  rmem_driver_init+0x28/0x1000 [nvmem_rmem 649243b01e5e28ee94e4dd53bd13b6ececa836f8]
> [    9.831727]  do_one_initcall+0x48/0x2bc
> [    9.831740]  do_init_module+0x50/0x1f0
> [    9.831753]  load_module+0x1e54/0x2250
> [    9.831763]  __do_sys_init_module+0x2ac/0x2f0
> [    9.831774]  __arm64_sys_init_module+0x24/0x30
> [    9.831785]  invoke_syscall+0x78/0x100
> [    9.831803]  el0_svc_common.constprop.0+0x15c/0x180
> [    9.831820]  do_el0_svc+0x40/0xb0
> [    9.831836]  el0_svc+0x34/0x134
> [    9.831850]  el0t_64_sync_handler+0x114/0x120
> [    9.831865]  el0t_64_sync+0x1a4/0x1a8
> [    9.831956] rmem: probe of 3ef62ce0.nvram failed with error -17
> 
> Some background information about the issue could be found here:
> https://bugzilla.suse.com/show_bug.cgi?id=1206846
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>   drivers/nvmem/rmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> index 80cb187f1481..77c70a47d519 100644
> --- a/drivers/nvmem/rmem.c
> +++ b/drivers/nvmem/rmem.c
> @@ -70,7 +70,7 @@ static int rmem_probe(struct platform_device *pdev)
>   
>   	config.dev = dev;
>   	config.priv = priv;
> -	config.name = "rmem";
> +	config.name = dev_name(dev);

AFAIR changing userspace isn't great because application could rely on 
the filename prefix.

What is the result after applying this patch:

ls bus/nvmem/devices/rmem*

>   	config.size = mem->size;
>   	config.reg_read = rmem_read;
>   
