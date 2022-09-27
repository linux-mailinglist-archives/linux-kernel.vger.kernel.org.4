Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BCA5EC693
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiI0Oh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiI0Ogt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:36:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BEC72B4C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:34:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a8so15980859lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=acCfIXSEg+p9BRvSasg6n7vxaIKD1v6nwDt9haJjID4=;
        b=QgEOT9R7HvQuURmKpD32ePt8X/quN8Mgms7zIlqxXEcuZleC+WkiU6rnIAE+VOmA7p
         AKzoefSiS+qwHB+RuNgQ0M3GmuolLohQFherQZ0AQBC3yixvLnOdC33YVzDDv9X7r8tK
         aYLCscnoOlTGquASwxHmHpWsb0NAu+HbL/EVJBFbYptd9RwN96a9gdrHM1l4gRagQz3L
         NG6fprtn5K+fQNxStOR2eiPqSzmPinMtwXA67Js/hpFtHVyh9fqsrOBNFU2kA9rJXK0g
         /+VD+gSvlzp0OWaSUeHR9geB86zWpfjOqV9sp3iZlclo9CD0jNWyFHdPPS2N2ys74vsh
         Qk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=acCfIXSEg+p9BRvSasg6n7vxaIKD1v6nwDt9haJjID4=;
        b=ynXb1aZheXPS7/fahPkQD02YECFS+Czw0xO977kzzTKNL7ZRyONr+BkIHnKo0JorXb
         1o5FMeDusI11ye+nPxR3CHFFGItwKGvFstmAVE8/kSaJLeLtcgTXi0tIkoPI6MFdQ/oF
         5riAxRMz0IvXeMyeTFoQbUl+43ZUcfl0dKVsELprqFK6eLSYIPkW2BgU4kYaKmeA9faL
         zWOCc6/YbewRgW9y8o8P2jITpGq4ZVKVNS+9I/9DDpWR0Mxam5h6pVaGsmn2kHDKEpQb
         Zcud91Q6WaxUlStKEuieAkcWLi/1L6b+yiV+JZNYjhLRKkIacY1wC/vtoW4JIvNR69zK
         hcaA==
X-Gm-Message-State: ACrzQf0nah8S1zJyiFjXysNytMr0xT/SfsXZobHqyGevkcJrwAHxtMP7
        i1NxM1zFSEwEvHdyLVENCS1YxA==
X-Google-Smtp-Source: AMsMyM5HF32G8zBKxBDSRk0Co6DuTb44eQb2XOpoqNIlWhBA00YGIY7V1/dw12NficsJu7DCThiLCg==
X-Received: by 2002:a19:654d:0:b0:49f:5309:1cb6 with SMTP id c13-20020a19654d000000b0049f53091cb6mr10928341lfj.522.1664289247824;
        Tue, 27 Sep 2022 07:34:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be43-20020a056512252b00b00498ee99a749sm176228lfb.304.2022.09.27.07.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:33:56 -0700 (PDT)
Message-ID: <e7697876-f2bc-b0ef-c8bc-6737d8a54551@linaro.org>
Date:   Tue, 27 Sep 2022 16:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 01/33] arm64: dts: qcom: ipq6018-cp01-c1: correct
 blspi1 pins
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
 <20220926074415.53100-2-krzysztof.kozlowski@linaro.org>
 <647d12dd-9bc6-ebe3-7a72-9b9c0d4610dd@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <647d12dd-9bc6-ebe3-7a72-9b9c0d4610dd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 16:01, Robert Marko wrote:
> 
> On 26. 09. 2022. 09:43, Krzysztof Kozlowski wrote:
>> When BLSPI1 (originally SPI0, later renamed in commit f82c48d46852
>> ("arm64: dts: qcom: ipq6018: correct QUP peripheral labels")) was added,
>> the device node lacked respective pin configuration assignment.   It
>> used also blsp0_spi function but that was probably the same mistake as
>> naming it SPI0.
> 
> Hi,
> 
> Sorry for making it confusing, but "blsp0_spi" is the correct function.
> Pinctrl driver and datasheets call functions blsp0-blps5, but usually in DT
> we call the nodes blsp1-blsp6.
> 
> It would probably be better for me to rename the nodes to blsp0-5 instead.

OK, so instead I will add blsp0_spi to the bindings.

Best regards,
Krzysztof

