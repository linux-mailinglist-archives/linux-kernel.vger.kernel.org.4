Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D129E60489C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiJSOBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiJSOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:00:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79F57252BA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:42:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 417BB1424;
        Wed, 19 Oct 2022 06:40:56 -0700 (PDT)
Received: from [10.57.68.61] (unknown [10.57.68.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178853F7D8;
        Wed, 19 Oct 2022 06:40:48 -0700 (PDT)
Message-ID: <e75db140-af0d-d7b3-ce61-665d044bee73@arm.com>
Date:   Wed, 19 Oct 2022 14:40:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH] coresight: etm4x: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221019124953.45885-1-yuanjilin@cdjrlc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221019124953.45885-1-yuanjilin@cdjrlc.com>
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

On 19/10/2022 13:49, Jilin Yuan wrote:
> Delete the redundant word 'the'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Thanks, Queued.

> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 80fefaba58ee..849c563cfc65 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1478,7 +1478,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   			/*
>   			 * If filters::ssstatus == 1, trace acquisition was
>   			 * started but the process was yanked away before the
> -			 * the stop address was hit.  As such the start/stop
> +			 * stop address was hit.  As such the start/stop
>   			 * logic needs to be re-started so that tracing can
>   			 * resume where it left.
>   			 *

