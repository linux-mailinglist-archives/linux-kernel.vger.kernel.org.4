Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542AF6A118C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBWU7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBWU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:59:48 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBB5C15C;
        Thu, 23 Feb 2023 12:59:46 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bi17so14112481oib.3;
        Thu, 23 Feb 2023 12:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Osx0ixVmVSP+aXEP28qlQVylRkJ040ddv5NltnrKe3o=;
        b=EVx5RvngRD2W6T1SggAGYLrDi9ZMatODN3ARiAqiLth4GCIRubrg8exqKZWZ6kSQen
         sQSYJQlGsv2GfIBi7oj+pdQ/5uX5NEFKUMQJdILj657G0HTagy+3DsBNZTZrD8CH7R4J
         sjZ+otvp4XM5AyKl4oh8q63zyQ6enEHqfKqswjqeGzSAO6Wa1JoOjdOpqh/K3fRibS/J
         YEY1JaEovVUnfsihbjIdpsXBrgcnuynjAiL/rBz/yjAKehz0JoL63NHboBF0QhotKJxC
         vahi/6HLXOoL5tiiO4+rk59RWKtT7IMOMLNRPZFIN3dJb6juHc6kJxu66PcvStAlNdh6
         MXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Osx0ixVmVSP+aXEP28qlQVylRkJ040ddv5NltnrKe3o=;
        b=v1ezEH0ahkSGjpPFJ35RlhSNZw3DjOlUIyPTOWcWEluLl4nB98QiLJeL0pDyD/UQ0S
         ef6Ssgc1u4eWUGQMyHhC3uKkqBKqr+XZ06iu1129/x3GAm3jYC9O8z6GtD5ik5n82qbZ
         Ap5s4S6S6vVeTbW3kmwq15M2xUZ0MEMdODt0vc5332TjIcsyAJfFDCn0+JLg/YtG79uZ
         ocfzl2qZpZ44wSL9HWwp7ZQcs0CpWKm1I8etNEM+FCKuHmOEFOC9JZU/LoNg2cerltPa
         85jxoE7pEw/hK3WBMRgdkBMvMrZ2feRO6hdPS5Tr/LaMwnYIE1LfAJnLAGg/nvNLDoFk
         5/Sw==
X-Gm-Message-State: AO0yUKWrvy86U4Q8ps1Hboq2Cwh8xOtmD+icsNKiMTxFL9t/aULzeFdr
        ZdOvGGqZNbSUZAXhNBqshq01HDzn13k=
X-Google-Smtp-Source: AK7set/XYKik2KGEkmcJt1YBiLl/7lkSjFmlME/eKt7SLMjAtvvlUVVkJ9QRzAycFxpyas0MeiJTAA==
X-Received: by 2002:aca:2809:0:b0:37f:9d35:779 with SMTP id 9-20020aca2809000000b0037f9d350779mr6332787oix.16.1677185985846;
        Thu, 23 Feb 2023 12:59:45 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:2586:7432:d181:902b? ([2600:1700:2442:6db0:2586:7432:d181:902b])
        by smtp.gmail.com with ESMTPSA id bd23-20020a056808221700b0037d93a7e8f6sm5284817oib.54.2023.02.23.12.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 12:59:45 -0800 (PST)
Message-ID: <c7c3ce77-fefa-f771-390f-fa8891ee0271@gmail.com>
Date:   Thu, 23 Feb 2023 14:59:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230222221051.809091-1-frowand.list@gmail.com>
 <20230222221051.809091-2-frowand.list@gmail.com>
 <20230223123415.6dade5ec@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230223123415.6dade5ec@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 05:34, Clément Léger wrote:
> Le Wed, 22 Feb 2023 16:10:50 -0600,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>> When enabling CONFIG_OF on a platform where of_root is not populated by
>> firmware, we end up without a root node. In order to apply overlays and
>> create subnodes of the root node, we need one. Create this root node
>> by unflattening an empty builtin dtb.
>>
>> If firmware provides a flattened device tree (FDT) then the FDT is
>> unflattened via setup_arch().  Otherwise, setup_of() which is called
>> immediately after setup_arch(), and will create the default root node
>> if it does not exist.
>>
>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>> ---
>>
>> There are checkpatch warnings.  I have reviewed them and feel
>> they can be ignored.
>>
>> Changes since version 1:
>>   - refresh for 6.2-rc1
>>   - update Signed-off-by
>>   - fix typo in of_fdt.h: s/of_setup/setup_of
>>   - unflatten_device_tree(): validate size in header field dtb_empty_root
>>     that will be used to copy dtb_empty_root
>>   - add Kconfig option to manually select CONFIG_OF_EARLY_FLATTREE
>>
>>  drivers/of/Kconfig        |  7 ++++++-
>>  drivers/of/Makefile       |  2 +-
>>  drivers/of/empty_root.dts |  6 ++++++
>>  drivers/of/fdt.c          | 27 ++++++++++++++++++++++++++-
>>  include/linux/of_fdt.h    |  2 ++
>>  init/main.c               |  2 ++
>>  6 files changed, 43 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/of/empty_root.dts
>>
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 80b5fd44ab1c..591cfe386727 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -42,9 +42,14 @@ config OF_FLATTREE
>>  	select CRC32
>>  
>>  config OF_EARLY_FLATTREE
>> -	bool
>> +	bool "Functions for accessing Flat Devicetree (FDT) early in boot"
>>  	select DMA_DECLARE_COHERENT if HAS_DMA
>>  	select OF_FLATTREE
>> +	help
>> +	  Normally selected by platforms that process an FDT that has been
>> +	  passed to the kernel by the bootloader.  If the bootloader does not
>> +	  pass an FDT to the kernel and you need an empty devicetree that
>> +	  contains only a root node to exist, then say Y here.
>>  
>>  config OF_PROMTREE
>>  	bool
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index e0360a44306e..cbae92c5ed02 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -2,7 +2,7 @@
>>  obj-y = base.o device.o platform.o property.o
>>  obj-$(CONFIG_OF_KOBJ) += kobj.o
>>  obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>> -obj-$(CONFIG_OF_FLATTREE) += fdt.o
>> +obj-$(CONFIG_OF_FLATTREE) += fdt.o empty_root.dtb.o
>>  obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
>>  obj-$(CONFIG_OF_PROMTREE) += pdt.o
>>  obj-$(CONFIG_OF_ADDRESS)  += address.o
>> diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
>> new file mode 100644
>> index 000000000000..cf9e97a60f48
>> --- /dev/null
>> +++ b/drivers/of/empty_root.dts
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/dts-v1/;
>> +
>> +/ {
>> +
>> +};
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index b2272bccf85c..0d2f6d016b7e 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -33,6 +33,13 @@
>>  
>>  #include "of_private.h"
>>  
>> +/*
>> + * __dtb_empty_root_begin[] and __dtb_empty_root_end[] magically created by
>> + * cmd_dt_S_dtb in scripts/Makefile.lib
>> + */
>> +extern void *__dtb_empty_root_begin;
>> +extern void *__dtb_empty_root_end;
>> +
>>  /*
>>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>>   * @limit: maximum entries
>> @@ -1326,8 +1333,19 @@ bool __init early_init_dt_scan(void *params)
>>   */
>>  void __init unflatten_device_tree(void)
>>  {
>> -	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>> +	if (!initial_boot_params) {
>> +		initial_boot_params = (void *) __dtb_empty_root_begin;
> 
> The crash I encountered was actually not due to memblock alloc but to
> this usage/declaration of the embedded dtb pointers which is wrong.
> 
> Either declare it as:
> 
>  extern char __dtb_empty_root_begin[];
>  extern char __dtb_empty_root_end[];

Thanks for catching this, and the fix.

I will change to uint8_t instead of char, consistent with the use
in drivers/of/unittest.c

-Frank

> 
> and keep the existing usage in this function or keep the existing
> declaration but modify this function to use &__dtb_empty_root_begin
> 
> With this modification, I finally have an empty device-tree present on
> my system:
> 
> $ dtc -I fs -O dts  /sys/firmware/devicetree/
> /dts-v1/;
> 
> / {
> };
> 
> Thanks,
> 
> Clément
> 
>> +		/* fdt_totalsize() will be used for copy size */
>> +		if (fdt_totalsize(initial_boot_params) >
>> +		    __dtb_empty_root_end - __dtb_empty_root_begin) {
>> +			pr_err("invalid size in dtb_empty_root\n");
>> +			return;
>> +		}
>> +		unflatten_and_copy_device_tree();
>> +	} else {
>> +		__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>>  				early_init_dt_alloc_memory_arch, false);
>> +	}
>>  
>>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
>>  	of_alias_scan(early_init_dt_alloc_memory_arch);
>> @@ -1367,6 +1385,13 @@ void __init unflatten_and_copy_device_tree(void)
>>  	unflatten_device_tree();
>>  }
>>  
>> +void __init setup_of(void)
>> +{
>> +	/* if architecture did not unflatten devicetree, do it now */
>> +	if (!of_root)
>> +		unflatten_device_tree();
>> +}
>> +
>>  #ifdef CONFIG_SYSFS
>>  static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
>>  			       struct bin_attribute *bin_attr,
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index d69ad5bb1eb1..f0dc46d576da 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -81,6 +81,7 @@ extern const void *of_flat_dt_match_machine(const void *default_match,
>>  /* Other Prototypes */
>>  extern void unflatten_device_tree(void);
>>  extern void unflatten_and_copy_device_tree(void);
>> +extern void setup_of(void);
>>  extern void early_init_devtree(void *);
>>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>>  #else /* CONFIG_OF_EARLY_FLATTREE */
>> @@ -91,6 +92,7 @@ static inline void early_init_fdt_reserve_self(void) {}
>>  static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
>>  static inline void unflatten_device_tree(void) {}
>>  static inline void unflatten_and_copy_device_tree(void) {}
>> +static inline void setup_of(void) {}
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>>  
>>  #endif /* __ASSEMBLY__ */
>> diff --git a/init/main.c b/init/main.c
>> index e1c3911d7c70..31e0931b5134 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -101,6 +101,7 @@
>>  #include <linux/init_syscalls.h>
>>  #include <linux/stackdepot.h>
>>  #include <linux/randomize_kstack.h>
>> +#include <linux/of_fdt.h>
>>  #include <net/net_namespace.h>
>>  
>>  #include <asm/io.h>
>> @@ -961,6 +962,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>>  	pr_notice("%s", linux_banner);
>>  	early_security_init();
>>  	setup_arch(&command_line);
>> +	setup_of();
>>  	setup_boot_config();
>>  	setup_command_line(command_line);
>>  	setup_nr_cpu_ids();
> 
> 
> 

