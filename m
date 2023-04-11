Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30F6DDFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDKPoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDKPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:44:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7C931FD5;
        Tue, 11 Apr 2023 08:44:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16DDFD75;
        Tue, 11 Apr 2023 08:44:50 -0700 (PDT)
Received: from [10.57.20.231] (unknown [10.57.20.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DD273F73F;
        Tue, 11 Apr 2023 08:44:01 -0700 (PDT)
Message-ID: <5d200bb9-a41c-9075-ee43-3aad49eb7028@arm.com>
Date:   Tue, 11 Apr 2023 17:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/17] PM: EM: Refactor em_cpufreq_update_efficiencies()
 arguments
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <20230314103357.26010-1-lukasz.luba@arm.com>
 <20230314103357.26010-2-lukasz.luba@arm.com>
 <CAJZ5v0jK-5o=YWVz+v52Puu_QgFt5EE=iQVaPhNL9i+zhxgtRQ@mail.gmail.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0jK-5o=YWVz+v52Puu_QgFt5EE=iQVaPhNL9i+zhxgtRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/23 19:16, Rafael J. Wysocki wrote:
> On Tue, Mar 14, 2023 at 11:34 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> In order to prepare the code for the modifiable EM perf_state table,
>> refactor existing function em_cpufreq_update_efficiencies().
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Quite obviously, this series needs ACKs from the Energy Model people.

FWIW, I tried the patch-set and everything was working well. I had
some small comments for some patches,

Regards,
Pierre
