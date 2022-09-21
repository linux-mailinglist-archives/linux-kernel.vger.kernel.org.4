Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A345BF675
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIUGgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIUGgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:36:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1078049B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:36:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so7562247lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yH6iLbkmU8vuQx6J49b2UpdkQWSvaC4UtePhwuwHlXE=;
        b=LpfGpU64avQ4ZPWZSpfWPbK2+LJJzUu/PqXloCUs0pR9Ux6YCFG9k9q94Y+F9XxnHX
         QOppRw0//6+5sxN4binVSZVdyaz8F2/Ire/2PoIaxFu34ycYW9auIJa25jotMOZNmSD5
         1ooFg4LuJmtiWSgxyXSM+cSn4MqjciUeIXy3HZxnyIQBtrfNpnujCL3f6H1AlZi1uJu2
         f5Q0KbaIbjd+cePfqgR7nxQ1kZ0B7FnnatQ0tVyVIzjmLOsDjsmYOqQT3O2YvEI/iK7F
         tts1OHbGVSbzUFHsLv2wom7BfQLx+WhOEClLO8yD+e/fFZmda5rvXtmY2b4eCWrvEqi9
         EaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yH6iLbkmU8vuQx6J49b2UpdkQWSvaC4UtePhwuwHlXE=;
        b=leYprGTcM9bfuRhAklJoMSUZ5CZ33wgtbwHqPkjIzvKE8VJqr/sCt5JErAUsipWYGo
         d2fF0k4EPNJDnZjlfNtkmpXUYooE8PVB7JN2GUx5/1MuVGq0vZhSK142fxOgylaBCztY
         Xfi0YPWeUlbi3c+XRV2LURg7koV/7CnJJKVWCYksKl/rxlWJFvkXQo/gkSldmWz6Gq6m
         y505bSAze0J5lpH9WpAi9PG8DOnICPzrtnHXwwnSKlEgLxdU4QGZBJzFxadRBsSSKDU8
         +q9lCHwxNSNFt20Xxg9ofODbeTGHzXs7Hbi7NFx+HfbO7Rs2Q5lB+cIbnzxi45GcBu85
         Q0yw==
X-Gm-Message-State: ACrzQf10IrKjAiAuyH1D3ELCmvmpB5/jc1pPPO8u3qdTunfbM8CWNu3F
        e8MozXLdU153TxmTcYjQFVL/UA==
X-Google-Smtp-Source: AMsMyM59nFePana0jsoM3q3M+VQT7XIIowgjLYQMTB5rbMd81tjaDQ1tjFcDcNwLLnHRQ7H6roaANA==
X-Received: by 2002:a05:6512:b04:b0:4a0:588:5b33 with SMTP id w4-20020a0565120b0400b004a005885b33mr92323lfu.371.1663742205196;
        Tue, 20 Sep 2022 23:36:45 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f18-20020ac24992000000b0048b003c4bf7sm299228lfl.169.2022.09.20.23.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 23:36:44 -0700 (PDT)
Message-ID: <da0d5f12-78fd-b09f-d1c5-2df46cb98901@linaro.org>
Date:   Wed, 21 Sep 2022 08:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/6] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J721e
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        krzysztof.kozlowski+dt@linaro.org, Rob Herring <robh@kernel.org>
Cc:     lee.jones@linaro.org, kishon@ti.com, vkoul@kernel.org,
        dan.carpenter@oracle.com, rogerq@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, sjakhade@cadence.com
References: <20220914093911.187764-1-s-vadapalli@ti.com>
 <20220914093911.187764-2-s-vadapalli@ti.com>
 <20220914161527.GA2269201-robh@kernel.org>
 <d48e5ef4-6d5b-0977-ed45-de810e42356c@ti.com>
 <31028736-ba81-122e-b630-b66e9d9d491a@linaro.org>
 <2f830a26-c9f0-2902-302c-371c59994a6f@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2f830a26-c9f0-2902-302c-371c59994a6f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 06:56, Siddharth Vadapalli wrote:
>>> Thank you for reviewing the patch. Based on the discussion for the
>>> previous series at [1], I had planned to reuse the same property
>>> "ti,qsgmii-main-ports" for TI's J721e device too. The reason for this is
>>> that the property represents the same feature on both devices which is
>>> that of the QSGMII main port. The only difference between the two of
>>> them is that J7200's CPSW5G has 4 external ports while J721e's CPSW9G
>>> has 8 external ports. Thus, J7200 can have at most one QSGMII main port
>>> while J721e can have up to two. Adding a new property which describes
>>> the same feature appears to be redundant to me. Please let me know.
>>>
>>
>> The trouble is that you wrote the description like it were two different
>> properties (for xx this is one element, for yy this is something else).
>> You need to describe the property in unified way.
> 
> Thank you for reviewing the patch. I plan to update the description to
> the following:
> "Required only for QSGMII mode. Array to select the port/s for QSGMII
> main mode. The size of the array corresponds to the number of QSGMII
> interfaces and thus, the number of distinct QSGMII main ports, supported
> by the device. If the device supports two QSGMII interfaces but only one
> QSGMII interface is desired, repeat the QSGMII main port value
> corresponding to the QSGMII interface in the array."
> 
> I intend to describe the property in detail to help users understand the
> property and its usage better. In the process, I might have
> unintentionally made it appear as two different properties in the
> previous description. I hope the new description shows that the property
> describes the same feature across devices while making its usage clear
> to the users at the same time. Please let me know if this is fine.

Sounds good to me.

Best regards,
Krzysztof
