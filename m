Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9621A6DE1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDKRH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDKRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:07:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF746198
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:07:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q23so12688457ejz.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681232842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdfzJIKkFxIWGY1rkF0F0muLgVM5DAQIuMkjMd6tTQw=;
        b=HSvS5GsLxSDwYhUMkn8c5rNLPwwT8unZWVQGHgnG0LcXiufU5iO5BySuWj7sVjuP/9
         8kyBwgbW36zuTom5JtFLIHG8Yn2PLYphgV8BD1RbEQsD2+wewb8EHqEamtsSBEjx/smJ
         zLgsllKhpG6UEYfW50c86I7PIrhW4qG0qX0E4J3Q9+ttfxfsNLZpqEvACeS753WDd06E
         X/IxFfINba8DTpM8hNRzfVGiTy28UkOg16gY9paSub5NGBnaV7eYb8k4T2ZtzCV5g/d5
         o1EdlCGkceESd7bfe9OrKSBPHYZ9a/DTfoRGhcfw2gZito5pMR+xxPNw7XDLrdnNoivS
         X1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdfzJIKkFxIWGY1rkF0F0muLgVM5DAQIuMkjMd6tTQw=;
        b=ad6msv5f7yYk2mdnBlC/oyORz7heGT4LwHbtmOLu9jT/38zLS/wwugii2DeVS7gVMi
         L4WpUjFlUe1r5GK86xPQuyuAPI6ZYIb6XqDOdc1gfvSfvf7fAijTLkMd2UKxikCwaTkb
         IX61X2eoZFoSf88nckFVvhZWkbZGXHHQ9arDO7M1PCMGa2NUZ/IAPHgp67MsYLrkBZEQ
         6RKXzni1/ed4B4C2eRzcEEwmTcqpZ8/oULTI23CF8loonFp/eIglo3nQ6/SktOl7kpAi
         zg9Rh3i+SxtTH5ZaoXaUqAQCtj08qE4WcyLjrzK5L7K0l7uWu38dYyHkr8ym4etjun06
         seoQ==
X-Gm-Message-State: AAQBX9esCfspzCeCKvGVlgWsM0328JdxGy/f9pmCJ/t1pHGoh6oeikI/
        dwkjoDYvUMjUZZU+ZgpKenC0MA==
X-Google-Smtp-Source: AKy350YUHA8noLFxB77M1WrwMp3h3S22CgVFDg9e5wFnchjY210tZ+OCaYJzVNhF67XiuxFuudOouA==
X-Received: by 2002:a17:906:2a48:b0:933:4d37:82b2 with SMTP id k8-20020a1709062a4800b009334d3782b2mr10790107eje.57.1681232842328;
        Tue, 11 Apr 2023 10:07:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f1da:c117:3657:c8a? ([2a02:810d:15c0:828:f1da:c117:3657:c8a])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090657ca00b0094a64f6b78fsm2902162ejr.20.2023.04.11.10.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:07:21 -0700 (PDT)
Message-ID: <b7c9ac38-6f9b-8d05-39c6-fee9058209a9@linaro.org>
Date:   Tue, 11 Apr 2023 19:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 05/10] arm64: dts: qcom: sc8280xp: remove superfluous
 "input-enable"
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
 <20230407175807.124394-5-krzysztof.kozlowski@linaro.org>
 <ZDVq1b0TjXH5LTYx@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZDVq1b0TjXH5LTYx@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 16:12, Johan Hovold wrote:
> On Fri, Apr 07, 2023 at 07:58:02PM +0200, Krzysztof Kozlowski wrote:
>> Pin configuration property "input-enable" was used with the intention to
>> disable the output, but this is done by default by Linux drivers.  Since
>> patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
>> input-enable") the property is not accepted anymore.
> 
> This description does not seem to match the pin configurations that you
> are changing below which use the "qcom,sc8280xp-lpass-lpi-pinctrl"
> binding for which 'input-enable' is still accepted AFAICT.
> 
> Perhaps you can fix up the lpass bindings (and driver?) to match?

Thanks for spotting this. This change is wrong.

Best regards,
Krzysztof

