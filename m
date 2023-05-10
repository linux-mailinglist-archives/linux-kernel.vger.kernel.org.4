Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5D6FD7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbjEJHHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjEJHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:07:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E75F53C0C;
        Wed, 10 May 2023 00:07:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4AB61063;
        Wed, 10 May 2023 00:00:23 -0700 (PDT)
Received: from [10.57.22.157] (unknown [10.57.22.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA7A73F663;
        Tue,  9 May 2023 23:59:36 -0700 (PDT)
Message-ID: <5572cf25-b89b-1044-f3db-29bb2100be41@arm.com>
Date:   Wed, 10 May 2023 07:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/17] trace: energy_model: Add trace event for EM runtime
 modifications
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        rafael@kernel.org, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
References: <20230314103357.26010-1-lukasz.luba@arm.com>
 <20230314103357.26010-6-lukasz.luba@arm.com>
 <9994acf8-e0bc-55ce-9012-e36ef3b8ddab@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <9994acf8-e0bc-55ce-9012-e36ef3b8ddab@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/23 16:39, Pierre Gondois wrote:
> Hello Lukasz,
> Just a suggestion, maybe it would be good to trace the CPUs affected by

We print the device name in the trace event, which would be the first
CPU in the frequency domain.

> the modification. It is possible to retrieve this information by going
> to /sys/kernel/debug/energy_model/xxx/cpus, but might be simpler when
> parsing a trace.

We don't want to introduce an array of CPUs, or a name like cpus0-3,
which than has to be parsed in more complex way. Also, the other devices
like GPU might use this trace event, so I just wanted to keep it simple
and generic to handle them all.

