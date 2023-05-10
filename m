Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD146FD7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjEJHBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjEJHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:00:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25D5530F9;
        Wed, 10 May 2023 00:00:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B4615A1;
        Wed, 10 May 2023 00:01:19 -0700 (PDT)
Received: from [10.57.22.157] (unknown [10.57.22.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B60A3F663;
        Wed, 10 May 2023 00:00:32 -0700 (PDT)
Message-ID: <d4faa9a0-72a2-a865-761c-6ddbe677e03c@arm.com>
Date:   Wed, 10 May 2023 08:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/17] PM: EM: Refactor em_cpufreq_update_efficiencies()
 arguments
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230314103357.26010-1-lukasz.luba@arm.com>
 <20230314103357.26010-2-lukasz.luba@arm.com>
 <CAJZ5v0jK-5o=YWVz+v52Puu_QgFt5EE=iQVaPhNL9i+zhxgtRQ@mail.gmail.com>
 <5d200bb9-a41c-9075-ee43-3aad49eb7028@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5d200bb9-a41c-9075-ee43-3aad49eb7028@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/23 16:43, Pierre Gondois wrote:
> 
> 
> On 3/27/23 19:16, Rafael J. Wysocki wrote:
>> On Tue, Mar 14, 2023 at 11:34 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> In order to prepare the code for the modifiable EM perf_state table,
>>> refactor existing function em_cpufreq_update_efficiencies().
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Quite obviously, this series needs ACKs from the Energy Model people.
> 
> FWIW, I tried the patch-set and everything was working well. I had
> some small comments for some patches,

Thanks Pierre!

> 
> Regards,
> Pierre
