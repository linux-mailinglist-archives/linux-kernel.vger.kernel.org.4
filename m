Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18D8639D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiK0VaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiK0VaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:30:19 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270DD134
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:30:18 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q7so11112699ljp.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0n4CTe4WBaaSWhkZDVFkSXyJGGMu9q39kAifmZ2ndLs=;
        b=oJo4UvcNKjMiYJs92Cqcs3TNjzbQ9oWY96Jm3o1a2r0LecO2IAbqQ3vEKiDN1ShiZ5
         mYUdioXJuOEqVNmU3fVQiBHuQnV4iwWaI8QSl9mYd6Kc3fMpO9uKUN2U1kEmkE86BKUm
         i1V/VyAluyz9jWUrz2yKiEmtYQl3ObFEo0joriLZ4WCpWBAEY/Oc2FhecGvN1Ez89GmF
         buwMSYKl3MIUpb2d6ur61pQAWakOTlThmMst/Jw7GkzmgEglcFy2S2sWR+SR3SHdhTZD
         SIeGwBNpatYabdO/WclRbbGHrfMdVGOHTmr9TyPuazEMNYBLW5XXHfcf2d4smekxZBO8
         SzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0n4CTe4WBaaSWhkZDVFkSXyJGGMu9q39kAifmZ2ndLs=;
        b=1poaZo8cK0Qr73oTf9AOj7tvkP0yZm/sItBvI/RO+D0CAlbQNEEwxg7w20xV8BB+Vp
         bMdwWcg641CH6/it+joKBdWy9hO0mpDEpewSfySh8rNpVpG7TQcBLUbTodDHmVLbwuYi
         ZVszpJm3IR6slfpSgwPvVtC9lLFFjEdxmJ09c9eJMTwgdcS3DljrOCJyMJQv41Tvn02l
         BT9Znlt+5xDAsB/0Pz6WBZnhDpjd387fZlX6wp8gQrt5lgllF7dudo460S7UTf5DsPF+
         Ajp4Gpnk9jNq4msXsD5IO9ZxZROx8YUeji5PLWXEit/g2K6JGiNiqbaq4f0279Zf8x1G
         pcgw==
X-Gm-Message-State: ANoB5pkFQLyVplsdc0bylUFeAdOi7+L9pvmKmoAfEpSws2AF8pSSpFqa
        EsPJoNZ8AVLxohGtAuticu4x6A==
X-Google-Smtp-Source: AA0mqf4r2WZxTuCuGnSThCQfKi6ipfJsSqYG0WK2G9b921OL1SXuMkGGGeTd2YIt0j7LOSPY3UfFDw==
X-Received: by 2002:a2e:bc12:0:b0:279:f7d:15d6 with SMTP id b18-20020a2ebc12000000b002790f7d15d6mr10175281ljf.402.1669584616439;
        Sun, 27 Nov 2022 13:30:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a2-20020ac25202000000b004acff58a951sm889582lfl.133.2022.11.27.13.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:30:16 -0800 (PST)
Message-ID: <f0a15b01-81b6-5c73-6c35-ce3a8c71b4ad@linaro.org>
Date:   Sun, 27 Nov 2022 22:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document oneplus,bacon device
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221127181835.806410-1-luca@z3ntu.xyz>
 <CAA8EJpoe09FZcfVXuknmFWO5qg-iYDOBVN3=qr=DeJjvHw56Mw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpoe09FZcfVXuknmFWO5qg-iYDOBVN3=qr=DeJjvHw56Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 22:25, Dmitry Baryshkov wrote:
> On Sun, 27 Nov 2022 at 20:19, Luca Weiss <luca@z3ntu.xyz> wrote:
>>
>> Document the OnePlus One ("bacon") which is a smartphone based on the
>> Snapdragon 801 SoC.
>>
>> Also allow msm8974 devices to use qcom,msm-id and qcom,board-id.
> 
> The patch itself is good. However it raised a broader question for me.
> Up to now all msm8974pro devices use qcom,msm8974 as a top-level
> compatibility string. Should it be changed to use pro-specific one
> (e.g. qcom,msm8974pro)?

Yes, makes sense.

Best regards,
Krzysztof

