Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6283B739771
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFVGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFVGYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:24:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A119A6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:24:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f900cd3f69so51332325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687415044; x=1690007044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eH8Jr142ntLel/7gLS1oZ1Nz56TZasAa577P+okAIvw=;
        b=Qhk4+G/vUb59EiStnxM1IvO/IzZ51ii4b1HymApYEhCeaBxA0YMbxE5YsVsF6c8Q3z
         pWeKr5HYwG3KzFEl4hK686UK8L7u9lAEkU+HbqwyXsrlsv1x5KVchS4TjwhoCqWEKZFn
         i4Ro0mEocafLppA3jOsRtFLu+eDg4XaaZxLBVkLtldbHDtorhe8oZoto2E2GW2Ks5NP+
         VpV4ZYk7YpZHfJl3EMpMHW2LjuMuowug3IJ8WZXtNDkH3/miXK7mSR+cG/uRlGeEFZan
         2GTd0L9isK+frNFvjSNT5M6EOTz539wYjDxf+8CqNHDehMTGRUNYprcsBhzK850D07lF
         BBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687415044; x=1690007044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eH8Jr142ntLel/7gLS1oZ1Nz56TZasAa577P+okAIvw=;
        b=YvOvgR0Q1yYRy7b3qANWQhyfn5FhsnqFiGVrU5WfR89JPYHynsIUmIR4WWMhwBwBAk
         0nz3u8kku7edzIPHMu48eVEciwqII+V8zAvfVbHN/AXxXGGulb086vx7zPmORYvjA/+B
         05ZbJsAFXxnRfrCo/F/svVn0n9+0PU89lql7CIc2o7p/1LprRL/XsUyCHc7M8TMIUAxL
         En0lfTv90e15nu42yDjssauahS6Cm5h6liZCdkuOk9xkHno7r7RewkhEsAXwMyiN5OyW
         zqCDWF+No9kHuYzym3VlL7jQ4HrrOxU2p4jsyAA8bP2xrLC9EUCR7Lo0utyF37M7GTlI
         HGKA==
X-Gm-Message-State: AC+VfDx1/LHb0k61qJ4af/3AlfFQAXUtHWhQTPys73ElSVmbxq3vDpgt
        FCXo+We5ACftSR/6X5GzT2ATuw==
X-Google-Smtp-Source: ACHHUZ4N2Wiu5Bmd+kn66yQlZpQggnM3k8bZUERZzs+mFFPuLF88JjPdu4yXxaJygw9d8Q1tFcz9gA==
X-Received: by 2002:a1c:750a:0:b0:3f5:878:c0c2 with SMTP id o10-20020a1c750a000000b003f50878c0c2mr12326628wmc.3.1687415044072;
        Wed, 21 Jun 2023 23:24:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c294600b003f7e4639aabsm17920533wmd.10.2023.06.21.23.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 23:24:03 -0700 (PDT)
Message-ID: <3e4840e0-adb6-010b-8186-0b3e38b4a374@linaro.org>
Date:   Thu, 22 Jun 2023 08:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] dt-bindings: power: supply: Document Mitsumi MM8013
 fuel gauge
Content-Language: en-US
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
 <20230621-topic-mm8013-v1-2-4407c6260053@linaro.org>
 <da300402-d417-5646-d4c9-7c100c351db1@linaro.org>
 <dc5ffed0-555b-18e5-cf96-d6a4263357af@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dc5ffed0-555b-18e5-cf96-d6a4263357af@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 02:51, Konrad Dybcio wrote:
> On 21.06.2023 18:38, Krzysztof Kozlowski wrote:
>> On 21/06/2023 17:39, Konrad Dybcio wrote:
>>> The Mitsumie MM8013 is an I2C fuel gauge for Li-Ion cells. The partial
>>
>> Mitsumi

...

>>
>>
>> I think you miss several properties: three power supplies (although not
>> all might be needed) and most likely monitored-battery. One regulator
>> output and output GPIO probably can be skipped.
> Looking at the example circuit, it seems like the chip's power lines are
> hardwired to the battery cell.
> 
> monitored-battery does not seem useful today, as we don't have any
> information about writing values onto the chip :/ And I'm not w

OK. With the typo in commit msg:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

