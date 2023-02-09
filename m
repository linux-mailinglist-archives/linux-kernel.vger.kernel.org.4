Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF36904FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBIKeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:34:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C765C6A311
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:31:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DEA1515;
        Thu,  9 Feb 2023 02:32:14 -0800 (PST)
Received: from [10.57.75.176] (unknown [10.57.75.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583983F71E;
        Thu,  9 Feb 2023 02:31:30 -0800 (PST)
Message-ID: <77bd4509-bd8b-3bcc-e94a-7593505e27c0@arm.com>
Date:   Thu, 9 Feb 2023 10:31:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3] coresight: tmc: Don't enable TMC when it's not ready.
To:     Yabin Cui <yabinc@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <CALJ9ZPNrF-HhUNskr=_MJ1CrnO+0xzSN8pMpER3FMqf5Pd0idg@mail.gmail.com>
 <20230202214633.12584-1-yabinc@google.com>
 <CALJ9ZPPte1Gso7LYA6eAVifZJDgdZP+QPdSKUJEpz=+v2S0cag@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CALJ9ZPPte1Gso7LYA6eAVifZJDgdZP+QPdSKUJEpz=+v2S0cag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 01:08, Yabin Cui wrote:
> Friendly ping?
> 
> On Thu, Feb 2, 2023 at 1:46 PM Yabin Cui <yabinc@google.com> wrote:
>>
>> If TMC ETR is enabled without being ready, in later use we may
>> see AXI bus errors caused by accessing invalid addresses.
>>
>> Signed-off-by: Yabin Cui <yabinc@google.com>
>> ---
>> V1 -> V2: Make change to all TMCs instead of just ETR
>> V2 -> V3: Handle etr enable failure in tmc_read_unprepare_etr

As I mentioned, v2 was queued. Please could you update your changes on 
top of the coresight next branch and resend the patch ?

Suzuki


