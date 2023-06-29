Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7874206B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF2Gff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF2Gfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:35:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA501727;
        Wed, 28 Jun 2023 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688020530; x=1719556530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AFzg3FqF7514HUhQf1w+sr/2SUF9as8V/MqUkh+gBzY=;
  b=boxZYx59pMdMQudXTrFgF90Z3kZ14Vs+wXuTqFVf8aJMFFZPy4LtDiNa
   lWTo1qkjwLVB3feeJy9zJop4RFdKCuG8jJ3tcwnPlBN+Sh9c0kDXsRhmf
   o1pEgwy7ZSvUFd8nzNdK+Jt2kfFS4D5qgSzQSHZ+cvzXXb2eroeNQO0QA
   4rQFF5JqgELQOdfGC0NdDsqiTFtZoo/B8PUEE5g9zl/6+XWigEeG6MdXi
   hzLk2ac7xPSlrkHsNScIb0KHoC/CJF3KmvaL+s2dGtP9BaKs+5PhnBcwr
   jB8sX1SGirAShPYqI6VnMklXtlzbliXgCJZq2/2LgdYWWbagTXQFnPzdy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="392759195"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="392759195"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 23:35:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="891299887"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="891299887"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.81])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 23:35:26 -0700
Message-ID: <287bf3c8-fa0e-8c36-df14-7d728c63c265@intel.com>
Date:   Thu, 29 Jun 2023 09:35:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
References: <ZG5kjDN63HqqMuJJ@yoga>
 <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
 <ZHENW4HOIo0F6FnN@yoga> <ZHkEWse0NVZhwKR7@yoga> <ZH5YBBWW5ANckoMp@yoga>
 <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
 <ZIHPXV5/ZopqcSSc@yoga> <ZIofrGKElc3nkNk0@yoga>
 <CAP-5=fV9tXNpYHH9DW0cVbRoFLGvG9SNn-MUhuyKuVBRuDqjoA@mail.gmail.com>
 <ZJyT8bt0LFLw6hKV@yoga>
 <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7ch7TdagV+dzj6MCp4fY15Vc4oGJjKAoQDyc=BXqy7qi+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/23 09:26, Namhyung Kim wrote:
> Hi Anup,
> 
> On Wed, Jun 28, 2023 at 1:11 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>>
>> On Wed, Jun 14, 2023 at 01:17:52PM -0700, Ian Rogers wrote:
>>> On Wed, Jun 14, 2023 at 1:14 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>>>>
>>>> On Thu, Jun 08, 2023 at 06:23:49PM +0530, Anup Sharma wrote:
>>>> I wanted to take a moment to provide you with an update on the progress
>>>> of our Firefox Gecko converter work. While I must emphasize that the code
>>>> I'm sharing is not the final version, I wanted to share the advancements
>>>> I have made thus far.
>>>>
>>>> This script can generate a JSON format from the output of the "perf script" command.
>>>> I attempted to load this JSON file into profile.firefox.com, and although it
>>>> successfully loaded, the call tree are not visible. I'm certain this issue
>>>> is related to the format of the JSON file or if there is another underlying
>>>> cause. I will continue investigating to determine the cause of this problem.
>>>
>>> Great Anup, progress can be frustrating slow at first but it is a good
>>> milestone to be generating output and having firefox profiler consume
>>> it. You can open up the JavaScript console for the firefox profiler
>>> and it will give some debug output. This should hopefully help you
>>> make progress.
>>
>> This week I tried playing with perf-script-python, the first challenge was
>> figuring out how to parse the data coming from the process_events.
>> Understanding the structure and extracting the necessary information
>> proved to be more complex than anticipated. This required me to spend
>> a significant amount of time researching and experimenting with different
>> parsing techniques.
> 
> I'm not sure what kind of parsing you meant.  IIRC the sample data is
> in a dict and all the information should be available there.  Maybe we
> missed some new sample data types though.

Most data is there.  There are existing scripts in
tools/perf/scripts/python/ for reference.

There is also the dlfilter API:

https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-dlfilter.1

> 
>>
>> The second challenge revolved around the usage of event hooks provided with the perf script
>> python event handlers. I found myself deliberating between two approaches. The first
>> approach involved creating custom functions that would be called using the event
>> handlers. These functions would then save the data in an organized format within
>> globally created data structures. The alternative approach was to write the entire
>> logic inside the event handlers themselves.
>>
>> Additionally, I contemplated whether it would be more suitable to handle the creation of
>> a Gecko format for JSON and the profile format within the same script or to separate
>> them into different scripts.
>>
>> I will discuss this points during tomorrow's office hour.
>>
>> However, I have gained a deeper understanding of the problem at hand and will use this
>> knowledge to make more informed decisions and progress more effectively in the coming weeks.
> 
> Sounds like you did a good amount of research on how perf script
> works.  We can talk about the details in the meeting.
> 
> Thanks,
> Namhyung

