Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4244745FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGCPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGCP37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:29:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4022AE49;
        Mon,  3 Jul 2023 08:29:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B76132F4;
        Mon,  3 Jul 2023 08:30:40 -0700 (PDT)
Received: from [10.57.27.93] (unknown [10.57.27.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AEAA3F663;
        Mon,  3 Jul 2023 08:29:55 -0700 (PDT)
Message-ID: <18b1a981-79a0-13d7-bfba-2f1c0e554da9@arm.com>
Date:   Mon, 3 Jul 2023 16:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/17] PM: EM: Add argument to get_cost() for runtime
 modification
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-13-lukasz.luba@arm.com>
 <93afb0fd-6226-4b0d-380a-182ecf028b34@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <93afb0fd-6226-4b0d-380a-182ecf028b34@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/23 10:53, Dietmar Eggemann wrote:
> On 12/05/2023 11:57, Lukasz Luba wrote:
>> The Energy Model (EM) supports runtime modifications. Let also the
>> artificial EM use this new feature and allow to update the 'cost' values
>> at runtime. When the artificial EM is used there is a need to provide
>> two callbacks: get_cost() and update_power(), not only the last one.
>>
>> Update also CPPC driver code, since the new argument is needed there
>> to compile properly and register EM.
> 
> Is there a real use case behind this? It can't be mobile which IMHO
> drivers the rest of the 'Runtime modifiable EM' feature.

Correct, CPPC+EM is not for mobile phones, but notebooks. For now
the notebooks are not tested with that feature and were not in
requirement scope.

> 
> Do we know of any machine using the artificial EM. And do they care
> about EM matching workload or static power?
> 
> [...]

For now we don't know about such notebook which uses CPPC + EM
and if it's a candidate for this feature.

I thought, since it's just one patch w/ small change, it would be
consistent to not 'forget' about that notebooks angle. I know
that there are some folks who 'run'/'are willing to run' Arm laptop with
CPPC w/ artificial EM. They might pick that feature as well.
