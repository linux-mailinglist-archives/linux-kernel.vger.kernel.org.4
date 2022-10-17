Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA930601B69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJQVoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJQVo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:44:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D7A8052A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:38:10 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a24so8593786qto.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmBtQkpZL1ZyXNynloFB66YiMCVWHSl2tHXuTV/q/48=;
        b=oxkGSUyFpNdlwjcIGDuiex6N8kAdmKI3heOoor9CqmRM/LVqO/g643mCYsr0kJ7i/T
         MiHcQ0QlruRR9hWeOw64xs6OZRIT+otmgoTjbApOEdoNuItSwu7NGt5VNuhvZWaFUx6Q
         a4S9XEkLKZCCZOuv9xldUI0+/qi/Umr2RGs/HXdm7Ss1zjoUE4/HidOX5Gc7QY2Nttpk
         ucultbe8A02vywIiqjVRPgrzdrhESjvLnERnTXST8L0ll7p/5jEIKrS5Q762VQY5fcMK
         JWf2pOoHchQPZxZAkbWbH9Zn3Jfuj9B+iGW6ypb8xYTVe4lSfUPAek/jw0F0nHRB+vhT
         cLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmBtQkpZL1ZyXNynloFB66YiMCVWHSl2tHXuTV/q/48=;
        b=nvmgw9F+I/8voHLTiRGPq4tviuZeHlf1AgTjzCF0vIN5uQlmqqF7W6Bte8I8BfhtNz
         v8Q+UANunhtf+YR11sNl/0nLfB68Mvp1X0GI+ID2VHLpA2XPjgKXgdglYukZ9L433nA0
         B7qaYMY0g9zdgkfpPdF3IFQzFA8fvWqpfqL5YsS2bXDPAoUD2EUpu8QtwMgGpoXTLLcm
         D8MZsa0EPw9eInaPXtH3o+DhHfDft8PM5tsFaE2kxPazBjNAxkRANzHiF67hoL7NBgYk
         dSDTXryxGWQh57+i7FW2Yn21TTA/b5dDSIanaGJiN87/tAPbuSy39Xh1ghEzrLzt9lhc
         6PbQ==
X-Gm-Message-State: ACrzQf1+MrghZBf2KvwmXe3Uylt6n3aSGcDe2sTe9J8BChbepQ+2+U3/
        Y6xWsVFa6d+6CgzFzndK0c7ulw==
X-Google-Smtp-Source: AMsMyM4o8q1eVeUbEESXsCu714aA/qZ8nq3N38eug1cql8CTVsbRHplNcIcv64V81tEcts8rU0QchQ==
X-Received: by 2002:a05:622a:138e:b0:39c:e87e:3d07 with SMTP id o14-20020a05622a138e00b0039ce87e3d07mr6874752qtk.624.1666042689276;
        Mon, 17 Oct 2022 14:38:09 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a2a0e00b006cbc00db595sm785051qkp.23.2022.10.17.14.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:38:08 -0700 (PDT)
Message-ID: <f61be2e8-32f6-7759-1069-e03a70b4f849@linaro.org>
Date:   Mon, 17 Oct 2022 17:38:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: convert
 qcom,mdm9615-pinctrl.txt to dt-schema
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v2-1-639fe67a04be@linaro.org>
 <CACRpkdbaZRNV56+x=gnN7kKnesaf03hN4nr35qjT9eV=_dKkew@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdbaZRNV56+x=gnN7kKnesaf03hN4nr35qjT9eV=_dKkew@mail.gmail.com>
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

On 17/10/2022 06:41, Linus Walleij wrote:
> On Mon, Oct 17, 2022 at 12:23 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> 
>> Convert the MDM9515 pinctrl bindings to dt-schema.
>> Keep the parsing of pin configuration subnodes consistent with other Qualcomm
>> schemas (children named with '-state' suffix, optional children with '-pins').
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Could Krzysztof include this with the rest of his massive DTS and schema
> cleanups and just pass me a pull request with all the qcom stuff in?

I'll do that.

Best regards,
Krzysztof

