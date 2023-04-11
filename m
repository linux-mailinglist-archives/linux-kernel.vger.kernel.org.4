Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053EB6DE19E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDKQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:56:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDCBE2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:56:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qa44so21757534ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681232185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2W2TdrAYAHqXUQPd2hL/amTd12MPrArbxFDal1DqMG0=;
        b=I11pzJPxAPkHbv91VqecaOe6G+GPQMSP4c/l+E5YkCng5zYhd57wXuULJ0Ct8E/+IT
         PcXZpfGy7cGIPRYmOJ8UemwmfCydAHH7fUdQ5z+sanmUvvCTTm6zr7vSiIOqTRL7VIoT
         IgDBhCR9gy3FsMvB34Vy1V7Ijhs++pMpC//2+ajPgTQS9vHIYnlppdQNsIKME5Gv0cy+
         Co1B96ZBEB/emXjYg1UzPXMrFzKt8g5I/vca7bX5vKDDb0pdJerdIKIi71kb/zI8cZ0K
         3FHrwlR9pp3grXA4VWMlqca5RQuzCNWrWxFbZKfFOIt56L087M92ZPMJcBnUVwhMY2Lj
         /dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W2TdrAYAHqXUQPd2hL/amTd12MPrArbxFDal1DqMG0=;
        b=CPttfDwHqPlgSHJoWfq42l3jywpdenD7XhHyKOJNxjl3HKquxjRwjQ+lYqeYyWPe/R
         Ti8kF63GiTZyqOUOF4IE97AmES04WMypz5zur5THgy8PciOZ+N8+ypeOYD2bp58Gnqyf
         DDlaEoZht8/TusCSa0hI4NdmGciACn7moyOiuK4wuM78SvU/x4JiYhizGMHVERascFrZ
         CAQo7zGxLuCzFKEyGHnZDpY956AbxX/lUbuDjti1USXfgQFSxf5TzTnJgX1YZKk7NCF2
         ZjXnfBUe0vhSTzBAt/CMQB1QMdp9CCVSjr4xVnLxlcjtoBqAxhw0x+b6Gk6+tOFcqEmf
         2bYA==
X-Gm-Message-State: AAQBX9evRkX4+SQxMDNaxlhaIeoBcENuJ26sicMTXqC7Nxh2LTheaaFw
        NM8C1AeaUVBfWodybhr7lCxd0w==
X-Google-Smtp-Source: AKy350b6QBKq+ELt+vKy7N57lOIWt/5PXx8+Il5iIoPyUQ32jeUOzjoWYnnaynw/xx/bVPGPqm77FQ==
X-Received: by 2002:a17:907:9714:b0:932:853c:c958 with SMTP id jg20-20020a170907971400b00932853cc958mr13030989ejc.25.1681232185320;
        Tue, 11 Apr 2023 09:56:25 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bk25-20020a170906b0d900b00947ab65d932sm6282523ejb.83.2023.04.11.09.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:56:24 -0700 (PDT)
Message-ID: <c1943fbf-46fc-b20a-1351-a7328188aab0@linaro.org>
Date:   Tue, 11 Apr 2023 17:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvmem: rmem: Make reserved region name unique
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230411135035.106725-1-iivanov@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230411135035.106725-1-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2023 14:50, Ivan T. Ivanov wrote:
> They could be multiple reserved memory regions,
> so let's make their names unique.
> 
> This fixes following kernel error:
> 
> [    9.831285] sysfs: cannot create duplicate filename '/bus/nvmem/devices/rmem0'

Have you considered using NVMEM_DEVID_AUTO?

--srini

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
>   	config.size = mem->size;
>   	config.reg_read = rmem_read;
>   
