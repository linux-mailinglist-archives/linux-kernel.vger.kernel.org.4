Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D606B9BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCNQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCNQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:41:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB62B048B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:41:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so64408817edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678812095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SsCCJzWTBiCPh1OsbG9kK3RWsvKGZ056pX9CV7XhZA=;
        b=jz3L9GpfUAqN42bQ+FcTiVeAwtE2XA7ccj8YMmams3WB19+ew1CZMsRhmve1uimWXX
         lOOUFFaxymTSywBgI5YbRFn2O+5WcvF7BkM1WDqHRDZFXq/8mq1j9Lekv+ub91NwBJQ1
         gsIDSwQzmybTLv60ZYBd9hpbqgpLAVN8zgXMZbiQXNs3lYiXeSaEdzPKgLptaEnktOsJ
         PQmHI5n8/539//UwrNwx9w0aOwAu2QbW3znCnmDxDl38jZaPZ7kpYLT3xKqz7sNMGwMS
         oYt56TtGG+Vl8fSOTd4SQebrhoudRvPBOwU7GpQSmWFMzC+qVYsRdI7+n08hLPumCPbP
         i4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678812095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SsCCJzWTBiCPh1OsbG9kK3RWsvKGZ056pX9CV7XhZA=;
        b=Ek6I7g5IJIIJvvb/5vB9Gql/GoVzAVMJojRLA1n1JwxEQYEdekLe9gt//XNlBC26aK
         f6XCZhiOZ+vGtTo/osWv437TrwbTXUtEoSph9Hw7irDxvvf8LsH9FVjIgCobPz2TnPAH
         DF6p2VzmJTklCfIxxcFKXvHlPHvWvUjEcaf4ICEXMW9uRQGvukKVqe9SUeo9kdvlyGPR
         JQwwx7H5tBhyt2ifvLMpmW9r02RSimruNFLd0FHXycygjSgIwUlDYhpcL2SxwOJ5cMAL
         pvOwwodmvR/rnL+6VRXqIt/laHEjmG09aPJRsDymGbNCYb5m++Nd/2YQyn6ZbBQsneUM
         kq4A==
X-Gm-Message-State: AO0yUKUBEnqqzQVOG198euhZpnd3YK4tdA323IUY5KvbP++fsYITLHO6
        3GzyciDMnPrlHw31EpKlaCwsuw==
X-Google-Smtp-Source: AK7set//SoqnRRnKaLi/E2VlDshAWGHEvIdc5wTaQLtFuAdBQoKbbNHYMSgUJptpD3CmMR27puqFBg==
X-Received: by 2002:a17:907:a0e:b0:895:58be:957 with SMTP id bb14-20020a1709070a0e00b0089558be0957mr4077263ejc.2.1678812095568;
        Tue, 14 Mar 2023 09:41:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id h1-20020a50c381000000b004c0c5864cc5sm1297077edf.25.2023.03.14.09.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:41:35 -0700 (PDT)
Message-ID: <ed2d01ee-4e64-396b-569e-e698ea6fd5da@linaro.org>
Date:   Tue, 14 Mar 2023 17:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node
 name
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230207234735.201812-1-robh@kernel.org>
 <CAL_JsqLitc8rX4aXomgXKSPcW8ejEYe1wB_ecyAg7pgJgR=zyA@mail.gmail.com>
 <c02f83c4-3796-40ad-8087-d297ba84e5da@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c02f83c4-3796-40ad-8087-d297ba84e5da@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 17:21, Andrew Lunn wrote:
> On Tue, Mar 14, 2023 at 10:22:40AM -0500, Rob Herring wrote:
>> On Tue, Feb 7, 2023 at 5:47 PM Rob Herring <robh@kernel.org> wrote:
>>>
>>> The GICv3 ITS is an MSI controller, therefore its node name should be
>>> 'msi-controller'.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Ping!
>>
>> If not maintained, should I send a patch removing this platform instead?
> 
> Gregory usually picks these up around -rc6.

Hm, so they stay in next for just one or two weeks before sending to
arm-soc? Why? They should be in the next as fast as possible, why waiting?

Second question, shall I drop it?

Best regards,
Krzysztof

