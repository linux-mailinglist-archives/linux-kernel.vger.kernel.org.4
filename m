Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB565AB0D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 19:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjAASz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 13:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAASzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 13:55:54 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A022C5B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 10:55:53 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NlSr80g0Zz1S5Ck
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 13:55:52 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1672599351; x=1673463352; bh=0xMvWBI
        uiz9YShYwSZljNHApB6B6Wuwiqzi/ogUp9MY=; b=M3pR354zqNM9i6J32IUzvDe
        KdZ5DqmwyPIztMwqXg3PM4rkHDNaKJqyC6aVlB7Pkd4TU8eWGppY/MBLJlidGRlx
        UZWcztJakQbiG16kKazdbp2FO9uC0LTZ6AslIGkOzGVhUMDTmZVyHaiXV/BTo0PB
        z/dgQ51pfn7yPLVJzklLQArRx1AKzTeYoIvK4xa7MDLgHbMTHzRrYTChBL8Kgkha
        ZEYFZ4Nz6x/ibyvGyzWcHK6EEnf+3125ZOVGSugkjK7C77c0gghNJaCRZHONuB+f
        JcvVNXh9vXmpeQmRQNpGdcbv/Ovo5BH2FomCrcCDXjaWS3udUl6FGdDHboD/NwA=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AI9dh8YC8Kcs for <linux-kernel@vger.kernel.org>;
        Sun,  1 Jan 2023 13:55:51 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NlSr26Hdmz1S52G;
        Sun,  1 Jan 2023 13:55:46 -0500 (EST)
Message-ID: <e4c110eb-6030-fd46-19ee-09543147c6cf@mint.lgbt>
Date:   Sun, 1 Jan 2023 15:55:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 5/6] dt-bindings: arm: qcom: Document
 xiaomi,laurel-sprout board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221231222420.75233-1-they@mint.lgbt>
 <20221231222420.75233-6-they@mint.lgbt>
 <396b0ef2-b3da-2c44-66a1-16d1b21ac6ef@linaro.org>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <396b0ef2-b3da-2c44-66a1-16d1b21ac6ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/01/2023 12:40, Krzysztof Kozlowski wrote:
> On 31/12/2022 23:24, Lux Aliaga wrote:
>> Document the Xiaomi Mi A3 (xiaomi-laurel-sprout) smartphone which is
>> based on the Snapdragon 665 SoC.
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However, there's no need to repost patches *only* to add the
> tags. The upstream maintainer will do that for acks received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>
> If a tag was not added on purpose, please state why and what changed.
>
>
>
>
> Best regards,
> Krzysztof
This was accidental. I've already fixed it so in the next revision these 
changes get applied. My apologies.

-- 
Lux Aliaga
https://nixgoat.me/

