Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B291D6B83E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCMVUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCMVT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:19:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB288DA4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678742360; x=1710278360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=y+z1odmgY0Ze6Ju5KbeVq9eHiK/46JcyWTy4BRUevMc=;
  b=h6onNqj4iv387cWdTDGpRcQ79UIVN1XoPe48f+AGhILWYpI2/RkleFKC
   LOtd3RP1ZNQXduhhlzLf9mqWmtktd/P1T61fO4BIw1OXNJnDGAjx4p1k9
   7RYSc224UKEN11Wk8mu6dsjPybAQwEbQHjIAa5uZcd2iBsmxwjFVi4lDT
   fODEEgH5RspLEnrMWX++hAwGJpwlYoXYWPnlZqIIRhQYkeyF7r0c3PQy1
   XjxX7zyoAcJTSGYAPAvdk6A9PYEtUK5ZIwgadkynx3oPY3gcn6oJ3p4fc
   RbMbk59oh0NtPsm6uaEl91Fmn/3n8sZG/uq/U7skyXs2270HEpH8gtn4a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="338809253"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="c'?scan'208";a="338809253"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 14:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="924657174"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="c'?scan'208";a="924657174"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2023 14:19:18 -0700
Received: from [10.209.60.110] (kliang2-mobl1.ccr.corp.intel.com [10.209.60.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7B6DC580C25;
        Mon, 13 Mar 2023 14:19:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------pHmKNXD2aw4Qd5o1A9ZEmKq8"
Message-ID: <76362685-0250-ef03-e6b9-e905a1bfd942@linux.intel.com>
Date:   Mon, 13 Mar 2023 17:19:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com>
 <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
 <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com>
 <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
 <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com>
 <568b09ce-dc6a-8d2a-13ca-6df045236449@linux.intel.com>
 <CANDhNCrooGXFvW6DDuRJHtM2K8wCbqajSP0KDVn+wkEcTNHJZA@mail.gmail.com>
 <77f1ac9f-0acd-1b70-c19e-3564caa45f41@linux.intel.com>
 <CANDhNCpnoRjrX7k7spDdnUgwzygVUoaF5u7A2-heQfCuokcN6Q@mail.gmail.com>
 <44422a27-081b-0722-58c4-ace1b7e871f8@linux.intel.com>
 <CANDhNCq7a7DBhb83veKtVOOkGpHLssgd4JpQ552B40YK51cLsg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CANDhNCq7a7DBhb83veKtVOOkGpHLssgd4JpQ552B40YK51cLsg@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------pHmKNXD2aw4Qd5o1A9ZEmKq8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023-03-11 12:55 a.m., John Stultz wrote:
> On Thu, Mar 9, 2023 at 8:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 2023-03-08 8:17 p.m., John Stultz wrote:
>>> So I spent a little bit of time today adding some trace_printks to the
>>> timekeeping code so I could record the actual TSC and timestamps being
>>> calculated from CLOCK_MONOTONIC_RAW.
>>>
>>> I did catch one error in the test code, which unfortunately I'm to blame for:
>>>   mid = start + (delta +(delta/2))/2; //round-closest
>>>
>>> That should be
>>>   mid = start + (delta +(2/2))/2  //round-closest
>>> or more simply
>>>   mid = start + (delta +1)/2; //round-closest
>>>
>>> Generalized rounding should be: (value + (DIV/2))/DIV), but I'm
>>> guessing with two as the divisor, my brain mixed it up and typed
>>> "delta". My apologies!
>>>
>>> With that fix, I'm seeing closer to ~500ns of error in the
>>> interpolation, just using the userland sampling.   Now, I've also
>>> disabled vsyscalls for this (otherwise I wouldn't be able to
>>> trace_printk), so the error likely would be higher than with
>>> vsyscalls.
>>>
>>> Now, part of the error is that:
>>>   start= rdtsc();
>>>   clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
>>>   end = rdtsc();
>>>
>>> Ends up looking like
>>>   start= rdtsc();
>>>   clock_gettime() {
>>>      now = rdtsc();
>>>      delta = now - last;
>>>      ns = (delta * mult) >> shift
>>> [~midpoint~]
>>>      ts->nsec = base_ns + ns;
>>>      ts->sec = base_sec;
>>>      normalize_ts(ts)
>>>   }
>>>   end = rdtsc();
>>>
>>> And so by taking the mid-point we're always a little skewed from where
>>> the tsc was actually read.  Looking at the data for my case the tsc
>>> read seems to be ~12% in, so you could instead try:
>>>
>>> delta = end - start;
>>> p12 = start + ((delta * 12) + (100/2))/100;
>>>
>>> With that adjustment, I'm seeing error around ~40ns.
>>>
>>> Mind giving that a try?
>>
>> I tried both the new mid and p12. The error becomes even larger.
>>
>> With new mid (start + (delta +1)/2), the error is now ~3800ns
>> With p12 adjustment, the error is ~6700ns.
>>
>>
>> Here is how I run the test.
>> $./time
>> $perf record -e cycles:upp --clockid monotonic_raw $some_workaround
>> $./time
>>
>> Here are some raw data.
>>
>> For the first ./time,
>> start: 961886196018
>> end: 961886215603
>> MONO_RAW: 341485848531
>>
>> For the second ./time,
>> start: 986870117783
>> end: 986870136152
>> MONO_RAW: 351495432044
>>
>> Here is the time generated from one PEBS record.
>> TSC: 968210217271
>> PEBS_MONO_RAW (calculated via kernel conversion information): 344019503072
>>
>> Using new mid (start + (delta +1)/2), the guessed PEBS_MONO_RAW is
>> 344019506897. The error is 3825ns.
>> Using p12 adjustment, the guessed PEBS_MONO_RAW is 344019509831.
>> The error is 6759ns
> 
> Huh. I dunno. That seems wild that the error increased.
> 
> Just in case something is going astray with the PEBS_MONO_RAW logic,
> can you apply the hack patch I was using to display the MONOTONIC_RAW
> values the kernel calculates?
>   https://github.com/johnstultz-work/linux-dev/commit/8d7896b078965b059ea5e8cc21841580557f6df6
> 
> It uses trace_printk, so you'll have to cat /sys/kernel/tracing/trace
> to get the output.
> 


$ ./time_3
start: 7358368893806 end: 7358368902944 delta: 9138
MONO_RAW: 2899739790738
MID: 7358368898375
P12: 7358368894903
$ sudo cat /sys/kernel/tracing/trace | grep time_3
          time_3-1443    [002] .....  2899.858936: ktime_get_raw_ts64:
JDB: timekeeping_get_delta cycle_now: 7358368897679
          time_3-1443    [002] .....  2899.858937: ktime_get_raw_ts64:
JDB: ktime_get_raw_ts64: 2899739790738

The error between MID and cycle_now is -696ns
The error between P12 and cycle_now is 2776ns

The time_3.c is attached.

Thanks,
Kan
--------------pHmKNXD2aw4Qd5o1A9ZEmKq8
Content-Type: text/plain; charset=UTF-8; name="time_3.c"
Content-Disposition: attachment; filename="time_3.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy90aW1lLmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDxzdGRp
by5oPgojaW5jbHVkZSA8ZXJybm8uaD4KCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBy
ZHRzYyAoKQp7CiAgdW5zaWduZWQgbG9uZyB2YXI7CiAgdW5zaWduZWQgaW50IGhpLCBsbzsK
CiAgYXNtIHZvbGF0aWxlICgicmR0c2MiIDogIj1hIiAobG8pLCAiPWQiIChoaSkpOwogIHZh
ciA9ICgodW5zaWduZWQgbG9uZyBsb25nIGludCkgaGkgPDwgMzIpIHwgbG87CgogIHJldHVy
biB2YXI7Cn0KCnR5cGVkZWYgdW5zaWduZWQgbG9uZyBsb25nIHU2NDsKCmludCBtYWluKCkK
ewoJc3RydWN0IHRpbWVzcGVjIHRzOwoJdTY0IHN0YXJ0LCBlbmQsIGRlbHRhLCBtaWQsIHAx
MjsKCWRvIHsKCQlzdGFydD0gcmR0c2MoKTsKCQljbG9ja19nZXR0aW1lKENMT0NLX01PTk9U
T05JQ19SQVcsICZ0cyk7CgkJZW5kID0gcmR0c2MoKTsKCQlkZWx0YSA9IGVuZC1zdGFydDsK
CX0gd2hpbGUgKGRlbHRhICA+IDIwMDAwKTsgICAvLyBtYWtlIHN1cmUgdGhlIHJlYWRzIHdl
cmUgbm90IHByZWVtcHRlZAoKCXByaW50Zigic3RhcnQ6ICVsbHUgZW5kOiAlbGx1IGRlbHRh
OiAlbGx1XG4iLCBzdGFydCwgZW5kLCBkZWx0YSk7CglwcmludGYoIk1PTk9fUkFXOiAlbGx1
XG4iLCAodTY0KXRzLnR2X3NlYyAqIDEwMDAwMDAwMDAgKyB0cy50dl9uc2VjKTsKCW1pZCA9
IHN0YXJ0ICsgKGRlbHRhICsgMSkvMjsgLy9yb3VuZC1jbG9zZXN0CglwcmludGYoIk1JRDog
JWxsdVxuIiwgbWlkKTsKCXAxMiA9IHN0YXJ0ICsgKChkZWx0YSAqIDEyKSArICgxMDAvMikp
LzEwMDsKCXByaW50ZigiUDEyOiAlbGx1XG4iLCBwMTIpOwp9Cg==

--------------pHmKNXD2aw4Qd5o1A9ZEmKq8--
