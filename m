Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E90C5FF216
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJNQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJNQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:13:36 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CAB180258
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:13:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h15so3965119qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAYgD7p8nfOyI0inpXjm1KydkFFVZgXtGF7VcGSmJv0=;
        b=ISSTBDW5maTqi6JGFq5DH7FRK8gzbVwThTRZ81FikOlFIo4wB7lfsVx4i5g+pSUb6h
         UxPkPL3F6Kz+iZdwBecJKyCPuOhxuC0AsvRqGEF/FJypUuVa4O+iTVE8FMAjrzK8Ciqc
         GI4LHMm5hK6NmR4Hr7Knb3qGv3jBnRYLrjbb5/HYgXcj5nN4BO+Sg58uU+3YHZdhuq6B
         lBaCFelM3POBA91JNem0zoWb8wtBjfLuQEsec1fe8przKHOJuGAQGxMuH5XYP/8gbCrp
         5jJP7OdpXompy3+ZRTmdk8IXIqh/AiZSkM1WiP/LnRKdWQPJsIyM+x35KTT7HwDFAAnf
         pwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAYgD7p8nfOyI0inpXjm1KydkFFVZgXtGF7VcGSmJv0=;
        b=DeLwlGx5yi1o8eqVJ+54p8DDntyqisBhiM/lOogsGyQdLYr4u7ZJuRaTeahN3m3F44
         mraAK1ww0TkOV3yqU56fGaHvFzlFsz2PACB9oxZbuQS2yJVpPGcHUHfInQA3wZu39oRI
         cIcbG0K9VFTuMz6pr0C/16eXeK6YIkGt8ndYXWbW3hpDf3ijKbavuslizNyGkuR7LjiS
         LTpfjq8tXutx/Rv58qiF3RZwamwVXYozeCotMyJ4hdx4jXjZsy4YolzZpSMooRKZAnbk
         MeOVPcaWPU5wvrWSfWkgjeqPnLC9KTDviqemK4y2qKjL9nPvvW5cy0wVR0sI8qOce2nK
         pE/w==
X-Gm-Message-State: ACrzQf2KrmM2ihi0NNKOoAf6Lg1ib/OX3yBei+RXIS0OWOxCK8u2RELe
        Z3JKeVJ6BQiWOcY5ghF3bekGsA==
X-Google-Smtp-Source: AMsMyM6YaCACpBs3YABkF2NUlwPBqw8RPkkMujHjs7tea+n8gH/GsHgoTZMQxOTqqm5XMWIsXYuPmw==
X-Received: by 2002:ac8:5bc9:0:b0:39a:348b:857e with SMTP id b9-20020ac85bc9000000b0039a348b857emr4817701qtb.462.1665764013887;
        Fri, 14 Oct 2022 09:13:33 -0700 (PDT)
Received: from [192.168.7.170] ([12.190.236.102])
        by smtp.gmail.com with ESMTPSA id bl16-20020a05620a1a9000b006bbc09af9f5sm2845994qkb.101.2022.10.14.09.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:13:33 -0700 (PDT)
Message-ID: <8c773f11-1c00-1856-daa7-250a4ec37d23@linaro.org>
Date:   Fri, 14 Oct 2022 12:10:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: add samsung,starqltechn board
 based on sdm845 chip
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221012185411.1282838-1-dsankouski@gmail.com>
 <20221012185411.1282838-2-dsankouski@gmail.com>
 <99652775-8921-9d4a-193e-20d1487e6759@linaro.org>
 <CABTCjFDDEhNo0OVk+87kU93xwvXNR3tMuinfLXzZ6PeyweCpag@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABTCjFDDEhNo0OVk+87kU93xwvXNR3tMuinfLXzZ6PeyweCpag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 07:01, Dzmitry Sankouski wrote:
> чт, 13 окт. 2022 г. в 16:43, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>:
>>
>> On 12/10/2022 14:54, Dzmitry Sankouski wrote:
>>> Add samsung,starqltechn board (Samsung Galaxy S9) binding.
>>>
>>> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
>>> ---
>>> Changes for v2,v3: none
>>
>> Where is v2 and v3 of this?
> I've been told it's easier for maintainers to resend all patch series,
> even if only 1 patch from the series requires change. So I decided to
> keep versions equal in all patches, to clearly indicate those patches
> are from the same series. Please, correct me if I'm wrong.

This is okay, but you wrote here there was a v1 and v2, and you changed
nothing against it. If there was v1 and v2, we would ack it, I think.

Or this changelog is for some other patch? Not for this one?

Best regards,
Krzysztof

