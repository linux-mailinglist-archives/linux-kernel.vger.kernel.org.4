Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02168BC64
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBFMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBFMIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:08:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA30114E94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:08:12 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i5so2972051wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 04:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmU4cUw93QoE4h7oX6k5SfP7VHgqLh62OEyhjT4wVP8=;
        b=Ni8+xUZ3mafWJiQ/wLY6Geib7YEH7K2AC5kCqZ+JTeGMmicPeFJ6hzw832SQdyv3cd
         GMhX6/lDx28BrWFVAiawpQeogNRfAu+GgExT3KYDZHd7hi5trQlbRDm4pdbO4KsFBNDy
         8H5MTqBeArJXSn9W2ISmHmpqm5+6oplEecq/eOJuTQZDpdgfR87ZhzJTGjFtmjgqcv1Y
         gj1zOCl3xtc36SovdkuCUJ+FaATrfMiCC8gIzsU6NW8F/ljWD3AYQJWTyIUc4itr4zhw
         F7NTg5imlwM+qweIXM+ZME7zSp+5VPTyBkswk5ntXFt8LamTNJLbG32Ai/kxYNiA/sdA
         e9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmU4cUw93QoE4h7oX6k5SfP7VHgqLh62OEyhjT4wVP8=;
        b=HQXcJdB12MQaid1dkzmqOFRSbJ42cughmZP7n9pBMnsBqv6euYzk5xAxN1yAOQzhnk
         ncQDZ+jMe+U05e6ep0joepTLBYTxbKD9TtE+HMpKgg/DGNrXKR+veVFhXnCF8J0gVfMW
         wghGIpIQzg7+PX9EqXXeFHk5BonDMOAZlAbNHm2ZrxAAVAaNegVMGUF3afmmsHS5gsUG
         zyLD6muJGg0XGlpuzQ6OY2HtQ42xmBK+h9JYW6VUeVm/O1Mc4Frj1CKwTkn/u3qqJfyF
         WEdZMVRVUaDFpk9AkpHFWMmT19qi5tzTz6pIAvUQ6Hl8U5QqKXvLp75BauX8CBjx6YL6
         Dang==
X-Gm-Message-State: AO0yUKWZEPOUfWzlyRx4mcxyujuQ96B/QtfRqXDFTxkS3giw2D9RMAlQ
        nevi//zOf8opDx76uZ7TerBZy2D1+ON+/ACB
X-Google-Smtp-Source: AK7set9M7wMcnISexQ3dNo8gIHt8/hl45Ub6FwwT11q2ei8QyMYj6F/FiDSNCR+u6yQlYLWZ8u2oIA==
X-Received: by 2002:adf:e192:0:b0:2bc:846a:8ead with SMTP id az18-20020adfe192000000b002bc846a8eadmr18206689wrb.37.1675685291427;
        Mon, 06 Feb 2023 04:08:11 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j8-20020a5d6048000000b002bfb02153d1sm8698009wrt.45.2023.02.06.04.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 04:08:10 -0800 (PST)
Message-ID: <b16d137b-56ee-5aa2-346d-8ab02d590bf8@linaro.org>
Date:   Mon, 6 Feb 2023 12:08:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH 30/37] nvmem: core: fix
 nvmem_layout_get_match_data()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
 <20230206102759.669838-31-srinivas.kandagatla@linaro.org>
 <Y+Dst2V9mfJbVrzD@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Y+Dst2V9mfJbVrzD@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2023 12:04, Greg KH wrote:
> On Mon, Feb 06, 2023 at 10:27:52AM +0000, Srinivas Kandagatla wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> This function was trying to match wrong OF node (parent device's)
>> against an of_match_table. It was always returning NULL.
>>
>> Make it match layout's OF node against layout's of_match_table.
>>
>> Note: __maybe_unused is needed to avoid:
>> warning: variable 'layout_np' set but not used [-Wunused-but-set-variable]
>> (of_match_node() is no-op without CONFIG_OF).
>>
>> Fixes: 61a093b4a0e0 ("nvmem: core: introduce NVMEM layouts")
> 
> Nit, how can you have a git commit id if you are sending me patches to
> be applied to my tree?
> 
How should I deal with this situation?
I apply patches to nvmem-next tree and developers fix issues on top of it.
On the other hand I send patches as list to you to go via char-misc, so 
the fixes tag is really not relevant to char-misc.

Should I drop those fixes tag before sending it out?

thanks,
Srini


> That's never going to work, sorry.
> 
> greg k-h
