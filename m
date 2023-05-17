Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92570642A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjEQJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjEQJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:30:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A119A7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:30:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50db7f0a1b4so787352a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684315830; x=1686907830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUzdy3IaIQzq5nRdBRJ4CCJrcCkR0OgrgjQsv52hwAU=;
        b=CZ7BnvfTcqeadMIEosUB0CY2OnrUMg/Ehng1E1VqtBnK9yAmX0uAwuQdsG/PpCY0QW
         X9T1qgHSZFuBdCKRUw85xOimKQrSTenDDzHyAlw8QUsFLPbiqzPd4nTdhOGFCN0E6e3o
         yHp/OYWOc9Y+FJTDW/YFeroAPF2X6L3Eh6g0ILWT9jxV6coUllbFlixpTFoyTU10g8w6
         +yoDIQ/24mPl4CLGBb+hrXrhDUby9CWrghH/91vO4n4yb0tdqd7RB/CzhaZE3ZyUSUA8
         VGN5Ba7aaxKynTrusMWkGPY7JWcP6psylDj+s3An+1o1t+BDnqxAI/oozDdlmCSc/eFL
         VRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684315830; x=1686907830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUzdy3IaIQzq5nRdBRJ4CCJrcCkR0OgrgjQsv52hwAU=;
        b=S2TzF/P8ygNfiVzuGcE9Ta5mPgJKjjanF79Va8tK78edtb8JE3TcDD7fu0dwYT+aW4
         CYApcmBqkrL4nRm1eNDAv94i9Er5nl7i/zunEyGuXlYXnCT5zKfnKxpbjjCQywTNogCa
         hpnEryzNNsdYOtP3mzkOhbjGj40LpJVaz6WimpMvvX/hvBVnaFuir5XbiADKs7Le854+
         oEz5FxrMJT6te69EOHxinfeANaS7g4Wr0Qa7ka5OzkHnKOF/6UgF2/uFYFtuVKpjZgnP
         sSmH0HeehVPHhIa7VE1Ddns7piRPuQtvfZn+H53kjMLAmcAsB84H8tp3p8Td5Vx+O7eR
         wQUQ==
X-Gm-Message-State: AC+VfDy6AMwmOc4ikm7wSgz+ipa6KG8YzO//1OTWqLGUeARtwj1GmnVI
        Sv+jvcmsDCaiyl6VPzFoivYi7w==
X-Google-Smtp-Source: ACHHUZ5iJ/zDI6dvKaZaIEoptXlHraI7FVmNbrkIBVv6R3E5jqonyVRZBV8CAklmUB4izFMLbbYIng==
X-Received: by 2002:a50:fe93:0:b0:508:3b23:d84c with SMTP id d19-20020a50fe93000000b005083b23d84cmr1560294edt.1.1684315830281;
        Wed, 17 May 2023 02:30:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id d11-20020a05640208cb00b0050bd4b8ca8fsm9005293edz.14.2023.05.17.02.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:30:29 -0700 (PDT)
Message-ID: <2a1b81da-39c8-4111-7e42-18f5f2f557c4@linaro.org>
Date:   Wed, 17 May 2023 11:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH] drm/i915: constify pointers to hwmon_channel_info
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
 <87cz2zgvdd.fsf@intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87cz2zgvdd.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 11:28, Jani Nikula wrote:
> On Thu, 11 May 2023, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> Statically allocated array of pointers to hwmon_channel_info can be made
>> const for safety.
>>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> FYI we'll merge this once we've done a backmerge to get the hwmon
> changes to our tree.

There are no dependencies. hwmon changes are already in rc1.

Best regards,
Krzysztof

