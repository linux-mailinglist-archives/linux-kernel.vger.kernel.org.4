Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766DF64DCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLOOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOOWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:22:20 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD82A258;
        Thu, 15 Dec 2022 06:22:19 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so3672018otb.1;
        Thu, 15 Dec 2022 06:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3Dyn/dn/OWhAGrjHDvE1azPWS3up/x9nlv5UZ3aCO4=;
        b=ljp/21/vPol/YLMtFI+cpFXzZkJ9UoJ7vOlRBxlmYXBYpzW8mwQ6DnJqwQsEk60BuS
         co1GAkHqNwn17/HyJFjNOS0iu5K2NXnv80MWEQrI9aLB9d/mAGgYohC2oaqvHUPAP1Kl
         12nDkkH+BTfcwATHrjVaJJ/rPEpTTVz9QK7JnijmoUC+iJUF4HF2Mf7f8aXImXwfMXJ2
         Yk+A+T96wpIWeSgiX892nbwb9T+JM+/4ihNzBThb9dkBqxTOQbO7Qd7OBE/BInNleHMi
         JVSimtiimiPT9V0js8NsnOW7i3cnRItQf4dv0pUIrvSsJ6fOoQNSzJm9LuRV785vlVPW
         qejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3Dyn/dn/OWhAGrjHDvE1azPWS3up/x9nlv5UZ3aCO4=;
        b=pYVkc13SfisdamRD5vbljX2PvoyTBue3JhmXa5g2engX67Q2dIb0Z7rDaGoV0G7Isu
         BY9krT1zl2Dm5f8cKrwsTharzx4Q/0INxkV6f6Ux6Fullf68r0CpTOrWEo3am3+IsjlP
         P4RcXhrKVaafb30ZMvdDKfKvv9uYWOyvU0aUuMagXiUsnPkH9QxiNiqR0CjQvZRd5skz
         aFvztelptixZVZfPEyZZ7J9nDWd9aKtlIApnC/ga8OjaQ6ElkFydPophdmgXjd9Z1jwD
         sDhrprAOv3LoqTK5GZPo34y9kw72gz+TnoeZOks5S+gGVwBbMA+CH0iby4V6/+b9t44N
         /feQ==
X-Gm-Message-State: ANoB5pnb2z1vpgySaFG6nxnA3WY/XSR9R1gtbR7LJCinhzWym5HVzZrF
        KAotNhsn21ed/eNEmw1OH0w=
X-Google-Smtp-Source: AA0mqf5kfNGLyuBOK25+b4fURdCHoQyME2h1L0828nosozSsOt+dga/upIXyAIc1acBRdjNy2UObbQ==
X-Received: by 2002:a05:6830:620b:b0:66e:64c8:2a3 with SMTP id cd11-20020a056830620b00b0066e64c802a3mr17101815otb.38.1671114138444;
        Thu, 15 Dec 2022 06:22:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q26-20020a056830019a00b0066e968701f8sm3544190ota.27.2022.12.15.06.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 06:22:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <68f76ac7-5edd-d437-8bef-e233f2876660@roeck-us.net>
Date:   Thu, 15 Dec 2022 06:22:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
References: <Y5sWMEG0xCl9bgEi@tpad>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: coretemp: avoid RDMSR interruptions to isolated
 CPUs
In-Reply-To: <Y5sWMEG0xCl9bgEi@tpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 04:42, Marcelo Tosatti wrote:
> 
> The coretemp driver uses rdmsr_on_cpu calls to read
> MSR_IA32_PACKAGE_THERM_STATUS/MSR_IA32_THERM_STATUS registers,
> which contain information about current core temperature.
> 
> For certain low latency applications, the RDMSR interruption exceeds
> the applications requirements.
> 
> So disable reading of crit_alarm and temp files via /sys, in case
> CPU isolation is enabled.
> 

That isn't really what the code is doing. It doesn't disable reading
the attributes, it returns an error when an attempt is made to read
them.

> Temperature information from the housekeeping cores should be
> sufficient to infer die temperature.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 9bee4d33fbdf..30a35f4130d5 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -27,6 +27,7 @@
>   #include <asm/msr.h>
>   #include <asm/processor.h>
>   #include <asm/cpu_device_id.h>
> +#include <linux/sched/isolation.h>
>   
>   #define DRVNAME	"coretemp"
>   
> @@ -121,6 +122,10 @@ static ssize_t show_crit_alarm(struct device *dev,
>   	struct platform_data *pdata = dev_get_drvdata(dev);
>   	struct temp_data *tdata = pdata->core_data[attr->index];
>   
> +
> +	if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
> +		return -EINVAL;


Littering the output of the "sensors" command with errors is most
definitely wrong and not acceptable. On top of that, the user didn't
do anything wrong, so -EINVAL ("Invalid Argument") is definitely
the wrong error. Maybe return -ENODATA, or if the condition is
static just don't instantiate the attribute for the affected CPUs
to start with. Also, this warrants a comment in the code and an
explanation in Documentation/hwmon/coretemp.rst.

Guenter

