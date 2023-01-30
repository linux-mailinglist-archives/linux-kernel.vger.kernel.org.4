Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFEB681F87
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjA3XUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjA3XUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:20:34 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE10C144A9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:20:33 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q6so2383171ior.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoWJBPlhONEo27DBkPSJxofFyjuxznuCdFDDNuIYoVA=;
        b=K2eGncq5rm8WUagXiXHcL9i2X7JWgHlub+RvFMn2ALoI6HP73WLm4haHMRafCzbO47
         l8ZDxzZNsqqGXbKsbCv086D1hGfCqwp3KZk+8L6vbQpDcvRsYyQeq7kYsHZM6tzNFXtm
         7rRCtxdMr9qwRUHVQEUl0K7MGB20Ad6/mrGIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoWJBPlhONEo27DBkPSJxofFyjuxznuCdFDDNuIYoVA=;
        b=fhlxiIPJAXGOHYgAcioSMpwdX+iNedjOz1CXOf1nRs8sbKLwzq/KOPQ+uUrYji2vbS
         V4lyhUDgeC9A8fKb3Z1QQZhv19/7o7fcZeJnt+exS/nWe+X4lzgVpG85Tvn0Q5tNQAR5
         QKl9Kc3jl+bSwe3eB+s5kImjACrObhpCwpOQ2h2M/lzrrmN5HOI00hBzOc6DV4Ga3JzI
         YdcYkbfjgZRTrBioSL1Q5l9Tipvm0GjFP9YRWbqDEWHMRlJUyngi+5G3kOz9nZoPSMUm
         7KCUGtQFvdq8UXaJbkU/t2eKhH6euvoNFaDDS7bzX3DLqI/dnvEMoF59z0gEnPX9RFry
         zu4A==
X-Gm-Message-State: AFqh2koeVoFtgF27siBfTIxlIW4Ez+iYwNiwg58qlmOFsViGEXCBSxHc
        xAp7RyycByeeZ7FYqhyunyU+Ww==
X-Google-Smtp-Source: AMrXdXvQAGzB2SQuB2Udtkj3pF9mBQbBcfaP1Vnr1bkh3W45zfQsX2tCVAfrJZPxB33Uhs1zcGLKvA==
X-Received: by 2002:a05:6602:341a:b0:704:d91f:9932 with SMTP id n26-20020a056602341a00b00704d91f9932mr8807276ioz.0.1675120833103;
        Mon, 30 Jan 2023 15:20:33 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a056638062d00b003a970f21f9asm4210310jar.78.2023.01.30.15.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:20:32 -0800 (PST)
Message-ID: <68594f1d-25e3-4eab-98cb-8691d01719c7@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 16:20:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] docs: add workload-tracing document to admin-guide
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127234616.55137-1-skhan@linuxfoundation.org>
 <25089707-b037-4cce-367b-819ddd239b17@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <25089707-b037-4cce-367b-819ddd239b17@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 22:40, Randy Dunlap wrote:
> Hi--
> 
> On 1/27/23 15:46, Shuah Khan wrote:
>> Add a new section to the admin-guide with information of interest to
>> application developers and system integrators doing analysis of the
>> Linux kernel for safety critical applications.
>>
>> This section will contain documents supporting analysis of kernel
>> interactions with applications, and key kernel subsystems expectations.
>>
>> Add a new workload-tracing document to this new section.
>>
>> Signed-off-by: Shefali Sharma <sshefali021@gmail.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> Changes since v1:
>> - Addressed review comments on v1 on long lines, rst syntax, license
>>
>>   Documentation/admin-guide/index.rst           |  11 +
>>   .../admin-guide/workload-tracing.rst          | 591 ++++++++++++++++++
>>   2 files changed, 602 insertions(+)
>>   create mode 100644 Documentation/admin-guide/workload-tracing.rst
>>
> 

Thank you for the review. I will send v3 to address them.

thanks,
-- Shuah

