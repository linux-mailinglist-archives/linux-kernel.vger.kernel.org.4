Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C41162DC47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiKQNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiKQNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:07:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66556207F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:07:10 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a15so2603504ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTMuaBfKCMZXSl9LUyd4MIB5DqyeQyzncHYThdTUxqc=;
        b=FrCOZ6nVXao0w5awL8iRMvlXfEYyNRkTaPpnAujQjsIOw03r6wIvF6HBvR7ZDd2EyM
         aCROBjtDlRd7G2k4+P4mJDkl1uQsNj2IONW5BiM+a+EJJr9QP6N39PZb0eGaJs8awrB5
         qIkMrwWAJCjpRU2gWSG40wnLdTjg9i17NsQ6jaS0gOAfDwgh/zns8o1ittbgVaTQ01b8
         4xI+m78UCRp63u+03o1okyoXjzbYlAK7QqX2TYZeDmBhlvcWGyLjJQXVi5au8TLqasBu
         3/RlO4q7QDNVwdhP60FwiXTeqNIaJSvEBIJHTRn1Oq1xJhLCAGVz7G4pjI7J4M700S+V
         UAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mTMuaBfKCMZXSl9LUyd4MIB5DqyeQyzncHYThdTUxqc=;
        b=GGLUZVZt9sOvxav42nRXEgw4h0zyGJNmUvvNvLo2Fx3zoMyvaxx0ZIs/wNifF26OBY
         K6rXS1o/XQ01n1l5izF5E7JBASqO5rgB9P0peQTcAJ/LolnAdiM/iAO285VMO02HUqnl
         U/DTMHCI/QMH713it3GCH72J/5re5BfQJJY3GumZ5RzeMcrgJqNBN++SFfNEbkHkxaVF
         hc50LI9Wq0u8yQJMDBqMaAnuOIXui0Fea9s3qWQmmzZsU64D1HjXODJtWDaT4IX3mDPb
         2bYjANv3J7EDr95it9Opiv+ufNxBuPh5J4Y19wEIKjyW8QWa9xh0TSuBYIgFlKn34+9g
         Ibhw==
X-Gm-Message-State: ANoB5pkfU/uKOLsKu8VvjsPopJQlTqiwPIPPcbjlxXZhWsifrIaNed2y
        rtsrxOkeN6zJa905sQ8y8O9GVp53233FoQxO
X-Google-Smtp-Source: AA0mqf75w4xQTmMedpWhD/8OvEx6h6E/KKGgAMpDrEd5hZKxX3G1odg3r90a7WzY1EkIFjWmWmh6sA==
X-Received: by 2002:a2e:a58b:0:b0:277:278:de24 with SMTP id m11-20020a2ea58b000000b002770278de24mr928223ljp.388.1668690429153;
        Thu, 17 Nov 2022 05:07:09 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id j7-20020ac253a7000000b004acb2adfa21sm136918lfh.297.2022.11.17.05.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:07:08 -0800 (PST)
Message-ID: <306064c9-1b8a-03e5-97b5-6cb2dbb6d8a4@linaro.org>
Date:   Thu, 17 Nov 2022 14:07:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add SM6350 GPU SMMUv2
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117094422.11000-1-konrad.dybcio@linaro.org>
 <20221117094422.11000-2-konrad.dybcio@linaro.org>
 <77805b04-2724-dc93-eae7-21d9c7caf0a4@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <77805b04-2724-dc93-eae7-21d9c7caf0a4@linaro.org>
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



On 17/11/2022 13:55, Krzysztof Kozlowski wrote:
> On 17/11/2022 10:44, Konrad Dybcio wrote:
>> SM6350 has a qcom,smmu-v2-style SMMU just for Adreno and friends.
>> Document it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> (although this might need rebase later on Dmitry's refactoring)
Oh, I forgot to mention this patch was made on top of Dmitry's work. But 
it's good that you pointed that out!

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
