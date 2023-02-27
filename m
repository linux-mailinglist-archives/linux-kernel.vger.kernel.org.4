Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F96A4284
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjB0NVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjB0NVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:21:48 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE3120553;
        Mon, 27 Feb 2023 05:21:45 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id DFC386244DF88;
        Mon, 27 Feb 2023 14:21:43 +0100 (CET)
Message-ID: <b41fb307-9fa0-6939-5b25-81decadf7977@molgen.mpg.de>
Date:   Mon, 27 Feb 2023 14:21:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Several Dell laptops: thermal thermal_zoneX: failed to read out
 thermal zone (-61)
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <466c8661-4d5b-ba05-328d-6772804169d3@molgen.mpg.de>
In-Reply-To: <466c8661-4d5b-ba05-328d-6772804169d3@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Am 23.08.22 um 16:00 schrieb Paul Menzel:

> On the Dell XPS 13 9370 with Debian sid/unstable, Linux warns about a 
> thermal related issue:
> 
>      [    0.000000] Linux version 5.18.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU 
> ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
>      […]
>      [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
>      […]
>      [   15.722394] thermal thermal_zone10: failed to read out thermal zone (-61)
> 
> Can that warning be addressed?

For the record, this warning is also logged by Linux 6.1.12 on a Dell 
Precision 3540:

     [    0.000000] Linux version 6.1.0-5-amd64 
(debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU 
ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 
6.1.12-1 (2023-02-15)
     […]
     [    0.000000] DMI: Dell Inc. Precision 3540/0M14W7, BIOS 1.23.0 
12/19/2022
     […]
     [   20.958894] thermal thermal_zone8: failed to read out thermal 
zone (-61)


Kind regards,

Paul


> PS: There are twelve thermal zones:
> 
> ```
> $ ls -l /sys/devices/virtual/thermal/
> total 0
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device0
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device1
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device2
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device3
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device4
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device5
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device6
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device7
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device8
> drwxr-xr-x 4 root root 0 Aug 23 14:24 cooling_device9
> drwxr-xr-x 4 root root 0 Aug 23 14:24 thermal_zone0
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone1
> drwxr-xr-x 4 root root 0 Aug 23 14:24 thermal_zone10
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone11
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone2
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone3
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone4
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone5
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone6
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone7
> drwxr-xr-x 4 root root 0 Aug 23 14:24 thermal_zone8
> drwxr-xr-x 3 root root 0 Aug 23 14:24 thermal_zone9
> $ ls -l /sys/devices/virtual/thermal/thermal_zone10/
> total 0
> -r--r--r-- 1 root root 4096 Aug 23 16:00 available_policies
> drwxr-xr-x 3 root root    0 Aug 23 14:24 hwmon6
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 integral_cutoff
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 k_d
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 k_i
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 k_po
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 k_pu
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 mode
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 offset
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 policy
> drwxr-xr-x 2 root root    0 Aug 23 15:33 power
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 slope
> lrwxrwxrwx 1 root root    0 Aug 23 14:24 subsystem -> ../../../../class/thermal
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 sustainable_power
> -r--r--r-- 1 root root 4096 Aug 23 16:00 temp
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 trip_point_0_temp
> -r--r--r-- 1 root root 4096 Aug 23 16:00 trip_point_0_type
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 trip_point_1_temp
> -r--r--r-- 1 root root 4096 Aug 23 16:00 trip_point_1_type
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 trip_point_2_temp
> -r--r--r-- 1 root root 4096 Aug 23 16:00 trip_point_2_type
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 trip_point_3_temp
> -r--r--r-- 1 root root 4096 Aug 23 16:00 trip_point_3_type
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 trip_point_4_temp
> -r--r--r-- 1 root root 4096 Aug 23 16:00 trip_point_4_type
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 trip_point_5_temp
> -r--r--r-- 1 root root 4096 Aug 23 16:00 trip_point_5_type
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 trip_point_6_temp
> -r--r--r-- 1 root root 4096 Aug 23 16:00 trip_point_6_type
> -rw-r--r-- 1 root root 4096 Aug 23 16:00 trip_point_7_temp
> -r--r--r-- 1 root root 4096 Aug 23 16:00 trip_point_7_type
> -r--r--r-- 1 root root 4096 Aug 23 16:00 type
> -rw-r--r-- 1 root root 4096 Aug 23 14:24 uevent
> ```

For the Dell Precision 3540:

```
$ ls -l /sys/devices/virtual/thermal/
total 0
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device0
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device1
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device2
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device3
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device4
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device5
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device6
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device7
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device8
drwxr-xr-x 4 root root 0 Feb 27 11:09 cooling_device9
drwxr-xr-x 4 root root 0 Feb 27 11:09 thermal_zone0
drwxr-xr-x 3 root root 0 Feb 27 11:09 thermal_zone1
drwxr-xr-x 3 root root 0 Feb 27 11:09 thermal_zone2
drwxr-xr-x 4 root root 0 Feb 27 11:09 thermal_zone3
drwxr-xr-x 3 root root 0 Feb 27 11:09 thermal_zone4
drwxr-xr-x 3 root root 0 Feb 27 11:09 thermal_zone5
drwxr-xr-x 3 root root 0 Feb 27 11:09 thermal_zone6
drwxr-xr-x 3 root root 0 Feb 27 11:09 thermal_zone7
drwxr-xr-x 4 root root 0 Feb 27 11:09 thermal_zone8
drwxr-xr-x 3 root root 0 Feb 27 11:09 thermal_zone9
$ ls -l /sys/devices/virtual/thermal/thermal_zone8
total 0
-r--r--r-- 1 root root 4096 Feb 27 14:21 available_policies
drwxr-xr-x 3 root root    0 Feb 27 11:09 hwmon6
-rw-r--r-- 1 root root 4096 Feb 27 14:21 integral_cutoff
-rw-r--r-- 1 root root 4096 Feb 27 14:21 k_d
-rw-r--r-- 1 root root 4096 Feb 27 14:21 k_i
-rw-r--r-- 1 root root 4096 Feb 27 14:21 k_po
-rw-r--r-- 1 root root 4096 Feb 27 14:21 k_pu
-rw-r--r-- 1 root root 4096 Feb 27 14:21 mode
-rw-r--r-- 1 root root 4096 Feb 27 14:21 offset
-rw-r--r-- 1 root root 4096 Feb 27 14:21 policy
drwxr-xr-x 2 root root    0 Feb 27 14:21 power
-rw-r--r-- 1 root root 4096 Feb 27 14:21 slope
lrwxrwxrwx 1 root root    0 Feb 27 11:09 subsystem -> 
../../../../class/thermal
-rw-r--r-- 1 root root 4096 Feb 27 14:21 sustainable_power
-r--r--r-- 1 root root 4096 Feb 27 14:21 temp
-rw-r--r-- 1 root root 4096 Feb 27 14:21 trip_point_0_temp
-r--r--r-- 1 root root 4096 Feb 27 14:21 trip_point_0_type
-rw-r--r-- 1 root root 4096 Feb 27 14:21 trip_point_1_temp
-r--r--r-- 1 root root 4096 Feb 27 14:21 trip_point_1_type
-rw-r--r-- 1 root root 4096 Feb 27 14:21 trip_point_2_temp
-r--r--r-- 1 root root 4096 Feb 27 14:21 trip_point_2_type
-rw-r--r-- 1 root root 4096 Feb 27 14:21 trip_point_3_temp
-r--r--r-- 1 root root 4096 Feb 27 14:21 trip_point_3_type
-rw-r--r-- 1 root root 4096 Feb 27 14:21 trip_point_4_temp
-r--r--r-- 1 root root 4096 Feb 27 14:21 trip_point_4_type
-rw-r--r-- 1 root root 4096 Feb 27 14:21 trip_point_5_temp
-r--r--r-- 1 root root 4096 Feb 27 14:21 trip_point_5_type
-rw-r--r-- 1 root root 4096 Feb 27 14:21 trip_point_6_temp
-r--r--r-- 1 root root 4096 Feb 27 14:21 trip_point_6_type
-rw-r--r-- 1 root root 4096 Feb 27 14:21 trip_point_7_temp
-r--r--r-- 1 root root 4096 Feb 27 14:21 trip_point_7_type
-r--r--r-- 1 root root 4096 Feb 27 14:21 type
-rw-r--r-- 1 root root 4096 Feb 27 11:09 uevent
```
