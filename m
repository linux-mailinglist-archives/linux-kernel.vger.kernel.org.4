Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744EC60BB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiJXU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbiJXU7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB74416D563
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:05:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 109D6150C;
        Mon, 24 Oct 2022 08:24:02 -0700 (PDT)
Received: from [10.57.68.77] (unknown [10.57.68.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DCFA3F792;
        Mon, 24 Oct 2022 08:23:54 -0700 (PDT)
Message-ID: <ad13afb6-a7d9-849b-b517-ab17d190b858@arm.com>
Date:   Mon, 24 Oct 2022 16:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] coresight: cti: Remove unused variables in
 cti_{dis,en}able_hw()
To:     Nathan Chancellor <nathan@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221024151201.2215380-1-nathan@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221024151201.2215380-1-nathan@kernel.org>
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

Hi Nathan

On 24/10/2022 16:12, Nathan Chancellor wrote:
> Clean up the following warnings, as the variables are no longer used.
> 
>    drivers/hwtracing/coresight/coresight-cti-core.c:93:17: warning: unused variable 'dev' [-Wunused-variable]
>            struct device *dev = &drvdata->csdev->dev;
>                          ^
>    drivers/hwtracing/coresight/coresight-cti-core.c:154:17: warning: unused variable 'dev' [-Wunused-variable]
>            struct device *dev = &drvdata->csdev->dev;
>                          ^
>    2 warnings generated.
> 
> Fixes: 665c157e0204 ("coresight: cti: Fix hang in cti_disable_hw()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for your patch, this is now reverted upstream. I have
queued a patch locally to sqaush the changes and plan to push
it once the revert lands upstream.

Thanks
Suzuki

