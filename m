Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05314631EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKUKsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiKUKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:48:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 645FEDD8;
        Mon, 21 Nov 2022 02:47:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CB671FB;
        Mon, 21 Nov 2022 02:47:34 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29C4D3F73B;
        Mon, 21 Nov 2022 02:47:26 -0800 (PST)
Message-ID: <1c8da30c-d798-729d-c8e5-73a07f8b9f18@arm.com>
Date:   Mon, 21 Nov 2022 10:47:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v13 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
Content-Language: en-US
To:     hejunhao <hejunhao3@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, john.garry@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        lpieralisi@kernel.org, linuxarm@huawei.com, yangyicong@huawei.com,
        liuqi115@huawei.com, f.fangjian@huawei.com,
        prime.zeng@hisilicon.com
References: <20221114090316.63157-1-hejunhao3@huawei.com>
 <20221114090316.63157-2-hejunhao3@huawei.com>
 <92291cb2-859c-a994-b05d-806def431376@arm.com>
 <c07e6417-7a37-3cf5-d3dd-b3ce7b3c20b1@huawei.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <c07e6417-7a37-3cf5-d3dd-b3ce7b3c20b1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 12:45, hejunhao wrote:
> Hi Suzuki ,
> 
> 
> On 2022/11/15 19:06, Suzuki K Poulose wrote:
>> On 14/11/2022 09:03, Junhao He wrote:
>>> From: Qi Liu <liuqi115@huawei.com>
>>>

>>> +static void smb_init_hw(struct smb_drv_data *drvdata)
>>> +{
>>> +    /* First disable SMB and clear the status of SMB buffer */
>>> +    smb_reset_buffer_status(drvdata);
>>> +    smb_disable_hw(drvdata);
>>> +    smb_purge_data(drvdata);
>>> +
>>> +    writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + SMB_LB_CFG_LO_REG);
>>> +    writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + SMB_LB_CFG_HI_REG);
>>> +    writel(SMB_GLB_CFG_DEFAULT, drvdata->base + SMB_GLB_CFG_REG);
>>> +    writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLB_INT_REG);
>>> +    writel(SMB_LB_INT_CTRL_CFG, drvdata->base + SMB_LB_INT_CTRL_REG);
>>
>> Does this come with interrupt on overflow ? Do we not use this ?
>>
> When the buffer overflow, no interrupt will come.
> Interrupt will upgrade SMB_LB_INT_STS_REG register status if start trace.
> Thanks.
>> Rest looks fine to me.

What is the purpose of the "Interrupt" on the SMB ? It is not clear to
me.

Suzuki

