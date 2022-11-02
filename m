Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551226162E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKBMou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiKBMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:44:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE82A42D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:44:39 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id o65so14892693iof.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJo91bgThDZYuB3vQ95X53c7qStB+JG3e9Cb+LQ28g4=;
        b=eu+6eNC2KNy9tJO7miJCz9Bz7xwutFsz8mb3HbpuHr2tVwu2CBIfSRUWMqFwI1NSkG
         AbczpR8JqXwnPlYfbPW0v9xu2eI0n8qnrxZnlvBCHbpVQaKRKoCU3tcjJ5DaEFrxvei3
         gaqS71r9TrfL1+XGJdAhbmR9kNc2bIll8tIcgUHOMYelprOJDpiUSwA4nvr64j/HrMhJ
         w0rQNHaqe/dcMzhWf5Ga1fyuqKYnvi+iww2vjlQCGTTyFblmAJ0boNZG1AgW6i6IpQMG
         hBTt6pidMW5cqrdGiQ/xgDkwPMaRSIeFzafLNljBTUOWf0vecn+RrW1ETbm96Wrh8PY2
         9nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJo91bgThDZYuB3vQ95X53c7qStB+JG3e9Cb+LQ28g4=;
        b=GqfUqcTYUBnadXC1PTwQpKIb6K+7Zsejffn73JJyLRuJxG+d/dQiPlXlqfHTn/o87d
         NUWltZxQU0Fpe8xsmb8eNrO8/Tau/hnJP98WPN8tqNd/XI29RRnohXsT4wu6+fUcjnZE
         fJnZknA21XbB14M7U4fk3pyWECMhS7ab4fnLYE9J9Nc/z48bYKBDvCKB0FvpS3iJwbyx
         ggE66Lcyr7jxCVo6bn1XOluGi12aL/BTH+nPHcCtrp5h+Qr4wYt77EJ3aHZZtf2l7KXz
         342BLXCq4AOEgLhFv8+QCeholaNJ/BmSeL/s0+r+VdmSqNSRW7uHY5xKjwEgTelbr7Cv
         okKw==
X-Gm-Message-State: ACrzQf3UygwnJRYj+omHqtAIWDyn77C76Y2N5zf1Hfg61y4z0IWV890e
        RiVxk9HGcrhUteKC7qnHzHKqjw==
X-Google-Smtp-Source: AMsMyM4kCjiARMSuxz+HYP8JVizh7CfbjS53Gov9bfb7Fx5trPZC4UQW7cykCO2KseaAdBfRWiTP+Q==
X-Received: by 2002:a05:6638:1450:b0:363:7052:9c30 with SMTP id l16-20020a056638145000b0036370529c30mr15761229jad.53.1667393078374;
        Wed, 02 Nov 2022 05:44:38 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id r11-20020a92d98b000000b002ffdb341ef9sm4442119iln.88.2022.11.02.05.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 05:44:37 -0700 (PDT)
Message-ID: <0ba56650-e1bf-5a8f-86cd-8406f3dc75be@linaro.org>
Date:   Wed, 2 Nov 2022 07:44:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH net-next 9/9] net: ipa: use a bitmap for enabled endpoints
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221030001828.754010-1-elder@linaro.org>
 <20221030001828.754010-10-elder@linaro.org>
 <20221101213404.3e4c3b8f@kernel.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20221101213404.3e4c3b8f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 11:34 PM, Jakub Kicinski wrote:
> On Sat, 29 Oct 2022 19:18:28 -0500 Alex Elder wrote:
>>   	/* Set up the defined endpoint bitmap */
>>   	ipa->defined = bitmap_zalloc(ipa->endpoint_count, GFP_KERNEL);
>>   	ipa->set_up = bitmap_zalloc(ipa->endpoint_count, GFP_KERNEL);
>> +	ipa->enabled = bitmap_zalloc(ipa->endpoint_count, GFP_KERNEL);
>>   	if (!ipa->defined || !ipa->set_up) {
> 
> This condition should now check if ipa->enabled

You're right.

> And the error handling patch needs to free it, in case it was something
> else that didn't get allocated?

See below, but in any case, I'll make sure this is right.

> Frankly I have gotten mass-NULL-checks wrong more than once myself so
> I'd steer clear of those, they are strangely error prone.

I don't typically do it, and generally don't like it,
but I think I was trying to make it look cleaner
somehow.  I'll check every one in separately in v2.

>>   		dev_err(dev, "unable to allocate endpoint bitmaps\n");
> 
> this error message should not be here (patch 5 adds it I think)
> memory allocation failures produce a splat, no need to print errors

At the end of the series, the structure of this
error handling changes, and I think this is
correct.  But now that you point this out I
think the way this evolves in the series could
use some improvement so I'll take another look
at it and hopefully make it better.

I don't normally report anything on allocation
failures for that reason; thanks for pointing
this out.

I really appreciate your feedback.  I'll send
out version 2 today.

					-Alex

>> +		bitmap_free(ipa->set_up);
>> +		ipa->set_up = NULL;
>>   		bitmap_free(ipa->defined);

