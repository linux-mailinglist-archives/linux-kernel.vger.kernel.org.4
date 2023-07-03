Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99562746044
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGCQAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjGCQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:00:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 274D9E44;
        Mon,  3 Jul 2023 09:00:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2E42F4;
        Mon,  3 Jul 2023 09:01:16 -0700 (PDT)
Received: from [10.57.27.93] (unknown [10.57.27.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5071E3F663;
        Mon,  3 Jul 2023 09:00:31 -0700 (PDT)
Message-ID: <07e778b5-07bd-94e1-1fc0-876fa21ac7ac@arm.com>
Date:   Mon, 3 Jul 2023 17:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 13/17] PM: EM: Refactor struct em_perf_domain and add
 default_table
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
 <20230512095743.3393563-14-lukasz.luba@arm.com>
 <6fc603da-b874-0e38-2402-a112e5c3914d@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <6fc603da-b874-0e38-2402-a112e5c3914d@arm.com>
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



On 5/30/23 11:23, Dietmar Eggemann wrote:
> On 12/05/2023 11:57, Lukasz Luba wrote:
>> The Energy Model support runtime modifications. Refactor old
>> implementation which accessed struct em_perf_state and introduce
>> em_perf_domain::default_table to clean up the design. This new field
>> is better aligned with em_perf_domain::runtime_table and helps to
>> distinguish them better.
>>
>> Update all drivers or frameworks which used the old field:
>> em_perf_domain::table and now should use em_perf_domain::default_table.
> 
> I still believe that doing this refactoring before the introducation o
> the new feature `runtime modifiable EM` would do wonders on the
> tangibility of the other patches in this set.
> 
> [...]
> 

Let me move that refactor patch a bit earlier in the series...
