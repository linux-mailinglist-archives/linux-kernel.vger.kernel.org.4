Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206A766E299
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjAQPpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjAQPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:44:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B4842BEA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:42:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b7so5025117wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wMLUDIH2u9/pswBqiZWKFr3YnA0VJ7DKRwdJNPTORM=;
        b=LwL7rLSiam2L1sRGB+ZIu3nfA6uXxCQPSTYuV4YH3BBDd2kwVeuGY+hM8hs8nRDj8i
         qm6sHCSdaVMk3UigPhL3EWXrqzfj6G71+byWdSPqCGxH+O4mUljcLgU7sb9IHyQIffZN
         IPO7Z7omHXiHdToy1KLVUm0b5axR40XrVkUdeiCRN/RRfeElZbenYDHg7kDv5Av8OJ5w
         1DK/sd3bTNLNpaFNL+zO9RC0qg3dy/irgFQEQiJID5RGMKgooUPP5GOdj3MJp56ytH+b
         ybMqcoZHId+UTsZGZ85tmZIQMFKJYBeFMcPEU4mnriuvdaVrzC/2LqMwxWubUwF/ZuWZ
         ssLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wMLUDIH2u9/pswBqiZWKFr3YnA0VJ7DKRwdJNPTORM=;
        b=SZDSembUxtXkLUqN22AAeOmKo9OMBOSt9f0zDpAC3bNR6aGjesj1HmA3B8YqfV2huf
         zmf2WpOpyq3qnfMJPJX5Yata/kojUqNLMlAdbEqd1nRXIje7i2/kW/igx0AtZovyU58k
         lSCqEgHQZfR7brVDOiUeS5NCNaTP1+7g/tJvE/KB2g6H3CY26T0bzG44/1W6JyzYefvN
         rbHhisPrI6pog0D7F+mXvqVFySmXrjqfrzzV4Z7KNWGhpaPagLfnSRWaLCe2f7bFipXq
         LDJP/C2gyL7B0CKr8r8NsGguQh8Go3wF2VBYayEEA7hq3hh0ziCsbZMa7q3kLV37KtGE
         Re9w==
X-Gm-Message-State: AFqh2ko3NF7lvZasz/XEz+nhwH3Q3mSNlXlegTsHcG6iu6BUsirgq/or
        clo1/l0gIfLlv8EEf4iIK1t4dg==
X-Google-Smtp-Source: AMrXdXtVgF8A66wqa/DHWKmBZ9PN3w6XmvV7QPpBfZ5+cE0/rHWN72iynsEjUXXbxMyfFfERBjUw3Q==
X-Received: by 2002:a5d:6e91:0:b0:2be:1ea0:f794 with SMTP id k17-20020a5d6e91000000b002be1ea0f794mr2623740wrz.52.1673970174528;
        Tue, 17 Jan 2023 07:42:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d4e4c000000b002be1d1c0bd7sm2215180wrt.93.2023.01.17.07.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 07:42:54 -0800 (PST)
Message-ID: <d1bb1148-e273-f5bb-bccc-ceca82bb6836@linaro.org>
Date:   Tue, 17 Jan 2023 16:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
 <Y8a+Hk2jFOjbkIvZ@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y8a+Hk2jFOjbkIvZ@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 16:26, Laurent Pinchart wrote:
>
>> +
>> +          clock-lanes:
>> +            description: VIIF supports 1 clock line
> 
> s/line/lane/
> 
>> +            const: 0
> 
> I would also add
> 
>           clock-noncontinuous: true
>           link-frequencies: true
> 
> to indicate that the above two properties are used by this device.

No, these are coming from other schema and there is never need to
mention some property to indicate it is more used than other case. None
of the bindings are created such way, so this should not be exception.

Best regards,
Krzysztof

