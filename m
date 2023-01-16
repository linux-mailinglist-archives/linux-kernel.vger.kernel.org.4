Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB71066C282
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjAPOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjAPOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:44:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9BE5241C1;
        Mon, 16 Jan 2023 06:22:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90DFBC14;
        Mon, 16 Jan 2023 06:23:39 -0800 (PST)
Received: from [10.57.89.182] (unknown [10.57.89.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C89393F67D;
        Mon, 16 Jan 2023 06:22:55 -0800 (PST)
Message-ID: <da1415e3-3a7f-2c04-e0b5-fb7d49e14855@arm.com>
Date:   Mon, 16 Jan 2023 14:22:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 15/15] coresight: etm3x: docs: Alter sysfs
 documentation for trace id updates
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20230116124928.5440-1-mike.leach@linaro.org>
 <20230116124928.5440-16-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230116124928.5440-16-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 12:49, Mike Leach wrote:
> Sysfs access to etm3x trace ID value is now read-only due to recent
> trace updates and for consistency with etm4x.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> index 651602a61eac..234c33fbdb55 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> @@ -236,7 +236,7 @@ What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/traceid
>   Date:		November 2014
>   KernelVersion:	3.19
>   Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
> -Description: 	(RW) Holds the trace ID that will appear in the trace stream
> +Description: 	(RO) Holds the trace ID that will appear in the trace stream
>   		coming from this trace entity.
>   
>   What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/trigger_event


I have squashed this to PATCH 6, where the above sysfs file permission
is actually changed.

Thanks
Suzuki
