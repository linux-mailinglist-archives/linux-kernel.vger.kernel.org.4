Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545CE603B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJSIQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJSIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:16:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C3496110E;
        Wed, 19 Oct 2022 01:16:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DFDB20E3;
        Wed, 19 Oct 2022 01:16:20 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0DBA3F7D8;
        Wed, 19 Oct 2022 01:16:12 -0700 (PDT)
Message-ID: <46328b62-d948-a5c2-25c6-f5caec123412@foss.arm.com>
Date:   Wed, 19 Oct 2022 09:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v9 13/13] perf test: Add relevant documentation about
 CoreSight testing
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-14-carsten.haitzler@foss.arm.com>
 <yt9dr0zex1j4.fsf@linux.ibm.com>
Content-Language: en-US
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <yt9dr0zex1j4.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is weird. This shouldn't be making its way into any man page at 
all. It's just a file pointing people at other parts of the kernel tree 
for docs (because when I looked for docs - i found nothing for any kind 
of getting started guide - I put something here as this was the obvious 
place for perf related docs for testing - but was told to put the docs 
elsewhere in core kernel documentation, but I put a reference here for 
those who follow after to be able to more easily find it).

There is some rule somewhere it seems that makes anything perf-*.txt 
into a man page. I need to rename this file it seems.

On 10/11/22 08:27, Sven Schnelle wrote:
> Hi Carsten,
> 
> carsten.haitzler@foss.arm.com writes:
> 
>> From: Carsten Haitzler <carsten.haitzler@arm.com>
>>
>> Add/improve documentation helping people get started with CoreSight and
>> perf as well as describe the testing and how it works.
>>
>> Cc: linux-doc@vger.kernel.org
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   .../trace/coresight/coresight-perf.rst        | 158 ++++++++++++++++++
>>   .../perf/Documentation/perf-arm-coresight.txt |   5 +
>>   2 files changed, 163 insertions(+)
>>   create mode 100644 Documentation/trace/coresight/coresight-perf.rst
>>   create mode 100644 tools/perf/Documentation/perf-arm-coresight.txt
>>
> 
> Investigating a rpm build failure i see the following error with next-20221011:
> 
> % cd tools/perf/Documentation
> % make O=/home/svens/linux-build/ man V=1
> rm -f /home/svens/linux-build/perf-arm-coresight.xml+ /home/svens/linux-build/perf-arm-coresight.xml && \
> asciidoc -b docbook -d manpage \
>          --unsafe -f asciidoc.conf -aperf_version= \
>          -aperf_date=2022-10-06 \
>          -o /home/svens/linux-build/perf-arm-coresight.xml+ perf-arm-coresight.txt && \
> mv /home/svens/linux-build/perf-arm-coresight.xml+ /home/svens/linux-build/perf-arm-coresight.xml
> asciidoc: FAILED: manpage document title is mandatory
> make: *** [Makefile:266: /home/svens/linux-build/perf-arm-coresight.xml] Error 1
> 
> Can you please fix this?
> 
> Thanks!
