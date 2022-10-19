Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95B604C86
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiJSP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiJSP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:58:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9411C193464
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:57:46 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 8so10987353qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XuH1cwGYuoIXuHDHrxmGsjJyFHpkABDYVCIkLmAK2bw=;
        b=ghdwkgoTZX+EiHmt/h6EJyEpxc3hSgg79jAPidHTEO5U7Oacb2f7aV9dA16+K2MI+2
         ZzRKn6SblRwL+Rux3tzWlTKKK0E+pXdghGvOqIUCGWlsFEqRDdMrL3lJvy/xM9Jm/J8i
         RRa9s8ygIFflpnEI7Oafv9LZ+seAPhNZ0bpscvw5Yk0pUNTAgLlOCdBvKHWaC+TKSBEN
         /xlpUA+2rL7MD4soWBynVfAodBYwZDxgDAvIr/lbs3fW72ukn33S338xKxaC+S1OptCh
         hBSPFsIFUsKwTeGOzyu+tPtH7BasQmSIyETOFf+XPtp2krHM8NbAy1mN78PRPba3v0gl
         yIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuH1cwGYuoIXuHDHrxmGsjJyFHpkABDYVCIkLmAK2bw=;
        b=aKKD1wS8eABDZNnIBeUBjgcBnKai8AsBzu8AaWjWFHD4a5FtZ+cYgOkQGR/PzVJgPd
         h9eK1OwKFcPmN8PFPwIyRHySLS8puUdag3ybi+KCvRIZxyks4r6Zr0wpxPJW1sErVCUv
         RioKhwEY+kv8RTRWVfNSr2JoSrb+u20KTIsoL9GALHs4NDEbhSfZ1Y8Dmu7hW5VOaPtN
         CX4M8ILLJx0GeaKET6pYOsEzKBSGGTOW0iziKzT/0kSeBk0AFfcQVUT/OYgCB2a/seM5
         XAog1M/WduHwWnsMYtxvX2dKnH1NVDUXPJnA93UdfI06wNZHqxG9nxxwgUiO51ins1nB
         R9Sw==
X-Gm-Message-State: ACrzQf0a071R+7Iaxje1+ypVIgVsEFun87rUiSDE0J1JwE46wvtKbKdP
        k7qRIEKNIQxqH4iUM/u7UcRTAw==
X-Google-Smtp-Source: AMsMyM4eCXdcxPYYjqQ4LMC6OlOLsmYWjCS81HiLMFGL1eq8MVPxt363n9uh3cA7kLDZL6Qos11S6g==
X-Received: by 2002:a05:620a:30b:b0:6e4:6de2:7f38 with SMTP id s11-20020a05620a030b00b006e46de27f38mr6179989qkm.520.1666195060953;
        Wed, 19 Oct 2022 08:57:40 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id i23-20020ac84897000000b0039853b7b771sm4218488qtq.80.2022.10.19.08.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:57:40 -0700 (PDT)
Message-ID: <6b71bc77-b168-282b-9318-1640bba4e946@linaro.org>
Date:   Wed, 19 Oct 2022 11:57:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 4/4] dt-bindings: pinctrl: qcom,sc7180: convert to
 dtschema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20221019001351.1630089-1-krzysztof.kozlowski@linaro.org>
 <20221019001351.1630089-5-krzysztof.kozlowski@linaro.org>
 <CAD=FV=U0WR-a7d4p5eoCFMRer5yhX8AcEPdUaJag4KpGB9kp+A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=U0WR-a7d4p5eoCFMRer5yhX8AcEPdUaJag4KpGB9kp+A@mail.gmail.com>
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

On 19/10/2022 11:48, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 18, 2022 at 5:14 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Convert Qualcomm SC7180 pin controller bindings to DT schema.  Keep the
>> parsing of pin configuration subnodes consistent with other Qualcomm
>> schemas (children named with '-state' suffix, their children with
>> '-pins').
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> ---
>>
>> Changes since v2:
>> 1. Drop entire drive-strength (not needed, brought by common TLMM
>>    schema).
>>
>> Changes since v1:
>> 1. Drop default:2 for drive strength
>> 2. Add Rb tag.
>>
>> Cc: Doug Anderson <dianders@chromium.org>
>> ---
>>  .../bindings/pinctrl/qcom,sc7180-pinctrl.txt  | 187 ------------------
>>  .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml | 158 +++++++++++++++
>>  2 files changed, 158 insertions(+), 187 deletions(-)
> 
> Looks great now.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks

> 
> Will you also send out separate patches to fix up the "drive strength"
> for all the other Qualcomm boards. They all have the same problem. The
> drive strength never defaults to 2 and always gets left at whatever
> the BIOS leaves it at unless it's specified.

If you mean - other bindings for Qualcomm - then answer is yes. Several
things are already applied and will pop-up in tomorrow's next:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git/log/?h=next/qcom-pinctrl

I'll go in spare time with rest of bindings.

Best regards,
Krzysztof

