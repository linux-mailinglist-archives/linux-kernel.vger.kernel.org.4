Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB80B5F5867
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJEQfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJEQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:35:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F05F015
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:35:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bp15so12857075lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ArbnXthF17aFuK2Rgr6+egy+HB4WLw6ceMUfORh6l5Y=;
        b=XvUHOrQG17fhHnlsoCT7GqSjckTrNFw6Vy+GWnTE4oAEokGaLPenF5tQfc3fhpUWo1
         qKFIPUF79oULb9lmZeVbm4Ukh3AyWcQkeK7IdEJR0M3pItEwdEyJVjZ6oSVH5OjsulVL
         HZ1HoQL8/yCWzDe5QrL1nFvG8v3C+O8QVE2ePiFpFcWTjGTl2hryRJG8gHO7Cx/+p2RH
         BdP6uRRj759ACtmumxm/aczNsEEz6BxVzoOJZX83Kx4eZtsdgm4Ujl1CGN2EVOy2KlhY
         rE/TdxZOHna+0XZkJVRv8dIUKwVvCE5nWCtP6xJH2EdC4wK1DJo3WrZuooZC83oKx6b6
         NLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ArbnXthF17aFuK2Rgr6+egy+HB4WLw6ceMUfORh6l5Y=;
        b=ziAhysTYgnhmlWBn+vVH801ekFsrAadaiflfzAd+yIAl/JxcbFE64h7/sQ4ZX2XCbk
         UPOoM8u4tyeE/qcLhdoSxK26DXjwRoVRyQs3o3BhXvTHheYA4AXJc4dx9cLuftye6v72
         ehDsmkXeb7nyqBPLTtd5uvMqNe4+CyaN3mXJn/zJTnLPrE0EIBpEIvdxKEo963MjXbB4
         ZVyPKttvhJSaIg6rWP0yDf3pRic2ljrTOJzKMevG8dAIleVGYOteJXGHFTKmpuyHhtl1
         VbmHDjvAoveQ6I7crWXF+Ru+Gw1wUN++i0n/yzgV0uBHTjK1R1X3H6V+8q5qn4hdc7pW
         LQ2Q==
X-Gm-Message-State: ACrzQf1OWx//XqnsV4jivhuFYIV5uX/9Wz0v5jC6Vd9qCRzpOUnuF8Be
        f324QQR5Ews0tDjjUYhy7I9/pw==
X-Google-Smtp-Source: AMsMyM5LjKt7QvMVK5nxucMwvVVKZDMB0Zf8Ee6Jfz1lQgOYAmg2F5JK8113gHKmDPb4++HQwSS93g==
X-Received: by 2002:ac2:4f03:0:b0:495:ec98:bcac with SMTP id k3-20020ac24f03000000b00495ec98bcacmr224149lfr.339.1664987743632;
        Wed, 05 Oct 2022 09:35:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o20-20020a056512231400b0048a9b197863sm2391823lfu.235.2022.10.05.09.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:35:43 -0700 (PDT)
Message-ID: <4e5c0d90-d1ec-15ca-c07a-d43f52d4d69a@linaro.org>
Date:   Wed, 5 Oct 2022 18:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] dt-bindings: mfd: mt6370: fix the interrupt order of
 the charger in the example
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        matthias.bgg@gmail.com, sre@kernel.org, chiaen_wu@richtek.com,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <9dda705a8d67826306f6c6129722d3ad8edc96fc.1664816175.git.chiaen_wu@richtek.com>
 <CAL_Jsq+YeZRizJFYuU7RPTcFRe1cDjLgsTidisJ_P5PNC4eKiw@mail.gmail.com>
 <CABtFH5Ld91S65RiDu4iSpFhAMiFWaQdj-yDRM79=WUkArpA0JA@mail.gmail.com>
 <9004b427-66b7-f783-9258-4f6b893899ef@linaro.org>
 <CABtFH5LLxjaWHFLRGjVb9x1a_SJoHzD_GsOqn-e9uQAJ6mOocg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABtFH5LLxjaWHFLRGjVb9x1a_SJoHzD_GsOqn-e9uQAJ6mOocg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 10:59, ChiaEn Wu wrote:
> On Wed, Oct 5, 2022 at 4:33 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
> ...
>>
>> Eh, my patch was merged in July... and yours from September still does
>> not use updated multi-led bindings. Was it even tested before sending?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> 
> I must apologize for checking our patches are based on v5.19 (I also
> forgot to apply your patch before checking patches......), not the
> v6.0-rc series at that time.
> I will update the latest code and check my patch again and again
> before submitting the patch next time.
> I'm very sorry for this mistake.......

Always base your patches on one of: latest mainline kernel, latest
maintainer's tree or recent linux-next.

Best regards,
Krzysztof

