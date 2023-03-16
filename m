Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED96BD6DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCPRS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:18:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD8EA52916
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:18:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E43A2F4;
        Thu, 16 Mar 2023 10:19:07 -0700 (PDT)
Received: from [10.57.54.186] (unknown [10.57.54.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7565D3F885;
        Thu, 16 Mar 2023 10:18:22 -0700 (PDT)
Message-ID: <2992c337-e9e6-6023-8882-bbf8d87994a5@arm.com>
Date:   Thu, 16 Mar 2023 17:18:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/9] coresight: Rename nr_outports to nr_outconns
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-4-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230310160610.742382-4-james.clark@arm.com>
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
> Rename to avoid confusion between port number and the index in the
> connection array. The port number is already stored in the connection,
> and in a later commit the connection array will be appended to, so
> the length of it will no longer reflect the number of ports.
> 
> No functional changes.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c  | 32 ++++++++---------
>   .../hwtracing/coresight/coresight-platform.c  | 34 +++++++++----------
>   .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
>   include/linux/coresight.h                     | 10 +++---
>   4 files changed, 39 insertions(+), 39 deletions(-)
> 

...

> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 322d7273e122..cdf0d1def778 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -102,13 +102,13 @@ union coresight_dev_subtype {
>    * struct coresight_platform_data - data harvested from the firmware
>    * specification.
>    *
> - * @nr_inport:	Number of elements for the input connections.
> - * @nr_outport:	Number of elements for the output connections.
> - * @conns:	Sparse array of nr_outport connections from this component.
> + * @nr_inconns: Number of elements for the input connections.
> + * @nr_outconns: Number of elements for the output connections.
> + * @conns:	Sparse array of nr_outconns connections from this component.

s/conns/out_conns/

Otherwise looks good to me.

Suzuki

