Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59813739749
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjFVGQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjFVGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:16:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B541738
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:16:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f849a0e371so9071869e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687414571; x=1690006571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=poTMBpsW2wjpyMUwrhE2d7/bK8bYKWDZ9t9qjQY+Y4g=;
        b=aJlL+DetePj5uZjoDbapcd13KqWhVsZrwU+VPpEDwjOV1kDukNItKeN3wZF63mhL4s
         +RcPrC9BpbPB83mD23fmdfNXhEYzGib9/+d4KAVM5Zol/WXlayFcZlPVR3HjTLjovPpH
         bgkG9Bty1HEpPsvV0YURLos4rP9IFVwo2rQaEcAZMGXGVjIRq1bzDrgEHxA1RhAsL/Hj
         ID1M/42xD73l8D8t6/Dgj5inpy2u4U46KJdcVjzsDZ1kuvuuMIeo6dcFagkCcv/us//m
         JPlR8B7x67SCzn9VkwZ48OO8LkS6VC0bWvkV1NEawjKPjAKbB/NADjYiUHQsaJSGiAdv
         fnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687414571; x=1690006571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poTMBpsW2wjpyMUwrhE2d7/bK8bYKWDZ9t9qjQY+Y4g=;
        b=hAtdxUKDWzYuKX6JrBv5Vm5YeBkxH0xY8x5/G1CemMzMURR9GVED2A2rmgsREggv4J
         Fmurr1/B411tMg+wb73I1SST0X0Yb53wHb3r1UqLbWWaYpKfdjgt3MTqOqpfsmEq0cxr
         r6YbonG9IzMSvjeFHweK5oX6yzjLZEyN1GHkL2Z25XPqudWFmXYF9BjoGHRSzFNH9z74
         LvkOgKu0vEOl9kmZqzh6B36JMPLuQuueV5qcqSxabMGooLc4Jp7N9VoaDfDwRrhAxZ/R
         h6lUrErYawTyqR+zlxjm6Xtimxu8mftIxDmNRVnozLealsgRRxcQKUEa/cE85irWFoUt
         z3Yg==
X-Gm-Message-State: AC+VfDzSk1CKhBggkdOghF+krANwMUrJgkIdn65n1zmhHod6NwbY0nST
        h6YVCioHA55nE3DLyzdBcU7Yxw==
X-Google-Smtp-Source: ACHHUZ4CY/suwusuVWwIE87HUXkOkuSg/a1kVHwJ9Ov3EQI9ZE1tPyqLKwnRzZ6C5oOunra4MGmpRQ==
X-Received: by 2002:a05:6512:310b:b0:4f8:66da:228a with SMTP id n11-20020a056512310b00b004f866da228amr6856659lfb.4.1687414571068;
        Wed, 21 Jun 2023 23:16:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h25-20020a1ccc19000000b003f42158288dsm17838993wmb.20.2023.06.21.23.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 23:16:10 -0700 (PDT)
Message-ID: <50f75267-492f-d36b-f977-da2fb3a3fd1f@linaro.org>
Date:   Thu, 22 Jun 2023 08:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] dt-bindings: timer: add Ralink SoCs timer
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org
References: <20230620100231.1412582-1-sergio.paracuellos@gmail.com>
 <168739869603.42044.12383139966264039986.robh@kernel.org>
 <CAMhs-H_fUSnXHgO0ZXuGOX7gkuM98HXm+Y_jq1DxCv5Az=3Rag@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H_fUSnXHgO0ZXuGOX7gkuM98HXm+Y_jq1DxCv5Az=3Rag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 07:14, Sergio Paracuellos wrote:
> On Thu, Jun 22, 2023 at 3:51 AM Rob Herring <robh@kernel.org> wrote:
>>
>>
>> On Tue, 20 Jun 2023 12:02:31 +0200, Sergio Paracuellos wrote:
>>> Add YAML documentation for the timer which is present on Ralink SoCs.
>>>
>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Remove redundant 'documentation' word from subject.
>>> - Drop clock-names property.
>>>
>>>  .../bindings/timer/ralink,rt2880-timer.yaml   | 44 +++++++++++++++++++
>>>  1 file changed, 44 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
>>>
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
> 
> Thanks! Which tree is this supposed to go through?

Preferably clocksource/clockevents/timer drivers tree/

Best regards,
Krzysztof

