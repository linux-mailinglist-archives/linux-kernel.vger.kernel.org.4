Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368F96B1DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCIITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCIISU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:18:20 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C2E5006
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:14:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 51B6A604EF;
        Thu,  9 Mar 2023 09:14:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678349652; bh=eQYgYGof5e27Nf41t5KKL3ucmmdEiYbCoIwcdj/66oQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qJ6hoo7oUvARXYBKwPdGCDR6gWXc4Vvdxj2FfyeDBLERYfI87kZxJT+7G6ogCUxr6
         /DryWk+I8Z781piFuKbvrMsub0+rRje6xZnUVW5+o5qW/LWS3HghbxmTbuiM5aWRtl
         HkuoeWqHd1jJqZYkEMnYXLcFm3tjjtXY4AwleG/kBSz0C27z7gnSZfiuqkuAP5DLa3
         lF5HxaD+mPMD9W4c6eWmy3vSYcE2HyAykIx0vXIVgv6HwybURbaUcsxmi2hPnT36YF
         REH3IJWRK7r2kTXRk1iFH6O+WuM1Euw+62PtfGraT+O2KsP/m9yi7AEss5ddPl9BN/
         ht2uGEA7v2a1A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4PxQJUlCSToQ; Thu,  9 Mar 2023 09:14:09 +0100 (CET)
Received: from [10.0.1.57] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 7AA7B604ED;
        Thu,  9 Mar 2023 09:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678349649; bh=eQYgYGof5e27Nf41t5KKL3ucmmdEiYbCoIwcdj/66oQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AEkOFcmmXLo3TSQEecKqbrj8m6x0tyUhUX68JDHdujeDwHw6FoxJo7Sl/eSGf/iUk
         GdYOSeT5SnHH9lvL/uTRSZbLVWMiGsI6jx4RIXytd0l56Vf1IV2D5W88fg9zu4c8SR
         bnAvZR6QwMxLnKULxn45cAk/OsI680qldw+GzqYsmo+uqqJtQFyjvBSq87Ex87Mskd
         WZgPvKNLR1cLioeACONYrX+VGzNhXrwSwJlTSRb+AKe8y55v/TadLP8r53NJJCRtJI
         4SEJooo+XbLeE4KhAkbaUYIqLlDuxRJ8DbjtpGhKPYTVwhHIoq7SDon9CQqPxsulbR
         VmRw7Yuy9hA7Q==
Message-ID: <7590df81-3bdd-b04e-7b4e-797b45fabded@alu.unizg.hr>
Date:   Thu, 9 Mar 2023 09:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: INFO: BUG: kobject: integrity does not have a release function
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20230309021556.2203-1-hdanton@sina.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230309021556.2203-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.3.2023. 3:15, Hillf Danton wrote:
> On 8 Mar 2023 15:08:21 +0100 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>
>> Please see the bug reports from the kernel log:
>>
>> https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123748.jpg
>>
>> https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123752.jpg
>>
>> The kernel is Linux 6.2.0-mg-andy-devres-12485-gf3a2439f20d9-dirty x86_64
>> on a LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB running AlmaLinux 8.7.
> 
> Only in case no support from your linux vendor, take a look at the debug/fix
> diffs below.
>>
>> I was unable to reproduce on the other Lenovo laptop box, for the kernel
>> refused to boot, unable to find root drive on NVMe (other kernels w/o
>> CONFIG_DEBUG_KOBJECT=y run smoothly).
>>
>> Config used is:
>>
>> https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/config-6.2.0-mg-andy-devres-12485-gf3a2439f20d9-dirty
>>
>> As I already said to Andy, this might not be a critical bug, for it happens
>> only at shutdown AFAICS. However, it can be a sign of some more serious problem
>> in the code. :-/
>>
>> Hope this helps.
>>
>> Regards,
>> Mirsad
>>
>> -- 
>> Mirsad Goran Todorovac
>> Sistem inženjer
>> Grafički fakultet | Akademija likovnih umjetnosti
>> Sveučilište u Zagrebu
>>
>> System engineer
>> Faculty of Graphic Arts | Academy of Fine Arts
>> University of Zagreb, Republic of Croatia
> 
> Add a dummy release callback to the integrity ktype in order to
> quiesce kobj warning.
> 
> --- 6.2/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -356,7 +356,11 @@ static const struct sysfs_ops integrity_
>   	.store	= &integrity_attr_store,
>   };
>   
> +static void blk_integrity_kobj_release(struct kobject *kobj)
> +{
> +}
>   static const struct kobj_type integrity_ktype = {
> +	.release = blk_integrity_kobj_release,
>   	.default_groups = integrity_groups,
>   	.sysfs_ops	= &integrity_ops,
>   };
> --
> 
> Add debug info to catch invalid kobj type.
> 
> --- 6.2/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -443,6 +443,8 @@ int kobject_init_and_add(struct kobject
>   	va_list args;
>   	int retval;
>   
> +	if (WARN_ON(!ktype || !ktype->release))
> +		return -EINVAL;
>   	kobject_init(kobj, ktype);
>   
>   	va_start(args, fmt);
> --

Hi, Hillf, thank you very much for the patch.

However, I have seen another inconsistency here:

security/integrity/iint.c:
175 static int __init integrity_iintcache_init(void)
176 {
177         iint_cache =
178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
179                               0, SLAB_PANIC, init_once);
180         return 0;
181 }
182 DEFINE_LSM(integrity) = {
183         .name = "integrity",
184         .init = integrity_iintcache_init,
185 };

There is no call to kmem_cache_destroy(iint_cache) in entire security/integrity subtree?

Is that intentional?

I know there is little logic in releasing resources at shutdown, but it seems like the
right thing to do ... :-/

Thank you very much, again.

Regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

