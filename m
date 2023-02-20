Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C469CD6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjBTNtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjBTNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:49:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219D51E2B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:49:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id eg37so1127131edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49HWWb3cc/HZxywIb9uNzaTa/ku4Ssf3WpC18ssUqdM=;
        b=ASOr3MPofKHL4lTrFztPVZ8pYYkUihrtwv+jTcH3fIcIeAs8ABsKBTzL8f9ngHjeUb
         U6gCplTJOBDvXMTwk1lzJbAFFKEX2f3Pb56QFVyZ+ZEjZIa01FcuDR/2vVITDMjN08Ft
         Rg2lR00FSUpJTiBsnspJeDkinc25kFMmonYuKV3gTWOBO6qy4GDW1uLeoR9Qarnex70A
         plYYTdiATA4MgHqjb9TbXQb/Y36XejAZdjecpHxMZfl/0qRu+tmeR7QzrX9iU9sm9prk
         m5CNw0zF72qan+4DRUvJOWVnuV1E4wZdmYCE6RtutFBoEwKscppIpxmDDDv5YNmNBYgY
         yrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49HWWb3cc/HZxywIb9uNzaTa/ku4Ssf3WpC18ssUqdM=;
        b=kTKZdu1wIHC4xaE4SkdX2xzwbnKyCZQntdPTq+LHB9xnKLcNrLPJgl+o8XyZUAtGdl
         EhGu4fcy0EeTSlSIx3d/B6WhzD7NHSMlocio+TBouvDzcrle0ouw7DA8pOgHWWGLDwFI
         tdRP8WkaAQ4vwCriKSyleQVf5+AnPY1bS9jiBmjsAaGuDtwHiHPnb3NxmP5oNgGczFIo
         ORAJJkrJeL169PR0TSzde37bSnj6CQGXgYTqlTngrzhzYDfTe/ehjkoTZJBopSNmxuwd
         +VrSLA5n451/7DICAMlqhAX/T91gpE+HsznPDMoDHFcPnqs4ulYY9GdaeawoLS1C8BH/
         tUsg==
X-Gm-Message-State: AO0yUKXZxCPorrT15f1MnNhkA2h8XptKvHdjICOGiNEgKxO8iLR7e2DO
        nq8BBKigrQu5U35SpZZQsdZquw==
X-Google-Smtp-Source: AK7set8oqq9/YhAz+OGjQTF/zubGQ1QoCjgs2EU78K7J4oztgSo+kTDoPZezNu1KMlJmBBXskLceXw==
X-Received: by 2002:a17:906:ad82:b0:8b1:7eb4:6bea with SMTP id la2-20020a170906ad8200b008b17eb46beamr10504743ejb.38.1676900939396;
        Mon, 20 Feb 2023 05:48:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t18-20020a170906949200b008bfe95c46c3sm3124624ejx.220.2023.02.20.05.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 05:48:59 -0800 (PST)
Message-ID: <1d8b225e-19ed-f828-91b0-0cbc0a9e53a3@linaro.org>
Date:   Mon, 20 Feb 2023 14:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        jannadurai@marvell.com, cchavva@marvell.com
References: <20230123192735.21136-1-pmalgujar@marvell.com>
 <20230123192735.21136-5-pmalgujar@marvell.com>
 <d05161ed-eb30-2d4d-e9bc-4b40e8ae09e7@linaro.org>
 <20230220132214.GA24729@Dell2s-9>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220132214.GA24729@Dell2s-9>
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

On 20/02/2023 14:22, Piyush Malgujar wrote:

>>> +
>>> +  cdns,read-dqs-cmd-delay:
>>> +    description: Command delay used in HS200 tuning
>>
>> What are the units?
>>
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>
>> Drop quotes (everywhere)
>>
>>> +
>>> +  cdns,tune-val-start:
>>> +    description: Staring value of data delay used in HS200 tuning
>>
>> Same problem - missing units.
>>
> 
> These are integer values, will add in the description that these units are integer used
> in tuning. Also, will remove the $ref.

All units are integer values. We don't talk about this. Delay is usually
in time, thus I would assume here proper unit suffix.


Best regards,
Krzysztof

