Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CEF712E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbjEZUrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjEZUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:47:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2B1B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:47:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3078cc99232so1046265f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685134057; x=1687726057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWQNcyZP8KiazdiWKnaP5XYHweBHqUNg+1IkJ9O3dyY=;
        b=HOP5yi8wL4uZwsx/lN1hkXHAUQcLlHwLeN1NrRSX66ZKHVibVzeVB1VA/mIvQfv5rt
         pSzJCHCRifpmdaUu1G1hwXNtfwOihWzRtQZ3kRUKJLkJ6qSAZ6Opvv/qsHs0z7cWhCp8
         YCq+jVuMuoCDwktcu0Vb1Z14142njMpAPjfHakDKuWsWg6D1aJaMwrAmAusd9Ooqlq9w
         QvuJ7cU+Gl0/X4jgUf7qeQODEA8HIhkX3rAlms2ao9SFHxEnhCKINwjN/X1sTflpUjy1
         +xOW2hUtRErNSti5nRKNBWvWKknNun1AuJBJRyqSwEydJKDgNY6Y9euyXSwrdPIXEqWk
         KBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134057; x=1687726057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWQNcyZP8KiazdiWKnaP5XYHweBHqUNg+1IkJ9O3dyY=;
        b=hEB3dV3fIktclmE1FAIVE1GP+/a/JP0gliv+DIDpkFrGw/cfkcHqNp1xzdkhsKihF/
         acsE6GAh1M+zwGEgx6BIf0C1Lav0Wz9FUPC/D25sHbt0O7vhALVFo7G+iapXAaodpqHO
         atfS3TSIespuit21C3vvkizQnwYZLIPW3s/hSU2oVRaLSZnAI9SMFwUAIyL3f7vguMpd
         AwxlpcbL8SkqZ6LEAdemSy5JnV+ex/QQUuTluD1j7pmpBHTx+P199BwQ9NnJwRgez/IT
         aD6ccKR1gl4u9Uz8+KjXPA5DugW6cbwIn0hX1QS8jNbx21m0zTxgHyO3GfRIaiuGv84H
         ps8A==
X-Gm-Message-State: AC+VfDzsc6X3mCbyoemJCX9X+e8jHltcPuGT2RcqkJco2a/GFlV2BUh0
        LbaNYzLY3VjwCP4s9RgAu1dzmg==
X-Google-Smtp-Source: ACHHUZ58exYPPq57b3uzGOTHpryl+KwllVGqwA4MIB3/qNNft8Red3AAA0R7RVOZ3ZBJrCXeM0EtkA==
X-Received: by 2002:a05:6000:11c4:b0:306:2e04:5925 with SMTP id i4-20020a05600011c400b003062e045925mr2451387wrx.17.1685134057195;
        Fri, 26 May 2023 13:47:37 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p25-20020a7bcc99000000b003f1751016desm6319163wma.28.2023.05.26.13.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:47:36 -0700 (PDT)
Message-ID: <2385b00f-3292-3d27-dba2-c1375e5d9dae@linaro.org>
Date:   Fri, 26 May 2023 21:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] dt-bindings: media: camss: qcom,msm8996-camss: Add
 CAMSS power domain
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Conor Dooley <conor@kernel.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-2-y.oudjana@protonmail.com>
 <20230526-obstruct-venus-5833511a58af@spud>
 <838b134d-46cb-6237-49b0-0c287141ebb3@linaro.org>
 <20230526-street-pox-2ff5ee106c43@spud>
 <8d89c14f-b2c2-7db2-f637-aa6d90273f4d@linaro.org>
 <631e5eec-853b-dce2-c474-62e76e83d7e6@linaro.org>
 <5dc28004-5ff4-2102-0bb3-8f7bee7cfca6@nexus-software.ie>
 <265d1c93-0740-cd87-3ba2-e1ddf70a0c65@linaro.org>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <265d1c93-0740-cd87-3ba2-e1ddf70a0c65@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/05/2023 21:43, Konrad Dybcio wrote:
> 
> 
> On 26.05.2023 22:40, Bryan O'Donoghue wrote:
>> On 26/05/2023 21:36, Konrad Dybcio wrote:
>>>> oh the names
>>>>
>>>> no toss that
>>> this should be
>>>
>>> if:properties:compatible:blahblahmsm8996:then:required:power-domain-names
>>>
>>> Konrad
>>
>> Hmm, we don't depend on the names though.
> Check patch 3!

Hmm but we already count the number of power domains in 
camss_configure_pd().

There's no logic in counting it twice using two different methods.

