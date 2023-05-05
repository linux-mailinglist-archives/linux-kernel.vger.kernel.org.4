Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FBF6F8415
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjEENbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjEENbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:31:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BBB203CD;
        Fri,  5 May 2023 06:30:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaec9ad820so16236335ad.0;
        Fri, 05 May 2023 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683293456; x=1685885456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jdXhOVy2KMLa5873OS7jS/gpPkG+MRIdvwBG6rYttG8=;
        b=a1MWLmJTX6yJ9OtYpzs066urW8nsFrP8te/CvF8bR5wQG9LYs/fV8EWGjrSuJN16+j
         qc/s3SG8LpYKl4iMH8UYBYjEM2L4zoWv0WAjMAYjB25KZd0Yj+1mJE3RyHDL4SWXwxTz
         ohIdeI1Pz5kFmpYfNGwaKT+5MQwvrM+B+QyQqVMOFQLVsgPCJyCtEajM14VGRe0hGxUf
         y2RswLv7QAa54lBPEZLpSw5lVgvgoSS8kpE38cxkzeFCGKZ0lqSVI8IOdDeHLljsqZwR
         hJKAdqf4YHPGE96YQVz3m7iRXQHkcKOlDjV6dQ73T1x/y3oOT//UPcrZzbMdOw8y8l0N
         efRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683293456; x=1685885456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdXhOVy2KMLa5873OS7jS/gpPkG+MRIdvwBG6rYttG8=;
        b=fNzv1n/Y0s4ykFxpZ68VzbroMhR1PTSfdZzNp6jhza/J/n75HImV52QhHFvOHxFJ8s
         pYkMGz1JYKgcJjKFbGWQFTlsOZFjEHQAcQ0XVyKIGzSiJv7XWMXS1DsJwujjEV9KGOjS
         5gPCihsuOIw+Be6VZGBcrNL/bx4tegVarZBM6wSFDlMJGa9YS48qa+Y9wLw5TAkEcf5c
         xgUCmIOsLaEbC5VzElvgfROK9A+TbguEN84qGBknnhItzqeyJRm0j9J0G29T+MlI83S6
         1JMwTFTXP9h3yOgqNjWEnYBS/HilrUPw+ssMojYICd+GlMxyuiaFI1+vlvoIgcHK+y9X
         KGGg==
X-Gm-Message-State: AC+VfDzY0qGvufIn5hOhIhvIdHHDLXh9SNE7iSlYpioaolu32PYxSg6k
        WdRE+4CYKXbVZ96FiYK2Vw8qyb5isFA=
X-Google-Smtp-Source: ACHHUZ74MgHysUIp/rpLKSwYZzxTBWmIQ69hMTJKMa+Lkxx1JidvezZz2gxkNG4h7ilFI9TSlmr9ow==
X-Received: by 2002:a17:90a:8a18:b0:246:b973:de35 with SMTP id w24-20020a17090a8a1800b00246b973de35mr1601732pjn.4.1683293456564;
        Fri, 05 May 2023 06:30:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a304400b0024e2230fdafsm7094681pjl.54.2023.05.05.06.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 06:30:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ec28c2c2-4623-0d92-00bc-b8cd53c965b2@roeck-us.net>
Date:   Fri, 5 May 2023 06:30:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 02/11] hwmon: (core) Rename last parameter of
 devm_hwmon_register_with_info()
Content-Language: en-US
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-3-james@equiv.tech>
 <ff6efe53-2173-1372-a1ca-c0928cf8a160@roeck-us.net>
 <ZFUBZyG5eoz2TpZX@equiv.tech>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZFUBZyG5eoz2TpZX@equiv.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 06:15, James Seo wrote:
> On Thu, May 04, 2023 at 08:29:57AM -0700, Guenter Roeck wrote:
>> Please please please no such changes. I don't want to have to deal with
>> patch wars just because people believe variables should have other names.
>>
>> Such changes add zero value unless one counts wasted review time as a "value".
>>
>> Guenter
>>
> 
> Hello,
> 
> Of course arbitrarily changing variable names is pointless. But this
> patch fulfills the intent of 848ba0a2f20dc121a3ef5272a24641d2bd963d8b,
> which makes this change for devm_hwmon_device_register_with_info() in
> hwmon-kernel-api.txt and in hwmon.h - but not in hwmon.c. The same
> commit makes the same change for hwmon_device_register_with_info() in
> all three files, so it obviously should have been in tree already.
> 
> The other reason for this patch is that for the purpose of generating
> function documentation from kerneldocs, it is not feasible to call
> this parameter "extra_groups" in the kerneldoc and still call it
> "groups" in the function itself. Doing so results in the lines
> "const struct attribute_group **groups / undescribed" and no mention
> of "extra_groups" in the generated document. Leaving things as is, so
> that [devm_]hwmon_device_register_with_info() have different names
> for this parameter, is potentially confusing and more noticeable to
> to the eye than I would like once rendered.
> 
> Is this good enough to proceed? And as a subsystem maintainer, is
> there anything else, specifically or in general, that you would like

Marginally. That should have been explained in more detail in the
description.

> to see addressed?
> 

I don't know. There are changes which seem to be more based on POV
than real improvement (such as the removal of the credit from the
PMBus document). I'll have to verify each and every reference to determine
if the change is appropriate. Also, the changes are substantial.
It will take a lot of time for me to review, and right now I do not have
that time. I have a hard time keeping up with code reviews.

Guenter

