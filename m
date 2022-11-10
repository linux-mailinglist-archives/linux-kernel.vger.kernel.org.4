Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3B8624885
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiKJRon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKJRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:44:41 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316202D75A;
        Thu, 10 Nov 2022 09:44:41 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id l2so2001277pld.13;
        Thu, 10 Nov 2022 09:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwceInYzCobuvA+97AtreUei0+vT6Z12rofSZH5CYag=;
        b=fTB0wq3SC/cCKKEe2Wjyc7h8vf52sudjZXLhxgaZjFPg9iROaj7whiWh6Yue50Qw3c
         9SI0pw22U7e9qdefgL94fpVgN5eSjiinc7i2lmfeqZhrcPkU++lLJJhzDrUQlZ4D4z+M
         D+Yt3Z87uQ9lbiRcRKUE6nDQGf79H11bnABa1FLY1RWMraI8x2st5GCBvm2z2a9ZB25h
         dlFnzSDvTtb/A9t2WoYkK9SfxNrfHfBtkVn5zj9UMlQQYgpcsiI/VMJ89D2CEEiryeZd
         7BYANN4UsBDbdxD+j0PlxBt3+cld6xYkBhmhLzOqAIvPUIsEP1qbyPTEGHGghyuu3Lcq
         ZHfQ==
X-Gm-Message-State: ACrzQf0iGL5xt5kb0I4V6RT6WeYufaD3nUh/rE85pqzQHj6jNwJPJdkr
        B1UJhU/NM2z+agYCuBVurWf0LOOCZ5E=
X-Google-Smtp-Source: AMsMyM45goJ9HglQcd7yg+Y15isFuzi+L14lDds6gq0WcCBcb3B0WjOiO9I4KB/k0a0YK6hNZ5Mo2A==
X-Received: by 2002:a17:90a:4618:b0:214:100a:65cf with SMTP id w24-20020a17090a461800b00214100a65cfmr51674268pjg.118.1668102274562;
        Thu, 10 Nov 2022 09:44:34 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:2ecf:659:1c55:5? ([2620:15c:211:201:2ecf:659:1c55:5])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902ed9300b00186acb14c4asm11506491plj.67.2022.11.10.09.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 09:44:29 -0800 (PST)
Message-ID: <05a91775-e4fa-4d70-8303-898339c4ea01@acm.org>
Date:   Thu, 10 Nov 2022 09:44:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [6.1.0-rc4-next-20221109] Boot time warning
 kernel/module/main.c:852
To:     Sachin Sant <sachinp@linux.ibm.com>, linux-scsi@vger.kernel.org
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
References: <06C70AFA-75C5-49A7-9EB4-27AF20A80EBB@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <06C70AFA-75C5-49A7-9EB4-27AF20A80EBB@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 00:01, Sachin Sant wrote:
> While booting 6.1.0-rc4-next-20221109 next kernel on a IBM Power9 LPAR
> following warning is seen:
> 
> [ 8.808868] ------------[ cut here ]------------
> [ 8.808872] WARNING: CPU: 1 PID: 378 at kernel/module/main.c:852 module_put+0x48/0x100
> [ 8.809024] sd 1:0:0:1: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
> [ 8.809024] LR [c0000000009ee680] scsi_device_put+0x50/0x70
> [ 8.809035] Call Trace:
> [ 8.809038] [c000000007c37b10] [c000000007c37b50] 0xc000000007c37b50 (unreliable)
> [ 8.809045] [c000000007c37b50] [c0000000009ee674] scsi_device_put+0x44/0x70
> [ 8.809053] [c000000007c37b80] [c000000000a10c70] alua_rtpg_work+0x210/0x920
> [ 8.809059] [c000000007c37c90] [c000000000182314] process_one_work+0x2b4/0x5b0
> [ 8.809066] [c000000007c37d30] [c000000000182688] worker_thread+0x78/0x600
> [ 8.809072] [c000000007c37dc0] [c00000000018f4f4] kthread+0x124/0x130
> [ 8.809079] [c000000007c37e10] [c00000000000cffc] ret_from_kernel_thread+0x5c/0x64
> [ 8.809086] Instruction dump:
> [ 8.809090] f821ffc1 41820034 395e03c0 7c0004ac 7d205028 2c090001 3929ffff 41c00010
> [ 8.809101] 7d20512d
> [ 8.809101] sd 1:0:0:1: [sdc] Preferred minimum I/O size 32768 bytes
> [ 8.809102] 40c2ffec 7c0004ac 79290fe2 <0b090000> 60000000 38210040 ebc1fff0
> [ 8.809115] ---[ end trace 0000000000000000 ]—
> 
> -next-20221108 was good. Git bisect points to following
> 
> commit 0b25e17e9018a0ea68a9f0b4787672e8c68fa8d5
> Date:   Mon Oct 31 15:47:25 2022 -0700
>      scsi: alua: Move a scsi_device_put() call out of alua_check_vpd()
> 
> Reverting this patch gets rid of the warning.

Hi Sachin,

Thanks for the detailed report. Does the patch below help?

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 693cd827e138..d2cf15338724 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1025,7 +1025,7 @@ static bool __must_check alua_rtpg_queue(struct alua_port_group *pg,
  			kref_put(&pg->kref, release_port_group);
  	}

-	return true;
+	return sdev != NULL;
  }

  /*

