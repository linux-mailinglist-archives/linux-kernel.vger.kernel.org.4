Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E3745F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGCPJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGCPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:09:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D811FE7B;
        Mon,  3 Jul 2023 08:09:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ADD12F4;
        Mon,  3 Jul 2023 08:09:55 -0700 (PDT)
Received: from [10.57.27.93] (unknown [10.57.27.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F36E3F663;
        Mon,  3 Jul 2023 08:09:09 -0700 (PDT)
Message-ID: <3140f1a0-59e7-7269-1678-fb0ee904e727@arm.com>
Date:   Mon, 3 Jul 2023 16:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/17] PM: EM: Create a new function em_compute_costs()
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
 <20230512095743.3393563-5-lukasz.luba@arm.com>
 <46beae55-6a87-6365-d8c5-b707f87b181e@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <46beae55-6a87-6365-d8c5-b707f87b181e@arm.com>
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



On 5/30/23 10:51, Dietmar Eggemann wrote:
> On 12/05/2023 11:57, Lukasz Luba wrote:
>> Create a dedicated function which will be easier to maintain and re-use
> 
> I guess `refactor` would be more suitable than `create` here?

Good point, I'll rephrase that.

> 
> AFAICS, you factor out em_compute_costs() from em_create_perf_table() so
> you can use it later for the updater of the runtime modifiable EM
> em_dev_update_perf_domain() (in 10/17) as well.
> 
> [...]

yes
