Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF87D638659
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKYJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:33:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66B51F9C4;
        Fri, 25 Nov 2022 01:32:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so2986455wms.0;
        Fri, 25 Nov 2022 01:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C9OyskwPZlHME1PL3eMYljWMwoWT8eKh9tVx7GnyNs=;
        b=X1lHRr9ubBRLqHsVi0VQENrFN0+dhSqkauzWMsNmlIBxF1O5sWa6sPo9lm34+S2d3Y
         zX4F5O3X+9AaDXU4zS5yQGVZGtiwHVR+8VbeEsmToe+kKK/0t095rN7VNZoJDquzOjag
         F5kBL57pyGPpoOCf5uco2ckDIok7mktIF/1vjm5Gkuh5gn29Rux9gQItEVEQ+TNJJXBO
         xVmjm/QUejgwI91jFeMbShZq20lo5GDSbQXiS+MNrWchAf7G/3V64LCwbX0t0j5AkP5r
         EJ0hVxsTg9I+J0gMVEsfDeOvQULYoSawFpXBOng0sU6GNr6gXpU4HdrJ9EC82Gqu2qzM
         EtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1C9OyskwPZlHME1PL3eMYljWMwoWT8eKh9tVx7GnyNs=;
        b=6HzUgbuJgoRgq2xJWB9QolEBEWCI5/H4qeaiLb/k/LvfDHTdsKsa2ZBfKV+YwPSvbT
         YuPiD7/gD7LFjwL6L04P/vY8RANXl04Dyzwe9pdR9xq8Jmlax65r7oV+tVV/PSY0M4i/
         qvSwtx3MLyCVhHGZDLk8HRhctDeRHjeExCv83p2DdcFaftI6fA6Z0xAk8tHw7iHoh/eC
         +nbKICTnWf85Ouj10mhtU3i+6XBQC9SSCw8P+G0oimD5dq0IoGlH9qdg1Ry8lyXQ5X4C
         hmGR6s+OFoKNZp7IuhYXL7rG7ImhH3uD82BDJqltLR4hpBt8H8YglJ4jbUPGWGBYhnHn
         KJDg==
X-Gm-Message-State: ANoB5pkoJAqfBoitQ4g7NGM9X9x2N9mlq1hYn7SAU9GXcbUIX8C/TJPI
        d8lfULrn622sto2id4TW748=
X-Google-Smtp-Source: AA0mqf4q6TFRr6LgrxaDHG9T89iG0G5ZI2HSBkBeVAhnSnpeqpP6OOmimacE684/RiElIUU3DIEZxA==
X-Received: by 2002:a05:600c:220d:b0:3cf:633f:c570 with SMTP id z13-20020a05600c220d00b003cf633fc570mr17959222wml.110.1669368778398;
        Fri, 25 Nov 2022 01:32:58 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id u22-20020a7bc056000000b003c6c1686b10sm8406659wmc.7.2022.11.25.01.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:32:58 -0800 (PST)
Message-ID: <d2c7979e-3891-283e-d20b-97b75a27730e@gmail.com>
Date:   Fri, 25 Nov 2022 09:32:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.krogerus@linux.intel.com, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org
References: <20221123022542.2999510-1-yangyingliang@huawei.com>
 <Y34gz4UXN7il3b49@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <Y34gz4UXN7il3b49@smile.fi.intel.com>
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

Hello

On 23/11/2022 13:31, Andy Shevchenko wrote:
> On Wed, Nov 23, 2022 at 10:25:42AM +0800, Yang Yingliang wrote:
>> The 'parent' returned by fwnode_graph_get_port_parent()
>> with refcount incremented when 'prev' is not NULL, it
>> needs be put when finish using it.
>>
>> Because the parent is const, introduce a new variable to
>> store the returned fwnode, then put it before returning
>> from fwnode_graph_get_next_endpoint().
> To me this looks good enough. Not sure if Dan has a chance (time) to look at
> this, though. And maybe even test...
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Apologies; didn't notice this earlier. I will look at and test this today

>
>> Fixes: b5b41ab6b0c1 ("device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> v2 -> v3:
>>   Add a out label.
>>
>> v1 -> v2:
>>   Introduce a new variable to store the returned fwnode.
>> ---
>>  drivers/base/property.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index 2a5a37fcd998..7f338cb4fb7b 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -989,26 +989,32 @@ struct fwnode_handle *
>>  fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>>  			       struct fwnode_handle *prev)
>>  {
>> +	struct fwnode_handle *ep, *port_parent = NULL;
>>  	const struct fwnode_handle *parent;
>> -	struct fwnode_handle *ep;
>>  
>>  	/*
>>  	 * If this function is in a loop and the previous iteration returned
>>  	 * an endpoint from fwnode->secondary, then we need to use the secondary
>>  	 * as parent rather than @fwnode.
>>  	 */
>> -	if (prev)
>> -		parent = fwnode_graph_get_port_parent(prev);
>> -	else
>> +	if (prev) {
>> +		port_parent = fwnode_graph_get_port_parent(prev);
>> +		parent = port_parent;
>> +	} else {
>>  		parent = fwnode;
>> +	}
>>  	if (IS_ERR_OR_NULL(parent))
>>  		return NULL;
>>  
>>  	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
>>  	if (ep)
>> -		return ep;
>> +		goto out_put_port_parent;
>> +
>> +	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>>  
>> -	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>> +out_put_port_parent:
>> +	fwnode_handle_put(port_parent);
>> +	return ep;
>>  }
>>  EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>>  
>> -- 
>> 2.25.1
>>
