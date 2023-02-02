Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3D687F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjBBNs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjBBNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:48:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3146B371
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:48:42 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so4081270wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyL3kkiVp4mLz2Hp6hjic9mBVgDnqyFENCvNL4U+uOw=;
        b=a3erPWZfy6c6wCP0keZLVHNiuJcUKRL8M45u6fm68U/7S05oURTsDpWuvdD1dae7Lo
         dMNn4Oe0vMIoCssaewoXDrA2658XFrfu8xAXtHpTKPmys5WBz2K/uDIXdZutr+hesVa8
         huJPK9JgF1TFUkS/SEBabUrVmc9QU8u/mXJhWl0/qOlc46XCXxRomwdo9U8XYmuc/yYU
         yPzLrszUldhvaqLdQ0ljgpmycJ/EAptcyZGDkGSrA+NVdQEAeBY0lJwU9FIi1kzruKpt
         I2kS8f8ScCqiJ+pgGmm2Gpq5iDD0nNaLcipc/Z5Dj0PjwC9XRo+UsnD0LyJjFOy/Td8a
         js3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyL3kkiVp4mLz2Hp6hjic9mBVgDnqyFENCvNL4U+uOw=;
        b=vo9rt0Xd30YwbFWCx4CrtNYORm/TlLU8TXG24lOMKr7yYU9rsLej3fSpIFtyJgNOJl
         oEE5SPNjxodGDYmqck/Hx0iQbiuImLg8yTfOxiMQ6R3JZZuwPLq89k8TAz4WvUAeKOPQ
         akv9vtoFohMvA/TP0JNGIVUvP2+40iYgwxoKM50UwPXhPsW0kN515RDcKoh53P7zQX8y
         /VJ+HopzUCcSC8pksfcntQnpZ0WyeDqoHoKYdldy0I1678eOzGaf79vZ36/cLwWIzveR
         t+b0kIl0i7nOl+mHkd6RwkuStlSlQOeMrsXHbIGHNZMvohzyFmTbPtnJwz0kHF/vao+P
         TdpQ==
X-Gm-Message-State: AO0yUKX2hAF7rta0KyamJmlMotTDkwvpNpGC3OM+l3Pf7AwWphJP3/ub
        WcqtbjMhyHpiMwQwIJD9+J90CQ==
X-Google-Smtp-Source: AK7set8hw1rDy3WxUj4JBGJtDz2ZH5OsTbomKDnSUP4x83gmZ2C5vO+e3kiiVY5jg1hc1N3lf9Ev1g==
X-Received: by 2002:a05:600c:a07:b0:3df:db2f:66a with SMTP id z7-20020a05600c0a0700b003dfdb2f066amr2154590wmp.31.1675345720666;
        Thu, 02 Feb 2023 05:48:40 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v32-20020a05600c4da000b003dec22de1b1sm4402482wmp.10.2023.02.02.05.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 05:48:40 -0800 (PST)
Message-ID: <db23ece7-0ae1-586b-c4ec-f3ff633118a1@linaro.org>
Date:   Thu, 2 Feb 2023 14:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/4] powercap: idle_inject: Export symbols
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com
References: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
 <20230201182854.2158535-2-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230201182854.2158535-2-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 19:28, Srinivas Pandruvada wrote:
> Export symbols for external interfaces, so that they can be used in
> other loadable modules.
> 
> Export is done under name space IDLE_INJECT.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

(missing my ack from v3)

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> v2/v3/v4/v5:
> 	No change
> 
>   drivers/powercap/idle_inject.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index c03b5402c03b..ec02b370ec16 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -162,6 +162,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>   	if (!run_duration_us)
>   		pr_debug("CPU is forced to 100 percent idle\n");
>   }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_set_duration, IDLE_INJECT);
>   
>   /**
>    * idle_inject_get_duration - idle and run duration retrieval helper
> @@ -176,6 +177,7 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>   	*run_duration_us = READ_ONCE(ii_dev->run_duration_us);
>   	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>   }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_get_duration, IDLE_INJECT);
>   
>   /**
>    * idle_inject_set_latency - set the maximum latency allowed
> @@ -187,6 +189,7 @@ void idle_inject_set_latency(struct idle_inject_device *ii_dev,
>   {
>   	WRITE_ONCE(ii_dev->latency_us, latency_us);
>   }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_set_latency, IDLE_INJECT);
>   
>   /**
>    * idle_inject_start - start idle injections
> @@ -218,6 +221,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_start, IDLE_INJECT);
>   
>   /**
>    * idle_inject_stop - stops idle injections
> @@ -264,6 +268,7 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
>   
>   	cpu_hotplug_enable();
>   }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_stop, IDLE_INJECT);
>   
>   /**
>    * idle_inject_setup - prepare the current task for idle injection
> @@ -339,6 +344,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>   
>   	return NULL;
>   }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
>   
>   /**
>    * idle_inject_unregister - unregister idle injection control device
> @@ -359,6 +365,7 @@ void idle_inject_unregister(struct idle_inject_device *ii_dev)
>   
>   	kfree(ii_dev);
>   }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_unregister, IDLE_INJECT);
>   
>   static struct smp_hotplug_thread idle_inject_threads = {
>   	.store = &idle_inject_thread.tsk,

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

