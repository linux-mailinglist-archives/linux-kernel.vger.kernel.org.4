Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C85627879
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiKNJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiKNJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:03:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 252771D671;
        Mon, 14 Nov 2022 01:03:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFAAC23A;
        Mon, 14 Nov 2022 01:03:23 -0800 (PST)
Received: from [10.57.4.132] (unknown [10.57.4.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8914E3F534;
        Mon, 14 Nov 2022 01:03:14 -0800 (PST)
Message-ID: <fa8de189-8477-462b-e55a-a3046bbdbb36@arm.com>
Date:   Mon, 14 Nov 2022 10:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 07/20] arm64: dts: Update cache properties for freescale
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>, Chester Lin <clin@suse.com>
Cc:     linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20221031091956.531935-1-pierre.gondois@arm.com>
 <20221111025553.GJ125525@dragon> <Y23URNBaDS4wmykw@linux-8mug>
 <20221111045727.GM125525@dragon>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20221111045727.GM125525@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 05:57, Shawn Guo wrote:
> On Fri, Nov 11, 2022 at 12:49:08PM +0800, Chester Lin wrote:
>> Hi Shawn,
>>
>> On Fri, Nov 11, 2022 at 10:55:53AM +0800, Shawn Guo wrote:
>>> On Mon, Oct 31, 2022 at 10:19:51AM +0100, Pierre Gondois wrote:
>>>> The DeviceTree Specification v0.3 specifies that the cache node
>>>> 'compatible' and 'cache-level' properties are 'required'. Cf.
>>>> s3.8 Multi-level and Shared Cache Nodes
>>>>
>>>> The recently added init_of_cache_level() function checks
>>>> these properties. Add them if missing.
>>>>
>>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>>
>>> Looks good to me.  Should I pick it up on IMX tree, or it needs to go as
>>> part of the series (via other tree)?
>>>
>>> Shawn
>>>
>>
>> The change for s32g2 looks good to me. I would be grateful if you could pick
>> this patch to the IMX tree. Thanks!
>>
>> Reviewed-by: Chester Lin <clin@suse.com>
> 
> Ok, I will wait a confirmation from Pierre that the intention is indeed
> for platform maintainer to pick up individual patch.
> 
> Shawn

Hello Shawn, Chester,
Yes please pick the patch individually,

Regards,
Pierre
