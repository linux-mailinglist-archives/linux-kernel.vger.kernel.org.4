Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D75700836
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjELMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbjELMkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:40:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89A265A4
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:40:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f4271185daso57506375e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683895216; x=1686487216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYBrXrkZvtGUdnl+T9M4zNPAIaDpUkdt7BFmY49m2ZI=;
        b=ZbgA8DY0DZ+xjn65/9QBCA6eVuMjDzEnT5SLZASnCeknNfA1Dz4gRIdPiZAAVpRD8H
         xJfTgCW62q81Dc7rOigwzeBngfPdRC4Tv013c8bgBNY4jX4x9d5eovBz4OceFNH4NSM0
         Radzx9jDmt4AQKEWSQfoN4t2cK0VmnKMA3Alw5EOpgFHCAH/MZjcQkTBZszOVutv92q9
         iLy/3zBfXhFtvC3byTILlU8TKz/sYpm3944ZOmr9DUXtoIjShZnkIKhdzhfprgCP4RNZ
         SGgYQdZW1cnkzux80fPTKSSLUJjxgcto0akvwtpNqpSxXzn0sMC1hVCpwjltSGOJOKlX
         ChHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683895216; x=1686487216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYBrXrkZvtGUdnl+T9M4zNPAIaDpUkdt7BFmY49m2ZI=;
        b=hMLuSrCpS29K+VVf8VFZbFTTuRZ0W0yYZrdxN5g2fetvVYI35k0ftXZGlelADaNWWl
         DVfo23QGr53HIfbWdaIkfsiIKd9z+kistlf2d+Kf/mJb5LxZWxIn1Ev8dfH+j4wtFHl4
         i7wx5jViqIIytCET7AL1jRWk5dUBnsBXtG7yhthAC6Dh+y1xR+i0GMn/8b9Jton/Wfxm
         XfL0IaOsYMFjy8WrkhgwLWwGUowUTwnWZGy9j4DVUSQrpVAr7WrKCkcgJVqUHTeSgc/f
         HMNWmcycBW6wGgytiFDAhBqEtwSEDwOD3wsGy2tw0uh3rj9FEjInYUrrNAWDwK5YMey4
         J2GA==
X-Gm-Message-State: AC+VfDwUBycyAFzI5fAdwphibqQ6Q83h0nOtwMt/GsZL3GfsNDjHYwfD
        Wu6Ev1/0AvG9WCF10IXwlBoC9w==
X-Google-Smtp-Source: ACHHUZ6L5DJx65fZeuAyJ0+FoXdXQimFZJ5rIaK75cbLRr5ODhrE9mGnAkA+JLhc30QRmyWi5WfFbQ==
X-Received: by 2002:a05:600c:22ca:b0:3f4:2158:2895 with SMTP id 10-20020a05600c22ca00b003f421582895mr12882808wmg.3.1683895216317;
        Fri, 12 May 2023 05:40:16 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 21-20020a05600c029500b003f42d8dd7d1sm9274290wmk.7.2023.05.12.05.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 05:40:15 -0700 (PDT)
Message-ID: <c6f903e6-ccf2-701f-cfe3-34abacde278b@linaro.org>
Date:   Fri, 12 May 2023 13:40:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] misc: fastrpc: Reassign memory ownership only for
 remote heap
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org, ekangupt@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com, stable <stable@kernel.org>
References: <1679394100-27119-1-git-send-email-quic_ekangupt@quicinc.com>
 <17185edd-aa6f-386b-4252-0c6eac1ddcfc@linaro.org>
 <ZCQOaMcObl0vYqlg@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZCQOaMcObl0vYqlg@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2023 11:09, Greg KH wrote:
> On Tue, Mar 21, 2023 at 08:53:33PM +0000, Srinivas Kandagatla wrote:
>>
>>
>> On 21/03/2023 10:21, Ekansh Gupta wrote:
>>> The userspace map request for remote heap allocates CMA memory.
>>> The ownership of this memory needs to be reassigned to proper
>>> owners to allow access from the protection domain running on
>>> DSP. This reassigning of ownership is not correct if done for
>>> any other supported flags.
>>>
>>> When any other flag is requested from userspace, fastrpc is
>>> trying to reassign the ownership of memory and this reassignment
>>> is getting skipped for remote heap request which is incorrect.
>>> Add proper flag check to reassign the memory only if remote heap
>>> is requested.
>>>
>>> Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
>>> Cc: stable <stable@kernel.org>
>>> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>
>> Thanks for fixing this,  without this fix the code inside if condition was a
>> dead code.
>>
>>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Are you going to be collecting these and sending them on?  If not,
> please do.
Sorry for long delay,
I will take care of collecting fastrpc patches and send it.

--srini



> 
> thanks,
> 
> greg k-h
