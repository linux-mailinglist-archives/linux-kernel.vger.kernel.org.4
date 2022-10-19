Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11D604997
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJSOoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJSOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:43:52 -0400
X-Greylist: delayed 3557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 07:30:02 PDT
Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F3E7FE935
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:30:00 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id l8yLom6VCSmRKl8yLoC5TK; Wed, 19 Oct 2022 15:19:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666185545; bh=WDOGMpV390CNEKOYi9e07ywYx+WEmXUEkJzv9gxWxDQ=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=VesLSrQjcCVgIuoR09xn8ccWOncxgNJcFM6I7wVwjsfV2pUdgYZ8hpjBNGvD2SOOt
         QZl+pQzHBrIw3NwIm2x6BYUm2MQhMb1dmqChCu3e7NqoHzI9dvaYYet6vnVAv5rI9o
         SdOyhMh3w2+81l3DjVSwJQap/i1CpzVudzmaK2wUd3yDKd96kZQk1P9LSiWNC2v4yX
         u+5TrkE30+LIE3aanSyzL+2Px9i1UtgsA8F6DI6ZrjwJaKqLOwpAo5QSUSMC0v0ubX
         TrNBJrNH3/l3GixjjJK78GYOS3iMGd4VnCk5Ur8SjrAGLk0J5B1/uodHhTEN7e4kSf
         0sV/SxXC5mXGA==
Message-ID: <e08af145-59eb-1a36-01d1-3ddb9eef5e7c@benettiengineering.com>
Date:   Wed, 19 Oct 2022 15:19:01 +0200
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
X-CMAE-Envelope: MS4xfB+NDAsiJxnR3l50nzexIf2Nm5qf9kozjDLXjBsMXnWsJq1kS6Prga/nWQyUoWheKfTCL6zoU+IRJI1sdAmagXZVMkd/FUYgd79e2NLN0969HIPurf4s
 7FMqqGZHdB7dUwJp3GTb41IUsxfziJIyLnvZ2LjBS9yn5u/m8d4V+f0W95lHOCCGo8cqAJjRnoimvLFwFjpDbOaqnPBQADhxPA1Bpsw7xVtBnLVPAsqmdeAA
 hfVULjRA0+GBTwTI1NvhAMDIC2d/0nQl/Xb/svdU7BuHgAPVDgZ/rwbC4Xc+zmXCjZs9ATUNqmLhxECSEYGZmCCatC2GMc1CbjslIrBo+kmqc8HZKABoxeuz
 RaeT95Md9rzbiu3lgAtg3o/IqI0jmCKESRC5IiByX7ymiZH7J9EI94Tu767HTqsyTJCcYC18KkUPqUFcM9knS1Ut77Tiwd5WGx/a+hlWM+/Og0ZqY74KtyxQ
 LYFfX/FiHIR++SiEBaZlD2erzaOmk7J8BBA7GQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristoph,

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

thank you for taking a look.
Should I send a patch for removing the code in this v2 patchset?

Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
