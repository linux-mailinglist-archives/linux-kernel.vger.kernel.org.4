Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A607605006
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJSS5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJSS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66765AB832;
        Wed, 19 Oct 2022 11:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 035636199B;
        Wed, 19 Oct 2022 18:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EDAC433C1;
        Wed, 19 Oct 2022 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666205867;
        bh=EnOpH7Lv1TeiqPjow/eD64evbB/LIRhs0HLdNfrtqzY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c14JiC5Cxi1euBihLQy4aYcfn7XPo+SjbbDLw5kiIqj4ktcXPnRdE3nhmRFWG5OpA
         yiyaY4Zh/2RZ14Pil0LM3NGxj81fTEjpCAHmM93XHLXgPsOBXTp0qRUH4m+eY4Cqf0
         lXmN2Q4hgb3fjOGajMN2tTkFSBmHCo/thpSmGnQAKb19R8diUJ323KSBTu2jntU1+x
         0toYyNe13UVkLR8rLJ/KXLeo/79WeiYHF3jgEtYRXusbtvMVEr+0rWRgbDvY1RArkJ
         lmnp9JqX37Hs6gR6RTWoRxbyUA5eoFa/n6zSyL6RSQgZN7oAJbhTVd5shkPpdZ7Kjd
         NvsxD2ToXFvjw==
Message-ID: <6e6935bc-6de9-99fe-be17-1845b1910e2c@kernel.org>
Date:   Wed, 19 Oct 2022 19:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] of: fix repeated words in comments
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
 <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
From:   Conor Dooley <conor@kernel.org>
In-Reply-To: <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 19:53, Randy Dunlap wrote:
> 
> 
> On 10/19/22 06:02, Jilin Yuan wrote:
>> Delete the redundant word 'of'.
>>
>> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
>> ---
>>  drivers/of/device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 8cefe5a7d04e..16c7e5a2a868 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -19,7 +19,7 @@
>>  
>>  /**
>>   * of_match_device - Tell if a struct device matches an of_device_id list
>> - * @matches: array of of device match structures to search in
>> + * @matches: array of device match structures to search in
> 
> Hi,
> Rob has already explained this at least 2 times.
> 
> The second "of" is "open firmware".
> I would write it
>               array of OF device match structures to search in
> :)

Good luck getting a response out of these guys, at this point
you've gotta wonder if they're real people or bots.

> 
>>   * @dev: the of device structure to match against
>>   *
>>   * Used by a driver to check whether an platform_device present in the
> 
