Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7866BE435
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjCQIqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjCQIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:45:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BDB4DE13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:44:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x13so17531459edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679042663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6NYA0wCgWDefyLAOc5P5kFbBTKmFV1aY1moHxgahZ4=;
        b=nSnrtmro6phByHozBbIH+6vgvGhfoA2XR6oh4c9iFxXwheTatFHgEWS+SwuFCFkbdZ
         BfBVGU5j7zYY5VUsQnQP37PgGMeZ42DOcBJvs4A9sZqamJKHfTQ1yxG94Hsoic30WAwd
         qW20GsPtNzcWJkTob8X0JCuetOip0Odt2nqnmF0fgsoB7z8Vxf2XjM1j4yR6ZS9jjTtV
         LijYWf13ukfiur9d7iEcl7Or8Vah/ec81ZO2/HtxHBuc9F0UF23agl6m3HSaQEktfJu+
         qbJRkgZOeB6KPxPvcM8KXOZo4PEZVNYJ+WpIeKdRGDCRlvv7RAKTZB3OsIX0+cc1QNqu
         BqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679042663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6NYA0wCgWDefyLAOc5P5kFbBTKmFV1aY1moHxgahZ4=;
        b=CYOd1dd0yxHH0qownzNKYIKk44x8eG35a/b2ebwocnt4LWA2OXRII6zCCWXlSCBVOO
         kZgL0BZxq5Kfv49VTrX26ef/0Jt9S4Bc3SxE/NtV6j+PNw5yal8+pEqVXGGQ9Ahh4hdZ
         yHIXok0gKbbuGmu5zVKIJDEZRCZFfylQrUOh0zXgsVhTySqtnX1L7fFgTHrVCI77TmJl
         0ciKIJrwckbK3iFXP4ns8W9Z5adhSvjXckl/lKmXBGJhqNKbzzvYMNSRFBPeOACVawgg
         H2bbIUhwPO//uJHYrueCDbfr51OWR8k8XA/ViiMht8Xhtedw3AbDq+3wsJOf7SJxdqbY
         wLag==
X-Gm-Message-State: AO0yUKVGNcn1/pxIi9xm4TuOPp4OzXBlq+FR5+oa1wanCgcVylGK6h7E
        zIMb4VCYDAaA3sIQ4gBQp5c=
X-Google-Smtp-Source: AK7set8KpwunSYP+AssKKXLVGbERVf3AkLTktgzChwGdNKe+i4I0cKfF28SlHZOKl4ijmlRxjNML2g==
X-Received: by 2002:a17:907:a4ca:b0:92f:d900:9c66 with SMTP id vq10-20020a170907a4ca00b0092fd9009c66mr7600786ejc.10.1679042663332;
        Fri, 17 Mar 2023 01:44:23 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170907760300b00930876176e2sm713264ejc.29.2023.03.17.01.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:44:23 -0700 (PDT)
Message-ID: <5077782b-334f-c292-2e06-450c203b8fdc@gmail.com>
Date:   Fri, 17 Mar 2023 10:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
References: <20230208160230.2179905-1-gregkh@linuxfoundation.org>
 <f60870dee13900252e0b13fb2f5f05b5@walle.cc> <ZAWNtv0g6vmADGnb@kroah.com>
 <20230306093336.523832b0@xps-13> <ZAWuvRHVVV3hTm0e@kroah.com>
 <20230306120558.00f614fb@xps-13>
From:   Tudor Ambarus <tudor.ambarus@gmail.com>
In-Reply-To: <20230306120558.00f614fb@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.03.2023 13:05, Miquel Raynal wrote:
> Hi Greg,
> 
> gregkh@linuxfoundation.org wrote on Mon, 6 Mar 2023 10:13:33 +0100:
> 
>> On Mon, Mar 06, 2023 at 09:33:36AM +0100, Miquel Raynal wrote:
>>> Hi Greg,
>>>
>>> gregkh@linuxfoundation.org wrote on Mon, 6 Mar 2023 07:52:38 +0100:
>>>   
>>>> On Wed, Feb 08, 2023 at 05:15:41PM +0100, Michael Walle wrote:  
>>>>> Am 2023-02-08 17:02, schrieb Greg Kroah-Hartman:    
>>>>>> When calling debugfs_lookup() the result must have dput() called on it,
>>>>>> otherwise the memory will leak over time.  To solve this, remove the
>>>>>> lookup and create the directory on the first device found, and then
>>>>>> remove it when the module is unloaded.
>>>>>>
>>>>>> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>>>> Cc: Pratyush Yadav <pratyush@kernel.org>
>>>>>> Cc: Michael Walle <michael@walle.cc>
>>>>>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>>> Cc: Richard Weinberger <richard@nod.at>
>>>>>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>>>>>> Cc: linux-mtd@lists.infradead.org
>>>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>    
>>>>>
>>>>> Reviewed-by: Michael Walle <michael@walle.cc>
>>>>>
>>>>> one nit below I didn't notice earlier, no need to send a new
>>>>> patch version just for that.
>>>>>
>>>>> ..
>>>>>     
>>>>>> +void spi_nor_debugfs_shutdown(void)
>>>>>> +{
>>>>>> +	if (rootdir)
>>>>>> +		debugfs_remove(rootdir);    
>>>>>
>>>>> debugfs_remove() already has a check for NULL.
>>>>>     
>>>>
>>>> Ah, good catch, I merged this in when I applied it to my tree, thanks!  
>>>
>>> Any reasons why you did apply this patch to your tree? It is a spi-nor
>>> fix, I would have expected it to go through mtd.  
>>
>> It's been sitting around for a month, I assumed it was lost, so I picked
>> it up.
> 
> Sorry if it took too long, the merge window also happened during that
> time, we are collecting patches now that 6.3-rc1 has been released.
> Next time don't hesitate to ping first ;-)
> 
>> I can revert it if you don't want me to take it for 6.3-final
>> through my driver core tree.
>

It's fine, I don't expect other changes on these chunks of code. Anyway,
if there will be merge conflicts I'll solve them locally by merging the
-rc containing the fix.

BTW, you forgot to cc stable and add a fixes tag :).

> I'll let spi-nor maintainers decide what they prefer.
> 

If it'll be a next time, a ping would be better.

Cheers,
ta
