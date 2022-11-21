Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E26320D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKULis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKULi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:38:26 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A8B4F1B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:35:56 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z26so11087618pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xj4ShWl/W6XVIrTFJyttrtRVjDkB/tCBxscsEA35xfM=;
        b=gvWoNr1fwq/GUbik/QuidrVz4liXQjaKTzSjbFKmyCwMSFIYCRoBZUUz0jp6z9yzPU
         Y1W7ZFYULSZFlakApy0IW3u9W28KWwyk35CpgnmJ9nD1ZYVJK8XXawNvuPSG1Dw0D5r7
         UT5V+3rUB1zB2sa4qIYMgoq6MpYR/sSAIwZtA/WBfkvc0/yJaob6TPrK9tet0Fh1qOlp
         VtQEcbS/e6YgeHVNLgbdWQbc0K2xi9DS0LdUVSC1Cy9CFx34AWJkcoQjfVe8op5oFQPF
         EcXKDdkIGPXIGwZP1vlCAxsl1wfysYkfrhKceQrnPxTzNUsQw4ZxRxKxhhOQOU8HLs+/
         370A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj4ShWl/W6XVIrTFJyttrtRVjDkB/tCBxscsEA35xfM=;
        b=omnWhTaO8XYSehyGMOjDMRZsuvTG/yog+j6HxI6C1bn3AJUasINpwpUI+/EPUEOswY
         rWYYe89ajyvNuQpl9AOf2JwYHMqfulyEd4RddQAZDlm08o3bIUgn21Vf16dkhIG5aEBb
         IL/Ukvdvk93ExuSgcLkgVhM9eVKp/gzG8e4rWyXaT0OG6X25Xqku7b8VgscT1Sr5HtML
         ZeItqvAJTQXglPero9EQvZU/RgXZRninnIObHmJd5QrMT79QKU2NRyNp2xv4MeURPzt6
         USlGujiKqPZSJEjxx6gijgIvAT3hmdlhilRh+U0ah3acKz4da76WoifmwpKoY2a5Yasj
         NEPQ==
X-Gm-Message-State: ANoB5ploQCoozCzdMmzXsFaxTiuqciMGVnGp82zBf/YUvJLplmotrRuz
        mrdEtDMviY1Ek92cLVhJXVlqVg==
X-Google-Smtp-Source: AA0mqf4ONuYy9VuHFONHH5wUXiH+6i3Vv0pKNb3mo2qL0th24zSzflLF4iBl57omeNZlzULBBub5Yw==
X-Received: by 2002:a05:6a00:1a88:b0:562:bcf8:7b35 with SMTP id e8-20020a056a001a8800b00562bcf87b35mr1584725pfv.52.1669030555753;
        Mon, 21 Nov 2022 03:35:55 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090a120900b00218722ecac2sm7979598pja.18.2022.11.21.03.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:35:55 -0800 (PST)
Message-ID: <71571dd9-65a8-4ccd-3fe5-88c22dd5b492@9elements.com>
Date:   Mon, 21 Nov 2022 17:05:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] hwmon: (pmbus/core): Implement regulator get_status
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221119182517.2334156-1-Naresh.Solanki@9elements.com>
 <20221120141432.GA1790249@roeck-us.net>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221120141432.GA1790249@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 20-11-2022 07:44 pm, Guenter Roeck wrote:
> On Sat, Nov 19, 2022 at 07:25:16PM +0100, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Add get_status for pmbus_regulator_ops.
>>
>> Changes:
>> - use lock throughout the function
>> - Avoid line continuation upto 100 column
>> - Optimize use of & and | operator
>> - Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
>>    respective status register for fault.
>> - Report regulator current status.
>>
> Change log should be after '---'
Sure
> 
> Also, when looking into this, I realized that we already have
> pmbus_regulator_get_error_flags() which has somewhat overlapping
> functionality. Would it be possible to utilize that function to get
> the error status instead of more or less hand-coding it ?
Sure. But looking at get_status scope, I feel that we are already 
checking the following:
1. Check if regulator is off & yes then return off
2. If not off then it should be on & has power good then return on
3. If no power good then this itself is error condition so return error. 
Decoding status register for fault just double confirms that & may not 
be needed in get_status unless we are going to print or utilize the 
error bit information in some other way but that is out of scope of 
get_status call unless I missed something.

Does this approach makes sense ?
> 
> Thanks,
> Guenter
