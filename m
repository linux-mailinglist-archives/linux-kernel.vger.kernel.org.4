Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AF05B58B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiILKrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiILKrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:47:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3233204C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:47:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bt10so14185142lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bS7LDsVs3qcnyEA5WCUeLMEdHfGdR6OQ6NC7pdWEKCo=;
        b=v9C7GeUH/ntRNwKKZ1I7TT6BQcjJBRkVZ1XpH6mXDdIGqsu2oqlY8NR6ikeS2VHyL8
         7XoeJToQeSx7WIMqvu9S5zhL+/zdPWkCJ/xRvKy5UYL5moSuGoTzW/rT+uXwRSG6Eiic
         vRv3Oy4PyY5Y4nPRruZEaZcvpvxM6lCfMQ0gzcT4tFsasIVkJa+3D6W6V8K+hfLskejA
         LNX5aQQbJSTAfgk7Upg8DIPsy+QVWFepdmlC4bDE/vck/eapbQzWJPan/jIBh9yCxMTn
         xdGGkKSLDDM4Cf8yXZKpajXEJTCiwphjC+CcMOkntC3mGhoodSx7fPj7QXXQPJ79Il6x
         BM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bS7LDsVs3qcnyEA5WCUeLMEdHfGdR6OQ6NC7pdWEKCo=;
        b=ZxgoZpMNSLGSkjobJw1zJ5OGludvgmyZkSF1P1pysJCPt7xiaawchEuxM8ah43E/it
         ddGfxCzX8Tjd8LJDUX5hSpv49Eyeg5LcfWNWw0T/HoJTR/hn+BzYtsPDQ7NZi6xNTZ8e
         xy5SebueUOgKSCopqyMAPqtgKaRyp+YuUqGFym+Fy7V7KFzn/vEtGghxRRrCKhv6OXDG
         rvneFFlFi4gJDczBdJ3pJccSdLLK1bYGMg/vlpo8IAmQiWwuPJa9YzdBXfshuIjnI2PU
         ruS6CH4h8V6jg24NkAeGPKqpUS2jUfn9bvmTLFOXe3JlKitOjfVLagGoSrg3BBtwYsnP
         vbEg==
X-Gm-Message-State: ACgBeo1y6ZDvLD6uhfHClTXJY6yBv+1M1nGxyGxIWYtGRa/pf/xh7Uy8
        H6n+AL0QAJy3Pp09/WSriEe2yw==
X-Google-Smtp-Source: AA6agR5+jaTiqHAiQpzt1KGZYW6NOWDU4UIg3cF3n4GCh9g7ACcWMJRrb7wrqPm8IlRGzsNs5ZLcOA==
X-Received: by 2002:a05:6512:3f8c:b0:492:b392:bb84 with SMTP id x12-20020a0565123f8c00b00492b392bb84mr8267929lfa.368.1662979633605;
        Mon, 12 Sep 2022 03:47:13 -0700 (PDT)
Received: from [10.129.96.84] ([109.232.243.34])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eb7c8000000b0026c111ac7bcsm188263ljo.86.2022.09.12.03.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 03:47:13 -0700 (PDT)
Message-ID: <79c11b6a-8f34-a5ee-373d-f88d5a980039@linaro.org>
Date:   Mon, 12 Sep 2022 12:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/4] dt-bindings: remoteproc: qcom: wcnss: Add
 qcom,pronto compatible
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     bjorn.andersson@linaro.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
 <20220908184925.2714098-4-sireeshkodali1@gmail.com>
 <ad201ee7-d83c-9ebc-3619-64632f1f266e@linaro.org>
 <CMU3V4NK164X.1D3TDJPALGIDD@skynet-linux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CMU3V4NK164X.1D3TDJPALGIDD@skynet-linux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 05:33, Sireesh Kodali wrote:
> On Fri Sep 9, 2022 at 1:30 PM IST, Krzysztof Kozlowski wrote:
>> On 08/09/2022 20:49, Sireesh Kodali wrote:
>>> The qcom,pronto compatible is used in the wcn36xx driver to determine
>>> which register to access. However, this compatible was not documented.
>>> This patch documents the existing compatible as is, since it isn't
>>> immediately clear why the wcn36xx driver uses this extra compatible,
>>> rather than relying directly on the regular compatible string.
>>
>> The patch does much more - messes entirely all compatibles...
> 
> Is there another preferred way to handle this?

The one which does not introduces any other changes than what you wrote
here. You wrote here, that qcom,pronto is being added, so why some
things are changed to oneOf or to enums?

Best regards,
Krzysztof
