Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E85C6FB521
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjEHQbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjEHQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:31:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A24C0C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:30:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so7224226a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683563458; x=1686155458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XZ+bhPlwzWhayELXrhbCbnvtPJ+kW/neWtCZuaOEDA=;
        b=sQYiigymkSQGz1c3Eblx6BYBSksmvaD89TyiGKSydp4AZ89HLnlctiQ/Az6+OrnZZ1
         S1C2uEXRfm0qNIRH65+jq4V4I0lH7esWxFQ/3IHdgJVo1JToy9uk0dCyvu9f9B9WU4k7
         VrOuGknyH5fRMEfjUO0paWezryAEXfCe3jaFLojkQlSKfrfWEJ8MoxP7lp34pDDCgYe7
         UsRYkYnOZh4MSz5eliAum7uVdjkIS8PHIaKyfenSDJrSRYnzEEErwZOYbFHLWicu/KLm
         ZHI6umaEo7w7ghlMJH/yU6aiPspf1xFy6sRfN2waQ5giHo3ivhve63oT/LhYDBBPleAq
         HXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683563458; x=1686155458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XZ+bhPlwzWhayELXrhbCbnvtPJ+kW/neWtCZuaOEDA=;
        b=VfV6C2mzj7hU2gs/ASB8tBsvVsJWeWwdhV7STYvUHjXRjVkfVb1rhktxDK4BjBmVO2
         DK43T3A5jaIngt8Ae8cuaZDu+ikkAQJwLV9ZliQSqaVIdxyCruKFNg5LCvdNpcJJibKQ
         jOGgAmAOPQlrOJ2pt1y7MmNbA/CA193goOat4TwH/xVGGe+FZgm6YmxSG5vB50P0eB5u
         7gcY3RNZpl6UPsxOtKdN9JD1ZOHZLj3JjanY6WL0acu9eS9zPaoFbSyLgeEY2OG3Y9S7
         XCO6bO6MNqLIl+ZGj8zNjjD/1cKXsIEaKPgkDG4ORQ84Qvy0ldVFSre17G1GqSLoykGC
         JV/g==
X-Gm-Message-State: AC+VfDw/A80fN48s5Oa9lXHWhgwF2Dzz1TN6inRoIjst5ImwHvj5ov84
        IEtZ4M0Szf6FLUej57wfA2Z0QA==
X-Google-Smtp-Source: ACHHUZ4W/+DD5ldtST9n+L3tb19fltiQjnjSwXcsWaHXldW/GVwZIlA/d220E2oOodwNbaN9vsHROA==
X-Received: by 2002:a17:907:16a3:b0:967:92c6:1ec1 with SMTP id hc35-20020a17090716a300b0096792c61ec1mr2573213ejc.55.1683563457748;
        Mon, 08 May 2023 09:30:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906105800b0096650474479sm153939ejj.165.2023.05.08.09.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:30:57 -0700 (PDT)
Message-ID: <7b5b2b87-3ac7-4a58-8ebc-e6e59096caf2@linaro.org>
Date:   Mon, 8 May 2023 18:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: soc: bcm: add missing dt-binding document
 for bcm23550-cdc
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230508135930.GA27583@standask-GA-A55M-S2HP>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508135930.GA27583@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:59, Stanislav Jakubek wrote:
> Broadcom BCM23550 has a Cluster Dormant Control block that keeps the CPU
> in idle state. A command needs to be sent to this block to bring the CPU
> into running state.
> 
> This has been in use in mainline Linux since ~2016, but was never
> documented. Add a dt-binding document for it.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

