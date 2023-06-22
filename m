Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4F739F53
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFVLQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjFVLQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:16:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDD91BDA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:16:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-311367a3e12so6216386f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687432579; x=1690024579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkuJbui1TrFk7WnIn5Q46aI6dYF0X8Z64txw2ibvVmI=;
        b=ahafXNRY3jyMyKboVgYIAAB1IJz3gEICHNJxy6sG1yZPI7R07+y7fANWear+IWlQwI
         ZRLyoBdmHCPSccVCNbfvZPz5K7DGqnWSOAM+ZJIc7Lf5kryoi9AdBMWxrOOnGHhOYXkB
         t8knDk3pwAPG5wXg+J4ZoMXTv3RbKL0e+bdyqatnNLOJd6RHe09TR+jgcc2bIDOc1XNj
         S4LZiIw+uMMDio/PI7ggO64y3vn3oPzxVFTGwpBjGFy0Fb1QrHjWprvUrjWe4Yq1nw0Z
         qwROrtVcBZfkhS0pnEfTmg13sdU0LkiWq1zaQCvoXCDt6vQwl5bO0on/pT4GWKvuofMM
         KXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687432579; x=1690024579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkuJbui1TrFk7WnIn5Q46aI6dYF0X8Z64txw2ibvVmI=;
        b=IaxmMHJx0mpDy1JdDGEkxi9HEkpHYhCNnlYLcCJVgtQQFVFoutoWtVdNW5gMCTlnsd
         DQ8DzHq+OZBDK7gVy604Fg5ud8kIez5mdiWThAcfjngwufm7xIvhcWaUVOAKe9W1KvSq
         Dr6+RJvJ5u36Zq6gOmMBqs4nBV5CaSlpz05aLdezteelhVvX0oGP65MVsFfTewq8PrSS
         COYcc0nC4aP0dIsEWywVU/bMCg342y5ZKjgZ1SDgYFLRzfulvDEV/1x5YTsZ9RpWM9jP
         ezfJ/a+sZQnzuBSrA6VKOIq9RKNcSsNa22LKYtY2LtxjCyayDrnXqoeOEdYwWER03asL
         YeMw==
X-Gm-Message-State: AC+VfDxLvayE6Fc3zstmJY99iEQ1gzZR2y+Qmiw95Mt4vwvFtcHtBTFt
        hM75kmMmSFYl/mSi7hd8gDnotA==
X-Google-Smtp-Source: ACHHUZ7G90x1rlqtJDABY4jL6gqVyqinf07WM6SQZgZLaL3Ya2Rqsfug/LwHGfUfmAl3cPo0pNwPiQ==
X-Received: by 2002:adf:f34f:0:b0:30f:b1ee:5cd0 with SMTP id e15-20020adff34f000000b0030fb1ee5cd0mr15821068wrp.50.1687432579278;
        Thu, 22 Jun 2023 04:16:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b003078681a1e8sm6819888wrt.54.2023.06.22.04.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 04:16:18 -0700 (PDT)
Message-ID: <2300d479-2384-745a-7d45-19744c17a3ce@linaro.org>
Date:   Thu, 22 Jun 2023 13:16:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sdm845-mtp: add chassis-type
 property
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
 <20230622-topic-sm8x50-upstream-chassis-type-v1-5-13f676eb71f3@linaro.org>
 <CAA8EJpphEZa1Vfs1ipm+1x7MvYgF7HMiW-GfNzYi37YPoMzKVw@mail.gmail.com>
 <091a281f-b4c3-39e5-6d9c-5df903a020f5@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <091a281f-b4c3-39e5-6d9c-5df903a020f5@linaro.org>
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

On 22/06/2023 12:49, Konrad Dybcio wrote:
> On 22.06.2023 12:48, Dmitry Baryshkov wrote:
>> On Thu, 22 Jun 2023 at 12:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>
>>> Qualcomm's Mobile Test Platforms devices are handsets, set the
>>> chassis-type property to 'handset'.
>>
>> Is it really a device that you can take into your hand and put close
>> to the head?
> If you don't mind getting a bit microwavey, yes

Handset should not poke your brain, so the chassis is not really
handset. Maybe it is just embedded?

Best regards,
Krzysztof

