Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D8697E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBOOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBOOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:44:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2F3929B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B9861C3D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931DBC4339C;
        Wed, 15 Feb 2023 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676472239;
        bh=ZYy2SiK9o8XAp9f39GoyiQzDdp41wQI4tr6oU4Ic9Fw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PlyxzAm1ZI1Fqk6aBTiXn0qDQdolDjA6CwWYTCIC0Sb1a+SeyN9An1jI8Ps5KIKWx
         1BAq2Ii8lNEa2CtlMPrbvJd+gHG/G/VuWEn3+lQoDnLmOZWD/wd9HKYeM09oCPe7FS
         ZzGn2DKBvAPk4rK9VMUFfgg/yhv8uJtYEngh8SrFpmIqKL9VukCPBFOxrmykZ3JyL5
         REX9VbCE1dXnwmMFehnn8YIS/reX2jXIlNHpX5j1wdBzGty7MiqxVBuPZtik7pVX/I
         ojuw7T7HGpWe6+ffqoPfvZ9wTT/zLwcZL6Zw1eh3aQVffZTFfR9H8v3SOoJbQsNytT
         EPa48PS5od94A==
Message-ID: <10a80557-50f6-f563-56ca-eb3df7e4ea93@kernel.org>
Date:   Wed, 15 Feb 2023 22:43:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: make kobj_type structures constant
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
 <cc338b66-f0f5-d9b7-81d3-b15bccc9d463@kernel.org>
 <Y+p4jezz5asWoPhu@google.com>
 <abb12474-f338-dedf-115b-da70e4946cec@kernel.org>
 <Y+vN18flpTqWwvll@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y+vN18flpTqWwvll@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/15 2:07, Jaegeuk Kim wrote:
> On 02/14, Chao Yu wrote:
>> On 2023/2/14 1:51, Jaegeuk Kim wrote:
>>> On 02/13, Chao Yu wrote:
>>>> On 2023/2/9 11:20, Thomas Weißschuh wrote:
>>>>> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
>>>>> the driver core allows the usage of const struct kobj_type.
>>>>>
>>>>> Take advantage of this to constify the structure definitions to prevent
>>>>> modification at runtime.
>>>>>
>>>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>>>
>>>> Reviewed-by: Chao Yu <chao@kernel.org>
>>>
>>> Hi Chao,
>>>
>>> Note that, next time, I won't apply/modify any patches merged in -dev,
>>> unless it has a problem.
>>
>> Hi Jaegeuk,
>>
>> Oh, any particular reason, to avoid unneeded commit id change when the time is
>> close to merge window?
> 
> Hi Chao,
> 
> I'm trying to avoid breaking the -next branch.

Jaegeuk, so why do we need to avoid breaking -next branch? I didn't get it. :-(

> 
>>
>> Is there any period of grace before merging patches from dev-test branch into dev
>> branch? Maybe a week is reasonable? so I may have time to catch up in time.
> 
> No rule, but I'm trying to wait for several days while running my local tests.
> If the patch looks okay, sometimes I'll queue it right away.

Sure, not problem.

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
