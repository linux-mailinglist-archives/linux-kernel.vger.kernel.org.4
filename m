Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B807D604CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiJSQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJSQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:12:26 -0400
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACF4018C960
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:12:20 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id lBg2o697isjaWlBg3oQLXQ; Wed, 19 Oct 2022 18:12:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666195939; bh=H11y0JOWCVcRqUZSCbershaEEzVxspy74vpoOyQgK1g=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=F6xpCnw6VQfbPVuxQh6SJFXhBf4zWoODRgCm7gx0E/hTYTAQIOo67I2TZ64CJbJB5
         kz6apcQw0yt4oUyg8MJfzg2gWdXROWmL4iOAWFB/HMzWO0F7v4pdOqSaksdkYLEZ8I
         elbH1I0KrccNDjpcOTUD0yrVQpCbarNxuaMUKeBOMjjB9qZ4g/JjjibjiNPDcrq0FB
         JFvo7SaAmYKxy9RG+dErk8ee8XoB+K15PS2bTYW7DT3RM4AnW+JM0rUMvs39Pg2S5C
         Z5QxsV6wwgcvXA+JKQDPG9m7Udgl9xqIfs9y1CZH6AVHIHfuo+YJl0u+feFMFmogT5
         htSRUM2de3LEw==
Message-ID: <fa21b2b9-50cc-48a5-eec1-e3360be9d296@benettiengineering.com>
Date:   Wed, 19 Oct 2022 18:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/3] raid: substitute empty_zero_page with helper
 ZERO_PAGE(0)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-raid@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Song Liu <song@kernel.org>
References: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
 <20221018215755.33566-3-giulio.benetti@benettiengineering.com>
 <Y0/Yt4uJWg4knNoc@infradead.org>
Content-Language: en-US
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <Y0/Yt4uJWg4knNoc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIhqBZ6chw9faEg1o6elx0uoZAGxbuv8fzCjCxxumRpa3oxOvtrKNIjF5tfVszhlZcfDvQLXWeyefke0ZBwV0dQ9t40Ax/xBSP++kTOUQHdqWYuZ1+19
 vmIwZjrtJSJrtw+3Y+GESPSr5VqBU04jPvhToni1hxwy6MHjNe7fbDCYUXmDN0N2ml6tkqiHFN33yMEE5K19C0PiuInchED2meQFP9rsxJZkjlYjkWhdktja
 nc7+KirBREDtVOpBtYfxaO2OPtdwafXt4R3pKS+tA+TwCGdpyGDfP7Y1J5Xw7eA02HL4NcVSI1YeC9xvV9HQ96Sf7ELAJXgq2y9Zc1xHCP7fDKOnJqbajqOT
 XtfAExf6UcmZT49Dyb21pTjm0wnz0H8iQCX2UX1v1EnHJSYDSLRKCwuNRKrX/cVkzwMY43i76qbXu6CoOuk4PLynx9RZCHUFrXWcfgN693tru5f/rigqfOvi
 DVKXH26DQCjQvdpgDxxMQ7jrRSiH/Y2hBrEnEw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, All,

On 19/10/22 13:00, Christoph Hellwig wrote:
> On Tue, Oct 18, 2022 at 11:57:55PM +0200, Giulio Benetti wrote:
>>   #if RAID6_USE_EMPTY_ZERO_PAGE
>> -# define raid6_empty_zero_page empty_zero_page
>> +# define raid6_empty_zero_page ZERO_PAGE(0)
>>   #else
>>   extern const char raid6_empty_zero_page[PAGE_SIZE];
> 
> RAID6_USE_EMPTY_ZERO_PAGE is never set to a non-zero value.  So this
> is dead code and we can just remove all code related to the
> RAID6_USE_EMPTY_ZERO_PAGE case.

Here is a patch that removes that unused code:
https://lore.kernel.org/all/20221019160407.7550-1-giulio.benetti@benettiengineering.com/T/#u

and then makes this one useless so I ask to drop it please.

Thank you!

Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
