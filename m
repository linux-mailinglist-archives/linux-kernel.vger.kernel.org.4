Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619A26D073E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjC3NrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjC3NrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:47:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7EE9F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:47:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t10so76560957edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680184034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7heuTSxTseGx6DRd1J0KDR2xUe+BJ0nlLM1TKQLexsI=;
        b=eEvxUUcCgtdPkTaWnlq98JyD0YDBwGyNzMkarDDRXGioMx58qsAhiHXVP7Pm8k3ptY
         OQLxjeR882CPmERFLOTrQzAtlK29YMs0aqG8uQ+lcvpSXixQ4stGS8zpD/XENfBphQ9M
         dla9t94zuHDmU5ndx9dtNEW72X656Jadqf5ke/nKA6oGkTarWt/Dv458LWmIVlPbTD4O
         c+oIIN6lq+MQTT1UKYDeBnqJVODDkq2VNXQTrTk8XBkWmt2IKZ52dA0uLZA78cMXJZzw
         XNqWWUdQ3veIon5RS4OQ8LowOhgBJka6wvwuYvuHMEHsezcUn2YNjfCG3UwzG+5qgWYb
         QExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7heuTSxTseGx6DRd1J0KDR2xUe+BJ0nlLM1TKQLexsI=;
        b=W3CPcV3AUnqirb0Wy7Er4YKCWhVgMFL8w4vQcQZfntoXTUVQPXRoMnG7jIkD3fA1xK
         8DJv7BgDRCf3veqsMJ8ruboDX5J20G/as6xBou/6jYSLIsu8xjWR5cv4cOYJJD3BD3n4
         ZqkckbzKjuGja2UD4sojCQw7y2vRD3EmgCInnZ91vr/YQId1gIFs0eyX0WRFkar1b2/r
         Nx9o/HYLW5J+5AAgb3X+dzcQH6ktllE/7zKfNjJxADMZH/CljvS5mCXmSXG4YG9BrkS/
         cvgooKT9JiMCYeQbzVsYPlaF4GncSPH/Ia3TKLtxCACuGNNSO+48Lj6MmpUpKrPE3XPF
         pbiw==
X-Gm-Message-State: AAQBX9fiyOU/nMhN0U6C3R16SdwNG0FskA9xINhRuwv2+tNqffcZQxi4
        kj8Qn3InhNd2byqaj9vc3n4uoQ==
X-Google-Smtp-Source: AKy350avsdzd2DtKve0wHEmyKWZ5v7Q4Wzltkvqn3YQnOvRP0aU79AWzKoxvtbhSShhNLd7Mz298RQ==
X-Received: by 2002:a17:906:801:b0:92e:efa:b9b4 with SMTP id e1-20020a170906080100b0092e0efab9b4mr27892658ejd.22.1680184034684;
        Thu, 30 Mar 2023 06:47:14 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id u20-20020a50c054000000b004aeeb476c5bsm18060637edd.24.2023.03.30.06.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 06:47:14 -0700 (PDT)
Message-ID: <1f3d50b0-0528-befb-4fc6-8b5a96fc41b6@linaro.org>
Date:   Thu, 30 Mar 2023 14:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RESEND][for-stable 5.10, 5.4, 4.19, 4.14] ext4: fix kernel
 BUG in 'ext4_write_inline_data_end()'
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@kernel.org, stable@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, boyu.mt@taobao.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Ye Bin <yebin10@huawei.com>,
        syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com,
        Jun Nie <jun.nie@linaro.org>
References: <20230307103840.2603092-1-tudor.ambarus@linaro.org>
 <42739df1-8b63-dfd6-6ec5-6c59d5d41dd8@linaro.org>
 <ZCV6I-CBHVw2GPre@kroah.com>
 <661ff1fb-ab0d-e0a3-693c-073443f556df@linaro.org>
 <ZCWFx_iRPRr1Afw0@kroah.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZCWFx_iRPRr1Afw0@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/23 13:51, Greg KH wrote:
> On Thu, Mar 30, 2023 at 01:21:55PM +0100, Tudor Ambarus wrote:
>>
>>
>> On 3/30/23 13:01, Greg KH wrote:
>>> On Thu, Mar 30, 2023 at 12:42:27PM +0100, Tudor Ambarus wrote:
>>>> + stable@vger.kernel.org
>>>>
>>>> Hi!
>>>>
>>>> Can we queue this to Linux stable, please?
>>>
>>> Queue what exactly?
>>>
>>
>> The patch on which we reply:
>> https://lore.kernel.org/all/20230307103840.2603092-1-tudor.ambarus@linaro.org/
>>
>> Shall I do something different next time?
> 
> Please resend, your commit message is very confusing and this patch is

Indeed.
> long out of my review queue for some reason.
> 

Replaced the blurb with a 2 line explanation in the [] section above my
S-o-b:
https://lore.kernel.org/stable/20230330134233.3407390-1-tudor.ambarus@linaro.org/T/#u

Cheers,
ta
