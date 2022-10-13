Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2F5FDCB1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJMOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:54:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63AE410537D;
        Thu, 13 Oct 2022 07:54:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4B613D5;
        Thu, 13 Oct 2022 07:54:31 -0700 (PDT)
Received: from [10.57.0.242] (unknown [10.57.0.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A55983F67D;
        Thu, 13 Oct 2022 07:54:22 -0700 (PDT)
Message-ID: <da49035b-bc5c-d40e-a1dd-2f229cffbada@arm.com>
Date:   Thu, 13 Oct 2022 15:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: arm coresight txt triggers build warning: (was [PATCH] perf test:
 Fix test_arm_coresight.sh failures on Juno)
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     suzuki.poulose@arm.com, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        acme@kernel.org
References: <20221005140508.1537277-1-james.clark@arm.com>
 <f1f8c436-68ce-b4cb-1347-62fb0638e35e@linux.ibm.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <f1f8c436-68ce-b4cb-1347-62fb0638e35e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/10/2022 14:45, Christian Borntraeger wrote:
> Probably not related to this patch set, but
> tools/perf/Documentation/perf-arm-coresight.txt
> 
> results in
> cd tools/perf/Documentation/
> make man
>   ASCIIDOC perf-arm-coresight.xml
> asciidoc: ERROR: perf-arm-coresight.txt: line 2: malformed manpage title
> asciidoc: ERROR: perf-arm-coresight.txt: line 3: name section expected
> asciidoc: FAILED: perf-arm-coresight.txt: line 3: section title expected
> 
> in linux-next.
> 

I think this is the same as what has been reported here:
https://lore.kernel.org/linux-perf-users/20220909152803.2317006-1-carsten.haitzler@foss.arm.com/T/#mf1345f086db25c9fb40eb916b0aa42f1960d7eb2

Carsten, are you able to take a look at this?

Thanks
James
