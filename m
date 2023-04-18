Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E36E6F88
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjDRWlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjDRWlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:41:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 834F28A6C;
        Tue, 18 Apr 2023 15:41:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063A6143D;
        Tue, 18 Apr 2023 15:41:56 -0700 (PDT)
Received: from [10.57.21.176] (unknown [10.57.21.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB6643F587;
        Tue, 18 Apr 2023 15:41:08 -0700 (PDT)
Message-ID: <36f9b5b8-2e80-9706-689c-0b55a81f0d12@arm.com>
Date:   Tue, 18 Apr 2023 23:41:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/17] PM: EM: Refactor em_cpufreq_update_efficiencies()
 arguments
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <20230314103357.26010-1-lukasz.luba@arm.com>
 <20230314103357.26010-2-lukasz.luba@arm.com>
 <CAJZ5v0jK-5o=YWVz+v52Puu_QgFt5EE=iQVaPhNL9i+zhxgtRQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jK-5o=YWVz+v52Puu_QgFt5EE=iQVaPhNL9i+zhxgtRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 3/27/23 18:16, Rafael J. Wysocki wrote:
> On Tue, Mar 14, 2023 at 11:34 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> In order to prepare the code for the modifiable EM perf_state table,
>> refactor existing function em_cpufreq_update_efficiencies().
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Quite obviously, this series needs ACKs from the Energy Model people.
> 

My apologies, I have missed your email. Sure thing, we are going to
discuss this patch set on OSPM23. So hopefully that would help bring
some attention here and people would look at it or give it a try.

Regards,
Lukasz
