Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916AA723E03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbjFFJmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbjFFJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:42:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E41B126
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:41:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D3992F4;
        Tue,  6 Jun 2023 02:42:13 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3E843F587;
        Tue,  6 Jun 2023 02:41:26 -0700 (PDT)
Message-ID: <150e5765-1f7d-eca2-05de-2049df733113@arm.com>
Date:   Tue, 6 Jun 2023 10:41:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] coresight: etm4x: Fix missing trctraceidr file in sysfs
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     leo.yan@linaro.org, hejunhao3@huawei.com
References: <20230512133054.235073-1-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230512133054.235073-1-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:30, Mike Leach wrote:
> The trace ID patchset adjusted the handling of the TRCTRACEIDR register
> sysfs to allocate on read.
> 
> Although this was initally correct, the final version of the patch series
> introduced an error which resulted in the mgmt/trctraceidr file in sysfs
> not being visible.
> 
> This patch fixes that issue.
> 
> Fixes: df4871204e5d ("coresight: etm4x: Update ETM4 driver to use Trace ID API")
> 
> Reported-by: Junhao He <hejunhao3@huawei.com>
> Link: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/KK3CVVMRHJWVUORKMFJRSXYCEDFKENQJ/
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>

Queued to coresight/next

[1] https://git.kernel.org/coresight/c/9f37d3798026

Suzuki
