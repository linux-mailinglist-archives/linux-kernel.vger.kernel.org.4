Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E96678CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbjALPO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjALPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:14:29 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E820C12AAC;
        Thu, 12 Jan 2023 07:05:33 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id jo4so45491739ejb.7;
        Thu, 12 Jan 2023 07:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wltNgvmoTEOdzqXrThP0TENXCKomPCLaFAPp9HR3deY=;
        b=ZgZ5L3Bketfsde0TLMzOY61Fvk+o266XO03TTckE5BOB8DKDeMsOkLLE2J/h9QoWsR
         yeSTo32aRST1+hrkt2TZLcLCPvV8u0Xj3adH/eVbCu3tcUicfMaPe/M7DmzWzE1zfDOC
         anFbgi4a52k/Iq89DCof5zYCIxa90PvHpvUgyhXCl4MxPx1/FIrzxfQOoQEKuxK7OjoW
         7MzbY8TXhqfFLIQhfjxaVrYbfty0dFLY8lDmyg6pO7+32RGNxtHqT+RJg6J8JRR9ZCdt
         Pi7XVJcfYtQCBC2ic5QICsAuxBIHzVPGzNy4xLRMP7MzkMw9rpP+TXzhooX2U4TTa3ux
         mW5w==
X-Gm-Message-State: AFqh2kpPt7iWWrphufPztSTKw72xKNmMSY2haYJ2Q+nwtmRQJvwyUHfe
        EKMrufUwxNCny0eCa9FdGtIOc9SDK4utQYKPBBU=
X-Google-Smtp-Source: AMrXdXvKmZ2PCMXVnx7nExgmOtUWzRBMI/6pY7Omz5S3AXQJ76U8+Cuvv1wgfhkdhzXb7XvSkvwJKcy+CYycMkK7wro=
X-Received: by 2002:a17:907:75ea:b0:7c0:f118:7e4e with SMTP id
 jz10-20020a17090775ea00b007c0f1187e4emr4416278ejc.478.1673535932416; Thu, 12
 Jan 2023 07:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com> <20221129233419.4022830-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221129233419.4022830-2-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 16:05:21 +0100
Message-ID: <CAJZ5v0gxTdHW_Wk2E13M+tK+B5rqOirY4sz6UJVMjhentvEstg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] powercap: idle_inject: Export symbols
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, amitk@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:34 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Export symbols for external interfaces, so that they can be used in
> other loadable modules.
>
> Export is done under name space IDLE_INJECT.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2:
>         No change
>
>  drivers/powercap/idle_inject.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index fe86a09e3b67..dfa989182e71 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -160,6 +160,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>                 WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
>         }
>  }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_set_duration, IDLE_INJECT);
>
>  /**
>   * idle_inject_get_duration - idle and run duration retrieval helper
> @@ -174,6 +175,7 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>         *run_duration_us = READ_ONCE(ii_dev->run_duration_us);
>         *idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>  }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_get_duration, IDLE_INJECT);
>
>  /**
>   * idle_inject_set_latency - set the maximum latency allowed
> @@ -185,6 +187,7 @@ void idle_inject_set_latency(struct idle_inject_device *ii_dev,
>  {
>         WRITE_ONCE(ii_dev->latency_us, latency_us);
>  }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_set_latency, IDLE_INJECT);
>
>  /**
>   * idle_inject_start - start idle injections
> @@ -216,6 +219,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_start, IDLE_INJECT);
>
>  /**
>   * idle_inject_stop - stops idle injections
> @@ -262,6 +266,7 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
>
>         cpu_hotplug_enable();
>  }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_stop, IDLE_INJECT);
>
>  /**
>   * idle_inject_setup - prepare the current task for idle injection
> @@ -337,6 +342,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>
>         return NULL;
>  }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
>
>  /**
>   * idle_inject_unregister - unregister idle injection control device
> @@ -357,6 +363,7 @@ void idle_inject_unregister(struct idle_inject_device *ii_dev)
>
>         kfree(ii_dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(idle_inject_unregister, IDLE_INJECT);
>
>  static struct smp_hotplug_thread idle_inject_threads = {
>         .store = &idle_inject_thread.tsk,
> --
> 2.31.1
>
