Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC70738B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjFUQdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFUQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:33:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683DC2680
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:33:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f8ff5fe50aso41878245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687365176; x=1689957176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLGr90Ct6YiiWYZK3C/9ohPmOziEp9WBnHBSoxvZVKg=;
        b=CdOcoVkfqUF7yQFTakDIkkGOhpaulKgfWZ9V+c0O0STLC3VXDnnY/fsTI1UbU3oLwR
         YxIFdJ1cmh2qnq9KgzpxEXcmTwDBNmJy/wq/35qxLUGbHc+331EwP5AcT+ptSmjlAPvy
         dGWBDIZHyCECOH2s5r6UzmVvhVB+0K4TXmjdP3jJxPEqu59z6eg3IcLAj39EbG7eau1L
         Fn7wTPrNmIHb2cq8djegYjzjxw0VOgcOiNruftBF1eeXF+1YtvAS4l05B5vPK3UW+ZoM
         rZT0g+tLtSHcu6T7ru/lSwPlxvIXjPScVxO23osmrJHETsTLCopV30woDua/MshQNBwS
         7uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687365176; x=1689957176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLGr90Ct6YiiWYZK3C/9ohPmOziEp9WBnHBSoxvZVKg=;
        b=aOGNboMb9JvVjH3NqPGfRY4HTK+uzSQfxmvDgjLkRtLDbcPvJoYSgV7/1F6D6q+4Gu
         CU68V2KvRhb99fW0TdKeWIzXrPYlQcaFfg13458B6H0F0oY3BfhVNkyxZgSPyvkKIBAV
         m5hTvEUC+31G9NF4lMz5X9/nYowX4MI22I490cZGRyhNahVkWXW+drjep4bbVV5ob3k2
         KZV12orKW6PVnAc9p3FhXK5RaWbllq0Q8Iwfz+rlpvT9ig8dcM0jNSBmznKSWb0mItCc
         6qUUAaU7VLer3cA/vUKv4n9uH7HhLsjLOdBKpP53yuqbpSLPF9/Zeva/ZbMJNhmmugWK
         341w==
X-Gm-Message-State: AC+VfDzeYMpORB+DGyFSszi2+qMpj3/UjbUCfNtUGC4yYnjfFBIs0IWz
        v9vOK8xzu0r4UyFXBj689USH2g==
X-Google-Smtp-Source: ACHHUZ7xXM1RwY58kyvXjTjJcIvjnaCnAMjZVA66OVbtjFywGkQrMDgpxkkyuFFk/+F5RpQxRl5/WA==
X-Received: by 2002:a05:600c:230c:b0:3f8:f1db:d1f5 with SMTP id 12-20020a05600c230c00b003f8f1dbd1f5mr14997447wmo.5.1687365175902;
        Wed, 21 Jun 2023 09:32:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c225500b003f7f4dc6d14sm5405348wmm.14.2023.06.21.09.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 09:32:55 -0700 (PDT)
Message-ID: <e6ae26d6-dec4-d9c2-0d9e-31e80c8d58f5@linaro.org>
Date:   Wed, 21 Jun 2023 18:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Mitsumi Electric
 Co., Ltd.
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
 <20230621-topic-mm8013-v1-1-4407c6260053@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v1-1-4407c6260053@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 17:39, Konrad Dybcio wrote:
> Mitsumi was [1] a Japanese company making various electronics devices
> and components. They've merged into a new entity, MinebeaMitsumi in 2017.
> 
> Their current main page is available at [2]
> 
> [1] https://en.wikipedia.org/wiki/Mitsumi_Electric


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

