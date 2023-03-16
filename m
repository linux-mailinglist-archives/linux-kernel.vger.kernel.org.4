Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8D6BD63E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCPQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjCPQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:47:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27F182B9ED
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:47:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81542F4;
        Thu, 16 Mar 2023 09:48:06 -0700 (PDT)
Received: from [10.57.54.186] (unknown [10.57.54.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF213F885;
        Thu, 16 Mar 2023 09:47:21 -0700 (PDT)
Message-ID: <b16a31ab-907c-1478-3a07-44d588318768@arm.com>
Date:   Thu, 16 Mar 2023 16:47:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/9] coresight: Use enum type for cs_mode wherever
 possible
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230310160610.742382-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 16:06, James Clark wrote:
> mode is stored as a local_t, but it is also passed around a lot as a
> plain u32, so use the correct type wherever local_t isn't currently
> used. This helps a little bit with readability.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c       |  7 ++++---
>   drivers/hwtracing/coresight/coresight-etb10.c      |  3 ++-
>   drivers/hwtracing/coresight/coresight-etm3x-core.c |  6 +++---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c |  6 +++---
>   drivers/hwtracing/coresight/coresight-priv.h       |  9 ++-------
>   drivers/hwtracing/coresight/coresight-stm.c        |  6 +++---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c    |  2 +-
>   drivers/hwtracing/coresight/coresight-tmc-etr.c    |  7 +++----
>   drivers/hwtracing/coresight/coresight-tpdm.c       |  4 ++--
>   drivers/hwtracing/coresight/coresight-tpiu.c       |  3 ++-
>   drivers/hwtracing/coresight/coresight-trbe.c       |  3 ++-
>   drivers/hwtracing/coresight/ultrasoc-smb.c         |  3 ++-
>   drivers/hwtracing/coresight/ultrasoc-smb.h         |  2 +-
>   include/linux/coresight.h                          | 13 ++++++++++---
>   14 files changed, 40 insertions(+), 34 deletions(-)
> 

Looks good to me.

Suzuki


