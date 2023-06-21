Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2A73797F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjFUDIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjFUDIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:08:43 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B511703;
        Tue, 20 Jun 2023 20:08:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vle8pmP_1687316914;
Received: from 30.221.149.25(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vle8pmP_1687316914)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 11:08:35 +0800
Message-ID: <a5486c58-32b6-2d5e-e623-d7844c51474c@linux.alibaba.com>
Date:   Wed, 21 Jun 2023 11:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v4 0/4] Add JSON metrics for Yitian710 DDR
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.g.garry@oracle.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAM9d7cj3v58m8NcsEK4sYsk_dbQDAq71hYo7DV=xaQa_rZyPYg@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAM9d7cj3v58m8NcsEK4sYsk_dbQDAq71hYo7DV=xaQa_rZyPYg@mail.gmail.com>
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



在 2023/6/21 上午3:04, Namhyung Kim 写道:
> Hello,
> 
> On Tue, Jun 20, 2023 at 12:17 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Hi all,
>>
>> I add an identifier sysfs file for the yitian710 SoC DDR to allow
>> userspace to identify the specific implementation of the device,
>> so that the perf tool can match the corresponding uncore events and
>> metrics through the identifier. Then added yitian710 SoC DDR
>> metrics and events alias.
>>
>> Change since v3:
>> - Split the CMN and ali_drw patches. This patchset only contains
>>   ali_drw PMU related patches. The CMN metric related patches will
>>   be in another patchset.
>> - Link: https://lore.kernel.org/all/1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com/
>>
>> $perf list:
>> ...
>> ali_drw:
>>   chi_rxdat
>>        [A packet at CHI RXDAT interface (write data). Unit: ali_drw]
>>   chi_rxrsp
>>        [A packet at CHI RXRSP interface. Unit: ali_drw]
>>   chi_txdat
>>        [A packet at CHI TXDAT interface (read data). Unit: ali_drw]
>>   chi_txreq
>>        [A packet at CHI TXREQ interface (request). Unit: ali_drw]
>>   cycle
>>        [The ddr cycle. Unit: ali_drw]
>> ...
>> ali_drw:
>>   ddr_read_bandwidth.all
>>        [The ddr read bandwidth(MB/s). Unit: ali_drw ]
>>   ddr_write_bandwidth.all
>>        [The ddr write bandwidth(MB/s). Unit: ali_drw ]
>> ...
>>
>> $perf stat -M ddr_read_bandwidth.all ./test
>>
>> Performance counter stats for 'system wide':
>>
>>             38,150      hif_rd        #  2.4 MB/s  ddr_read_bandwidth.all
>>      1,000,957,941 ns   duration_time
>>
>>        1.000957941 seconds time elapsed
>>
>> Jing Zhang (4):
>>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
>>   perf jevents: Add support for Yitian 710 DDR PMU aliasing
>>   perf vendor events: Add JSON metrics for Yitian 710 DDR
>>   docs: perf: Update metric usage for Alibaba's T-Head PMU driver
> 
> So patch 1 is for the kernel, and patch 2-4 depend on it, right?
> 

Hi Namhyung,

Yes, patch 2-4 depend on patch 1.

> I'm curious why the first patch is needed, presumably the PMU
> should have 'ali_drw' in the name already.  Do we use substring
> match for the compat name in the JSON metric?
> 

The main purpose of patch 1 is to add an identifier so that the Compat
field can match the corresponding event when defining aliases or metrics
for events.

For example, "Unit" can match "ali_drw" in the name and different SoCs may
be able to match ali_drw, but they may have different events, and even if
the events are the same, the meanings may be different. Therefore, the
Compat field is needed to match the Identifier to confirm which type and
revision of PMU the current SoC has. Therefore, both "Unit" and "Compat"
need to be matched at the same time. Although it seems that ali_drw is
redundantly matched currently, it is meaningful for future expansion.

Thanks,
Jing

> Thanks,
> Namhyung
> 
>>
>>  Documentation/admin-guide/perf/alibaba_pmu.rst     |   5 +
>>  drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
>>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
>>  .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
>>  tools/perf/pmu-events/jevents.py                   |   1 +
>>  5 files changed, 426 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
>>
>> --
>> 1.8.3.1
>>
