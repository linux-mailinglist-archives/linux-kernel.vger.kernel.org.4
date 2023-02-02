Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B46884B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjBBQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjBBQla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:41:30 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9216A33D;
        Thu,  2 Feb 2023 08:41:19 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id p26so7532399ejx.13;
        Thu, 02 Feb 2023 08:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMEUzV79djPNglFPNvQyYDYgkjJYNlqfDHh5F9nZxs8=;
        b=MKKcBwg7vyYYR+n6nx1RCzljdMUX4SOi4lwms3q6pwlrh445DoRfOFC9x8ZtftynoK
         hAyOMNn8Dbt2P4IVDRoFslTwwzfJEzUCOYcLp5u0Lf7NXHdLEaKZXNv0R/rjYIVJwp+y
         Je+XV9/MFCgkDcfN2GN62wPHii9pWQdmsagM5Jq8wedzX4P1w/lHq1aFLKSfvjDkB8+X
         z7pyvuQlKgsZfvJvSfQZWWi+vvGroSUrxIVDKRThDbzFBHG1iaAZVUMpmxYprsWxNESc
         bNbtP5ahBeIHnevHriENMGkuHHPaZAQ868C697wM97ObBxbkp/NJCnoBNk7ppkKXCir2
         NHeA==
X-Gm-Message-State: AO0yUKVwlT/XNgFBX0uaQiog3SJOkavRC93J6YX3H3osz9ZGvfXOAeBf
        fVCWctwAtIjvsGSNcrYRIx89FEldp4p5z7Irj/bywKSYoyE=
X-Google-Smtp-Source: AK7set/A7dtKM6+llIyRXiYZ2Rsj+dEqnMf9dnYDNwCm+hZvD+0mwFbKmPKMEM2RZRmIFLyrIwxAFMMwyXua6oxA0LY=
X-Received: by 2002:a17:906:2f88:b0:844:44e0:1c4e with SMTP id
 w8-20020a1709062f8800b0084444e01c4emr2185153eji.291.1675356078239; Thu, 02
 Feb 2023 08:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com> <20230201182854.2158535-5-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230201182854.2158535-5-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 17:41:06 +0100
Message-ID: <CAJZ5v0g0oVj974A22z5HaYK_JE8SuL82kvwA21=g9EM=-JqPnQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] thermal/drivers/intel_powerclamp: Add additional
 module params
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, I would say "Add two module parameters" in the subject.

On Wed, Feb 1, 2023 at 7:35 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> In some use cases, it is desirable to only inject idle on certain set
> of CPUs. For example on Alder Lake systems, it is possible that we force
> idle only on P-Cores for thermal reasons. Also the idle percent can be
> more than 50% if we only choose partial set of CPUs in the system.
>
> Introduce module parameters for setting cpumask and max_idle.

"Introduce 2 new module parameters for this purpose."

> They can be only changed when the cooling device is inactive. This module
> already have other module parameters. There is no change done for
> those parameters.

s/have/has/

"... other parameters that are not affected by this change."

> cpumask (Read/Write): A bit mask of CPUs to inject idle. The format of
> this bitmask is same as used in other subsystems like in
> /proc/irq/*/smp_affinity. The mask is comma separated 32 bit groups.
> Each CPU is one bit. For example for 256 CPU system the full mask is:
> ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> The leftmost mask is for CPU 0-32.
>
> max_idle (Read/Write): Maximum injected idle time to the total CPU time
> ratio in percent range from 1 to 100. Even if the cooling device max_state
> is always 100 (100%), this parameter allows to add a max idle percent
> limit. The default is 50, to match the current implementation of powerclamp
> driver. Also doesn't allow value more than 75, if the cpumask includes
> every CPU present in the system.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v5
> New patch
>
>  .../driver-api/thermal/intel_powerclamp.rst   |  22 +++
>  drivers/thermal/intel/intel_powerclamp.c      | 169 ++++++++++++++++--
>  2 files changed, 173 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/driver-api/thermal/intel_powerclamp.rst b/Documentation/driver-api/thermal/intel_powerclamp.rst
> index 3f6dfb0b3ea6..d805e28b7a45 100644
> --- a/Documentation/driver-api/thermal/intel_powerclamp.rst
> +++ b/Documentation/driver-api/thermal/intel_powerclamp.rst
> @@ -26,6 +26,8 @@ By:
>             - Generic Thermal Layer (sysfs)
>             - Kernel APIs (TBD)
>
> +       (*) Module Parameters
> +
>  INTRODUCTION
>  ============
>
> @@ -318,3 +320,23 @@ device, a PID based userspace thermal controller can manage to
>  control CPU temperature effectively, when no other thermal influence
>  is added. For example, a UltraBook user can compile the kernel under
>  certain temperature (below most active trip points).
> +
> +Module Parameters
> +=================
> +
> +``cpumask`` (RW)
> +       A bit mask of CPUs to inject idle. The format of the bitmask is same as
> +       used in other subsystems like in /proc/irq/*/smp_affinity. The mask is
> +       comma separated 32 bit groups. Each CPU is one bit. For example for a 256
> +       CPU system the full mask is:
> +       ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> +
> +       The leftmost mask is for CPU 0-32.
> +
> +``max_idle`` (RW)
> +       Maximum injected idle time to the total CPU time ratio in percent range
> +       from 1 to 100. Even if the cooling device max_state is always 100 (100%),
> +       this parameter allows to add a max idle percent limit. The default is 50,
> +       to match the current implementation of powerclamp driver. Also doesn't
> +       allow value more than 75, if the cpumask includes every CPU present in
> +       the system.

I'm not sure if this is driver-api.  It's admin-guide rather IMO.

> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 850195ebe5e0..68830b726da2 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -37,7 +37,7 @@
>  #include <asm/mwait.h>
>  #include <asm/cpu_device_id.h>
>
> -#define MAX_TARGET_RATIO (50U)
> +#define MAX_TARGET_RATIO (100U)
>  /* For each undisturbed clamping period (no extra wake ups during idle time),
>   * we increment the confidence counter for the given target ratio.
>   * CONFIDENCE_OK defines the level where runtime calibration results are
> @@ -109,6 +109,135 @@ static const struct kernel_param_ops duration_ops = {
>  module_param_cb(duration, &duration_ops, &duration, 0644);
>  MODULE_PARM_DESC(duration, "forced idle time for each attempt in msec.");
>
> +#define DEFAULT_MAX_IDLE       50
> +#define MAX_ALL_CPU_IDLE       75
> +
> +static u8 max_idle = DEFAULT_MAX_IDLE;
> +
> +static cpumask_var_t idle_injection_cpu_mask;
> +
> +static int allocate_idle_injection_mask(void)
> +{
> +       /* This mask is allocated only one time and freed during module exit */
> +       if (!idle_injection_cpu_mask) {

I would do

if (idle_injection_cpu_mask)
         return 0;

here and rearrange the rest of the function accordingly.

> +               if (!zalloc_cpumask_var(&idle_injection_cpu_mask, GFP_KERNEL))
> +                       return -ENOMEM;
> +
> +               cpumask_copy(idle_injection_cpu_mask, cpu_present_mask);
> +       }
> +
> +       return 0;
> +}
> +
> +static int cpumask_set(const char *arg, const struct kernel_param *kp)
> +{
> +       int ret;
> +
> +       mutex_lock(&powerclamp_lock);
> +
> +       /* Can't set mask when cooling device is in use */
> +       if (powerclamp_data.clamping) {
> +               ret = -EAGAIN;
> +               goto skip_cpumask_set;
> +       }
> +
> +       /*
> +        * When module parameters are passed from kernel command line
> +        * during insmod, the module parameter callback is called
> +        * before powerclamp_init(), so we can't assume that some
> +        * cpumask can be allocated before here.
> +        */
> +       ret = allocate_idle_injection_mask();

Could it be allocated by powerclamp_init(), though?  It is not useful
before that function runs anyway.

> +       if (ret)
> +               goto skip_cpumask_set;
> +
> +       ret = bitmap_parse(arg, strlen(arg), cpumask_bits(idle_injection_cpu_mask),

So this would replace the existing idle_injection_cpu_mask even if it
is going to fail later.

> +                          nr_cpumask_bits);
> +       if (ret)
> +               goto skip_cpumask_set;
> +
> +       if (cpumask_empty(idle_injection_cpu_mask)) {
> +               ret = -EINVAL;
> +               goto skip_cpumask_set;
> +       }
> +
> +       if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask) &&

Should this check be against cpu_online_mask instead?  Arguably
offline CPUs don't matter here.

> +                         max_idle > MAX_ALL_CPU_IDLE) {
> +               ret = -EINVAL;
> +               goto skip_cpumask_set;
> +       }
> +
> +       mutex_unlock(&powerclamp_lock);
> +
> +       return 0;
> +
> +skip_cpumask_set:
> +       mutex_unlock(&powerclamp_lock);
> +
> +       return ret;
> +}
> +
> +static int cpumask_get(char *buf, const struct kernel_param *kp)
> +{
> +       if (!idle_injection_cpu_mask)
> +               return -EINVAL;

I would return -ENODEV here.

> +
> +       return bitmap_print_to_pagebuf(false, buf, cpumask_bits(idle_injection_cpu_mask),
> +                                      nr_cpumask_bits);
> +}
> +
> +static const struct kernel_param_ops cpumask_ops = {
> +       .set = cpumask_set,
> +       .get = cpumask_get,
> +};
> +
> +module_param_cb(cpumask, &cpumask_ops, NULL, 0644);
> +MODULE_PARM_DESC(cpumask, "Mask of CPUs to use for idle injection.");
> +
> +static int max_idle_set(const char *arg, const struct kernel_param *kp)
> +{
> +       u8 _max_idle;

new_max_idle would be slightly better I think.

> +       int ret = 0;
> +
> +       mutex_lock(&powerclamp_lock);
> +
> +       /* Can't set mask when cooling device is in use */
> +       if (powerclamp_data.clamping) {
> +               ret = -EAGAIN;
> +               goto skip_limit_set;
> +       }
> +
> +       ret = kstrtou8(arg, 10, &_max_idle);
> +       if (ret)
> +               goto skip_limit_set;
> +
> +       if (_max_idle > MAX_TARGET_RATIO) {
> +               ret = -EINVAL;
> +               goto skip_limit_set;
> +       }
> +
> +       if (idle_injection_cpu_mask && cpumask_equal(cpu_present_mask, idle_injection_cpu_mask) &&
> +           _max_idle > MAX_ALL_CPU_IDLE) {

The same check is done here and in cpumask_set().  Could it be done in
a separate function called from here and from there?

> +               ret = -EINVAL;
> +               goto skip_limit_set;
> +       }
> +
> +       max_idle = _max_idle;
> +
> +skip_limit_set:
> +       mutex_unlock(&powerclamp_lock);
> +
> +       return ret;
> +}
> +
> +static const struct kernel_param_ops max_idle_ops = {
> +       .set = max_idle_set,
> +       .get = param_get_int,
> +};
> +
> +module_param_cb(max_idle, &max_idle_ops, &max_idle, 0644);
> +MODULE_PARM_DESC(max_idle, "maximum injected idle time to the total CPU time ratio in percent range:1-100");
> +
>  struct powerclamp_calibration_data {
>         unsigned long confidence;  /* used for calibration, basically a counter
>                                     * gets incremented each time a clamping
> @@ -342,6 +471,10 @@ static unsigned int get_run_time(void)
>         unsigned int compensated_ratio;
>         unsigned int runtime;
>
> +       /* No compensation for non systemwide idle injection */
> +       if (max_idle > MAX_ALL_CPU_IDLE)
> +               return (duration * 100 / powerclamp_data.target_ratio - duration);
> +
>         /*
>          * make sure user selected ratio does not take effect until
>          * the next round. adjust target_ratio if user has changed
> @@ -460,21 +593,11 @@ static void trigger_idle_injection(void)
>   */
>  static int powerclamp_idle_injection_register(void)
>  {
> -       /*
> -        * The idle inject core will only inject for online CPUs,
> -        * So we can register for all present CPUs. In this way
> -        * if some CPU goes online/offline while idle inject
> -        * is registered, nothing additional calls are required.
> -        * The same runtime and idle time is applicable for
> -        * newly onlined CPUs if any.
> -        *
> -        * Here cpu_present_mask can be used as is.
> -        * cast to (struct cpumask *) is required as the
> -        * cpu_present_mask is const struct cpumask *, otherwise
> -        * there will be compiler warnings.
> -        */
> -       ii_dev = idle_inject_register_full((struct cpumask *)cpu_present_mask,
> -                                          idle_inject_update);
> +       if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask))
> +               ii_dev = idle_inject_register_full(idle_injection_cpu_mask, idle_inject_update);
> +       else
> +               ii_dev = idle_inject_register(idle_injection_cpu_mask);
> +
>         if (!ii_dev) {
>                 pr_err("powerclamp: idle_inject_register failed\n");
>                 return -EAGAIN;
> @@ -510,7 +633,7 @@ static int start_power_clamp(void)
>         ret = powerclamp_idle_injection_register();
>         if (!ret) {
>                 trigger_idle_injection();
> -               if (poll_pkg_cstate_enable)
> +               if (poll_pkg_cstate_enable && max_idle < MAX_ALL_CPU_IDLE)

Why is the additional check needed here?

>                         schedule_delayed_work(&poll_pkg_cstate_work, 0);
>         }
>
> @@ -565,7 +688,7 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
>         mutex_lock(&powerclamp_lock);
>
>         new_target_ratio = clamp(new_target_ratio, 0UL,
> -                               (unsigned long) (MAX_TARGET_RATIO - 1));
> +                               (unsigned long) (max_idle - 1));
>         if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
>                 pr_info("Start idle injection to reduce power\n");
>                 powerclamp_data.target_ratio = new_target_ratio;
> @@ -656,6 +779,13 @@ static int __init powerclamp_init(void)
>
>         /* probe cpu features and ids here */
>         retval = powerclamp_probe();
> +       if (retval)
> +               return retval;
> +
> +       mutex_lock(&powerclamp_lock);
> +       retval = allocate_idle_injection_mask();
> +       mutex_unlock(&powerclamp_lock);
> +
>         if (retval)
>                 return retval;
>
> @@ -689,6 +819,9 @@ static void __exit powerclamp_exit(void)
>
>         cancel_delayed_work_sync(&poll_pkg_cstate_work);
>         debugfs_remove_recursive(debug_dir);
> +
> +       if (idle_injection_cpu_mask)
> +               free_cpumask_var(idle_injection_cpu_mask);
>  }
>  module_exit(powerclamp_exit);
>
> --
