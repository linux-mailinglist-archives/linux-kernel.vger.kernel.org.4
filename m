Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990766C9D16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjC0IB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjC0IBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:01:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CDD4225
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:01:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so32257451edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679904075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuAEn34evWkVu+9g8pzRZ0hvhIqCGv/9o6SvLbyayKo=;
        b=Zc6Pxv7O/Ah5V8t+dlGwiLkt/3TbeGoWzWL7HNsIIabo0lnDs1byWI+IkPhHgchnDW
         a645LNnxe5eTN8twzOCgZjCTz2Q3Le/XVMVIjqBFvCTX6fPhKUT4Vp/TJ2ORh6LREELW
         /oSRQxpsLpE7TP9KBL/i4Vlxysbz8TWvM73Js2Fz5lLNZBEPD0en448i39LF6d/KrqrR
         MNrMx58APxq80vpDEJ5NGi6ZBSnausd6w/Pya6jv0hH7AEc+9kRWoB8S4gvzPLMhqKqt
         mQiA61PfS8LfnMApT0kA34rA8lyw4eiDRaz4j5T0K25PPgwuM3mJqfoTwqZmH2UAz5jL
         KITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679904075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuAEn34evWkVu+9g8pzRZ0hvhIqCGv/9o6SvLbyayKo=;
        b=xrWK9MrJRF0ND6Due60aJwrrhCT8EKmQ/gspIWxdiuPVO3XD+AC0FHbF9jBVeyYsF9
         HEPiuu7KpadTwjyQOWoufFyyQn5Ou3zhJExiAsAvmqrUtLAy1ql6+ki/iz3w48ckVrwN
         7HvjnzXGmso1rJ6FhVwE+D7C35Vf8aqfFjYDzVN3qt8/3JmBwwbIGiOnBwIz9V4f2pLM
         eE7PbEgJFkJGLGAFrv1nn5EaLQZcMxZ+4FMzo10+FwusCKwqWXRQbK4qYostxXnzKoLG
         P9h774j5WUCj8F5kuQLXgs83I9lzP+M92E4PlyYAZ6/uQNBNM8umip4upz+B+BEfgjd4
         TjuA==
X-Gm-Message-State: AAQBX9fI6UCJWVXv0/YccIb/lsWPe/oALIz0kqJpFC1KRrWEfOJkzXDB
        JaqVUdX76wpVTPHZCFzX2i5PFQ==
X-Google-Smtp-Source: AKy350bIuG/4z1iiKW0lC8wTRxCuaJolAI7s+x1CbqqxUTPT34ySWHo3ciDWbj19NxxG12DrJ3hBEg==
X-Received: by 2002:aa7:ce0f:0:b0:502:24a4:b0ad with SMTP id d15-20020aa7ce0f000000b0050224a4b0admr10030514edv.4.1679904075589;
        Mon, 27 Mar 2023 01:01:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id f11-20020a50a6cb000000b00501c96564b5sm10527397edc.93.2023.03.27.01.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 01:01:15 -0700 (PDT)
Message-ID: <c3cb97cf-bb2a-2072-ae8b-a7fc9f9c9d61@linaro.org>
Date:   Mon, 27 Mar 2023 10:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/12] regulator: dt-bindings: qcom,rpmh: Add
 compatible for PMC8180
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-9-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325122444.249507-9-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 13:24, Vinod Koul wrote:
> Commit 71ca776a8885 ("regulator: qcom-rpmh: Add pmc8180 and pmc8180c")
> introduced these compatible's but the yaml conversion commit
> 7255f98d08c7 ("regulator: Convert RPMh regulator bindings to YAML")
> seems to have dropped it
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

