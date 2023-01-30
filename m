Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECF3680B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjA3LDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjA3LDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:03:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025662E0F7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:03:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l8so7691999wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iW3h48EgC+B9xesAWTV4ocRnzISW708+S34/T5By3HU=;
        b=I/vL66wKwzqLij5P964thWoGXBWf3+KlaCT1thMeSMNPsOfANjBAig3bvDY24ERBeR
         ECtez/D+MW3vFdEc2JKG9slBNZ5rNMtUscHFtJoCyjjPtx4ulXYFL0ys98AglfdmRN6p
         e7qNcXIkvNuU+c/GI0SbMF+Zh2Ky0J7iwy4epvNWhnRsEg4cDugszIF/evGiKY5XrGki
         bsb4KEPOKqU9vQpbsrp9HNjAGOi69c4qvGXVvHx6K2hJd3AYi1ZoX+Xpfn4MmngIMYOr
         49RT0y6/Zd/85gR+CAFkDMkA21gANnmoYgBFWAApVSbzIcFh+4eCh0bIguXqgHJDjz2W
         31tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW3h48EgC+B9xesAWTV4ocRnzISW708+S34/T5By3HU=;
        b=5MnNSE3ttEadixYsJISsQUFUqdEkYhv0HqTJSW0rPPxDd7jEBZHojQUsGPf2vphgsU
         6ziKeMIlLkSIwVLJxPVR/vom43ylPxPuF/XzOoKquW0nCthQcVIIbkIJKnlZBPLu+xMA
         JCPQWQB1+ePIuCfX4PrQ8v7n/o8WqasZjB+AaYnoedbcobpuESeaQH8fE2s+hHeIih0V
         4N8w5UFqp69lorPfRqx3fguLObaPyJuKwi7rMd3CBx/KTAft6faY5/IMyNKI538YlgLP
         FzIIFkUEVLX/diUMrkKydgxS+Qs36Ry57NPoUDFnwod2/DQSvE9iWnOyTNMJij6CxQYc
         cqpw==
X-Gm-Message-State: AO0yUKVqC0yC7czaVHYe2vjgQwhv0Di1UdFy3XPvUBR0j8qNz2B9erpx
        8dtVU8FuiGJ5/tJZv+Sov9MDFLsy3BjSVVad
X-Google-Smtp-Source: AK7set92F7rpe2VyZ9xPeLwLyfZu/TFzv535Wdebib/Lc11YmgHfVGoR0nmw7A+no9AHvPW/w/+rNQ==
X-Received: by 2002:a05:600c:4688:b0:3dc:438a:c381 with SMTP id p8-20020a05600c468800b003dc438ac381mr9402664wmo.28.1675076585672;
        Mon, 30 Jan 2023 03:03:05 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e15-20020a05600c218f00b003dc434b39c7sm11618282wme.0.2023.01.30.03.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:03:04 -0800 (PST)
Message-ID: <ef5e4ea6-6dcb-3700-a8e5-2b7ec5aad092@linaro.org>
Date:   Mon, 30 Jan 2023 11:03:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/10] nvmem: fixes for 6.2
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
 <Y9Ulm3So08Fg308w@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Y9Ulm3So08Fg308w@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg,

On 28/01/2023 13:39, Greg KH wrote:
> On Fri, Jan 27, 2023 at 10:40:05AM +0000, Srinivas Kandagatla wrote:
>> Hi Greg,
>>
>> Here are some nvmem core fixes around nvmem provider device register
>> and error paths.
>> Most of these patches have been in next for 2-3 weeks.
>>
>> Am really not sure if you are taking fixes late in this cycle.
>> In case you are not could you please apply them for 6.3
> 
> When I apply them, I get the following errors from the scripts:
> 
> Commit: 36f5dbea16ad ("nvmem: core: fix return value")
> 	Fixes tag: Fixes: 60c8b4aebd8e ("nvmem: core: fix cleanup after dev_set_name()")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> Commit: 7de8892c0527 ("nvmem: core: fix device node refcounting")
> 	Fixes tag: Fixes: 69aba7948cbe("nvmem: Add a simple NVMEM framework for consumers")
> 	Has these problem(s):
> 		- missing space between the SHA1 and the subject
> 
> The first one is because you have your own git tree, that's fine.  But the
> second one should have given you an error when it was in linux-next, what
> happened?
> 
> Let me see if I can fix this up...

Thankyou very much for fixing this up before applying, will take extra 
care next time. :-)

thanks,
srini
> 
> greg k-h
