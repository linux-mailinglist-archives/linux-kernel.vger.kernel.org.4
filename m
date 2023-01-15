Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A066B398
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 20:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjAOTMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 14:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjAOTMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 14:12:41 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114FF754
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 11:12:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y19so4538308edc.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 11:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ld9xL7wWYCmRMzhwzuxLkOblMkKoFA/qhkwrew38Pj4=;
        b=OwOVjyrid8zLZ7BV6ac1U/q23NxxVZSGzdQhrFYebdTjhRnJ59OOrvtoBHxTrx7hyg
         rftE9wZmoUi2Zj6yCNCkgusSu4DTp4PIV3UywzJ6ASvdbA17xrYmREPBDSX1e50mcQQf
         xBtG5m5LIEndFU5qdfq2C0aPa5nobVnAdiWvwUuTKNDOsPdCwGDKQ27HjgJ1MyGTsHDG
         rFPu+WHTUjCIMXIoISwUqqUsHLgAgGOy/hmBt9iZYu1DqB6XCbi0hFccRZ+AotfKRoOr
         kVMdvcX6mifJGwqGnkGBionL42KvpuuiN4RisrYon6GmxjIw6pFg+K0WP6Uf0vvTdk+C
         XLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld9xL7wWYCmRMzhwzuxLkOblMkKoFA/qhkwrew38Pj4=;
        b=PeVO3s736cuCwDWdm3DQZDaZHrxkb3F5tgtAoT3IUefsCGQ9NHblJkrNidZw8UEsRm
         MuFi9Bb/2qQJMEFo3wLJzFuDsXX5EwtfXcuBfBVTIbAe9J2cFTCyL/3Z0r8eVP79bedn
         Qmpgp8nYyzhHdJvwshyAQtCaQewOMucpyzwPV1eluz7VdIvEjkK+DFe099SPjeJut6K/
         W+i+uM88BcUKCW9VKLjrRiMUN/xKRBI9aqyvZrrBnbsa8jTQgEf/Rx/8d/r9W4dq1dcQ
         I3hpUug1va0W+nq4N3UyJ69aXbYTtE4nLG6tTzCFnkSL9lw3jlQwDJ7QeVP8Yt6ZE2qt
         FyCA==
X-Gm-Message-State: AFqh2kqaa7+RAjAa2OaRW+szslgAmajaD9wjBdnzKh3q/ZhxdLUSqw9J
        Cb6Rv6kkjkAZslnwA31OZKE9eg==
X-Google-Smtp-Source: AMrXdXvFg/pAJsxxOc9rpeYxzIe8eYXIZQV7fPujSfMj0zrCKe+Jvd4jv1G1kVAlGMinHyOXaedoPg==
X-Received: by 2002:a05:6402:414f:b0:49a:d3c2:c770 with SMTP id x15-20020a056402414f00b0049ad3c2c770mr16885812eda.13.1673809958522;
        Sun, 15 Jan 2023 11:12:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7cb8e000000b00499b6b50419sm7632682edt.11.2023.01.15.11.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 11:12:37 -0800 (PST)
Message-ID: <72600a64-00a6-fecd-61d9-b93ee83e0fe4@linaro.org>
Date:   Sun, 15 Jan 2023 20:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/5] dt-bindings: regulator:
 adi,max77541-regulator.yaml Add MAX77541 Regulator bindings
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221226223839.103460-1-okan.sahin@analog.com>
 <20221226223839.103460-5-okan.sahin@analog.com>
 <74fd9706-119e-c6c3-4c64-c7ee419ce4bb@linaro.org>
 <MN2PR03MB51688C9858CC8CA7CACCDB22E7C09@MN2PR03MB5168.namprd03.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB51688C9858CC8CA7CACCDB22E7C09@MN2PR03MB5168.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2023 18:41, Sahin, Okan wrote:
>>> +patternProperties:
>>> +  "^BUCK[12]$":
>>
>> Old DT example was correct - lowercase node names.
> Actually, I did not change this part of the patch. I checked other examples, and it looks like using upper case under regulators node seems correct to me. Additionally, there is no warning or error after "make dt_binding_check".

What do you mean "correct"? The convention is simple - all node names
are lowercase. Why this is an exception?

Best regards,
Krzysztof

