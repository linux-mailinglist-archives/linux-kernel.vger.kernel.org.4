Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0D5FC504
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJLMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJLMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:07:28 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FB1B9C3;
        Wed, 12 Oct 2022 05:07:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id h1-20020a4aa741000000b004756c611188so12012134oom.4;
        Wed, 12 Oct 2022 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdG+anD4T/Gy+xDHzUmpSm9s7SkxhK5WIyr0Mbbg6tU=;
        b=gZfE9RjYh2TDaXEE+y0SmdT0C+AyQ1y8ljLCC3y05tc6qyxkv6BckhEPgUvOLemN7h
         IAXXKtOrQiPFPTAyCDoNjavZciBxrfQTXUZ9cz8GFRpFXslvM7HcHdrIr38Iak3A4zZK
         Hv3OXYzseJ2VJCMBp/2D+CqOkVBIXcg3x7tKzcYkd+KLuIIlmODimhT37wx4MEwzcPPg
         g31zDaKNgMMDcxDJQns4IaSNjRPmtPged8Y5PrA6yYKgueug0aFZyiBC0/octKSQBgW7
         o4ghdnSWOFNORTHUOo0UqVzHZJVUTid9iheUsajUjJ/8NHfOaI/E0znTR542J9XWGaUI
         H96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdG+anD4T/Gy+xDHzUmpSm9s7SkxhK5WIyr0Mbbg6tU=;
        b=gtcgg7DYe9skjnRHppnIrPKBbRhYYyL//hMCOeHCotEarhTfPE75R1UHMDJ2vS1KcB
         xEkD4msQ0+9PKkiZwXIXvHYkc/QmDqyBuPIWPs0cNxHT3zmPd4/bxrGQGJfxRr857XC2
         JblPjPaD0AUBMocJN+PWFWXSnnuGCeKF87voiYCOD/cgCHlAunS4WYXBZ4DRM2vbZ7H0
         x3JPIxyC3vFxVIVs5bk4bEf79DmkVGkHoYGlJQYvr9o5fO43FllE0ARsyz+GCOV6yJ9A
         LuRDlWrYlk0WDcPGmOwKErCzV8Gcr8SXNadjgakTTYOWArQNsuVMFYW5592WntatUOmt
         A5sQ==
X-Gm-Message-State: ACrzQf1jOSXLdfwb2BZjkhUz0qKl4/EmK9jZt5atD3TY+mG84yxs0/8G
        iyFmsocnXSFwhk/806PE1dn7ZzZWFJUSOw==
X-Google-Smtp-Source: AMsMyM6YkTSw3ZkAFaeMfoCdK+kW3r3GT2niazzrovGK4nYUaCpPirw+9c594ksoTKdb/l8ycb0xqw==
X-Received: by 2002:a05:6830:2788:b0:65c:48ac:8f38 with SMTP id x8-20020a056830278800b0065c48ac8f38mr12525761otu.359.1665576405966;
        Wed, 12 Oct 2022 05:06:45 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id u127-20020a4a5785000000b0047f72b6988fsm878200ooa.45.2022.10.12.05.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 05:06:45 -0700 (PDT)
Message-ID: <733ea288-5b10-56ed-49d0-3bbfb022a7c9@gmail.com>
Date:   Wed, 12 Oct 2022 07:06:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RESEND PATCH V2 0/9] Implement AMD Pstate EPP Driver
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
From:   Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although I am very much in favor of having some kernel interface to the
EPP MSR for AMD CPUs just as for Intel, I have some reservations about
the units in the tables, and whether performance per watt, measured in
this way by these benchmarks, is an appropriate figure of merit for
cpufreq governors.

On 10/10/22 11:22, Perry Yuan wrote:

> The PPW calculation is referred by below paper:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Fperformance-per-what-paper.pdf&amp;data=04%7C01%7CPerry.Yuan%40amd.com%7Cac66e8ce98044e9b062708d9ab47c8d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637729147708574423%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=TPOvCE%2Frbb0ptBreWNxHqOi9YnVhcHGKG88vviDLb00%3D&amp;reserved=0
> 
> Below formula is referred from below spec to measure the PPW:
> 
> (F / t) / P = F * t / (t * E) = F / E,
> 
> "F" is the number of frames per second.
> "P" is power measured in watts.
> "E" is energy measured in joules.

In the whitepaper, "F" is not the number of frames per second.  It is
the number of frames.  The number of frames per second is "F/t", where
"t" is the number of seconds. Following the dimensional analysis:

    Frames
   --------- / Watts
    seconds

    Frames      Joules
 = --------- / ---------
    seconds     seconds

    Frames      seconds
 = --------- * ---------
    seconds     Joules

    Frames
 = ---------
    Joules

All the seconds cancel, and performance per watt reduces to completed
work divided by energy, as you would expect. However, in the benchmark
tables, seconds always appear in the PPW unit.

Furthermore...

> Gitsouce Benchmark Data on ROME Server CPU
> +------------------------------+------------------------------+------------+------------------+
> | Kernel Module                | PPW (1 / s * J)              |Energy(J) | PPW Improvement (%)|
> +==============================+==============================+============+==================+
> | acpi-cpufreq:schedutil       | 5.85658E-05                  | 17074.8    | base             |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:ondemand        | 5.03079E-05                  | 19877.6    | -14.10%          |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:performance     | 5.88132E-05                  | 17003      | 0.42%            |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:ondemand          | 4.60295E-05                  | 21725.2    | -21.41%          |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:schedutil         | 4.70026E-05                  | 21275.4    | -19.7%           |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:performance       | 5.80094E-05                  | 17238.6    | -0.95%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:performance              | 5.8292E-05                   | 17155      | -0.47%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP: balance performance:    | 6.71709E-05                  | 14887.4    | 14.69%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:power                    | 6.66951E-05                  | 4993.6     | 13.88%           |
> +------------------------------+------------------------------+------------+------------------+

The numbers in the PPW column are equal to 1/Energy, so the math works
out even if the units are mislabeled. But neither the actual performance
nor anything that can be used to derive it appear in the table.

As far as I can tell, this benchmark, which compiles git from source,
should be entirely CPU bound.  That is, it is occupying at least one CPU
core for the entire runtime. [1] For such tasks, to a first order
approximation you can run the CPU at 1/2 frequency and finish the task
with 1/4 the energy in 2x the time. Since the time units vanish,
"performance per watt" can look good when performance and watts are both
low. So you very much need to have performance in the table.

I can think of a couple ways to handle this problem. The empirical
approach would be to use the userspace governor and scaling_setspeed to
iteratively find a fixed frequency with similar benchmark performance to
each driver/governor, and then report the energy usage. The "benchmark"
should probably be a sum of multiple runtime benchmarks, or a harmonic
mean of multiple rate benchmarks, because the advantage a governor is
supposed to have is the ability to adapt to different workloads and/or
different phases of computation.

Alternately, one might use or perf^3/watt as the figure of merit. That's
an ED2P metric [2], and you'd be comparing governors on their ability to
make the CPU look like a "better" CPU by identifying tasks that waste a
lot of available cycles stalled on things outside the CPU core clock
domain (DRAM, I/O) and running them at lower frequency and higher
instructions per available cycle.

I've heard about perf^2/watt being used, but I don't know what, if any,
theoretical basis it has.

On another note, If PPW of CPU-bound tasks is maximized based on energy
counted with the CPU package energy MSR only (assuming it's even
calibrated), without including DRAM and baseline consumers like fans,
HDDs, southbridge, displays, NICs, radios, ect., then the PPW of the
system as a whole is certain to be worse. This is the idea behind
race-to-idle. On the other hand, CPU package power can be the correct
measure for deadline-type workloads where finishing the task sooner
doesn't allow powering down the machine. That's stuff like
line-speed-limited network servers and scrolling in web browsers. In
that case, the only thing that goes to sleep when the task is done is
the CPU, so the only energy that counts is the energy burnt in the CPU.

> Tbench Benchmark Data on ROME Server CPU
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | Kernel Module                               | PPW MB / (s * J)  |Throughput(MB/s)| Energy (J)|PPW Improvement(%)|
> +=============================================+===================+==============+=============+==================+
> | acpi_cpufreq: schedutil                     | 46.39             | 17191        | 37057.3     | base             |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: ondemand                      | 51.51             | 19269.5      | 37406.5     | 11.04 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: performance                   | 45.96             | 17063.7      | 37123.7     | -0.74 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: performance(0)               | 54.46             | 20263.1      | 37205       | 17.87 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance performance          | 55.03             | 20481.9      | 37221.5     | 19.14 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance_power                | 54.43             | 20245.9      | 37194.2     | 17.77 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: power(255)                   | 54.26             | 20181.7      | 37197.4     | 17.40 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: schedutil                       | 48.22             | 17844.9      | 37006.6     | 3.80 %           |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: ondemand                        | 61.30             | 22988        | 37503.4     | 33.72 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: performance                     | 54.52             | 20252.6      | 37147.8     | 17.81 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
For this one it seems like PPW is calculated as Throughput/Energy * 100?
The benchmark looks a lot like the result of running the script at [3].
It looks like the script would multiply by 99 though?  And also the
bogus time units do not appear in the script, so if that's a newer
version I'm glad it's fixed.

But I ran tbench on my own machine, single-thread to reduce the impact
of background activity, and got this:

+---------------+---------------------+--------+
| CPU Frequency | Throughput ( MB/s ) | Perf % |
+===============+=====================+========+
| 1 GHz         |  85.78              | Base   |
| 2 GHz         | 174.35              | 203 %  |
| 3 GHz         | 264.04              | 308 %  |
| 4 GHz         | 352.86              | 411 %  |
+---------------+---------------------+--------+

Which implies tbench is 100% clock-frequency-bound [1, 4], and so this
benchmark is equivalent to measuring the average clock frequency over
the runtime. I think that means the most interesting number in your
table is the throughput.

Somehow, amd-pstate:ondemand is running the CPU faster on average than
even amd-pstate:performance and EPP:powersave:performance, which
*should* be choosing the highest possible frequency at all times.

1. As I understand it, the intent in the schedutil governor is to run
CPU-bound tasks at maximum performance, and if you want to trade energy
for time userspace should set cpu.uclamp.max in the cgroup.  Any
CPU-bound benchmark that runs slower under the schedutil governor than
under the performance governor can then be considered a bug. There are
many such bugs, and tbench is one of them.  But I agree with the
philosphy: 1:1 scaling with CPU frequency is the best possible, and no
governor should be running such a workload below scaling_max_frequency.

2. http://www.eecs.umich.edu/courses/eecs470/OLD/w14/lectures/470L14W14.pdf

3.
https://patchwork.kernel.org/project/linux-pm/patch/20220914061105.1982477-3-li.meng@amd.com/

4. I suspect the >100% scaling is due to the relative overhead of
background tasks and scheduling being less at higher clock frequency.


