Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A468264E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjAaIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjAaIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:25:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C019C43444;
        Tue, 31 Jan 2023 00:25:03 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id pj3so705896pjb.1;
        Tue, 31 Jan 2023 00:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0rwG3PqPm8a8AxcESZ4/zakZ0Dt7cBUSWN3oZUnKNg=;
        b=R0vq8mjsTy6EvMYEEcuDPuZaCSOvXTALXlMfC8TFOutprP6cDzUbg2/DLTJGr22sQ4
         jEA6///cmrQGdAqbZnoP36CIwhnPG+vIx0BXI/kXjbLrQJKCiUBPiYAoaEGfgUXx6YF+
         /J5KT/m2g7m7Eha/da6AJWgglUTHBHQwNqRW0/DhGIL1zu0nH8y1bhYZssdzoFNpGHmw
         6WiKse25+cZonkHaVDgR80AZLcqFo/Dw4o3oa997tOzTiCKlDdPVk5gxisDxvEbMVokf
         /e2CVK6wEyNXdMJh/0oQFojPwQw8iFJpuT14Jot9zFSVI9UyDEPcEgLQ2vY+FzCzt6eU
         tinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0rwG3PqPm8a8AxcESZ4/zakZ0Dt7cBUSWN3oZUnKNg=;
        b=7SHH5JjtBpvvmKR6noBu9P/g57GsrAtNg4BpaytRoXGF4zDTEEO/M2JUoiCZ3vGp7x
         qekx7GhLXUckqafN0vwYJh58DBFJDgoSCgdbXg0TRL3R0XQRb305PMW9Xou1PJQdSXlj
         dwGRgSolGoCda4kYG+gHEoKuLgTuSbv0WIreHM7siSlK1riuMoJf+M3k1j8EOA4inyfx
         8IKFhhGKzke5BwKLnNOHCMD8PnS47YWsdo7wC5FV+VlH2L2lXMw5mbNwmX+YSf/kXu/s
         R3RNYSGPwS5iOKGcxN5sIm4QWKfzh/9GQr3YsCjiWwoIU0p8yVWNEOR9JiXjjyZC6iHp
         RNJQ==
X-Gm-Message-State: AO0yUKUuOc7UoRATEtNUFVSggwgd/Dkf8WAxkZL0epru8l7gF6qMHO6k
        VJ/TiIzoNcfrrOXhhwz9OkxX+t0QoFT0Ew==
X-Google-Smtp-Source: AK7set+ONdUfzlGAqobNIINVyfq35C+e4y0xbm5IeVAJeNKEEadcn0mKHBf7vVnjWLyB/N3xsBJxLg==
X-Received: by 2002:a05:6a20:1b06:b0:b9:24d:8320 with SMTP id ch6-20020a056a201b0600b000b9024d8320mr10590710pzb.26.1675153503167;
        Tue, 31 Jan 2023 00:25:03 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id q19-20020a656853000000b004d09bbd023csm8058524pgt.88.2023.01.31.00.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:25:02 -0800 (PST)
Message-ID: <e4f9b513-f4c2-8a89-a768-ecfd005249f4@gmail.com>
Date:   Tue, 31 Jan 2023 15:24:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: build warnings after merge of the ftrace tree
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230130165149.7933efb1@canb.auug.org.au>
 <20230130135148.5fc7431b@gandalf.local.home>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230130135148.5fc7431b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 01:51, Steven Rostedt wrote:
> krobot saw this too. I'm thinking this can fix it:
> 
> -- Steve
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index 5c391328b9bb..026eef03afe0 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -1864,7 +1864,7 @@ A histogram can now be defined for the new synthetic event::
>  The above shows the latency "lat" in a power of 2 grouping.
>  
>  Like any other event, once a histogram is enabled for the event, the
> -output can be displayed by reading the event's 'hist' file.
> +output can be displayed by reading the event's 'hist' file::
>  
>    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
>  
> @@ -1911,7 +1911,7 @@ output can be displayed by reading the event's 'hist' file.
>  
>  
>  The latency values can also be grouped linearly by a given size with
> -the ".buckets" modifier and specify a size (in this case groups of 10).
> +the ".buckets" modifier and specify a size (in this case groups of 10)::
>  
>    # echo 'hist:keys=pid,prio,lat.buckets=10:sort=lat' >> \
>          /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
> @@ -1945,7 +1945,7 @@ the ".buckets" modifier and specify a size (in this case groups of 10).
>  
>  To save stacktraces, create a synthetic event with a field of type "unsigned long[]"
>  or even just "long[]". For example, to see how long a task is blocked in an
> -uninterruptible state:
> +uninterruptible state::
>  
>    # cd /sys/kernel/tracing
>    # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
> @@ -1990,7 +1990,7 @@ uninterruptible state:
>    => kthread+0xe9/0x110
>    => ret_from_fork+0x2c/0x50
>  
> -A synthetic event that has a stacktrace field may use it as a key in histogram:
> +A synthetic event that has a stacktrace field may use it as a key in histogram::
>  
>    # echo 'hist:delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger
>    # cat events/synthetic/block_lat/hist
> @@ -2183,7 +2183,7 @@ The following commonly-used handler.action pairs are available:
>                wakeup_new_test($testpid) if comm=="cyclictest"' >> \
>                /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
>  
> -    Or, equivalently, using the 'trace' keyword syntax:
> +    Or, equivalently, using the 'trace' keyword syntax::
>  
>      # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
>              trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
> @@ -2320,7 +2320,7 @@ The following commonly-used handler.action pairs are available:
>      resulting latency, stored in wakeup_lat, exceeds the current
>      maximum latency, a snapshot is taken.  As part of the setup, all
>      the scheduler events are also enabled, which are the events that
> -    will show up in the snapshot when it is taken at some point:
> +    will show up in the snapshot when it is taken at some point::
>  
>      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
>  
> @@ -2339,7 +2339,7 @@ The following commonly-used handler.action pairs are available:
>      following the rest of the fields.
>  
>      If a snapshot was taken, there is also a message indicating that,
> -    along with the value and event that triggered the global maximum:
> +    along with the value and event that triggered the global maximum::
>  
>      # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
>        { next_pid:       2101 } hitcount:        200
> @@ -2439,7 +2439,7 @@ The following commonly-used handler.action pairs are available:
>      $cwnd variable.  If the value has changed, a snapshot is taken.
>      As part of the setup, all the scheduler and tcp events are also
>      enabled, which are the events that will show up in the snapshot
> -    when it is taken at some point:
> +    when it is taken at some point::
>  
>      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
>      # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable

Hi Steve,

I had already sent the fix, which also include required indentation changes
to make code blocks alignment nicer at [1].

Thanks.

[1]: https://lore.kernel.org/linux-doc/20230129031402.47420-1-bagasdotme@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

