Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2866BB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjAPKQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjAPKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:16:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 866B31A941
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:15:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D7BFAD7;
        Mon, 16 Jan 2023 02:16:13 -0800 (PST)
Received: from [10.57.89.182] (unknown [10.57.89.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D2B23F67D;
        Mon, 16 Jan 2023 02:15:29 -0800 (PST)
Message-ID: <109531b9-a844-d1e3-a0cc-a64fb5d35a09@arm.com>
Date:   Mon, 16 Jan 2023 10:15:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] coresight: etm4x: Fix accesses to TRCSEQRSTEVR and
 TRCSEQSTR
To:     Junhao He <hejunhao3@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com,
        linuxarm@huawei.com, shenyang39@huawei.com,
        prime.zeng@hisilicon.com
References: <20230114091632.60095-1-hejunhao3@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230114091632.60095-1-hejunhao3@huawei.com>
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

On 14/01/2023 09:16, Junhao He wrote:
> The TRCSEQRSTEVR and TRCSEQSTR registers are not implemented if the
> TRCIDR5.NUMSEQSTATE == 0. Skip accessing the registers in such cases.
> 
> Fixes: 2e1cdfe184b5 ("coresight-etm4x: Adding CoreSight ETM4x driver")
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Queued to coresight next:

https://git.kernel.org/coresight/c/589d928248b72f8

Thanks
Suzuki

