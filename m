Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6A673327
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjASH7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjASH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:58:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 178A83EFED;
        Wed, 18 Jan 2023 23:58:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA0441758;
        Wed, 18 Jan 2023 23:59:22 -0800 (PST)
Received: from [10.57.10.42] (unknown [10.57.10.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2201F3F445;
        Wed, 18 Jan 2023 23:58:39 -0800 (PST)
Message-ID: <eee126fc-c93f-9ff1-835a-96d5d70b4eca@arm.com>
Date:   Thu, 19 Jan 2023 07:58:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] cpufreq: Register with perf domain before
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Wang <bhuwz@163.com>,
        Vincent Wang <vincentwang3@lenovo.com>, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118044733.29391-1-bhuwz@163.com>
 <20230118084923.m3ztfn6v3hskpad6@vireshk-i7>
 <529d967f-9dbc-5b35-546a-428cbb191f0f@arm.com>
 <20230119053952.qwh2yrmhddzocnju@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230119053952.qwh2yrmhddzocnju@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/23 05:39, Viresh Kumar wrote:
> On 18-01-23, 09:24, Lukasz Luba wrote:
>> Viresh, If that's an issue for other governors, than maybe
>> we should address that.
> 
> As you said in the other email, it isn't a mainline issue, I will
> ignore it then :)
> 

Fair enough. Although, I hope one day, maybe at some conference,
we could discuss those Android-kernel vs. mainline differences.
IMO the gap isn't shrinking, but I would like to shrink it.
Especially when we are serious about long term kernel
support for mobile devices, this gap should be tiny.
Therefore, I would tackle this scheduler cpufreq governors and API
for them.
