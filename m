Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA026F3D94
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjEBGgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjEBGge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:36:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB532D41
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:36:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f32588c13so568941666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 23:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683009391; x=1685601391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEihoYElpiA1xR8/uoGmOyLMqKO0DpcNQ2I0d88KJzY=;
        b=xGqj/xlzMXdk4R2wQNsjPm2d6UP+IXIGS3ezzL4b0hINtAp5LS+wWsYVX4dQ4GtSmd
         jTqNGLYHkrm5sZR+VZAmKn1lRFbHCBSzLrLLMybnSIx8XqxpgSTYjLImVB1jC7acvELZ
         z09bboJRl3PTObri32XKFvp9J17UVNj5wWqmhl2odhfh5scUyC7kf+1L2gyMF7LHpTB4
         4mhN4lIarimyDWQrxyl4MPBk/J+ciiSRQuNFqRvZz3m+aOkPHSLv0c0pQabjT1dHILwo
         +3cwr5Huto+VxcRicSI715bf6tsgbt4QTYfXXI59tJstIiyJZBLNBJZV05a5QcsW0Sb6
         LYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683009391; x=1685601391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEihoYElpiA1xR8/uoGmOyLMqKO0DpcNQ2I0d88KJzY=;
        b=EOhFJksqleRcCBMVc4BmbVD6jN990xzcktzJUanAs86zVWgyB/xyoM8BuHD2jZ9TuU
         oM+MHsLL3eAdctVzw1DCKjpmNOI9oqfAt8/E5YMaV0OBFAd9x+KIMkZMuKsrWKo2NRtL
         W+PnO4nrs1bWrZ8gYm3bAW+aq0U0I+z7nMUu7OLubX0Rywi2QdPdQaoVFrIi+owEXSaJ
         5JiXBrFIMuSqM1N/Y099dIc7JVil9Duu5nRQVTm/jLdvRKQZgASR1qmKRNZqALS0vgoL
         lTKmQgM/VhKck6+csa4YwLQGjbhvnADLRxVr+3icNdik1kpYWlQ3LNX+Zma8jMMEXUCT
         8l1w==
X-Gm-Message-State: AC+VfDxfz3h7GRjSpj7RqSYuSaZ1BHFcl21fTYKRpIiFljTi+Vh7mLTD
        xg1ogvZjOj+IWCZ5eG4BrbcmYw==
X-Google-Smtp-Source: ACHHUZ4Skvp/4abrSsBYGQDALtzu6bFNcxFkgFuUA4v0JLgczKgKwpmnwqF4FYwIye4/qQBhlXJ7Hw==
X-Received: by 2002:a17:907:701:b0:961:800b:3f5b with SMTP id xb1-20020a170907070100b00961800b3f5bmr5035623ejb.20.1683009391264;
        Mon, 01 May 2023 23:36:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id lh21-20020a170906f8d500b0094eeab34ad5sm15643867ejb.124.2023.05.01.23.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 23:36:30 -0700 (PDT)
Message-ID: <07c36d46-76c0-1bad-a124-55b96aff8347@linaro.org>
Date:   Tue, 2 May 2023 08:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/8] regulator: max77658: Add ADI MAX77643/54/58/59
 Regulator Support
Content-Language: en-US
To:     "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-3-Zeynep.Arslanbenzer@analog.com>
 <ce89857a-53b3-d63b-c1ad-5d28fd7d8f80@linaro.org>
 <MN2PR03MB5197DF4EEA50D6CB5DF311098B6F9@MN2PR03MB5197.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB5197DF4EEA50D6CB5DF311098B6F9@MN2PR03MB5197.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 08:32, Arslanbenzer, Zeynep wrote:
> On Wed, 22 Mar 2023, Krzysztof Kozlowski wrote:
>> On 22/03/2023 06:56, Zeynep Arslanbenzer wrote:
>>> Regulator driver for ADI MAX77643/MAX77654/MAX77658/MAX77659.
>>>
>>> MAX77643/MAX77659 has 1 LDO regulator.
>>> MAX77654/MAX77658 has two LDO regulators.
>>>
>>> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
>>> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
>>
>>
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct platform_device_id max77658_regulator_id[] = {
>>> +	{ "max77643-regulator" },
>>> +	{ "max77654-regulator" },
>>> +	{ "max77658-regulator" },
>>> +	{ "max77659-regulator" },
>>
>> Why do you need so many entries? They do not differ.
> 
> They are slightly different. Just MAX77659 and MAX77643 regulators have exactly the same features. MAX77659 and MAX77643 have 1 LDO regulator but others have 2 and the voltage base of the MAX77654 regulators is different from others. Should I use the same entry for the MAX77643 and MAX77659?

Wrap your email replies, it's difficult to read and reply.

Your driver does not choose regulators based on these compatibles. Your
of_device_id table claims all devices are fully compatible and do not
differ from regulators point of view. If they are different, you should
encode the difference. If not, use only one entry in of_device_id (only
of_device_id, not bindings).

Best regards,
Krzysztof

