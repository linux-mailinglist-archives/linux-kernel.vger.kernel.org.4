Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F20737981
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjFUDP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUDP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:15:27 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4E31717;
        Tue, 20 Jun 2023 20:15:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VleADK4_1687317318;
Received: from 30.221.149.25(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VleADK4_1687317318)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 11:15:19 +0800
Message-ID: <738dda90-6235-07dd-145a-d1dd3b1f5b5c@linux.alibaba.com>
Date:   Wed, 21 Jun 2023 11:15:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     John Garry <john.g.garry@oracle.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
 <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
 <079d7920-2030-2e00-a833-5ec6d450f7dc@oracle.com>
 <552eebae-76bb-a2fe-ccdc-11e8a01717da@linux.alibaba.com>
 <045a49c9-b9ae-bf0e-c4be-858d905bcc55@oracle.com>
 <7c765e0f-ca76-d212-0496-f9c56369e389@linux.alibaba.com>
 <d1ab4947-6bdf-2b9c-5b26-52c572611ca6@oracle.com>
 <a6e1114c-b37c-6999-0668-039aa495db84@linux.alibaba.com>
 <71c4ef1e-0982-1ef4-5135-001303b43cd3@oracle.com>
 <777e06ae-fd9c-8fd3-6976-7b80594e1942@linux.alibaba.com>
 <ae596b0c-e0bc-2b08-c348-0927acc0c8ef@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <ae596b0c-e0bc-2b08-c348-0927acc0c8ef@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/20 下午3:01, John Garry 写道:
> On 20/06/2023 03:12, Jing Zhang wrote:
>>> But that JSON is not in this series. Why is it not included?
>>>
>> Because the RFC version of the cmn.json file does not define the EventCode for each event, this will not take effect, so I temporarily removed it.
>> The EventID of CMN events is different from other events. For example, hnf_slc_sf_cache_access corresponds to arm_cmn_0/type=0x5,eventid=0x2/.
>> The current JSON format parsing does not support this EventID, and jevent.py needs to be extended.
> 
> So please do that then. I would suggest just to first support event aliasing, and then support metrics. JFYI, I am still reworking current perf tool metric code for sys events, which should take a few more days.
> 

Ok, thank you.

>>
>>> The cmn kernel driver exposes event hnf_slc_sf_cache_access, but I did not think that perf tool metric code matches those events described in/bus/event_sourcs/devices/<PMU>/events
>>>
>> If there is no alias defined, other events with the same name may be matched, it is indeed necessary to define an alias for each event first,
>> and I will add it in the next version. But first I need to extend jevent.py to support cmn EventID.
> 
> ok, please do this. I assume that you are talking about wildcard matching for cmn HW identifier. We would also need perf tool self-test expanded to cover this wildcard matching - see tests/pmu-events.c
> 

Ok, let me try.

Thanks,
Jing
