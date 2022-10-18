Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4203602C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJRMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJRMp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:45:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B138C4593
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:45:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a24so9494744qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWxKl23w6XMI7+5jEn1eePKGLm8+GZam2TRBB7nw/fU=;
        b=GZcjHVztgYOJHB6mAJbvi8Th0/QGV94wcDkolAkngJuS8QoerJe/nBj/jmhdKXQzrX
         gqxH1ttIA+M2ExM5khLwidXF1/n+PyXFRUjlnHq/rb2USCzW5TVrqRiGQrHZnVNWSixh
         DzWnw6w8R8yrmfFh8JTGIz8IwATL4WA1MNANq3VNOii9gPuWK0eARjbBA2wNeMeKusSE
         bwpRqROC7gfCVP9ufJEEfi8AblrCoUuGkCV+dFZild+XlG3GEvpT9+yg1aZ1jSeiuAAK
         BeXrzEdSWQoCpJScpb7wGRinN+6jIxuWmqxlvSV7uRlUDhHm2l8H+TsX2/bZSx8f6LQ9
         T+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWxKl23w6XMI7+5jEn1eePKGLm8+GZam2TRBB7nw/fU=;
        b=64n9Nc8Uo9rkxrbqyRL714MKeZDvHw0xVXkCKLXLpAT7eAPuOydB6o9kUio6FHfO9D
         /328vRXO8r7qbkGyDBSclO9tHbwIlKUrEee+AOlZRANW17+HGl6duVgbt23krXts2c6s
         ucjJ8W3H8F2g0v+GCir8LoHbfDI2y8AIObFXiPBUHO8jSCTXm5jQuOeslEmE5oNx5N/V
         OPW0bsorj2R5K9Ze2YfDu4yO/0e1PjtsuKVGQoluz28WpdCAsdLRzGKPenzQQ07Og2s5
         Z/79MbKIVCOSkwObmbHlg14JWOwtoOLr8/DQCl25Hxm+xq9e7BXfG1/J4MPLCCDwvF4Z
         pR+Q==
X-Gm-Message-State: ACrzQf3n6DQLFfAy09yQJNFGHyPEz4ZYpPjklojWsJ1zKwcicOn3jfhg
        cVjaLh9gmV6dJzemtKQy9lw98Y7Qf8a9Yg==
X-Google-Smtp-Source: AMsMyM6Vm4QBG6EQYbErftl1Bfd4F9lOWC02IlvQ57Iue1RblKX7llB4Nn053ohiLxXnC+/4oqWTsQ==
X-Received: by 2002:a05:622a:554:b0:39c:ef65:bc66 with SMTP id m20-20020a05622a055400b0039cef65bc66mr1892322qtx.550.1666097152810;
        Tue, 18 Oct 2022 05:45:52 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05620a17a800b006bb78d095c5sm2212951qkb.79.2022.10.18.05.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 05:45:52 -0700 (PDT)
Message-ID: <5f9515e3-aa46-eba6-4c2d-9cd4d2e585aa@linaro.org>
Date:   Tue, 18 Oct 2022 08:45:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [GIT PULL] memory: late (3rd) for v6.1
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20221003073237.11488-1-krzysztof.kozlowski@linaro.org>
 <79d9b77f-f7e1-61d9-2e86-301f07a03721@linaro.org>
 <0991a91e-384b-4be1-ab41-e29f8ad88d84@app.fastmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0991a91e-384b-4be1-ab41-e29f8ad88d84@app.fastmail.com>
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

On 18/10/2022 03:18, Arnd Bergmann wrote:
> On Mon, Oct 17, 2022, at 11:51 PM, Krzysztof Kozlowski wrote:
>> On 03/10/2022 03:32, Krzysztof Kozlowski wrote:
>>
>> This was a late pull and missed the merge window. It was based on
>> previous pulls. Shall I rebase on 6.1-rc1 and resubmit?
> 
> I'd prefer a rebase to -rc1 before you resubmit, but sending the
> same pull request again would work as well.


Thanks, I'll rebase.

Best regards,
Krzysztof

