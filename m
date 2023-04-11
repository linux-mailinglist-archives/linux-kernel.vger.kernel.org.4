Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02486DD3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDKHSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDKHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:18:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4819F2721;
        Tue, 11 Apr 2023 00:17:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41ABDC14;
        Tue, 11 Apr 2023 00:18:43 -0700 (PDT)
Received: from [10.57.20.32] (unknown [10.57.20.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF05A3F73F;
        Tue, 11 Apr 2023 00:17:56 -0700 (PDT)
Message-ID: <da6af760-71b8-83e4-ad4e-8d5f3f62fcd9@arm.com>
Date:   Tue, 11 Apr 2023 08:17:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Di Shen <di.shen@unisoc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org,
        Di Shen <cindygm567@gmail.com>
References: <20230320095620.7480-1-di.shen@unisoc.com>
 <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
 <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/23 20:51, Daniel Lezcano wrote:
> On 10/04/2023 04:09, Di Shen wrote:
>> Hi Lukasz,
>> Could you please apply this patch if there's no more comment? Thank you.
> 
> Hi,
> 
> I take care of applying the patches. Give me some time to read the changes.
> 
> Thanks
>    -- Daniel
> 

Thank you Daniel!

Regards,
Lukasz
