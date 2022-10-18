Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217F76020BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJRCCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJRCCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:12 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE217EFD2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:02:10 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id g9so8491948qvo.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyq9LA30nyUqygfsWSbEbwvIL26nG2QJNkPL4U+fu7Q=;
        b=nX0AQEETouCt0DdM2aKt6GyHIUA/oCacw3uQrF37CYa2v6JTPpMFyTWgButSmZTq92
         SA4KiAGj/6MC8dl2mwVQzaeUy9svnvJM0xnmST1GTL3xSOIMZbvmzfQeuB8ko0+opNmC
         QiNwBKs1cFvNJGSiANcBY3EMaXWd9R5xsOxglLoWXAm92qSfg5XQUtv0FHTox0glWoXG
         nVRXLR4bCXxXXXeEOH/+DhdusjdY4vP+qfm7MAV1yZOyo4XOYZpNMpSNfgj2qv97PrSN
         R/28KdSLWvaTSNkXufFhAF641SPuUIyPlg7rSvjEV4wWhI9u1jVY5p1CWYO1fOrfDBok
         0R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyq9LA30nyUqygfsWSbEbwvIL26nG2QJNkPL4U+fu7Q=;
        b=lx3EtEQH2yGxxvlm90NCVNUrfy+bUvsNoJad0DBBM0dUBEQkKCzPElQ0DQfXXeX1V3
         YRQ2VkekvArZR646VmoKBkyRvAN0TBEZs2yVeNGSyXPE7GC7ZdDaf3EexGy5BOb/5FKL
         nS9/s3ZC9+NUVKA+s0XJMyRb/6cpWdWMUwzEJwHLtkT+4H7zat+wAEfvBP5RYomua5KS
         +ZgkQP4G7E0J3P77c1VcmrujDVGHsW4pQzfZaINBCDb/c01CdP7jlXJx+4pqdgawcnQR
         G8JruwQzJVjbluueMa3rZqhnK5QHKsr1sS89sCPOdheM5rlMjKsgjxlOSki/odps0usL
         5FVw==
X-Gm-Message-State: ACrzQf1+p+2KzTh00XkpwYYKQPFcxOkA2Lvz1yvbLpdbtlqKhIXLuxyO
        epz+kmk6oRWei35MNUmU7no60A==
X-Google-Smtp-Source: AMsMyM7k+NWuRywztdDPhD8AED+ORNgOqDg4iJxeblWIUX1Ug6zJd1Ys9280obKMURdhaddim+tzsA==
X-Received: by 2002:a05:6214:2342:b0:473:bcd6:a3b7 with SMTP id hu2-20020a056214234200b00473bcd6a3b7mr642978qvb.88.1666058530006;
        Mon, 17 Oct 2022 19:02:10 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006e16dcf99c8sm1289393qko.71.2022.10.17.19.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 19:02:09 -0700 (PDT)
Message-ID: <7ace0537-1228-c539-a74e-75f1e632f8af@linaro.org>
Date:   Mon, 17 Oct 2022 22:02:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM
 pinctrl schema warnings (5th set)
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <CACRpkdYMa=bG3R4yfS25JZ=70=dOveFy1JocJBs2BOiBWP06PQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdYMa=bG3R4yfS25JZ=70=dOveFy1JocJBs2BOiBWP06PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 17/10/2022 05:24, Linus Walleij wrote:
> On Thu, Oct 6, 2022 at 4:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Patches are organized not by file, but rather type of change
>> 1. First patches is for common TLMM schema and dropping unneeded refs.
>> 2. Last patches are pure cleanups without functional impact.
>>
>> Overview
>> ========
>> This is the *fifth* patchset around Qualcomm pinctrl in recent days:
>> 1. First round of TLMM fixes: merged
>> 2. LPASS fixes:
>>    https://lore.kernel.org/linux-devicetree/20220927153429.55365-1-krzysztof.kozlowski@linaro.org/
>> 3. ARMv7 TLMM fixes:
>>    https://lore.kernel.org/linux-devicetree/20221006124659.217540-1-krzysztof.kozlowski@linaro.org/
>> 4. ARMv8 remaining TLMM fixes:
>>    https://lore.kernel.org/linux-devicetree/20220930192954.242546-1-krzysztof.kozlowski@linaro.org/
>> 5. Fifth clean - styles and using common TLMM schema: *THIS PATCHSET*
> 
> Blanket:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please send me pull requests for any parts that need to go into
> the pinctrl tree.

Will do.

Best regards,
Krzysztof

