Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69C69560B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBNBnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBNBm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:42:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E8A5D8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:42:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6F961321
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6FCC433D2;
        Tue, 14 Feb 2023 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676338977;
        bh=7Aw+lFf2GKn1e8zcJaIaZ6GDRglUt/eLL0AZcc4QVWs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ltjtaO08iIIGLhYLCILTc/8YmAIm758+wWAxwNnQ2Si3Gp6AvKZ3Lt5NEEHz7oSY+
         yUl0GMQLhpBQwhUAMRCj/SraasE3MHsXPeyu4ZHYMqm+XmOsi/ln7LnXSgGfY4ccmZ
         fc+j0v+nxpChI46RsnDghdvhc+XjaNfbkRxeUjexMX2/Lg3Xe3p8Oq0BLJcU6PFVj2
         Rza5wXqOBJabAHX2QD3h4zGemXVMuRL5F9DYhYR0jvoJl7TM6cOE3VUtF9gveU0lUU
         UsSBmvwF5NYMlw32BXLkUKsVRPE74mYm2VrsPjSOvGNPhDyjJRM6nwWQGys1+SEpGT
         q8nflKkKXDlwQ==
Message-ID: <abb12474-f338-dedf-115b-da70e4946cec@kernel.org>
Date:   Tue, 14 Feb 2023 09:42:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] f2fs: make kobj_type structures constant
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
 <cc338b66-f0f5-d9b7-81d3-b15bccc9d463@kernel.org>
 <Y+p4jezz5asWoPhu@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y+p4jezz5asWoPhu@google.com>
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

On 2023/2/14 1:51, Jaegeuk Kim wrote:
> On 02/13, Chao Yu wrote:
>> On 2023/2/9 11:20, Thomas Weißschuh wrote:
>>> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
>>> the driver core allows the usage of const struct kobj_type.
>>>
>>> Take advantage of this to constify the structure definitions to prevent
>>> modification at runtime.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Hi Chao,
> 
> Note that, next time, I won't apply/modify any patches merged in -dev,
> unless it has a problem.

Hi Jaegeuk,

Oh, any particular reason, to avoid unneeded commit id change when the time is
close to merge window?

Is there any period of grace before merging patches from dev-test branch into dev
branch? Maybe a week is reasonable? so I may have time to catch up in time.

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
