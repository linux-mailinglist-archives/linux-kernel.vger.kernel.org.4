Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F98627594
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 06:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiKNFju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 00:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiKNFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:39:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F32416589;
        Sun, 13 Nov 2022 21:39:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso9602608pjc.5;
        Sun, 13 Nov 2022 21:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlwMTpTYCyZp/WYWlkzARk2edXg5YSk1kRs4+wjiJ78=;
        b=gYJf99H6t5oshYPBHt5OZfJzTgPJyH6QKNcodLlTZdpxgJ2R8S4he+OGuEAxMsR9y5
         ASZs+iU7f6pSl27s9vA29p5di3ZuVw+mc2c6PRgQDv+omZot903R3/7/+vlj1O5aM6Jp
         mHqF0l66+4Bq6uq7XsXJ7JWqqhoKs0Q+2A7E2hvxDPPQP0EfMF/c0KukZNbgmZ5qkptC
         veD0g3hTUtkdEeQq/A6HXV9DeczZsoObu5eoTogYZf9hiId88KEi1E7DM9BJRErxldQu
         P0xmiFxjc3l+co53nOijCSljb/BQI2Rj4GP8T1VOg8S3DW1bwhJOqBrMe7fk5dCmepkn
         YwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlwMTpTYCyZp/WYWlkzARk2edXg5YSk1kRs4+wjiJ78=;
        b=OEY56gSW/vNRHb1PlXGHrYs0uwh36usq2MzHt8nTwOeVZdKLyStYzp+PPTE84EjxPh
         yJPPNE46FTvKFQgBYIiWMSfOxJ1YIz1IgSgllUNkn3MYzbIEnMUVt68POHn9ziDxv8q5
         rbeHjREpR1jyJNirR3ur+ofqlXZlmisE1s+s4qoe5vI8Nyoju4xltbXPNvpNBA29/z7v
         799mxu+r2s5eQQw1lua4sv8tCo9X/WaXVwR2gIl2yK/5rxePkJtM07+L1XuOn5HzV8fP
         xDQl9VU6hqeBSd+U0KWlvUcuGBeAovsLhJn2GA7V6dgO+aUNImzTGYSUkPN/PGIXVx2E
         kP/g==
X-Gm-Message-State: ANoB5pnFqlPy1WKRdQ5G8HMQ+ZQVDSTsIhN7WQFT1jXO0wl2tvM2YcKL
        tYgiBpwFe2V0pMS6e0403GU=
X-Google-Smtp-Source: AA0mqf7hpuSDaZLMZByg2bX3Oe1xjlWimmLZjjYML3nU4TBu74nnsDZ1JREyHaURZUvI0mubJ5Nf1A==
X-Received: by 2002:a17:902:b491:b0:179:fe08:48da with SMTP id y17-20020a170902b49100b00179fe0848damr12083430plr.154.1668404384605;
        Sun, 13 Nov 2022 21:39:44 -0800 (PST)
Received: from [192.168.50.208] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b0017f64ab80e5sm6272341plf.179.2022.11.13.21.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 21:39:44 -0800 (PST)
Message-ID: <a15fbbb9-1f1e-c368-267d-5bcad5ce41c6@gmail.com>
Date:   Sun, 13 Nov 2022 21:39:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [patch 03/10] scsi: lpfc: Remove linux/msi.h include
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20221113201935.776707081@linutronix.de>
 <20221113202428.436270297@linutronix.de>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20221113202428.436270297@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2022 12:33 PM, Thomas Gleixner wrote:
> Nothing in this file needs anything from linux/msi.h
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Dick Kennedy <dick.kennedy@broadcom.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> ---
>   drivers/scsi/lpfc/lpfc_init.c |    1 -
>   1 file changed, 1 deletion(-)
> 
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -36,7 +36,6 @@
>   #include <linux/firmware.h>
>   #include <linux/miscdevice.h>
>   #include <linux/percpu.h>
> -#include <linux/msi.h>
>   #include <linux/irq.h>
>   #include <linux/bitops.h>
>   #include <linux/crash_dump.h>
> 

yep - agree.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james
